Return-Path: <bpf+bounces-39721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385D8976ADA
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB41C23776
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D21A2641;
	Thu, 12 Sep 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6Ew+ey8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F41A2C2B
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148390; cv=none; b=eu7nJGbgxul+RjG/oPFaUnyNb+A1AQpDooTT19mOqKT4f92CQ1fI67+Eq0X7b/OT46H6efo8pxE1JJG2GP5AjlDmY8tUqZw8bXVwFsQ+K9Gng+SlIWWTuGkHGoQmsBBf8xewFnv/OnuHqNcxFB/VroN5XGBpS+d+RGuZyB3RXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148390; c=relaxed/simple;
	bh=i1ARZ+re90HSn30lyTXTULOEXH7voJp26sFBUVcwzpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2vAq7M7yu/m0gx3o6Hj5pOhFs5S4fNlwZtdWIK5mZHEIb3LZzXeFkgbkN6Lr/rAgf900mM2WfrVzTM0HmLb1RUYNlB2Jqvdt8LRz06KsYgcumSGJ68xaSeukgtxkcc4ShrB2tAKSk4bD0vig5NA6Imfcu+6iMLAbHp7rF8+VtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6Ew+ey8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726148387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTH+AODJkqHG7R5DYChnEPKMyLn9r72dJ5ZX/ZhC1es=;
	b=g6Ew+ey8aLRUaShADKIdeppRIrD776eGI10ozRjileDE7cXY8iAm002sAGNzrVHYHQG5tl
	qIUbuWryzsSFOeHkn9NleHwx0Byc1XdE6h/moe2IZQcf/Wn0lscMl5drK0EvBSKLujqlY7
	D7Lgaov2exR5c5j9aVknwtVoSVKNqBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-v-N97uihMVmS9s8vs4fiVQ-1; Thu, 12 Sep 2024 09:39:46 -0400
X-MC-Unique: v-N97uihMVmS9s8vs4fiVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so6154155e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 06:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148384; x=1726753184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTH+AODJkqHG7R5DYChnEPKMyLn9r72dJ5ZX/ZhC1es=;
        b=i+PcZ/zdUOTv3ty0MhjzUNLfzeOpmcVVZ97vK42Rbsaw0dSlYB6xjQ9IFCFJ+XVEBW
         mxC3fVc5QkigHtDFAO6Sk2EcWJk7Erv12W65VPVpi8ae4f9A5eKn7QXlfqH953Q1xpHQ
         X25tjHPv8m+D+6GaqSxOAWTDmZc4o8Oiv0qfpsXm7aV6z7XNdTYAfS+GmYDEDwpXzdF2
         pUgQBy3NyRwWOhtQy3AiJakFiZ7HfMDgdROquF5QZ88/ehTmIM0D7LmflROztZT7b+IU
         uPv/MXGAFVHVk9IIjUmhCly5QEb9E8Jeh/MX1h9VowpFz7a51K/dzT9vvZ9bWVIWGkJk
         WJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx07GDkiqZhjQcRY2TZEiW4w7W1JOGq7dwNJKLV5ln7MQU2UNFmWNB2q5qNVA/1kBbUdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5O6E65pfTemvuX+4qFKZvHiWpIrYdcfjiXtB8MMsJ2aBVmFW
	d7pDXhyu+FFKiAV9jMCfxOpwjbI/f8QuqPvzI3mZYUi1FETA+FkDDscL9nJJOyDQq+iAGSHPPRr
	CK4RpGRMIhaAsZiB0BGN3mz+Xef6a3a8M41JnTGGlFNNCbZQhpQ==
X-Received: by 2002:a5d:46c9:0:b0:374:ba70:5525 with SMTP id ffacd0b85a97d-378c2cd5fcbmr1638666f8f.12.1726148383685;
        Thu, 12 Sep 2024 06:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUjmTSGzhw8s4cfrm1qCW28phQwHzz8FqoQqDd+C6ko3W2FFzGaPN4thvSWnAMSZKD6bzfJQ==
X-Received: by 2002:a5d:46c9:0:b0:374:ba70:5525 with SMTP id ffacd0b85a97d-378c2cd5fcbmr1638639f8f.12.1726148383124;
        Thu, 12 Sep 2024 06:39:43 -0700 (PDT)
Received: from [10.1.33.218] ([62.218.203.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32b0csm173663975e9.18.2024.09.12.06.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:39:42 -0700 (PDT)
Message-ID: <a3f1ee16-f29d-43c4-b272-64da00026359@redhat.com>
Date: Thu, 12 Sep 2024 15:39:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: netfilter: move nf flowtable bpf initialization
 in nf_flow_table_module_init()
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 17:37, Lorenzo Bianconi wrote:
> Move nf flowtable bpf initialization in nf_flow_table module load
> routine since nf_flow_table_bpf is part of nf_flow_table module and not
> nf_flow_table_inet one. This patch allows to avoid the following kernel
> warning running the reproducer below:
> 
> $modprobe nf_flow_table_inet
> $rmmod nf_flow_table_inet
> $modprobe nf_flow_table_inet
> modprobe: ERROR: could not insert 'nf_flow_table_inet': Invalid argument
> 
> [  184.081501] ------------[ cut here ]------------
> [  184.081527] WARNING: CPU: 0 PID: 1362 at kernel/bpf/btf.c:8206 btf_populate_kfunc_set+0x23c/0x330
> [  184.081550] CPU: 0 UID: 0 PID: 1362 Comm: modprobe Kdump: loaded Not tainted 6.11.0-0.rc5.22.el10.x86_64 #1
> [  184.081553] Hardware name: Red Hat OpenStack Compute, BIOS 1.14.0-1.module+el8.4.0+8855+a9e237a9 04/01/2014
> [  184.081554] RIP: 0010:btf_populate_kfunc_set+0x23c/0x330
> [  184.081558] RSP: 0018:ff22cfb38071fc90 EFLAGS: 00010202
> [  184.081559] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
> [  184.081560] RDX: 000000000000006e RSI: ffffffff95c00000 RDI: ff13805543436350
> [  184.081561] RBP: ffffffffc0e22180 R08: ff13805543410808 R09: 000000000001ec00
> [  184.081562] R10: ff13805541c8113c R11: 0000000000000010 R12: ff13805541b83c00
> [  184.081563] R13: ff13805543410800 R14: 0000000000000001 R15: ffffffffc0e2259a
> [  184.081564] FS:  00007fa436c46740(0000) GS:ff1380557ba00000(0000) knlGS:0000000000000000
> [  184.081569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  184.081570] CR2: 000055e7b3187000 CR3: 0000000100c48003 CR4: 0000000000771ef0
> [  184.081571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  184.081572] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  184.081572] PKRU: 55555554
> [  184.081574] Call Trace:
> [  184.081575]  <TASK>
> [  184.081578]  ? show_trace_log_lvl+0x1b0/0x2f0
> [  184.081580]  ? show_trace_log_lvl+0x1b0/0x2f0
> [  184.081582]  ? __register_btf_kfunc_id_set+0x199/0x200
> [  184.081585]  ? btf_populate_kfunc_set+0x23c/0x330
> [  184.081586]  ? __warn.cold+0x93/0xed
> [  184.081590]  ? btf_populate_kfunc_set+0x23c/0x330
> [  184.081592]  ? report_bug+0xff/0x140
> [  184.081594]  ? handle_bug+0x3a/0x70
> [  184.081596]  ? exc_invalid_op+0x17/0x70
> [  184.081597]  ? asm_exc_invalid_op+0x1a/0x20
> [  184.081601]  ? btf_populate_kfunc_set+0x23c/0x330
> [  184.081602]  __register_btf_kfunc_id_set+0x199/0x200
> [  184.081605]  ? __pfx_nf_flow_inet_module_init+0x10/0x10 [nf_flow_table_inet]
> [  184.081607]  do_one_initcall+0x58/0x300
> [  184.081611]  do_init_module+0x60/0x230
> [  184.081614]  __do_sys_init_module+0x17a/0x1b0
> [  184.081617]  do_syscall_64+0x7d/0x160
> [  184.081620]  ? __count_memcg_events+0x58/0xf0
> [  184.081623]  ? handle_mm_fault+0x234/0x350
> [  184.081626]  ? do_user_addr_fault+0x347/0x640
> [  184.081630]  ? clear_bhb_loop+0x25/0x80
> [  184.081633]  ? clear_bhb_loop+0x25/0x80
> [  184.081634]  ? clear_bhb_loop+0x25/0x80
> [  184.081637]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  184.081639] RIP: 0033:0x7fa43652e4ce
> [  184.081647] RSP: 002b:00007ffe8213be18 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [  184.081649] RAX: ffffffffffffffda RBX: 000055e7b3176c20 RCX: 00007fa43652e4ce
> [  184.081650] RDX: 000055e7737fde79 RSI: 0000000000003990 RDI: 000055e7b3185380
> [  184.081651] RBP: 000055e7737fde79 R08: 0000000000000007 R09: 000055e7b3179bd0
> [  184.081651] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000040000
> [  184.081652] R13: 000055e7b3176fa0 R14: 0000000000000000 R15: 000055e7b3179b80
> 
> Fixes: 391bb6594fd3 ("netfilter: Add bpf_xdp_flow_lookup kfunc")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

The reported CI failures looks like an independent flake.

Since already acked by the relevant parties, accepting this a little 
lower the 24H grace period to land into todays PR.

Cheers,

/P


