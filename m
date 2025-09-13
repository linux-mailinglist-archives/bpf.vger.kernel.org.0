Return-Path: <bpf+bounces-68307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C9B5635E
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 23:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A514A08112
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9FD298CC4;
	Sat, 13 Sep 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqAZ3BL0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8B28134C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800731; cv=none; b=j8LXmqOuX2C5jLd/reyvhnC4nftCtobm5gMS1vrTvh89bQB/vITulpRpZLpGdV4civWUBjKvJki65yOPio3InkXCqfX8LrmF9bwO7l3QutuIiRmR/CE2yDS7u4gq3Rz6dLSjsfEOm4S8u8G9yT7kt41GJhFdBBxtwSOiPwxM8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800731; c=relaxed/simple;
	bh=LOkCsYvBCi1biYmhepUrhqSgx/AvwDKKOTu2pLbdFBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4lvhHjBdi0MoEt/888mKIwy09Y1+WBJu+BkfBScma0gZ0JyGrlWDDgJV8+D6mDlfOM6Vv/K0rjIz/UI6Sf17Nbi74l1VtS9pxOyIw8t0QkwZSTBuMUSqWAGjWkhQw6vEg1zqvv6Lxv2rXaeEMKds3UCQOzIaA+DdzuvA5HlfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqAZ3BL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A535C4CEF8
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 21:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757800731;
	bh=LOkCsYvBCi1biYmhepUrhqSgx/AvwDKKOTu2pLbdFBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MqAZ3BL08G0VoegLZAmlWSt/9K9iPdP3cdcw0ykMDuUaKbKBfoiKSEbXawOgYYava
	 ky5V0Xk2yeZ0HchvollUmChz5Kx/FZfG62uqvBCwNmOArkcGVIFqzzqhuIztwHfc+l
	 H3j26G11wgk4Ep9vvGEoQ0qwcKV0koHXnru+j3tAv11n9VN+SP8NYhTWSjKpunqRET
	 EplkYrU7Atx5Nw9PRUKmRV0XWVX0qBo2OgBRYktSfyRTl7x3nKdS9wTLdz9LJoG0aD
	 X++73p2wC4mSbr7KGhL2z73oALBYlL7057CEveVuZc+SsqCNGsS78zQx2OXc0ka3+b
	 aTle0E00pOzLg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-826fe3b3e2bso77251785a.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 14:58:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzM22nNM7Rw18J80HS3U7/dCKpZNtNRX/W+sfynSoPp3LPwC7O9
	VR6L8iSomveBsrk3vZFpUaLIXp8RbXgO+PUISPZHDD5456qmy/011mkjdD5uG1FNqqgw8+1QFZv
	Xwjo9WNuF6jMzJTJRnI20UVK1FmFBRDI=
X-Google-Smtp-Source: AGHT+IFhdgDXcY38HLqUNK+yXTp4MrRWnBrSKYcSMoTNPz3CdZ7gKInWn6VzZRT6FZ8yo1siiDRAkb+w/GTh9xUoYc4=
X-Received: by 2002:a05:620a:bca:b0:7f3:e3fc:c2f3 with SMTP id
 af79cd13be357-823fbde835cmr1050243985a.10.1757800730510; Sat, 13 Sep 2025
 14:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com> <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
In-Reply-To: <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 13 Sep 2025 14:58:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
X-Gm-Features: Ac12FXyEsLL2l0rxOgBvaBZs4-gra_5SMkSsrwtfeX4UksEfDcIiQIZ0bySh-RA
Message-ID: <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:27=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
[...]
> >
> > Maybe I missed something, but I think you haven't addressed Alexei's
> > question in v1: why this is needed and why hash map is not sufficient.
> >
> > Other local storage types (task, inode, sk storage) may get a large
> > number of entries in a system, and thus would benefit from object
> > local storage. I don't think we expect too many creds in a system.
> > hash map of a smallish size should be good in most cases, and be
> > faster than cred local storage.
> >
> > Did I get this right?
> >
> > Thanks,
> > Song
> >
>
> Yes I think I addressed in the cover letter of -v2:
>
> "Like other local storage types (task, inode, sk), this provides automati=
c
> lifecycle management and is useful for LSM programs tracking credential
> state across LSM calls. Lifetime management is necessary for detecting
> credential leaks and enforcing time-based security policies."
>
> You're right it's faster and there aren't many creds, but I feel like
> in this case, it'll be a nightmare to manual cleanup with hashmaps. I
> think the correctness we get with lifetime management is worth it in
> this case, but could be convinced otherwise. Many cred usage patterns
> are short lived and a hash map could quickly become stale...

We can clean up the hashmap in hook cred_free, no? The following
check in security_cred_free() seems problematic:

        if (unlikely(cred->security =3D=3D NULL))
                return;

But as far as I can tell, it is not really useful, and can be removed.
With this removed, hash map will work just as well. Did I miss
something?

Thanks,
Song

