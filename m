Return-Path: <bpf+bounces-68537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2FB59FB0
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 19:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A2F1C00EE8
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589A2773DD;
	Tue, 16 Sep 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1+ixcXx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CE26561D
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044836; cv=none; b=J1V4rPYN7sZ1ZGbT2wX/+jajd0N2pCqdAo2nFoNEZpZb5TETnL68AXyOcYKaQ4Sqfdpjq20z6q3k6DWJ8XFLg9uyRn8nbiLiln/hnHRObf7+UORW1NZjZ+ZnpVM8VEHveO6H6JV/ei2QOOIrF6EF5u8MgDLaBPtffS2XIusLUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044836; c=relaxed/simple;
	bh=aLmbkZlhz1WS9XpqHbrwfjTUeFYT2Q1NHeUwS7oznZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljjhMSa8IlVph7UMOGULWIMAgS1p8n7mip+ILJhxHaqbsbvRwxLXjjQJ5JVPu5fc6OktClSUd4ckCBfiiQZAg9Mqgd+IewiMLkUAStW46WkA6axRl68Ok5DdsnN/CiunYD0raEm7wLPYaX53CQfMOGwxbu+Q/ilGtTg3aKyBNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1+ixcXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F58C4CEFD
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758044835;
	bh=aLmbkZlhz1WS9XpqHbrwfjTUeFYT2Q1NHeUwS7oznZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c1+ixcXxM8sQfs4XzFUJLvPebbv2IfIgNOPhJlESuUQt2/59lq6vQ6fxHGoRSTXDx
	 hlv2Fzt73lEr1tRaMLnYDeIGprHu0iju6XpyfQDhfayKLbvTsWHObGV9EEIIJX5x1+
	 IkTL9AjPwk/XPHVlRRsNr38CEayCdT7eUxFI4mHgPQgwAzprfDWnu1I6s5cly+REiT
	 aTBiJHkUe2a15t4VvckBw44DJVJCf30emdUPMGfpcYk/IJd5UKsoSHfCSlVUojRbwk
	 yDIHD/PaCF3qWTE/E6Kycs787oH5DwUBrUQekNH6cBuWBOJbEBlnRGuDsVsDzQ6uwC
	 g76YBugSqDo/w==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-826fe3b3e2cso310234485a.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 10:47:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdWw3JNj6vVNAfFckq9y2BD36qMvjRHUc/xYAbIynRqwUU+W+5bTuumOhBiH+KnhvA1aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmYfi+DTreFn0s3Exzza9xDpBXi5JuGAWSvjO/BvDJ0d2JEY3
	YERMfSd/I9h5p2Pn6uC+RNMkhNKzWJszCU0VPiP9w1lu5wpAdo2D2t2r+yDm2BsJsdejo1XV+zV
	b+m8AhiRgIWhdGsX4DlibCvVhDdvH9Iw=
X-Google-Smtp-Source: AGHT+IFezjxFE8oQGXb4mz1uQF6IRvxcY+qF9XaG71lkSWfOy8S3Hq2ksW15fYl1JMPaUJijUrjDvOLcG9O8nCAq79E=
X-Received: by 2002:a05:620a:4891:b0:82b:f16b:274a with SMTP id
 af79cd13be357-82bf16b2cacmr414668385a.50.1758044834715; Tue, 16 Sep 2025
 10:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
 <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
 <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
 <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com>
 <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
 <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
 <CAEXv5_hKQqFH_7zmxr7moBpt07B-+ZWB=qfWOb+Rn9Vj=7EX+g@mail.gmail.com>
 <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com> <CAEXv5_jCXKm4L6tJy5X6kjoLpoPqkbRLuhGuEMYNwoW=EYYtsw@mail.gmail.com>
In-Reply-To: <CAEXv5_jCXKm4L6tJy5X6kjoLpoPqkbRLuhGuEMYNwoW=EYYtsw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Sep 2025 10:47:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6qFXKiZ4+kMWtKK9PO_-Z7=GQLa3wYF73GcXgkDgZVLg@mail.gmail.com>
X-Gm-Features: AS18NWC8lfPBhjeqHEkvNBXjAkocXr4VFwolRxWKLxCfZWFUN9hHNAHjHoLMGXo
Message-ID: <CAPhsuW6qFXKiZ4+kMWtKK9PO_-Z7=GQLa3wYF73GcXgkDgZVLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:36=E2=80=AFAM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Tue, Sep 16, 2025 at 12:16=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >
> > On Tue, Sep 16, 2025 at 8:25=E2=80=AFAM David Windsor <dwindsor@gmail.c=
om> wrote:
> > [...]
> > > >
> > > > makes sense thanks
> > > >
> > >
> > > Hi,
> > >
> > > Thinking about this more, hashmaps are still problematic for this cas=
e.
> > >
> > > Meaning, placing a hook on security_cred_free alone for garbage
> > > collection / end-of-life processing isn't enough - we still have to
> > > deal with prepare/commit_creds. This flow works by having
> > > prepare_creds clone an existing cred object, then commit_creds works
> > > by swapping old creds with new one atomically, then later freeing the
> > > original cred. If we are not very careful there will be a period of
> > > time during which both cred objects could be valid, and I think this
> > > is worth the feature alone.
> >
> > With cred local storage, we still need to deal with prepare/commit cred=
s,
> > right? cred local storage only makes sure the storage is allocated and
> > freed. The BPF LSM programs still need to initiate the data properly
> > based on the policy. IOW, whether we have cred local storage or not,
> > it is necessary to handle all the paths that alloc/free the cred. Did I=
 miss
> > something here?
> >
>
> Yes each LSM will have to do whatever it feels it should. Some will
> initialize their blob's data with one type of data, some another,
> depends on the LSM's use case. We're just here to provide the storage
> - bpf cannot use the "classic" LSM storage blob.
>
> I was referring to the fact that if we use a hashmap to track state on
> a per-cred basis there may be a period of time when it could be come
> stale during the state change from commit -> prepare_creds.

I still don't see how cred local storage will make a difference here. If th=
e
cred is stale, the data attached to it is also stale. As long as we free th=
e
attached data together with the cred, it should just work, no?

Song

