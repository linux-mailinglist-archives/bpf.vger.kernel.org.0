Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3258A73A
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiHEHhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiHEHhT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 03:37:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1731A06C
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 00:37:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso2026733pjl.4
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FaDd+LzIj5iLUBrDGb+n83PYJvxLCIFQVAAzY4PoSgk=;
        b=XhBBP6F6NzSSGpBbC3Qr0i4t8FDpstx+oB1ZK17xY0wdAv97sZbC+uFiJPa8BTCUdF
         ijwFAyY8W8/tyzJUfFe5s8LJisc8t9l0bQdhxl0GpDh9w1VvbN043QNaaj6ToJEGHLGn
         oBAr0b0CARjT8inWeVR4DdluMpvyo3QutR03fGDvPeNafYOdUO6lcKgBhpW9oHdBS/dL
         D288zlvGYf/FOUkEAKMMtlgJ36pb27bl1XTlwJ5HAAqnKg8bKpr5+dD7+BV5vhSN+OJW
         lV5l7OakAfDUEIPCPyPN1EibMUQE/WXQqqXgr55znvuFdu8MVivOwqr//W6BrCzV1svr
         98Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FaDd+LzIj5iLUBrDGb+n83PYJvxLCIFQVAAzY4PoSgk=;
        b=ROxmZ2LvmURSunABD1uUaMgpLyxt6nhRWT6PyGg+d6HxZZpGxqQyZ+xlBPlmXUhFRm
         24luhtA+Sl+FktL5O1Pzs1i3SKla4bTXv24eCeew4Tf16L398fuqyCY2ESRBtrxt34fF
         WU66Wsmxjl7d2fjo9HvRxmNE9qdT0m+iw2bk4dU56+fEOHtKzj1TA443O3fDyyX3bCNv
         dxG/X/ki1aWJ8pLKRr9tXAG0H4fqyOorxsuWvnki1HL5cSW4U4fIe8SofU3JtguPltos
         HeKzjDmNhii0/uLAkV/XsF7dcH7qKL756L1fuZs/rzevciTfVKDj6sler4dWZ1FQFpyj
         O8QA==
X-Gm-Message-State: ACgBeo21wmKK7TdMtic9/Wd7jVTwNzgw+uCOUqYE2bbY0EDHTtai7VyL
        JN5WO4XZnl9GFetEF3+A1xs=
X-Google-Smtp-Source: AA6agR6aXUqXhkZ84+pJdqBEbVO0712xP8TGTnR2og+zd4XNEDcabte56LnhHtREQeehcE9x8oJuWA==
X-Received: by 2002:a17:902:f785:b0:16a:4f3b:a20c with SMTP id q5-20020a170902f78500b0016a4f3ba20cmr5629511pln.118.1659685036933;
        Fri, 05 Aug 2022 00:37:16 -0700 (PDT)
Received: from localhost ([117.136.0.155])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a008500b001f559e00473sm3228861pja.43.2022.08.05.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:37:16 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com
Cc:     paskripkin@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        18801353760@163.com, Hawkins Jiawei <yin31149@gmail.com>,
        bpf@vger.kernel.org
Subject: [PATCH net v5 0/2] net: enhancements to sk_user_data field
Date:   Fri,  5 Aug 2022 15:36:48 +0800
Message-Id: <cover.1659676823.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <00000000000026328205e08cdbeb@google.com>
References: <00000000000026328205e08cdbeb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset fixes refcount bug by adding SK_USER_DATA_PSOCK flag bit in
sk_user_data field. The bug cause following info:

WARNING: CPU: 1 PID: 3605 at lib/refcount.c:19 refcount_warn_saturate+0xf4/0x1e0 lib/refcount.c:19
Modules linked in:
CPU: 1 PID: 3605 Comm: syz-executor208 Not tainted 5.18.0-syzkaller-03023-g7e062cda7d90 #0
 <TASK>
 __refcount_add_not_zero include/linux/refcount.h:163 [inline]
 __refcount_inc_not_zero include/linux/refcount.h:227 [inline]
 refcount_inc_not_zero include/linux/refcount.h:245 [inline]
 sk_psock_get+0x3bc/0x410 include/linux/skmsg.h:439
 tls_data_ready+0x6d/0x1b0 net/tls/tls_sw.c:2091
 tcp_data_ready+0x106/0x520 net/ipv4/tcp_input.c:4983
 tcp_data_queue+0x25f2/0x4c90 net/ipv4/tcp_input.c:5057
 tcp_rcv_state_process+0x1774/0x4e80 net/ipv4/tcp_input.c:6659
 tcp_v4_do_rcv+0x339/0x980 net/ipv4/tcp_ipv4.c:1682
 sk_backlog_rcv include/net/sock.h:1061 [inline]
 __release_sock+0x134/0x3b0 net/core/sock.c:2849
 release_sock+0x54/0x1b0 net/core/sock.c:3404
 inet_shutdown+0x1e0/0x430 net/ipv4/af_inet.c:909
 __sys_shutdown_sock net/socket.c:2331 [inline]
 __sys_shutdown_sock net/socket.c:2325 [inline]
 __sys_shutdown+0xf1/0x1b0 net/socket.c:2343
 __do_sys_shutdown net/socket.c:2351 [inline]
 __se_sys_shutdown net/socket.c:2349 [inline]
 __x64_sys_shutdown+0x50/0x70 net/socket.c:2349
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
 </TASK>

To improve code maintainability, this patchset refactors sk_user_data
flags code to be more generic.

Hawkins Jiawei (2):
  net: fix refcount bug in sk_psock_get (2)
  net: refactor bpf_sk_reuseport_detach()

 include/linux/skmsg.h        |  3 +-
 include/net/sock.h           | 68 +++++++++++++++++++++++++-----------
 kernel/bpf/reuseport_array.c |  9 ++---
 net/core/skmsg.c             |  4 ++-
 4 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.25.1

