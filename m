Return-Path: <bpf+bounces-32580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B4910176
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6842282030
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B71A8C3C;
	Thu, 20 Jun 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrkUpcp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33B199250
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879318; cv=none; b=T3IeY+GXYCEpgNjEORkM/WoOgslCvW2RCGCm5UqtXsL7Qfj8jLnzRiMeMiQQSKNY3IY8xmsOYLhsc+hu4kTx26vYrWr1LPq2KVQPWAkE2N/o0ymcRiOQEbnXJPdp1gZ4HHgtnUbYdyN8CfTFQ65J9H3rptpijfiRZQrvAGOHYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879318; c=relaxed/simple;
	bh=8orZamx8oVHw4rR7aN8XdwgGxp218vaZRASmnxXrnlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxwHFAyYQng2ZEO+Ss0O7JkdgrYGQA5nMfWXSc1SiMf8GbZmoMvfnKiM0qyS3j2tmxF9nkHN7Ax3PN7eWDtptgPuS0fjRg+QOURu1uoDYOmd9T4MCoTEevKQ3cX35jDvyk4jga5O2qO6KU25gfssyexe/FQe8eid2MFTOm8gU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJrkUpcp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f700e4cb92so6463905ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718879316; x=1719484116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OjfKW4mhlHyaNhimmDxBtVqtRhMmyAv6HPN10uZ00c=;
        b=KJrkUpcp/PS9iVNrTMqqOvZWAP3MnqH/BDvx3bctx2wygJtkdMGgfnMbDpv8dmeUVv
         e1Q+pc8I3UBNMhQylcEchoxEC6RGg8xDy604TQM+RmPsfVJXTr297JH7ZrbA2mPso3BW
         Ix7UsWqSR5M0B9fglA/3B6E2aUjILi0qyPUN9Suc+um+FRTDc4AQwKjeKHkumCIYszCx
         PRjPpGYhnNXl+GTCGi2MnbsGEwhqvgaUc4RoFvmaZ1RZdMXjHQPZKMgx372qB7uZssUV
         Fcfpl9K7P5PeLSMnpWfvO1tt8sxAyNVNRotxLwzWo9WOQ6NjYNy+lwUyzHfWxP2sfSRx
         BEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879316; x=1719484116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OjfKW4mhlHyaNhimmDxBtVqtRhMmyAv6HPN10uZ00c=;
        b=ProFbP2vVCFfEX9byPMMoUdGN9XBLp+5LKjP3QpdB2befdSqQVqfck4veG4D5Ql4M9
         2eNk7Dc5R7abjHXiC4BbqkN2PcGuYxSlbx1XZQVDbFlbM5Op9TTTUniRBFpGiEHmwKf3
         TEw0Yg9lBdUFgiBk59+Onfxis/yldOojLF1YJjYyjO7YxcohfFjkzSK7juiSZszC4Sre
         ywGgs85ae4WA9PZAx2Y3kBwbek7J6l2D3Mk8NRd+Znq/Cw9CiFozaLV3KcjmaCwqFXxN
         LQ4H5MKuGC1VXsAaDz4SI3O5B5wu5XoK49Ip0LvjTPZdZEqOHE2c/F3gImOEZ+irC7dp
         eb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXu2DyFmQVMmxv1+mx5ILeUC6NYbyE2pp2XL5606EcRfscqu4mKZOlFnuBWsAauOXPIqf0Ky5Rn29bxWLmSVm/cIoCq
X-Gm-Message-State: AOJu0YzBUuWac44aAA09rDLHAUCcjLS/Qey7K6iCQSpOEI4fLgTcR9SE
	c28Lau15S07HmIV+XIB2C/UEpYbzrSDqBbZ2MjJ46+WUViUANZkv
X-Google-Smtp-Source: AGHT+IH0k907BnGQJH7TB6x/UlD/v0AtFrGWcHf8hXZ41SyievNCtHsMQWXKzwpK4dvQwq2YE20L7g==
X-Received: by 2002:a17:902:e80a:b0:1f9:c9e2:4e1 with SMTP id d9443c01a7336-1f9c9e20740mr13483835ad.66.1718879316326;
        Thu, 20 Jun 2024 03:28:36 -0700 (PDT)
Received: from [10.22.68.7] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f99261d056sm50805305ad.86.2024.06.20.03.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:28:35 -0700 (PDT)
Message-ID: <b49e89d0-345f-4616-a955-d1cd9f4b90ed@gmail.com>
Date: Thu, 20 Jun 2024 18:28:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Tengda Wu <wutengda@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20240620060701.1465291-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240620060701.1465291-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/6/24 14:07, Tengda Wu wrote:
> When loading a EXT program without specifying `attr->attach_prog_fd`,
> the `prog->aux->dst_prog` will be null. At this time, calling
> resolve_prog_type() anywhere will result in a null pointer dereference.
> 
> Example stack trace:
> 
> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> [    8.108262] Mem abort info:
> [    8.108384]   ESR = 0x0000000096000004
> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.108722]   SET = 0, FnV = 0
> [    8.108827]   EA = 0, S1PTW = 0
> [    8.108939]   FSC = 0x04: level 0 translation fault
> [    8.109102] Data abort info:
> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    8.112783] Modules linked in:
> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
> [    8.113230] Hardware name: linux,dummy-virt (DT)
> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
> [    8.113798] sp : ffff80008283b9f0
> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> [    8.114126] Call trace:
> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
> [    8.114202]  bpf_check+0x3bc/0x28c0
> [    8.114214]  bpf_prog_load+0x658/0xa58
> [    8.114227]  __sys_bpf+0xc50/0x2250
> [    8.114240]  __arm64_sys_bpf+0x28/0x40
> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
> [    8.114273]  do_el0_svc+0x4c/0xd8
> [    8.114289]  el0_svc+0x3c/0x140
> [    8.114305]  el0t_64_sync_handler+0x134/0x150
> [    8.114331]  el0t_64_sync+0x168/0x170
> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
> [    8.118672] ---[ end trace 0000000000000000 ]---
> 
> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
> when calling bpf_prog_load().
> 
> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Cc: stable@vger.kernel.org # v5.18+
> ---
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f45ed6adc092..4490f8ccf006 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2632,9 +2632,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
>  			return 0;
>  		return -EINVAL;
>  	case BPF_PROG_TYPE_SYSCALL:
> -	case BPF_PROG_TYPE_EXT:
>  		if (expected_attach_type)
>  			return -EINVAL;
> +		return 0;
> +	case BPF_PROG_TYPE_EXT:
> +		if (expected_attach_type || !dst_prog)
> +			return -EINVAL;
>  		fallthrough;
>  	default:
>  		return 0;

Would be better to add a selftest for it.
But, looks good to me.

Acked-by: Leon Hwang <hffilwlqm@gmail.com>


