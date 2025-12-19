Return-Path: <bpf+bounces-77159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D5CD06A2
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A3030C1636
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C033DEF6;
	Fri, 19 Dec 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh6FSf/t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4D33D6D0
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156083; cv=none; b=jZs1I0u9i2QWhBQ9xSboSzozxschmREtcQmP+CtehelaXlqv8IZ171q4H3QShE5cRW8LgQuND0P74K+hUbW4DOLWESVn2mQ1fe1PcbJo3fyot9HQrJxg25is8uyz4pozCT70Mx1VvtwskPGdr/IL/IWzAi2BYKViCqx4IKbVj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156083; c=relaxed/simple;
	bh=4Xdt/E0eKuLiqARs5/+NwNizpugYWI1QB+HlCH+SMbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDYZZ3R3RQFyhaG5LWNaIcfKY+Ln4AJnpCRnG6RJt6BiLuv8+nvPr68EflhYy69tR3Ln0M70J6jxIIDTfNTXDHRNfTLAcaHXqFuh/jLQ/OYle4F+1vlS3/bL/XnElHf1/bDfuojWTaRSS8ujlssrklQgRzMECxIZ/oR2HCy+nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh6FSf/t; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fb7704cb4so4675357b3.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156080; x=1766760880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDdaTMRRYAY1qSHlAuTYn+8+uE5UBoDcaSos5vnXy9g=;
        b=kh6FSf/t9mCFBt1iHZ+MlgKIXW7Yqb9pIOMPd9uAbrvR2sToE0IM56TS9Tf37eapb7
         CoWl2MxEX4Z8TSFuy/tEQJaJbXe8uJaC1yn1HqgcbR7C8wlAZXpeJe+QuDvz3dZTwMvR
         aYq+9nFZE4owwzz16bNlrSGcARiNU3Juen1CmiRxfck5Lsabm6n3J0UkW/djztFkyRKR
         O4hq73syL7UfsdILWPy57VSc2S2PzPSHb16gAUTFq6PEswB9jVqr67Bf/anil2iM5tO0
         Tk1MuD2+OPIXOFVNK+A0oKY2hXZmn3gYeqPlfrJGs71gN0J/8F27evd5L4saRJBOUONy
         5eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156080; x=1766760880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDdaTMRRYAY1qSHlAuTYn+8+uE5UBoDcaSos5vnXy9g=;
        b=TI0tT8rUSRpNf+cPMq4SNP9FvrX8ixnK7PiRW7puBc+a5sMYa+efl+wiDkNr5GJgtz
         gIz7CLDEN8CapMVTq6TX52rnO3rBQVHRPL0q74fd17mlyMNcgan9ojE5Mx1k6N4QTm/Y
         7+5DZbYOAtFLcWSvdMCwiDtRWpnrhy61Q/RPPRH2MENDmZ5nYYEsAI4h5uOH7ZrJZwmL
         SuHPEu98DzJKaE6a7uD3A4gWw4myCHd8uG15gLoM7s5miTjD9y0ASVXJse3EnXXuCFdI
         eM5ihkXg4IkIl75tj/J6nawPEuMGeGKu8ufCMJdeNgs1zM14KYHMm8r+5YhKcCkRsPkz
         AvxA==
X-Forwarded-Encrypted: i=1; AJvYcCWolDFM0ofkVAcFIc9yWCxOtwqkpY/5LaeRiXeWSe9OKodYzgPDRzvQUfCS5aw0dO757fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIypcfUZyl4CbuDnFDJhdOlOTYmemsWy/ZTqhhdzNRY+sd7DF4
	a22CvGcwc26iCRReVyU3lV6p77NJIwPOMEpLfEzGScQhtNXxOUtjH9XdhxPYlZGqvkA2IY5Zg9S
	sgZsUVW8zpUBmdUROK9SikIcnvL29m4M=
X-Gm-Gg: AY/fxX5I5rRsdbI6a2NK4/4pwydsjFOAmh5JaEK59CBElO8zhb6DH5bDpN5x1+saR2b
	tCI+NbPVGDia91/TV2neohGDhXneG2OFZdNApbRv4jEAlNx0W660UxbQS3qUDJaJV9euNBTM2tW
	AR4N4dnzHIpxsq+O0yyZoB+2R0CW+SN6JaKgsmV+kricowZCa4bgt1gtugAFOWNwiL6eVk7dVlo
	CRKWiDTIgz6+4r95b6oydrYHL8d8rVq7HaVtyG+dXWBqpzEQILtIj6Oq5chwBNwAcx63vvwxeo=
X-Google-Smtp-Source: AGHT+IEQpU2uHORHsSaJvH+4Kc5a7FmzNED+x1TC212I/IRWbm5lKmfSyUpFZx/jrL2TYMouTF4PT26t1Et1Fqe+jxo=
X-Received: by 2002:a05:690e:4184:b0:644:43f7:11b8 with SMTP id
 956f58d0204a3-6466a844038mr2341085d50.13.1766156080207; Fri, 19 Dec 2025
 06:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <875xa2g0m0.fsf@igel.home> <5070743.31r3eYUQgx@7950hx> <1948844.tdWV9SEqCh@7950hx>
 <87cy4aeg56.fsf@igel.home> <CADxym3Y098836fHHRSjeryxCp=CPB8sDU19TBBVs07VZOERJXw@mail.gmail.com>
 <878qeyedaw.fsf@igel.home>
In-Reply-To: <878qeyedaw.fsf@igel.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Dec 2025 22:54:28 +0800
X-Gm-Features: AQt7F2qQ1ufef4ZaQXp8N9zw3HgOD1aYzUQ6NsLMEQPkiIIuUt3G0BCDsWRcz7k
Message-ID: <CADxym3ZSHtqAn+_6pKEO+95tRp13eRCUuPqCfcM=xqMbhcf3PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, ast@kernel.org, rostedt@goodmis.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:50=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
>
> On Dez 19 2025, Menglong Dong wrote:
>
> > @@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct
> > bpf_tramp_image *im,
> >         }
> >
> >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > +               /* skip to actual body of traced function */
> > +               orig_call +=3D RV_FENTRY_NINSNS * 4;
>
> Before this line, orig_call still contains the same value as func_addr,
> with the latter being dead, so there is not much point in using a copy.

Yeah, we can use "func_addr + RV_FENTRY_NINSNS * 4" here directly.

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."

