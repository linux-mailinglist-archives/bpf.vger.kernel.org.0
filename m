Return-Path: <bpf+bounces-15173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1F7EE1FA
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A8E1F2450F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7730CE7;
	Thu, 16 Nov 2023 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d7hHsHsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5DEAF;
	Thu, 16 Nov 2023 05:54:54 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDoPsZ012042;
	Thu, 16 Nov 2023 13:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k4+XzjxisPHaDAbUWdypNQD1W73qMIUcQhfWlrRelXg=;
 b=d7hHsHsZ9BS848uJUmYOfx/wk/1Pq/08h6cJowBK8V/V0Scp79OJRpC+/Ff0E0PbSTDD
 1u8e5sg0nmzjy5V/Llwx6GIqAgU0MyfNAfLZDXJADiJ/9nmcAkZdqgQWROLfn4+V7l3P
 fNmHK/kN+R4EmGsZsAdCEURe7vvw3O1OvrFwAG4h6T93x3konNn7VmhKdFjQRgEN5Qvl
 F16Hyup3hpFHeEYP8JSKIbX6SULG1/zj6JUlAgp4NF4yX6AXaWxO9iLlnwCemRZd3DRV
 mBhq5HVuF8CecBg2QJj5Rf57HqzETYEtbyISwetqNAFdjjLXyQSris0KVlxximNaWtfQ Mg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udmamr48u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 13:54:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBVKOh003493;
	Thu, 16 Nov 2023 13:54:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayq67c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 13:54:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGDsNit5112390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 13:54:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54BC20043;
	Thu, 16 Nov 2023 13:54:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D5620040;
	Thu, 16 Nov 2023 13:54:23 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Nov 2023 13:54:23 +0000 (GMT)
Date: Thu, 16 Nov 2023 14:54:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
Message-ID: <20231116135421.22287-A-hca@linux.ibm.com>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
 <20231115153139.29313-A-hca@linux.ibm.com>
 <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: liBaMNIlxU-nrf3Ohmh4w-GHdF05LtXt
X-Proofpoint-ORIG-GUID: liBaMNIlxU-nrf3Ohmh4w-GHdF05LtXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_13,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxlogscore=286
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311160108

On Thu, Nov 16, 2023 at 09:15:26AM +0800, Hou Tao wrote:
> > If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
> > this is a realistic scenario) the memory consumption directly after boot
> > is:
> >
> > $ cat /sys/devices/system/cpu/present
> > 0-5
> > $ cat /sys/devices/system/cpu/possible
> > 0-511
> 
> Will the present CPUs be hot-added dynamically and eventually increase
> to 512 CPUs ? Or will the present CPUs rarely be hot-added ? After all
> possible CPUs are online, will these CPUs be hot-plugged dynamically ?
> Because I am considering add CPU hotplug support for bpf mem allocator,
> so we can allocate memory according to the present CPUs instead of
> possible CPUs. But if the present CPUs will be increased to all possible
> CPUs quickly, there will be not too much benefit to support hotplug in
> bpf mem allocator.

You can assume that the present CPUs would change only very rarely. Even
though we are only talking about virtual CPUs in this case systems are
usually setup in a way that they have enough CPUs for their workload. Only
if that is not the case additional CPUs may be added (and brought online) -
which is usually much later than boot time.

Obviously the above is even more true for systems where you have to add new
CPUs in a physical way in order to change present CPUs.

So I guess it is fair to assume that if there is such a large difference
between present and possible CPUs, that this will also stay that way while
the system is running in most cases.

Or in other words: it sounds like it is worth to add CPU hotplug support
for the the bpf mem allocator (without that I would know what that would
really mean for the bpf code).

Note for the above numbers: I hacked the number of possible CPUs manually
in the kernel code just to illustrate the high memory consumption for the
report. On a real system you would see "0-399" CPUs instead.
But that's just a minor detail.

