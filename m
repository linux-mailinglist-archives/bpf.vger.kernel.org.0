Return-Path: <bpf+bounces-41507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F89997994
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FE61F22F4F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B2B663;
	Thu, 10 Oct 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLKuk00n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAC28F1;
	Thu, 10 Oct 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519773; cv=none; b=GcG/JqaIugvBUio445tOvr6CVUsgbxgyWjdzG6DCJGuQgeW7OGRqk/EJAQX2m6iBLOnWCrPeew4B/34aZG7djS5vpB+CRfY0WJD/PpqWg9omOjN+wHCI7IbZGC+Mprozzh+7zwgwJ0nMz98UGAs1kVHXqydrkJTVgJNyCQKFg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519773; c=relaxed/simple;
	bh=QeHDIQcPBZ6hCPQRGNqJUDnSPF4LDoi4wKN3VkkkBZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUKXGYExOvrEbwIcuxDjUiV6PmYe7UOdnUJOg5MSFHQwolQjiQNUrZlbyDAwp2pu14OYJMyEMCgYl013EFjla0AeIfoHI0g/2OIA2TE0GwAuPFvLC6R+VlhYcx0SpNNZpgN0nUVvoPabsPMTURmElVFU1pnNECwvafSsabM6Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLKuk00n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1123C4CEC3;
	Thu, 10 Oct 2024 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728519773;
	bh=QeHDIQcPBZ6hCPQRGNqJUDnSPF4LDoi4wKN3VkkkBZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLKuk00nF/ieu6IVmNwwqzC2Bs3X/xEaaDEpSK4sNmi8PAoTv0NriRI5oPN3I7FoK
	 najpdKyVucp4PlA7YxLUls6yjYGRxrjIzLRGPhEoGZh/t3Q6mjhzY4PFcqHd8Wjn+3
	 g+LGzRoLUsrNPa2KngVifoVFtAmBXKljcs/YF9hMXh58C1ES8RvAhPF/hauqydvcS2
	 VI8DIZMRTzKrnHr5iers1k/nku+Tmv2m46fRkiSz2vmLE/xMflwFhzflKxsblk6TIv
	 4+w7876uLdZ88BeDrzpJzZoQm+PFdOfjWMXYt3b68M62NJia1ZKxTaavgPhf9of2iL
	 KISW9025Lw2yg==
Date: Wed, 9 Oct 2024 17:22:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v3 0/2] perf stat: Support inherit events for bperf
Message-ID: <ZwceWxIoRw8r7ZIe@google.com>
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <729eef63-6aed-44db-b18a-eb4bf96aeaab@huaweicloud.com>
 <ZvTYduigMBtlmNbK@google.com>
 <ZwYS4FEP5yMOCXEv@google.com>
 <CAPhsuW5nDNicW5Pbavt60Q9W0rcgzLPRnfP7794T-SL0PkugAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5nDNicW5Pbavt60Q9W0rcgzLPRnfP7794T-SL0PkugAA@mail.gmail.com>

Hi Song,

On Wed, Oct 09, 2024 at 10:21:05AM -0700, Song Liu wrote:
> Hi Namhyung,
> 
> On Tue, Oct 8, 2024 at 10:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 08:43:50PM -0700, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Wed, Sep 25, 2024 at 10:16:16PM +0800, Tengda Wu wrote:
> > > > Hello,
> > > >
> > > > Sorry for pinging again. Is there any other suggestion with this patch set?
> > > > If there is, please let me know.
> > >
> > > Sorry I was traveling last week.  I think it's good now.
> > >
> > > Song, can I get your ack?
> >
> > He seems to be very busy.  I'll pick this up and run some tests.
> 
> Sorry for the late reply. I somehow missed the earlier email.

No worries.

> 
> I have a question and a nitpick for 1/2. Otherwise, this looks good
> to me.

Thanks for your reivew!
Namhyung


