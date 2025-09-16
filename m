Return-Path: <bpf+bounces-68531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEFB59D51
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FC16F45C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094434A33D;
	Tue, 16 Sep 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHFL47LH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A02F83A8
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039394; cv=none; b=X3WFi+lNXzDPo4Nh4Wtf/1qT+Lx8SjGy3Qrw7WTuCTt0QJK8XmClAKXN6wbYePd2bsWPvwE4f4cPR8uSfNL5fwd109FHI65pery39QDJQyGczOFLWJyr6d1yAfdGwS4511eRDT1DPpyXUmeWIxmAx2uU3gsXjnF66VsFQvOLaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039394; c=relaxed/simple;
	bh=gfe/h63MwQ37snmGzXAelvumcKpDp1mT8vZk101TVIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxZw682BoIUMAjJ5XYOnpW8FBpN/3icBsMuDG6uaDH6jvDBttteETwBHfkHM7hL+Cq9pAxoy1IsAr5JofhmMbMg+dsRjuN0kxMMVYTBfCyQNxM+/wUmuQnj4PcSngWqFhCpMyxY67UPqpfPNF1ZiLtNkQGUPrBm7lVQJcgcc+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHFL47LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85592C4CEFD
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039394;
	bh=gfe/h63MwQ37snmGzXAelvumcKpDp1mT8vZk101TVIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pHFL47LHV811NkCr0BjQCu805bmHO8gyi2a56Z/wcdWBSwY1o/w9HXINprVEUoP9j
	 r69qh8OgN7ZS34hNzk4WM+26Ba3CQRqjObpJGnMYqJsjxQX8CkZ/GlZhCebIswX6tq
	 w6Csso2IiGLI+IuZqZVixyR6uy9sj5z6NnjvTcbnEk0RxI1zwcGdzuxwLE1TILjRu6
	 yOnFjBckE53zDra+TAucLQmwZehDuu6Jfa9SsoJHiMO4W11quIOCgVnAMGtmbtUPyA
	 YEvlD9TV/2QtICDfCPCpa7EiCha740SXKylnno5aHNeO9twaysXcfGVYlVFwsNj5zq
	 hI28osqLWm0vQ==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8112c7d196eso597927585a.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:16:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0wgCEfCit5lpQ+o+x3n+yQvbbJkZoikcFYrE4LpLD5LDoku0K8bCDOq4ZWhwTPqiBO9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZ5hS0AxfdfH6tQ2N6QliVekAhX5NoK4nnXoN+qM6g5yVIaHx
	onmjJjQ/dmelFvc6Qgq9+S5iezh7cbAj2+N6UefhEDfpCkdneR+uwPXDdFaUUuMVeA+DyUbAgyj
	OTRtXWt+aOCtlXIFYCyZ0bD5+7IYFIsQ=
X-Google-Smtp-Source: AGHT+IGlME22nfvdEBMMgv4l5HAb32nvutakxh/wHR7lHuhi2MDeQ8dABzpNaYx48xvlZvk2yCwru9yk/lZMLXcnZps=
X-Received: by 2002:a05:620a:4720:b0:80a:8704:1ca5 with SMTP id
 af79cd13be357-823fdad0d08mr2156145585a.35.1758039393622; Tue, 16 Sep 2025
 09:16:33 -0700 (PDT)
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
 <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com> <CAEXv5_hKQqFH_7zmxr7moBpt07B-+ZWB=qfWOb+Rn9Vj=7EX+g@mail.gmail.com>
In-Reply-To: <CAEXv5_hKQqFH_7zmxr7moBpt07B-+ZWB=qfWOb+Rn9Vj=7EX+g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Sep 2025 09:16:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com>
X-Gm-Features: AS18NWALBX8kvdE_q3ArIdoxc3YDpPiTJ2wk750BR7VtHxbrcwjwIBXbNk7Wmzs
Message-ID: <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 8:25=E2=80=AFAM David Windsor <dwindsor@gmail.com> =
wrote:
[...]
> >
> > makes sense thanks
> >
>
> Hi,
>
> Thinking about this more, hashmaps are still problematic for this case.
>
> Meaning, placing a hook on security_cred_free alone for garbage
> collection / end-of-life processing isn't enough - we still have to
> deal with prepare/commit_creds. This flow works by having
> prepare_creds clone an existing cred object, then commit_creds works
> by swapping old creds with new one atomically, then later freeing the
> original cred. If we are not very careful there will be a period of
> time during which both cred objects could be valid, and I think this
> is worth the feature alone.

With cred local storage, we still need to deal with prepare/commit creds,
right? cred local storage only makes sure the storage is allocated and
freed. The BPF LSM programs still need to initiate the data properly
based on the policy. IOW, whether we have cred local storage or not,
it is necessary to handle all the paths that alloc/free the cred. Did I mis=
s
something here?

Thanks,
Song

