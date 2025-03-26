Return-Path: <bpf+bounces-54774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D90A71E31
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191847A4115
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E57251782;
	Wed, 26 Mar 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLtUFMuR"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82156251790
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013280; cv=none; b=Lfvg63xcLT+nbvhZ7oP8eXEHjDe2QOUnq67t51PRIEtDHcSRqy7PXB/YKptwpRWQU0EWV6A0FRw7CqivRSb/lFHlCHoVYvUQ+0844WZVKTnO+9c8+BrKc5GV9W+NSJS81qVpwXaihAyi/9aslAK3AFFSsxPze9ple+chOL/0KS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013280; c=relaxed/simple;
	bh=kTu8Y38oyzpI58LvWFfWQLfuXaWediTmwJ+j0gXAwz8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XfxVMLdyL0vUmUFy09gf3Z7Iy4Gs7xNh+83UKHs6t2xpMGSmQuHUlNlWPqDfSLXOSDVSI2Pd+MndOq7+Yb259SjvY1OJxTIwyoCIcMIcGhUEDNLq5JoBkZUe/chycdvVzdqhfRi43ufu9IGdu9tMQzV+erT3Z9gkYLvNMHgg8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLtUFMuR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743013276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4l+lQzfNdWNrBtg0qkUm5FjVJVe3D1qdSIMMNwvWfII=;
	b=ZLtUFMuRR0PCvDeRaLPBt1OT2NHm3TA+YNaujeY/7Jabk+FjavAKUQcgUpZgcF4lgNWfof
	6hYxkHKchqQ/ap5znX3NpF/1Gdx2ScgM6dKwr7eQB/pirYAIBDG3asEzIaHYOPLMbIY2Wv
	yho8IVrBWUlX0mMWrVZWE7M+7OGJ+Rk=
Date: Wed, 26 Mar 2025 18:21:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <f779b5c8d15358edd999d9eedef02ebb30c781a1@linux.dev>
TLS-Required: No
Subject: Re: CI for LTS kernels
To: "Shung-Hsi Yu" <shung-hsi.yu@suse.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Mykola Lysenko"
 <mykolal@fb.com>, daniel@isovalent.com, "Alexei Starovoitov"
 <ast@kernel.org>, andrii@kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org, song@kernel.org
In-Reply-To: <ixcbd3kvefirq5yfr6ooprtpgmbbmtbhfjwguwzlwlx273xuxb@gcxwy72fmdzf>
References: <50cfe7a278ba2518346b050285bc41aa36d834b1.camel@gmail.com>
 <kf9KhbhYjnPiE15zPbVJI0jMZDUQoNG74HrQe4c_bsP1wDXEPV7mms7zvnLUVKKjSto0SNYASRg8Q3rsewZCXDNwr8yKzu3g4U2JpVE_AmI=@pm.me>
 <ixcbd3kvefirq5yfr6ooprtpgmbbmtbhfjwguwzlwlx273xuxb@gcxwy72fmdzf>
X-Migadu-Flow: FLOW_OUT

On 3/24/25 8:49 PM, Shung-Hsi Yu wrote:
> Hi Ihor,
>
> On Mon, Mar 24, 2025 at 10:16:38PM +0000, Ihor Solodrai wrote:
>> On Monday, March 24th, 2025 at 1:55 PM, Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
>>> Hi All,
>>>
>>> The question of testing LTS kernel on BPF CI was
>>> raised by Shung-Hsi on the LSFMM today.
>>> I think, Ihor in CC can guide through the process
>>> of adding such support to the CI if decision would
>>> be made to commit to this.
>
> Thank you Eduard for start the thread.
>
> Attaching the link to the slides[1] for reference.
>
>>> Eduard.
>>
>> Hi Eduard, thanks for pinging me.
>>
>> I actually thought about implementing LTS kernel testing for libbpf,
>> but so far it was not a priority.
>
> I'm not too familiar with BPF CI, but I assuming this meant having
> libbpf's GitHub action test stable/linux.git as well, along side the
> current bpf/bpf-next.git target?
>
> It if it's that then it would be great. Exactly what I'm looking for.

Hi Shung-Hsi.

In short, yes: it's possible to set up Github Actions to run BPF
selftests on LTS kernels using current BPF CI code.

I'm afraid we don't have enough bandwidth on BPF side to maintain LTS
kernel testing within our CI infrastructure. But I will share with you
some pointers in case you're willing to take a stab at it.

All the CI code is public and you should be able to figure out how to
modify it for your needs.

https://github.com/libbpf/ci has a collection of callable Github
Actions that can be used as building blocks for kernel testing.
For example, you can use `get-linux-source` action to download any
source revision:

      - uses: libbpf/ci/get-linux-source@v3
        with:
          repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/li=
nux.git
          rev: master

The actual BPF CI workflows implementation is located at
https://github.com/kernel-patches/vmtest repo.  In particular, see
`.github/workflows` directory.

https://github.com/libbpf/libbpf contains a simpler version of a very
similar workflow, although it has additional code to test libbpf
builds on various distros.

>
>> ... One thing we'd need to figure out
>> is a way of determining which subset of the selftests is supposed to
>> work on a given revision.
>
> I think I might be able to help.
>
> Some question though, is the plan to run bpf-next BPF selftests on LTS
> kernels? (hence both bpf/bpf-next.git and stable/linux.git will both
> need to cloned, separately)

Well, that's a design decision for the LTS testers. I don't think it
makes sense to run all bpf-next tests on older kernels, as usually
tests are added with new features, which would be absent. But it seems
like a good idea to backport and run tests (if there are any) for
backported fixes. It feels like a lot of work though.

>
> Suppose we have some per test case annotation of the kernel release tha=
t
> its depending feature is introduced, would that work? (we might have to
> start with an even coarser grain and ignore annotating feature
> introduced long time ago)
>
> Thinking out loud here. Starting with 6.12 is likely the easiest, for
> that I'd just need annotations like like SINCE("6.14"), SINCE("6.13"),
> SINCE(BPF_LTS_TEST_BASE) where BPF_LTS_TEST_BASE is "6.12". And have
> most test group/cases annotated with SINCE(BPF_LTS_TEST_BASE). Anything
> not annotated would be considered to be bpf-next-only.

I'd be reluctant to introduce annotations directly in test
definitions. I think a better approach is to maintain allow/denylists
that control what tests to run on what revision. BPF selftests runners
already support allow/denylisting. The hard part is to actually
produce and maintain those lists.

>
> OTOH we could just use the LTS BPF selftests found in the same code bas=
e
> as the LTS kernel themselves. That seems to be eaiser as a POC.

Yes, that's a reasonable approach in the beginning.

>
>> I definitely could help setting this up, if there is a need.
>
> Definitely. If you could also give me some pointers on where to start (=
I
> guess I'd need to clone libbpf repo in GitHub and hack on the .github
> files), and what to watch out for that would be deeply appreciated.

One thing that you might want to explore is setting up a Kernel Patches
Daemon (KPD) instance. It can be  integrated with patchwork and github to
automatically collect submitted patches and open PRs to a github
repository for CI testing.

Here is a public repository:
https://github.com/facebookincubator/kernel-patches-daemon

I don't know the details about how to set it up, but I know a couple
of subsystems besides BPF are already using it.

>
> Thanks,
> Shung-Hsi
>
> 1: https://speakerdeck.com/shunghsiyu/bpf-in-stable-kernels

