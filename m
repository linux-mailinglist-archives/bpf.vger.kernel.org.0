Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81883FF3E6
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347317AbhIBTMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 15:12:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243515AbhIBTMQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 15:12:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182JBB2B006814;
        Thu, 2 Sep 2021 12:11:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=U60xmXB7Kvft9sLX6XAZhDvDp0s6G/cAqd4rvTuv2Ns=;
 b=cydJk3T6F+fA4C0dyVU6rVtywZKyAei33aq46bZOCFs6xX/7P635xwUJwWV3a4LOaYLp
 jifypbL3CjE825WbVG94j8xftP1CBINrnRcE3rpzwrFqW5BArZc57QLB5iBwjIt+W6v+
 x+kutwR13Uikj6s8TbBVwx7avY/zsh5GhhI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdxvc5y2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 12:11:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 12:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqqcXbNOQcfVXJic29dwOl5w2vW0IA7VUCsM+XqyKaDpZ2mMwOzSPEC4g5SxDQghbJYvL0YY3ZHnhPrghPvntwu2XnsLQc7MOAYIfGF+LwCBAx0HS5UJyh/sajUXDQeXVGUyLLpUobQrPsZsdYQrlirTDk35sOya0doJI80DYtr/KQLsSsCC2/EvFMUauJnCY0nF+xS9IRZXXnD1wVLkmoJO6HyOMjKB9TVHfNwTKHTd3K+ux/bjtpy7qdJDgln94/Qb/c3mMlItoBdZ3vQbU/jWw7kX2aGSyjJgXhDh98uKwNj0k5WGrpGYi9g4lNaP6zzmWOWcwpcdnIzrgBQv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U60xmXB7Kvft9sLX6XAZhDvDp0s6G/cAqd4rvTuv2Ns=;
 b=VfODOBquba8I6dLsAJ429HsQBR5BwWQoJxF21rDy5nspNnsKud+Uz8nPEGHtp1Si1Yx2VWSXC8xiddpImlBkohD5BPbeyPUYFoIaKc5iiY8i3/oGi8rGdwjC3M752eTA6chAjdu4HwUWp+06xmabeCMHDn9mvaIM3VUh+hnN3z5lHc0LkEMU2sihLuqluiAoFyA5tsPTsn+2jTan1/MrmYbrTKVadAFU4lEzCuapESbkwwLbBtDpkciO6S2tJFAek7mnXfTG7vZyR/kE0zLvT3q7PWAYIcTMaFwzqYjef7i1cBY9e+1+FupBZLrm1b+RW8oA8SNAUpDIuyXhrM9fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN7PR15MB4239.namprd15.prod.outlook.com (2603:10b6:806:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 19:11:13 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::6dc9:801e:3ad5:a175%8]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 19:11:13 +0000
Message-ID: <fa1f83f8-2b25-feea-a352-f138c4276e0c@fb.com>
Date:   Thu, 2 Sep 2021 12:11:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0.3
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <20210901025507.3hx4wpx3kmtjipad@ast-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20210901025507.3hx4wpx3kmtjipad@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::12dc] (2620:10d:c090:400::5:b76f) by BYAPR06CA0006.namprd06.prod.outlook.com (2603:10b6:a03:d4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 19:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf81feb-9234-410f-af9c-08d96e456e78
X-MS-TrafficTypeDiagnostic: SN7PR15MB4239:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4239DD968B131FE4C2B5AEBCD2CE9@SN7PR15MB4239.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APpZI5MLleT0P3w24wVOf91DR6jALOj9TgJRPuFAuBey7uV6iQ6o3R1kD/rFY9LrJSbTMzwFaFWFBbSsu+wVIcuDjYRPa1YpJoVcxoCgbTX7oxivFZl/mGnbKjeyXNi3MhHHUe1HFGp9HuPeemuRpwybPwh6O+zqhAFSb2ZsxBT1/pIc7wUJFOr+AlX2rYqUKrEYXKkHztOqyQj3ORS+Mbfbcrc+nSHIsJ2qp/qObQsQiNMkSZ1fF4zGIMM/a1VINBi7H23OCUWLjlTLbK0XjHE7/h1cBKHZwDP3GFtU8xkPZcQNVcOksB85JVu9EJtDgawENY+a2hqt4SWcIkq9j3i4EHi2a+jfXA1PPGYoxrAY+Ok+E25hkYIs8B/1q686apyw81lYxXbBlPjFOQnHiK1JKeE2IbYNzGQ2i0YWCXH2OTea1RgqpWQDGddF0XC15BJcjOnRBpwD0jx5GZUDidWQfk6Irpay59YDQOB/JBDBPKGFbu3bpj01cDMY1vGgiTh0lLI+LuqPsznd5m7k7NtxMknw4Qzyk7LVDHOf7t0gLAhc/nFYJ0du8wiw/tfOBfaukyswFln/O/jq4wKcAmcayA2e19At731x9c+nsn4Fmqh5h6glHd5udz/frAbd4hqCG+WU4TPmYys8mVhOMh+DWM4Kw0cg8JLO/TNqABh6uQyDxd3oQP5JzEOQaxyAieX1ix6HB7GNQPeGLpCqZz3qfqt5qwxmLT9MSMDsgQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(31686004)(36756003)(8676002)(31696002)(66476007)(86362001)(5660300002)(53546011)(2616005)(4326008)(186003)(316002)(66946007)(83380400001)(66556008)(8936002)(478600001)(2906002)(6916009)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0N2TisrVWJqNit1SENSbTI2aUlvYkRFcEhUMnpyTDd1YkVhdFJZZnRLRjlF?=
 =?utf-8?B?L0gxNzhCeGVTTEl2dUx3U1hqV1lTSmIzWkYydEd2V2xSck1vTHV4bHE1c2Zv?=
 =?utf-8?B?MG5VaVo3bzRQRmdEZ0QyN0lJaElUNFVVRjFMOUpXTXNNa09Obi9iZVRMSGtv?=
 =?utf-8?B?UjJZME9yM1FqMWhhcnphNHV4dHZUQ0VKYXV3Vnl0eDVEalZOSWJvak9tcWNv?=
 =?utf-8?B?VUNtOEJqcGJTZnErOGtVc3RsTnR0eGdZdnQ0SC92Q3gvU0xCWGtGZnkza0hM?=
 =?utf-8?B?S1YvdFJjNFJVOTlaNEhzN2FTNjhGT21uaHFsNElPczQ2L0tUcmd2YTZUWXZR?=
 =?utf-8?B?RnZ6b3NxR24xelVVdmUvL2lSYWJSck1uck1JOFBDVlRVd055YXZVN1lRdmNz?=
 =?utf-8?B?VEdXa0xqK0N2dDYzS0IzVlBlWUlKdG1GemcxT3gveHRSRWVMYjhHZFF0cUJM?=
 =?utf-8?B?Z2JLTnNEYUJneVVPYVVjMGNmK2QzOTJhZHFWbUJzb3ZRdEJ3Y055L2lOY09H?=
 =?utf-8?B?V2owVFZmZWNtVlJOSG41a29hSkdKdlBJd3NjbzRZSzl2enE0MWxHSUJRWWVE?=
 =?utf-8?B?RFZ4M0tTRkhRTSt4WDZDN1RESWVHT0tqSFpFSU9FMUh2djhXSC8xN08waWx1?=
 =?utf-8?B?cTZCd3RFQytvcEQzZ0w3eGZCV1IrdGs0VDlUdDNacVpRdmZsYktrRUw1eEk0?=
 =?utf-8?B?S2lGSjFBbWRMK0F2a042R0RKSlpieW5XV3IveEowQUNnSS8vWUg4QlRqYUtP?=
 =?utf-8?B?NXB4Mm5vMUJLSTAxeDFPSmYxd2xlS044V3BSL3kwUVMvYWNWb2p1UDZmRFFy?=
 =?utf-8?B?RzlnZjZBTkxjQkpHVzN0cHBTV2FIaStqcStTUGFsYk5VM09iOEo3OFV6SUhv?=
 =?utf-8?B?YXRRUnVIN28wWXJtVlgxWm01cTlkb3FEL3JLUTJaVXdyY1Q3MnNGMHduZHhk?=
 =?utf-8?B?VDJIeTdWVm1MNGN5K3pqbHI2SFlSVlZEaXBUVVIzbGt1N0JYT1JqODRwUi9N?=
 =?utf-8?B?QlFLd2xMQXFCckJGdmJqbWdBT1Zrc2pyVmt5THYyTDZwakQxQWlIMElKc3Rh?=
 =?utf-8?B?Z3h5RHRUVGlWaXNvaVVtR0tFOFp4T04xWTAvNHZJd21vd2dZRnMwRnNSdmt4?=
 =?utf-8?B?Snp5VC9nN2pTaDZHenNzTU1lazg1VTdPRVhCYXhxRk5OSXNKc1hJV2JTamZC?=
 =?utf-8?B?U2lWcjQvcmlVQW9hekh0MVJvcHY4RHp1eUZPMnhRcXRYNVJYTG11cXZXeUkz?=
 =?utf-8?B?bVowQzdIdTNWSGQxM3pVZlpuMmswellnRlFLYzdWTzI4UHR2Y1AzSmYzaVVR?=
 =?utf-8?B?cm9YMVkrWk9vWjQzWERBaDNKZ0FVaEY5MVNNR1FxaEl6czFjanBYZTA2cVg0?=
 =?utf-8?B?dXhqblJHK3VVRXJOUzR5YlVNYU1GVElBUlZGL0ZnUFIrSVRvdnVMUUlxa0k5?=
 =?utf-8?B?WDVrbnpLcVdlbmVCdU9iVDlLNXRZVUVYT1ZZNVBBck82eTlmc3R2cVNhNHhy?=
 =?utf-8?B?YXBkQXQ4SHFSYi9ZSTA3bUVIbTY5R2FLWnhOOThabERqbTBwa0tHUGkvbHFs?=
 =?utf-8?B?SzJhU3ZWTm05N3NUaDRPUWhrZU5PMllmSkJDTnZ5ZEp4d0Z3T29Xd3VTclFr?=
 =?utf-8?B?c1cyZEc4NkxxaGRCRk8yWTR3T1ZzUU9ObW5ITWo1MjhOMTZCdm5KY3F2MDA1?=
 =?utf-8?B?eVpvZ2IvME1aY2wwSllieDJoSys5WW43YVB1YVhVRUR5NlA1VXcrS2c1S215?=
 =?utf-8?B?ZWtxc1RMOTgwUmxVYm0wb0dSdytVbVQzNmVoblk2TSt3dmRaZk5KRE9oK3lq?=
 =?utf-8?B?elJFQlhYR29nQUhXQnJyQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf81feb-9234-410f-af9c-08d96e456e78
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 19:11:13.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhZlS/atKy4nFvPBOMMaqCfAK4jnMqPRmfQ06W3QlDsTKoignBtDtxFU7ntfNWk92Gw9fptJ7RZZKFG9Q8Bi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4239
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: I_0tyqfeojd__MSozIN7ZUsyu0i7bSdU
X-Proofpoint-GUID: I_0tyqfeojd__MSozIN7ZUsyu0i7bSdU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/21 7:55 PM, Alexei Starovoitov wrote:

> On Tue, Aug 31, 2021 at 03:50:01PM -0700, Joanne Koong wrote:
>> +static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
>> +{
>> +	struct bpf_bloom_filter *bloom_filter =
>> +		container_of(map, struct bpf_bloom_filter, map);
>> +	u32 i, hash;
>> +
>> +	for (i = 0; i < bloom_filter->map.nr_hashes; i++) {
>> +		hash = jhash(value, map->value_size, bloom_filter->hash_seed + i) &
>> +			bloom_filter->bit_array_mask;
>> +		if (!test_bit(hash, bloom_filter->bit_array))
>> +			return -ENOENT;
>> +	}
> I'm curious what bloom filter theory says about n-hashes > 1
> concurrent access with updates in terms of false negative?
> Two concurrent updates race is protected by spin_lock,
> but what about peek and update?
> The update might set one bit, but not the other.
> That shouldn't trigger false negative lookup, right?

For cases where there is a concurrent peek and update, the user is 
responsible for
synchronizing these operations if they want to ensure that the peek will 
always return
true while the update is occurring.
I will add this to the commit message.

> Is bloom filter supported as inner map?
> Hash and lru maps are often used as inner maps.
> The lookups from them would be pre-filtered by bloom filter
> map that would have to be (in some cases) inner map.
> I suspect one bloom filter for all inner maps might be
> reasonable workaround in some cases too.
> The delete is not supported in bloom filter, of course.
> Would be good to mention it in the commit log.
> Since there is no delete the users would likely need
> to replace the whole bloom filter. So map-in-map would
> become necessary.
> Do you think 'clear-all' operation might be useful for bloom filter?
> It feels that if map-in-map is supported then clear-all is probably
> not that useful, since atomic replacement and delete of the map
> would work better. 'clear-all' will have issues with
> lookup, since it cannot be done in parallel.
> Would be good to document all these ideas and restrictions.

The bloom filter is supported as an inner map. I will include a test for 
this and add it to v2
(and document this in the commit message in v2)

> Could you collect 'perf annotate' data for the above performance
> critical loop?
> I wonder whether using jhash2 and forcing u32 value size could speed it up.
> Probably not, but would be good to check, since restricting value_size
> later would be problematic due to backward compatibility.
>
> The recommended nr_hashes=3 was computed with value_size=8, right?
> I wonder whether nr_hashes would be different for value_size=16 and =4
> which are ipv6/ipv4 addresses and value_size = 40
> an approximation of networking n-tuple.
Great suggestions! I will do all of these you mentioned, after I 
incorporate the edits for v2,
and report back with the results.
>> +static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
>> +{
>> +	int numa_node = bpf_map_attr_numa_node(attr);
>> +	u32 nr_bits, bit_array_bytes, bit_array_mask;
>> +	struct bpf_bloom_filter *bloom_filter;
>> +
>> +	if (!bpf_capable())
>> +		return ERR_PTR(-EPERM);
>> +
>> +	if (attr->key_size != 0 || attr->value_size == 0 || attr->max_entries == 0 ||
>> +	    attr->nr_hashes == 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
> Would it make sense to default to nr_hashes=3 if zero is passed?
> This way the libbpf changes for nr_hashes will become 'optional'.
> Most users wouldn't have to specify it explicitly.

I like this idea - it'll make the API more friendly to use as well for 
people who
might not be acquainted with bloom filters :)

>
> Overall looks great!
> Performance numbers are impressive.
