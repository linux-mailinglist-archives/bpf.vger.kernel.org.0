Return-Path: <bpf+bounces-15939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCF7FA1FD
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E31C20D25
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763830F95;
	Mon, 27 Nov 2023 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFJifH+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B46E3268;
	Mon, 27 Nov 2023 06:07:19 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db40898721fso3933932276.3;
        Mon, 27 Nov 2023 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701094038; x=1701698838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8oeFhCs7kIEK8abIOdKBsPggO+UU8nmR04lsK3QyLs=;
        b=BFJifH+M3YypRNQI2tSO/osf5/IfaELJVE7grWsnctEzXOZhGSzZrhGa198EXbpZy7
         D4zCD0SV9aIcIx85qQ8mcVl6jxpVvHF8DuxwAQphZ3Buk+e3tohlJ5lohDn9+uSL+YxG
         VNkzqYjxsA3UtiyoVvxQsE0doho4M6wQQIWkp7TCUZKvcuzsj4P0YK7WTgExf5TuVCh4
         NDjbExRvogiElsmQTwdRkc40od1ZYLrzwySVtr9DgdCPsk95EOaJUIw6CGDie7RzZFcW
         QwXnXgbk0gGPiyc1ceuw/3nwoP1MwASz81NEb35ceHWcL/mbq0uveQ31GQKIbKOj8P+V
         tvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094038; x=1701698838;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8oeFhCs7kIEK8abIOdKBsPggO+UU8nmR04lsK3QyLs=;
        b=NWz0CYeGjgrlV2bh2765gp+b2saRb+Tx55hYltiadtxW7oSlLf6HyOKPhIONzSI/BB
         u6k+lB4wVJPpgqIz7PMG6RZU8/akUe87eh6eh5WshtRQ9lCeHz1KKWQ2dfvNasoqJSiZ
         MSxYTN4EDRpRZVMyyAhk1wvXsgJFoe81h8fsOJf6ssMfKBVi2+hGI0RAGkO3+O6pfnGr
         cN48yHkvAMvE98EsFOoyYhnkAiEX4xjcqJfT3BBZuTK1GyxrQAj/PrlEnvyJzEPQMDcE
         vYcKX/3dLz81oVe/77Ldw2o7CbzeaxFtTedsiEze4Qu+23/M4HsyntHjmj0fEMrFybkE
         T2mg==
X-Gm-Message-State: AOJu0Yyj7bHwlelO936DKlXEQkdgqkve3SiR+DFxcnZzMGGiaCGXBlOI
	zUPiTtsWYMU5ZUDJTgslybb7NR85/DLm00BQe9ypZ9GjBw==
X-Google-Smtp-Source: AGHT+IGVZIL/uQ8SCfn15D9a6GMSq6qYaiV2lp0Yk6fvYWVJCeiSK9GCYfnkwschuaDxOJ5Nn/nPv/bRHk7RpB8Es5U=
X-Received: by 2002:a25:25cd:0:b0:da3:b87b:5b75 with SMTP id
 l196-20020a2525cd000000b00da3b87b5b75mr11682722ybl.64.1701094038084; Mon, 27
 Nov 2023 06:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Mon, 27 Nov 2023 15:07:07 +0100
Message-ID: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
Subject: [Bug Report] bpf: zero access_size of stack causes array indix oob in check_stack_range_initialized()
To: Andrei Matei <andreimatei1@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

The following program (reduced) can cause array OOB during verifying time.

What happening is that we pass a stack pointer
fp(smin=smin32=-7,smax=smax32=248), and a size reg whose min value
could be zero, to a helper. In check_mem_size_reg(), we have:

     if (reg->umin_value == 0) {
         err = check_helper_mem_access(env, regno - 1, 0,
                           zero_size_allowed,
                           meta);
         if (err)
             return err;
     }

The stack pointer with smax=248 should be rejected, but it's not
because in check_stack_access_within_bound():

         if (access_size > 0)
             max_off = reg->smax_value + off + access_size - 1;
         else
             max_off = min_off;

The max_off is set to min_off because access_size is zero. In
check_stack_range_initialized(), the slot could be -1 when `i` is 0:
     for (i = min_off; i < max_off + access_size; i++) {
         u8 *stype;

         slot = -i - 1;
         spi = slot / BPF_REG_SIZE;

Andrei, sorry to email you again, but this is introduced in
`01f810ace9ed3`. Should we handle zero access_size correctly in
check_stack_access_within_bound()?

Here are the reduced program, the verifier log after removing the
guilty instruction, and the kernel config I used:

C repro: https://pastebin.com/raw/Dx653LrQ
Verifier log: https://pastebin.com/raw/q19gaMdr
Build config: https://pastebin.com/raw/41uDYmYr

================================================================================
UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7051:39
index -1 is out of range for type 'u8 [8]'
CPU: 0 PID: 8339 Comm: poc Not tainted 6.7.0-rc2-g727d3a2bd1b6 #34
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xa0/0xe0 lib/ubsan.c:348
 check_stack_range_initialized+0xb06/0x1080 kernel/bpf/verifier.c:7051
 check_helper_mem_access+0x139/0x960 kernel/bpf/verifier.c:7156
 check_mem_size_reg+0x11d/0x1e0 kernel/bpf/verifier.c:7230
 check_func_arg kernel/bpf/verifier.c:8633 [inline]
 check_helper_call.isra.0+0xfc9/0x8530 kernel/bpf/verifier.c:9972
 do_check kernel/bpf/verifier.c:17356 [inline]
 do_check_common+0x4991/0xddb0 kernel/bpf/verifier.c:19899
 do_check_main kernel/bpf/verifier.c:19990 [inline]
 bpf_check+0x3f02/0xa6a0 kernel/bpf/verifier.c:20627
 bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
 __sys_bpf+0xfc8/0x4400 kernel/bpf/syscall.c:5384
 __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

