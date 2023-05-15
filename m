Return-Path: <bpf+bounces-569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98A703DC5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7544D28130B
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861719523;
	Mon, 15 May 2023 19:34:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113EFBF9
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:34:08 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292EA8
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 12:34:06 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34FC3R29004871;
	Mon, 15 May 2023 12:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=JWiqLc/4IMsW/dj1lqxrjKlvL53S/sGgH1IBmi2GCLc=;
 b=Gqh622XF4VmxyyJemrroXG4x2QcHuJkZeKzEsfsn+3NcYSChA2KilPFuPOzwySEZCrsI
 xUGCYZ0JpcJpp/vW/6zjTN1zNCvrq9//C1VqE0Mds63vQyVIUvw/NNTdEIViR2ATZAuh
 QkR+ETxYdPaeFJxcXdZdo7O9H3Oz2VesrPBh4PSnAR1giQHOjXNNNbav9i2ewIoWvyro
 AX4+aIMhMBTIvDnTHDDK6wxPXMkD/S5Tf0jvKbV1197T5RjCndXcNE35xmcD/w+TPPjF
 zwMIijOW2yGZw+L1TvTShXjJ8TB28ZDhquZ8vV9oDvo6/OzUPMCayCLyJPYFo0giZfgZ cw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qj62a6n83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 May 2023 12:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZFMjXeYVOfr6l1TFWE/pwQ8Ld9cbcTGT6mJVUGlnmr3YLn64xED9ShF/fqvj1fSrzn+StX8KrjwoSEW1DbvGHPl2bNcFZ6665ZlxzzxvFewrJ96gqDKFNvUDm/l73sN+icB9cDe0cUaEGultTAxEB6SJULx8l44k4NbFjsWdczC5kV0p4wvru5sQOL2jPaQ1crsYXUYcLNHSCE5Rjr1xwLwdVJ/LBtnD0Ey2xiVGV00SeDlJ61I0R0ZUDnI1tswlBB0wUaC8z5I/7b54VHfV/F8euFAMa6urE/uDBUMCMkvU8TH9LFfyto7Q6FAoInzNh+Ii4C/iLd9O+USjonsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWiqLc/4IMsW/dj1lqxrjKlvL53S/sGgH1IBmi2GCLc=;
 b=dmBZYw913MKfKBH2Db3E9qna/T5ngIh3zZAZvJGB/aJ/N/lGnF189J41iX10pCb1XgTrQZtEv3oFTuR9fxMoX5kx5eN/wN+PnsxFP8Jo2/v385DhOgnvUIBERm9YTVejcpUa3K5iUUs836jf/7gthtsHaL3pBIOb81wG+2PgFtKVstAK9saO2XBoyCjVS0s9LLxMeYB/GbfjiDnJdkxhPD05lzGZAfdyLJuI1qQzKS6mEjjYjJYeACX+s/6JljCAMNXtMSwlNS70hb2SjUYJUJOgLBoMOWPDCIuoGFcEEYuq3qbSlN0M61DYyg5QYx98qZLCdS4pAf1XQQuvs02K3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6065.namprd15.prod.outlook.com (2603:10b6:8:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Mon, 15 May
 2023 19:33:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 19:33:39 +0000
Message-ID: <9f1884a3-51b9-b6e6-843d-1e80724ee4e0@meta.com>
Date: Mon, 15 May 2023 12:33:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Lorenz Bauer <lmb@isovalent.com>,
        Timo Beckers <timo@incline.eu>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
 <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
 <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
 <ZF61j8WJls25BYTl@krava> <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
 <49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com> <ZGFXdAs2dzQiPHq8@krava>
 <76d62c3a-af8c-bd6d-abe7-8f8ead0a828d@meta.com>
 <deb2c59f-20a1-a849-6ad5-b4e09d6f6f85@oracle.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <deb2c59f-20a1-a849-6ad5-b4e09d6f6f85@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 21748052-475b-4df9-801f-08db557b486c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hyzM7OYS9qS0KniYrgAgg6hXOGeu69oLmQuAiBqzXAasuRu7GvFdeT+50LludUaoWhLH7GYUedq7qSXPZrfXhYU87SFEfrCws1WZHX2tehFuAWI++Wfo5gY35QWx/lSRmjxwPoX0VVUhIsXo5w5XaDSfFu4Sj36jl03/K9T6fYLjN0vxmakB2qI9+FMxSrX7Tj+0zL+ndHTdIjRM+gOfMAwMrh6KiKgUNRTOy6USmWeR++Ufj26YSvjqvD5Napqwn7udd5LcBzk/SjFeu60fWbSZ+0hU5zNpIF+oK1OaSrxRmr4St/qFwiDTMhP54ZPSJWUm57z2/Si+77AW8SXMOZ0vgIMffj3EooEsQBbIoDbmjSbQ7oUDd81jKd/U9Be/MFpqGV/onxV2IDyMDTuXaNOuV14AO4HRgEVyjIrVdLIVFGJTjtkkOcQdIhZulBRltoL6dJLdGilQ2KKBTpvf0eDKL5GHIjyBg1yXT5gRdMX/clB1YJM2j/yfsN8HbSBIQsFjXxO2c5RsrL4+sfvKZhSLgbpd3njUxCkFnmB6u0AHS+CP8VLNicVtvbb0y4GlB5TYKBdEDkFghUknsajbFwrcn8Tv7Dy6Vcp5LANq0T6K+u37HiJWiB/TFnERYG+p29Ue5DQy7VGbHrRPBYKVrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(31696002)(6666004)(38100700002)(6486002)(966005)(31686004)(186003)(86362001)(83380400001)(66899021)(2616005)(7416002)(8936002)(54906003)(2906002)(4326008)(5660300002)(36756003)(30864003)(8676002)(316002)(6506007)(53546011)(6512007)(66556008)(41300700001)(66946007)(66476007)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnVOeVZwdUxFWnQrMlFBK2MvVkdPVHFJSStBeFFML0ZoRFZ1clJvWUF2RUZy?=
 =?utf-8?B?ekk0a01KMmVHMGkzVUJwbEUxT3JmVmNZT0V6SDAvc1FBdjVrYzl6b28zV285?=
 =?utf-8?B?dHdFU3pMamFWK0grdlNPTmFlSEZvaURIR1hneHZVYXRpR21xcUZvZlljZ3M0?=
 =?utf-8?B?TUdMTEh3aE8ydSs1SmtPQUE1K3J0QmJ2WFZnczExc2RSemZQQzRXUjRWU0dE?=
 =?utf-8?B?c05JL0FPY2RmWnhrWHdIdFhjNXNsa0pocC80YkhVc2RqYTNTdVJ6WWtzSkw1?=
 =?utf-8?B?R1NMTkpUV2VreEc5ZFhZc2dYUitkRk5yM1FzcHJuS2xReGMwK2dyNXZxZDAy?=
 =?utf-8?B?RjNyYlZoWWJDTGVYWXZHRk95Rnd3L3NobEV1bkg0ZHh3MjlyZWJZY0Q3em8v?=
 =?utf-8?B?a1N3b1JRbFBMOWxIc2NuR0VHcG9vZ3VsamtkTHhBT0svWjBNeENkUlZ4b0lO?=
 =?utf-8?B?WXB4dllQdXFOUHNmakFrVW9OYVBhZUxUOEJRSldOS1hrdEgrZTZ3REtyUjZa?=
 =?utf-8?B?NmtFWUJLdktTcFZ6Tkh3WTJRYkJDaWtpNjY2dGkyeVN6VmcyQzZ1dVJnTVd1?=
 =?utf-8?B?Qk9rczdCREJ4N3g1M2k4R0ttSSt2ckpoMElKY2VsSDZocjFBR2h5VnpRQ0Rl?=
 =?utf-8?B?RCs2YjFpd0FuTWRGck1CSElHTXVJL1VvTkFYQjMvZGxtNVVkcE5HZzAxWlZB?=
 =?utf-8?B?dStrdlJKamFyMW82MlV3MWx6Ry92ZEVEUXdtdE1JZ1hCL1N0Z2p3ckJVLzdF?=
 =?utf-8?B?MnIrSnd4RVlKaGVGaFNlR29nZUlBbStXbHBkenNxRHUxU3g0RndtY1pKMlNK?=
 =?utf-8?B?SFdMUklyc1F1TkYxSGo0bHp5dllRWmkyU1Qxb256ZTVqQlliYU5SZGVMV0Ru?=
 =?utf-8?B?aCt3UUxwdit3UFhzeUtBTElWMzQ5Q0s4Ulc5WDd5ZExoWkYwd2x0amhGUkQ4?=
 =?utf-8?B?UmhSZXIrR2FJazMvZysrZFdhWTc3RmJWeDkrMC8xUm00UEsyMGxiSG8zaGp4?=
 =?utf-8?B?ZEVnRjFQR1JEb2xhamJ3cktVSlBqKzA4aG9nakpWeVVTcStGQ0RlTHhwUDZn?=
 =?utf-8?B?OW1rb2dLMWovcWZTUmgvZWwxZFl3aTRidVZIeTFSRENjL2srK2xEZ0Q2MDJU?=
 =?utf-8?B?Mk9RM2p4dE00T2gyNEdFOExNUnhPQkd6dzY0SzNZU2RXNlR6SVZCZXk5S0JK?=
 =?utf-8?B?UTVLVXE5d0hSK1F2L1FzMGtWUnBZQ2s2RkRHT09tOFlNbGtyUFE5dEVyVnpI?=
 =?utf-8?B?RCt1c3NSS09oYVlKdUpaejJ5bE9aYVUrclNoeERacGFQaDdQdGZlK2I1R2xZ?=
 =?utf-8?B?R3hZZnlRSXNvdFVhclVTWGdTNXlmamRXUk02UDEzcWFCMmVCVll0U0I5d0t3?=
 =?utf-8?B?QTU5b3pVZ2dpN3hSdzl1OFVOcVB6TWIvWmZMMnlDdml3RU5ndzIxSXpObU5p?=
 =?utf-8?B?alQ4dkNjek00S2JLamVjNG1MUnMxTC95Njl1cWNFcUtpZ050QThNTDN2TGty?=
 =?utf-8?B?V3IyWEl6a0RVYmcxQzhHYzhkN2ZTWXkzOUxvU05kWHBEaUg4eWxzaHhMUXZQ?=
 =?utf-8?B?dDFCcU55eG5mb2FlckpBamd1UVo4U0VNU0hscGMyREJiT0tOcXF3QnJvQWth?=
 =?utf-8?B?ZEZVTlNYLzNZRzNBdHpSSDNDNFA4K2M0M0xlbEE2NGRGc0l2TkFFQnp4ajlB?=
 =?utf-8?B?VnhLclRFOFg3VDFHZUlwRk9NQTJibm1abmkyZjZHYkJMUUExTDhoYlllL2l6?=
 =?utf-8?B?ZEJzdWlUazZHYkVHL1pZUVFQZWZnWjE5WHZWbEE4bmxjUzhINHk4MXZtdC8x?=
 =?utf-8?B?bVRIVGJwdm1nenhHUGdVNDNMc041VW9zOENsRlRhYVJBbnJYbFM0UE5sOGI2?=
 =?utf-8?B?L05pMEVIRDZvcDUwellFODRZNzBMTm1ZV3BCaWhSOGs4SjRNZW1xUnNCM05Z?=
 =?utf-8?B?cU5vTCsrekpsRm4rY1Z4ZXEzUVE3VkI2WkZ4Nk9TdHhVWkJpblIxWHAzSTFs?=
 =?utf-8?B?MEJnR08yUy9KNm0rWThHaDA0bzcyUFdXY3U2RXVIRE4remVucVdJeDFDRHFa?=
 =?utf-8?B?ODRmcFZVTHBhL01oSXNRTHBKQ3YxOWJ6cjhBSkFXckdaUWlYNG85TDJWdE1B?=
 =?utf-8?B?WVY3SjVuT01IS09qZDhGcGZYWkVIL3BUY1RYNG5pR1F3eFRvamlpb0YyeUoz?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21748052-475b-4df9-801f-08db557b486c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 19:33:38.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fW1oQUCzaY5Sq5QXIHHP5QFGe8BTh2cicmScHQuZMCejwptXh0RuHl9EXZW7gP/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6065
X-Proofpoint-GUID: cQHOnMEdAG0qLOrd9D2lRHVMvFOhBzTb
X-Proofpoint-ORIG-GUID: cQHOnMEdAG0qLOrd9D2lRHVMvFOhBzTb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_17,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/15/23 7:53 AM, Alan Maguire wrote:
> On 15/05/2023 05:06, Yonghong Song wrote:
>>
>>
>> On 5/14/23 2:49 PM, Jiri Olsa wrote:
>>> On Sun, May 14, 2023 at 10:37:08AM -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 5/12/23 7:59 PM, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 5/12/23 2:54 PM, Jiri Olsa wrote:
>>>>>> On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
>>>>>>> On Fri, May 12, 2023 at 9:04 AM Alan Maguire
>>>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>>>
>>>>>>>> On 12/05/2023 03:51, Yafang Shao wrote:
>>>>>>>>> On Wed, May 10, 2023 at 9:03 PM Alan Maguire
>>>>>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>>>>>
>>>>>>>>>> v1.25 of pahole supports filtering out functions
>>>>>>>>>> with multiple inconsistent
>>>>>>>>>> function prototypes or optimized-out parameters from
>>>>>>>>>> the BTF representation.
>>>>>>>>>> These present problems because there is no
>>>>>>>>>> additional info in BTF saying which
>>>>>>>>>> inconsistent prototype matches which function
>>>>>>>>>> instance to help guide attachment,
>>>>>>>>>> and functions with optimized-out parameters can lead
>>>>>>>>>> to incorrect assumptions
>>>>>>>>>> about register contents.
>>>>>>>>>>
>>>>>>>>>> So for now, filter out such functions while adding
>>>>>>>>>> BTF representations for
>>>>>>>>>> functions that have "."-suffixes (foo.isra.0) but
>>>>>>>>>> not optimized-out parameters.
>>>>>>>>>> This patch assumes that below linked changes land in
>>>>>>>>>> pahole for v1.25.
>>>>>>>>>>
>>>>>>>>>> Issues with pahole filtering being too aggressive in
>>>>>>>>>> removing functions
>>>>>>>>>> appear to be resolved now, but CI and further testing will
>>>>>>>>>> confirm.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>>     scripts/pahole-flags.sh | 3 +++
>>>>>>>>>>     1 file changed, 3 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>>>>>>> index 1f1f1d397c39..728d55190d97 100755
>>>>>>>>>> --- a/scripts/pahole-flags.sh
>>>>>>>>>> +++ b/scripts/pahole-flags.sh
>>>>>>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>>>>>>            # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>>>>>>            extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>>>>>>     fi
>>>>>>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>>>>>>> +       extra_paholeopt="${extra_paholeopt}
>>>>>>>>>> --skip_encoding_btf_inconsistent_proto
>>>>>>>>>> --btf_gen_optimized"
>>>>>>>>>> +fi
>>>>>>>>>>
>>>>>>>>>>     echo ${extra_paholeopt}
>>>>>>>>>> -- 
>>>>>>>>>> 2.31.1
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> That change looks like a workaround to me.
>>>>>>>>> There may be multiple functions that have the same proto, e.g.:
>>>>>>>>>
>>>>>>>>>      $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
>>>>>>>>> kernel/bpf/ net/core/
>>>>>>>>>      kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
>>>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>>>      net/core/bpf_sk_storage.c:static void
>>>>>>>>> bpf_iter_detach_map(struct
>>>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>>>
>>>>>>>>>      $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
>>>>>>>>> bpf_iter_detach_map
>>>>>>>>>      [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>>>>>>>>>      'aux' type_id=2638
>>>>>>>>>      [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
>>>>>>>>>
>>>>>>>>> We don't know which one it is in the BTF.
>>>>>>>>> However, I'm not against this change, as it can avoid some issues.
>>>>>>>>>
>>>>>>>>
>>>>>>>> In the above case, the BTF representation is consistent though.
>>>>>>>> That is, if I attach fentry progs to either of these functions
>>>>>>>> based on that BTF representation, nothing will crash.
>>>>>>>>
>>>>>>>> That's ultimately what those changes are about; ensuring
>>>>>>>> consistency in BTF representation, so when a function is in
>>>>>>>> BTF we can know the signature of the function can be safely
>>>>>>>> used by fentry for example.
>>>>>>>>
>>>>>>>> The question of being able to identify functions (as opposed
>>>>>>>> to having a consistent representation) is the next step.
>>>>>>>> Finding a way to link between kallsyms and BTF would allow us to
>>>>>>>> have multiple inconsistent functions in BTF, since we could map
>>>>>>>> from BTF -> kallsyms safely. So two functions called "foo"
>>>>>>>> with different function signatures would be okay, because
>>>>>>>> we'd know which was which in kallsyms and could attach
>>>>>>>> safely. Something like a BTF tag for the function that could
>>>>>>>> clarify that mapping - but just for cases where it would
>>>>>>>> otherwise be ambiguous - is probably the way forward
>>>>>>>> longer term.
>>>>>>>>
>>>>>>>> Jiri's talking about this topic at LSF/MM/BPF this week I believe.
>>>>>>>
>>>>>>> Jiri presented a few ideas during LSFMMBPF.
>>>>>>>
>>>>>>> I feel the best approach is to add a set of addr-s to BTF
>>>>>>> via a special decl_tag.
>>>>>>> We can also consider extending KIND_FUNC.
>>>>>>> The advantage that every BTF func will have one or more addrs
>>>>>>> associated with it and bpf prog loading logic wouldn't need to do
>>>>>>> fragile name comparison between btf and kallsyms.
>>>>>>> pahole can take addrs from dwarf and optionally double check
>>>>>>> with kallsyms.
>>>>>>
>>>>>> Yonghong summed it up in another email discussion, pasting it in here:
>>>>>>
>>>>>>      So overall we have three options as kallsyms representation now:
>>>>>>        (a) "addr module:foo:dir_a/dir_b/core.c"
>>>>>>        (b) "addr module:foo"
>>>>>>        (c) "addr module:foo:btf_id"
>>>>>>
>>>>>>      option (a):
>>>>>>        'dir_a/dir_b/core.c' needs to be encoded in BTF.
>>>>>>        user space either check file path or func signature
>>>>>>        to find attach_btf_id and pass to the kernel.
>>>>>>        kernel can find file path in BTF and then lookup
>>>>>>        kallsyms to find addr.
>>>>>>
> 
> I like the source-centric nature of this, but the only
> danger here is we might not get a 1:1 mapping between
> source file location and address; consider the case
> of a static inline function in a .h file which doesn't
> get inlined. It could have multiple addresses associated
> with the same source. For example:
> 
> static inline void __list_del_entry(struct list_head *entry)
> {
> 	if (!__list_del_entry_valid(entry))
> 		return;
> 
> 	__list_del(entry->prev, entry->next);
> }
> 
> $ grep __list_del_entry /proc/kallsyms
> ffffffff982cc5c0 t __pfx___list_del_entry
> ffffffff982cc5d0 t __list_del_entry
> ffffffff985b0860 t __pfx___list_del_entry
> ffffffff985b0870 t __list_del_entry
> ffffffff9862d800 t __pfx___list_del_entry
> ffffffff9862d810 t __list_del_entry
> ffffffff987d3dd0 t __pfx___list_del_entry
> ffffffff987d3de0 t __list_del_entry
> ffffffff987f37a0 T __pfx___list_del_entry_valid
> ffffffff987f37b0 T __list_del_entry_valid
> ffffffff989fdd10 t __pfx___list_del_entry
> ffffffff989fdd20 t __list_del_entry
> ffffffff99baf08c r __ksymtab___list_del_entry_valid
> ffffffffc12da2e0 t __list_del_entry	[bnep]
> ffffffffc12da2d0 t __pfx___list_del_entry	[bnep]
> ffffffffc092d6b0 t __list_del_entry	[videobuf2_common]
> ffffffffc092d6a0 t __pfx___list_del_entry	[videobuf2_common]

Until now, we are okay with static inline function carried
into .o file since all inline functions are marked as notrace
(fentry cannot attach to it.)

However, now we have
https://lore.kernel.org/live-patching/20230502164102.1a51cdb4@gandalf.local.home/T/#u

If the patch is merged, then the above inline function
in the header survived in .o file indeed a problem.

Typically users won't trace inline functions in
the header file. But for completeness, agree that
file path may not fully reliable.

> 
>>>>>>      option (b):
>>>>>>        "addr" needs to be encoded in BTF.
>>>>>>        user space checks func signature to find
>>>>>>        attach_btf_id and pass to the kernel.
>>>>>>        kernel can find addr in BTF and use it.
>>>>>>
> 
> This seems like the safest option to me. Ideally we wouldn't
> need such information for every function - only ones with
> multiple sites and ambiguous signatures - but the problem
> is a function could have the same name in a kernel and
> a module too. So it seems like we're stuck with providing
> additional info to clarify which signature goes with which
> function for each static function.

When passing attach_btf_id to kernel, we have attach_btf_obj_fd
as well, which should differentiate whether it is kernel or which module 
it is.

> 
>>>>>>      option (c):
>>>>>>        if user can decide which function to attach, e.g.,
>>>>>>        through func signature, then no BTF encoding
>>>>>>        is necessary. attach_btf_id is passed to the
>>>>>>        kernel and search kallsyms to find the matching
>>>>>>        btf_id and 'addr' will be available then.
>>>>>>
>>>>>>      For option (b) and (c), user space needs to check
>>>>>>      func signature to find which btf_id to use. If
>>>>>>      same-name static functions having the identical
>>>>>>      signatures, then user space would have a hard time
>>>>>>      to differentiate. I think it should be very
>>>>>>      rare same-name static functions in the kernel will have
>>>>>>      identical signatures. But if we want 100% correctness,
>>>>>>      we may need file path in which case option (a)
>>>>>>      is preferable.
>>>>>
>>>>> As Alexei mentioned in previous email, for such a extreme case,
>>>>> if user is willing to go through extra step to check dwarf
>>>>> to find and match file path, then (b) and (c) should work
>>>>> perfectly as well.
>>>>
>>>> Okay, it looks like this is more complex if the function signature is
>>>> the same. In such cases, current BTF dedup will merge these
>>>> functions as a single BTF func. In such cases, we could have:
>>>>
>>>>      decl_tag_1   ----> dedup'ed static_func
>>>>                            ^
>>>>                            |
>>>>      decl_tag_2   ---------
>>>>
>>>> For such cases, just passing btf_id of static func to kernel
>>>> won't work since the kernel won't be able to know which
>>>> decl_tag to be associated with.
>>>>
>>>> (I did a simple test with vmlinux, it looks we have
>>>>    issues with decl_tag_1/decl_tag_2 -> dedup'ed static_func
>>>>    as well since only one of decl_tag survives.
>>>>    But this is a different issue.
>>>> )
>>>>
>>>> So if we intend to add decl tag (addr or file_path), we
>>>> should not dedup static functions or generally any functions.
>>>
>>> I did not think functions would be dedup-ed, they are ;-) with the
>>> declaration tags in place we could perhaps switch it off, right?
>>
>> That is my hope too. If with decl tag func won't be dedup'ed,
>> then we should be okay. In the kernel, based on attach_btf_id,
>> through btf, kernel can find the corresponding decl tag (file path
>> or addr) or through attach_btf_id itself if the btf id is
>> encoded in kallsym entries.
>>
>>>
>>> or perhaps I can't think of all the cases we need functions dedup for,
>>> so maybe the dedup code could check also the associated decl tag when
>>> comparing functions
>>>
> 
> Would using the BTF decl tag id instead of the function BTF id to
> guide attachment be an option? That way if multiple functions shared
> the same signature, we could still get the info to figure out which to
> attach to from the decl tag, and we wouldn't need to mess with dedup.
> I'm probably missing something which makes that unworkable, but just a
> thought. Thanks!

The issue is due to current bpf syscall UAPI. it passed attach_btf_id
and attach_btf_obj_fd to the kernel. If we change UAPI to pass
decl_tag_id instead of attach_btf_id to the kernel, we should be
okay, but this requires a bpf syscall UAPI change. Maybe this works too.

> 
> Alan

