Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB45B8977
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiINNtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINNtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 09:49:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EB7333B
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 06:49:11 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E6xn6h027464;
        Wed, 14 Sep 2022 06:48:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZQ7TBqqC2x9Z9p3QyxH1MtQZIJHTx5PyICW9DNGBsXo=;
 b=Ly5JfXOUidO12v/nRmz78GqdTptGgxPKa2B0iCTrdJLzz7S61+rtiq3Xn8HIVEibsJbK
 DbpvPQGgtHcaY++lhyNULWV2bKgsNYDQObxbzvGe/Ak6uqUTxbbD4cZQXZPQx8w1c8OO
 dvjVumxTWeOdoqsvNk8wVrmsL1mBsr3cxa8= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjy09dmse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeEqlIKVd7FGwUFGAeb/17d859FEisanGAlCjVMmekj5v8O2Ri8nuxQlxZpFzUwNXN9UP2DjFt20RlHe+PSx8wJXSID/n2aYDJR1cGrcbGabKW9pk7p9qlz6xCCCqn7+1piuMm7GDwXa36eR52FXOHbKFgo8NsTUlF/AWhORKOm1rnWdvZ0RXTU8zQ3fcA7FYnh9w7Efz/I9+mn9VlotnPyClvCE0sxdrjHD6kVdVngx71UEkfL6nAWhGId7eC4TChEgoskcQxRalskxel1V2mfEnnN9SMw3DZ+stJ+HVRlQ6xY7f6RdEPyXYQXUWo2+aEdsYveJJjT3WMleWFaccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ7TBqqC2x9Z9p3QyxH1MtQZIJHTx5PyICW9DNGBsXo=;
 b=j+Ujkh12aBCSHYCvvCk49dr661LvZW2C36sfrhCVfdF9gVoSmF4ietsOn0me4STuZ9/lw1xvvpzJzIzd8SfDQ1NIaJLqWdYrdyROQRhEHe3+d5fPnwDaxj0IS5gANu15Fgx7L7EJ0zSE5yk2s/O4JAmgrjq42H5/cwug49G3QqYVddDFOH8gRrkFoWjgbkC+MBZg43tJcDjo0efpFPPB7D+nnIHtkS5XotXeWXqEpUfoRWxh0kkELT6PuS6hg/ZfiinY8rvvuAd0s8j4lgPbMaYxblTsmUIIMm30KblSp027pxW9fzX4ZBFQBNM2TkvS1K7qhGMWfKf5LOCha2sG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SA0PR15MB4013.namprd15.prod.outlook.com (2603:10b6:806:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:48:54 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%8]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:48:54 +0000
Message-ID: <47644903-156a-d244-9b9a-502de20fea4c@fb.com>
Date:   Wed, 14 Sep 2022 14:48:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next 2/2] bpf: Consider all mem_types compatible for
 map_{key,value} args
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Liam Wisehart <liamwisehart@fb.com>
References: <20220912101106.2765921-1-davemarchevsky@fb.com>
 <20220912101106.2765921-2-davemarchevsky@fb.com>
 <CAP01T76YeOQLfYBX+63Z+cbF+xZUH-4FYG3MyNTiKtP8fLPGtw@mail.gmail.com>
 <CAP01T75Ldqze_sgiDCpvwLN262pEDRJpM2zs46FBW68yxiVBTA@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAP01T75Ldqze_sgiDCpvwLN262pEDRJpM2zs46FBW68yxiVBTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::23) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|SA0PR15MB4013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9a9c00-180f-4c90-d8a4-08da9657dcec
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tIwKBvYjIhA/jLW6Jpq2gp23bomzWPKSBCwGLqmrj1ck0cQMewVaJKN8wkhu+C4zpKacqza3QJD0DioTDyPmBmyZNp0yhvdQrXNkSPX49fgnfRYxXTmmsaLHjhZCy+ivWta4enq+9bi15MlH0OGy+eWth37/vfJy7uQkPik30UV+UnvSpHrX53oTzTtPjSc4Z3Fch+a+hknPB0iuLuEyA6QGe3JtEUd/iKi09b1iiwQ83sLflekCV7/J7Yz3xlWC/X9LrYkuHQUWWMORpI8xXlLjhaHpvcCOag4XuB/gchwTY0ZaP58Vz9qoMw1oAAANhb3tQTdT3RqxITsPa4c8yodpHfrd1Qr71XyYdHnfvZMMZej7I08xR6bNVPhylZC3MIPNDwtz5jIlzrbtF1ZkcUa7VRroeqULnfuBsQV2JakNL/7TtuV4xsStZc10tdBemMZtxyulyGEjGo5cnEnkqcqknatYu/E4JZ+k5Uf1crSZN4bfNMTC5+ClQSA3R7cM3kHSdZjPIPsP5EWqkELMXno4GTWN1oUVkQ/vSPUHgVef9s2VnHAD6Q3vioAHL9aalzrny5EmEW0+600m3PPeSVOGiLqVTN3rNe8c0346ySsKegN68NgZ0DEzNrkZ03VkqRrh2eZkW4INyoY6u6IKDO8v+d82Y2zV/PDuDK79OwjiO/oqaPn2nLzg1AqnXxh/quLLjrX7/JDb5HYaOf8t4iExujgwigvd7ljF2l3vRXcBmrn5QUNAA2OymSpW1buta+qR3HfUTcUKAN5HdxGsFXk/uVYTP142UzlVMaZjGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(6916009)(66476007)(316002)(41300700001)(54906003)(36756003)(66946007)(6486002)(2616005)(6666004)(8936002)(6512007)(186003)(53546011)(31696002)(478600001)(5660300002)(86362001)(66556008)(38100700002)(4326008)(8676002)(2906002)(83380400001)(31686004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjh1Nm5DZDAybzlLanFzRmhQT0dtaUZOaGpWVDBIQ3I5c3k1OFlZYWtkNjg3?=
 =?utf-8?B?VWd2VGdva21CWmlSaHpZdnh3dXlxZVhzWThla28zTWd2T2xDMG9NTW1SVmRV?=
 =?utf-8?B?UU14aDB1VW5SbnFnaVVpQnFQN3A4ajc0R3VkVlpMbEtSQ2tQU1BWeXVIR1FM?=
 =?utf-8?B?c3laVDJ5WTBBOFNXenp1RjZpUmFDOXNUSmxmenVTci95TlgraW1iL0tvbW9p?=
 =?utf-8?B?V0JRRzIySElyRDBIWlN0NmpTMjgrOGVPaERnNlZHcnU3QzRjZlk1QkM3V3Jh?=
 =?utf-8?B?dGxLdXlPd0dWa0NwUTBRVHhpWFFYaS81NSsyQVB6K09RVnRneVVNV00zUWVB?=
 =?utf-8?B?c2NtWDl6UXpVSFhGRDRqWGV3QTFvZHhPYmMwelRnNDRueURXWjFzOFk3K0o2?=
 =?utf-8?B?ZlVSdDc5Ujk5SWFNeWlob082cUxiZWlsWmNETHpteEFJMXMvSWZZdU96Wk1X?=
 =?utf-8?B?NTE0SHlyTXR4WjYrTkRNYVdFcUpYTURrSWExbnNOYnRzTVpDTVoyUkR1YWpC?=
 =?utf-8?B?MUhSbzhqbnZtOHVlZGJsR1IyTWF3dEZ6Wmd1Zkd4Nmc0RzJiL1ZaV0tkZWpY?=
 =?utf-8?B?dmJnL0RxMUpVeFd6TWlzamxmb3ZpeC9EbW9ja0I1WnZmTHpJTW56dzR4VTNQ?=
 =?utf-8?B?d0U4NkJrZUJzbFA4aWRzVGJiSTZiZEJPb2h1TDJyOFdGU040cDBxTHJYcjh5?=
 =?utf-8?B?S2lqZ2x5Zmw3M3lTRzl4Y1BoVFBFS051ellLWFZMOVpTQ0U0MU1LMitvSGwv?=
 =?utf-8?B?NjVSZ1U5UXFmQXlJN2xEbVFQei95d3IzREFwT3FzVUZPMlZoOUo1ZCtxS3Fj?=
 =?utf-8?B?VTN1dENvQXVFMHhYL3pabmxLa2Z5cTVESFpnbW9uVGxCZTV0WEJ2anhYa1JB?=
 =?utf-8?B?UE9hRHBkWWo2VGhnQ2VBR29aS00wS3dtemUwaEhSQTJ3a0M5U0FkeStVdGlB?=
 =?utf-8?B?WnMvcTl6U0taZS9OTFZIeTM4RHpQLy90R3QwWTdkaXpxelZkL0IyR3IzWVcr?=
 =?utf-8?B?SmZyc1VabDRabTFqWCtHWE5jZ2VwRzlPbG1XSFJNUUtJVitYa0I4VFZ6YzZI?=
 =?utf-8?B?TlFScXlRdWZ4R2NISXR6YTFKQzBuZGtLWjBNa2d4WWZyZW1kcjJkYktxcTdo?=
 =?utf-8?B?cHNJQ3N3ZDVCTzcwS1IySEhXQmZVZTdPbjRaVDRhYzFzOTNmTWZ2MzZha2ls?=
 =?utf-8?B?UWJncVRaSW9hTUtUZ2JGUno3enBXWUg2cFMvMHlLbm9EeFFJUWUwdmtTZmdi?=
 =?utf-8?B?eFg1OHduN2JqNXkrZHEwT1R2NTJWanRKR0QvZURVRjFxRzR4OG5GTkVQaWtH?=
 =?utf-8?B?K21naTdsVmlWZHUxaEpWRHIvbGJ6bzlqaTNDLzEvb0VtUHIvNnpIb2QrUW5y?=
 =?utf-8?B?dDVhV05ZVmYwOTFTYWluamNhR215cUZub2ZHWU5La2xCOHFGY1g1N1NYT1dZ?=
 =?utf-8?B?aWY1cVlEd0tEclR5eTNmVXhlUlFFVWtUbGV4OGdNbFVUcnBwbkxBMEpKQWtn?=
 =?utf-8?B?UG5KK1g5YllkaWNEdmYzWDFOV1JIZkZ4QmJiTHRzMTVPOS9jQVJSaHl1ZzRq?=
 =?utf-8?B?OG1VSEhDN3VmMmN4clZpY21ncUpzYkJrdG1vdEdtRUEzTHNtS2g3MVVEdzkw?=
 =?utf-8?B?bHVMSVgrSFdOZzJwSm1BdTBVVDQvcVFvcGRoeVFtcGo5UFcvRXBDVXl5THhj?=
 =?utf-8?B?MzMxWmdCZEE5cXJGTVFYNzkzRElCT3JUeFBrdlYrWXdNOGRGQTRMbTl1VUZX?=
 =?utf-8?B?bm5zb1VwUC9kYlJmM3lrWnQ2MUo4UnFQWHlHWTVzWWZGNjZubTVlSzQzQzdS?=
 =?utf-8?B?TTJqeXg3a3NveTZvTmRidjFlZFdCeGc0VTNTVm85TDNXVHpCcGtERm91M3ls?=
 =?utf-8?B?d2pSNXVFa2U5VmdVY1hkSm0xYjlsa2pxeWNnN2M5eU5yUGtlUGRCZ3FmaVI1?=
 =?utf-8?B?ZzNZS1hEZ3NteUczZXJBYU1Iak90Vnk4TU5JOGwyNUVIZ2NidWJ3bTZPVlQ4?=
 =?utf-8?B?VmFIZTRwOWZFZUthY3NraXJZc3k1Vm84OEFFTlk1Vlh1K3RmbU1XN1B6cGdR?=
 =?utf-8?B?c1FHbzRuVUxWTG53ZmpsbHV1SmFJL214MlZ1amFwMDMwRW5wdXUyWnhrWnA5?=
 =?utf-8?B?WlFzUm5mNGs0Mnk4U1VXSTdCQjhOL0dQaG9qNjNqcTArVTJJUThsRDA5VjMr?=
 =?utf-8?Q?eL5j7W8QBPnTOOSFpcQ8yc0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9a9c00-180f-4c90-d8a4-08da9657dcec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:48:54.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpQEhenh+qfn/k1DF7hYpJ8q+0RQ6X73IIi6Aw8CQslMoEpa22hKs9zxdfuoa5J9eR3tJ52Ol4MMELpb/YilZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4013
X-Proofpoint-GUID: N8iKqAuh-OPXzEr7YgQqhh6Biktmglt6
X-Proofpoint-ORIG-GUID: N8iKqAuh-OPXzEr7YgQqhh6Biktmglt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/12/22 3:34 PM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 12 Sept 2022 at 16:34, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>
>> On Mon, 12 Sept 2022 at 12:24, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>
>>> After the previous patch, which added PTR_TO_MEM types to
>>> map_key_value_types, the only difference between map_key_value_types and
>>> mem_types sets is PTR_TO_BUF, which is in the latter set but not the
>>> former.
>>>
>>> Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
>>> already effectively expect a valid blob of arbitrary memory that isn't
>>> necessarily explicitly associated with a map. When validating a
>>> PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
>>> already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
>>> logic like that in process_timer_func or process_kptr_func.
>>>
>>> So let's get rid of map_key_value_types and just use mem_types for those
>>> args.
>>>
>>> This has the effect of adding PTR_TO_BUF to the set of compatible types
>>> for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> ---
>>
>> I'm wondering how it is safe when PTR_TO_BUF aliases map_value we are updating.
>>
>> User can now do e.g. in array map:
>> map_iter(ctx)
>>   bpf_map_update_elem(map, ctx->key, ctx->value, 0);
>>
>> Technically such overlapping memcpy is UB.
> 
> Hit send too early.
> To be fair they can already do this using PTR_TO_MAP_VALUE, so it's
> not a new problem.
> 

Yeah, I see what you mean and agree that it's a bug. But as you concluded it's a
preexisting issue, so I didn't attempt to address it in the v2 series I sent out
today.

I agree with all other comments and addressed them.

>>
>> Looks like for this particular case, overlap will always be exact.
>> Such aliasing pointers always have fixed size memory.
>> If offset was added for partial overlap, it would not satisfy
>> value_size requirement and users won't be able to pass the pointer.
>> dynptr_from_mem may be a problem, but even there you need to obtain a
>> data slice of at least value_size, if an offset is added
>> slice will always be < value_size.
>>
>> So it seems we only need to care about dst == src, and should be using
>> memmove when dst == src?
>>
>> PS: Also it would be better to split verifier and selftest changes in
>> patch 1 into separate patches.
