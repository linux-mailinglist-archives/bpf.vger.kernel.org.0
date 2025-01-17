Return-Path: <bpf+bounces-49220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E59A15639
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146AF7A4A4B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDA185B72;
	Fri, 17 Jan 2025 18:00:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DB19D098
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136816; cv=none; b=CLTC9ZwbrT7cOw4chyeo5zdqQX7z/LvjFZfqreXHCD8G3xssVsAP49PbcMPjZyPMBV7wrENU9ZjC/sJDkVGqPHP0/Osh627CHcyjlnHLOfY4y4mfn0SytRTW40vfZrtcdKb5Ih8M2lBMBZH0BtDx9FFIUmkdgu0gw2Or1QKiTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136816; c=relaxed/simple;
	bh=HOrwFHlPLwUikmKPnpnsigf1d5I++j4SrBxj6vgAnj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHWFHg2/EantvC/KMQjV8Y5EJ6oSYSD5hO0wGFBM6oJQpydBfw9nspPQP7MDq1LlxBjRLqnwUXK3UmCqhp9vVKW+m1eToKjUYFNUVJ82IEkRdgaevvolzgPqw1jW+WQeysucKtnGu7T4yu/fk8J8ua4unJKZaZQBn8H4f8rUCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Ihor Solodrai via Gcc <gcc@gcc.gnu.org>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,  Ihor Solodrai
 <ihor.solodrai@pm.me>,  bpf <bpf@vger.kernel.org>,  Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Alexei Starovoitov <ast@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Manu Bretelle <chantra@meta.com>,
  Eduard Zingerman <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,
  Yonghong Song <yonghong.song@linux.dev>,  David Faust
 <david.faust@oracle.com>,  Andrew Pinski <pinskia@gmail.com>,  Yonghong
 Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
In-Reply-To: <zp_HRUf7wzFwZMVqR2IwXRMf-WtdNZP-ocWWflDG0nDLg2FXZ0Jt91ztxfBxdHurGC_z4C5M5qPIspVTFMAXG5_hFuDwZRMNmXKak3UnLXk=@pm.me>
	(Ihor Solodrai via Gcc's message of "Fri, 17 Jan 2025 17:55:21 +0000")
Organization: Gentoo
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
	<Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
	<87bjw6qpje.fsf@oracle.com>
	<8zWDbpQS-9sjNHlLlLHFNncS_8_Tl0clkrX-Jst-1FeRJWHWYpPQe9DLdKTQwfPoLX8Grb0tB-714dcMOFsdTRBd0-ZcYwpkqe-HgGXkenc=@pm.me>
	<87ldv9k9e3.fsf@oracle.com>
	<zp_HRUf7wzFwZMVqR2IwXRMf-WtdNZP-ocWWflDG0nDLg2FXZ0Jt91ztxfBxdHurGC_z4C5M5qPIspVTFMAXG5_hFuDwZRMNmXKak3UnLXk=@pm.me>
User-Agent: mu4e 1.12.7; emacs 31.0.50
Date: Fri, 17 Jan 2025 18:00:08 +0000
Message-ID: <871px1jp7b.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai via Gcc <gcc@gcc.gnu.org> writes:

> On Friday, January 17th, 2025 at 2:44 AM, Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
>
>> [...]
>>
>> > Ok. I disabled the execution of the test_progs-bpf_gcc test runner for now.
>> > 
>> > I think we should check on the state of the tests again after decl_tags
>> > support is landed.
>> 
>> 
>> Thank you. Sounds like a plan :)
>> 
>> Is it possible to configure the CI to send an email to certain
>> recipients when the build of the selftests with GCC fails? That would
>> help us to keep an eye on the patches and either fix GCC or provide
>> advise on how to fix the selftest in case it contains bad C.
>
> In principle, yes. In practice email notifications are not that
> straightforward.
>
> Currently a BPF patch submitter gets a notification about the status
> of the CI pipeline for their patch. This makes sense, recipient is
> obvious in this case.
>
> In case of GCC (or any other CI dependency for that matter), it is
> necessary to determine the potential cause before sending
> notifications. There are all kinds of things that might have caused a
> failure independent of the target being tested: could be a bug in CI
> scripts, or github could have changed runner configuration, or a merge
> commit from (Linux) upstream broke something, etc.
>
> Point is, dependency maintainers (GCC team in this case) don't want to
> get notifications for *all* such failures, because you will have to
> ignore most of them, and so they become noise. A boy crying wolf kind
> of thing.
>
> The other issue is that maintaining email notifications is an
> operational overhead, meaning that the system managing the
> notifications needs to be looked after. Currently for BPF CI it's
> Kernel Patches Daemon instance maintained by Meta engineers [1].
>
> As it stands, if there is problem with GCC that affects BPF CI, you
> can be assured it'll be reported, because it will block the testing of
> the BPF patches.
>
> I suggest GCC BPF team to think about setting up your own automated
> testing infrastructure, focused on testing the GCC compiler. Maybe you
> already have something like that, I don't know. You certainly
> shouldn't rely exclusively on BPF CI for testing the BPF backend.

I think Jose is asking from the angle of wanting to make GCC support as
painless as possible for you upstream, not to ask you to provide a
substitute for our own CI. i.e. We don't want you to feel burdened by
providing that and we're happy to look into any problems as soon as they
arsie.

>
> [1] https://github.com/facebookincubator/kernel-patches-daemon
>
>> 
>> > Thanks.
>> > 
>> > [...]

