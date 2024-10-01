Return-Path: <bpf+bounces-40692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB298C3FC
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317C41C213F6
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FFB1CB518;
	Tue,  1 Oct 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbYGq5ST"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FD1C5782
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801675; cv=none; b=MzGxXfqL0CmZ/mWZoxTiYnvvV3RH6JgX89GHOieNNrYywUrt/VEww0G4QIvvp2rhCNG0PeOj1pNX0i4TArxOedFZGNvlpoW0Avg+fTmkfifOc999jqyMMHBvhFxwOFStDI26NwWstTvbjAhx7xZBn2t2bPd13IV+51Z/mAu72m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801675; c=relaxed/simple;
	bh=spcG661xJtX9dOxeGyghD3KcINo1HQqfgXhzoH2Nq/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eymWVP8a+vmZgLFBDEma5bV3pL1wu5jowNCkjmSIgEHcRidJCFKTYyNdMm/ZTmmIyIEWn9LXgT2v5/cIaD8TeJsYpiGAeDI+X1OhdzK5MNWb6R8iF3TxgwDEaxJq4tm53PEvsrmOqGm9uGHoy+gD5gqN4lbnv4bXdESjieE970Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbYGq5ST; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-717934728adso4498432b3a.2
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801673; x=1728406473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZfJSeHsHTjz2Hu0u6hzipahvCQAu626nlWPPn/DOSpU=;
        b=AbYGq5ST+OkEruGoty5DRPBOpL7PYx90hiBvKmtJd2q1+J0Gq+0WvSsio7lBU7KqqB
         664NbaW6sAKOHwGiVnpb152lup5HEaGEzYXSE9Ll7ffi8fJuR3eQOfNsrC5wmp4EnkQJ
         C8/Jy3z2r8Zsi8RSQzGkMKseKyppApH9hV1bdSKhuW81+lwYLR8NRMht+BzJuX5mbCbq
         FkVOxyV+3O15O8h2vTY4IzWTFl6quoFs/KF/qoSz4zS70ekEqwiNZ+fpl1vEsYhaWV41
         SWuo1N+/D5dXhjNIE6Jf2ABaozpUPDIO2gqaFAMsfh2Zlgenj+BrPLEbTiUY8YLAh3tB
         nUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801673; x=1728406473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfJSeHsHTjz2Hu0u6hzipahvCQAu626nlWPPn/DOSpU=;
        b=PQW86ete27468HSC52RjZEIkwgR3iSEvEbJVd1mXlShyX/WbAc6RVP9rJrbM3BUmc/
         IEEbUmzeXQN3vPYHU2XpFbJJTd544yIEKBg4j9zis/07uRCvqpIJ31dkjGno0oY2Mdq6
         ODaigJMpscqjM3ip8G9H/KWrKP8q9+vxAtV5FO8P0oxExKJlRBUaoOASvQH2QbW7BBYo
         +FQGcT1mvBjUvOzYi8dfwRj2SjGCeuwHpHpST55i7Sn3TdPmUm6iSW+6dXB3YHO7UROW
         24TjWLIs9lR1imSzqjLq3/BUpWGO0Py7j3Qt9ODKhrWTGtz7+I4tq8Vqakc7A5QZIynL
         ZzxA==
X-Forwarded-Encrypted: i=1; AJvYcCWDsTmQZx7HOr/8veeaztBb33VUZynd0WxF/xASOVaGy0jnhF89qEcFYUvwHDCGLR556AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQW/maPKPYSYPkr4oMNQZAM811TGAklHMzhYSqRAYY8gqc/JY3
	7WYpUgO1FFcOnTRqLWxnTOxwrWJhHsdAF40IGSEczxLI5LgzUn52rr41GKEk
X-Google-Smtp-Source: AGHT+IGWuKij8b/2L5bCcfM0/mpez5sl+hNiZSJUWtZ8x3sdmxiP6SDaEJXWW6P8u1wWrrJVh6mJTw==
X-Received: by 2002:a05:6a00:14c8:b0:71a:fbc6:28b7 with SMTP id d2e1a72fcca58-71dc5c4c332mr593668b3a.4.1727801672953;
        Tue, 01 Oct 2024 09:54:32 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dc448fd26sm438586b3a.186.2024.10.01.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:54:32 -0700 (PDT)
Message-ID: <c748f0687e197894d2e0cc8d7d9314ce9a69fe6e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Prevent updating extended prog to
 prog_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 01 Oct 2024 09:54:27 -0700
In-Reply-To: <57d535b9-1229-4048-aee5-7184c2ca9e9e@linux.dev>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
	 <20240929132757.79826-2-leon.hwang@linux.dev>
	 <916f579cce8397b45790b1db68ad2a61cce4dfd8.camel@gmail.com>
	 <57d535b9-1229-4048-aee5-7184c2ca9e9e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 21:20 +0800, Leon Hwang wrote:

[...]

> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index a8f1808a1ca54..db17c52fa35db 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3212,14 +3212,23 @@ static void bpf_tracing_link_release(struct b=
pf_link *link)
> > >  {
> > >  	struct bpf_tracing_link *tr_link =3D
> > >  		container_of(link, struct bpf_tracing_link, link.link);
> > > -
> > > -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> > > -						tr_link->trampoline));
> > > +	struct bpf_prog *tgt_prog =3D tr_link->tgt_prog;
> > > +
> > > +	if (link->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
> > > +		mutex_lock(&tgt_prog->aux->ext_mutex);
> > > +		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> > > +							tr_link->trampoline));
> > > +		tgt_prog->aux->is_extended =3D false;
> >=20
> > In case if unlink fails is_extended should not be reset.
> >=20
>=20
> Nope.
>=20
> In bpf_trampoline_unlink_prog(), 'tr->extension_prog =3D NULL;' always no
> matter whether fail to unlink.
>=20
> So, it should reset is_extended always too.

Hm, you are correct, sorry for the noise.
It is unfortunate that these updates are separated in the code, tbh.

[...]


