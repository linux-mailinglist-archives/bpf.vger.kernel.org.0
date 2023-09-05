Return-Path: <bpf+bounces-9238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA88E79211A
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 10:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20161C2031A
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83553B7;
	Tue,  5 Sep 2023 08:41:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1A1C2D
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 08:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D9C433C7;
	Tue,  5 Sep 2023 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693903289;
	bh=0FEt4XuiCupoBQ6w4wjOKxVM3NSL60l5Rgl/mPesGj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dzEuwrOuckVM06GIWlpPtpXgBGfpTSsuhMVQMA65s3r9o5BXlcklA0FILdaqJaCqW
	 LYDX1RsYmuR0Zg2YArZtkU+G06G/mftmP7ht3VcTcHxFrhOk5+mQUPRVz6hYdq3zFR
	 in69ct1+0v5O3vEeGSEEiYfpF59qxYYOWEyNIWX/XA+5adlSbY2ZUUrrSRnT7hgk81
	 Fh0K3GYPDXotbNmsZ1ZdFHJW61U0ou2/TPWoIaNyrF07soAK+oa2/sWhaZPHIUbLtM
	 4NifjPKWufUknMhHN6A2PvdB0qXsWiM+WVNMWCgELUzU5w8ENbAy6oSz7DxNJvl/93
	 HaFtWY2E4aDhg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A54EDC62C2; Tue,  5 Sep 2023 10:41:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: David Wang <00107082@163.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
In-Reply-To: <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
 <49e1d877.1e64.18a63574e6a.Coremail.00107082@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Sep 2023 10:41:23 +0200
Message-ID: <87wmx5ovv0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"David Wang" <00107082@163.com> writes:

> At 2023-09-05 05:01:14, "Alexei Starovoitov" <alexei.starovoitov@gmail.co=
m> wrote:
>>On Mon, Sep 4, 2023 at 3:49=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>>>
>>> David Wang <00107082@163.com> wrote:
>>> > This sample code implements a simple ipv4
>>> > blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
>>> > which was introduced in 6.4.
>>> >
>>> > The bpf program drops package if destination ip address
>>> > hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
>>> >
>>> > The userspace code would load the bpf program,
>>> > attach it to netfilter's FORWARD/OUTPUT hook,
>>> > and then write ip patterns into the bpf map.
>>>
>>> Thanks, I think its good to have this.
>>
>>Yes, but only in selftests/bpf.
>>samples/bpf/ are not tested and bit rot heavily.
>
> My purpose is to demonstrate the basic usage of BPF_PROG_TYPE_NETFILTER ,=
  showing what bpf program and userspace program should do to make it work.
> The code is neither  thorough  enough to make a valid test suite,  nor  d=
etailed enough to make out a tool (Could be a start for a tool)
>
> samples/bpf is a good  place to start for  beginners to get along  with b=
pf quickly,   those  sample/bpf codes do help me a lot,
>   but selftests/bpf is not that  friendly, at least not friendly for begi=
nners, I think.=20=20=20
> There are already test codes for   BPF_PROG_TYPE_NETFILTER in selftests/b=
pf,  actually I did refer to those code  when I made this sample.
>
> Get a feeling samples/bpf would be deprecated sooner or later, hope that =
would not happen.
>
> Anyway, this sample code is not meant to test.=20

FYI, we maintain a Github repository with BPF example programs of
various types at https://github.com/xdp-project/bpf-examples

Happy to include this example there as an alternative to the in-tree
samples/bpf :)

-Toke

