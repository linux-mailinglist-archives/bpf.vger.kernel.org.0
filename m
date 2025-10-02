Return-Path: <bpf+bounces-70223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B4BB4C2E
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119D62A82AF
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708382749CB;
	Thu,  2 Oct 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+CIKciE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDB26E71F;
	Thu,  2 Oct 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427915; cv=none; b=BTTHoT/vXgaqu0Z6qeCPZsxPbjLeJ5wEkNUoURp2Keh64cD2yzqg66blKXa9oIxrkDuYLzbLSqsfAq+V2kxIjP+BrejFC6qALv8fehMhq2UgnQ04AivOJtn1k9aXg+b2SlCcM6kdiTirsg9EnLAenRdgEAFjq3v1Zk8gkneMiyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427915; c=relaxed/simple;
	bh=Gu94/4ZwgZFIOwmyLK42k6VmXdFuRJ4upet3VdokhZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1ZbMGS6DGBp/v//O8ropnJfeu0EsJXqxO83UrhbNgLdTrrlDHSwU+mJms64mXYG06bGC6fU+oHEE5R6b148p0J71gZJr84r9DHW+ZEjiieoDJ3WC5C+iuEFktPWlt59cvxD0n9WnnixYvDGCOCGwP85VQgULXAfWn/IDVTcvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+CIKciE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4BDC4CEF4;
	Thu,  2 Oct 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427914;
	bh=Gu94/4ZwgZFIOwmyLK42k6VmXdFuRJ4upet3VdokhZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+CIKciER6rtzyebO9KGQfQZ8RoYi4l5PpnAnx3Vj/9CnQV5rsjx3BNpfn0wNEKNm
	 QjgTXeZy3Bf5Ky6jBnfZ/yQJhVvNSGZQBak3prkQY/9r295soACJceLpV53A/CBKAX
	 UK7hE5pfCa0m/wd1+dAmsbelBCFR2OWRoA84U7q2Ef30rCeUuvv1WjEwTkwFOEd8Tj
	 2t/YQ2SaW5y9m29wkjFo9Iz8KbCsLudxv6BYklbOuatU7XOgeXle/gr+jvy05dWEmp
	 bwhGneUdhk0rjA4jO6quD6WPeWze2yXHcEjS+6u7KBqVGuEouuwc8/olAf4lTPvb7M
	 2c/2cRF/Xl4ow==
Date: Thu, 2 Oct 2025 14:58:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrew Pinski <apinski@quicinc.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	"Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>,
	Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Andrew.pinski@oss.qualcomm.com" <Andrew.pinski@oss.qualcomm.com>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Message-ID: <aN69RSQQ8agXOBDH@x1>
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev>
 <aN629m1MlMXYh1te@x1>
 <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>

On Thu, Oct 02, 2025 at 05:35:09PM +0000, Andrew Pinski wrote:
> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
> > So I'm taking the patch as-is, ok?

> > But first we need the Signed-off-by tag from Andrew Pinski as
> > he is listed in a Co-authored-by, that I replaced with Co-
> > developed-by as its the term used for this purpose in:

> > Yonghong, can I add an Acked-by: you since you participated in
> > this discussion agreeing with the original patch (If I'm not
> > mistaken)?

> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
 
> Note my email address for doing Linux and GCC development is
> Andrew.pinski@oss.qualcomm.com . It was apinski_quic@quicinc.com but
> that changed last month.

This is what I have in the patch now:

Co-developed-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>

- Arnaldo

