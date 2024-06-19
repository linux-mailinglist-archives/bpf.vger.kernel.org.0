Return-Path: <bpf+bounces-32505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5790E64F
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B81C218B4
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE617D088;
	Wed, 19 Jun 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5fXran"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CF2139B1
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787144; cv=none; b=dmXMMpbgnlCsZNSZ3jbyEILASC2aEV9hgwTwCfxCmLjOKAx5yPyuOBiJLCMDN+3mBgpdkJr+/eDz6Yx0BSM1+qWABJi3fZazYDiHQfGv2B36N4HKHrGeFiQ6So63TDXFzVg9j1U0/+iDySH+oGJ8Bs+Vszt+/jRdEFlviAs0j3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787144; c=relaxed/simple;
	bh=6EdKmqtWk5jnq859gyRM3QoxJK21anxacJP/hH9F/A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDLimagHt5FuqTev5gK2D6157r4ag7hOxkLzji0fGKXuzaa4Xs48k8eKo/fzioOjKZCJumJbWJGzyt5vqcGCrVYSqQPN8vOLCNvKX+2PdSYkh92IlZOLfQHYq/KGTwXGqcrzxfQtkWa3f0xb6uzySbVx/Y0HyvBanX5Nn3DhWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT5fXran; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso838608466b.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718787141; x=1719391941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqsJN/dL2uU/COBCvCNXFnVnbZdegg2i0q9GQv+D47s=;
        b=GT5fXran6TcYdRLzygvLUWJW5NHj+rXjIfyf7vq7gom9BreRagm5dprEtPmkM0YKsY
         MqpxEjKArKcNFO7RmqObmVYSxvmM8dxORsDCRIOsbGFI8UufPxr9dNR6/OLVEeoyugDv
         q3gfS4mfyMOGBRYJdr6aN4fSb3yEz9P2WtwafyPUOZaigLdWja3cbH86BYGaXp45Vx62
         LAYmYyDCGMva3nzVGhDjH85aD4fCg4OTtrygV58CNyezwo3o/hdptPEfuZ3oEA7M5Wcu
         8ljEddf/Li3Bw14+JiXaCtyV+3e+nKa69LY3eEFB2/dq5zgPnUcG6QijLNPNXZJDyOD/
         LhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787141; x=1719391941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqsJN/dL2uU/COBCvCNXFnVnbZdegg2i0q9GQv+D47s=;
        b=YO7xdvgvw2iMtiRsH3KWinE05q4siyjUVptuDaxTYKv7h0H6mMVvTTleEoqXm18jNp
         M1MjAAJz5z8/9llUE+XxRXmw4kEm2uN3gb4PbOoRydcqjRdm9ow99l8klE/zgoibaqSJ
         QqHK/H8eYO7TgUydHpt95xvel3amAz19JoFH57UooVlQiD0HDYCf0//NCC+vSpmaNXVe
         rt3gX8Gszf0z3KtMTWA03qATyhSgoakRK/+VmVDkDo4Fnk1vXZlmW7lrEmy3JYtZ9GNp
         JGGhGodZ6tW8icohLGHpYBFVnSzLusVPb6S63JwtvhIpO1779MP05enMtNhuYH7IkzFp
         zYyw==
X-Gm-Message-State: AOJu0YwDJfz2PSFBu/s05qmhfAB5RGa17gg3UYTTpIgPLrI1XLajG6GI
	8tX7ng6mrXdZ30Ilfc+1Wol47mVf2vhhLHEdT1p+aV5dB0FcrhRnKM9+CauiQ0ZgiSfygG/RUHo
	hLhlbzNH+WeVLDx0aERJPiE2/Kk2sZlrC
X-Google-Smtp-Source: AGHT+IF/a/KVs+lr1J3kxQ9/z0o54D64KieXeaMHdJgij4ELojCOzCPTgkt1xvZTj7DehX9sHIRpwc6hx3E9KFnJnzk=
X-Received: by 2002:a17:907:7ba8:b0:a6f:718f:39b6 with SMTP id
 a640c23a62f3a-a6fab613430mr96785066b.25.1718787140835; Wed, 19 Jun 2024
 01:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082946.2389067-1-mattbobrowski@google.com>
In-Reply-To: <20240619082946.2389067-1-mattbobrowski@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Jun 2024 10:51:44 +0200
Message-ID: <CAP01T77xObOA6E9mnqo1w_ZFchXtFpjjAOMU=b+GCgNxrwqjbQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: add missing check_func_arg_reg_off() to prevent
 out-of-bounds memory accesses
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 10:29, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> a global function as an argument. The adverse effects of this is that
> BPF helpers can continue to make use of this modified
> CONST_PTR_TO_DYNPTR from within the context of the global function,
> which can unintentionally result in out-of-bounds memory accesses and
> therefore compromise overall system stability i.e.
>
> [  244.157771] BUG: KASAN: slab-out-of-bounds in bpf_dynptr_data+0x137/0x140
> [  244.161345] Read of size 8 at addr ffff88810914be68 by task test_progs/302
> [  244.167151] CPU: 0 PID: 302 Comm: test_progs Tainted: G O E 6.10.0-rc3-00131-g66b586715063 #533
> [  244.174318] Call Trace:
> [  244.175787]  <TASK>
> [  244.177356]  dump_stack_lvl+0x66/0xa0
> [  244.179531]  print_report+0xce/0x670
> [  244.182314]  ? __virt_addr_valid+0x200/0x3e0
> [  244.184908]  kasan_report+0xd7/0x110
> [  244.187408]  ? bpf_dynptr_data+0x137/0x140
> [  244.189714]  ? bpf_dynptr_data+0x137/0x140
> [  244.192020]  bpf_dynptr_data+0x137/0x140
> [  244.194264]  bpf_prog_b02a02fdd2bdc5fa_global_call_bpf_dynptr_data+0x22/0x26
> [  244.198044]  bpf_prog_b0fe7b9d7dc3abde_callback_adjust_bpf_dynptr_reg_off+0x1f/0x23
> [  244.202136]  bpf_user_ringbuf_drain+0x2c7/0x570
> [  244.204744]  ? 0xffffffffc0009e58
> [  244.206593]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
> [  244.209795]  bpf_prog_33ab33f6a804ba2d_user_ringbuf_callback_const_ptr_to_dynptr_reg_off+0x47/0x4b
> [  244.215922]  bpf_trampoline_6442502480+0x43/0xe3
> [  244.218691]  __x64_sys_prlimit64+0x9/0xf0
> [  244.220912]  do_syscall_64+0xc1/0x1d0
> [  244.223043]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  244.226458] RIP: 0033:0x7ffa3eb8f059
> [  244.228582] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> [  244.241307] RSP: 002b:00007ffa3e9c6eb8 EFLAGS: 00000206 ORIG_RAX: 000000000000012e
> [  244.246474] RAX: ffffffffffffffda RBX: 00007ffa3e9c7cdc RCX: 00007ffa3eb8f059
> [  244.250478] RDX: 00007ffa3eb162b4 RSI: 0000000000000000 RDI: 00007ffa3e9c7fb0
> [  244.255396] RBP: 00007ffa3e9c6ed0 R08: 00007ffa3e9c76c0 R09: 0000000000000000
> [  244.260195] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffff80
> [  244.264201] R13: 000000000000001c R14: 00007ffc5d6b4260 R15: 00007ffa3e1c7000
> [  244.268303]  </TASK>
>
> Add a check_func_arg_reg_off() to the path in which the BPF verifier
> verifies the arguments of global function arguments, specifically
> those which take an argument of type ARG_PTR_TO_DYNPTR |
> MEM_RDONLY. Also, process_dynptr_func() doesn't appear to perform any
> explicit and strict type matching on the supplied register type, so
> let's also enforce that a register either type PTR_TO_STACK or
> CONST_PTR_TO_DYNPTR is by the caller. Lastly, we also add a new
> negative test which catches this regression.
>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

As we discussed offline, once you respin, it'd be best to split
selftests and the fix into two, and probably add one more for the lack
of reg->type check (if it's possible to trigger without this fix), and
extend the commit log accordingly.

Apart from that, fix & test lgtm!

