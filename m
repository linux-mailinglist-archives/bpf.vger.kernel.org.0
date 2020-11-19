Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF392B8C2B
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgKSHTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 02:19:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgKSHTW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Nov 2020 02:19:22 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AJ7J6td015900;
        Wed, 18 Nov 2020 23:19:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YMJhG9XCO+8FcHBbwb6h0O7iw7j+nUlm7+uDVeHt6ls=;
 b=Z5GBaDG/HnfdSTV+cQwaoyhEksTD2K82rkyPULkobXUtv0VzVj3A38ITuRgn+c56bG08
 3RVE9oWKnBdEUpk2az0JwmH8/lX8McrhOCnfwVTBRcv1avbk2GossbV0fXn7ruf/2/7V
 rsONjLUDyAMjyq4Wxd9XVJJ0wfVSoen1ivg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34whfkhn58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Nov 2020 23:19:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 23:18:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6/7H6M4GsPZamHpYSxk1oe4ioUvoBQopg7ThhRFRQfy36mUCBNPYL8ekr/vtoixllgVtXN+5Qxh9/5wsDV+T5Xn7dWrtgJ4jQPoueMVMPqbaCJWIeQuvU+6olTTsR8TerJt4dBue+nk609OmaAjpdjghpBif4nGY6nTDcNOV4a+0lg0vXo0MBJrQJxzt7uCmW437mFmKI/kDzxUlOvKO9KBE7Pyf+f9H+L9t3BdTlDvUvc4bOIzyZSdvbEDxgzHoYWf05jd3WwWn8nAKaztJ84ViXdD8//oyt0/Z+5l2pfyY3EzoPMicsr3OvcxbSoD1tEENfyD9rPGxHnB4sZ40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMJhG9XCO+8FcHBbwb6h0O7iw7j+nUlm7+uDVeHt6ls=;
 b=g8t6aB0fpPisMfCI+P25oBkv7Dlmmnby8a2njCvvRzc+8VP6JVjJ3nut49FigYuKi8QvVDJ5v6SR48S8jdPEd7Gh3JiMkA6UnLeIdHt1c4S/KnHxguIZdnwB9KqQff2+dwWipMVyQXio8R8L8F5Q9bpb4mYNmMNoq49A4f7+9pb1zJUuV/H0Qg6bNfAQzyV4CPPd1aTEvZfAI8xI+1rS59rywCPZM5VImdUpthswZkRQHS2NW6Y8H7HmTkd8eGvFgh0quv1k7nOCyo+qyiaOebpY6v3Ir7XRQSv4GwSk6jSIrehr5k8I4kPOPPy9gncGy4ncTsaEoFQ/5A4VZJ0YvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMJhG9XCO+8FcHBbwb6h0O7iw7j+nUlm7+uDVeHt6ls=;
 b=Hvm9YwXzck5nm9I/p0yuIt6ZblHRngBa4Z6oTyYI8rex3eB3FzkQ3cAIAsVI8U2SNSf0XVepF48DL3rieNGSKbS425FUIqNqr+/U7co8XNgcIpnlnDfBAiLLYUn/VbOxTAdNLfYJVfmjtVasKeGOkyOtxBywrqhBAt/vHY7wlqY=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 07:18:49 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 07:18:49 +0000
Subject: Re: [PATCH bpf-next] bpftool: add {i,d}tlb_misses support for bpftool
 profile
To:     Song Liu <songliubraving@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20201119042332.3343146-1-yhs@fb.com>
 <3D194218-382A-48F0-AAAC-9D3C2355D61B@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c6c774d7-2d1f-b16b-d10a-603373f029a5@fb.com>
Date:   Wed, 18 Nov 2020 23:18:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <3D194218-382A-48F0-AAAC-9D3C2355D61B@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6898]
X-ClientProxiedBy: CO2PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:104:1::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1383] (2620:10d:c090:400::5:6898) by CO2PR05CA0095.namprd05.prod.outlook.com (2603:10b6:104:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Thu, 19 Nov 2020 07:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71b0b1af-b904-44f8-7e36-08d88c5b5c39
X-MS-TrafficTypeDiagnostic: BY5PR15MB3668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3668511AD277463234D1A2CAD3E00@BY5PR15MB3668.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzXV+UYmZ3Q61T+Ill0Hx4aG+sMriT3uXED2HsI/O9hyR3KdIkXx2wQ2wWVyXMA6iMylesLMux1fIW6OvDRgdoRb7m8qwJry3R6dF7DMCr5AaR2qRYsatUiR/58Z5vJy4porfXeHsylfNo0s7TTTZmbTPJznFwYEgHmezAfjBl5LZba+jIk1iBBWrLw9HiopX2g1pgnKtV3/2S2JQIGifmg+FQwFoivpiLd9iywcIQq6Lo69cxaqApKApwz8RnJX3kaoxgx8edTTovTH4mwdQUq8RUvZXDaeNPsh/2T29goT/P7nyGOBFX25ZKnmAFfUViBUdzjBPtrJxXyyhwQyjMBAFKWcaq9Lg4nziKfkWwgUMc20jH1NMTqt0FCEY1oj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(6486002)(316002)(83380400001)(31686004)(2906002)(54906003)(478600001)(37006003)(16526019)(53546011)(186003)(8936002)(2616005)(31696002)(66556008)(52116002)(8676002)(6862004)(66476007)(66946007)(86362001)(36756003)(4326008)(5660300002)(6636002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RWRkSlF1BE6sLjTva6++ZUwA8NKlDTnorwKqUndq+pVzX60Q/kb9L1cmtXwVZx35z0/YPq3S+Ww4yWCYS4aBwu+TKLMa9Fu5KAGJ88TtiTFou5FlykO51iEzgtJlnQC7Y35Z672KuBGepf6iSYXWCS8rWEmbX4gsDtXokKaIdWPQkinEB0NWBUAnU6kFSB+XIyX73W4ZInwIQO5CvL2GgWgEc5GJLPTk+fOPVP1AS11ZQGrTkHFL3TtHBEfoKGdYo2YvPGWPkvElnybp+EF24M0r2u6BFtFnmhHaR6kMum0rYaG3ho8QbJtnwizGEHoFIXATXaiaiy65HTxIMst8qBejCazbUXeT3U6nDG4Scfh5jp7eoFEUt9Hk1r59zIq6IWOw8a2Wk543ZuneJCes5POUfISDvoRagQTx77Y17kFCQzr2jYxl1gAP25NKNJk3NJ3JNJQixvka3i/GeNGJMCfnVFeVyVS9Lx+tZkdLiB9mDjgC2CPHT3riK4RLL/aY87dqXIP0tx4ojoFvBuCEzeVu+umVXgqsTzbzsVMFxllRh6e/A24BPqJdM6sOfoWCGh5jLODNmC3nhNj/JHsg56WcYzDkRid6HRkxUPle/ndCEzXF6fF5ARSdNKxSZ2QLP/N4Bp/T3b0/kkFmKAkyYeR77Ax0IjGaW9bZB6I7fOEEWzinQLg627tt5NE/YCM4fsIaB+RX5R6k1Ax4btUGu9fuMnIwdpfX6yicfkCvZ4N2Levsg57piFER3SY6yvB6mg9hwz2NDfki0ITiDa3sl4VUSPnbTS0xD1HCvhE6lcz4izqeoiR35xRS5Al5pimEnWoUfQ3ExgVD5STKPCnV5td6QyLLkVLMOiudowk4V/CVKrl7GnKwuTXoBxeuZNKXABSC1B+yLPfkESVlfA9vwnlp/BjrpHrhu/7d017WmmY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b0b1af-b904-44f8-7e36-08d88c5b5c39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 07:18:49.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXRQLeonAad/VQ4sdvhTEVypLqaRblYhaQKipjPLyTN0V+5VPeYHfdEpO3TWeVxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190052
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/18/20 9:03 PM, Song Liu wrote:
> 
>> On Nov 18, 2020, at 8:23 PM, Yonghong Song <yhs@fb.com> wrote:
> 
> [...]
> 
>>
>> Cc: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>> tools/bpf/bpftool/prog.c | 32 ++++++++++++++++++++++++++++++--
>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index acdb2c245f0a..e33f27b950a5 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -1717,11 +1717,39 @@ struct profile_metric {
>> 		.ratio_desc = "LLC misses per million insns",
>> 		.ratio_mul = 1e6,
>> 	},
>> +	{
>> +		.name = "itlb_misses",
>> +		.attr = {
>> +			.type = PERF_TYPE_HW_CACHE,
>> +			.config =
>> +				PERF_COUNT_HW_CACHE_ITLB |
>> +				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
>> +				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>> +			.exclude_user = 1
>> +		},
>> +		.ratio_metric = 2,
>> +		.ratio_desc = "itlb misses per million insns",
>> +		.ratio_mul = 1e6,
>> +	},
>> +	{
>> +		.name = "dtlb_misses",
>> +		.attr = {
>> +			.type = PERF_TYPE_HW_CACHE,
>> +			.config =
>> +				PERF_COUNT_HW_CACHE_DTLB |
>> +				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
>> +				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
>> +			.exclude_user = 1
>> +		},
>> +		.ratio_metric = 2,
>> +		.ratio_desc = "dtlb misses per million insns",
>> +		.ratio_mul = 1e6,
>> +	},
>> };
>>
>> static __u64 profile_total_count;
>>
>> -#define MAX_NUM_PROFILE_METRICS 4
>> +#define MAX_NUM_PROFILE_METRICS 6
> 
> This change is not necessary. This is the max number of enabled metrics.
> We don't stop the perf counters, each enabled metric adds some error to
> the final reading. Therefore, we don't want to enable too many metrics
> in the same run. If we don't have a use case for more metrics in one run,
> let's keep the cap of 4 metrics.
> 
> If we do want to increase this, we should also increase MAX_NUM_MATRICS
> in profiler.bpf.c.

Thanks for explanation. I missed that we also need to change 
MAX_NUM_MATRICS to really make it work. Ideally it would be best if we
only need to change in one header and that header is shared by both
bpf program and non-bpf program but probably is a overkill here just
for a single macro.

Also, your concern makes sense. We do not want to enable too many
metrics as this will cause counter sharing and may sacrifice accuracy.
I will leave current max profile metrics 4 then.

Will respin v2.

> 
> Other than this,
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Thanks!
> 
