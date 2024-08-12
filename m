Return-Path: <bpf+bounces-36917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32694F60D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB6E1F22BC6
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BDD18732C;
	Mon, 12 Aug 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iycopLn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E925569
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484842; cv=none; b=sslN0QtzLNoF5FJXQSyLaroREvxaLyzDjknaL5mshSuoI1ddQJEfEC1o9rgcKuw+mFH2hU2WJYDEQmo0q+6qrRxBigf5V3gwMa4FBMvKH/CuCGk/eTebOkjp7qAQ35Xy4iBlU5igasZVjjssNvJPHcRhn3OWQpwb900b7BQiFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484842; c=relaxed/simple;
	bh=KAp6BkQ9zRz04N5I0j7jjOJCwNKNOYJqy7W29Bwa4so=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emIxlbCtWyNcsu50rXzbt8LziO8VieCFbbBfrapHA3JS8AozLhNle3xeNiMpLhxjkfOdI0r0K9DOS2KK5YGti5MsylEHbx57eWetdPAfW3mNnc/FIT8v88gUhB0cY9sPAgEldj/CdqAugSIn/++ExWAl5SN7dd3GN0rRBBtm2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iycopLn6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso3278827b3a.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484840; x=1724089640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1pGAAktAajbipJR3ED3HqOKMTzLW3w/FljSiuiBf5Ug=;
        b=iycopLn6SZD65Xiy45y3doNls+umLzPtfVdeKx3W6fdVH/CqkKRe4fhCji+Lima6SI
         a7EKpeXmVLRK5K4h8CtldPhQb0pnh0lgdinzF5SnBvMGYfgkTjmhGX30oE8DnvvPVZ+3
         Dl1JLJK0QN+ZALCeBybo+kmp9tLjJ2v9kw5TcKs2NubXOarbHaiIsVQQ++TxyPCq0+qo
         rzXxJGyrSAkBuxPeNEzPCcCgKbfvx9RGJJcPME3E+PqbgZP5HL51FzBCibRrmz3CIxce
         s2VEW2rYGoNmG1VCQfriGYC5QrkC6khha583L00SRWOO1/Tth6V2ywst/IAtGxPl/OOQ
         KOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484840; x=1724089640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1pGAAktAajbipJR3ED3HqOKMTzLW3w/FljSiuiBf5Ug=;
        b=hlfjq5KvXJxtk/pdhTzYaXMT9JcrmK7BXMZNIUfBRzEPkfk40V156YvVjPaWABKthL
         XQ9CFfD98heqdThxEr3PjdikLABqcGVZM0epc3J0VmYc5DffSWccfTFvXRdlQx6NgLlQ
         tXt3JkTocb61JWKt8v12ZOZh45x5I8xrhiTtcmPo49VbQ1OdN3EGf7UA2UabN37OeoH9
         1kIHBLfcBELi6tFgicIMZIyYx2idVPcoYRA7rT+UWoArir0bJw0Y+slyPKDY1Rcb3LwJ
         4Dku2gth32tnXhamiv539f7W3fFDio0jezeYtjyvE0IKjO6DvkHC1H+2jcyiDEPG0Ec6
         ScyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1xDsgod8lSwZvPFNGXpHueDPftqZNTr4LzsGPrm/kzbzaoNpoqjUjX6+sbGj613B3NyQcF7nN7LYW0GiH+DIB55Hp
X-Gm-Message-State: AOJu0YycJSD3cvA/lgTsRn8GN/HQa1L8Tg/E1FUApxP63L5Jug8lNz+w
	ltc5GaTs3jDL/toPklkPhQFtDgx8SG7Zh9KwtMncO22VIHi4V3Om
X-Google-Smtp-Source: AGHT+IF4BnFFh/M1VU+MQFPPWsrJBZmOgvWIZ1QRHo88d2CDQQGfEPbOV/Yx0m3p3ZOrOQFBoVsZmw==
X-Received: by 2002:a05:6a00:398b:b0:70e:a4ef:e5c2 with SMTP id d2e1a72fcca58-71255152768mr1047934b3a.13.1723484840214;
        Mon, 12 Aug 2024 10:47:20 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a8f22sm4268031b3a.46.2024.08.12.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:47:19 -0700 (PDT)
Message-ID: <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, Martin KaFai Lau
	 <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 10:47:14 -0700
In-Reply-To: <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
	 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
	 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 10:44 -0700, Alexei Starovoitov wrote:

[...]

> Should we move the check up instead?
>=20
> if (i >=3D cur->allocated_stack)
>           return false;
>=20
> Checking it twice looks odd.

A few checks before that, namely:

		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
		    && exact =3D=3D NOT_EXACT) {
			i +=3D BPF_REG_SIZE - 1;
			/* explored state didn't use this */
			continue;
		}

		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_INVALID)
			continue;

		if (env->allow_uninit_stack &&
		    old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_MISC)
			continue;

Should be done regardless cur->allocated_stack.


