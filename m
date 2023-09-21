Return-Path: <bpf+bounces-10550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FC7A9B31
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B231282293
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B719BA8;
	Thu, 21 Sep 2023 17:49:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7119BAE
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:49:23 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABFB8848E
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:38:58 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38L3WTKJ017603;
	Thu, 21 Sep 2023 16:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=LdGdQ9kV5GKJkOita+0fy5/8Opf5YQi3H3CnGBlkkUU=; b=CY6lizIyC5kx
	lBmN2V0UdGU7Qfb4dSw3xxqRisXnun3EPO0Dr8j+OCPCPQAopBngwXIYgHq4VV6+
	W9DJiBGLao7sZDFBg8tzqDo+2hH7VSamj/6LvCdFOVcM46WeWMDqdMMI/GMvNSVf
	wATbKJxH5ACjPBRFl4MRPaBkhLW4KdzqFnzbpxO5jSpDsk42IqDab4Dobc9F8Oom
	QcvkLWKq8drRSHZw3o7l/7tefbhEviXZ08qzObFEX/yBwl3KARHzioSooTpQMH/O
	OI7avITybsVR5dM0p/PZMj1CIpEAqFmt7aXkwo/oTtzDEIifJQZC057ThG18w/A+
	J2gKodSS2Q==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t7ebwx44x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 16:08:08 +0000 (GMT)
Received: from [10.102.42.184] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 21 Sep
 2023 16:08:06 +0000
Message-ID: <e8f90cab-366f-ce4c-01f0-a9c5d79b885c@crowdstrike.com>
Date: Thu, 21 Sep 2023 09:08:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re:Re: [PATCH bpf-next 00/14] add libbpf getters for individual
 ringbuffers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@kernel.org>
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
 <CAEf4Bzai8oxP6MkyGumt08WKcdOToHrt2ZqF1bgESJ-xi+2Aag@mail.gmail.com>
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAEf4Bzai8oxP6MkyGumt08WKcdOToHrt2ZqF1bgESJ-xi+2Aag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH09.crowdstrike.sys (10.100.11.113) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: np8l9aQma3O3pvZB2WCoP-6_Majaame1
X-Proofpoint-ORIG-GUID: np8l9aQma3O3pvZB2WCoP-6_Majaame1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309210140
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 18:28, Andrii Nakryiko wrote:
> On Thu, Sep 14, 2023 at 4:12 PM Martin Kelly
> <martin.kelly@crowdstrike.com> wrote:
>> This patch series adds a new ring__ API to libbpf exposing getters for accessing
>> the individual ringbuffers inside a struct ring_buffer. This is useful for
>> polling individually, getting available data, or similar use cases. The API
>> looks like this, and was roughly proposed by Andrii Nakryiko in another thread:
>>
>> Getting a ring struct:
>> struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx);
>>
>> Using the ring struct:
>> unsigned long ring__consumer_pos(const struct ring *r);
>> unsigned long ring__producer_pos(const struct ring *r);
>> size_t ring__avail_data_size(const struct ring *r);
>> size_t ring__size(const struct ring *r);
>> int ring__map_fd(const struct ring *r);
>> int ring__consume(struct ring *r);
>>
>> Martin Kelly (14):
>>    libbpf: refactor cleanup in ring_buffer__add
>>    libbpf: switch rings to array of pointers
>>    libbpf: add ring_buffer__ring
>>    selftests/bpf: add tests for ring_buffer__ring
>>    libbpf: add ring__producer_pos, ring__consumer_pos
>>    selftests/bpf: add tests for ring__*_pos
>>    libbpf: add ring__avail_data_size
>>    selftests/bpf: add tests for ring__avail_data_size
>>    libbpf: add ring__size
>>    selftests/bpf: add tests for ring__size
>>    libbpf: add ring__map_fd
>>    selftests/bpf: add tests for ring__map_fd
>>    libbpf: add ring__consume
>>    selftests/bpf: add tests for ring__consume
>>
>>   tools/lib/bpf/libbpf.h                        | 68 +++++++++++++++
>>   tools/lib/bpf/libbpf.map                      |  7 ++
>>   tools/lib/bpf/ringbuf.c                       | 87 +++++++++++++++----
>>   .../selftests/bpf/prog_tests/ringbuf.c        | 38 +++++++-
>>   .../selftests/bpf/prog_tests/ringbuf_multi.c  | 16 ++++
>>   5 files changed, 199 insertions(+), 17 deletions(-)
>>
>> --
>> 2.34.1
>>
> Looks mostly good, sorry for taking a while to get to these. I left a
> few comments here and there, please address and submit v2. Try to use
> consistent "ring buffer manager" and "ring buffer map" to distinguish
> them in doc comments. And also please don't add new CHECK() uses to
> selftests, we have a whole family of ASSERT_xxx() macros, please use
> them.

Thanks, I agree with all the comments and will issue a v2 as soon as I 
can. I noticed the ringbuffer vs ringbuffer manager discrepancy but 
wasn't sure which phrasing was better, as the API and struct names are 
ring_buffer and ring instead of ring_buffer_manager and ring_buffer. 
I'll change it up to consistently refer to the parent struct as "ring 
buffer manager".


