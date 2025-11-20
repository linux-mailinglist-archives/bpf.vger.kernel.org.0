Return-Path: <bpf+bounces-75123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF4C71BD2
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D662A2BBFC
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EA1DE8AE;
	Thu, 20 Nov 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7GXIVIn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FE263F30;
	Thu, 20 Nov 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603816; cv=none; b=ByTV7KyZWXGrMe7xs5yvNt0LHlZPIj6+g+5Gc+SV5sGcrnRv9WpkvCblmTluaWXHdxyskYXxzmmzbQRfzFIGltYbiGILxNBxcETka14PdhfuRkTxHnVSMfihzmMHO7n2rHIauQ/2nYTrsHAIARsBpl3zosLF9ikjx4ZoH5WrSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603816; c=relaxed/simple;
	bh=RIzky2Ct4NDFJrpkrSbp3ztWcruyC/Diqy/bvTOKXZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPAGHRoz1Mawm/iY92LxHs2uUIxIGhZYJDoHx4BQVSMpu64LAC28Fnn9KHsf3M7WBxSdx55C2vhUaXxU041rKyXYuUoQx2yp1Tbg7HGgqudT8chu9iwnyci6W8vSfBa4JzD40NddRu9kF15lewqeGMkiIU0bt/BbPfpQ1LwI4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7GXIVIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C42C113D0;
	Thu, 20 Nov 2025 01:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763603815;
	bh=RIzky2Ct4NDFJrpkrSbp3ztWcruyC/Diqy/bvTOKXZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7GXIVInzpdgM+kUNlGfK5V46/wJmmWTc5zeiBevo61EwgOOKnamJ08/1XisRcYzh
	 ZuxEZyiwODeR8rUfc101v0ONLEGP1pOfBx9Pewi6GpnPtqkDzKBIDyEVBowk5GmQ1K
	 SJ+pMc6l9TkZaiTlbdjzQ74PNYSNMJuSz225gSPceZ4LBm8S3cjzJywwu/7EQ27bkZ
	 XO8VIz8hRz/nyqTEODx2BZMn383hi6JyvQcOKM+RaXiCOeoKuEaB8wsncxEiU9LaJA
	 auqtJcfu/G6koD1kRBb7X2C0hRUnMEwZdicjyy/lwjBtH3x1YLSgMZ7RgrpfW+uiJm
	 nOfy+4og3EfnQ==
Date: Wed, 19 Nov 2025 17:56:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Quentin Monnet <qmo@kernel.org>, KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [BUG] bpftool: Build failure due to opensslv.h
Message-ID: <aR51ZSicusUssXuU@google.com>
References: <aP7uq6eVieG8v_v4@google.com>
 <2cb226f8-a67c-4bdb-8c59-507c99a46bab@kernel.org>
 <aP-5fUaroYE5xSnw@google.com>
 <d6a63399-361f-4f1c-845c-b69192bfc822@kernel.org>
 <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c86f05f-2ba3-4f63-8d63-49a3b3370360@oracle.com>

Hello,

On Tue, Oct 28, 2025 at 10:20:22AM +0000, Alan Maguire wrote:
> On 28/10/2025 09:05, Quentin Monnet wrote:
> > 2025-10-27 11:27 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> >> On Mon, Oct 27, 2025 at 11:41:01AM +0000, Quentin Monnet wrote:
> >>> 2025-10-26 21:01 UTC-0700 ~ Namhyung Kim <namhyung@kernel.org>
> >>>> Hello,
> >>>>
> >>>> I'm seeing a build failure like below in Fedora 40 and others.  I'm not
> >>>> sure if it's reported already but it failed to build perf tools due to
> >>>> errors in the bootstrap bpftool.
> >>>>
> >>>>     CC      /build/util/bpf_skel/.tmp/bootstrap/sign.o
> >>>>   sign.c:16:10: fatal error: openssl/opensslv.h: No such file or directory
> >>>>      16 | #include <openssl/opensslv.h>
> >>>>         |          ^~~~~~~~~~~~~~~~~~~~
> >>>>   compilation terminated.
> >>>>   make[3]: *** [Makefile:256: /build/util/bpf_skel/.tmp/bootstrap/sign.o] Error 1
> >>>>   make[3]: *** Waiting for unfinished jobs....
> >>>>   make[2]: *** [Makefile.perf:1213: /build/util/bpf_skel/.tmp/bootstrap/bpftool] Error 2
> >>>>   make[1]: *** [Makefile.perf:289: sub-make] Error 2
> >>>>   make: *** [Makefile:76: all] Error 2
> >>>>
> >>>> I think it's from the recent signing change.  I'm not familiar with
> >>>> openssl but I guess there's a proper feature check for it.  Is this a
> >>>> known issue?
> >>>
> >>>
> >>> Hi Namhyung,
> >>
> >> Hello!
> >>
> >>>
> >>> This looks related to the program signing change indeed, commit
> >>> 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> >>> introduced a dependency on OpenSSL's development headers for bpftool.
> >>> It's not gated behind a feature check. On Fedora, I think the headers
> >>> come with openssl-devel, do you have this package installed?
> >>
> >> No I don't, but I guess it should be able to build on such systems.  Or
> >> is it required for bpftool?  Anyway I feel like it should have a feature
> >> check and appropriate error messages.
> >>
> > 
> > +Cc KP
> > 
> > We usually have feature checks when optional features bring in new
> > dependencies for bpftool, but we haven't discussed it this time. My
> > understanding was that program signing is important enough that it
> > should always be present in newer versions of bpftool, making OpenSSL
> > one of the required dependencies going forward.
> > 
> > We don't currently have feature checks to tell when required
> > dependencies are missing for bpftool (it's just the build failing, in
> > that case). I know perf does a great job at it, we could look into it
> > for bpftool, too.
> >
> 
> One issue here is that some distros package openssl v3 such that the
> #include files are in /usr/include/openssl3 and libraries in
> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
> figure out a feature test that handles that too?

What's the state of this?  Is the fix in the bpf tree now?

Thanks,
Namhyung


