Return-Path: <bpf+bounces-495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873407022AC
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 06:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843E01C209B3
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 04:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838CC1FB9;
	Mon, 15 May 2023 04:07:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14D1C26
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 04:07:23 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0225E73
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 21:07:20 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EKsGXJ000369;
	Sun, 14 May 2023 21:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2zdqLNW5U0ceb3L5lSYNhX5BBcxQkxRNJlqIjeKuNQY=;
 b=KcBEEmTCNHuz8TF6/iqlzvKXbpmeFkPSviYvVjwek7j5dSF3aHngjqvi9+BSzWsdgN9C
 BPUW+JrR/48dyEoigh45jA9YJuRWvKQPU4zZ/JTbZ5WeNcbYuTpeUq2mua0JlLJlk6AF
 yqkPFaNYqeUStQwvU5tuMfotK5YJ71CpdWb+ix9kMWhdTSUfKt87UD3IrB7pbGr+PuhY
 3IMx7Tqr5BoDddIIqc+gw1AP+lujCHemhWheyptAYocDMSZ0xH2bmU+p88dMXmG6VgoA
 VT2btQm6fpwZf7s+VzL2XO1mWRDMpQskjcax6TBC62PieSWxgkOH/e5HQojOZi0EMTjh nQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj5vr1chn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 May 2023 21:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX4MCg3fx2EHV+gDbYkAycg5QHBpFzie5+uVxu7kLWvTq9Mle5yoTIj66PFMnPLA82n/g6ILRLVzEdHCQEmof980Au5YC2+jjH0rOGHzYXNU/oomN/pyT0vUTs57xNeo8VoPhWDsWRPg2mHchkqa4xpfvx4TwszgELLFuDMuefZ2mzHaXjV6IgirjiuIqrl8/jYTJt+jp39z1vWMLrAYJJGcvQ3Qbn6mTKU3DfuqUAD1HA3UhylMz6x50FHxwgRtCDBzR533U8V9D/PQm6QCiE46VnwXzvi86AdZssCIwWqGyW1kcBfdFCUfmIpl9xPO9E1awSqgiTuFFsGJ9i+44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zdqLNW5U0ceb3L5lSYNhX5BBcxQkxRNJlqIjeKuNQY=;
 b=fjWFpVtjXITfLSjffqbL3yTwUeGSJe974Ph/XCQX3ieLQNJP0aCy8U1LdwSbqyafct0TMGVcfHS8F1zrdm8e0uyNTDgmfNL1i4Iimocf7bJTrr+Bv/xw/Fqlmz0TmVm1ozRjZ23QSOtLRs/iMIeK4grACOCz8FZqp8X+Usw5umW+y/1dU23rkYmydpQVjCx0LHls5GWToc+SZUbiDGXyskwRSLkaYFwuiYbr79aB8I/QbyvUjHbTg1sVSAu7SGIbw1offU2WiFkk5qOibscT1Kuyq5V3va3EBKPtqnB55xm5ghLxfC+h7oZm3bajkyk/9uBBAzR71NmrbY1p7jM2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 04:06:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 04:06:55 +0000
Message-ID: <76d62c3a-af8c-bd6d-abe7-8f8ead0a828d@meta.com>
Date: Sun, 14 May 2023 21:06:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
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
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ZGFXdAs2dzQiPHq8@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: ca661c04-6fda-4b19-c4ea-08db54f9d1f8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RdVJsspHdNdGUYel+/cGUhWk+/yixTWcOmDG3WxwYlJQhJdmD54162CaieSRKi5VXsoFYSYP7iew7fhwLhBF6+Yfy+CE44ISJCzOS+/gmuXYz1Dhscqoumnzd1AQVJpv9Daluq6m+Zr24kJfeN+YsyuH9xDpRD0t2W/pDwavcID2tE53h2sRJfwHRf7T1OTGgfRFScXK6kaldDuS67hGUxWHd9fDoRr2Bu4r9UZjWP/YD0DetZPlNQnqHdZMAB8M6tJbeWneYbac6AgjhRIq2U7ZgwThHGFZrFmXsNIvtBIPZB5LTwZQBR+zYONDkL64aD6N/Frvw8LAWXPdD0/Lk3i+wrnUzQpdMSdvt0OTFjVyiuortfdu4j+cPCntm1YJ3D9t0KBU56yGJ75Zd/ugLcHhMQNWJj97WRfvY141AySoBsQoA7uJcdk36AY3MJjIClX8a1MfVxAx7RxWKcsZmD/JFVzbloy+bt+ML2PcWgHNgmRgZp8WUdqXbCMDuBGmJ38cUS8oHsGLruTjRwGPzfyIYCXMGeA2clnmGhEtEFGUfKIW28rXgDJVLvFHagjAONHoAa1/Y4MXxA05dmxmIzRTTyrvT6XsprR+yILqYGqbHEh7+3AjiadeRsHNbc7HN4zO7ZupXev1TYKnlYWxfg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(36756003)(86362001)(54906003)(316002)(66556008)(6916009)(66946007)(66476007)(4326008)(6486002)(478600001)(8936002)(8676002)(5660300002)(41300700001)(6666004)(2906002)(7416002)(31696002)(38100700002)(2616005)(186003)(53546011)(6506007)(6512007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REZmVW15TStyZ0RrN3I0cUYyMGEvT0JqNFh2dGxtdXcvWDgxa0lpTnhkVzJo?=
 =?utf-8?B?VnoyeWY1YVBHZ2lJd0tzNkFKckxDQ3JhSUR5ZXpKLzBKRnV3RGJvVzgrU1J5?=
 =?utf-8?B?ejN6d3hPNDNoV2RXcXpPSldjdGZ5OEpTNStmL1p4TDAyZFpaaWZLL2Fjb28x?=
 =?utf-8?B?MlZXQnpVZFdpRVNJNFYvWVM4NHlHZktQTGJ3UTM4RWxhTzZRRENTdmFSbU0y?=
 =?utf-8?B?anNoVHFDUVRHellhRG1nZ3Q1dDNVUU5sekl1VnVkMFRPTUdhNWNrc2FWd21w?=
 =?utf-8?B?SCtOdndxM3FzdC90Z1p6aEpqQXh4S3pRcEcyblJqYXVGaDJjNVc3MGUzb2tw?=
 =?utf-8?B?UVFrc08wVzFZSXBmenFmNm1qbE1BTmFDRUY2VGNybXpsN2JlelE4WjM2YVpv?=
 =?utf-8?B?ZzRmU3l2SEprdkNVRTFsZlp0T2xjaVFLbG5iTndFME9GZE5tWVIyZzVxKzg4?=
 =?utf-8?B?OVhNVjcwdlcwbnJFVGFtLy85SUVORDRJUmZqOXdEcEFUTnZyU3JwNXl6Z2VI?=
 =?utf-8?B?aFlQQ3FhWWUyZVkzR0JOeU41anphcGRIa0p6YmsxOUhxV09SdmdDSTluZjlK?=
 =?utf-8?B?N1c2STEvczVFTUZ2d2d2dmQyRWc2bkh1QWxLNkZ0MkNjZktuR3hSZTFDenJJ?=
 =?utf-8?B?OTdLdHFlZzhpMUwzYUJ4YTJjTHI0dWlBeE82M1FxUE83Ty96Q2xhWllVajNL?=
 =?utf-8?B?M3VZay9QMXppbHN5aFNTcFAzVEpIclY3SXV0aGMyUnE2dDJMQlpuZCtLY2Zy?=
 =?utf-8?B?enFDbFlJNUNrUCsxOWxFOHZ1aE9tOFBaUGRYaEFJbnJodHFCOGxvVnlUTUV1?=
 =?utf-8?B?SW9XOUtwSlZXdGxTZU4yTFNOUCtEK2F2S3IrZ1FObUF0WDVVZGtpazRXRFBH?=
 =?utf-8?B?SmJlQjg2VnlMbDVIb0hxeHgyQkNIaHdmelN3YUNUS1YrMzdHZ2ZJQXRMN1dP?=
 =?utf-8?B?YmQrWFJ1ZlRuaCs3UVFleXdBaDNLaXJhcGR1MktVdE9SaW5tUXcwSlVXQ2FH?=
 =?utf-8?B?QUZTNzk0N1dMS3VSeHBQeUpPWHJLT0dzU09XYVZ1MGNVdzc0aklQTDZnR3A5?=
 =?utf-8?B?RTdiNHVvTmhRbjZGZWV5UjZNdEZ0VUtBTG85RVNLZWd1b3JHaDZqdWpTNXM3?=
 =?utf-8?B?M1JMSktxcGFCK2NzQkxWbmduWmZtV0w0YU80R1VVVS9IRkFFejd1SnpDTzhh?=
 =?utf-8?B?dHFpRkVMWU5JamRwQ2dNcWtCK0htaGVMZVlhUlFNRXdOSnkwYmM4Q1Vndmxz?=
 =?utf-8?B?ck95U21sWEk0dmdWYTdHZGNNY1NLY2duRFhzNkhmWExDdm1Nc1dNbXloV2Mz?=
 =?utf-8?B?M3lleVlURFQvTVZxZkR0UytFZFI0eFlRKzZjRXNhbU5aSlAyc09CSS84alVD?=
 =?utf-8?B?dGd6cGNNcDBhRlBMQWRqdElDQVFTdXFKcjBrMG5ZMnNaeTFEQ2djS3I4Vm9H?=
 =?utf-8?B?OWpvaFlWNEtyeXF4YVc5NzBYcHB1L1l5QUxXV2R3bkhzSmE4bEk2Z2JZQjZM?=
 =?utf-8?B?RU1pc0hEMjZVVStVczI4QjlXaWNoM1J0WkZSbytKN3NGNXN5TFR0a0JQa2tR?=
 =?utf-8?B?Y3p4MUNPQU5nbGtTK24ySG1EREU5c3l4dFZKNklPME9hZVNjMmtIeVRRNzc0?=
 =?utf-8?B?OVJ5MjdtMnFnZzJJK2xudms0Q25UVWFTMVBNN3RmSDh3RFdjWWRLZlVZajhY?=
 =?utf-8?B?VC9BdVliL0dLZG1mYk0rVE1JZzZ1QUFKTXFlUG9PQWtPZzhSNlJXU3hYRWU4?=
 =?utf-8?B?YXVFRm5HNE15NzJra2hhTFZwUVhtVE5UOHJaVFVkQVl3N2llWmkrbjdMMGFD?=
 =?utf-8?B?NEpQdzRQZXpIV3FBMnJtamJ2ODhQWXQwNHY2VEtCY2RqTitseDVoRmcrTTZ1?=
 =?utf-8?B?dHM1Y3dUSVBCNGVSNldZYjFVaVB0b1RpOUUrS2dua1d4Yit4d3lic0crR0I3?=
 =?utf-8?B?eXVDcVkyUjlTc1ZyTVBSek56ckp6Qlg1b3Vld1g1L3JKSTZMT2hpZ3FuZDFJ?=
 =?utf-8?B?Qk1LaGxqYTBYalhIZUZ6clJHU05vcHcyMjBuWVZHaWQyaVVDQ05Fck5aMmVZ?=
 =?utf-8?B?Y1c1aUhOMHlRVzZwZ2dOKzlMMGNOdzFGNk1mYTlCWFhKOUZ2RHZIT3dTVkZj?=
 =?utf-8?B?UXgvU0JNQ2k4emp0aE1HckdTcWoxay9wbWxLeTFRdTc5eENuaEVBbzhNQytK?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca661c04-6fda-4b19-c4ea-08db54f9d1f8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 04:06:55.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd1Ljyn32ibtWLKIrcNDd7L015JYLPTL44qyVJZvg01OVHoobvu52I+qu+QRH1Xg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-Proofpoint-ORIG-GUID: 3EZxEvpahcixbHlimbCtiSTTDIIlONwz
X-Proofpoint-GUID: 3EZxEvpahcixbHlimbCtiSTTDIIlONwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_02,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/14/23 2:49 PM, Jiri Olsa wrote:
> On Sun, May 14, 2023 at 10:37:08AM -0700, Yonghong Song wrote:
>>
>>
>> On 5/12/23 7:59 PM, Yonghong Song wrote:
>>>
>>>
>>> On 5/12/23 2:54 PM, Jiri Olsa wrote:
>>>> On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
>>>>> On Fri, May 12, 2023 at 9:04 AM Alan Maguire
>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> On 12/05/2023 03:51, Yafang Shao wrote:
>>>>>>> On Wed, May 10, 2023 at 9:03 PM Alan Maguire
>>>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>>>
>>>>>>>> v1.25 of pahole supports filtering out functions
>>>>>>>> with multiple inconsistent
>>>>>>>> function prototypes or optimized-out parameters from
>>>>>>>> the BTF representation.
>>>>>>>> These present problems because there is no
>>>>>>>> additional info in BTF saying which
>>>>>>>> inconsistent prototype matches which function
>>>>>>>> instance to help guide attachment,
>>>>>>>> and functions with optimized-out parameters can lead
>>>>>>>> to incorrect assumptions
>>>>>>>> about register contents.
>>>>>>>>
>>>>>>>> So for now, filter out such functions while adding
>>>>>>>> BTF representations for
>>>>>>>> functions that have "."-suffixes (foo.isra.0) but
>>>>>>>> not optimized-out parameters.
>>>>>>>> This patch assumes that below linked changes land in
>>>>>>>> pahole for v1.25.
>>>>>>>>
>>>>>>>> Issues with pahole filtering being too aggressive in
>>>>>>>> removing functions
>>>>>>>> appear to be resolved now, but CI and further testing will confirm.
>>>>>>>>
>>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>> ---
>>>>>>>>    scripts/pahole-flags.sh | 3 +++
>>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>>>>> index 1f1f1d397c39..728d55190d97 100755
>>>>>>>> --- a/scripts/pahole-flags.sh
>>>>>>>> +++ b/scripts/pahole-flags.sh
>>>>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>>>>           # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>>>>           extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>>>>    fi
>>>>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>>>>> +       extra_paholeopt="${extra_paholeopt}
>>>>>>>> --skip_encoding_btf_inconsistent_proto
>>>>>>>> --btf_gen_optimized"
>>>>>>>> +fi
>>>>>>>>
>>>>>>>>    echo ${extra_paholeopt}
>>>>>>>> -- 
>>>>>>>> 2.31.1
>>>>>>>>
>>>>>>>
>>>>>>> That change looks like a workaround to me.
>>>>>>> There may be multiple functions that have the same proto, e.g.:
>>>>>>>
>>>>>>>     $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
>>>>>>> kernel/bpf/ net/core/
>>>>>>>     kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>     net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
>>>>>>> bpf_iter_aux_info *aux)
>>>>>>>
>>>>>>>     $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
>>>>>>> bpf_iter_detach_map
>>>>>>>     [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>>>>>>>     'aux' type_id=2638
>>>>>>>     [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
>>>>>>>
>>>>>>> We don't know which one it is in the BTF.
>>>>>>> However, I'm not against this change, as it can avoid some issues.
>>>>>>>
>>>>>>
>>>>>> In the above case, the BTF representation is consistent though.
>>>>>> That is, if I attach fentry progs to either of these functions
>>>>>> based on that BTF representation, nothing will crash.
>>>>>>
>>>>>> That's ultimately what those changes are about; ensuring
>>>>>> consistency in BTF representation, so when a function is in
>>>>>> BTF we can know the signature of the function can be safely
>>>>>> used by fentry for example.
>>>>>>
>>>>>> The question of being able to identify functions (as opposed
>>>>>> to having a consistent representation) is the next step.
>>>>>> Finding a way to link between kallsyms and BTF would allow us to
>>>>>> have multiple inconsistent functions in BTF, since we could map
>>>>>> from BTF -> kallsyms safely. So two functions called "foo"
>>>>>> with different function signatures would be okay, because
>>>>>> we'd know which was which in kallsyms and could attach
>>>>>> safely. Something like a BTF tag for the function that could
>>>>>> clarify that mapping - but just for cases where it would
>>>>>> otherwise be ambiguous - is probably the way forward
>>>>>> longer term.
>>>>>>
>>>>>> Jiri's talking about this topic at LSF/MM/BPF this week I believe.
>>>>>
>>>>> Jiri presented a few ideas during LSFMMBPF.
>>>>>
>>>>> I feel the best approach is to add a set of addr-s to BTF
>>>>> via a special decl_tag.
>>>>> We can also consider extending KIND_FUNC.
>>>>> The advantage that every BTF func will have one or more addrs
>>>>> associated with it and bpf prog loading logic wouldn't need to do
>>>>> fragile name comparison between btf and kallsyms.
>>>>> pahole can take addrs from dwarf and optionally double check
>>>>> with kallsyms.
>>>>
>>>> Yonghong summed it up in another email discussion, pasting it in here:
>>>>
>>>>     So overall we have three options as kallsyms representation now:
>>>>       (a) "addr module:foo:dir_a/dir_b/core.c"
>>>>       (b) "addr module:foo"
>>>>       (c) "addr module:foo:btf_id"
>>>>
>>>>     option (a):
>>>>       'dir_a/dir_b/core.c' needs to be encoded in BTF.
>>>>       user space either check file path or func signature
>>>>       to find attach_btf_id and pass to the kernel.
>>>>       kernel can find file path in BTF and then lookup
>>>>       kallsyms to find addr.
>>>>
>>>>     option (b):
>>>>       "addr" needs to be encoded in BTF.
>>>>       user space checks func signature to find
>>>>       attach_btf_id and pass to the kernel.
>>>>       kernel can find addr in BTF and use it.
>>>>
>>>>     option (c):
>>>>       if user can decide which function to attach, e.g.,
>>>>       through func signature, then no BTF encoding
>>>>       is necessary. attach_btf_id is passed to the
>>>>       kernel and search kallsyms to find the matching
>>>>       btf_id and 'addr' will be available then.
>>>>
>>>>     For option (b) and (c), user space needs to check
>>>>     func signature to find which btf_id to use. If
>>>>     same-name static functions having the identical
>>>>     signatures, then user space would have a hard time
>>>>     to differentiate. I think it should be very
>>>>     rare same-name static functions in the kernel will have
>>>>     identical signatures. But if we want 100% correctness,
>>>>     we may need file path in which case option (a)
>>>>     is preferable.
>>>
>>> As Alexei mentioned in previous email, for such a extreme case,
>>> if user is willing to go through extra step to check dwarf
>>> to find and match file path, then (b) and (c) should work
>>> perfectly as well.
>>
>> Okay, it looks like this is more complex if the function signature is
>> the same. In such cases, current BTF dedup will merge these
>> functions as a single BTF func. In such cases, we could have:
>>
>>     decl_tag_1   ----> dedup'ed static_func
>>                           ^
>>                           |
>>     decl_tag_2   ---------
>>
>> For such cases, just passing btf_id of static func to kernel
>> won't work since the kernel won't be able to know which
>> decl_tag to be associated with.
>>
>> (I did a simple test with vmlinux, it looks we have
>>   issues with decl_tag_1/decl_tag_2 -> dedup'ed static_func
>>   as well since only one of decl_tag survives.
>>   But this is a different issue.
>> )
>>
>> So if we intend to add decl tag (addr or file_path), we
>> should not dedup static functions or generally any functions.
> 
> I did not think functions would be dedup-ed, they are ;-) with the
> declaration tags in place we could perhaps switch it off, right?

That is my hope too. If with decl tag func won't be dedup'ed,
then we should be okay. In the kernel, based on attach_btf_id,
through btf, kernel can find the corresponding decl tag (file path
or addr) or through attach_btf_id itself if the btf id is
encoded in kallsym entries.

> 
> or perhaps I can't think of all the cases we need functions dedup for,
> so maybe the dedup code could check also the associated decl tag when
> comparing functions
> 
> jirka

