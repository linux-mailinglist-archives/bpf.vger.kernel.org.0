Return-Path: <bpf+bounces-55086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BDA77F99
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB941885931
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA320C481;
	Tue,  1 Apr 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YAOZl+tc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF237160
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522854; cv=none; b=uLz273KbZbMNmdEj5njCYVx7fNnXb2ekcXNoX9CC3qrUGI1dq7BQ3xJnmcLkchzAQzF2Rm2PFvCFOZz1JS03J2mnTSc5QQz3ABtNwAjAUX7BMnJtRL8VETk5FzQ7oq2KIa+6JhBfXIW3143P0UdvClGcewuRgw/Pc0RfRbaHMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522854; c=relaxed/simple;
	bh=ZFA0yVI3UYiZQnRBU+RGdoE40VIqwmij7YchgMiohIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7lCJh1wP6opdqRwPv88KPkC4ieiEXRlZtwbVuPFvypZFR8A0uqAgySD1oK/zWIPfQ3+YGP+tgXvCCG4GRvbwNEPKknb1zdgk5CSB6Q306gJI+Za3RXnV7/fEKkUv7Tc8ssu8U9Imk98xGNNMzBjxwUiJOlZW8d1fyvL2o1OCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YAOZl+tc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531E3IUE011758;
	Tue, 1 Apr 2025 15:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VVZrHrHVFTiwIjChPXp3QNULr+GZaI
	aw64nWjsSBAPI=; b=YAOZl+tcDjENOLwBmPFMR4IVb6wArvkLXfon5c5fLUYtsc
	SysuFxmhDyL5X2V2xuPbgM0t1t8zPCG7IoUsQmblodsFT9mWmZbBs2XSlnBuWEYo
	LTTnRkoYHOzlKA8cvJYCtZhS2AeNSzxSTkUufcDGmJZq/Up52RtzF47RCtI2PKrb
	iNCjkEGC/XmprpjWVCnDYGJbJOuJruh2FmoR+WdCXa/mcFIMEsAramDR932ktvan
	abOHk84t5XasrekGAQdRe4ev6aa9cqFL7Y+cAIckqFx358vyaFar/yBykUHJ8amL
	EfwEMisNeiea6g2KrWA5jY1jgX+MwJcHBjbgQXlg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rhjprjup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 15:53:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531DV4Wt001719;
	Tue, 1 Apr 2025 15:53:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45rddkscdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 15:53:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531FriR656885554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 15:53:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB6E20049;
	Tue,  1 Apr 2025 15:53:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E075320040;
	Tue,  1 Apr 2025 15:53:43 +0000 (GMT)
Received: from localhost (unknown [9.171.61.169])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Apr 2025 15:53:43 +0000 (GMT)
Date: Tue, 1 Apr 2025 17:53:42 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: iii <iii@imap.linux.ibm.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        kernel-team@meta.com, Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: s390x: selftests/bpf are failing on CI
Message-ID: <your-ad-here.call-01743522822-ext-4975@work.hours>
References: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
 <7d55acbf6e6b20f9e8d679883c1e77391e80b304@linux.dev>
 <1199a2932ed1800fa0a898e67ba74590@imap.linux.ibm.com>
 <a1b5ac5e01e50a6f3dc1047a08b725d6@imap.linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1b5ac5e01e50a6f3dc1047a08b725d6@imap.linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 56G8wkuO8RwIH1JJgmKCrwT_ppDatgJX
X-Proofpoint-ORIG-GUID: 56G8wkuO8RwIH1JJgmKCrwT_ppDatgJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=847 phishscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010096

On Tue, Apr 01, 2025 at 05:16:28PM +0200, iii wrote:
> On 2025-04-01 10:06, iii wrote:
> > On 2025-04-01 00:45, Ihor Solodrai wrote:
> > > On 3/31/25 3:25 PM, iii wrote:
> > > > On 2025-03-31 20:25, Ihor Solodrai wrote:
> > > > > Hi Ilya,
> > > > > 
> > > > > After recent merges from upstream, CI started failing both
> > > > > on bpf and
> > > > > bpf-next trees. Yonghong Song and Song Liu submitted a
> > > > > couple of fixes
> > > > > that are already applied to bpf tree, but there are still
> > > > > failures on
> > > > > s390x.
> > > > > 
> > > > > https://github.com/kernel-patches/bpf/actions/runs/14163772245
> > > > > 
> > > > > Could you please investigate?
> > > > > 
> > > > > [...]
> 
> I could not reproduce this on a s390x machine, so I downloaded the CI
> artifacts and noticed that
> /sys/kernel/debug/tracing/available_filter_functions is empty.
> Turns out this is caused by cross-compilation.
> I have let our kernel team (on Cc:) know and they will investigate this
> further.

There must be an endianness issue in the sorttable tool. Reverting just
the commit fa1518875286 ("s390: Sort mcount locations at build time")
fixes the issue. I'll take a look.

