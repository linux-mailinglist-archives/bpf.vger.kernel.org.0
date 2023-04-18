Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED96E6FAC
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDRWxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRWxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94982D42
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l124-20020a252582000000b00b8f5572bcdaso14702810ybl.13
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858425; x=1684450425;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLgjrTkyEcYnS83pUlw9/gvrZRFajaENng+qitn7bWQ=;
        b=bjFoWOlLvlFQfGfutJCa3viVf+3z22EoXY5mTBKJB9nd8RGgcKkro+g80kHakq2rr9
         bFkJjakgk91ifgRBX1O2uWhNhAzm3DPGDZ79sTJwP8GZFRKyUOpPhqzPu7mJ6CforOdL
         kkIMU7OgXihxVausWJhpA/Cy4LNkGUFPij96vYs7jLeca/ryxHNg2A/zLEeqbL0pLsc8
         jJFPLjWpzrRQj4pwY0OSgp/9+1v3es/3VOrIj7ayacoN8TuyicPgRDYs1g7mnPBHhhTV
         ds4/aVTJg0v7SF21N78FUMZZzPP6UogxQ+Gf6CPRBoP9aWXsJxpQvHQsz4M6rGiq5HEX
         HaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858425; x=1684450425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLgjrTkyEcYnS83pUlw9/gvrZRFajaENng+qitn7bWQ=;
        b=ghrFiAAYG1ryjwUfwxGYBb17uYIS7gNNOBbXBafpEDAK5P/bEpOQRzF9/MQ3efTTtk
         C6MlrmwXNMytQMIRug+b/L/m3Ya3Mm17OPyf8NVDsH/U8EwoybtJftP+nqnc6nl1TONn
         BUZrrTXo6Cr9EqqKRitheod4EDUdPXd8npB1Gg0+n+4qrwHQrwBWK58glHBz3IQqeWTh
         /LJaEiIYKbxvJ3TtrJnO+wd3FNGhcLHJ3RbXJRien9L8jVpvjU1xLrojd8EJe5+5v0fM
         qWm4Nk+WttdeP3TK5Xw4RRqG6tgF59Mkw622TDg+r9TfsCbvIo4BkYYYwtagLOFVIADl
         0O+w==
X-Gm-Message-State: AAQBX9fzbO3TUsTgbOVeDe+3zbhB9hco50/XdUe8OpZDN3y+mPj5AZ7k
        ukRMHUEuGPZ0Cze5+u9+JrZPSVRI+rJx8icvQLbIdrX1tEMlz6b1dRI1eibcp4n22YjcRIiSbdL
        WwoAe/0Ru6XilVXivsA8uQILYDuihqGqYOCoLlWwDXB5mWSV93Q==
X-Google-Smtp-Source: AKy350a8Q4is11vH6d/q/0U4inb9uMB+WQop8gzkXge1fJuN87gpEXedDPki+lrln3lVMyo/otaIuWw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:cfce:0:b0:b75:8ac3:d5da with SMTP id
 f197-20020a25cfce000000b00b758ac3d5damr10594157ybg.4.1681858425181; Tue, 18
 Apr 2023 15:53:45 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:37 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-1-sdf@google.com>
Subject: [PATCH bpf-next 0/6] bpf: handle another corner case in getsockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin reports another case where getsockopt EFAULTs perfectly
valid callers. Let's fix it and also replace EFAULT with
pr_info_ratelimited. That should hopefully make this place
less error prone.

First 2 patches fix the issue with NETLINK_LIST_MEMBERSHIPS and
test it.

Second 2 patches replace EFAULT with pr_inro_limited and update
the tests.

The remaining patches update documentation and existing selftests
to be more gentle with 'optlen > 4096' cases. People might be
copy-pasting from there, so let's be more pedantic.

Cc: Martin KaFai Lau <martin.lau@kernel.org>

Stanislav Fomichev (6):
  bpf: Don't EFAULT for getsockopt with optval=NULL
  selftests/bpf: Verify optval=NULL case
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     | 64 +++++++++++++++++--
 kernel/bpf/cgroup.c                           | 17 +++--
 .../selftests/bpf/prog_tests/sockopt.c        | 42 ++++--------
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 28 ++++++++
 .../progs/cgroup_getset_retval_getsockopt.c   | 12 ++++
 .../progs/cgroup_getset_retval_setsockopt.c   | 16 +++++
 .../selftests/bpf/progs/sockopt_inherit.c     | 16 ++++-
 .../selftests/bpf/progs/sockopt_multi.c       | 24 ++++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  8 ++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 33 ++++++++--
 10 files changed, 211 insertions(+), 49 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

