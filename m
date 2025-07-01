Return-Path: <bpf+bounces-61963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A70AF005D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA25231DF
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9D275103;
	Tue,  1 Jul 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MIFcsZyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466527E1D0
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388106; cv=none; b=sioEdjNyOXvutOsEwpaOM91qSV9v6530aXCTpqJpKkd9XonvP+JWaSxYKBYQfjFua2/+xTlyzE1TK+p+6dXcvAfSERV0oRVAn8o5MgRy3GYRR20PeJKyAB/Xk2gPovAUdnef6BUJ8mfvI9YkyLyQIwD6b50NOTFTLIlLgmSpAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388106; c=relaxed/simple;
	bh=IWPGg61zB1oth4kd/0y/wwEehBXGlVgrzvdrkzTEs5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWOA/h3ZdBcTKmEpbO09oAnuqjNOk28tkwaRA0sBxA8WQQgtklJBOQImG+o8xFsui+bVKqUYeQRx73sfLQMJsCL2+5IXBBjcqztSwJDjq501gGm+zRQmzicDuWkzLz7yWOhXZ6tRdt1odWZLUIhZmhT0pXz4e3spP7RhQutl19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MIFcsZyi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-555024588b1so4075336e87.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751388102; x=1751992902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWPGg61zB1oth4kd/0y/wwEehBXGlVgrzvdrkzTEs5A=;
        b=MIFcsZyiAJebptflBYP0VN2SOUilf8saxuKU4To8S160uqUYfQNF0S3O4Bj10naZHP
         eS3MGX5sJEJ7xLveyJ1GxDpLQu3q0qZ3S1He1kouTwXAdh8drBB/C8xRKY68C8o+Gx9X
         E5BiynJ5iuB3gdfeygT7oK+1/2GTz/OyOS0/KuwXI71EIhASm9LbVpxmRe4YjVE2Ur4x
         DzlE4blBaVOFckGhyuDQfX2/WShn9Rzi3NXqUgEFQxQIDEi4XhlivCKCzj/red5J1w8P
         RDg8LmoMZMfozgkEE4CPE3BN4Oo3Mp3bdpIFxsXtJhOOoa+GitLhso6fDpdILQhYoVR0
         qDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388102; x=1751992902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWPGg61zB1oth4kd/0y/wwEehBXGlVgrzvdrkzTEs5A=;
        b=f7cVpXsfoBdpNWNUid5eRCDn/b9GqINrFrr7qnJb+OK1QZhOrEEAN+f6NaNhro2Xa2
         mHQ6Sn26aNeWbxho8OX40dqaBvHCBXFScQHgcqZyMzkJ3QUPdXA3dTd083XHlRfWhBFC
         lyIbZo3vKPbWlAIB6QVSCdOIr6OJymzGGTNM6LdY4B8oSJ/hNCwktgcJtGWlg52kxjOq
         qk/1XbniehIfCvDu/LSIQeGKh4WnBgNQV5SugYD21PboM/WZkk1H114359kav+A+Vl4o
         sxRXETP1Aomy32bfpqqQ+WhoPxeErzw1N6xwIe0Cnf/D2sXYO7rgsUScztFoFxkyYn6r
         T0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthI6X1fuITme1ovFUuTeN21C6seRyiV6h6CeCfx1OAcGavMGZ7/Z8iqXwlr1KPZAevb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2622EAZUK02omxlIzh00zqPZDyN6dzRAHc9128KRj0PAZRD8D
	ah/mYhIre3yaD2ysG4ARihQRQTraKWZbW26TC76W3SgQc0BuRW3+SETKA224hVBQrZhigEmy86n
	D6PCBysKzQyBOM0FHVdyqsvvsvMyeumMlTI7/gG0DpQ==
X-Gm-Gg: ASbGncv4FNlNHwKBeIiJJg7HUmAlqn7usq/f6LsPDMuzqk5OA+mJTOaeBpFLMt3URMM
	/6Pj/0Zp2FN1M4wsJg0RyuErMP6nLcI3Qx5G0RSYdKDBuS+sQPF1nIzqWjvO2A8V1a3U7plF3ou
	dWcATTi9tqiMEo5K28FwFXCXBLJ8vFXt2MzRRxqFYXGoUVact8Y2RqaCfzctZGfg==
X-Google-Smtp-Source: AGHT+IHEq5ypAjgPeGrXgSB+iQb7yMaRQQKfYmf1cOj3A7y4mag1GtbmVbmT4BQ62LbNkTcruSd+EqYyt3TiF72QD1o=
X-Received: by 2002:a05:6512:4012:b0:553:297b:3d45 with SMTP id
 2adb3069b0e04-5550b8dd339mr6809093e87.43.1751388102208; Tue, 01 Jul 2025
 09:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
 <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
 <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com>
 <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com>
 <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com>
 <CAGis_TUNfUOD3+GdbJn1U33W8wW5pWmASxiMa5e5+5-BqJ-PKw@mail.gmail.com> <CAADnVQJp-AtrRj_XESbE5TUj6_dGNDwpRWwu2vEHv1HGOb4Fdw@mail.gmail.com>
In-Reply-To: <CAADnVQJp-AtrRj_XESbE5TUj6_dGNDwpRWwu2vEHv1HGOb4Fdw@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 1 Jul 2025 18:41:29 +0200
X-Gm-Features: Ac12FXyOUK2ie89s6D74HJ8lkPkT67UPAFc_lYbeFJHGKWlptLg9cG1ciKg7zYQ
Message-ID: <CALrw=nEAXCG6-qWBkPudM-c4pLhZ49jdyDKH5CT=hz9YwgBCBQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Fleming <mfleming@cloudflare.com>, Matt Fleming <matt@readmodwrite.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 30, 2025 at 6:28=E2=80=AFAM Matt Fleming <mfleming@cloudflare=
.com> wrote:
> >
> > On Fri, 27 Jun 2025 at 20:36, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Good. Now you see my point, right?
> > > The cond_resched() doesn't fix the issue.
> > > 1hr to free a trie of 100M elements is horrible.
> > > Try 100M kmalloc/kfree to see that slab is not the issue.
> > > trie_free() algorithm is to blame. It doesn't need to start
> > > from the root for every element. Fix the root cause.
> >
> > It doesn't take an hour to free 100M entries, the table showed it
> > takes about a minute (67 or 62 seconds).
>
> yeah. I misread the numbers.
>
> > I never claimed that kmalloc/kfree was at fault. I said that the loop
> > in trie_free() has no preemption, and that's a problem with tries with
> > millions of entries.
> >
> > Of course, rewriting the algorithm used in the lpm trie code would
> > make this less of an issue. But this would require a major rework.
> > It's not as simple as improving trie_free() alone. FWIW I tried using
> > a recursive algorithm in trie_free() and the results are slightly
> > better, but it still takes multiple seconds to free 10M entries (4.3s)
> > and under a minute for 100M (56.7s). To fix this properly it's
> > necessary to use more than two children per node to reduce the height
> > of the trie.
>
> What is the height of 100m tree ?
>
> What kind of "recursive algo" you have in mind?
> Could you try to keep a stack of nodes visited and once leaf is
> freed pop a node and continue walking.
> Then total height won't be a factor.
> The stack would need to be kmalloc-ed, of course,
> but still should be faster than walking from the root.
>
> > And in the meantime, anyone who uses maps with millions
> > of entries is gonna have the kthread spin in a loop without
> > preemption.
>
> Yes, because judging by this thread I don't believe you'll come
> back and fix it properly.
> I'd rather have this acute pain bothering somebody to fix it
> for good instead of papering over.

I think we need both anyway just for the reason we need something to
backport to stable. A full re-implementation of trie might be viewed
as a new feature, but older kernels need to be "fixed" as well.

