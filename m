Return-Path: <bpf+bounces-68544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D790B5A18E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A501322CBF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD292DC775;
	Tue, 16 Sep 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOGTohGg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68242773F0
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051426; cv=none; b=mV9apvwDU6L+DNbqheThkBtv6vOsaLnlZRHLtm9SPAV3sqb9gGp6EakJo2nHXW72YokUQsM8sDZ7Q0q4X3GN6ena/74pU4DfpuwEUScQAzt4VWWOTJR5N6wO+e3t16kVRwFMrsn+r2NTPdx3oOmXShTSSWQMfGD4wPeiVSPBchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051426; c=relaxed/simple;
	bh=V1PBA0ipVR6RHL4l+EzKcfMj25cy8Hz5q4i26ppeCjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJeMufszawdBlsWgqzCWi4q322dZmMg4uOJGuz3hSA2tO+4OASxjKAV/0b3zcqqmbyZ22+pKBztnqi9rXCZsm1PkyFpHrsMCfu33zq02MsS5L8pTlVxAreVdIyhYvANswCltsSZVFSzhUXD17+EWIBXbXuGFZul1wTKp12Zkrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOGTohGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACD4C4CEEB
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758051425;
	bh=V1PBA0ipVR6RHL4l+EzKcfMj25cy8Hz5q4i26ppeCjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eOGTohGgX7Tmmk1lvNGtHro1rjwkkc/bkGX/n0xDtR00icaCqjSRTOuE2/qxeQziG
	 E/aFGSKGTKCCv2sxCFqXiYU+Ij1q+VVSMdseB993mqeVWpiFwKE+54D5YngvenKd/F
	 iUC3xq75Vrg8Q2mCmPErlzFkSOdvVdGl71r5XD+C97n6Qejy1WsbNOEdKlFtrs6JiK
	 o0l119madXk2f+Idhh6pAoB1+GO5uxKVM6ccjPGqQWVd1WVj9WN0AzcjPG1wgmeA9f
	 Ykj3eOa1nzKCoB5avxZsR5pFLYK1TSD56/GM1DgdrHq1zZeuP1BdjrovGM717fDArG
	 vcHbKy+Q1aNfw==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8250869d5d8so520223685a.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 12:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrjkW+cltN+sNGuPTAR5TwVUVecTHEqlNspRJG93cxu0BSCMZivPB0vnT7V85pEhN6rgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzew2KX3zbL0Pt0oBxXuBeCx1wqbtWniWbwY3hw2P7cPuh91Wy4
	maq2THkxLb4LQ+GT5yRAYsBtpk3F1C7NG0nPVvszYnvyX39vjSWYX05GVSOhp56sHBmIdNT0GCI
	qtymeTVzR83kJjaBR283N38z9/Eu2qBA=
X-Google-Smtp-Source: AGHT+IFgFeA2/tPbCnmIP2m5qCivYDfdZRboW/Hyk9eCaMRvYb6yHkgdxTP1UNEdSYkv+Hz2ELx4cc3yItcdSkZ3n/U=
X-Received: by 2002:a05:620a:a00f:b0:7e9:f820:2b4c with SMTP id
 af79cd13be357-82400943aa3mr2131013485a.68.1758051424741; Tue, 16 Sep 2025
 12:37:04 -0700 (PDT)
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
 <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com>
 <CAEXv5_jCXKm4L6tJy5X6kjoLpoPqkbRLuhGuEMYNwoW=EYYtsw@mail.gmail.com>
 <CAPhsuW6qFXKiZ4+kMWtKK9PO_-Z7=GQLa3wYF73GcXgkDgZVLg@mail.gmail.com> <CAEXv5_h=DoexdK4ZtFGS1Ya3NSM146qxxKyLhO9R736TS7=idg@mail.gmail.com>
In-Reply-To: <CAEXv5_h=DoexdK4ZtFGS1Ya3NSM146qxxKyLhO9R736TS7=idg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Sep 2025 12:36:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5dEqMBPxvh03dc=K6az0Z6TP-aXCpiowLoTxDHxCvTsw@mail.gmail.com>
X-Gm-Features: AS18NWDHXBjO6dPwyTm8QXiBBhPo69cLDotnh2cAnHI_TY5kkgwTYWgyTsAuIbg
Message-ID: <CAPhsuW5dEqMBPxvh03dc=K6az0Z6TP-aXCpiowLoTxDHxCvTsw@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 11:49=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
>
>
>
> On Tue, Sep 16, 2025 at 1:47=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 9:36=E2=80=AFAM David Windsor <dwindsor@gmail.c=
om> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 12:16=E2=80=AFPM Song Liu <song@kernel.org> w=
rote:
> > > >
> > > > On Tue, Sep 16, 2025 at 8:25=E2=80=AFAM David Windsor <dwindsor@gma=
il.com> wrote:
> > > > [...]
> > > > > >
> > > > > > makes sense thanks
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thinking about this more, hashmaps are still problematic for this=
 case.
> > > > >
> > > > > Meaning, placing a hook on security_cred_free alone for garbage
> > > > > collection / end-of-life processing isn't enough - we still have =
to
> > > > > deal with prepare/commit_creds. This flow works by having
> > > > > prepare_creds clone an existing cred object, then commit_creds wo=
rks
> > > > > by swapping old creds with new one atomically, then later freeing=
 the
> > > > > original cred. If we are not very careful there will be a period =
of
> > > > > time during which both cred objects could be valid, and I think t=
his
> > > > > is worth the feature alone.
> > > >
> > > > With cred local storage, we still need to deal with prepare/commit =
creds,
> > > > right? cred local storage only makes sure the storage is allocated =
and
> > > > freed. The BPF LSM programs still need to initiate the data properl=
y
> > > > based on the policy. IOW, whether we have cred local storage or not=
,
> > > > it is necessary to handle all the paths that alloc/free the cred. D=
id I miss
> > > > something here?
> > > >
> > >
> > > Yes each LSM will have to do whatever it feels it should. Some will
> > > initialize their blob's data with one type of data, some another,
> > > depends on the LSM's use case. We're just here to provide the storage
> > > - bpf cannot use the "classic" LSM storage blob.
> > >
> > > I was referring to the fact that if we use a hashmap to track state o=
n
> > > a per-cred basis there may be a period of time when it could be come
> > > stale during the state change from commit -> prepare_creds.
> >
> > I still don't see how cred local storage will make a difference here. I=
f the
> > cred is stale, the data attached to it is also stale. As long as we fre=
e the
> > attached data together with the cred, it should just work, no?
> >
>
> If we use local storage, the cred being stale will still be possible but =
its attached object will at least be consistent.
>
> In this case, a cred object has been replaced with a new instance, but un=
der RCU readers may still legally see the old pointer for some time.
>
> If we're tracking state in a side map keyed by the pointer and you=E2=80=
=99ve already removed the old entry (after copying state to the new one), t=
hose readers will get a miss even though the old object is still valid:
>
> CPU0 (commit_creds)        CPU1 (BPF hook)         Hashmap
> -------------------------  ----------------------  ----------------------=
------
> task->cred =3D old_pointer                           entry[old_pointer] =
=3D blob_old
>
> rcu_assign_pointer(new_pointer)
>
>                            still sees old_pointer
>                            lookup(old_pointer) -> blob_old
>
> map_update(new_pointer, blob_old)                  entry[new_pointer] =3D=
 blob_old
> map_delete(old_pointer)                            del entry[old_pointer]
>
>                            still sees old_pointer
>                            lookup(old_pointer) -> NULL (this is a failure=
)
>

This is a problem because we are calling map_delete(old_pointer)
at commit_creds time. If we instead calls map_delete(old_pointer)
at security_cred_free, it will be the same as cred local storage.

Does this make sense?

Thanks,
Song

