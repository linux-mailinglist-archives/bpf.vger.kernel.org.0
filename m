Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58334BEC0
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC1USb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 16:18:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10028 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhC1USb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 16:18:31 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SKFxu4009514;
        Sun, 28 Mar 2021 13:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yo7WolCtM7YFAKNf43Njp0s++2a3WWHnwu+6zQyh8jc=;
 b=bewMeffaaPg6uGHp0QTZyc3lTJu0S/293Ilr1evM3v9xq7nLflOzkUUMPUNaA77iHoPV
 j8sGhBZ4m+mzjY9zs4+WZMM5FrNFmwEu8ASPN/XItwSL1LXenrjxMF0Y8BybGgfr7p3r
 /M6PyODLFisJVz/r/0k2uj9pb6Wqb8hgJDA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37jmhs9u3y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Mar 2021 13:18:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 13:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUWKdnY23oLHEEaLSdKj6NrBBV5SUdDb6LOY1u7aLcyFTJgKXQVPeNA+CA3m25bxv5BBJRkeIWaw1NJkhPyXMN7vBCIv6frxnmQs77TYALcIGC25QCBKBH9WYSYLiPCaUslb8CRDZPv0BB1IepzBLkCZwPkBEjJaimD928bAybGWNC7m/hw9j/3nmgxyIvGn9fam6LaJ64Jq/ILJo76PObrT4bav23dPvEdFbbblyf/BMBpfzpaFCNEuZKxUfLeH3fe0f04P0FDoGGoTGSg8zS7tTp8ref8u6pUeX4MA+jDy92Ub/TJTFhVnpuV8IImcv2Rv9cci+bnKKgHXK3bihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo7WolCtM7YFAKNf43Njp0s++2a3WWHnwu+6zQyh8jc=;
 b=bqZ9ha1fwAQ0H+qkV+uAeJpagWwVMEHnJfgWe3lCFCa30gdh9h/LUTQ/nnrmvvHElPXSeSt2YW5b2CdtfCislDV5CqL4r2Qm939Ar7BFrK4u5YTQ8tv9DkdeQFZ5ozSxTeWoFhdBEohZvP6c/E7YIyjLW+pgFmI0yQjzssli54DHX8zPaJE7hGLwA2NamlTI+v+k/K1W/awkZLL4H78w9PkQWs+ph1vQehL7oRVMaePYkzKujzCMnuqgJRyVe2F3mMEgTeJrAf4hN2o8NsKZaQgr6fTf1xIOPQcvsk4liT43WFW9SLOtlft17CyRWMfvCIdahZ9eHZgMX+EyFy//IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4451.namprd15.prod.outlook.com (2603:10b6:806:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Sun, 28 Mar
 2021 20:18:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 20:18:24 +0000
Subject: Re: [PATCH dwarves v2 3/3] dwarf_loader: permit merging all dwarf
 cu's for clang lto built binary
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328061646.1955678-1-yhs@fb.com>
 <20210328061702.1956720-1-yhs@fb.com>
Message-ID: <72580b46-3bf8-ce91-de61-d1c1a68b01ad@fb.com>
Date:   Sun, 28 Mar 2021 13:18:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210328061702.1956720-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:a94c]
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:a94c) by MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Sun, 28 Mar 2021 20:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d107b75-330a-48d6-2b45-08d8f226a39e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44510BEF81C0094BB08776A4D37F9@SA1PR15MB4451.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q20Qqv+wwLk2eF1eYWAtl5tOozcGQm9Qa1jh0E/3OfUPWJUUcGD+18XiqehuBKdoa1i010bBcSlmlkyMjANyptHiyxb4bAgOVhPGjILJCb9qN5wrKzZmBv5OGItadDkQt5GJ9xVYMTO7CCI3FRvUIZJIC/o58W4w5BMxF83CZvQqeKdZ6fmESAleV1muxhh4Re1bNb9HS8yAYbn8ViGwXzvUsiiWRveIByDzlXy9sSLVNNOBPHMC70K8n1geDZqjh5n9yNXQ76ELn+fictsw2mkTKQf4yQVJtJO5CqCBuh62+2fvNoaGr+p0i+SdXxBlwC9XDJjSBhcIvTOKwl+bSUaXVm5zPWll7xPUKJrAjcQ1p/Fc38m9FvBgDT67hGlKXS3qI2uUqnTHpjLDoryeKTlpQ2tNm4S6QpC70Vewv/2vSXCJ5TvQdjviu3EIxulPMHmANJjNeHjHzIAIHm6W/KGb59TyICeUG/0DJh8SdZWHHrPO09eANXp+YzQWk+x5/sUOQ8Mqswhl0un+XM8BOJO9rQfzL//nivg3kjxTKeE6bi1xv4+miPUkxG1kSj4wLO8h/pZ+xeSMiEI5sfyp7yk4ohyzh/+bK9vHghtYFIQhjrZ8zMpz+qKeMnCQEt5lMWsHH7hpqj6V9KGTEuQ6N6kKwiKx1vDTPFrUW0fNh1/w/6FqXpZeWiGgzhJtrU/kF7YyJC+V6CnUeJlGf/CkBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(6486002)(316002)(4326008)(86362001)(8936002)(54906003)(2616005)(5660300002)(36756003)(52116002)(31686004)(186003)(16526019)(83380400001)(38100700001)(6666004)(478600001)(31696002)(53546011)(66556008)(66476007)(66946007)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUV4WnBHT2RtbWVrT2FXbTliZ3NxNU1aMFFzK3dNcTlMNjdDT1hpSWMzcC9p?=
 =?utf-8?B?VEphdGZCV2tLYThobTY3b0NFeHNZMVo0ZVB1Z1UxS1FNWGZZOVZxbG93d0Yz?=
 =?utf-8?B?Z2V2MDM4UXplTVFZcmRpRVVoaTNZZFpWaFJDV2RMNDBkazRBZkZJc1BFV1Bw?=
 =?utf-8?B?SVdOME5pa3VhT3ZxWENaNDhib25jTE13WG41eHl2RHViTURtd0ZFbUk1UlJM?=
 =?utf-8?B?RDZleGptZ3FPYmJsWTRCb2tzbVhxeHZVYmo1K0RkbWNKbW9LcysyRjlNOFdm?=
 =?utf-8?B?bHJrK1dyb3BEY0Z3TEpoWHdibFYxZ05MbHYxN0d0MkJBMlUrdGpIVHhYT3BP?=
 =?utf-8?B?RGdGV29WOHRyYjdyVTIzN1ZFTVZqWElScUtReDZHemx0YzNGc1U1MWdFTUp4?=
 =?utf-8?B?QXdxdDlmRnh0SGJnR0lOUDIyMHpwdmhicmJhYnVRRVhOTjZNOVZiaDlwTXI4?=
 =?utf-8?B?a1lnQXZyQnNBWFd6SStnL3FQOVpNSzJoSWwySFNBUllFcHpNSkg3NVRoakZD?=
 =?utf-8?B?R2JOM1dSbGt1SHUwVWpTVVpBQkl6VFp2WnIvbEhaYWVpZitlK21yN1A5UE5m?=
 =?utf-8?B?aS80Z2NxRmlyQXBDNHFJZ0V2NCtIYlBXWW0xQ1Y4eEdaSTRzSVJudzJESXo5?=
 =?utf-8?B?TWZtckxlSUZIeGhqd1R3dlhoWHc2bVpCeGhoR3dPVUFsamtPM0hvc1pSdmc0?=
 =?utf-8?B?NFBPZ1ZOWCt6T2EwN09yNXp1Y2ViTXNEUFd6RDBETVNDckhDTkkwVyt3T3lV?=
 =?utf-8?B?dVZFSjJ2bksvcW1pbFkwZXU1MUFnNXNEbzJvZXV1YWtNWHVhOWRXU1YyZ1pi?=
 =?utf-8?B?ZUEzeXVvc0ExV3M5WHQ0YWE1eG4xOGphcnJkTHgraFVZZXVKVXEvMzdCS2dY?=
 =?utf-8?B?M2RDa3ZkZ1NOWVJYYXBLSC84SEVER3ovMWE5Nmtway9PdlpXRW1PT2h6YWRv?=
 =?utf-8?B?bG5zMGVpbTE1OXNSbTRGaVZUa291R3kyOFpIdFlnV0ViaE10Wk9iZUZaaVRl?=
 =?utf-8?B?bkIxZ2RyQ1NzTSs3Rnd0OWRuaTFLVmk4Q2MrbTdHUmRmV3dxODFFaEppbm1j?=
 =?utf-8?B?UklVbXRUdnN1MDhuY2tmdldydTRXM2VFRW82VzgvMkJuSXh1a0QwejNsZmVH?=
 =?utf-8?B?YjkzY3BYbVlBQ0V0emR1L1NRSHlWYy9lWFNuN0d6cXB4SzJIbG4wODNrZ3o2?=
 =?utf-8?B?QkVmYzB1UkNzc0Y0ZVpOUkw1d0RnSlh5cnloMnppbW5HcHpzRjcxcG15STBJ?=
 =?utf-8?B?Vk02ZUlUcVh5ZXFmRDZDU0lBa3Q5b3YzZkJoQ3Y3aUVLMnBxUDFRSWs3cndX?=
 =?utf-8?B?dUZ1dm0yL0phbnB3Ujg2SGJ5MWVNM20zdWU2MUhESEhVNURGL0VkQ2h3ZkYx?=
 =?utf-8?B?bkFvcjJPNXNyQ0tEQ3d5aFRpRlc5UTdjZlNZY3lQb3ZEZ3MybTZBNzFWUWFG?=
 =?utf-8?B?ZE8xaFpBRGczN3ZoTGpGWERxd0V3YkFkejJGcVp0NFJxY0oybWNrRDU0VW5W?=
 =?utf-8?B?M3k2WURtSE5VNVg4Z1BUeTFRVFdNWGRYR2NqWk1uSkQ0N3Rpak9kWlgyTXV6?=
 =?utf-8?B?SllHSDdRcEJRNUViaDdTZjhuVXFCTnBCdytLRkQwWlE5TDc0RWp6WHA1Ylcz?=
 =?utf-8?B?VzdMd3lpOGN0K1pvT3JlTmZReStjc1FKcEcySnQ5MTU0VmJjZzBGVnUrTHh0?=
 =?utf-8?B?OXpWR3IzY3ZmRVBFN2V2L0ZyRTA5SVVCVEl0cWpkT1FkTkFQeTFRZWgyRDho?=
 =?utf-8?B?TTYvMmFRdGhIL211Ky91S2dNL3hNN0ZVUHBSa2dGV2ZjQzM4cWdUTHYrSm5B?=
 =?utf-8?B?Y0RMTTZuUCtaQUJ4MkJuUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d107b75-330a-48d6-2b45-08d8f226a39e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2021 20:18:24.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xVr5/WgXCX4l/egR9ROICc3+zEUuBzqHi3eB7PO8LWF/2UXR/sHGtBHHJtiBELr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4451
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pNkpNZ16P3VfbwDabduHxwK2IJ12enQt
X-Proofpoint-GUID: pNkpNZ16P3VfbwDabduHxwK2IJ12enQt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_12:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/27/21 11:17 PM, Yonghong Song wrote:
> For vmlinux built with clang thin-lto or lto, there exist
> cross cu type references. For example, the below can happen:
>    compile unit 1:
>       tag 10:  type A
>    compile unit 2:
>       ...
>         refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
> 
> To resolve this issue, the tag DW_AT_producer of the first
> DW_TAG_compile_unit is checked. If the binary is built
> with clang lto, all debuginfo dwarf cu's will be merged
> into one pahole cu which will resolve the above
> cross-cu tag reference issue. To test whether a binary
> is built with clang lto or not, The "clang version"
> and "-flto" will be checked against DW_AT_producer string
> for the first 5 debuginfo cu's. The reason is that
> a few linux files disabled lto for various reasons.
> 
> Merging cu's will create a single cu with lots of types, tags
> and functions. For example with clang thin-lto built vmlinux,
> I saw 9M entries in types table, 5.2M in tags table. The
> below are pahole wallclock time for different hashbits:
> command line: time pahole -J vmlinux
>        # of hashbits            wallclock time in seconds
>            15                       460
>            16                       255
>            17                       131
>            18                       97
>            19                       75
>            20                       69
>            21                       64
>            22                       62
>            23                       58
>            24                       64
> 
> The problem is with hashtags__find(), esp. the loop
>      uint32_t bucket = hashtags__fn(id);
>      const struct hlist_head *head = hashtable + bucket;
>      hlist_for_each_entry(tpos, pos, head, hash_node) {
>              if (tpos->id == id)
>                      return tpos;
>      }
> 
> Say we have 9M types and (1 << 15) buckets, that means each bucket
> will have roughly 64 elements. So each lookup will traverse
> the loop 32 iterations on average.
> 
> If we have 1 << 21 buckets, then each buckets will have 4 elements,
> and the average number of loop iterations for hashtags__find()
> will be 2.
> 
> Note that the number of hashbits 24 makes performance worse
> than 23. The reason could be that 23 hashbits can cover 8M
> buckets (close to 9M for the number of entries in types table).
> Higher number of hash bits allocates more memory and becomes
> less cache efficient compared to 23 hashbits.
> 
> This patch picks # of hashbits 21 as the starting value
> and will try to allocate memory based on that, if memory
> allocation fails, we will go with less hashbits until
> we reach hashbits 15 which is the default for
> non merge-cu case.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 120 insertions(+)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index aa6372a..1e63ca9 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -51,6 +51,7 @@ struct strings *strings;
>   #endif
>   
>   static uint32_t hashtags__bits = 15;
> +static uint32_t max_hashtags__bits = 21;
>   
>   static uint32_t hashtags__fn(Dwarf_Off key)
>   {
> @@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>   	return 0;
>   }
>   
> +static bool cus__merging_cu(Dwarf *dw)
> +{
> +	uint8_t pointer_size, offset_size;
> +	Dwarf_Off off = 0, noff;
> +	size_t cuhl;
> +	int cnt = 0;
> +
> +	/*
> +	 * Just checking the first cu is not enough.
> +	 * In linux, some C files may have LTO is disabled, e.g.,
> +	 *   e242db40be27  x86, vdso: disable LTO only for vDSO
> +	 *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
> +	 * Fortunately, disabling LTO for a particular file in a LTO build
> +	 * is rather an exception. Iterating 5 cu's to check whether
> +	 * LTO is used or not should be enough.
> +	 */
> +	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> +			    &offset_size) == 0) {
> +		Dwarf_Die die_mem;
> +		Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
> +
> +		if (cu_die == NULL)
> +			break;
> +
> +		if (++cnt > 5)
> +			break;
> +
> +		const char *producer = attr_string(cu_die, DW_AT_producer);
> +		if (strstr(producer, "clang version") != NULL &&
> +		    strstr(producer, "-flto") != NULL)
> +			return true;
> +
> +		off = noff;
> +	}
> +
> +	return false;
> +}
> +
> +static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
> +				     Dwfl_Module *mod, Dwarf *dw, Elf *elf,
> +				     const char *filename,
> +				     const unsigned char *build_id,
> +				     int build_id_len,
> +				     struct dwarf_cu *type_dcu)
> +{
> +	uint8_t pointer_size, offset_size;
> +	struct dwarf_cu *dcu = NULL;
> +	Dwarf_Off off = 0, noff;
> +	struct cu *cu = NULL;
> +	size_t cuhl;
> +
> +	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> +			    &offset_size) == 0) {
> +		Dwarf_Die die_mem;
> +		Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
> +
> +		if (cu_die == NULL)
> +			break;
> +
> +		if (cu == NULL) {
> +			cu = cu__new("", pointer_size, build_id, build_id_len,
> +				     filename);
> +			if (cu == NULL || cu__set_common(cu, conf, mod, elf) != 0)
> +				return 1;

This is an oversight. I forgot to change back to DWARF_CB_ABORT after
some experiments. I just sent out v3 to correct this and added the
kernel patch link which is needed to make this auto lto discovery work.

> +
> +			dcu = malloc(sizeof(struct dwarf_cu));
> +			if (dcu == NULL)
> +				return 1;
> +
[...]
