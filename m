Return-Path: <bpf+bounces-46297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B539E77C1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF341887DFB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6151FFC41;
	Fri,  6 Dec 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ1dvVlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB91F63F6
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507934; cv=none; b=LIeoDXIx/VQa5nKx/JsBrBCQHyz7H4RGJgwGgQYw/gM8HNm8vBjTZEBSaTsZ+UiOlPy5VA+NjSBaSB8ZI5ZOl+uRqmT2nmb96ZI+l3Mcqfl1ziWyWi8xGmHtBKFRduyAcAw9dgdGqYqjHVQ1ngpXMBdjdxuYRa5x5bJwvkL4360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507934; c=relaxed/simple;
	bh=Rju7wDtlQcRbzcu1X9PD9GeICg6Jt2E1YZVJ5R7oOZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1nhobi3MIPiEx+ZYTJKAHV5MW339LjijSHU3XGUeloA8nN54Wl3uw+g0ai4FL5u3xGdFj3E7fgB30RsNVarLETkYBFwE/kXklcae6W9Wc6bz/KA8GXAU+P0oncJIlR6mki9EoPsw9gVXlBVTb9q5gj8xgh9HiuMMYcS1L8ThD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ1dvVlg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd21e4aa2eso1080266a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733507933; x=1734112733; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rju7wDtlQcRbzcu1X9PD9GeICg6Jt2E1YZVJ5R7oOZs=;
        b=cQ1dvVlgcr5e5yQhflyHgxO5SzoJwv1WQonu+7fIUmPqzT+ClykH7MSzthMEcBMsZK
         j7h0qigI9fR9tOMJPrMTqb39v2EfD8RQJnsKY4+smVtUxFyn/9wWZUxB+DuywwlMEEXJ
         diL4nhuhokfCV0aA+yEbRv1NK+P5SExL/BjKKcYWwyl2ev1KKUi1Wht+svKvQyKiAWmF
         kFG7xtxTK4zUV6VYXeJTMUukTvcOqwGGHwBbwStjUKwP+AUvl0MCkX7NlZUTIpBzXYXr
         QOJBvnO7sRmYL73BZP+qEBPAbDp+kLiCywr4UOPiByZYMPuO62rvDBvJmU5+PwE4T/Rj
         oeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507933; x=1734112733;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rju7wDtlQcRbzcu1X9PD9GeICg6Jt2E1YZVJ5R7oOZs=;
        b=JVfMdrHAEf2dltPmEbefeVxgPMYykyr/nLYP8HGsoQqWQDG5mS1HtnaYg+ErcUqlT1
         0ndDNCQLjgVJx1Et6PhG8owpqKpHIGIbyekm3zl7FHglXt5bYzvXUAbupR12/i8Sewyq
         TwcPm1gfP01QU4XxI1zI3xL2jH2tBs/27ilWCbSFSs/QKW52g4enJlyN/7RSDhKNg8sN
         A8LvkO8uwepq1jEtVqJDVkK7RZOhvGpBnFw4EbPy3pCCIPtk5XnYQIANVQ8ndIYFxfaG
         4tISnu8BUtG8fxMJPSWM9FFqy2dA7vWQCmZ0evVji7+TDvMMs3Ap/MU1/jxSRjj3fpiQ
         eMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUmNbucl3hqwVASFaJuv3WElwG/d4d99DAI3QgsWvtd05YDTTeZRV3c8YhusmfdZ5F3lWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3J+66acwxh+MJFsFQQiMeKP/euTFD5G5BJh7sk4CP4W1OnWt
	WBjPVZg8I3ZpiaLz6Mo9dvRSWODFgGwp0CnrE8Ao5WDevVPbzn31n8WLUQ==
X-Gm-Gg: ASbGncuX561iWvcif+v6SMJPYLlStGiSSPX7uQJcyKjaAI5aVtHzTDP7IixFA8syjjq
	w0h5MDQAqE3AEyN8Sso7WqQ2HMVp/ZXKa6+X3BXYuTd8CW/uLYZmxNNICgj3snYEFNg+s8+u2I2
	r9iBXxY58BGBqj8IlIR95atfjkGf+xRF8cCDqqxgCKQZCvkzVOgrR59QUevV7athFlc17mXULBx
	vMUlzjB3F10igWmxjZLhSbECQR+Y+DFipgW06hUZI38Lk8=
X-Google-Smtp-Source: AGHT+IEyOeyZlMzgPJzRUsNtAHzar0v7w9+u9NYFefCerwqXI9t52mjd8naadVVexlup7QkhMCexkw==
X-Received: by 2002:a17:90b:2b4d:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2ef6ab270cfmr5650259a91.32.1733507932597;
        Fri, 06 Dec 2024 09:58:52 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef68de394esm1847546a91.49.2024.12.06.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:58:51 -0800 (PST)
Message-ID: <fca94f90badf43ee16e2773faf35e136d551ec28.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov	
 <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky
 <mejedi@gmail.com>,  bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Date: Fri, 06 Dec 2024 09:58:47 -0800
In-Reply-To: <CAEf4BzZJOxnm7z6QaxRr9PsfD_DTV5nSPP9TjiEMQxNMxzLFRA@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
	 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
	 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
	 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
	 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
	 <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
	 <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
	 <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
	 <CAEf4BzZJOxnm7z6QaxRr9PsfD_DTV5nSPP9TjiEMQxNMxzLFRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 09:46 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 6, 2024 at 9:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Fri, 2024-12-06 at 08:08 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > The tags would be that generalizable side effect declaration approach=
,
> > > so seems worth it to set a uniform approach.
> > >=20
> > > > Please take a look at the patch, the change for check_cfg() is 32 l=
ines.
> > >=20
> > > I did, actually. And I already explained what I don't like about it:
> > > eagerness. check_cfg() is not the right place for this, if we want to
> > > support dead code elimination and BPF CO-RE-based feature gating.
> > > Which your patches clearly violate, so I don't like them, sorry.
> > >=20
> > > We made this eagerness mistake with global subprogs verification
> > > previously, and had to switch it to lazy on-demand global subprog
> > > validation. I think we should preserve this lazy approach going
> > > forward.
> >=20
> > In this context tags have same detection power as current changes for c=
heck_cfg(),
>=20
> You keep ignoring the eagerness issue. I can't decide whether you
> think *it makes no difference* (I disagree, but whatever), or you *see
> no difference* (in which case let me know and I can explain with some
> simple example).

In the context of the packet pointer invalidation I see no difference.
Tags are as eager as check_cfg() traversal.

> > it is not possible to remove tag using dead code elimination.
>=20
> That's not the point of the tag to be dynamically adjustable. It's the
> opposite. It's something that the user declares upfront, and this is
> being enforced by the verifier (to prevent user errors, for example).
> If the user wants to have a "dynamic tag", they can have two global
> subprogs, one with and one without the tag, and pick which one should
> be called through, e.g., .rodata feature flag variable. I.e., make
> this decision outside of global subprog itself.
>=20
> > So I really don't see any advantages in the context of this particular =
issue.
>=20
> See also my reply to Alexei, and keep in mind freplace scenario, as
> one of the things your approach can't support.

Some freplace related mark will have to be present after program verificati=
on.
It might be in a form of a tag, or in a form of an additional bit in
an auxiliary structure. There would be code to check this with both approac=
hes.


