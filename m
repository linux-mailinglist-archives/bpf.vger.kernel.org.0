Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0D2B72F0
	for <lists+bpf@lfdr.de>; Wed, 18 Nov 2020 01:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKRARp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 19:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKRARo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 19:17:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1AC0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 16:17:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m186so8082ybm.22
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KSzntMlQutgORfFcLQlCCoRzBQW8Wn75jurvpaJoF8E=;
        b=Rm+nB6H2KrMsrAYrIv1Yg2A06B3tgtEHgKHUzMvuyI+kLnMZMsu9QHqGc3XFv8WgJY
         58ZX6vEaYkGLbxljUUcXKyV7MfsHqHFYhOW63JjMi1l4W4RGB5Lfjf9jYnwcsTeCSAL9
         lgGJlHKKt6nMH7XNwQ4C6h41KC1C9A/ueuaEvu9IMN67oA8iKpF7NWMKlfHB2T16k43E
         neINuSczClnUb7Zm0OBzQesPUbJO9lAcktccRDEAKE0NS6l1f7P4ccUMV1eXqsvnTTYd
         eC22NGtQALgiiUksx2qaA6A/p0ASaaB1mSHwDhBErlGevq6lq+/ylB04drLQEmFT6047
         SvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KSzntMlQutgORfFcLQlCCoRzBQW8Wn75jurvpaJoF8E=;
        b=jrBoioz4PxYBzFH6ul4Rk/Ruig0Ys5RqjYVm77HjExfmxOsTP8rsW89bdBC9dA0vfq
         aKC+Ky2/YV8yrzYxeTCHk5z8m+nvjHQiK5m11so0Y7vXdIM9TXMy6uuafmJPIQI/bUtP
         tl9ROhb2F4yRNNrKVgPiRkU7PQoH3eG9FvW7CkwV2nfQ/KHal0g6QBcKLGlh5BPpmJww
         7SSiQIyIJxg/y4eXLiKa4lNnQodskJTG+vLkOSV+Ak4+gDafwk3RRJ62EWiGDh9dDtVb
         Qo/P6LespGDXoNwY9tiL4sdJbEemAIExt5268ACeNcsOjKC1PcmmdjV0WuMCM+USURSZ
         oi0w==
X-Gm-Message-State: AOAM532ytDM1zs9jLvmekW377Mux/u86QdoeZLsd9svGE40WRVDe41Ce
        m1PdRq6KWzgb7SlCSyGkpZB4DUE=
X-Google-Smtp-Source: ABdhPJw4kRiwpjmqN9x2bFVjJhPOCp5kFZFnwAYaQT7Ly2H4YvEb+aTyLkBaH0FZuaaOtqs6Y0wP2uk=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a5b:10:: with SMTP id a16mr3748622ybp.242.1605658664033;
 Tue, 17 Nov 2020 16:17:44 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:17:39 -0800
Message-Id: <20201118001742.85005-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH bpf-next 0/3] bpf: expose bpf_{s,g}etsockopt helpers to
 bind{4,6} hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This might be useful for the listener sockets to pre-populate
some options. Since those helpers require locked sockets,
I'm changing bind hooks to lock/unlock the sockets. This
should not cause any performance overhead because at this
point there shouldn't be any socket lock contention and the
locking/unlocking should be cheap.

Also, as part of the series, I convert test_sock_addr bpf
assembly into C (and preserve the narrow load tests) to
make it easier to extend with th bpf_setsockopt later on.

Stanislav Fomichev (3):
  selftests/bpf: rewrite test_sock_addr bind bpf into C
  bpf: allow bpf_{s,g}etsockopt from cgroup bind{4,6} hooks
  selftests/bpf: extend bind{4,6} programs with a call to bpf_setsockopt

 include/linux/bpf-cgroup.h                    |  12 +-
 net/core/filter.c                             |   4 +
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv6/af_inet6.c                           |   2 +-
 .../testing/selftests/bpf/progs/bind4_prog.c  | 104 ++++++++++
 .../testing/selftests/bpf/progs/bind6_prog.c  | 121 +++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 196 ++----------------
 7 files changed, 249 insertions(+), 192 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/bind6_prog.c

-- 
2.29.2.299.gdc1121823c-goog

