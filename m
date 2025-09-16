Return-Path: <bpf+bounces-68568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E02B7EB4A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C75189015F
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7527E043;
	Tue, 16 Sep 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcK8XZX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB91C84A6
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062855; cv=none; b=u0HUB/TwNYhQOaTX6rOzXIHaupw02eWyu1GYNezIh9nhM57FFVqx4JvEbp8Km5tNuhX6CV9OU8JUZJQWUj9Ws6RmmTEsTWuVMqs6rsA8j4y7tBb2wXMG96oB0YLyI2djnJsiyR9dQuFrdF12EvDhwqzD3MLg/2xG4Zn8aoVZOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062855; c=relaxed/simple;
	bh=yfBXfiwaE6UBo1VSET+b5FvEyEKartVH+P37TonkpmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4VjX0Mr/h5dmZJPDqpjN+nz+6RBTDxNttHi2vHfQRNIxs+BOcxDOD0smgL47Njp/whdcxokgZ+hKcshG7kS/ClvWQfNvOQ8deq+Cux7R1R590IehdAgDNT1+X68bkA2JFHL4vAQu5prqcpN0xzD/tzvIMzBk4fQYwgPLNp5sos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcK8XZX0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso4059068a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758062853; x=1758667653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8ue7NxlyVY4hrk9DjxGkRlTeGKIsIJViaabqkDqgdk=;
        b=FcK8XZX0gwGMOl+zrS8eVNjuC16rhjMNJeuvy93zNdpcIB86mnXvsBpATKfejHPKty
         sKyE9ESDKtq1SHAyu1J8nbcsXuKwzERJoFc5k38//VRBkJNtmG4U7sRQMPpc3ioVW4hi
         KrkQJojwNw+jOcZt9MTvXHSW4gntju1+heCFabkg/laKY22P/6x4/7R15AAEypOmXPCP
         +fJudmdMJm37jO0cKpXhxKK8mAShBmUhfu7U7gu0bcGAaeykXuHJ9QP7Ef5FwXbf5MCh
         bGtHlSz40ipBa0qZ6GGuDK5f48jtgkM3CWcyUTouOELgBmFm2PtZK53t0jFru1NjxAnF
         jJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062853; x=1758667653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8ue7NxlyVY4hrk9DjxGkRlTeGKIsIJViaabqkDqgdk=;
        b=f8mCyqSAbs5zDWBYRNbvaafA9fFnw66Luu2D7bHE2CAijYlv/s6rbvThGZMRbnc+fL
         sfuGaFx4i9ac3xycG9dKEPG0kwyzHyLM7KnaqskI2LgkQmSS/VT3ebZuNNI2WeoKISPS
         GuwJxv9dCy43W7UJKAXpwbMm31gbJpza7ilNkwaj3Os6dLiUHHF8wD0KlT1DEJUGxTXL
         bNFYWI/ODoIMmjh05IcOoO/n871dwmWRv7EITRGX8Q7n/PUTFeAL5XW8OSDSRHVTMv2p
         8JtvS8MO7Pj48S3pqTZ7QgCP+ioIkYIlTyN3ksgfF7txXijT5MfBZ6x7MqFE5vQGI4nn
         v81Q==
X-Gm-Message-State: AOJu0YxI9ekGu3kII1lsp0n6OahH6ZjGtHmvI5sPIwQkOPiTpH8dx9uj
	tWdtxH6z4qD+mjMOuO6UqK2ZtTWb/BpVgMVwdoWum7QjJuyJBMOa2VZ7YFLuGs7klUeFUXLVGmX
	RhvO8s2P/I1euZYrj/UucpS3AUI7KA8M=
X-Gm-Gg: ASbGncv5fwChzXy00KEQVc/S1JXtkQNW1k62Qc48Ne5sIX8aUxNawGDad24d4/gPMB6
	s+kI81C95weUIv8iFAtOFAW+DIYieGq1WWFPfunXLAR2BRm+nZuddoa1fBO3ml5IIAB6s3LwS6r
	m65OtUy4NaVWkYl3//pO5NrNwK2aT8lCx+lv+ieVADCRXHv28+K5i1RiUsuPxeA+oaxTo8On/g0
	6oM8gFff9YFA6wm5MCznaL1ufUKyjkTLA==
X-Google-Smtp-Source: AGHT+IH1HmjpcOvFr8pd8mXjmlAg2aOcdlPfneq1LKidHixXdLl0J0viD3BJSaKMXhyxmjbcl1pIUZYotp5Pw3Bkqkk=
X-Received: by 2002:a17:90b:5910:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-32ee3f7b53fmr26630a91.36.1758062853042; Tue, 16 Sep 2025
 15:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916212251.3490455-1-eddyz87@gmail.com> <CAEf4BzYJW+O6CD5+V1wP3uF0=BBVNLrUwM+co7Pps8HF13p3Ng@mail.gmail.com>
 <e011fbe6e1e715243b9d1166d7a125036cbb6b9b.camel@gmail.com>
In-Reply-To: <e011fbe6e1e715243b9d1166d7a125036cbb6b9b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 15:47:19 -0700
X-Gm-Features: AS18NWBzMR2FOwJixWcwvLAcX7w-g1UUeCknt0vwKfwfp-ZA-JxEtIL6u4c2YO8
Message-ID: <CAEf4BzbMa07jVzDpdnfdZfKyVXbE+XKyoJ+UyM-Drv-2850UZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for missing
 bpf_scc_visit on speculative path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, 
	syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-09-16 at 15:33 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -1950,9 +1950,24 @@ static int maybe_exit_scc(struct bpf_verifier_=
env *env, struct bpf_verifier_stat
> > >                 return 0;
> > >         visit =3D scc_visit_lookup(env, callchain);
> > >         if (!visit) {
> > > -               verifier_bug(env, "scc exit: no visit info for call c=
hain %s",
> > > -                            format_callchain(env, callchain));
> > > -               return -EFAULT;
> > > +               /*
> > > +                * If path traversal stops inside an SCC, correspondi=
ng bpf_scc_visit
> > > +                * must exist for non-speculative paths. For non-spec=
ulative paths
> > > +                * traversal stops when:
> > > +                * a. Verification error is found, maybe_exit_scc() i=
s not called.
> > > +                * b. Top level BPF_EXIT is reached. Top level BPF_EX=
IT is not a member
> > > +                *    of any SCC.
> > > +                * c. A checkpoint is reached and matched. Checkpoint=
s are created by
> > > +                *    is_state_visited(), which calls maybe_enter_scc=
(), which allocates
> > > +                *    bpf_scc_visit instances for checkpoints within =
SCCs.
> > > +                * (c) is the only case that can reach this point.
> > > +                */
> > > +               if (!st->speculative) {
> >
> > grumpy nit:
> >
> > if (st->speculative)
> >     return 0;
> >
> > ... leave the rest untouched ...
> >
> > ?
>
> I did this on purpose.  In the comment above I explain why the error
> is valid only for non-speculative path, so want to have code and
> comment in sync. Tried inverting the comment to explain why it's not
> an error on a speculative path and it is confusing.

...
  * (c) is the only reason we can error out below for non-speculative path"=
.
  */
  if (!st->speculative)
      return 0;

  verifier_buf(...);

(even as is your comment read just fine in my head, tbh).

But I don't insist, if you find this confusing, I just don't like
deeply nested code when less nested would work.

>
> >
> > > +                       verifier_bug(env, "scc exit: no visit info fo=
r call chain %s",
> > > +                                    format_callchain(env, callchain)=
);
> > > +                       return -EFAULT;
> > > +               }
> > > +               return 0;
> > >         }
> > >         if (visit->entry_state !=3D st)
> > >                 return 0;
> > > --
> > > 2.51.0
> > >

