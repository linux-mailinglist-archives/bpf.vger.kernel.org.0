Return-Path: <bpf+bounces-451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75F700F16
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EBB281C50
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161023D5C;
	Fri, 12 May 2023 18:55:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422E23D53
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 18:55:34 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B31FD6
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:55:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso11641615e87.0
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683917731; x=1686509731;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7NrNru9lpjoNxruPbGkDK8FxzylhHXXgW3ILVaHk1k=;
        b=q1pLr68RT/5j1E3zgjYF9dGjooARl/aZtCca8it5qxQSJg3p8ZK+UY9e5Xx9drnqwe
         5ZBULTY0XvGjWnkubPLCzG+Hb8c63wDCnBMuYTYJwgoHhgWkpvr0aHAuBnRkvWKX0AgZ
         b6cE/GDOMeAQJIaxDc4GLw1uHeEi6Cwv70TYvbZCdOBo7JddRAB1kFgF4p/c0Z7R6sGp
         MO0IAyTKbFRA2iWRHCsJO4BbYK5KO8GcaZGmhrHH3zJK4zYbfB7Q4sZY99bivE86bBq1
         ZVcunf2B1kkAMCP8mOkvNVXeIRU7gm9xrYdcMqX51NkPpYOOXEVKjc0x1cFOuowAhiHv
         LVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683917731; x=1686509731;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7NrNru9lpjoNxruPbGkDK8FxzylhHXXgW3ILVaHk1k=;
        b=FiFWM548iLQkBK59qBnXrrWnLZxssEyeBMywjF8aGzCpSzybXmIPYLuOWSaWaDQwsQ
         dWTro9MulzPEFzMfRkKBdhukQTuILfZTYinQtSYtLQH0lAFOBTW1n9GFwp+vOEE8IBf2
         olXBHkzeMHJVjclNNd9eIfrm9jU6FM+dZQXdNJt6zKfh9VE/TWpJ3sIn718Iq7AcA5eX
         XI32+PhO7By3f4P+mzcYtTPgQBLT7XyvsGsOPppcPlOqffSbhBI9pEUNJPgH1Yi/9M6W
         ZQ7lrEEBqcsdsrQHPT8Y/8t5anOIhKJqm6BNpN6KkyKLUloucD2FvGjcO8RoMUa4u8vh
         0j/Q==
X-Gm-Message-State: AC+VfDyy22Vod8isXfH7wTdgC5cN7tMEAsYgpT55BJEatAt2len/uC4g
	Xan0lWDeD23Bmnprp3qvMTpdNB98II/+r5ucwyhEzaMoWQ9M/w==
X-Google-Smtp-Source: ACHHUZ6Th5G2ff2cnncaP6NrN3Y5uj3fAk8lqXAcowCT2rLIWfZz/DzAU3eVYbXksj7v2AyZ6nNpxReSu0DWQ6mG7+k=
X-Received: by 2002:ac2:46ee:0:b0:4f1:5001:1d9c with SMTP id
 q14-20020ac246ee000000b004f150011d9cmr4453588lfo.55.1683917730790; Fri, 12
 May 2023 11:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 May 2023 11:55:19 -0700
Message-ID: <CAADnVQKs-0C_VLBZi9F68WgoNeDy_UOJ2QY5O+xcPr1u3sX8+w@mail.gmail.com>
Subject: verifier backtracking bug
To: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii,

Here is what I see on the latest bpf-next:

 ./test_progs -t global_funcs
[    7.969549] bpf_testmod: loading out-of-tree module taints kernel.
[    7.979444] ------------[ cut here ]------------
[    7.979812] verifier backtracking bug
[    7.979828] WARNING: CPU: 1 PID: 2026 at kernel/bpf/verifier.c:3500
__mark_chain_precision+0xd8d/0xda0
[    7.980818] Modules linked in: bpf_testmod(O)
[    7.981161] CPU: 1 PID: 2026 Comm: test_progs Tainted: G
O       6.3.0-07968-g7b99f75942da #4614
[    7.981876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    7.982732] RIP: 0010:__mark_chain_precision+0xd8d/0xda0
[    7.983140] Code: ff e9 fb f4 ff ff 80 3d e2 c5 50 02 00 0f 85 15
fd ff ff 48 c7 c7 fe 5b 5c 82 4c 89 0c 24 c6 05 ca c5 50 02 01 e8 b3
ed e8 ff <0f> 0b 4c 8b 0c 24 e9 f3 fc ff ff 0f4
[    7.984523] RSP: 0018:ffffc90002bb78f0 EFLAGS: 00010282
[    7.984918] RAX: 0000000000000019 RBX: ffff88810137c000 RCX: 0000000000000002
[    7.985467] RDX: 0000000080000002 RSI: ffffffff825bda2c RDI: 00000000ffffffff
[    7.986011] RBP: 00000000ffffffff R08: 0000000000000000 R09: c0000000fffeffff
[    7.986553] R10: 0000000000000001 R11: ffffc90002bb77a8 R12: 000000000000001b
[    7.987093] R13: 0000000000000002 R14: 0000000000000010 R15: 000000000000001c
[    7.987641] FS:  00007f7bd27d7400(0000) GS:ffff888237a40000(0000)
knlGS:0000000000000000
[    7.988254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.988687] CR2: 000000000511e078 CR3: 000000010512f005 CR4: 00000000003706e0
[    7.989228] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.989765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.990306] Call Trace:
[    7.990500]  <TASK>
[    7.990668]  ? check_helper_mem_access+0xf9/0x2a0
[    7.991035]  ? btf_type_name+0x20/0x20
[    7.991329]  ? find_kfunc_desc_btf.part.106+0x210/0x210
[    7.991723]  check_stack_write_fixed_off+0x437/0x610
[    7.992113]  ? lock_acquire+0x15c/0x290
[    7.992416]  ? adjust_reg_min_max_vals+0xdf/0x1070
[    7.992778]  ? __kmem_cache_alloc_node+0x41/0x530
[    7.993140]  ? check_ptr_alignment+0x7d/0x210
[    7.993479]  ? lock_release+0x1b7/0x250
[    7.993774]  check_mem_access+0x8fc/0x1750

Looks like my earlier suggestion to do:
WARN_ONCE(idx + 1 != subseq_idx, "verifier backtracking bug");

is tripping on something.

