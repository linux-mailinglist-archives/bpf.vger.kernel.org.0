Return-Path: <bpf+bounces-50267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12AA247A6
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD953A8404
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296F13DBB6;
	Sat,  1 Feb 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1CJqPIz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2C22301;
	Sat,  1 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738397638; cv=none; b=IGOfr2+4l5fb8ZmtrGXyjT5azXOIIiXZBVXvquof6tptny/yRvJy5oVE9jPlT9h1IyFtswvPz/AZ1/0Y5NJRxSmhaQDL5DD1DrpKCBkNZt8XfvDpXCl26yh1QWB/EwPF0p9ryyHGFBeLRoT7P5KbzabgK0WzFupKP8kpBPqJ11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738397638; c=relaxed/simple;
	bh=+o7OpftxvJ7odRvtJQX+1YroFAOXXH5xf2zq8COGls0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ2ls7gmcCZ6wkcST1auN735alpU12cxcSO3sdWwlg0wjMbJ+PJmAQO3axuzXYSmxcBMPMuZo4wT2ST8PCKg4Wvu0M8sLM1pFzdZiVyBSefF40d03OElqt6pdqP9XOr/MY9/j+lMtBoymJ/TwY4a22QuokyVesmjvFdcfao4WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1CJqPIz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso28116845e9.0;
        Sat, 01 Feb 2025 00:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738397635; x=1739002435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x80V0UokGmNr0H2sgQ1akGR+E+fYoDNPRW/fOWgl3Zk=;
        b=D1CJqPIzon31BigZ+wYZpnHU/oKKowPIwb7v9qBwvWObhSLMPcDH2yNn+LQ4fpe2l1
         /iaSMa8/aGe1pq4ELIhsWiVKU8ojLbW9TGceDXgc8nE5ZjX7sZyrJPabsUnIMDQ2QH59
         BHQqBzlUIt2NsIj9sRrGf/vb2o8eI+5mZIHWNOng2tdrU4yDacFV6Ng0QhgFPlfFRFig
         l6Q0nXxZFRAsBvccSK2/gduqCa+imVT0VsZlfFkgdemt7hg19MnDjJn+aW/1mgP9ZkAC
         BDc+hn9lsUhe1hbQFU6RrwEydeQsNSmI0pGWYYJ+qvbLheNQm962HE/9V7mNowTIUQX3
         Mxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738397635; x=1739002435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x80V0UokGmNr0H2sgQ1akGR+E+fYoDNPRW/fOWgl3Zk=;
        b=V6rwbB9HBQuOzBpdXBxYMYt8CByNCmp1V1EF/nemq1GFTLsNkyocRt3hVm4UFkc3rm
         wwJOI56QXIWBUibtCDMiVzqHLcEZ4MHEDPSYILBhy56HFsARFpHiyCkSp8FaEw/+wq5Z
         L71NDjCp15uZ+4j3+V9puay997aj63Qgf9dwag2FzPRKG8Avb4au9y5Ppvb4TKi4TgBV
         kUrhV4e96DoZGJrpvl08xDnm2j5MQm7T2v4AB2uPIQV3V4C+FJ9OUc993rGsg0Y1/1TR
         EgQj2cEtj5u5G+gcBKsqNiezCNOQTHTOAHKzTu2+mKwfoYcgQcXfh1boRJsYLpmgQ3r3
         TTzw==
X-Forwarded-Encrypted: i=1; AJvYcCU0QZcvOAc/VaY5uscvu5UgktbBjgJZQZuH+TIFFbDbbjcfDAoMUuhkckt4AQbia6G8c+I=@vger.kernel.org, AJvYcCVLVCS39/JNpDr91Du/38DJkI5X7gbtOmXap8nWXon/0NRk+Vx3gg6tRTJdBeHkt4CwJnJoRRdo@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpDIvG2Wd5jaAFnzSAyL6cX6HCuj1m5nBmKmDbol95ytfI+74
	Lijl0amzfsm1WZPJeVAiV5cODUu6Ani2coUpVV85DxGJA1iPgHje
X-Gm-Gg: ASbGnct2kvm23w5jLpIGr9kOK0pMgo9cWcO6CRsPAlnbuudLRu+dI1ENwz/m2g4fbJe
	/pNx0NCvIE13VR7QbvtHeXinMhjKNa7AgDLy9w/0JkXR13br9EIBSudHsC86im0/9CeDQOpCNnm
	G3fQ6oOl0C375SY53ew2ZRENVrtebwn0LZtLZ/Ko5MZu3hZWMGyGKYagl6FWgB92Baq1WHEbL98
	6lhTCJKQP7K2KKiG+7AqYM9MyYU1jkmyVALVrZ+ZPVuNcTcpiLYZ7fUZWtze/90sY9XHsWUaUJr
	tQ==
X-Google-Smtp-Source: AGHT+IHdF2pLGF25zRF1FFmiCFDn6JX4P9PDPobDon4OC5r0lF0NMxk1vDLk6CszBDBKJF6/jW5fGg==
X-Received: by 2002:a05:600c:1c91:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-438dc3c38c6mr121893495e9.12.1738397634591;
        Sat, 01 Feb 2025 00:13:54 -0800 (PST)
Received: from krava ([193.32.29.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa296esm97753805e9.1.2025.02.01.00.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 00:13:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Feb 2025 09:13:51 +0100
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to
 raw_tp_null_args[].
Message-ID: <Z53Xv-okoj3PDT50@krava>
References: <20250201030142.62703-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201030142.62703-1-kuniyu@amazon.com>

On Fri, Jan 31, 2025 at 07:01:42PM -0800, Kuniyuki Iwashima wrote:
> Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> in trace_kfree_skb if the prog does not check if rx_sk is NULL.
> 
> Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
> 
> Let's add kfree_skb to raw_tp_null_args[] to let the BPF verifier
> validate such a prog and prevent the issue.
> 
> Now we fail to load such a prog:
> 
>   libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
>   0: R1=ctx() R10=fp0
>   ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_skb_sk_null.bpf.c:21
>   0: (79) r3 = *(u64 *)(r1 +24)
>   func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
>   1: R1=ctx() R3_w=trusted_ptr_or_null_sock(id=1)
>   ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfree_skb_sk_null.bpf.c:24
>   1: (69) r4 = *(u16 *)(r3 +16)
>   R3 invalid mem access 'trusted_ptr_or_null_'
>   processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
> 
> Note this fix requires commit 838a10bd2ebf ("bpf: Augment raw_tp
> arguments with PTR_MAYBE_NULL").
> 
> [0]:
> BUG: kernel NULL pointer dereference, address: 0000000000000010
>  PF: supervisor read access in kernel mode
>  PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> PREEMPT SMP
> CPU: 6 UID: 0 PID: 348 Comm: sshd Not tainted 6.12.11 #206
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
> Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 48 8b 57 18 <48> 0f b7 4a 10 48 bf 0c 4f e2 c1 ad 90 ff ff be 0c 00 00 00 e8 0f
> RSP: 0018:ffffa86640b53da8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffffa866402d1000 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: ffffa866402d1048 RDI: ffffa86640b53dc8
> RBP: ffffa86640b53da8 R08: 0000000000000000 R09: 9c908cd09b9c8c91
> R10: ffff90adc056b540 R11: 0000000000000002 R12: 0000000000000000
> R13: ffffa86640b53e88 R14: 0000000000000800 R15: fffffffffffffffe
> FS:  00007f2a27c2b480(0000) GS:ffff90b0efd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000100e69004 CR4: 00000000001726f0
> Call Trace:
>  <TASK>
>  ? __die+0x1f/0x60
>  ? page_fault_oops+0x148/0x420
>  ? search_bpf_extables+0x5b/0x70
>  ? fixup_exception+0x27/0x2c0
>  ? exc_page_fault+0x75/0x170
>  ? asm_exc_page_fault+0x22/0x30
>  ? bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
>  bpf_trace_run4+0x68/0xd0
>  ? unix_stream_connect+0x1f4/0x6f0
>  sk_skb_reason_drop+0x90/0x120
>  unix_stream_connect+0x1f4/0x6f0
>  __sys_connect+0x7f/0xb0
>  __x64_sys_connect+0x14/0x20
>  do_syscall_64+0x47/0xc30
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f2a27f296a0
> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 41 ff 0c 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
> RSP: 002b:00007ffe29274f58 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
> 
> Fixes: c53795d48ee8 ("net: add rx_sk to trace_kfree_skb")
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Closes: https://lore.kernel.org/netdev/Z50zebTRzI962e6X@debian.debian/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   * Add kfree_skb to raw_tp_null_args[] instead of annotating
>     rx_skb with __nullable

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> v1: https://lore.kernel.org/bpf/20250201001425.42377-1-kuniyu@amazon.com/
> ---
>  kernel/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9de6acddd479..c3223e0db2f5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6507,6 +6507,8 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
>  	/* rxrpc */
>  	{ "rxrpc_recvdata", 0x1 },
>  	{ "rxrpc_resend", 0x10 },
> +	/* skb */
> +	{"kfree_skb", 0x1000},
>  	/* sunrpc */
>  	{ "xs_stream_read_data", 0x1 },
>  	/* ... from xprt_cong_event event class */
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

