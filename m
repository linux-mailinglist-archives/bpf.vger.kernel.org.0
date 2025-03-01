Return-Path: <bpf+bounces-52954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4EA4A7DC
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8936E3B4002
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948814B08A;
	Sat,  1 Mar 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMXOAs7Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6622087
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794967; cv=none; b=aXJYRlZqInneKJp4j/POfUdlVnvrRJkJOYMr0TfxP/LX2k4iYAl28apMGmb5QnjMN30Nj8pKtF6GLxIWMUuGEmvoIa2x7pQLQUegVOBqtBKR3L4nEBuyhIontRDWNcN36Ij8MBXBTKaV27pBneoFhp6h+4bPqd7/X8f9F9I4wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794967; c=relaxed/simple;
	bh=tFhCjnTsB1Qo6geuXh8lHChyOxsyyVOoK/0o6Mccknk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOhlh/BVkcvgQntr83LrkRr9n09PRInlNPTM3ZsSkiQrkTg0TvGShh89FkmKTKbqGeq/W66lKsdY0KQv1e4vVf3r2kVVTODzgRFkFFn3zzc0UVaar/8GFRCqUNUqS5k4g4y7ChW/DOKZeprZNuQMKbxH6zM/8QqWGVceqUqRZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMXOAs7Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22355618fd9so46538405ad.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740794965; x=1741399765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JlQA7HqddkTpjz5kgjW2/pkWvE3cJDTHqXtoNltT3xI=;
        b=KMXOAs7QyR6FP3JUSPZd9bUYY67+Y2uv507L1paaEX/lDcTGTOliVIFMGuJMTM4XTQ
         lurmS8l3aH2tPllmc8+8DUUTaXHyj9qk53djFZK+zI8F7PsZnf6tnebnb+vgSPEBzp/4
         UBfrdO5lBVfHEeKuRPyVfg/ryFxj1z5FHV3eXgIfaWHPlFrY+q4J+Wk8RadOvwuttzv+
         UcqJjlqEItn2fcA5mNb7GXJjnAuA/rwguySPQBMbsfbOLg47t+IAQBA81I/L9nOItLRG
         C5xdq7ow8CM/CROrZRFjWpCASwVlF/LMe1MsapO4LllaXjh+nGFopXHvVLJ55e/jxatP
         cqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794965; x=1741399765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlQA7HqddkTpjz5kgjW2/pkWvE3cJDTHqXtoNltT3xI=;
        b=tfal+/sn9urrSjCSoDKoxsqtQgFkYpBcoq5yJiwUznRNTU4WDU+QySssaYFPw9tpL6
         +DSkoBTo/eK9AonntH4kMqx5QtoAj9bk13Ryili6iUxTUG7GYrTMdMteOVlJINflHv8o
         lkT5qbcujgiz2XPIEncE3NKJVS7LwzWnoteVbNXvMy2ikd/MXKSG0LHDsWX1ErLKczBf
         eSJt511Vqh9oYcy955FEZ307CeklSOtXKKe01pxGX23WJJJ4h55foF0rUi6xTcZqZYI8
         GCqXKz7kguo/0MknUKhVStbvOQtkbuuJ8eITZq+mbY7nfjWTm0yOEZ8xdR8rw9mjU1iV
         Yu8Q==
X-Gm-Message-State: AOJu0YyJmz5xHcmUaZu7DV/7xDI4nRbTTgJZ/CdBp+SyhsPA1xgCrUph
	YnvPrr1DDddnQy+p4v9GgQrPh2LAy9508dI/GOTVV76AXrpRMXjn
X-Gm-Gg: ASbGncuAdsiJfMfZCywSIwXSI5m+EI0WqRjrpD4dae+12/uPXZhlciy6K7a1ga5Mf+g
	X/lrqPiR1ntyPzAHIVmhDtv0NpNOuvniPyz1bHnU2JgdQl7ETpv6HhKNbLHZNLqODF+dRpdSN8D
	FoAqwEe8ZIMqJ/5h6vP+gN+5DmalUAJe+z2aNjoKplHuq/pb34B/9bMN8tioGdOlI7IFomzcXga
	OUVv9hRdZLyQKwPGNzbxYsPYzD+bLbeqS22J0douBOcde4ssI5u9XBAS/7tu9gSlxnLNM96XALB
	yGKOaIGgTXgVHiQbAUlenDv8gJWBmLjbM/azhM9V/A==
X-Google-Smtp-Source: AGHT+IESQX3W0ev557G7Da5rh4F6jMY29LaDykr1cgDbvU5E0DUCMJZ0kDHg6aDE5ppgAEoE03Rx7Q==
X-Received: by 2002:a05:6a00:4fc8:b0:732:5a0c:c1b9 with SMTP id d2e1a72fcca58-734ac37ab53mr6985168b3a.13.1740794965215;
        Fri, 28 Feb 2025 18:09:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0060076sm4481849b3a.169.2025.02.28.18.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:09:24 -0800 (PST)
Message-ID: <a6fa86df063295d702365009bfd5936ffa5e083b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: simple DFA-based live registers
 analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Date: Fri, 28 Feb 2025 18:09:20 -0800
In-Reply-To: <CAADnVQJRFCn39RMPRydcopX-UY0h_s3AvCMhwcfc7YGQt-JcoA@mail.gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
	 <20250228060032.1425870-2-eddyz87@gmail.com>
	 <CAADnVQJRFCn39RMPRydcopX-UY0h_s3AvCMhwcfc7YGQt-JcoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 18:01 -0800, Alexei Starovoitov wrote:
> On Thu, Feb 27, 2025 at 10:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:

[...]

> > @@ -3379,10 +3388,7 @@ static int check_subprogs(struct bpf_verifier_en=
v *env)
> >                         goto next;
> >                 if (BPF_OP(code) =3D=3D BPF_EXIT || BPF_OP(code) =3D=3D=
 BPF_CALL)
> >                         goto next;
> > -               if (code =3D=3D (BPF_JMP32 | BPF_JA))
> > -                       off =3D i + insn[i].imm + 1;
> > -               else
> > -                       off =3D i + insn[i].off + 1;
> > +               off =3D i + jmp_offset(&insn[i]) + 1;
>=20
> Nice cleanup, but pls split it into pre-patch,
> so that main liveness logic is in the main patch.

Thanks for the feedback.
I'll include all requested changes in v2.

[...]


