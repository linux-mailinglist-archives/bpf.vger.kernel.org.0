Return-Path: <bpf+bounces-70431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFCBBEEEC
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF7F3AA056
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661C2DF717;
	Mon,  6 Oct 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqRNH5MM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001D2D061C;
	Mon,  6 Oct 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774973; cv=none; b=pG+Lslm+UhoJNyyKOg9AUNEdsTW99rYOUCoafKB5YG8ox6Zexjr7OWKD6JNuabiWONHgx7ie2BZmgxc836U83ro2NdCyXnbOzNATUUHvANKOIXup05TeRPT5qJLAt7/R/Ajoo5yERBlzhpu3mILqU6WiqdIZmP7pu7Xpu88CoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774973; c=relaxed/simple;
	bh=VeyCToPRr3H7Y8ZIR+jf+bsltx7or5qtLdkn6QYm1XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObaA3KlREj5jOJ30/nIRwRJi5KPzdAKSe15JrnpSc4eX6fARs4Bw2sPlv2v9NiRovmGj1nYQOnWKuJdVOgKBhX7iTMep4GH06yCxYv8EkPfz9Y9QS66hgsGUaM9mA12+NJcNw5AG9ra4/njjHN2dNaGmwHF8SvEsJav17kpCfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqRNH5MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2598CC4CEF5;
	Mon,  6 Oct 2025 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774971;
	bh=VeyCToPRr3H7Y8ZIR+jf+bsltx7or5qtLdkn6QYm1XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqRNH5MMYkHULwb4E/bqckXnR9kayp1cTGHE8PZFQBazERdBU5pYJ3PrcsMyzz5vZ
	 bATDOKda/5qTPZzZVUt3AurPqTFyjUVZQRGO7i3qDjp3pAgHA59CvIlQWXOhhhErnY
	 gyV+Wqh2oIWcAPYuHznmCVr73YBbrP+8pXnd9dw8LYVje8XlZiI0QYwSWBxrUHyVhb
	 ypefrwzmLS7BiAUBUYAzk1f1wQ0KUIe/IgSnA6jZqRVNDDFBgHeAVrlsLiV6ZausSu
	 YCXfrv5aZxg2l7EzwZpHxjeVUEoLh4k66TeM9sYKyU320JaboNpTuXUE8eNIuxGPQV
	 uhGykB8NJBxnA==
Date: Mon, 6 Oct 2025 15:22:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrew Pinski <quic_apinski@quicinc.com>,
	Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Message-ID: <aOQI-KJHaQZCsX0D@x1>
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev>
 <aN629m1MlMXYh1te@x1>
 <80d42369-3e23-453e-86a1-2fdb57bb78c8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d42369-3e23-453e-86a1-2fdb57bb78c8@linux.dev>

On Sat, Oct 04, 2025 at 04:19:48PM -0700, Yonghong Song wrote:
> On 10/2/25 10:31 AM, Arnaldo Carvalho de Melo wrote:
> > But first we need the Signed-off-by tag from Andrew Pinski as he is
> > listed in a Co-authored-by, that I replaced with Co-developed-by as its
> > the term used for this purpose in:
 
> > Yonghong, can I add an Acked-by: you since you participated in this
> > discussion agreeing with the original patch (If I'm not mistaken)?
 
> LGTM.
 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
 

Thanks, added to the cset,

- Arnaldo

