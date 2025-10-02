Return-Path: <bpf+bounces-70224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66537BB4C6B
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699D732352F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42427A10F;
	Thu,  2 Oct 2025 18:01:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85082798EC;
	Thu,  2 Oct 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428080; cv=none; b=T7DLCJNSNePtOdcCI3DKr44GYrF+Hrq7GpoBCSDDEPc0+cXkVAfroaSvSXPC/NK/fGDBuvg4Lemu1HNSHHefwIhItS0AdxkQZ0+CMFC64u0mFGq6hkYmcHXH5bd+khnx5Yn6Rtve1LehfSn53OPyHaYd2VwSynFpoIRD9GcCZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428080; c=relaxed/simple;
	bh=3Okw5ifb9rLUlWRI5FmlFu9g7uRHkmz5MKZJThzoFO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MMLGFqNl2WfpDD75ZfqD8cqq7vvixsLetZRvZ01yC38f1V/r7z/gs1SANOe1RjuSk3SMOhiGKW3mSAUlkj4V/DLzPQYa27AcF8ZWVqBwFQg9ZhiNoeVwyuShadweLBFh6tF2VIxaO/QweroqecV2dvuU+IiXP5L9JcVV6hzul70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AE3A2340DE1;
	Thu, 02 Oct 2025 18:01:15 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrew Pinski <apinski@quicinc.com>,  Yonghong Song
 <yonghong.song@linux.dev>,  "Andrew Pinski (QUIC)"
 <quic_apinski@quicinc.com>,  Namhyung Kim <namhyung@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Mark
 Rutland <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  "Liang, Kan" <kan.liang@linux.intel.com>,
  "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "Andrew.pinski@oss.qualcomm.com" <Andrew.pinski@oss.qualcomm.com>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
In-Reply-To: <aN69RSQQ8agXOBDH@x1>
Organization: Gentoo
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
	<aJPmX8xc5x0W_r0y@google.com>
	<CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
	<043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev> <aN629m1MlMXYh1te@x1>
	<CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
	<aN69RSQQ8agXOBDH@x1>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Thu, 02 Oct 2025 19:01:13 +0100
Message-ID: <87wm5dtc7q.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> On Thu, Oct 02, 2025 at 05:35:09PM +0000, Andrew Pinski wrote:
>> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
>> > So I'm taking the patch as-is, ok?
>
>> > But first we need the Signed-off-by tag from Andrew Pinski as
>> > he is listed in a Co-authored-by, that I replaced with Co-
>> > developed-by as its the term used for this purpose in:
>
>> > Yonghong, can I add an Acked-by: you since you participated in
>> > this discussion agreeing with the original patch (If I'm not
>> > mistaken)?
>
>> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
>  
>> Note my email address for doing Linux and GCC development is
>> Andrew.pinski@oss.qualcomm.com . It was apinski_quic@quicinc.com but
>> that changed last month.
>
> This is what I have in the patch now:
>
> Co-developed-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>

Looks good if Andrew is happy. Thanks!

>
> - Arnaldo

