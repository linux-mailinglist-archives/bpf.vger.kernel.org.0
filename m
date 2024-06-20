Return-Path: <bpf+bounces-32561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC090FCF5
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 08:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D5C1C21108
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5582E631;
	Thu, 20 Jun 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHQfwAtX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EC12E78
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865971; cv=none; b=F11Ebz61ahIeaDWgVdUcXXskO2WjKFw39Rh/Buml7EBt0DCES3C0+DolP0ytYKkhwB9ODdQhAIK/AZXDeSq0JMqqTeVLUlLFKaclVWJMexLEAeVU6isYpPwjjAchQTA26yKrx4wt24n8BCxNUNl17jlaW0KInoIZZnOYyrFB07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865971; c=relaxed/simple;
	bh=J837tzLcJ1unXMVTuB2/uUPhf0lcd9vlSW9MaX8/xmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uS2PirZxxBfr8SWEQBSY63XRgJYY4aJtxTA1N2kyYqubNPd3dDDY2mZX1ZgS6j9MoLOXf2WRrb2Zx8mKPGvPmpY73f6aIzJuun7mL4UZWOftf6L1m78aKfSoDAF2qGXmAgrkCzdx2G8meg9MHq4hYQNDK77GLzX/xJynYH3Sdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHQfwAtX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f99fe4dc5aso4573745ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718865969; x=1719470769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxKJcl2fG81OTHm6RuefVx/DQDrIocy5zsAucNjnW/Y=;
        b=iHQfwAtX7IsiMxRx9uGJLFl9WYN/TVPukZgTUv2hUuRpyz2Ehgi/PVtBt9CnKJKT4O
         7tbgHW6gB/o2mOMdxNPJBlS4vNC4kV3Juf1CpxJqDMHITBJQrXGARKOkKysYF8uwH4Bd
         ySBYhKPBr5RcOcGHYljNIpaGT7IW+DTbTjc7Gp988WbQaeC234kSt3+hd7R8VNsW2PX6
         GcxzdKjc5ngA+tnJgsGaNRk6dqJ1UUJ5JFaO3ufF5XgfFg/XFsswChopLnBROb3jOntm
         KLhXJKpOF5fO8W8haZNO0epo85wXIyRxEg/TumCx0Gcifrstoq9awcM7dxr5yzLWerLt
         Ug7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865969; x=1719470769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxKJcl2fG81OTHm6RuefVx/DQDrIocy5zsAucNjnW/Y=;
        b=F+Hk5xB0I7YecAN/psiLhDDj0w6rDxLDZNhhAYn6gn7CRxBBb0ErANmUav7WPqvjn/
         TxE2P1GPwMMX0tCO3bU30QA7lA2bYO40qTsDvAuxHjUgYGlyWpqn/Bsor8CA+DFy9p9S
         y6pBxpdHpelp6Cyc3Y4cAqxRs7v2Brqkc6DrSWgTmoCopMm5IkBykYETFCmLz3kANb8i
         OT+N6q3mSwIAEGe3mlF2jMnhVNbsfVJ4D6uIdtXlpJ5I9qsqL30lfc5OpveBTYdYqOwm
         02Jk1Pb1PREkk6n9DUpg8zXoN7LHdhbGCnx9t4O+Q437ruAEr7t36beUHgr/ZXBphcSy
         wrIg==
X-Forwarded-Encrypted: i=1; AJvYcCV7F52v9JIBy9lR57gfezbv407LByMPDRcKB+O2x6VfznNsSlNOa6EhapaHtYTPl4spFbbhbZU22DOxu2e4P8s9jiCH
X-Gm-Message-State: AOJu0Yz9zF5yH/kiThqfsBqu1VHtulfZCj9KXC7Ig897FUousyuUhQXY
	el3nbKpniyTwyeXH3JJwd5dewkySFRFQ13ohlGbDQIBSW3UyDw2t
X-Google-Smtp-Source: AGHT+IFySxCgwbmAFY/aMaC6bQLe/bNKfeCgLXmo0oszCZcFTyDxkgeCmsIXP7hY3gwIhtqc5i0Tww==
X-Received: by 2002:a17:902:d50e:b0:1f6:7f05:8c0e with SMTP id d9443c01a7336-1f9aa3b3954mr51863385ad.2.1718865968781;
        Wed, 19 Jun 2024 23:46:08 -0700 (PDT)
Received: from [10.22.68.7] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f40f38sm128827585ad.277.2024.06.19.23.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:46:08 -0700 (PDT)
Message-ID: <cfab6597-2c2c-4b76-853d-1b0dc13b8e9a@gmail.com>
Date: Thu, 20 Jun 2024 14:46:02 +0800
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

Interesting, same NULL pointer dereference causes another issue[0].

As for my case, when resolve_prog_type(), it has to use
prog->aux->saved_dst_prog_type instead of prog->aux->dst_prog->type for
EXT program, in order to avoid NULL pointer dereference.

[0] https://lore.kernel.org/bpf/20240602122421.50892-2-hffilwlqm@gmail.com/

Thanks,
Leon

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

