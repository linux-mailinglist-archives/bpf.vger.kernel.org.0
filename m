Return-Path: <bpf+bounces-51980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1813A3C9F8
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC01C189C105
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B02405ED;
	Wed, 19 Feb 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0WERSry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85023C393
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997258; cv=none; b=pUUV8zseO6m3IMjiBkLvOptF1CkAQetWoTIoSjFEJirtg39GNOFvEqYkipZfJCKT1ZiT9QCYJL1UOwQXixy49oK2SlOudBFcb4zzlqnycRD52/3U+ruV5mEKOaVNJhyizjZLRVW6d8y9Xc8rr0SM1JDiPp5WyoH09wjN0qMNlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997258; c=relaxed/simple;
	bh=KtewpFn+bhfpo3FEfbOseIdr+u5cOJw2Pp9NdUtngv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc2Zu7aFSZPv2SbVSzfSnDQM5CNFnOsSc4J5rFHzOigHiYUXnbIcUDz/SxK2FKirZX7eN3o5CRnDNUeTlELpEQdDUY6sPhlVWE2pzdCejgoskaKAcDoOmz2g/awDkheUL/4O5tOZPt4fJKl6eNN4Vc0x6Raw1zh8eVejdy1KyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0WERSry; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso2753715ad.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997256; x=1740602056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAHlHpOehAZ5qwGlaL8SccAJZ4Nk164JtVjyvrHUlLM=;
        b=O0WERSryKBT1UTBpJ11mXVFKfFrPCy+B69ys/GMHrRnvSm4I6mA9SpE5QmlrN9+Pp7
         ZLXjmNB/dlHfMRQwHmyEnkrmOTOl4LPzTZBzfbcDjBNpNqIn6pN4kOV4uIpIQRyzh/tK
         2qgLcGuZ6jmPv+9iC7iM43lY051ovJs/O4Xep3TyGdJfpiHqOQFXJagzykaNt1hXTh+G
         aQykrp8JXlTujNCvyIKzFs94r9t/t1D9ZNrs8oap6j2PI7+xn19FSkRQFFh7NqjWATpO
         jLn9o4FRaYYPeKTfgSG1wc2Gk+sFoK1yED+WO4TxWoLXaE57oYtAri8CM7HedssHboLn
         cu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997256; x=1740602056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAHlHpOehAZ5qwGlaL8SccAJZ4Nk164JtVjyvrHUlLM=;
        b=rBUSPMKXZcD+L4K+jBjjt6rAuwf9z1YeLTWR6qmFdECYhSQQ+4zkAKVrCNsqmhN5AV
         xUfnqqKJWyVotY1vUaCEMPYCkJEIiKet51bgz/h7b/RPkY81HIwDy3DE1SfmoJA54/hV
         w2oeOTbjBXp9940Y9qTJ5w69dKhcByUSxdL+UEAMtCrtFcHIDim0bQe4D5TR16GCO+WT
         cblJxn/GPPwsvn210NjLr0IAArt1SXwvDzR1wHaef6pMgJU03OSpKqjPwNV4yo7rweBS
         GC9zLRJ/3vygXG/f8uEN2kU6zmzuwpOtsMTR6sPu6cEU19mpPHpBRdhaB1q9ksAqeWqh
         eYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJg+IQc4/Ymema46tBcEvZY6vNBPejrgdbX7NA9W3tHYaMYThaWx67g7So7s8qsQqB5TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3J6w7+PqOxzcW7qw60ZvA54SQXMVOHYSpmfqg+piGhi34VDN
	WOAZGZRfTtfS1Vx6DgmX4UoEh0GiTCGfraOl+YaKsXhUxAn8MgPD
X-Gm-Gg: ASbGncu7mM0Ov0gol+ZQSbarLhz1ldwqTw0VkhXNpbC3Bzc+TTvOOSL9MGEetB1ZJOz
	wOqWN9GbOaziMxfRHXAe4cZzoiZfhK13wezgalCSSFXx8duRhFpqAf5OkjvMQPCqfePVHTTGbZP
	xT14+BBwkoHK3NA8gCzO9YPN8zlB2PtXorP8yUsKp6luDaffLWSp/b8jBafniCh+rhrfp4E/Ozr
	/MZTwxSrhvRDIfvJL1WF6tsmGXBjlHero+ZastuYzHX6onm6uFpY6NhaO0oqHsj3GNLIpeFU6dX
	yRhDsF2f+mkx
X-Google-Smtp-Source: AGHT+IHf3KAiRCGDl7OEWH/N5ZhRPOLItSX54ZX15EztKRvxozvmeK3TiGJxlRaBsYHTAlW31rPpAA==
X-Received: by 2002:a17:903:2446:b0:221:7b4a:476b with SMTP id d9443c01a7336-2217b4a4a16mr39209025ad.25.1739997256493;
        Wed, 19 Feb 2025 12:34:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2210005641dsm80474235ad.210.2025.02.19.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:16 -0800 (PST)
Message-ID: <a6c6f04bb895c817c0ae06ba8a7f5b05ec3cad2e.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 2/2] selftests/bpf: Add selftest for
 bpf_dynptr_slice_rdwr r0 handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Wed, 19 Feb 2025 12:34:12 -0800
In-Reply-To: <20250219125117.1956939-3-memxor@gmail.com>
References: <20250219125117.1956939-1-memxor@gmail.com>
	 <20250219125117.1956939-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 04:51 -0800, Kumar Kartikeya Dwivedi wrote:
> Ensure that once we get the return value and write to a stack slot it
> may potentially alias, we don't get confused about the state of the
> stack. Without the fix in the previous patch, we will assume the load
> from r8 into r0 before will always be from a map value, but in the case
> where the returned value is the passed in buffer, we're writing to fp-8
> and will overwrite the map value stored there.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index bd8f15229f5c..4584bf53c5f8 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1735,3 +1735,48 @@ int test_dynptr_reg_type(void *ctx)
>  	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
>  	return 0;
>  }
> +
> +SEC("?tc")
> +__failure __msg("R8 invalid mem access 'scalar'") __log_level(2)
> +int dynptr_slice_rdwr_overwrite(struct __sk_buff *ctx)
> +{
> +	asm volatile (

Nit: having a few comments with equivalent C code would help
     understand this test case.

> +		"r6 =3D %[array_map4] ll;			\
> +		 r9 =3D r1;				\
> +		 r1 =3D r6;				\
> +		 r2 =3D r10;				\
> +		 r2 +=3D -8;				\
> +		 call %[bpf_map_lookup_elem];		\
> +		 if r0 =3D=3D 0 goto rjmp1;			\
> +		 *(u64 *)(r10 - 8) =3D r0;		\
> +		 r8 =3D r0;				\
> +		 r1 =3D r9;				\
> +		 r2 =3D 0;				\
> +		 r3 =3D r10;				\
> +		 r3 +=3D -24;				\
> +		 call %[bpf_dynptr_from_skb];		\
> +		 r1 =3D r10;				\
> +		 r1 +=3D -24;				\
> +		 r2 =3D 0;				\
> +		 r3 =3D r10;				\
> +		 r3 +=3D -8;				\
> +		 r4 =3D 8;				\
> +		 call %[bpf_dynptr_slice_rdwr];		\
> +		 if r0 =3D=3D 0 goto rjmp1;			\
> +		 r1 =3D 0;				\
> +		 *(u64 *)(r10 - 8) =3D r8;		\
> +		 *(u64 *)(r0 + 0) =3D r1;			\
> +		 r8 =3D *(u64 *)(r10 - 8);		\
> +		 r0 =3D *(u64 *)(r8 + 0);			\
> +	rjmp1:						\

Note: 'rjmp1' would be a global label.
      An alternative would be to either use 'goto 1f' and label '1:',
      or use the '%=3D' counter: 'goto rjmp1_%=3D', 'rjmp_%=3D:'.
      These would make label names unique for this inline assembly block.
      See https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Special-form=
at-strings ,
      And https://sourceware.org/binutils/docs/as/Symbol-Names.html .

> +		 r0 =3D 0;				\
> +		 "
> +		:
> +		: __imm(bpf_map_lookup_elem),
> +		  __imm(bpf_dynptr_from_skb),
> +		  __imm(bpf_dynptr_slice_rdwr),
> +		  __imm_addr(array_map4)
> +		: __clobber_all
> +	);
> +	return 0;
> +}



