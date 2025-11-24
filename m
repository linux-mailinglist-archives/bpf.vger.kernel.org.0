Return-Path: <bpf+bounces-75394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041EC826DB
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A463ADD44
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BC02E613A;
	Mon, 24 Nov 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roWO5oSC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C891DF75A;
	Mon, 24 Nov 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016944; cv=none; b=FASRvmEfdUQMYDoX3wGlQy93OFeeikPo2x9jxBl/+zZmX81kGoZJIi9zxQ62aVoPlAbpty+8bZY4QJb2Aqcm411H+vlmP8Q3867VKqVZ1PAlhBpqcxh8onn1qBpIzArqURHhichX8If8dcSnyNNjx6nas3v7l7VQdLCh258aBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016944; c=relaxed/simple;
	bh=Si7eTK2/BZuVYtQFbflprK/KYJ4whdcxNyG6sL2lt+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpMCUKC2rBXupBTLvoF+5iEW7drh5sVhV/MLQHu6/q6YlLHZyXLuXkwlNEv1LmqNK77HPL5bpSwLTSO4udB+iyKMNCN2T/mrOTW3ip3E4jaVioNFNvNjjUo5N64Mf2kvvNbLwBJlUgOeYTP/NUBOQKaHPXslHph6Qk3NQkmpLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roWO5oSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA22C4CEF1;
	Mon, 24 Nov 2025 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764016943;
	bh=Si7eTK2/BZuVYtQFbflprK/KYJ4whdcxNyG6sL2lt+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roWO5oSChBQC5M9L+H/X0SrcgcdHG9KED5r9YMT1ouRulQwJq4DMnoC0maaXmz1gG
	 74DzdwNIUH3SupUIJxCYFZ5LVKkxCxzZBNPlKHbRgpcDyOVexU7Ibk7WT54gKgOLgL
	 d/thfo/UQDXRpGpLmuJIf9Kc28vhlzUBycPGmJE9QPMOx4EvPeGu9TPE0Nkx93/GXT
	 zfAj0SxOteqK9fMWlCJ1OEMnUnfWqigYEuhC/8Hh4jaQxHMhNtr+GxpNPF4QmYPcgm
	 R8qAqrpcGcL6RNKRyOKXeHSaYwERTTk3SrTnN1vknSJw/VKZ4/Xkl242m9C1v8R/Pz
	 mNmGj1jLfwUeA==
Date: Mon, 24 Nov 2025 12:42:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
Message-ID: <aSTDLrUqeZ3xwEhA@google.com>
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
 <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>
 <aR51ZSicusUssXuU@google.com>
 <fbd98bd0-a89c-4903-af06-fd1f2fb4ae16@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbd98bd0-a89c-4903-af06-fd1f2fb4ae16@kernel.org>

On Thu, Nov 20, 2025 at 09:24:49AM +0000, Quentin Monnet wrote:
> 2025-11-19 17:56 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> > Hello,
> > 
> > On Tue, Oct 28, 2025 at 10:20:22AM +0000, Alan Maguire wrote:
> >> On 28/10/2025 09:05, Quentin Monnet wrote:
> >>> 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> >>>> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
> >>>>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> >>>>>> Hello,
> >>>>>>
> >>>>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
> >>>>>> sure if it's reported already but it failed to build perf tools due to
> >>>>>> errors in the bootstrap bpftool.
> >>>>>>
> >>>>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
> >>>>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
> >>>>>>      16 | #include <openssl/opensslv.h>
> >>>>>>         |          ^~~~~~~~~~~~~~~~~~~~
> >>>>>>   compilation terminated.
> >>>>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
> >>>>>>   make[3]: *** Waiting for unfinished jobs....
> >>>>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
> >>>>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
> >>>>>>   make: *** [Makefile:76: all] Error 2
> >>>>>>
> >>>>>> I think it's from the recent signing change.  I'm not familiar with
> >>>>>> openssl but I guess there's a proper feature check for it.  Is this a
> >>>>>> known issue?
> >>>>>
> >>>>>
> >>>>> Hi Namhyung,
> >>>>
> >>>> Hello!
> >>>>
> >>>>>
> >>>>> This looks related to the program signing change indeed, commit
> >>>>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> >>>>> introduced a dependency on OpenSSL's development headers for bpftool.
> >>>>> It's not gated behind a feature check. On Fedora, I think the headers
> >>>>> come with openssl-devel, do you have this package installed?
> >>>>
> >>>> No I don't, but I guess it should be able to build on such systems.  Or
> >>>> is it required for bpftool?  Anyway I feel like it should have a feature
> >>>> check and appropriate error messages.
> >>>>
> >>>
> >>> +Cc KP
> >>>
> >>> We usually have feature checks when optional features bring in new
> >>> dependencies for bpftool, but we haven't discussed it this time. My
> >>> understanding was that program signing is important enough that it
> >>> should always be present in newer versions of bpftool, making OpenSSL
> >>> one of the required dependencies going forward.
> >>>
> >>> We don't currently have feature checks to tell when required
> >>> dependencies are missing for bpftool (it's just the build failing, in
> >>> that case). I know perf does a great job at it, we could look into it
> >>> for bpftool, too.
> >>>
> >>
> >> One issue here is that some distros package openssl v3 such that the
> >> #include files are in /usr/include/openssl3 and libraries in
> >> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
> >> figure out a feature test that handles that too?
> > 
> > What's the state of this?  Is the fix in the bpf tree now?
> 
> 
> Hi Namhyung, Alan just submitted a v2 of his patch (targetting
> bpf-next), see:
> 
> https://lore.kernel.org/all/20251120084754.640405-2-alan.maguire@oracle.com/
 
Hello Quentin,

I'm afraid it doesn't fix my issue.  It seems to fix another problem
about the error API.  But I still see the build failure.

Thanks,
Namhyung


