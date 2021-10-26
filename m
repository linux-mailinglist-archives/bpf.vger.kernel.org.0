Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C043BB33
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhJZTuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 15:50:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237048AbhJZTuM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 15:50:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19QFX2PL017384
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 12:47:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oTgTaPt/MoggzuizDUzFC6938hi4HiUuRwQ0MdMUAtg=;
 b=Q1JCb7yfVaivURbj83Jf1JLA23xCGVhiaEsDeEay6S6h64I6LqwT+A3FML6IaTjCwYyC
 pc/m47iUvhia9nucAbo0D2qTpT7phB9xCELqsjeKOUYp2aAGHSJ8f7RqICygQvDpj8qF
 R4CBuuxuG7p84TraIoIbQQxiPGJRYjg4zao= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bxkgu2c0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 12:47:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 12:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcdGbDjYbg1JCLJQpC2vi8kO7ZzwvB+z4G5h3JP5Prr6QJKQDiFR0Hnefjh/IrV0IlJfM5e+Rw6Strc8HlHZeqRQl4iWm4lQTBs8AO5YuzSgjCZm+l1JW7S+JpeZpkFv+8Vs7bbsahpyWmy9EL9mEQeh1+X035M7biddjeaoDUJ83VZyOuhdoQxqys8ErjsHVkEg2Z9FMVnLcPeAv3eoufe6Nzqmf/RuJ06hZC6xajUjGerIky11tsXZQfswK/apAe5Ldzx4gGdbpeovVCsgqH0rKsCLwxvY9WinED1lJqiwAad3LQXeG/2f4phN9wgQ+JbqNSHIWT/+YUPStEj3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTgTaPt/MoggzuizDUzFC6938hi4HiUuRwQ0MdMUAtg=;
 b=PHRKBMCD+Waby9hN51BAb7Sn5Aht55akLlKrRJ3/X5xtzvKlg7pGumuguWzrScN5M/BL/u+08owUgOwqYeQUK2kXOxEXs9GZOkEQAhruygsDdx48xHCkjA6J7ALL//lBwH83V/7Q27MEBVC9Bt8IKkFc7EVBw2iKi0lGsEvbyGMJN0hXYfsIHMUx3rdV9HjCwu4LaBnmmMIKq7wSlGt54sXqcVYbmcHOq6BnOI5o6QmCWYxknaTramfsV+OB5esMdsppBtDlz23OlbfI8ZibarH1GoRrqz1ZnrkOR9WhddQY2wQ8zIrKrw7lea22E9zKaWnmF/CSI3Ry+xSCpDvr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB3885.namprd15.prod.outlook.com (2603:10b6:806:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 19:47:46 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 19:47:46 +0000
Message-ID: <421d3144-d3bc-c967-1fa1-3d52e0b1f88f@fb.com>
Date:   Tue, 26 Oct 2021 12:47:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v5 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <Kernel-team@fb.com>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-2-joannekoong@fb.com>
 <20211026004307.34v3uwvnouaazlfa@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20211026004307.34v3uwvnouaazlfa@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:300:ad::33) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::17ab] (2620:10d:c090:400::5:b445) by MWHPR15CA0047.namprd15.prod.outlook.com (2603:10b6:300:ad::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Tue, 26 Oct 2021 19:47:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d94d476-8aa5-424a-772e-08d998b97b89
X-MS-TrafficTypeDiagnostic: SA0PR15MB3885:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3885C4166161B220F100E5C8D2849@SA0PR15MB3885.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sL4DM/iP1U6WZ1uc4Q0ll93S3ss6jIJe21wASnV3yhcrlKT7Emj18yB5ccrWi51nY6OYImGgZ5NVpIPlGKSGrpr7sCMBcDWmPYZAqwR0vZLsJ4sQVeLNDnpE0iXAsKVrigDC3lUotxkNpD6j02OmgRTTuU3bH9qts+KbfcQZwAbJkItU7zEf/Lk4SNLVa4zcE2OwI7U/MZNuQNTVExWZMhzyAypleSQwTCeeTQDm+/VX5VydYbCDsdP9tJxF4h3xTHcTE7/xkod/oiJkavrjFl+BzFRCxud5ZABpbljEU0TMLW6ECgIvf/9dX6EFQn+6nwYKydPa25xt4Z3bFGk2uDvmEnIkskCDmzjvjWsPaaIV/9ra8TDHGwe8y1bQlEqWd1d3J3fyfclfx3U0QeCwE5QHNQxwygJAQFuRVKgwoOfyEu4EIDWWWauR/IVl0o3UsVuI1qdxR2AGvvpk0gEdLmXqncE54xJaIfXDMXfuAV2wHSrflltHwKO2szdAovEwQs8nWQPryEvaK8avvOgWASVLt3n/mWg88zS6mIlmbv8QsbcM4Nx9ABiAAKzjvP4W9nNAtWj+kATdomwvOLYov8oqxu88SFEc8nhWeWE0SEz+9Qtr9raOnWibI5cWa9QFA4rzOvHJdrx6xY8E8u6+ByV6sJWc5A/fHzefXH0lPOoUV/fbiVu98gysDkUG+GCsMm5UXYN8656FmFQGDtXbtE569dcB+aUGUWDKK47UNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6486002)(83380400001)(37006003)(186003)(66476007)(2616005)(4326008)(86362001)(2906002)(66556008)(31686004)(6636002)(31696002)(5660300002)(8676002)(36756003)(6862004)(316002)(508600001)(53546011)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzduV3NYLzJQLzRFWFJNdXk3RzBhbis3QXJXS3RoeTk3ZVJCTHB1dEJnT0NB?=
 =?utf-8?B?aGFsL3pXMGJ2KzhQcHJ1Q3JHcDkzU3lZT3J3SmdTZVoydkRaUUxtSko3QzZB?=
 =?utf-8?B?T25wbTdLRmZJNllFdExZTzREeHZ4R3hMM3BlaVQ4UnJpbFBlSStIRDZvREww?=
 =?utf-8?B?TUl5YXk5TFdjeEJUbXFCTXF3QXJtLzhVUm9qb2ZyMHBTSEhQMEhmR2JCMHNl?=
 =?utf-8?B?N0RPZkJBUUU0MzYzMm8zMFI1ZlZmL21HVDRLT0RPdGVoNURuVEMrbTFkODJw?=
 =?utf-8?B?MGhoSjlsS1ZCNjAwSXFza3M5cUc4NGFYemJLbDJVOFpPNHIvUzYwbHluNlcy?=
 =?utf-8?B?NWNFa0ZGQUpSVUpCdXM4aEJDd0x4RkFqNWZ0ZmNveWhYMlJFWURKZzhaZHQ5?=
 =?utf-8?B?d05IM2FidnpGOU5tcEZLcGl6ajdodWE3elRRU0ZkYXVhUVRCU3ZmT2JlNTdG?=
 =?utf-8?B?eVdxcVNJMVpmakJBM2dyUXZESDA4dGIxV25rd3Z0V1p5V3NTVDcvQnJDLzlv?=
 =?utf-8?B?c3NuUU1DdEtKYjYvRG9rU0E0RjBDVTdlSDdZaDJnM05EaWVYMkJiTHJLbWhu?=
 =?utf-8?B?OWJvclNHR0NIN1poSU5qQTMrNENTMjQyZGxBVS9jM2tGUElEMVUvSFZaNFp1?=
 =?utf-8?B?bW5SeEgyVTYrT2wrMlZJQXBWcFBWOWljVktvMmM2NkxSQmdVbmlsK2lNVEEv?=
 =?utf-8?B?U0p2VnBOcSt4eUt1dVZRdDdTbkNPY0VzRUVhWFoyTCszNFVYZmJYN253V3pl?=
 =?utf-8?B?YlZmcDFMNXlYNURCZkRkK2s4dzBleCthNVM3TVQ5NHRkRWVZamRFZm5vN0hY?=
 =?utf-8?B?bURCQVZkQ2NIRVJWdndwYkxLYnBQS0JKVVVMdWVuNjZieExGRlFZMkpiSlFY?=
 =?utf-8?B?b21XUG4xb2sxMm1raHhDOFJPUGluakpSVk9Cd1plbXF1S01qUHYyZzRoT2pQ?=
 =?utf-8?B?L0VWVEpWNlBPRUNWM0J4bFlEV2ZuZlpDUTBBZldiMC9GcDZaUkZhSnRydGIy?=
 =?utf-8?B?M3kxblFVRHB3VU9nNVJYYTBXbDdEbmNzNHNSSDdQR1ZpMnlaeVZ0akhrOTNW?=
 =?utf-8?B?RmRWandDQzVRVGhqYXQvZ1VjcjRjbUtWK2RROUlQVVQ2blUxSkNFWlhNdHg5?=
 =?utf-8?B?eXJoeWhOZDBoaU93QWdaVi8xakc1QTVRZzQ5c0lLU2xXclN2Qk82MzNmVkFN?=
 =?utf-8?B?Kzh6d043SnNrOVlxSXZsbjYzZEZSTjcxNzM1bGJucGFPK2VHdTk5aWlZV2RL?=
 =?utf-8?B?R2orS0tOQ3d5M21VakNvZGloem5SL2hqSDRpaUVXcEZzem93NmN5cUtzRlNG?=
 =?utf-8?B?eHdzYlc2QjZwR3hjY3Z3Mzk2dWJOMTVsRHBPMTVKUllndkVpMTQwbk5OWEpz?=
 =?utf-8?B?MVg0OW5iRG9nWHBrMERmUG1EdTlSY05BcllUSjgxVGtTRTNjQUltZEFYMGVH?=
 =?utf-8?B?Y3d6V0pGU0VRMU5oZnN5VmxMTTJFcGRtS1VsZFBaTFkyL1ZVVElhWkQ0aUJM?=
 =?utf-8?B?R0JRTXBVcXRoTEx0cjkyYXR4M01oS1lYb1V1ai9ZY1V2N0RsSkVmbDdNYmVk?=
 =?utf-8?B?bUZRMk1iN0p0aDR6WnNyWFFSaUJWajJYVXZWeUFrU2JScVB1U1Z0U3FGcW01?=
 =?utf-8?B?UmtlM2NSbWRNYmo5cjliSmg3OC9MVlJEdGVrVTVSSncvRGxadnErOEVkMStE?=
 =?utf-8?B?SzhCOVFoMmZLWG8yWHBZdXpzQXhRWWNZOTFUWDlEL0hSaUphTXFCSnAxSVlt?=
 =?utf-8?B?ODNieUxOak83WEtUdERVVkhmRGZPT1g0Sk1DVU9xb3BGejlsdUpVMmIzTSt4?=
 =?utf-8?B?TFdGcUkvcUlFRWJtNTBST2lnbGNRS1kwOE5oSytkODVKVHJVZXJnMHU0Vm9M?=
 =?utf-8?B?OEpNMmYyQVYxNFpQWFNpcFdNNTFxOWpFQURyVS9CMW01Y20yZ0F5QzQ4NUF6?=
 =?utf-8?B?V0lOZVhCSlNFbmhIbmtDM0JIRjNJaWFXTGx3Y05keURSNzE3V3hhYVJqUTdl?=
 =?utf-8?B?ZjIvczNTdUR3ejMxRE9ETE1aTU0wWGFBS1NFYm16Y0orcmp3bFJGSW1ndkhU?=
 =?utf-8?B?ZHlWc2VvYkFVNUdWYXdiT04vaHIybTRpUGJaajZvWFBKZzFZaFdGWmoyREFE?=
 =?utf-8?B?NGd6M0QzTk9HYzhhajNEZ0hzUWVnSmZtVlZpeUhlNENGVTRHWEVIeWRBN0Vl?=
 =?utf-8?Q?rQCcaXcEs05pJJlW1s3erBvMXH1OGeA2pKibv75RVYAV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d94d476-8aa5-424a-772e-08d998b97b89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 19:47:46.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSIMC2L7eBOcd6lFhAdqqdyulVWdlGSZXp3qbsLecndFR1xxjZN8TeqP494AmUum7wRSRyQhu14kKDj7IpVSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3885
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yVz5fYSjuLf7EcckIwQx_jSjXMu1lz7D
X-Proofpoint-ORIG-GUID: yVz5fYSjuLf7EcckIwQx_jSjXMu1lz7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_05,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=863
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110260110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/25/21 5:43 PM, Martin KaFai Lau wrote:

> On Fri, Oct 22, 2021 at 03:02:45PM -0700, Joanne Koong wrote:
>
[...]
>> +static struct bpf_map *map_alloc(union bpf_attr *attr)
>> +{
>> +	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
>> +	int numa_node = bpf_map_attr_numa_node(attr);
>> +	struct bpf_bloom_filter *bloom;
>> +
>> +	if (!bpf_capable())
>> +		return ERR_PTR(-EPERM);
>> +
>> +	if (attr->key_size != 0 || attr->value_size == 0 ||
>> +	    attr->max_entries == 0 ||
>> +	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
>> +	    !bpf_map_flags_access_ok(attr->map_flags) ||
>> +	    (attr->map_extra & ~0xF))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* The lower 4 bits of map_extra specify the number of hash functions */
>> +	nr_hash_funcs = attr->map_extra & 0xF;
>> +	if (nr_hash_funcs == 0)
>> +		/* Default to using 5 hash functions if unspecified */
>> +		nr_hash_funcs = 5;
>> +
>> +	/* For the bloom filter, the optimal bit array size that minimizes the
>> +	 * false positive probability is n * k / ln(2) where n is the number of
>> +	 * expected entries in the bloom filter and k is the number of hash
>> +	 * functions. We use 7 / 5 to approximate 1 / ln(2).
>> +	 *
>> +	 * We round this up to the nearest power of two to enable more efficient
>> +	 * hashing using bitmasks. The bitmask will be the bit array size - 1.
>> +	 *
>> +	 * If this overflows a u32, the bit array size will have 2^32 (4
>> +	 * GB) bits.
>> +	 */
>> +	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
> Comparing with v4, it is using max_entries to mean number
> of values instead of bits and also not exposing
> BPF_BLOOM_FILTER_BITSET_SZ macro to calculate the number of bits.
> just want to ensure it is the intention in v5 since I don't see it
> in the change log.
Yes, this is the intention. Sorry for not making that clear in the 
change log.
I will add that to the change log!
[...]

