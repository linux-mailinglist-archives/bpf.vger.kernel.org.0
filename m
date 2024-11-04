Return-Path: <bpf+bounces-43877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC09BB099
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CC3B2175F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008D1B0F14;
	Mon,  4 Nov 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ggM8l7oV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A51AF0DD;
	Mon,  4 Nov 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714889; cv=none; b=HEmz95dfxmwhz9BwimYNlKX/whjXmu+FCDMVJnV46TuOKyZFb61FzKjCyVm91ipASgpAqVVyJwi0pgDt5G1iRHBTjeCUgJDOuh8nBCCdMFua7p+R5UEEtzV7CFUtqkaJLddxmmQjLl2ssi2zAAXqrRhhKq/PIL5Y7I/305TeBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714889; c=relaxed/simple;
	bh=f8HYPb8VjRWHbkzsO7hlkNdCSNC8iTfyKwTeOs/Jfl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rdwlxa4fDGjrE/qeQEHbZNo3ZMOTjoEj2J70QxdmzO9h5E5KYJdQWkdBMwMeuutN9uU4Q9X7GKDKz3CLRxJGBIgYcG/dlMWWSpVElAMbkEUR7KyedcfG/HPDD5UGMpn2EaiqkiD01Bh7EEl9zXXe1nXq89gJcxqE5ln7Yx5bKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ggM8l7oV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A49APa3021749;
	Mon, 4 Nov 2024 10:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f8HYPb
	8VjRWHbkzsO7hlkNdCSNC8iTfyKwTeOs/Jfl0=; b=ggM8l7oVNId+3+uGWJ3F3+
	Az2Ig8L0hd3vwQoZ3Di8B3h4J5VRGynRlE8KgKLIs9mRy5pKf6UvlEqU6dgnd/9D
	nSDEJoIdH0G+BkopVApIT0oDcPHVi48lz4mJSnRTsQMKaN6TtdjnKHJopWC9aye9
	Y7g75bbtAAaHuVvJBKk9OJgRDIQIYa3SI7YsOCkrTEBV5+eHcIp6r1UsLHEq4EcE
	1Z1y/mpWsV4diCmQufz9EIZsXCVVFE/OHfpvVNlrDoQYb7WiknDS3MLaqhpl+Vs/
	DBh0LK2yBwh2SoW/uU6JlU7xjmdDbgLAdTfjI6dBU1PW/btLQBNAS46oAHJbeoHw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pud5066a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:07:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A4A7gts004252;
	Mon, 4 Nov 2024 10:07:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pud50664-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:07:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A49l0NZ008430;
	Mon, 4 Nov 2024 10:07:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywk3kc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:07:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4A7dVS65077744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 10:07:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D20720091;
	Mon,  4 Nov 2024 10:07:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9A220090;
	Mon,  4 Nov 2024 10:07:38 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 10:07:38 +0000 (GMT)
Message-ID: <d5137f25846ebf585383de4d994d388eabab9d60.camel@linux.ibm.com>
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Hou Tao <houtao@huaweicloud.com>, Byeonguk Jeong <jungbu2855@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        Alexei
 Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 04 Nov 2024 11:07:38 +0100
In-Reply-To: <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
References: <ZycSXwjH4UTvx-Cn@ub22>
	 <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eCZKVjMiPO-fZnlvsgHXnS5e5h0DNfqO
X-Proofpoint-GUID: qG9CBpujW-v2rW9RMmtxHZCshnlStUUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=319 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040089

On Mon, 2024-11-04 at 09:34 +0800, Hou Tao wrote:
> Hi,
>=20
> On 11/3/2024 2:04 PM, Byeonguk Jeong wrote:
> > Hi,
> >=20
> > The selftest "verifier_bits_iter/bad words" has been failed with
> > retval 115, while I did not touched anything but a comment.
> >=20
> > Do you have any idea why it failed? I am not sure whether it
> > indicates
> > any bugs in the kernel.
> >=20
> > Best,
> > Byeonguk
>=20
> Sorry for the inconvenience. It seems the test case
> "verifier_bits_iter/bad words" is flaky. It may fail randomly, such
> as
> in [1]. I think calling bpf_probe_read_kernel_common() on 3GB addr
> under
> s390 host may succeed and the content of the memory address will
> decide
> whether the test case will succeed or not. Do not know the reason why
> reading 3GB address succeeds under s390. Hope to get some insight
> from
> Ilya.=C2=A0 I think we could fix the failure first by using NULL as the
> address of bad words just like null_pointer test case does. Will
> merge
> the test in bad_words into the null_pointer case.

Hi,

s390 kernel runs in a completely separate address space, there is no
user/kernel split at TASK_SIZE. The same address may be valid in both
the kernel and the user address spaces, there is no way to tell by
looking at it. The config option related to this property is
ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

Also, unfortunately, 0 is a valid address in the s390 kernel address
space.

I wonder if we could use -4095 as an address that cannot be
dereferenced on all platforms?

Best regards,
Ilya

