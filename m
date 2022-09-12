Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C895B5F4F
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiILRaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiILRaL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 13:30:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4C1E3EE;
        Mon, 12 Sep 2022 10:30:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28CEZrxI015723;
        Mon, 12 Sep 2022 10:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oco2PU1eE87Z2buWe2Giwe9gG4oENGG/ZhrUbk9VCcU=;
 b=JX7Pb6fraCh1RVwBHwjVFbD3vGRInk1/TVrYEU9Q4mNFzhWyDPlBYwqwiuOJv6lpftAj
 T6XGj3dBBx1IK/MzDGU0TSiBLV35CcsJ2nomPNW5hVbBMAk/+m+2X23EXXusby0o/BtX
 mFWaKUT50HNNE32utMG5RKRSaH64odbyPXU= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jgp39bvs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEo0ve6RcRS+jAfCn7zMS8O51rGRjf2ToV5J6t5eyPrCbKYSupuuDm+SKHDvZUURntIrSHJ3E67ofkyhmXuQEr6ZO2UghX5Cvku/zJbiIhX8TM2ozKYmWST0PaU4QsSZ8OgeMhrrd5aKm/9amTum/7ZAelzu2IN8W1QRQhyN1BfWYAx2Fz0bqL6SmzwYjMsAq/xu0Ljl+yRwqmRejH7RxyybH84qYFo5qqn9DM2h7FwZaiHb+4sHDV3Ca2Qe8xB8O0sEFrl28/1s0/P8Tv2WMMm50CTarqQbYc/8IxKXkAEnd3PNprEW5Q3p8UaXd6lE7OI18iBwMvjVNPdYQ4qapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oco2PU1eE87Z2buWe2Giwe9gG4oENGG/ZhrUbk9VCcU=;
 b=HURv4xyj/k7sFQYo8t6eD3TxFgmcDTlVkH5NYKrVvR5N9kIVUeb7VJgMTf1TW8XNjfEDsJZw86ubT4p+yvvag71VvFJkGtrQFU1Pgdkfimn/bCH0sAzH22Z3qd47F1tWoNWohbDM/KEit0nw+Ez/SqN74Oqj0CgiwjZeenXJXgiDwta6eicbonwv3/2FddjZM0aoDAhPpHW/LkPNDuKgnz44s5IC36jIIiigECfsGgETaj6WlE9aRtgpOhqRzYfTYObXnDszShrjU2gB7BE0Wy5ndvEIJCnCBnd4FFXkQDmaQGPhCThPsid5ApETqnDbqO/ia0qhV36GjDCglZVB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2741.namprd15.prod.outlook.com (2603:10b6:a03:156::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 17:29:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 17:29:40 +0000
Message-ID: <7cb9ebd2-5ee1-f00e-5d8e-0fe454f975a0@fb.com>
Date:   Mon, 12 Sep 2022 18:29:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] libbpf: define bpf_tail_call_static when __clang__ is
 not defined
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>, bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220912063514.2824432-1-james.hilliard1@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220912063514.2824432-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2741:EE_
X-MS-Office365-Filtering-Correlation-Id: fbef7fc5-75e7-4fd2-ae6e-08da94e45f8c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoxgAklexTrbT8kHRFgIvOhSZ+KKA058Zej99UuYsxcL+tq0BU3AxDrJEx7WvxSdaeV8leNKEB/kT9+H80JZzCJs4djA0QWcwKuMUWYK4nrTaLkyfmRBbq7rw1E/idXcihdBpDQ0gANRo7ISLPIV4BYUnxJ9FJjeSH1PUpcTOPpdbqC6gOchH6ekb+Bd5fZyoZJkH5RfHZPJ6ehWxl92ri10c558DkU0wz7iU0Q+LpkbNS0lZelRqVguQrolHJ8qpq51PRcBv/grWghgCpx8kCbY76VSri9oq7v5PgON0PT88pj/cMMprNkaZnakDhtyekzwrd/xsQW308z3ploqwr6rfitXqpVK6U4J+LH2KNT3xySJzZfbbyqqJDnGpSbYt6/2akXqH3nSxuAqbG6Vx303HJJrHJH2S5U61JxOP+Uhi9j2R2ff7zAq0cS0LVjPWgJ4wA6QQGLibyikrCmZBxlNX/lwdYbsOwvVJbuzD+V9U+z98xkpXcmIXfCWfhapcGT7NCla5WwLxO+uTh94jCBwbGFqx4TinYfOJ56sAvuUsrA38mQvlHJqkmG2pY4Kq5yJ0aGT4yQAeoJQyy/biOhbO+cDqdUHqKRPwtxBSJYiqBxAPfndNzDz8ojDnxKgRHAHthUpj/WEkIQ3GNLow55ySxYkHQ9YmFeNpqDwQYsWKlnKnFzcnlHAatNVBGetgw8m6TCxQ/8GMTEMtm6QHREaF3zU8nPw+OBh93GtOniczzNQXylvGrBYaGFn1MNbqpoRgyhkQhveEOxrJJ9rly4xWzxf0MdHt4LSZHi9NOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(53546011)(6506007)(6486002)(4326008)(186003)(8676002)(36756003)(2906002)(31686004)(41300700001)(6512007)(478600001)(54906003)(66946007)(66556008)(66476007)(7416002)(5660300002)(38100700002)(316002)(6666004)(83380400001)(2616005)(86362001)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNvbnB2L1NSWnZZc0lNVkNIMUFEZzlHT0hNK0R2MWhsNG1hdVBJeXQybW84?=
 =?utf-8?B?dDQwVFlqdUJxeldZQUhyTGRQZXFyT3c0OFZnZDVKck93TUVxZmRsQXlMRzZE?=
 =?utf-8?B?RE11Zyt0ZUdRQWJUVVhPb3BDb0VNNFppWVY1bjF6dkRoUVF3ZHBxOE1XL3ps?=
 =?utf-8?B?aHBMVGxORmZhcEdodHN6YVIxN2M5UFpBd0pZRnJQV0VMVitWL25yMCtnK2s3?=
 =?utf-8?B?d2Y3TGE2Vjlua2RLeUZNVjRiU0c3dC9GT1pGRDlIMmtpZXZTS1crTExOaW5w?=
 =?utf-8?B?eEduZXl3MlpBWjVFWmlLZWh4WTZGVVNYWEVqRkJzME9rOURteHh4NzJaRnNT?=
 =?utf-8?B?N25BcnoxZTRRUllNZU9KM1dDd05iN09DdFRzT1dVc2hBSjd1UHIwNXNQYVlv?=
 =?utf-8?B?U3ROTXRmY0NlOXhlZWovSmZHdElPRGJYaXZLY3lKRkZTajlMMklKeWZ1QXc5?=
 =?utf-8?B?cHVNR1YwYzNDQ01rZXljVm1jZ3dNUlZ1Myt3SmFvaVY3K2RFSW5XTkVQcnR0?=
 =?utf-8?B?YWg2cHBZUWFFZmE1UGFQRklLRklUZ3JIZWpjN0ZaNnFwWEVaUFhuU1ZicWJX?=
 =?utf-8?B?clc4ZnpoSzdHd0pGLzdWL1VFVmxQM0JtZHJTaVlhRlR6VE5vUzRGa0htQ096?=
 =?utf-8?B?N0VDakhqOEcxTFo0MFg2enhNRTFqQWNqN0FndUxJWjJsd2duc3pwMldKeERu?=
 =?utf-8?B?dVQwZDlJcUNDbmQ0bXpSRlNrWjRMaldlMTl0VmtYa0VyZ014MUVubUE3VGE0?=
 =?utf-8?B?R1U2dXNjdUVNeW9sSFpVZHhFVDcyWldaSjd4SVJGTHRKa2tCZ2VKNHlYdEk5?=
 =?utf-8?B?MzFIdndFMk4weFVVOVBXM1VqT0FGTmczelNGTVBqbHNhZnlqV21kK0tlZWJU?=
 =?utf-8?B?aUs5LzhwSTVodE4yY09IL29HeTFuRkRHckJCdmYvSmtBeTg2UHB1QlBWNXJ6?=
 =?utf-8?B?d3ozYkVFUEdsdVNGMThodEM0cnNSanRoSDRHK0c3TFlKaVlyWTQxWkV2b3Ey?=
 =?utf-8?B?MTZzcHpZMEJ2UzZDYlhJaUxXV2Jva2dXejk0VkNKdmpid3hacXRBQTQrcW83?=
 =?utf-8?B?U3hkYzh2M3RacTlIZWtxYUZlczRMenNWZnB3a0N0WVdQaXlXTzNmRGNqT3ZI?=
 =?utf-8?B?dTQwVkw5L2xmdVN4VkZhakNrblJFczVTL3hpTlJUdVQyaEtGQ1pkbEVvZ0xq?=
 =?utf-8?B?bUFQZkFIVDRWVGZzczlPNnU3ZEtJOGVTK2piV2FMRGdrek1TbnFSa1pGQkM3?=
 =?utf-8?B?bDNIaENMcE55VStWQVl2VCtjQ0JMMEpZamh4aTN5R1ZRSXJST0dzekVwYmI2?=
 =?utf-8?B?RlAvNGtyUDk5ZEh0R0hNY1FHQUlkU2hhdWR5UEZqeEVDUFZsUkM2Rm85ZUh6?=
 =?utf-8?B?VUNqZG90bHlzT1dqRVlobUZFdXo1MmxQTXBxZlMweDNwNVpERUNOeEl4SDBt?=
 =?utf-8?B?S2diWldNTS9JLzNKYXErNWJzVmdBSTVzaHhzMkVIMUpEWXZQcWt3Z0V0dGxr?=
 =?utf-8?B?VERXNG1tSXdiRGhzQVcyM28xblppTk80bzRzWElWMW14SmtINkRvWnVNelJE?=
 =?utf-8?B?TkZVeTZuWFIwbndNSUNNbkZKWEIvMnJxeDlIQzV4MmFiZlUwSnQrY3VJYzdJ?=
 =?utf-8?B?NG1zMEd3TjUzaHZ6c0IrckhWQ1MzTUkyc1lEZ0tib3VXUXBta0IyWDQyMjlM?=
 =?utf-8?B?dy9WMkxES1VuTWx3UGJOaTZ1VEZvTzV4YTE0S0FhRWswVG5vamFkM0pJNGZx?=
 =?utf-8?B?ckJYYXd5b3ZwOWt1Rkx0MU5VNDVUK080ekJqS09BNVpsUXhlWTFySE44U1pi?=
 =?utf-8?B?VUI4cWl1TjRWZmRyaG0rNnNQZjZWZTg5bVAwSEhHeXp1ZTErMnVzcnNJZ2FT?=
 =?utf-8?B?c1V1MkJVaHc4bm5EbTlac2pkcmU1VnVxd1VHUTlZOXhxYjBzYmM4bVc2Wm1W?=
 =?utf-8?B?WWk3a1Y4VVhZRDJIOUlxL2FRQ1NWM1V5R2g3eU5uOUF1U3JkQ0NmZ0l2cWdQ?=
 =?utf-8?B?bmxLRWY1Q2ZvbHFnVEp1eUx1eUFDYmJuaHljcnl4T1hpQVdTdHRUV3hoYXNa?=
 =?utf-8?B?SnhZbUE0c0tvcWRZdFY3ZGJsT1c1dEduL1dKZzBLVjdIZjlhMGx3dzluWCtV?=
 =?utf-8?Q?RAJqiJsBo5ykpAyT2u+ER98VK?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef7fc5-75e7-4fd2-ae6e-08da94e45f8c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:29:40.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IwIjXc/N3pG2ZW+LUdv8NMXSZsOtyuWOuT+6uFnmg5V1VdG2nQ7dimyXz7mEc96
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2741
X-Proofpoint-GUID: ErESJmRdkgGJiV8c56XQXRzRlskc0FUr
X-Proofpoint-ORIG-GUID: ErESJmRdkgGJiV8c56XQXRzRlskc0FUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/12/22 7:35 AM, James Hilliard wrote:
> The bpf_tail_call_static function is currently not defined unless
> using clang >= 8.
> 
> To support bpf_tail_call_static on GAS we can check if __clang__ is
> not defined to enable bpf_tail_call_static.
> 
> We need to use a GAS assembly syntax check so that the assembler
> is provided GAS compatible assembly as well.
> 
> We can use gasversion to provide a migration path to llvm syntax
> for GAS once llvm syntax is natively supported.

I didn't see a gasversion comparison in asm code.
Is it possible that we compare gasversion to a known
gas version which supports new syntax? If the gasversion
is supported, use the same syntax as llvm. If the
gasversion is not supported, output an illegal insn
and it would be even better if some error information
is printed out on the screen.

> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> Changes v1 -> v2:
>    - use gasversion to detect assembly variant
> ---
>   tools/lib/bpf/bpf_helpers.h | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 7349b16b8e2f..5b98f5506798 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -131,7 +131,7 @@
>   /*
>    * Helper function to perform a tail call with a constant/immediate map slot.
>    */
> -#if __clang_major__ >= 8 && defined(__bpf__)
> +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>   static __always_inline void
>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   {
> @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   		__bpf_unreachable();
>   
>   	/*
> -	 * Provide a hard guarantee that LLVM won't optimize setting r2 (map
> -	 * pointer) and r3 (constant map index) from _different paths_ ending
> +	 * Provide a hard guarantee that the compiler won't optimize setting r2
> +	 * (map pointer) and r3 (constant map index) from _different paths_ ending
>   	 * up at the _same_ call insn as otherwise we won't be able to use the
>   	 * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>   	 * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
> @@ -148,12 +148,18 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   	 *
>   	 * Note on clobber list: we need to stay in-line with BPF calling
>   	 * convention, so even if we don't end up using r0, r4, r5, we need
> -	 * to mark them as clobber so that LLVM doesn't end up using them
> -	 * before / after the call.
> +	 * to mark them as clobber so that the compiler doesn't end up using
> +	 * them before / after the call.
>   	 */
> -	asm volatile("r1 = %[ctx]\n\t"
> +	asm volatile(".ifdef .gasversion.\n\t"
> +		     "mov %%r1,%[ctx]\n\t"
> +		     "mov %%r2,%[map]\n\t"
> +		     "mov %%r3,%[slot]\n\t"
> +		     ".else\n\t"
> +		     "r1 = %[ctx]\n\t"
>   		     "r2 = %[map]\n\t"
>   		     "r3 = %[slot]\n\t"
> +		     ".endif\n\t"
>   		     "call 12"
>   		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>   		     : "r0", "r1", "r2", "r3", "r4", "r5");
