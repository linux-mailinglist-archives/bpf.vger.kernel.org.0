Return-Path: <bpf+bounces-33677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2619249D3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12B61C22BF1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B018201270;
	Tue,  2 Jul 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re1h9MvT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34861CE094
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955112; cv=none; b=nNYoA9sl8hp3cn3SRdNMQ41egzgl7ZGr2WhtskfxjAq6M7+BknVGuZqrfy9T/uswXqWMfdyF9PgskCPxfmDoYD6LZ9UPMqvJIqWZi3+MavZIk1PmRg0lQv+m8L/KqCZ7Y32PurTVYkNmdbooq7BsdTjrG9XcE2f3uomWvFJFlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955112; c=relaxed/simple;
	bh=tTuoqcAlfcRC58bcUMyHGukHiyTmK1zAM+OHq0NMots=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRmLCDhm4gSqs8RSBbP7xLe8CDHMq1v3G+znC5NlLUZ7n3Fbd0HXH/iwY4Bpj+/0OoUbxFfIp8YAvweKFBj/PiHV/sr2tbPqKgnzyKY1Zj6/taEX+np/gY9Y080dn1XiI8wZc5cpamB34V7FqY3yEXiANMB7qBctGkirZ+lx+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re1h9MvT; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700d3ffc28cso2665407a34.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955109; x=1720559909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB5uVfe2p8JxirLdu3TklbrBF7qo1FXZSzlH2o2bggk=;
        b=Re1h9MvT6tLvPG/CRFgrAATJcwcyL1l14xgd+O5WOAE91g/QONjNYFcO8xs6Nl3Ylg
         CuSJYGq4nsUbqXlvFC4de9ty+G1h2HLy4j10ePotiI4L7t3fjnGiIOVpIihAEYbWBw8h
         ZH3mmn4HGD1llhFfbn7iFvkateyMRds82AqqiN19N9OcIFlhiMEi58S4XO6gmIAF5o9/
         XJH9nFdlrc1lBTP9LOpoguWPVNpeSitECSW9r+9Wdda455GIBtedqsKShk7K2aidZb42
         RTXrN348p4ETzDwiZUWIF2DCJPQM7VKT2MzIvtxNv0JLy0hM/ZZeTA8bpSN03zWFQBNi
         Twfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955109; x=1720559909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DB5uVfe2p8JxirLdu3TklbrBF7qo1FXZSzlH2o2bggk=;
        b=IgmWr2nJGjCFaL90RiZOxVfc5gFtTSxWQzobMCl+heAL6NdNdb2BOI50qdQKi5XrIz
         mhzi7wUTSfvd2nf5RpedIriM6btZ1nzfTmhN7Uz/bpLkAJa+M+noYvA3Jkwt2gjInjHL
         SMJHTeLckf9AR3MMbkOwni5Ge+Bx0lj1f0Alwb1FInxH5ddiNAwWDqc0iBtC/oAFI3NB
         LNB46AefUMoD7CKsNEupgYMtnsKYSua9h2dm+RWlsm16jBZHoN0om4W4ppxpsxnzbbXp
         q3wLgxfq+RKy9kmCghuBEv0Dqk5x/zXqr1BTQqgyOwUlpgf+hP37EmVfhrpI4VizR3Pn
         4z0Q==
X-Gm-Message-State: AOJu0Yzo3hgP+oQwWQvuRX/yOTxpy6D3OCqifVlZ7Ug2I723YeHpncLk
	9FOGU6DYeoIyfbpHn37AVuGiGgMg0eWNXaAsdS9tLs8SC7zXHD9kwLxDHJdP7RJc4WgrpExwhYB
	oeQ8VARQ0UtEHuvflQaJAohw0OCg=
X-Google-Smtp-Source: AGHT+IEbQK4j/5nazQAv0qg8/u3oNrviTRiAYsLNrf1n2im9LiD/xrCwxO/2avY+CWcbPaPeLuy4wY3YuWR/mC7JLWg=
X-Received: by 2002:a05:6870:638a:b0:25e:56a:9669 with SMTP id
 586e51a60fabf-25e056aaee0mr1166354fac.4.1719955109604; Tue, 02 Jul 2024
 14:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-6-eddyz87@gmail.com>
 <CAEf4BzYeAG7SFschgypp3WHcQ2B4uxY4-euiU_pXM4s9dfHKNA@mail.gmail.com> <1e6f66cc6bcd80cc636206b5948c3a03e455711a.camel@gmail.com>
In-Reply-To: <1e6f66cc6bcd80cc636206b5948c3a03e455711a.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:18:17 -0700
Message-ID: <CAEf4BzbvB9st=qz0tvHWGpXWDaRRRWhOtYsT2ibHJcgf_zwp4g@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 5/8] selftests/bpf: no need to track
 next_match_pos in struct test_loader
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > >  static void emit_verifier_log(const char *log_buf, bool force)
> > > @@ -450,23 +449,23 @@ static void validate_case(struct test_loader *t=
ester,
> > >                           struct bpf_program *prog,
> > >                           int load_err)
> > >  {
> > > -       int i, j, err;
> > > -       char *match;
> > >         regmatch_t reg_match[1];
> > > +       const char *match;
> > > +       const char *log =3D tester->log_buf;
> > > +       int i, j, err;
> > >
> > >         for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
> > >                 struct expect_msg *msg =3D &subspec->expect_msgs[i];
> > >
> > >                 if (msg->substr) {
> > > -                       match =3D strstr(tester->log_buf + tester->ne=
xt_match_pos, msg->substr);
> > > +                       match =3D strstr(log, msg->substr);
> > >                         if (match)
> > > -                               tester->next_match_pos =3D match - te=
ster->log_buf + strlen(msg->substr);
> > > +                               log +=3D strlen(msg->substr);
> > >                 } else {
> > > -                       err =3D regexec(&msg->regex,
> > > -                                     tester->log_buf + tester->next_=
match_pos, 1, reg_match, 0);
> > > +                       err =3D regexec(&msg->regex, log, 1, reg_matc=
h, 0);
> > >                         if (err =3D=3D 0) {
> > > -                               match =3D tester->log_buf + tester->n=
ext_match_pos + reg_match[0].rm_so;
> > > -                               tester->next_match_pos +=3D reg_match=
[0].rm_eo;
> > > +                               match =3D log + reg_match[0].rm_so;
> > > +                               log +=3D reg_match[0].rm_eo;
> >
> > invert and simplify:
> >
> > log +=3D reg_match[0].rm_eo;
> > match =3D log;
> >
> > ?
>
> The 'match' is at 'log + rm_so' (start offset).
> The 'log'   is at 'log + rm_eo' (end offset).
>

oh... yeah... never mind... */me retreats*

> The brilliance of standard library naming.
>
> >
> > >                         } else {
> > >                                 match =3D NULL;
> > >                         }
> >
> > how about we move this to the beginning of iteration (before `if
> > (msg->substr)`) and so we'll assume the match is NULL on regexec
> > failing?
>
> Ok, but this would require explicit match re-initialization to NULL at
> each iteration.

yes, which also makes it clear that we don't carry over match in
between iterations (we can move `const char *match` inside the for
loop to make it even clearer)

>
> [...]

