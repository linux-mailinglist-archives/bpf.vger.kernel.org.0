Return-Path: <bpf+bounces-52160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8971A3F0D8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CF7017DC
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B90204C22;
	Fri, 21 Feb 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FmAcTuMD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D22046B3;
	Fri, 21 Feb 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131010; cv=none; b=ZIe9fRD60bcvlucaXhtMhmMG49+7EyW4NvGVCv2+PI6WBTswAvFoa3u8/gLIKkUYmTAJ1eGbuMB0nYI1eI4c09pBA/ThTEBRgr13KL9UbmvCLfxuvAn0BvY7d481vL15ZoWUZ0yR/3QRzARuEWNiy03Sara9uvMLd9ThaK+CanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131010; c=relaxed/simple;
	bh=LyR2zZKf5ESahtFq1ig6nTfJHCHBh898KS58abCNjOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQwsFctdjdM8ILv1u5n8GeR27ROl/vbuTAKRNHfkBlqqhp+XTXIhIeAwuSBPzxHRtbjmqSEDc4MpChoQPiR8Vbvg0R+9XdS+57Cnc4dPTKmQtgfVSioAxkalrj9PTYh84f+W10SNiY43T4o9WHiaJqVJVLjbB6MjW6+o+/ZQKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FmAcTuMD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMnaxs030909;
	Fri, 21 Feb 2025 09:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eSgcvvVvljqSxVfALXNZPgVnf+ekr0
	yvWovzwjgyAQY=; b=FmAcTuMDCjB9l2mNpsq2poBs5NzxzsYF37pc07/D5T8AnZ
	I9oLWcGgbV+mforSMtc9BzPuGW7rsbVBw8ocEp4+OMfUgdQchG/mL//ROvt19Mr+
	hv9OAUhurdGmzghLf+nHktskCdeHa0A3ntfywZKFkOuxjvJEGRiOT71Zv6Kn++6X
	io4V6DTIXJZGPPb+UTNU6yitlZNjuZan5gQ7e3ulNY9LZxZm5oRaSRPA4nD53PQW
	WwUq6PNwu8GLPLO+8ERRN6Mhpa6W0hir3piaSu2A7NcS6i7iB3dJWyiCINixBaar
	i/+c/ENwdRIr6cDRBTTBtVJwB/xq0Isc0V02cZ5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdhatg6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 09:42:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8rGu9005844;
	Fri, 21 Feb 2025 09:42:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xq3p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 09:42:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51L9grHC40829232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 09:42:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C7F2014F;
	Fri, 21 Feb 2025 09:42:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8610C2014E;
	Fri, 21 Feb 2025 09:42:52 +0000 (GMT)
Received: from osiris (unknown [9.179.14.8])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 09:42:52 +0000 (GMT)
Date: Fri, 21 Feb 2025 10:42:51 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Martin Kelly <martin.kelly@crowdstrike.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250221094251.11661Ada-hca@linux.ibm.com>
References: <20250217153401.022858448@goodmis.org>
 <20250218145836.7740B3b-hca@linux.ibm.com>
 <20250219102220.3b79ec5e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219102220.3b79ec5e@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tGeBz98IMu-thKTTl-sTAJQe3BEtZNKR
X-Proofpoint-ORIG-GUID: tGeBz98IMu-thKTTl-sTAJQe3BEtZNKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=347 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210072

On Wed, Feb 19, 2025 at 10:22:20AM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 15:58:36 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > > This series removes the place holder __ftrace_invalid_address___ from
> > > the available_filter_functions file.
> > > 
> > > The rewriting of the sorttable.c code to make it more manageable
> > > has already been merged:
> > > 
> > >   https://git.kernel.org/torvalds/c/c0e75905caf368e19aab585d20151500e750de89
> > > 
> > > Now this is only for getting rid of the ftrace invalid function place holders.  
> > 
> > Since you asked me to test this on s390: seems to work with
> > HAVE_BUILDTIME_MCOUNT_SORT enabled; the ftrace selftests still
> > work as before.
> 
> Great!
> 
> I'm guessing by just adding the support in s390 with what is upstream as
> well as what is in my for-next would work?

Yes, both variants work.

> You can just add that for the next merge window then.

It is already in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fa1518875286c94111bdaf1c7bae188c9c426c6b

Thanks for making aware of this!

