Return-Path: <bpf+bounces-68361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534BB56E24
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 04:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0F93AC863
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB9224B05;
	Mon, 15 Sep 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MghyeOKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B891C8629
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902258; cv=none; b=nJbGGvZ6P0NOCaH9Y4EUFJ4ArbaMRfFAUJA8MSn+deIBUxVoPsuhwu5nF9l01wssDfAVyTKC7fI/rpTspbjEFQEa2IhHDDP0fsLpsl35RxZrWae5bsvRCiIk885B7jhnu6pVEQo0QIUyj7w/1FZNHFtGucmAQvx4LMyfdjxSXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902258; c=relaxed/simple;
	bh=E8SaG3rK9OPYG2h30/QNxZDdik6CZIZaWWjp+wbNWmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9jw1cVEi5OyE50UwOFjVrAu9FVdbT6NbYFCMtXg0GkgAj6YeMtTtEHubKYr4VxM/5Hy3ypO02zGnMpvQaRbYbt16kz9URaIS9o+P76Up6JCWk465zZfPdfxTHO77Jer10SespGrubmhLfEQ5Wh9aeRK3ZVdHJimXCTCBLgMNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MghyeOKW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e94d678e116so3670291276.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757902253; x=1758507053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb/70s7hZ9XnWpsor82v4Uu8WD+M2Uwq/i5EJIsF6h8=;
        b=MghyeOKWg4xXYvFBQYoS8RGAWusiYPq5Jgw6WANpgM1P+05USoeL/L7AwZLKNdxrqj
         4Z0ykeJckUgFI4Y3y9uvyns2+FukgUR4c0nYX9IhQFHTeUmq/M5wa1T1+055hQwWvQjf
         sx9gyRNdVV8vqW7Zu4tqkkr9Jb4ZmwUR7N+kNxbXYkBJ4G3jBPmqpoldIFA64UP9csc4
         2RbOmu+zq3wq5xiOX/Tt+18ilvVln9kIl3QolbTZeWkV3TbFYHc817VZNbxCaeNxKbak
         mkU8QpILU4UTo/0Nn9W4jeRO+kzjyR1iAGjR8le5bBef+EQEvN2bM6jx5PaLEbc2EjpS
         SvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757902253; x=1758507053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb/70s7hZ9XnWpsor82v4Uu8WD+M2Uwq/i5EJIsF6h8=;
        b=h7TTaEeyo6NLBuzU95fHlXdzbb6guyJMNxMyY23sHswWsHzqS2+fNeNgzVjsTEjys8
         KVtMu6l6HotEPX14PaCl0orlZtK3RypJ41ScBAh4l8q04jCw/e8HnOozf6Xee1S+JLu5
         6iCQKZ4XScEQ/bAISwJ3n/EsZN1W7xDof3DtK98B6NJw/IvRILS37KigbTmjChkzhoii
         EWUNEk76L/eh+8gNLB6JXCpjtBNmVgtJnZ8GYUbnIAm1NLu1PPj4KZkig3AZIzZTnddu
         VLr8ZuS4aRYwNipZgOUdSiOy3wecasoHjGkTo/w85px78zt8YR//YsOToTkpxqkQkjWC
         NVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAkf1fpKCvQbFI/uGyII8awrb2LOD5ro7vYpt6RXPtLBIWLow5rJZDcb31CKpz7G9vcMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1YAqGzfxWDBHM/ZPfEsYliNJqiGSMk2u0leylWYD0MBNYBbV
	G8dI4sJEHv13yJI8Ob8eu1KTouD1/AeFmPXez7noGUR8J1KWds3Io9aE4V2GRPLPQznTMzbTOax
	p+EPuE7e2gSdCaqY1HzKwWhp8yW5WpEE=
X-Gm-Gg: ASbGncs41W6al574FIWsRnwwzpw52sW6wRsyJk8pkgaXaXXIytxa1winQf9DpXeOHUG
	hEa5EilvjWLclMSmStJJOiVrkhw6RKLxZU8V04fnO0BIK8G8OxZulwnhNuo1s2oqoBeMmRfsoqI
	Ok3fgn8zU5QjZ0azjeQ2M4vVruQrPNLbEfiwqxJxqeWbZRiFx+gXQDS5De0tmpW8tHin4dYUevn
	j47hyLBN3VMbvLnDyYZGmPtn1SQPt3r3+SQzg+R+WUneRFFL0E=
X-Google-Smtp-Source: AGHT+IGSARAJPsgY7DKq/2UWn0Qgs3Gt/9qvM16JbDHv3KDLoJQkGtaNs2DBUCW1ZV9cWRNyH27uIXWhigo6SRbl6oQ=
X-Received: by 2002:a05:690c:450d:b0:721:1649:b05b with SMTP id
 00721157ae682-73063094a3dmr99044467b3.13.1757902252841; Sun, 14 Sep 2025
 19:10:52 -0700 (PDT)
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
 <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com> <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
In-Reply-To: <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 14 Sep 2025 22:10:41 -0400
X-Gm-Features: Ac12FXwZkmA9MvRhoKidTeoeExlcsVdM8EuLRP0jfvl-W24TeL0RAL68lYTM2B4
Message-ID: <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 9:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Sep 13, 2025 at 3:27=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> >
> >
> >
> > On Sat, Sep 13, 2025 at 5:58=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >>
> >> On Fri, Sep 12, 2025 at 5:27=E2=80=AFPM David Windsor <dwindsor@gmail.=
com> wrote:
> >> [...]
> >> > >
> >> > > Maybe I missed something, but I think you haven't addressed Alexei=
's
> >> > > question in v1: why this is needed and why hash map is not suffici=
ent.
> >> > >
> >> > > Other local storage types (task, inode, sk storage) may get a larg=
e
> >> > > number of entries in a system, and thus would benefit from object
> >> > > local storage. I don't think we expect too many creds in a system.
> >> > > hash map of a smallish size should be good in most cases, and be
> >> > > faster than cred local storage.
> >> > >
> >> > > Did I get this right?
> >> > >
> >> > > Thanks,
> >> > > Song
> >> > >
> >> >
> >> > Yes I think I addressed in the cover letter of -v2:
> >> >
> >> > "Like other local storage types (task, inode, sk), this provides aut=
omatic
> >> > lifecycle management and is useful for LSM programs tracking credent=
ial
> >> > state across LSM calls. Lifetime management is necessary for detecti=
ng
> >> > credential leaks and enforcing time-based security policies."
> >> >
> >> > You're right it's faster and there aren't many creds, but I feel lik=
e
> >> > in this case, it'll be a nightmare to manual cleanup with hashmaps. =
I
> >> > think the correctness we get with lifetime management is worth it in
> >> > this case, but could be convinced otherwise. Many cred usage pattern=
s
> >> > are short lived and a hash map could quickly become stale...
> >>
> >> We can clean up the hashmap in hook cred_free, no? The following
> >> check in security_cred_free() seems problematic:
> >>
> >>         if (unlikely(cred->security =3D=3D NULL))
> >>                 return;
> >>
> >> But as far as I can tell, it is not really useful, and can be removed.
> >> With this removed, hash map will work just as well. Did I miss
> >> something?
> >
> >
> > No I think actually this is easier.
> >
> > I will prepare a patch for the race in cleanup I stumbled on earlier wh=
ich is still there and could affect other users.
> >
> > That said, is there any use case for local storage for these structs:
> >
> > - struct file
> > - struct msg_msg
> > - struct ipc
> >
> > I can off the top of my head think of some security use cases for these=
 but not sure if hashmaps are needed, perhaps struct file
>
> Sorry, no. This is not a copy paste territory.

no i get it's not copy/paste but I have the series for struct file
ready for submission, with selftests. this is also a performance
critical use case and there will be numerous struct file on edge
servers.

> The existing local storage maps were added because
> performance was critical for those use cases,
> but we made a few mistakes. There is a performance
> cliff that has to be fixed before we adopt it to
> other kernel objects.

ahh wasn't aware of this.

> Please use hash map and consider wrapping rhashtable
> as a new bpf map type if fixed max_entries is problematic.
>

makes sense thanks

> pw-bot: cr

