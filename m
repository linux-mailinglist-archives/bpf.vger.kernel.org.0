Return-Path: <bpf+bounces-57813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E96AB0604
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E139E1196
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3440229B27;
	Thu,  8 May 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idLdcqhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89524B28
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743923; cv=none; b=sC5kOFOp7SGiSxngfqy+qlmBNJUO7trHRzAhVDIXOw0Vhk2zNpCvsggksDdZA9H35KVR5j9bsttCEbinJJfC3JWQ4nXVYYV7CMCU1uXcCX59caY+iv9od3v8q0qMJs4N8p4CPjmd04UZc6z7cuvUIfCBuUSblPX94Rg3BRID6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743923; c=relaxed/simple;
	bh=C2nn5OMlCMUdCdYXzHJaRHMyEKyFHDjx0cGwKbBG3Yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbxwGcbVm47EVbXraIijN2EVpp9C7Tx4kTGvQvAx/sinWtP4IeeVTRon6CdU8qcQSkrzruOmIE6eUKkKmSFmEZQy0NxRNc6k0GimT5nbxSGiyzpEDfS7lYqjHquF5CU0yOA1mxM2RR4voHMqT+HqwyWCjbhbTjme8N/V3/PLnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idLdcqhG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30aa8a259e0so1505043a91.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746743921; x=1747348721; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RFH2AhEY2fUoSyw74myCVgc9Ab4iSFClqsq5AyK6AI=;
        b=idLdcqhG+JDUNsR7DkGE+SGbIZjCDoiyoYit+gDDYm7S79kznCqjg+Wi46X6EfJKLa
         E1XabzYZB2HI9xhSxjxhL/WXYt26Q6gZd48L7dNGmE7PH/CnHBbeLbXERppSYDXOnW7Z
         RvvuMwMDopj4cFnO9oe3rBeEfZfHLnj1fNuE0q2ip1S+rKfigHZ1d93bWlk6r/j6Mobx
         wrDj+UEcw60E0AxfrS5OQgSn108UpMoGmhgEI1iwsQGcX15dQBSMo0b6H0+zsypQ8Rtb
         CV4yeLCLD4YRRl6skOGCho0ketAN5DZjgBXS8lsuDO5gO6zeqebA2fOuZ4ijFQHUFhlx
         oZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746743921; x=1747348721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RFH2AhEY2fUoSyw74myCVgc9Ab4iSFClqsq5AyK6AI=;
        b=wDh450rCPTEU/Lk/BKo43PXZ/Kfoy0QZtA+hVv2enRFBCLYBUdsbtsQ5w3uawpRhiS
         s21kLLlzhN9XpPbG9tB5rvYd8dSdZyww2UVuLbAmMypM716XrvlmyafScnqZ51nSctzJ
         U62oaPJbGOr+d1KgiSymWU+xNcU+fyHKQ/sI5qhCY3hpCpGiG3hk3lbetQtR/7JlCFlc
         rA+NLK4YobaxOUp+zj9wqsku85YrQzO9ROq5EuCVWTLPcvDqmGfb2M8mf9qkcSQuMBAl
         5dJ35iUj1o1+CiEyiw+ZYrvGGctmXkyAJroC588O7CDieZ30ozT5+o56ZmzKcSYQ4l9j
         px/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRfLVbYl7AMeKhbME9f4IU8q/a4UH2WINs7Ha0aS5uUJG6EldwYggzLP1aDxhMnr7hydY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0tHZFeENjF6nme0Ymf0EzxCnGGstU9JBULpx2Shl1BRVsXSdQ
	zSCwIbpWMOJvrtcGgumRRKYKmVES9nzWEGojJdfuV21gptLP/j5Z
X-Gm-Gg: ASbGncs5S2qgjyTS3eD+71l28ccrL64uvjD+fcH+nPxpJp5VG2mwoBRy/yxsoBbkBuW
	L5WcHLIetT/wfneitRP/w26LO7Z4qLH3MHe3NjOmErH5WVTpVIphgbKze11d4Pr/jaPsICMRDlb
	+RZxg59PAKOCP/NYYltEJHUsQ4G6FP5VR/x199sgNO3Ws+WvZZMeseqatHKWhMwYmjOrtUsAgdt
	b2UQ170zqRSj2OB+fNlB3pX3InuzcYH8i5pgxX639a8Gb6Yw4Ai6E4CwIqb01SAp4Lpu1Ny7RJS
	F7cKwAUZR6XaWEbW92LMmjdiyoxYdmhe3V8o
X-Google-Smtp-Source: AGHT+IFWIS7d8ADdiDycTk/kZSQ7cEO6LMTL2ieXCFOeoYkP2qUYfV3yr/MFFI+02uAFm2jxdlHL/A==
X-Received: by 2002:a17:90b:4c84:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-30c3caf91a9mr2054824a91.4.1746743921005;
        Thu, 08 May 2025 15:38:41 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d2f1dasm2855291a91.17.2025.05.08.15.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:38:40 -0700 (PDT)
Message-ID: <d2d0c67e57cc14bcc186f4a5b744ec1a01630721.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/11] bpf: Add dump_stack() analogue to
 print to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 15:38:38 -0700
In-Reply-To: <20250507171720.1958296-6-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:

[...]

> +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +	struct dump_stack_ctx *ctxp =3D cookie;
> +	const char *file =3D "", *line =3D "";
> +	struct bpf_prog *prog;
> +	int num;
> +
> +	if (is_bpf_text_address(ip)) {
> +		prog =3D bpf_prog_ksym_find(ip);
> +		num =3D bpf_prog_get_file_line(prog, ip, &file, &line);
> +		if (num =3D=3D -1)
> +			goto end;

Should this be `num < 0` ?
bpf_prog_get_file_line() can return -EINVAL and -ENOENT.

> +		ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
> +						    (void *)ip, line, file, num);
> +		return !ctxp->err;
> +	}
> +end:
> +	ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> +	return !ctxp->err;
> +}

[...]


