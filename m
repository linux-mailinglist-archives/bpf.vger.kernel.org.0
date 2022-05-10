Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028652269C
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiEJWHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiEJWG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:06:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE45FF27
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:06:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLNkx024931;
        Tue, 10 May 2022 15:06:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vrRQfyc68KJDJfuDomm9q/gKAkoviCnmYUO+rf1fdn0=;
 b=O0nCWzq3WRsIibVuI+hsyIbwNRjWNgWaOU+ngEaaIFEsrFlbNQ7Ruauisr0MEnPLdvfW
 Zwd3uiqXbbQ5izjdDKu3qA6yn8h6WGxIZnpuxr10czzzgo9kqphPdzXzcuKirHCYTBPW
 h93LqM7oDY3WAiRzF84ufMIdJh+jPIBKlL8= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47w7qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYGkaceCstlLhFRNjOLDQGQt+axa5fWTEIoz9IuoCz1PUNPmuu3dd0f+w0DSNM/InbL0Z6TZQTwrFIuNNAiXhvQYBR7fEPjStIGE1Dwewkcs6ztWUyUGHc2kdAD/7FGu72qhUGcCECITHDkPhj7M6WIYtMnevp+EsZ6RWIhRbZlfddZ4ZMcav4zXdCj3YjCcvtS9w9fXUY8EgT6LQKG2jyohQJcJVqJ+GzDF0QMWX2viQEZiSMPhPvllY+tVwgSVhUHibQkG/mhjgrs3GNi8qQ1vJgk9ZkPr9UrTpS9z5+6fkSwMCIHHqhac6VyF5JdlFFIpCIASlva32soMJ7KEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66wt4NB05wL4nzc0iR/ats+hkRqagw1tZ8sSHvtEUx8=;
 b=QM9JB93SWe0q3ox02wUVbeNQSLfhAk4vdmTLBSJz1Z4QAFeFctiHXXPKkcDoGwI6vwclbZxM/ncHyBmSNAQAHIu43HjItFqjKBQT/9cNsE1gsg3Y8agNnGCvok4eLvnzG2r1e44+Zpgtv6JMdnqp817OHAp6pNh7bPCBg+FBf8KBW5PpG2noPg4Sb4XkEuDf466yxqfRnWvQwVsCAM/woEpyOiKNBkZR9lfuY5+BqiZQEwHN27rXThmnCzI6nhgI2dO/F5wCm/J2XixVEvx5FZGFlDNxfInqMT+YpR+hlFNB/HVz4amqis6ywIvOezPZB2ttzVpD9reJyYhljq+J5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1593.namprd15.prod.outlook.com (2603:10b6:3:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:06:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:06:40 +0000
Message-ID: <be27f832-c803-1ab0-2180-74bf7177ca41@fb.com>
Date:   Tue, 10 May 2022 15:06:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 01/12] bpf: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190007.2576808-1-yhs@fb.com>
 <CAEf4BzbqQDVsiaY1u5G6QAu_3Zq8Vn19qBkzuzVYX0T_e3OLSw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbqQDVsiaY1u5G6QAu_3Zq8Vn19qBkzuzVYX0T_e3OLSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8319e9-d9f8-41e2-b248-08da32d15c10
X-MS-TrafficTypeDiagnostic: DM5PR15MB1593:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB15930F552F4E5EE4D2ABBCDED3C99@DM5PR15MB1593.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNch9qH+h12NUZl5OFL6ztSlOu/tAY6svkRu0AZ4JpPsMgf8EnUG8aK9P3uLEhfXKtBlU8a1/GEci2uJnJs1fIur77KNwlyKF19LbJjEpLSxLJjtPmWjlXFgGIP2YyARJuNg3F//endffWNEx6l4msWqWU50UlGZyDEG1R6KiKiUlR8oqVyYMW/ze+2GUb9nugtxBj4PaCLSC/QbRmZxqc+8kUsxtm2ENBCfvlzL9e18izte7ACZTyWDcPjO1XUPWCWVV0gtXyunu5C57zI8J/3AOTm3qpgNaEG1yNA66u+ylFai0Eu5YajKZFYxR23rfdwhhwDPYNu5zokTIXt+V1nIpAHuET/brvnVmfJi2ilhNWckSMUjTrXoS9+hSXmbbeNlZqxtZ4EjM9HWx2w+Q7nL33Aa+LVm8l9C4qd5Dw+gO5JU8ks47vyvc+JxnvgTzMhj9E7w4cGFlwEz/v9Gqle/SkNgOP5OAea5m+wInOjoNlvy8QWypheORzXijjcEtajHbDZF93vrxLnG8PJ5K2IS7r4+WezySo749oLGNumQsaZ6KkgpngY0jRgSBup9EGWte5vdryyOufDaHw3YZ9zNJndGuZDhehOIlxtlm2Xy7b1AwaEkyf9gOpJxZs+7HMYen1aeAkTtu+VR9M5SNoK/c8iJA9ziCOQspsLM68olgOQnnXczhpPdj+gqZ4rcAVs4xjTiUgtSnO2pO4KyfQ8FSp1es/AIVY+UKX4JxJcMabgIqVVdUY/2UioeNjxLkmPa6ewDu6x4yBQ66aJlQqPcnzcEaiRkEKz2JDIktvhelRMep7BQ+7NXQ4OPvQhCDmhl5jTTSwK/FN9QVFWEkMqTvQyC0+i208f2wiGepv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(31696002)(4326008)(8676002)(2616005)(6512007)(2906002)(6506007)(53546011)(52116002)(966005)(6486002)(83380400001)(316002)(5660300002)(8936002)(38100700002)(508600001)(31686004)(186003)(36756003)(6916009)(66946007)(66476007)(66556008)(54906003)(86362001)(87944003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxRTEZQZEp2cnhoQ0dwL3NPWTR5RXloREdHUithbFpJRDVRUFNtSnQxSDFF?=
 =?utf-8?B?QzRzM2JLd1ZmTWU4dWRGQm9RSjViWWRIajRmK3dhVmZGVVNrUnhDQm13RGc4?=
 =?utf-8?B?RktMbFlBeE1rTjVZNGhweEpOQ1RXLzdjVU4vQUNKZjFTeWE4ZUs4RnIzL0FD?=
 =?utf-8?B?QmkxK1VVQVZFcVI3YVNobUwvV05UY1ZCTGNaS2dWRG1CV2lDU0YxSkcyZGtr?=
 =?utf-8?B?c3dMV3RJZC9ia0VKN3lEa0pMRFNtUVpUYzc0QW5SdW9rL1d6cDBUZk1lV3Vh?=
 =?utf-8?B?Z1F6OHhRK3dEYXhxc0V2QTFFMXlDKzR0STJiZWx3KzRUSGhlSVdFc3ppbkZm?=
 =?utf-8?B?bXhqMGdjZFhhVXN5YkJuUXVUVU55Q21rYktGWHpQOUJQL3lrVE41NXRoMWpB?=
 =?utf-8?B?MEMwQndxMng4a2xLRUNwYWJ2Nm5jUHZPQituVGp6MzFrWit4dXQrc1B2eWU0?=
 =?utf-8?B?bjZ6TGhBOGhWUFZ1NEhVYXpTOHp1RmxBTm5VQjQrOXVBazF4alllT0IwK3dC?=
 =?utf-8?B?QkZvOXAzUXpxVENOQ0xFV2NKcVlUN3pQTnJ1amhBeGh4ekdoL2s1cW1MdzNW?=
 =?utf-8?B?ak1DdVZSRFBiYTNIVjV0SzlZNFZPdHlmVEVveFovR2QzMFFFYWVnVHNDTzI4?=
 =?utf-8?B?aHF3VVRRV1Izb0RKOW4yV0d6bkYyWjMzMTJrUTM0MGUxYkdBb0taM2RPaWh2?=
 =?utf-8?B?bHFlVnI5bkQzZG1rT2oyZHN5SmowSmhWYWFWU2lXdzFsb1B0TlBBbnlvdzNQ?=
 =?utf-8?B?Nm5uUTR2YjVPMHRsNlJNczVncmd2N1FpS3dhQjdUUmhISjdPN1lxeE9YMzgx?=
 =?utf-8?B?R3RxQmllWTZmTDFpMkZZZVFkdXpGVENZdHVQQXI3cWRONjZBcmtBYVpBT3Y5?=
 =?utf-8?B?SWIrRmpoVVV3Q2cxL0x6VllpTEx3Ly9maGhucldGV2lkdklwOHlhNUIyeWdX?=
 =?utf-8?B?ZzE5T3BCTnlBZjVrUkMxMlkrM2o2SWNNRzhFUFVjam92bGZWdVFtNGM5TnNN?=
 =?utf-8?B?bWdkTmM0OXg0cEMydnJjSzJHU3RBRFZxak5IQ09wREJTUmRhUTFLWmFQbmhI?=
 =?utf-8?B?V1B4Y3pnazB4MExsWlg0S0hzQmpPeWhmbjJxU3h4KzB1Z1ZLb2toV1gwMW5R?=
 =?utf-8?B?ZnJ1ZCtlb2pNT3hhdnhWL05ZTm10NGRRMi9tTUZ4L2x0TDNYRTRWTC9qZWo1?=
 =?utf-8?B?elJFbE5mRXkxKzhjRU9oYjU4bC9JQnQvMnhudENaRXR4d2ZJQy9zMEpLRFM3?=
 =?utf-8?B?YmkyMnBjVWxRUzVmeXZRVEtYeDM4aFdUZjJoam5Ydkg0eUJlT2NVTCtMUWJJ?=
 =?utf-8?B?VFl6OEs2V3B5MVJ3bEhQcWZKcnZSVUdlUm51SklkdEpaMEhKbngrVUR5TmRw?=
 =?utf-8?B?MjBEVjF0WFlnMFZWSDJ5cHVmZE9aeERROW1OMENEOG9NdTRldXQ0MUNxSlgr?=
 =?utf-8?B?TWxiVURrdkQ4RFZBOTRZUmZESjN5dXJPb0lCRFNmbTQwOVBqUEFZNVFMTzZN?=
 =?utf-8?B?VGUxRWhoRGRudXZoZGFTZVphQXdKWUdEK1ZPUVFRZ2dNdXVoYW1ZUDF5NVUv?=
 =?utf-8?B?clZKK09TcEx5OFZHQmdicmpZS3pOeDVXZUlDU3FLU0JIQ1luMXU5NHlFaFpV?=
 =?utf-8?B?c2lIS1dGbFVVSUxDZ3dRSlZLRkhiYTJOVnl3ZDI0UzdmbHNwSFhnVzQybHBa?=
 =?utf-8?B?KzQxaDNMZG10d0FUQWtkRXluUTdnMjN1aUt1ejdvUW9jcXdHRldMT0lnMkVK?=
 =?utf-8?B?a1lxWnVkUDJwQVpyMjhUL0h6L2VJVDI2NkhEVEFVWW9FY0NoMWhPVjV4djQr?=
 =?utf-8?B?Ty9KT01RM2pPNnh3eVNHQWZlSTd3dkRQU1RueWkrRFlxeG9UTlBlblRBMEJJ?=
 =?utf-8?B?dmFHSWRrdGU5a1dnakRqdWttSkxwa3BGREN5VUFIdm5YVXNFemEvWmgvb3Rz?=
 =?utf-8?B?Slo0aWxHWDg4cU1XYXJBeEVpVVRSTjMyajFhNFlUTS9nN2VtSUtId09NcUVs?=
 =?utf-8?B?TVdvNXFVaDVlM2p6akFzTWQ5RXZrcmh5MFRXVTUycUZINkU2MVVlblFrSW8x?=
 =?utf-8?B?QU16dCtlN3ArZ0U2TUk4S25Nc3UrRzJOSEEvZ1UvYkdxSlZ0N3lSelR3aU5C?=
 =?utf-8?B?RDFhb01id256Yk50YlRwei9OMUd5ckNLL3FGV2JzSGU5UmNPcTBadE5KN0Iz?=
 =?utf-8?B?UkducVVGTkk2ckJmVkxtOUo0STd6NjhpTUFzSWk0OFRyd2R0djFrY2JFUVpj?=
 =?utf-8?B?bFg0RVhWMnpYM2x0eHV6WmFEZU1GWXRzOXpaZzUvTGlJMjhWRVhFSUlUNHdT?=
 =?utf-8?B?cnhyRmk4d3pYUXFzd3UvcDJjY1JMNjNxNm1xZzJsYWZOazg0RDZNV3VFY0xE?=
 =?utf-8?Q?vqalGIe0GIe4taeo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8319e9-d9f8-41e2-b248-08da32d15c10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:06:40.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDhtZOCng1HM7/goQNxk/a6eIqbZu2lLC5yYrakIc4qiVu/LLrsSwXMgayc+tOhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1593
X-Proofpoint-ORIG-GUID: xpMVdPMwLlPXKOoyijffg58y9pTN-HDl
X-Proofpoint-GUID: xpMVdPMwLlPXKOoyijffg58y9pTN-HDl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 3:29 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
>> But in kernel, some enum indeed has 64bit values, e.g.,
>> in uapi bpf.h, we have
>>    enum {
>>          BPF_F_INDEX_MASK                = 0xffffffffULL,
>>          BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>>          BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>>    };
>> In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
>> as 0, which certainly is incorrect.
>>
>> This patch added a new btf kind, BTF_KIND_ENUM64, which permits
>> 64bit value to cover the above use case. The BTF_KIND_ENUM64 has
>> the following three bytes followed by the common type:
> 
> you probably meant three fields, not bytes

correct.

> 
>>    struct bpf_enum64 {
>>      __u32 nume_off;
>>      __u32 hi32;
>>      __u32 lo32;
> 
> I'd like to nitpick on name here, as hi/lo of what? Maybe val_hi32 and
> val_lo32? Can we also reverse the order here? For x86 you'll be able
> to use &lo32 to get value directly if you really want, without a local
> copy. It also just logically seems better to have something low first,
> then high next.

I can go with val_hi32, val_lo32 and put val_lo32 before val_hi32.
I don't have any preference for the ordering of these two fields.

> 
> 
>>    };
>> Currently, btf type section has an alignment of 4 as all element types
>> are u32. Representing the value with __u64 will introduce a pad
>> for bpf_enum64 and may also introduce misalignment for the 64bit value.
>> Hence, two members of hi32 and lo32 are chosen to avoid these issues.
>>
>> The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
>> to indicate whether the value is signed or unsigned. The kflag intends
>> to provide consistent output of BTF C fortmat with the original
>> source code. For example, the original BTF_KIND_ENUM bit value is 0xffffffff.
>> The format C has two choices, print out 0xffffffff or -1 and current libbpf
>> prints out as unsigned value. But if the signedness is preserved in btf,
>> the value can be printed the same as the original source code.
>>
>> The new BTF_KIND_ENUM64 is intended to support the enum value represented as
>> 64bit value. But it can represent all BTF_KIND_ENUM values as well.
>> The value size of BTF_KIND_ENUM64 is encoded to 8 to represent its intent.
>> The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the value has
>> to be represented with 64 bits.
>>
>>    [1] https://reviews.llvm.org/D124641
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/btf.h            |  18 ++++-
>>   include/uapi/linux/btf.h       |  17 ++++-
>>   kernel/bpf/btf.c               | 132 ++++++++++++++++++++++++++++++---
>>   tools/include/uapi/linux/btf.h |  17 ++++-
>>   4 files changed, 168 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 2611cea2c2b6..280c33c9414a 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -174,7 +174,8 @@ static inline bool btf_type_is_small_int(const struct btf_type *t)
>>
>>   static inline bool btf_type_is_enum(const struct btf_type *t)
>>   {
>> -       return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM;
>> +       return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM ||
>> +              BTF_INFO_KIND(t->info) == BTF_KIND_ENUM64;
>>   }
> 
> a bit hesitant about this change, there is no helper to check for ENUM
> vs ENUM64. Inside the kernel this change seems to be correct as we
> don't care, but for libbpf I'd probably keep btf_is_enum() unchanged
> (you can't really work with them in the same generic way in
> user-space, as their memory layout is very different, so it's better
> not to generalize them unnecessarily)

Let me introduce a new helper called
btf_type_is_any_enum(...) to check both
BTF_KIND_ENUM or BTF_KIND_ENUM64.

> 
>>
>>   static inline bool str_is_empty(const char *s)
>> @@ -192,6 +193,16 @@ static inline bool btf_is_enum(const struct btf_type *t)
>>          return btf_kind(t) == BTF_KIND_ENUM;
>>   }
>>
>> +static inline bool btf_is_enum64(const struct btf_type *t)
>> +{
>> +       return btf_kind(t) == BTF_KIND_ENUM64;
>> +}
>> +
>> +static inline u64 btf_enum64_value(const struct btf_enum64 *e)
>> +{
>> +       return (u64)e->hi32 << 32 | e->lo32;
> 
> this might be correct but () around bit shift would make it more obvious

I can do this.

> 
>> +}
>> +
>>   static inline bool btf_is_composite(const struct btf_type *t)
>>   {
>>          u16 kind = btf_kind(t);
>> @@ -332,6 +343,11 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
>>          return (struct btf_enum *)(t + 1);
>>   }
>>
>> +static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
>> +{
>> +       return (struct btf_enum64 *)(t + 1);
>> +}
>> +
>>   static inline const struct btf_var_secinfo *btf_type_var_secinfo(
>>                  const struct btf_type *t)
>>   {
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index a9162a6c0284..2aac226a27b2 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -36,10 +36,10 @@ struct btf_type {
>>           * bits 24-28: kind (e.g. int, ptr, array...etc)
>>           * bits 29-30: unused
>>           * bit     31: kind_flag, currently used by
>> -        *             struct, union and fwd
>> +        *             struct, union, enum, fwd and enum64
> 
> see comment below on kflag for enum itself, but reading this I
> realized that we don't really describe the meaning of kind_flag for
> different kinds. Should it be done here?

We have detailed description in Documentation/bpf/btf.rst.
Hopefully it will be enough if people wants to understand
what kflag means for each kind.


> 
>>           */
>>          __u32 info;
>> -       /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
>> +       /* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
>>           * "size" tells the size of the type it is describing.
>>           *
>>           * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
>> @@ -63,7 +63,7 @@ enum {
>>          BTF_KIND_ARRAY          = 3,    /* Array        */
>>          BTF_KIND_STRUCT         = 4,    /* Struct       */
>>          BTF_KIND_UNION          = 5,    /* Union        */
>> -       BTF_KIND_ENUM           = 6,    /* Enumeration  */
>> +       BTF_KIND_ENUM           = 6,    /* Enumeration for int/unsigned int values */
> 
> nit: "Enumeration for up to 32-bit values" ?

This should work.

> 
>>          BTF_KIND_FWD            = 7,    /* Forward      */
>>          BTF_KIND_TYPEDEF        = 8,    /* Typedef      */
>>          BTF_KIND_VOLATILE       = 9,    /* Volatile     */
>> @@ -76,6 +76,7 @@ enum {
>>          BTF_KIND_FLOAT          = 16,   /* Floating point       */
>>          BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
>>          BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */
>> +       BTF_KIND_ENUM64         = 19,   /* Enumeration for long/unsigned long values */
> 
> and then "for 64-bit values" (or maybe up to 64 bit values, but in
> practice we won't do that, right?)

We can do "up to 64-bit values". In practice, from llvm and pahole,
we will only encode 64-bit values in ENUM64.

> 
>>
>>          NR_BTF_KINDS,
>>          BTF_KIND_MAX            = NR_BTF_KINDS - 1,
>> @@ -186,4 +187,14 @@ struct btf_decl_tag {
>>          __s32   component_idx;
>>   };
>>
> 
> [...]
> 
>> @@ -3716,7 +3721,8 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
>>
>>                  if (env->log.level == BPF_LOG_KERNEL)
>>                          continue;
>> -               btf_verifier_log(env, "\t%s val=%d\n",
>> +               fmt_str = btf_type_kflag(t) ? "\t%s val=%u\n" : "\t%s val=%d\n";
>> +               btf_verifier_log(env, fmt_str,
>>                                   __btf_name_by_offset(btf, enums[i].name_off),
>>                                   enums[i].val);
>>          }
>> @@ -3757,7 +3763,10 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
>>                  return;
>>          }
>>
>> -       btf_show_type_value(show, "%d", v);
>> +       if (btf_type_kflag(t))
> 
> libbpf's assumption right now and most common case is unsigned enum,
> so it seems more desirable to have kflag == 0 mean unsigned, with
> kflag == 1 being signed. It will make most existing enum definitions
> not change but also make it easy for libbpf's btf_dumper to use kflag
> if it's set, but otherwise have the same unsigned printing whether
> enum is really unsigned or Clang is too old to emit the kflag for
> enum. WDYT?

Right, libbpf assumption is unsigned enum and the kernel prints as 
signed. I agree that default unsigned should cover more cases.
Will change that in the next revision.

> 
>> +               btf_show_type_value(show, "%u", v);
>> +       else
>> +               btf_show_type_value(show, "%d", v);
> 
> you didn't got with ternary operator for fmt string selector like in
> previous case? I have mild preference for keeping it consistent (and
> keeping btf_type_kflag(t) ? "fmt1" : "fmt2" inline)

The reason I didn't do it is the line is a little long.
But I can do it.

> 
>>          btf_show_end_type(show);
>>   }
>>
>> @@ -3770,6 +3779,109 @@ static struct btf_kind_operations enum_ops = {
>>          .show = btf_enum_show,
>>   };
>>
>> +static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>> +                                const struct btf_type *t,
>> +                                u32 meta_left)
>> +{
>> +       const struct btf_enum64 *enums = btf_type_enum64(t);
>> +       struct btf *btf = env->btf;
>> +       const char *fmt_str;
>> +       u16 i, nr_enums;
>> +       u32 meta_needed;
>> +
>> +       nr_enums = btf_type_vlen(t);
>> +       meta_needed = nr_enums * sizeof(*enums);
>> +
>> +       if (meta_left < meta_needed) {
>> +               btf_verifier_log_basic(env, t,
>> +                                      "meta_left:%u meta_needed:%u",
>> +                                      meta_left, meta_needed);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (t->size != 8) {
> 
> technically there is nothing wrong with using enum64 for smaller
> sizes, right? Any particular reason to prevent this? We can just
> define that 64-bit value is sign-extended if enum is signed and has
> size < 8?

My original idea is to support 64-bit enum only for ENUM64 kind.
But it is certainly possible to encode 32-bit enums as well for
ENUM64. So I will remove this restriction.

The dwarf only generates sizes 4 (for up-to 32 bit values)
and 8 (for 64 bit values). But BTF_KIND_ENUM supports 1/2/4/8
sizes, so BTF_KIND_ENUM64 will also support 1/2/4/8 sizes.

> 
>> +               btf_verifier_log_type(env, t, "Unexpected size");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* enum type either no name or a valid one */
>> +       if (t->name_off &&
>> +           !btf_name_valid_identifier(env->btf, t->name_off)) {
>> +               btf_verifier_log_type(env, t, "Invalid name");
>> +               return -EINVAL;
>> +       }
>> +
> 
> [...]
