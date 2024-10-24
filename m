Return-Path: <bpf+bounces-43108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD39AF52E
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784C4284E81
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208CF21730E;
	Thu, 24 Oct 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQxQU0SO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9511C4A32
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808245; cv=none; b=kwMFYr5/O5W3CdyGdodg0WKldpkhzCivC+6+4q3CEQyzOOQ0YR23J9wgkOyexnwoS4EvScozOJpEraG0gYA5/tkNV7HtNkF7Wuy9PyFn4HSFOmT52R7yNEI8j21IBAtmJwkpSBLexPvbsmu/EdPulo+NdMudeWFI0Gs9zbs2vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808245; c=relaxed/simple;
	bh=W4bfwRrzCBnQHmrhUv9hcc1fJMAPjr/uuRMB/108E0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoHZx/aYHL3WkRC5sHGUfdSmCizUVdKgG1rxN9zVoOS5Ksf1+jC652x0BWY85DyiP0xcJ5HHsFNJndaV7b11iDXkyKBH8mgZCNnS1j876dlLyk7l49GJp4nip0+QDAmx8ryzd6KRYWjyFrd7NONOkz5yep2cENf5Pon50KWsG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQxQU0SO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso898384a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729808243; x=1730413043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8ijUBc1Inw+n5nB0hJ/zHJWvLJAHovAwG0UoRy++IM=;
        b=JQxQU0SOIJp18HkxX1gTkX+U7zUhuY/VWlxj+yjiSNFmLDgmU3PIMj3Zk5OYGVDtDQ
         AjdyVtyha2YQaHLvOmRcbJEHnU045hnnuaqfLVAG+6JksnvhF/7EWHIKgttG6w+2ZAuN
         JZ3NGwrZ+SKFsPQeFoW9/lvYOB69glM4VJLufQVP+zna3AsCOC7w9tlGRasbIy3QO91S
         gR0FbWAhDnPeQuahSC+PMfeddoHuGZzrQ7x3Y5y6W05IQjQ/vIZxaafZoDjJM5B5Jp3r
         QiKE9+z5I+fx76Y0AmyAlrISa2ZdKwhoxF482T5tew6XWHrQ2vkoS+0qzSv+N/Q0Ck0V
         Imlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808243; x=1730413043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8ijUBc1Inw+n5nB0hJ/zHJWvLJAHovAwG0UoRy++IM=;
        b=N6k14j9itYoCNYREP72cqs6his4whX8gAiqFdYbJakEGuWE0SF7E+wShU1qKxJhIHX
         WwrdQ2ngTNooV6hJPCw+blFTmob+ptz+anfEEcVJzCvVWSRhtrjA3f8qtl3zMpumJI45
         sRKDfQrRZl8fYZcOZoNdINQYS/jiFD18SoztMfBdY8JUUPcjiJWTO4zYJNxkzXj/PQDs
         WYpAU4FSlV4No+IoEibOOdW7fPX9GwWVxZP8niZOKuiciRwRT869Xf8b+5kIref22qLP
         mnunuT9DZCKBJMFlwVMmJJiBQwMNjSIoBINLEq5X2WvzCnF/TGZOv8+Eshc8JKkMbdm7
         PSeg==
X-Forwarded-Encrypted: i=1; AJvYcCXgxV8vJq0+BloTSZfQhIuRzgJgquR+Blt3EL2fKGaZKNVVLx3xmy0dUEUlTWz4AY/bPW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/vHn1+IhtiH9obztr7oeIN3np4yli92eGd2gVZ0HHhJZ5/x8
	NOsI5i93lJo7EWxvEp80jhI88IRqv64w2TVHUiRXQnVmcoGAKZNP
X-Google-Smtp-Source: AGHT+IGW0Hmh6XagoPV4JIUbKe4aq+sjQYNDHXFYf4WkaYxbgJzAkoWrwRBwfjLPqa+XV1JR+Ts59Q==
X-Received: by 2002:a05:6a21:680d:b0:1d9:9c6:5e73 with SMTP id adf61e73a8af0-1d98894f6a1mr4945495637.17.1729808243090;
        Thu, 24 Oct 2024 15:17:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d760esm8427876b3a.108.2024.10.24.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:17:22 -0700 (PDT)
Message-ID: <3f6d2d9c7699a0bfcd245149502ed1c8945ac334.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Vadim Fedorenko
	 <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Date: Thu, 24 Oct 2024 15:17:17 -0700
In-Reply-To: <CAADnVQJnM5uu-Nu-okWTwDvbPQjiYTcVrX0mmP-JUhVOFxWDVw@mail.gmail.com>
References: <20241024205113.762622-1-vadfed@meta.com>
	 <CAADnVQJnM5uu-Nu-okWTwDvbPQjiYTcVrX0mmP-JUhVOFxWDVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 15:14 -0700, Alexei Starovoitov wrote:

[...]

> > @@ -16291,7 +16292,8 @@ static void mark_fastcall_pattern_for_call(stru=
ct bpf_verifier_env *env,
> >                         return;
> >=20
> >                 clobbered_regs_mask =3D kfunc_fastcall_clobber_mask(&me=
ta);
> > -               can_be_inlined =3D is_fastcall_kfunc_call(&meta);
> > +               can_be_inlined =3D is_fastcall_kfunc_call(&meta) && !ca=
ll->off &&
>=20
> what call->off check is for?

call->imm is BTF id, call->off is ID of the BTF itself.
I asked Vadim to add this check to make sure that imm points to the
kernel BTF.


