Return-Path: <bpf+bounces-33670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37679249B3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E56B1F2290D
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62B20124E;
	Tue,  2 Jul 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcv5WdjR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B91CE084
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954345; cv=none; b=FulrMLe7Z4cpfJPMsodxf0KMCuSiRsxAcWENaeUxAeLBheo3aIo1acaDTEU8BdXWOi59dt0108x1cCRdqnpejNSn9qQG8F8kQQQS4st+ROtA/DFa6ab9NPONsYP/AGmWOByIwvssB+SImIgr/H8WAKWAwFmdbELpfWkvSy+h3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954345; c=relaxed/simple;
	bh=c+CBIyUjI3HWsRVbFtKmBrlIK0sDcTI1jVocTB9lwaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmUkQn1Xv/8gvY1/F4id38nsOtv2TeV5tO87QxUz4OmN21brN4GdxnpPOKW0GM85ud8F830zk8is/dmJsgvviPptx7S/Fd2q+l+Doh2OhHXGvDKYMkM+6AYg5/o1keij65KZfNXhUS9CxpYWN8JXuce1WtB1xxRSYDvbR2EpNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcv5WdjR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso2734191a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954344; x=1720559144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zrn/6obpPaLjgUjx8o5cba+cvGvM9NUMugERWMwuffY=;
        b=Tcv5WdjRFZGap8FRIJQ9p3xqWJwLw99JtwYzc2zRphYNSYwSTIMSF4/OJDV+WbMw3a
         pbxSVewUYDV5lk0dm2+n70ChSb0y0/61rxyekyRTeaxFocvTKui267VFOjjak5nM5m12
         HpBB8Pdh+qkI0NTBAc99lP+8H/Ah9CZI4931x/UBMTJm/n5icIKbcmaq53WJJsB0S3LN
         FOomEr3yHCXR2DN6M/WCS9RZjgNmxpnkDsLb3b3JgfA3gOpdHa5T17FBQwixxv+U+ovc
         reA1Tmxq6/xekD/RAm6X5T/IupCyed/ly8Lsk2RlcajzLUr+yWrP5k7EagCx09qw0cz/
         BNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954344; x=1720559144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrn/6obpPaLjgUjx8o5cba+cvGvM9NUMugERWMwuffY=;
        b=NZB14yq/BNYYOLnSYviq68lYNfA7KD+BxYDQVL9zJTjioDakp+nKtaFoAdO+5ACbro
         C2X86/NrVgI6Jh+EZGwSH6rOa50fsKOmktYa7R54dBXq31ruh2zapMbXzD98P+e6x7bc
         DFZeeQ66a8gRLFRftnLB6wIHHU6hPQ732or+YEZ5vjppgGrqTFu0k26Y1KV/7q8UUScb
         eIKJHaPQIb/p3u4j/gO3k25rmwP+vaoWyc329WsXs6dwsNZj693z0aGMtZ6H9iX0QrHp
         8+9Zu2L0PJOoiX5tHg//W/it7QtOWqA7nmcc8LIaIUiD/85cIC9d8dwPk+zjbPNo9xDQ
         4stg==
X-Gm-Message-State: AOJu0YxmHhyZQemhjgwBKEUKHIxTqmOcbITTZdwbSGJ3tul+z22rxpMo
	Ilc5tl4iD97id3/uvTGYI0Zr+eLTuvyAwP5oLRiJZQjj9xYIBLzRTUKOkA==
X-Google-Smtp-Source: AGHT+IHdWAQaAUwfRQAu9qSDQH1W5k6eeIF1RqVnbbao5YPtnSqIdpSBcM+ix+cNBnrUZszDOeIv8A==
X-Received: by 2002:a05:6a21:789a:b0:1bd:8582:38e with SMTP id adf61e73a8af0-1bef61ed2d1mr14115881637.45.1719954343633;
        Tue, 02 Jul 2024 14:05:43 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802959452sm9234351b3a.90.2024.07.02.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:05:43 -0700 (PDT)
Message-ID: <1e6f66cc6bcd80cc636206b5948c3a03e455711a.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 5/8] selftests/bpf: no need to track
 next_match_pos in struct test_loader
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:05:38 -0700
In-Reply-To: <CAEf4BzYeAG7SFschgypp3WHcQ2B4uxY4-euiU_pXM4s9dfHKNA@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-6-eddyz87@gmail.com>
	 <CAEf4BzYeAG7SFschgypp3WHcQ2B4uxY4-euiU_pXM4s9dfHKNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:

[...]

> >  static void emit_verifier_log(const char *log_buf, bool force)
> > @@ -450,23 +449,23 @@ static void validate_case(struct test_loader *tes=
ter,
> >                           struct bpf_program *prog,
> >                           int load_err)
> >  {
> > -       int i, j, err;
> > -       char *match;
> >         regmatch_t reg_match[1];
> > +       const char *match;
> > +       const char *log =3D tester->log_buf;
> > +       int i, j, err;
> >=20
> >         for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
> >                 struct expect_msg *msg =3D &subspec->expect_msgs[i];
> >=20
> >                 if (msg->substr) {
> > -                       match =3D strstr(tester->log_buf + tester->next=
_match_pos, msg->substr);
> > +                       match =3D strstr(log, msg->substr);
> >                         if (match)
> > -                               tester->next_match_pos =3D match - test=
er->log_buf + strlen(msg->substr);
> > +                               log +=3D strlen(msg->substr);
> >                 } else {
> > -                       err =3D regexec(&msg->regex,
> > -                                     tester->log_buf + tester->next_ma=
tch_pos, 1, reg_match, 0);
> > +                       err =3D regexec(&msg->regex, log, 1, reg_match,=
 0);
> >                         if (err =3D=3D 0) {
> > -                               match =3D tester->log_buf + tester->nex=
t_match_pos + reg_match[0].rm_so;
> > -                               tester->next_match_pos +=3D reg_match[0=
].rm_eo;
> > +                               match =3D log + reg_match[0].rm_so;
> > +                               log +=3D reg_match[0].rm_eo;
>=20
> invert and simplify:
>=20
> log +=3D reg_match[0].rm_eo;
> match =3D log;
>=20
> ?

The 'match' is at 'log + rm_so' (start offset).
The 'log'   is at 'log + rm_eo' (end offset).

The brilliance of standard library naming.

>=20
> >                         } else {
> >                                 match =3D NULL;
> >                         }
>=20
> how about we move this to the beginning of iteration (before `if
> (msg->substr)`) and so we'll assume the match is NULL on regexec
> failing?

Ok, but this would require explicit match re-initialization to NULL at
each iteration.

[...]

