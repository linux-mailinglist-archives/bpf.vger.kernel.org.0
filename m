Return-Path: <bpf+bounces-10075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D37A0DD4
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3111F20FCB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF1262BB;
	Thu, 14 Sep 2023 19:07:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F6D307
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 19:07:16 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A691FC7
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:07:16 -0700 (PDT)
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EHFRSt011574;
	Thu, 14 Sep 2023 19:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=JeAEwlJS+ilge4mxrvUCMiGaQoi5W1kwq7iJ4IrTUA4=; b=gSNrUlx1IzWF
	BQFWLsX3z4e1YQ7pgjeXQGecvdZe6RlxaMHSKoiAkulD+pHu9xhFg/GoLc9UhW7L
	hOqqtyCZgRxnrdSzXNXSWZjqRTFS+UFM7pFWyPKNttXofNe2Tl1jAwGG1V8tTBG8
	C4IJFlnuv/Xhal0IecwRczy5qPhPpM6gJqhsodG4Sk7SWks933Lv52ATxqDVQUSS
	YHm8di0wSR9239TwRdpUQBIYOD6gIFHUJ8NKPq+SGUzCbmCxYsV5UDUO1RQHgWy0
	kQlYc+Ozc8t07jW67D+iiGqnoqfFa8hbfhmTR4RQThAHViL957qIVpqxCmYBADd4
	//NsiLaMkA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybtwnj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 19:07:11 +0000 (GMT)
Received: from [10.102.42.52] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Thu, 14 Sep
 2023 19:07:10 +0000
Message-ID: <e776f129-3796-a425-b162-ac74e7d78530@crowdstrike.com>
Date: Thu, 14 Sep 2023 12:07:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Re: Best way to check for fentry attach support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <bpf@vger.kernel.org>, Rahul Shah <rahul.shah@crowdstrike.com>
References: <f76a8cb2-6cc7-be5d-0335-cc6b98baaed8@crowdstrike.com>
 <CAEf4BzYubqYZ=Hu2yzZ3FXGW-oGJ+-3k9=s+EAhvu07OCzgh+w@mail.gmail.com>
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAEf4BzYubqYZ=Hu2yzZ3FXGW-oGJ+-3k9=s+EAhvu07OCzgh+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04wpexch02.crowdstrike.sys (10.100.11.92) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: J0rU9oeiTdLq6qurzoUw_A6XC8xs83FP
X-Proofpoint-ORIG-GUID: J0rU9oeiTdLq6qurzoUw_A6XC8xs83FP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_11,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140166

On 9/14/23 11:05, Andrii Nakryiko wrote:
> On Tue, Sep 12, 2023 at 11:50 AM Martin Kelly
> <martin.kelly@crowdstrike.com> wrote:
>> Hi all,
>>
>> I'm trying to figure out the best way to handle the fact that
>> fentry/fexit trampolines are not fully supported on all architectures
>> and kernel versions. As an example, I want to be able to load an fentry
>> if the kernel supports it, and a kprobe otherwise.
>>
>> It's tempting to use libbpf_probe_bpf_prog_type for this, but on ARM64
>> kernels >= 5.5 (when BPF trampolines were introduced) but before the
>> most recent ones, loading an fentry program will pass, but attaching it
>> will still fail. This also means that libbpf_probe_bpf_prog_type will
>> return true even if the program can't be attached, so that can't be used
>> to test for attachability.
> Right, because libbpf_probe_bpf_prog_type() is testing whether given
> program type can be loaded, not attached.
>
>> I can work around this by attempting to attach a dummy fentry program in
>> my application, but I'm wondering if this is something that should be
>> done more generally by libbpf. Some possible ways to do this are:
>>
>> - Extend the libbpf_probe API to add libbpf_probe_trampoline or similar,
>> attempting attach to a known-exported function, such as the BPF syscall,
>> or to a user-specified symbol.
>>
>> - Extend the libbpf_probe API to add a generic libbpf_probe_attach API
>> to check if a given function is attachable. However, as attach code is
>> different depending on the hook, this might be very complex and require
>> a ton of parameters.
>>
>> - Maybe there are other options that I haven't thought of.
>>
>> I have a patch I could send for libbpf_probe_trampoline, but I wanted to
>> first check if this is a good idea or if it's preferred to simply have
>> applications probe this themselves.
> It doesn't seem too hard for an application to try to attach and if
> attachment fails fallback to attaching kprobe-based program. So I'd
> prefer that over much more maintenance burden of keeping this "can
> attach" generic API. At least for now.

OK, it's easy enough to do it in the application, so we'll do that. Thanks!

>> Thanks,
>>
>> Martin
>>
>>

