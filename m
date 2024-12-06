Return-Path: <bpf+bounces-46328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21979E7B12
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62279282CB1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E01AAA24;
	Fri,  6 Dec 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQYoEGPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0B22C6C0
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520957; cv=none; b=UD9YeomaLdtfV4KS9EOgPmpjkcbyeTCvqmwRmWpKtk9+cH21/bVXe2fYhnmRTXKUsJs+OVbK140BlErz/zdEivV3AsZoF8Yl/amR3PfCHpIltQubGnnRaXtdNnbbvYFPBG7T4iFN75Oj0+8NQM+nGLhJXHKcZe9sbV8i8QdyAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520957; c=relaxed/simple;
	bh=g3CaoPxq2xrEC7tZ6bslU+5cHtGN3PTozZiPXZK4HYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9pzoov2kVv982c131H2N0Z7QWvujlOfY1WJ3rdbOuMK7UPrFlQY+Di/xXRdPyzgKzrt6/e3ootzYx2s8tU1k5y4YkN7MrVsY7ihVDGATGKGYIDKNdMG9wyhpnAjkcODIRieSa/GOXJruO5v5EE9y+YF5+NpJFdtdFAZuCea8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQYoEGPm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso1873408a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733520955; x=1734125755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFT7/2fYjhKbUoW933UAiLDDFWCMe4e/GFL9fbz9oAk=;
        b=ZQYoEGPmgF+GYjiSdJTLtWwF2AYCxXM6vTKYHsb5p3XSbqaQNJDKciRLZePGPiOKx0
         m0SjvmmTN0GByYGipxpQc3dlHX14F1gIRt7zHTyQScH2UN0Q0VeMwx8aqCdR4LM/gjvn
         PdOj0FWcEnjAJl+M8zrfduBdTp6wMqG4PlbG7Iwx88tcjjRjE1UpHSkMuEVtUzDuILAV
         uN5LLbgZjvszhPduXfB/YhOpufCYkcF9TDHSFsgDfKgosSGkMnC/50Zgq5i1hXeOEVBb
         FoxZbsUm+ruscUiTRA0wp66l4wyfdABzWEvjLp7JbfPMh9ZqNov9bkxN78v9QeEiaukR
         Hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733520955; x=1734125755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFT7/2fYjhKbUoW933UAiLDDFWCMe4e/GFL9fbz9oAk=;
        b=IATAG/0VGs8DYmMjsMSKOtIhyAQ0pX7OtTZwHL4I91eSzQh6BZW9W4XUTgA2/P5sAf
         6OBySJ9xfGfe2/qBeaCkQvVrD20RpFIHZRB6I2Wu8fmsGNDwX/So6ELxTVnIuXY1EcV8
         vDb+APOCB26d9GEeW6UJvyYKPGWIUpiDmIHZZzbhV0tnmFHQDgoIIFAkvtvEV48nIU25
         SppYsJDWgDeY3gdMVj4c9I+3XSz3N3o1exDznY6w79xGSUpT1kl5vh3H5lagXeAV+r2J
         rt53ifS1YIdDSS7Ydi/oNT3FBsK3fsVS2U5L5mNxmx5SKtlzTBPYp7c15hUyXs4hYJea
         sAjQ==
X-Gm-Message-State: AOJu0YyeVAek7PR2SEwd2cu5JWDGewNI1PJqIDm3l/UODgfovT2Jm3C7
	Co9ce5jiCgLA2YZlHPiGFbdaXfxVf/xgRrywkFGLf5uaMYV2jEd6
X-Gm-Gg: ASbGnctsN4vhkw2bS+2zhzY15ZZhd3Bj0gdQ42i4A6Fj077VK1azsPhS1CHnw7MhdUB
	9wcA2sOHut+TluzLjs5kRY1ni/h02XZ3NpFCuqm49rfXXRRUgxB6A9XEIqsPOd+MqfiWDUbcwv5
	7T0ElooUWhQApTn8kHtcHLUC0marhQdFdrLqQL3LI5LNwCikE/2U9odKU4io6lGZqeSTnWfP0cU
	VZlgcySO3zTwStI1CRxnOXwxF+/R8P0/eeNQzGY1MXzo24=
X-Google-Smtp-Source: AGHT+IEdRSJtl26VgXMR5yD8dQI7Bs24AxoxdbRNj8NjS8eJkGXSOLWbc8a/eRGlUS0JvRUDg4M32g==
X-Received: by 2002:a17:90a:da8f:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ef69e15289mr6949582a91.10.1733520955478;
        Fri, 06 Dec 2024 13:35:55 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef1e920587sm4567547a91.1.2024.12.06.13.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:35:54 -0800 (PST)
Message-ID: <13bc5814f88e2b3d5a39c4a71263202df397b65a.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Date: Fri, 06 Dec 2024 13:35:50 -0800
In-Reply-To: <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
	 <20241206040307.568065-4-eddyz87@gmail.com>
	 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 12:43 -0800, Alexei Starovoitov wrote:
> On Thu, Dec 5, 2024 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index f4290c179bee..48b7b2eeb7e2 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -659,6 +659,7 @@ struct bpf_subprog_info {
> >         bool args_cached: 1;
> >         /* true if bpf_fastcall stack region is used by functions that =
can't be inlined */
> >         bool keep_fastcall_stack: 1;
> > +       bool changes_pkt_data: 1;
>=20
> since freplace was brought up in the other thread.
> Let's fix it all in one patch.
> I think propagating changes_pkt_data flag into prog_aux and
> into map->owner should do it.
> The handling will be similar to existing xdp_has_frags.
>=20
> Otherwise tail_call from static subprog will have the same issue.
> xdp_has_frags compatibility requires equality. All progs either
> have it or don't.
> changes_pkt_data flag doesn't need to be that strict:
> A prog with changes_pkt_data can be freplaced by prog without
> and tailcall into prog without it.
> But not the other way around.

Ack, will do.

(Note: the change Andrii suggested with change to global subprogram
       visit order looks plausible and not hard to implement,
       after I though about it a bit more).


