Return-Path: <bpf+bounces-49439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17519A18B17
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 05:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057E73AC531
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 04:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76B170A11;
	Wed, 22 Jan 2025 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LCfNkPAL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06933991;
	Wed, 22 Jan 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737520802; cv=none; b=CZ9AN26bkgCIL2gfLCATKZaaVyWfS5PJqq80v7GsI3r2mXdFYmcj3FhJ4w5CPyIv+38VkerDB8lJXoi70qrYZfCRZqDrTnc1XY97KhdQB+23E73sCtlzaFCLqnauzYa5Lu6HgovGDyBHrC6Wl+ViXS7OVSF4YN2xZXXh5vm4erI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737520802; c=relaxed/simple;
	bh=vozpJzoYh8NFazwcE0sbja2bDFoFPU5h6TA6RG2F2eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0+C1ddnSNu1KNbj25bv3kXHToP33N5ES7xARKsNJgrvRUtqecXlIG+bYbNyBaYElBO2903x2d9DjFruugAveXl3LXQfWb/NGNAV9o22t8T1uZWNTOJkp1i135zGgH9ke8kQtqdnLkwisgX6nIZpkwx1m07emDwn1LGUZfHOpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LCfNkPAL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M18O0q013816;
	Wed, 22 Jan 2025 04:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Uj1IBKSyRAR9M7uS0BMNRa1ZCi7T/v
	zkm1EVAV7KiDc=; b=LCfNkPAL9XOiNff3jWXdS3v6u7HvDU+yx/KMiEz10OID+h
	BHF+qdBG30yg0+vkh39dKE+YPVI9RDipo2vo/0K8+88vRvRQEwYNEvPBDCVlUgVF
	T2QsHWKovqldZ60UymJ0NVPl84Roh53Sw4PXe+Jt3e92qxJt0cPdKAXKrPqq/p2+
	GY9mszuG52k4hloJInmgQ8QtZbeb7PtVXoZ2VPXDBX0KGpp3CsBBO/ebmrzOo8t+
	ytK4pgvSibbA2iWu1pEBSuI6S1zmI2jIwMz/DZCQlQpMjn3TKBgDHxiUXiOVeWv7
	AGn7kwtKvA1OaCqR9bC5H6Ed1EwwMn2uLik99WTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr98pb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 04:39:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50M4dEAc032338;
	Wed, 22 Jan 2025 04:39:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr98pb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 04:39:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1MuQv022387;
	Wed, 22 Jan 2025 04:39:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k6mpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 04:39:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50M4d8EP34538106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 04:39:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D831E20043;
	Wed, 22 Jan 2025 04:39:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41AAB20040;
	Wed, 22 Jan 2025 04:39:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.19.247])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jan 2025 04:39:03 +0000 (GMT)
Date: Wed, 22 Jan 2025 10:09:00 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
        sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
Message-ID: <Z5B2ZFRWsuBviC/Q@linux.ibm.com>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
 <20250116074442.79304-6-alibuda@linux.alibaba.com>
 <Z49Bv8ySi2EJ/jfl@linux.ibm.com>
 <20250122024651.GB81479@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122024651.GB81479@j66a10360.sqa.eu95>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q9lflqyZ0u44bxu6ZGJfEd2KlfghN-gc
X-Proofpoint-ORIG-GUID: Q41V1KpJ1CnwKQ7Q8J91CM5w7UWBe_ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_01,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220030

On Wed, Jan 22, 2025 at 10:46:51AM +0800, D. Wythe wrote:
> On Tue, Jan 21, 2025 at 12:12:07PM +0530, Saket Kumar Bhaskar wrote:
> > On Thu, Jan 16, 2025 at 03:44:42PM +0800, D. Wythe wrote:
> > > This tests introduces a tiny smc_ops for filtering SMC connections based on
> > > IP pairs, and also adds a realistic topology model to verify this ops.
> > > 
> > > Also, we can only use SMC loopback under CI test, so an
> > > additional configuration needs to be enabled.
> > > 
> > > Follow the steps below to run this test.
> > > 
> > > make -C tools/testing/selftests/bpf
> > > cd tools/testing/selftests/bpf
> > > sudo ./test_progs -t smc
> > > 
> > > Results shows:
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > ---
> > >  tools/testing/selftests/bpf/config            |   4 +
> > >  .../selftests/bpf/prog_tests/test_bpf_smc.c   | 397 ++++++++++++++++++
> > >  tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
> > >  3 files changed, 518 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
> > > 
> > > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > > index c378d5d07e02..fac2f2a9d02f 100644
> > > --- a/tools/testing/selftests/bpf/config
> > > +++ b/tools/testing/selftests/bpf/config
> > > @@ -113,3 +113,7 @@ CONFIG_XDP_SOCKETS=y
> > > +};
> > Tested this selftest with patches applied on powerpc.
> > 
> > #./test_progs -t bpf_smc
> > 
> > net.smc.ops = linkcheck
> > #27/1    bpf_smc/topo:OK
> > #27      bpf_smc:OK
> > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > 
> > Thanks,
> > Saket
> 
> Hi Saket,
> 
> Thanks for your testing. I hope you don't mind if I add your test-by in
> the next version.
> 
> Best wishes,
> D. Wythe
> 
Fine for me Wythe.

Thanks,
Saket
> > > -- 
> > > 2.45.0
> > > 

