Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB083EA78F
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhHLPam (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhHLPak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Aug 2021 11:30:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419FC0613D9
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 08:30:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r32-20020a25ac60000000b00593ff08c28aso2312125ybd.5
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ps9dtDx12941A9SQUJ+R+y8TpeyDNU6PScAxGT8aLeY=;
        b=Pa5YlGdocqVh4d0WXzK8p83jRRi1hUFSP0z6YRA3+wgnOyMl4YpQKdQ/SgA3VnF2IB
         YvkT0nhoZaqWRHaWGHz2aMjB1jK9xG+tllN88nohYh92lZcqmFpOSmNIHc4iW6qXasS6
         hQgGEDcxLFIIXYXl8390H6SXrsRIBhTEQQi57PAH0+SH7ryXMUJJD9m2DT9TU6s67iG+
         2hGRih958f2HURg6/U7yJjlbo89ei0VJdmI3CKt8vyJz5uRF7byGX+Gbd/8Fv+P5yxTG
         duUrqqzaH/gcYxRm/I599FdIwycVw1iqks3ZiD5tUqvvwOXCGyt6wk1kEjZBm0JG8tys
         aOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ps9dtDx12941A9SQUJ+R+y8TpeyDNU6PScAxGT8aLeY=;
        b=RRX5oKB2sB3rMJmsxcMP6Wttt1Kinz2TcIIZeZ5cg7cXJfp5gWG5pX9gmxJtQsvwlg
         kpHWUi1yghCL2k/YbsBhf0RsYnshhRtMNsf4850kvpgduqqTQp5wKwBTXxqwDvaXRIN4
         /SR169eQOOI4Av7Zvn57DFWwyL5ObkTPJg0YWTciVNjS4HuWlx72unamuErMZZzTq+VL
         nDALt8c8TDewBxlq4MEbK5UBvG5kSwtnt4JGvmZwHRZQPavtOSnzZYnmTuyJA1QktFAQ
         ukAn44u1WLG8ISmHGiMfGVm2pn6yX9HuUiXYoPkZolkFJxQdW2Jlg/Nf1MSJYRtJTC23
         Yc2w==
X-Gm-Message-State: AOAM531iUWrC4GuXJFMHHt2iConM2f068xmTB6xhykiq/OxAwKKOGnt4
        hzvKqaJ2YsHyHtsFgdx6/Zx+CYk=
X-Google-Smtp-Source: ABdhPJyRfJgmI/klNckeumJ0NsjGjWad5oVhl5JDZVcLbW06bVXxq/+tlp3bKsW9kI4dpYEtWSq8GJQ=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:fa15:8621:e6d2:7ad4])
 (user=sdf job=sendgmr) by 2002:a25:2489:: with SMTP id k131mr2717779ybk.103.1628782214123;
 Thu, 12 Aug 2021 08:30:14 -0700 (PDT)
Date:   Thu, 12 Aug 2021 08:30:09 -0700
Message-Id: <20210812153011.983006-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next v2 0/2] bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We'd like to be able to identify netns from setsockopt hooks
to be able to do the enforcement of some options only in the
"initial" netns (to give users the ability to create clear/isolated
sandboxes if needed without any enforcement by doing unshare(net)).

v2:
- add missing CONFIG_NET

Stanislav Fomichev (2):
  bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
  selftests/bpf: verify bpf_get_netns_cookie in
    BPF_PROG_TYPE_CGROUP_SOCKOPT

 kernel/bpf/cgroup.c                        | 19 ++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c | 25 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

