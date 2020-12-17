Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47872DD5FB
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgLQRYH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 12:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgLQRYH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 12:24:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B924C061794
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 09:23:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so35774803ybs.8
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 09:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jzYMmW6juKzvxHSLq/5hwBc5kF7GCeBG4ufj8Bugw9M=;
        b=RWwQyODvZZM+uyf/toQAhYiCkNTOndjUkABM0xt0Z5R3lQx1W/9RPSdseEAET05Z+t
         BUxSjp5MrU9RLheL6xAm0b/gKYX0Cqx+FMpe2XHxWP1WRJe8S15jKt0p9sEJwp7/A1u2
         cUC6ZdwVIWfnAI56H309uhh0FKzmbqTE7slv3fbvGKexw7oYkom1cIluOtkQtwSChIxr
         ISpvJtvplBaPnM0WiRn7zXFG2ZvbUOLUT2+fKSnBmcrnOf4tY+TqMsIj7B0yB1oA7fv/
         wI3UKYRPPURrM/RdvLqOjjFuMv6LSZRY1btIEqfey1pxJWpPZ5ig6aJUa0FCMP64bylH
         TdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jzYMmW6juKzvxHSLq/5hwBc5kF7GCeBG4ufj8Bugw9M=;
        b=MVEV0+Eq4YuKtEOOMh4cMP3NDs9VdQzyiWWWPvP3W5JvhRiTivAmZi55Drw6tydHw1
         pMXaBlNyxUU8ZWczX3B+9+TziLdQOUds9EqLG0UcFOt1HkIfFAjdXfWVYwqcWVhameMu
         FXwExD6QK1fXmYoQmlX6ECQk5d0La4EKnQ/GBszmBTzM3cC9VCTrsadjG7i91vSajHao
         wH9adEgwdt6xr9EI7IMKOK/waQ6YOz+QXJlPNt6n8EFFVFXnGvVYQ95Rm1FOsZenDd4d
         O1tU52F5K6XdfuvfAYw3O4BpbX8ddv3+GYbRmeKu1eO7nu+JTefB1RY+L1IaP0WOisJy
         d2LA==
X-Gm-Message-State: AOAM533qZDhya+l1J1YKN3mSxd1El3R60e/pzV8/HkUAffDx1b6hrw5y
        BTnsxQNxTzxN8rK3ogToYYENM+0=
X-Google-Smtp-Source: ABdhPJzAiTxJQ0EyXMtBNXBGGGzrVyDi8x2AnhE4f33zXzrHus2TvD8QLRz2VxYZ9rJlc8p8JdM4V0w=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a5b:4d2:: with SMTP id u18mr230847ybp.71.1608225806251;
 Thu, 17 Dec 2020 09:23:26 -0800 (PST)
Date:   Thu, 17 Dec 2020 09:23:22 -0800
Message-Id: <20201217172324.2121488-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH bpf-next 0/2] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch tries to remove kzalloc/kfree from getsockopt for the
common cases.

Second patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

Stanislav Fomichev (2):
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type

 include/linux/bpf-cgroup.h | 36 +++++++++++++------------
 include/linux/filter.h     |  3 +++
 kernel/bpf/cgroup.c        | 55 +++++++++++++++++++++++++++++++-------
 net/ipv4/af_inet.c         |  9 ++++---
 net/ipv4/udp.c             |  7 +++--
 net/ipv6/af_inet6.c        |  9 ++++---
 net/ipv6/udp.c             |  7 +++--
 7 files changed, 83 insertions(+), 43 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

