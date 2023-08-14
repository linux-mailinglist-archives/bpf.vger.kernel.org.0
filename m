Return-Path: <bpf+bounces-7770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B877C0B0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931792811BE
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22ACA7A;
	Mon, 14 Aug 2023 19:23:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E6C2CE
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:23:08 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF489C
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:23:06 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37EHCtIg005333;
	Mon, 14 Aug 2023 19:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=zZQL6ddNNuvjKMCNF7YfZarodTl8T3gIqMxkwImreEE=; b=uqeag0OEd8lC
	vZnMqxOSsC2lj5WeOPnKobK0E7rdHjYqZX15dmKgN/v9+RX54rr3UTu+5fbX4M7/
	mwvDv4TddE5uSrAD4boDLW+vY+tmcvDAcTCmq6mv9haNO/yMLJbz3HCBhDIi9/k7
	LHHOwEdX+kUm42ARRdYhHldcR2qyf+95PKXUjDLPFpX+hwfqVs4oF43H2vchXDa2
	FgrK4nkcQwD55nvoqhUr0V0+4QHSesjvYtTojLJShLSkb/Hu6Y3GrIw5cR1KXUbl
	rSmv5OhHuIYUlNFLrRCSHCtLajoRgvvm1M89BqOa0o1z4lAcJVM9rxn7LXcnTdvb
	mzEFtcVrrg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3sen1mukvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 19:22:46 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Mon, 14 Aug
 2023 19:22:44 +0000
Message-ID: <c5353680-23a2-542f-6512-27910047aa70@crowdstrike.com>
Date: Mon, 14 Aug 2023 12:22:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Re: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Marco Vedovati <marco.vedovati@crowdstrike.com>
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
 <86e24c5b-f27e-42ee-aab9-af5379c3cf79@iogearbox.net>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <86e24c5b-f27e-42ee-aab9-af5379c3cf79@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH11.crowdstrike.sys (10.100.11.115) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: yEesSJ40RHt6YxT8B1Va_bv-WQ122_pB
X-Proofpoint-GUID: yEesSJ40RHt6YxT8B1Va_bv-WQ122_pB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=954 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/23 08:40, Daniel Borkmann wrote:
> On 8/10/23 11:43 PM, Martin Kelly wrote:
>> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
>>
>> Enable the close-on-exec flag when using gzopen
>>
>> This is especially important for multithreaded programs making use of
>> libbpf, where a fork + exec could race with libbpf library calls,
>> potentially resulting in a file descriptor leaked to the new process.
>>
>> Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
>
> Looks good, thanks for the fix, applied! Do we also need to convert the
> fmemopen in bpf_object__read_kconfig_mem - if yes, could you also send a
> patch?
>
> Thanks,
> Daniel

Good thinking, but it looks like (from libc sources and a quick test) 
the underlying fmemopen doesn't accept the "e" mode for close-on-exec. 
On glibc 2.35 at least, it's calling into _IO_fopencookie, which then 
executes this switch and rejects the flag.


