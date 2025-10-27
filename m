Return-Path: <bpf+bounces-72366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB5C1139C
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FC43A8041
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE02302CC7;
	Mon, 27 Oct 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTbBK6PH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839318A6A5
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594048; cv=none; b=NlIEb/xHYqFanaZAE5XcFR3aZAFfdFk3IW5j0IGzP+lMUhL31XOOEviB09EHMdMxgMm2srd0xoszVNyVb4GSB8HKy2iACY9aV7iH4cA2yktygRigkM2jZPS2iSNEKyxtBR+w6IIShA2Ths8rjVKmDJGawj+vRjgvkmuEEi0aZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594048; c=relaxed/simple;
	bh=LJsc2dF401a18ttCGln4rv/KtK9MA6GnYaTwe6pSYCE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qG3o8IoNImg7Zf+JcYZfeQX/zmZ9qkDSOrn7zCGfSpw37RROvVCfQfZbnaFrIpTwkKibJrotGcslQVh1VYzvDyvMKGXQ5oF/lBUZELwISCItb5mzk+a+9OEikdJxEBYAlA/tZtpT1DIUGft665NE6MfghKIZLEajbus7QiWd1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTbBK6PH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26e68904f0eso55041565ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594046; x=1762198846; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYquFuM2DJku7BjAYv0r20xBxJ+mXs/GgHx2sVKAPks=;
        b=KTbBK6PHuKNjrmHY2fn/ttQ2gnhh7SK55pqbh/IBQ3W2Zn+aXOA6s2eLvpT65Mr21g
         hRE76RVsbCxY86X17XIKEEaqw213pel0ZyfqnfwHJzoGVEm6oG0jaNyUpeAVr+1lhjCb
         15IgMsfVIe6bwcF7HScgpKgOgXwwb//RyLIgZT+LTWfY4cQks5NQ0O0Iq4Uvq3ufUe0i
         kIjTuiIMe/sQMLJVEhALg1yMOq/ogPpp8nMt6RsY7lt1Y0+nR1Na41KtOZRNmkt1Dq6e
         KKVPn3jaJaAghV5q4K4RzOLwJMji5IsAtUJXWGAhlY3bTlFdLBKvK0BWPnQrEr3S8VFg
         QZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594046; x=1762198846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYquFuM2DJku7BjAYv0r20xBxJ+mXs/GgHx2sVKAPks=;
        b=K3WubcG5uN8fcoT4hxyNkBdaWkjK8knqUEk7wtsaOV3242KCUFs/Ncp5V5prm7aD7F
         OCxNGrUETV7xyH1z/+QNEc5exc4owps+gvgo2ZxTgUhr94h6XW3M/i8eFXJqjs/Au9lp
         eJSSTJnbud52piq7s9eV7amPPud/YEBEvhpxlB7iXHmI+Odxgp4soelofBOrMbbbKj8S
         jIee+9k35zEa5yvLh6vUq/6a70aWIKViGiPEGzUBiZYHPhqmxI/JlBnKClwZlo8ji9UJ
         xk7QZnKZd+PMlRY4v1Da+q11yQujkRxHCCNGug3AChogIEDERxWmZzWEPpzh4qOJx8J5
         UZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWehUNrZIpcOiPoVKmRKHQ7foFthRxtSE4i6w15NqJWEaKJsROd1eDRWGA5tSpQs+yAO/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3bIT4hKJzZw8fSjvt6HemJWD7S1gHZU9EPR/ddzkPz2l34TE
	A58vCUNrHEuuhRUbKTc/WiIMwc8IsMAHgP6/8duruIqhO1Xs2AJEyrGg
X-Gm-Gg: ASbGncsC2S+QfH30ojaYv3bvLkn4iB20w+SoZOJnLJfhLYU2aKZrtujfAcO5WXtuLI8
	fpm/iY37e3zqmjiz8r9rnO5X++t7jgSzJida1mUXmT0un2vZWzUdfnJL4AAavvXDy1GyKfizlvv
	8z11QF+TrSzhs6El1Ar4uDvss43rFhOmkFKrbYc/EvR3Dacr8CrMF36pw9VTfutvwCdFvGrxf3H
	jwSa4T0GrOsYDd+q2G9coVrnvQqu/lk76UMKoKQ4EKXCD9y4+q1OccFozBZ3xr6KTP+3KIjW1WP
	+GnQj5RFvAEjvRcm3Az93QA4RyG5KEpckaK2ELbZZI8dNkTYZl16D3gqhC4MDIhIVtcpfhoFriV
	99Ev/L6oKio8g2NYV8ipDs7wT8VuoC5q0UeqKZ3HBp4Y5QH0+uKQRntMhYFnl+mV+woFEio7hK1
	n6sx8aZ5jQ
X-Google-Smtp-Source: AGHT+IFlDwV56FqNaaR7GrdvETO82oysKmQtrwPBBWfO2vJ67aNk29JP9vzetVkVDQ18K8dgn7gLxg==
X-Received: by 2002:a17:903:244d:b0:24c:b39f:baaa with SMTP id d9443c01a7336-294cb65f7f9mr9917365ad.49.1761594045818;
        Mon, 27 Oct 2025 12:40:45 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed835e26sm9393463a91.20.2025.10.27.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:40:45 -0700 (PDT)
Message-ID: <3e3643bdbad74611b5c00bb2d5931647dc7b8208.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for BPF_JGT on
 same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 27 Oct 2025 12:40:42 -0700
In-Reply-To: <20251025053017.2308823-3-kafai.wan@linux.dev>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
	 <20251025053017.2308823-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 13:30 +0800, KaFai Wan wrote:
> Add a test to verify that conditional jumps using the BPF_JGT opcode on
> the same register (e.g., "if r0 > r0") do not trigger verifier BUG
> warnings when the register contains a scalar value with range information=
.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Could you please add test cases for JSET and for one of the *E
variants?

>  .../selftests/bpf/progs/verifier_bounds.c      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 0a72e0228ea9..1536235c3e87 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1709,4 +1709,22 @@ __naked void jeq_disagreeing_tnums(void *ctx)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("JGT on same register")
> +__success __log_level(2)
> +__retval(0)
> +__naked void jgt_same_register(void *ctx)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	w8 =3D 0x80000000;		\
> +	r0 &=3D r8;			\
> +	if r0 > r0 goto +1;		\
> +	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

