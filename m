Return-Path: <bpf+bounces-8666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C8788DEE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE91C20FA6
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7518042;
	Fri, 25 Aug 2023 17:43:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81A107A8
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:43:29 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA852128
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:43:28 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHOms8010218;
	Fri, 25 Aug 2023 17:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zt6pL7o20Yixc3NyiECNrphOeta0tiESWhSHl/XnpCA=;
 b=LdIJGv4SWGdJIasFYubik2xK8Nwe11QR89489e+9bgbddqk3nSd/i39WA9M2f+CVvHER
 P99LcgDp8Szig1Gb21r63Jd2sb/5yK/4FbzGCORmgGQJIZ8Ntz7efmXzNmheyd8J1QdV
 iawTeen6gPtuxoleYjoxogZHzu3WTsx5oJ81mmOYZx+isZPexuf+gydQ5WKFlJjAqcFq
 0uCbKLsreF4AGhKZy02ix3Fx/0r6SKvtNG7xs9i8LQw7VfHF8kAJxX1B9oUhVT8Y0eVc
 ZJPH+10HWJW7mD1iWNnH2kgILUszTZPfumoRdvNy348Qy02AqU4wQlE2h1uiqIx689aE IQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sq0p7gcht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 17:43:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFLhEg004055;
	Fri, 25 Aug 2023 17:43:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21s1bhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 17:43:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PHh3K759834692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 17:43:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8882004D;
	Fri, 25 Aug 2023 17:43:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56FE220040;
	Fri, 25 Aug 2023 17:43:01 +0000 (GMT)
Received: from [9.43.126.199] (unknown [9.43.126.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Aug 2023 17:43:01 +0000 (GMT)
Message-ID: <62ca8ed7-8ae6-19ed-44a4-e8eec453d35f@linux.ibm.com>
Date: Fri, 25 Aug 2023 23:13:00 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/5] powerpc/bpf: use patch_instructions()
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>
References: <20230825151810.164418-1-hbathini@linux.ibm.com>
 <20230825151810.164418-6-hbathini@linux.ibm.com>
 <5f41d2e4-878b-1c0b-f888-96b977065207@csgroup.eu>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <5f41d2e4-878b-1c0b-f888-96b977065207@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZcDAMdc2fLHQB8zvALiwyC0uzYkgWFdk
X-Proofpoint-ORIG-GUID: ZcDAMdc2fLHQB8zvALiwyC0uzYkgWFdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=604 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250157
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 25/08/23 9:16 pm, Christophe Leroy wrote:
> 
> 
> Le 25/08/2023 à 17:18, Hari Bathini a écrit :
>> Use the newly introduced patch_instructions() that handles patching
>> multiple instructions with one call. This improves speed of exectution
>> for JIT'ing bpf programs.
>>
>> Without this patch (on a POWER9 lpar):
>>
>>     # time modprobe test_bpf
>>     real    2m59.681s
>>     user    0m0.000s
>>     sys     1m44.160s
>>     #
>>
>> With this patch (on a POWER9 lpar):
>>
>>     # time modprobe test_bpf
>>     real    0m5.013s
>>     user    0m0.000s
>>     sys     0m4.216s
>>     #
> 
> Right, significant improvement. Forget by comment to patch 1, I should
> have read the series up to the end. Just wondering why you don't just
> put patch 4 up front ?

I wanted to remove the dependency for bpf_prog_pack enablement
patches with this improvement, just in case..

- Hari

