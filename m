Return-Path: <bpf+bounces-35233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C99390DE
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A221C213BF
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5B16D9BF;
	Mon, 22 Jul 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgHA9Nwf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57F125D6
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659417; cv=none; b=i7NoOcxzsFrBHdCGWR8AW6wigp8VYMrnEsSRV2QGv7Ns8fV1hmHLTIJrTs/cQgAOOruxYnl8vihkQ+kVKkwRk00KRCK1VBW16GVRmh3AFyop0rUhBgjEMVpHyfI8mUi3e+sVB074RS40SrT/iE2HlOYSHjyxmE0bI+RYXDulPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659417; c=relaxed/simple;
	bh=yDcIEgHjxHD80tcpEp53KhsOHIvo6wpR83IscfZqMDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQvDIpb4F9DAOqkjhucxRCgeiiCbSZusirJaaJDu+K2oO6TkEAJzvMXEcCB8dz2oTVHlglbgrtaHDC8X2Sp1KNzecFA1maQWWZtcG6svmNYLUBo9ZrSXILU1mK7qQu3R+Hwc38+B+MvGG9ezQeuOlRRVZSHdCRFU4FljAkPNYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgHA9Nwf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d18112b60so1013769b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721659414; x=1722264214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq3tg4s/LbnktJiay7vmTUHoQrXnb89jHbQiQicLVx4=;
        b=BgHA9NwfPgKlqpg0wZalczZShdK0+Rd2rRypeQgvzkACcxSnGH9qI54d7lkp88nW7c
         Na9id9eWhpgUHWkpG+bOsIlg1hYiGUxEl0wbrWvEatRCnVVvL3fKQ6F5Jt6WGx3IktvU
         QFjqQIrbrrzi1OpcLkNF0zhj87Vveualf7fiBwVciOoCXQGYugIwt/M/8kXLTb9b92j/
         iSMAw9ufbmMIOQVVIzclNGkKi+Ny8Wm9ogkVn1O9f1VHkR+eTXD0EcDq3auZ57kioqg5
         5c+62tGfE2NBNmHcnvvzxrS6QCUiQOgf26/cUQ2BH7chJzaJqvr5Z1/oe9HKUpvkYCDV
         XBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659414; x=1722264214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq3tg4s/LbnktJiay7vmTUHoQrXnb89jHbQiQicLVx4=;
        b=sBabx931Oy3PnBt5sHayXoV41Hh8FoS9U/jQzci7CyyiR5X8JjYg6h+d3vRghBDOen
         wQ80ZpYkqcVHDWFF9f2mZoywrdzitBRketi2XulKFkUkOWxIaYm0bJS1jqjFloKZ+m8i
         hzBV1lU+vuvKPpe5VzdRPZeXeyaTg7njCzpAolqziSqXWLvRog3oH43UnASr4KYbXDoa
         5+wzcFXFvgzVkJivK4wdr1J+jGjjP3Gk5h5QizEYSa3qiQb02ZsgKVWvi6pVdYnmaZFR
         fiyCH5JIgUxC7xuSv7R+i4TWMGReug7sRtGee/WwvJ8qG3bRmYT/Rmp1ziAWT72deWfm
         FvpA==
X-Gm-Message-State: AOJu0YwUsT8habvDfNoBaHIenTp7+C+DPFEVJfKVwUuf8jhbq6V2CII8
	JBbAUdgB/DSR29hU6vyPf4NFlbAoeg1yNwZEliJdcb5kVaFb2KPDPqD8XQ==
X-Google-Smtp-Source: AGHT+IF5lfM06jQXspslTybB7mbITmeKheCUTJIrkZ/IklURcfkbf1yFyHPOXsBzPlX7nwV2x+ST6Q==
X-Received: by 2002:a05:6a00:4f88:b0:706:6867:7a63 with SMTP id d2e1a72fcca58-70d094d2a71mr11319726b3a.6.1721659413636;
        Mon, 22 Jul 2024 07:43:33 -0700 (PDT)
Received: from [192.168.1.76] (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d165333c7sm3220993b3a.191.2024.07.22.07.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:43:33 -0700 (PDT)
Message-ID: <172a5daf-8a3b-44d1-8719-301a6e8d196a@gmail.com>
Date: Mon, 22 Jul 2024 22:43:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Fix updating attached freplace to
 PROG_ARRAY map
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com
References: <20240602122421.50892-1-hffilwlqm@gmail.com>
 <20240602122421.50892-2-hffilwlqm@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240602122421.50892-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/6/2 20:24, Leon Hwang wrote:
> Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
> checking map compatibility"), freplace prog can be used as tail-callee.
> 
> However, when freplace prog has been attached and then updates to
> PROG_ARRAY map, it will panic, because the updating checks prog type of
> freplace prog by 'prog->aux->dst_prog->type' and 'prog->aux->dst_prog' of
> freplace prog is NULL.
> 
> [309049.036402] BUG: kernel NULL pointer dereference, address: 0000000000000004
> [309049.036419] #PF: supervisor read access in kernel mode
> [309049.036426] #PF: error_code(0x0000) - not-present page
> [309049.036432] PGD 0 P4D 0
> [309049.036437] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [309049.036444] CPU: 2 PID: 788148 Comm: test_progs Not tainted 6.8.0-31-generic #31-Ubuntu
> [309049.036465] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
> [309049.036477] RIP: 0010:bpf_prog_map_compatible+0x2a/0x140
> [309049.036488] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 fe 41 55 41 54 53 44 8b 6e 04 48 89 f3 41 83 fd 1c 75 0c 48 8b 46 38 48 8b 40 70 <44> 8b 68 04 f6 43 03 01 75 1c 48 8b 43 38 44 0f b6 a0 89 00 00 00
> [309049.036505] RSP: 0018:ffffb2e080fd7ce0 EFLAGS: 00010246
> [309049.036513] RAX: 0000000000000000 RBX: ffffb2e0807c1000 RCX: 0000000000000000
> [309049.036521] RDX: 0000000000000000 RSI: ffffb2e0807c1000 RDI: ffff990290259e00
> [309049.036528] RBP: ffffb2e080fd7d08 R08: 0000000000000000 R09: 0000000000000000
> [309049.036536] R10: 0000000000000000 R11: 0000000000000000 R12: ffff990290259e00
> [309049.036543] R13: 000000000000001c R14: ffff990290259e00 R15: ffff99028e29c400
> [309049.036551] FS:  00007b82cbc28140(0000) GS:ffff9903b3f00000(0000) knlGS:0000000000000000
> [309049.036559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [309049.036566] CR2: 0000000000000004 CR3: 0000000101286002 CR4: 00000000003706f0
> [309049.036573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [309049.036581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [309049.036588] Call Trace:
> [309049.036592]  <TASK>
> [309049.036597]  ? show_regs+0x6d/0x80
> [309049.036604]  ? __die+0x24/0x80
> [309049.036619]  ? page_fault_oops+0x99/0x1b0
> [309049.036628]  ? do_user_addr_fault+0x2ee/0x6b0
> [309049.036634]  ? exc_page_fault+0x83/0x1b0
> [309049.036641]  ? asm_exc_page_fault+0x27/0x30
> [309049.036649]  ? bpf_prog_map_compatible+0x2a/0x140
> [309049.036656]  prog_fd_array_get_ptr+0x2c/0x70
> [309049.036664]  bpf_fd_array_map_update_elem+0x37/0x130
> [309049.036671]  bpf_map_update_value+0x1d3/0x260
> [309049.036677]  map_update_elem+0x1fa/0x360
> [309049.036683]  __sys_bpf+0x54c/0xa10
> [309049.036689]  __x64_sys_bpf+0x1a/0x30
> [309049.036694]  x64_sys_call+0x1936/0x25c0
> [309049.036700]  do_syscall_64+0x7f/0x180
> [309049.036706]  ? do_syscall_64+0x8c/0x180
> [309049.036712]  ? do_syscall_64+0x8c/0x180
> [309049.036717]  ? irqentry_exit+0x43/0x50
> [309049.036723]  ? common_interrupt+0x54/0xb0
> [309049.036729]  entry_SYSCALL_64_after_hwframe+0x73/0x7b
> 
> Why 'prog->aux->dst_prog' of freplace prog is NULL? It causes by commit 3aac1ead5eb6
> ("bpf: Move prog->aux->linked_prog and trampoline into bpf_link on attach").
> 
> As 'prog->aux->dst_prog' of freplace prog is set as NULL when attach,
> freplace prog does not have stable prog type. But when to update
> freplace prog to PROG_ARRAY map, it requires checking prog type. They are
> conflict in theory.
> 
> This patch is unable to resolve this issue thoroughly. It resolves prog
> type of freplace prog by 'prog->aux->saved_dst_prog_type' to avoid panic.
> 
> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 50aa87f8d77ff..b648a96ca310b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -845,7 +845,7 @@ static inline u32 type_flag(u32 type)
>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>  {
>  	return prog->type == BPF_PROG_TYPE_EXT ?
> -		prog->aux->dst_prog->type : prog->type;
> +		prog->aux->saved_dst_prog_type : prog->type;
>  }
>  
>  static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)

Hi,

If no better idea to discuss, I'll respin the PATCH.

And then, I'm planning to fix another tailcall issue caused by
1c123c567fb1 ("bpf: Resolve fext program type when checking map
compatibility"), which is able to produce panic:

[   15.310490] BUG: TASK stack guard page was hit at (____ptrval____)
(stack is (____ptrval____)..(____ptrval____))
[   15.310490] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[   15.310490] CPU: 1 PID: 89 Comm: test_progs Tainted: G           OE
   6.10.0-rc6-g026dcdae8d3e-dirty #72
[   15.310490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Call Trace:
[   15.310490]  <#DF>
[   15.310490]  ? die+0x36/0x90
[   15.310490]  ? handle_stack_overflow+0x4d/0x60
[   15.310490]  ? exc_double_fault+0x117/0x1a0
[   15.310490]  ? asm_exc_double_fault+0x23/0x30
[   15.310490]  ? bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490]  </#DF>
[   15.310490]  <TASK>
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  ...
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  bpf_test_run+0x210/0x370
[   15.310490]  ? bpf_test_run+0x128/0x370
[   15.310490]  bpf_prog_test_run_skb+0x388/0x7a0
[   15.310490]  __sys_bpf+0xdbf/0x2c40
[   15.310490]  ? clockevents_program_event+0x52/0xf0
[   15.310490]  ? lock_release+0xbf/0x290
[   15.310490]  __x64_sys_bpf+0x1e/0x30
[   15.310490]  do_syscall_64+0x68/0x140
[   15.310490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   15.310490] RIP: 0033:0x7f133b52725d
[   15.310490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[   15.310490] RSP: 002b:00007ffddbc10258 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[   15.310490] RAX: ffffffffffffffda RBX: 00007ffddbc10828 RCX:
00007f133b52725d
[   15.310490] RDX: 0000000000000050 RSI: 00007ffddbc102a0 RDI:
000000000000000a
[   15.310490] RBP: 00007ffddbc10270 R08: 0000000000000000 R09:
00007ffddbc102a0
[   15.310490] R10: 0000000000000064 R11: 0000000000000206 R12:
0000000000000004
[   15.310490] R13: 0000000000000000 R14: 0000558ec4c24890 R15:
00007f133b6ed000
[   15.310490]  </TASK>
[   15.310490] Modules linked in: bpf_testmod(OE)
[   15.310490] ---[ end trace 0000000000000000 ]---
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Kernel panic - not syncing: Fatal exception in interrupt
[   15.310490] Kernel Offset: 0x30000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks,
Leon

