Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D712117EF4
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfEHRSt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 13:18:49 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:44066 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfEHRSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 13:18:48 -0400
Received: by mail-oi1-f202.google.com with SMTP id z1so631434oic.11
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K1s6dmhSrKNPUUHxfQZADn6Laf34Wzn/5cG+6alvhG8=;
        b=eJIZp41Oh7P2tjT1as/0sEqmmQloCeqrISujwIawv8/t+Wjz5zAKITiUyLsWGffbDZ
         BjhhNYzv7ExRwXfp3JtK/+/9D1bkKqjyYxCCHr3vv6xLn8nbk255+Cud11peLSYwPqTA
         2rKfKuBBXx+oaPKlZaJC5hak/3KG/wTjhKE0ZeP07/WPXxvvkpW63SvZIDGTeydMBHU2
         os87oQp+suYRlpQSkGtFU7+WQ049GHZcNb7lB2x9CPC4isI3Vu0XxdwA6h+81RFO8qXc
         zd6aQHt9oymsbJTvwyJKST7W230tKI1ulKT6a4xuhYJ6zHD1XRkRGKJtY5tuNWR/0R7W
         PSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K1s6dmhSrKNPUUHxfQZADn6Laf34Wzn/5cG+6alvhG8=;
        b=HpDmC91l+82uWz1HAq9bXa4QTw2LDHZXtvg1JQVRLvjShaEDkAlLcnuWXgrcgvlIsT
         /i5yqmYXjOa3+L/1ygIhTCxW8WyOsM3WpsJlb1DG3PXNLUyL2tAVGc1lVHku6bOdhu3F
         qwDsIw9Qml6yeN+8k4pUt7VgPVsMi7ZTkAtJvdixRdllK5vBRV4CvtLlCVfQmmJtqp6O
         VGAOSh1tEriPy8kNjG4u9LIwDxyAVoXOfGW1GbZb0NeNmfazMcE6qEe0wJCeiWNM+5Jv
         190qlWx/vn1xpOfVgGwr/VtcgbPpGEbg3woNihdhjShP9TcpMecAoI/QAJ/VFxiqNWsQ
         EJEg==
X-Gm-Message-State: APjAAAWkmInsUYXaHiklYmFJ0geSPMZZdbQpzihFOKsYdgvpCvHSd+Cd
        a+e3kT6sL/9slCqh6MWOOa0yZxs=
X-Google-Smtp-Source: APXvYqzxvFhfU+/EO8CHQWrgXCJkqwZrFulFFKJD3xGXysyk4lh+X76lUVIVnj3e4JKIDdfyL0GMvxg=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr3038780oif.47.1557335928077;
 Wed, 08 May 2019 10:18:48 -0700 (PDT)
Date:   Wed,  8 May 2019 10:18:41 -0700
Message-Id: <20190508171845.201303-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 0/4] bpf: remove __rcu annotations from bpf_prog_array
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now we are not using rcu api correctly: we pass __rcu pointers
to bpf_prog_array_xyz routines but don't use rcu_dereference on them
(see bpf_prog_array_delete_safe and bpf_prog_array_copy in particular).
Instead of sprinkling rcu_dereferences, let's just get rid of those
__rcu annotations and move rcu handling to a higher level.

It looks like all those routines are called from the rcu update
side and we can use simple rcu_dereference_protected to get a
reference that is valid as long as we hold a mutex (i.e. no other
updater can change the pointer, no need for rcu read section and
there should not be a use-after-free problem).

To be fair, there is currently no issue with the existing approach
since the calls are mutex-protected, pointer values don't change,
__rcu annotations are ignored. But it's still nice to use proper api.

The series fixes the following sparse warnings:

kernel/bpf/core.c:1876:44: warning: incorrect type in initializer (different address spaces)
kernel/bpf/core.c:1876:44:    expected struct bpf_prog_array_item *item
kernel/bpf/core.c:1876:44:    got struct bpf_prog_array_item [noderef] <asn:4> *
kernel/bpf/core.c:1900:26: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1900:26:    expected struct bpf_prog_array_item *existing
kernel/bpf/core.c:1900:26:    got struct bpf_prog_array_item [noderef] <asn:4> *
kernel/bpf/core.c:1934:26: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1934:26:    expected struct bpf_prog_array_item *[assigned] existing
kernel/bpf/core.c:1934:26:    got struct bpf_prog_array_item [noderef] <asn:4> *

Stanislav Fomichev (4):
  bpf: remove __rcu annotations from bpf_prog_array
  bpf: media: properly use bpf_prog_array api
  bpf: cgroup: properly use bpf_prog_array api
  bpf: tracing: properly use bpf_prog_array api

 drivers/media/rc/bpf-lirc.c | 27 +++++++++++++++++----------
 include/linux/bpf-cgroup.h  |  2 +-
 include/linux/bpf.h         | 12 ++++++------
 kernel/bpf/cgroup.c         | 27 +++++++++++++++++----------
 kernel/bpf/core.c           | 31 ++++++++++++-------------------
 kernel/trace/bpf_trace.c    | 18 ++++++++++--------
 6 files changed, 63 insertions(+), 54 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
