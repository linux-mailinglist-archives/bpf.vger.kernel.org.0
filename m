Return-Path: <bpf+bounces-461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4A701412
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 05:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80AC281D31
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A02EBD;
	Sat, 13 May 2023 03:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F784A44
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 03:00:20 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFE3C3D
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 20:00:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34D1fVQ0017216;
	Fri, 12 May 2023 19:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6Jdfw0q7duWX/5XCgRKcO97Dx9orcr9USQ/1dkb8rpU=;
 b=D3NagsJVZnomhWSLqnHHcXqI7NtjaktxQlJsVh7/vC2VKSMSlSOCxL9RFAtLGxokZmAf
 Y5y2N3vMzQZSJtUC+VHrOmCJwiF3YdvsRClhhguntsmF43ReiLW3aSNnj/QzYWt3r/A+
 nT+7pCNnzNf12+ijwcY0KE+YI28PXxNzKWEp3MuNCuSmN80hMtMU9HQyFto2OVRwMGhZ
 xsXwL6jQvlTwqBQvfW7mfL6+DehVh4/lEmeTKndywfvrPg3e/6G6nZFUEX9OixV2TUDL
 SxNWHGpOlWomQvn//hgdP3qZTNm6t5gIgk191GP/fppGIItyi6rBPVll1C5pDbouYMtU 0w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qhb3sujgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 19:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gryj9tu4pDUt6/d1+ZJ5404krC16EWTOvpQcsMLUVsy9z6vCz0b6ru6RsaO2JhjW/wP8jHf/fUNYERF0hFFpnhdM9m9ZZPxUVAdKW3GmNCWK4zpR+T3GtjKfYE8+o11uHq7OhWioICnw0ICWrHgM1S9b/rfthwIIcZErFz2bFL6/Bv1PURC2musqSKeyke8gtfCAX3JTgkvWdDBL9nt04/dSD6BGzbw7Q62dBqoo2G1Glw3bQChxAC00ktnRz5s2YnTb0lCrPZTb80InYip4WTJPl7A6mqrEIe/ewIhZsMaMokQgQV3dJXtp+HkOhF3ZJUjqgjg6PbN0bYYyzCvHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jdfw0q7duWX/5XCgRKcO97Dx9orcr9USQ/1dkb8rpU=;
 b=HxmbGttWpeDF0IZjoYVeIhXvA3+jS5Fa5DjOTP9Zuosz7XXVpRc9WpVGaK5xiFDkcaWRa3zkk/UX5f1Rqgbq3KX/eilWmSo1S3N5rlfdNkOqPw7Ac660lWSER9UGhF/L0xnOJblZFdCLCROEpfBQkPUJh1h3wTr/QimYJygDocp6cnEFV835sNhyH73aYVup5Of/Y44M4NrEfX+7v3O9lYCe2oBaZAmaXA+G4ENR0GOFKmHFDHtSZYd4V/AkkzkS+jkl/yp8ZhLK07dVfB9xFp570Oh1HUb/+j94jy4bLrW2ufjAXNiWv5QLy24gF8xKpiHS9cQrKMsObGu6fTka3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5517.namprd15.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Sat, 13 May
 2023 02:59:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Sat, 13 May 2023
 02:59:52 +0000
Message-ID: <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
Date: Fri, 12 May 2023 19:59:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
        Yafang Shao
 <laoar.shao@gmail.com>,
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
 <ZF61j8WJls25BYTl@krava>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ZF61j8WJls25BYTl@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: d27530ba-57a0-426f-ec83-08db535e1f75
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E6DYy/6EAxQT9+DHF9ojf7ErUq1nTkVDXwlliUtwZwJpHTWrv9HkTH1p644u4qTTErwQmEB2ChvzsWRy3qO00wgrzwbNCwiZJcLUOTSOSGMBFIuND0c7oPlSus/AHhNbCivAUCUJ7WJ4IeoXpe05eWGh9a4LYmFwdmmiMob4prbirzLELO/VMl8mQ4jSQEEY/zCYzXGj79mkTdEg5+socsK6VAJci+knk+70HFZtRkPIRkWjzAoZkcrF12LxFbCJK96FYWk15Siv6iYRltvX2qyLD6VrOmPlw99RNvqaEiIjGG7dUIWNMQUifwQyXg9SDB3UDGVFcGDEFeTGtucDxZWSGeCrF/ZniyE72bBCz36100QV7+Htce8acdUmwHTnb9R1fH/kp+jZX39IxyeP5iq3tRHdSzHj57ayElRaNi2J6jjR30WKJf3DBWwifXRnuAmnkt7s+3ifUrlcMnmb9YhxSxviueWTtQg1YlIyIAc2yGzRlJBiQMHfwJ/OPVRL1Nlql7j3NPdv+LGqOpSVoimEzpl54Hwlt2xese/ZrwSVc4P836L96vXhNgmKYnsQ3L0eBC9vC3tMosmapfKJlB0kwVEc7bqR0+kTBiHK00byH4sNbeQpPXxICa7mP5FIxIQOSl0GvAkGtfq1KnKXcw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(110136005)(478600001)(186003)(6512007)(6506007)(53546011)(36756003)(2616005)(6666004)(83380400001)(6486002)(38100700002)(41300700001)(8676002)(8936002)(66476007)(4326008)(316002)(86362001)(31696002)(2906002)(5660300002)(7416002)(31686004)(66556008)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWtqSmZLRDVOeDJ4U3lIWGxBZGFtd2ozNnBuR1lVYXp1aEwzQnY1YVg3aUxi?=
 =?utf-8?B?NWxjV0d0a0VaQytKa0Vva2E0RDVlMGlpSms2bEFlZ21SRnhoVjR6eHJzM3dC?=
 =?utf-8?B?SThMeFF4WGtOWi81aGkwOHFXL3lTL2hCcjZqUXkvZk9mSEZ6NU85WXp5SS9Y?=
 =?utf-8?B?MExtZ2xhdzdLRkVWVzJhd2xwOXJoam1aY3lhUE9McDlMaDQ3dkF5cU5OMzBr?=
 =?utf-8?B?WFJwTkFWaTNJZXlwMFM0VUpYN3c0RFV1SzAreHM5WVhSZWpRa2REWTF5dlc3?=
 =?utf-8?B?Y2c1ZTZIWXI3NGx0SG5xaVZYSEpKT3JBbERzdkZ0MStNQ01uZ3Vjc3hxWG8x?=
 =?utf-8?B?VGhIMHFnMWcrajhiL05nN1RRSmowekY5NmdWa3pEMERGaWd3NGpLb3M1dHU1?=
 =?utf-8?B?N2R2UU1PdDB4dm56TkpSc3RwUEJYRlBQZ01wVkhmeTlvQkVOZm4vMkRwUWpz?=
 =?utf-8?B?Qnl0ZGdwVXRBVFlVRlhYNmVXVUUxZEhDbFdmNHB3Vys3OHBuem5VZ1BYeVVo?=
 =?utf-8?B?SHJGTUxjY0VRWlN0SHI1S1EyNUZTUFJFcndzK1lzbUdRMUJxa1ZONkZMbGJ3?=
 =?utf-8?B?VGlYOVJpbS90WDZ6VEo4NVRQWURLSTRLaklscXlhcjEwbVJjZW1CanU0VTVW?=
 =?utf-8?B?MzBFaTN5L0dHT3l1V3Z5bUtGTUtaWGpvbVNFQmE2RHVsRjNsbytGZW1qbTdp?=
 =?utf-8?B?ZmFjVWVIb1NkNG9rbGxUUG9qYWlvZ0l4eGpJRU1JVVE1MFJobDltMHhxLyt5?=
 =?utf-8?B?MDVxZCt3ZnJ1M1Btbi9VZmlnUlk2ZndGQzIwOWZ1aXZCTlpzRkMrL0dHT2VK?=
 =?utf-8?B?SnQ5OTNZcjVYVGNQalFudjgxeHgrb01zQ1RQdE5MUWJNWitnM3dUTGxhSTJz?=
 =?utf-8?B?OVFlemc3U0pwd2lkYXV3dG9WeWE1QWVkTEdQYWsvL09UOTlZRUIvZjBqdzVj?=
 =?utf-8?B?U0EybEJPekQxRUFDTHZCQU5zTnpPOWw4cjdLS2prc3BSbVJmdmh4b0g5TDV3?=
 =?utf-8?B?MU1ZK3Bnck9YcDA4UXpOVUNaalhTVmtwYzZkVmpENWJzaVVLaHFQdGIvUFk2?=
 =?utf-8?B?YlI4YkZNVmk2cEZZamVQNzhqbDdFb290N0w3c0VoZFNaTHVONW8rc0JWeFVv?=
 =?utf-8?B?UjVVTzRuVEpHVFJhT09CZ24ycUc0ejRQNDVwSEc4L2Q4eFVROU12Umo3amND?=
 =?utf-8?B?Yk0xOUZ4L3ZZbTRQTkx3MUpmdzNTQ0Z5U3ZjRGFibXI3QVo2OU43TmRReHJ6?=
 =?utf-8?B?MTViRmNpS0N3ek9lbmpaQzQ3SVFCbWw0YmRibkUzbTdvakJpOHlIQW02WDBs?=
 =?utf-8?B?VSsvTmcyZUtWKy85VERDVXY2QUpVSjFCMXZHaGdtVHpsRHBML1pkaGIxWUNR?=
 =?utf-8?B?ZjFRMDJDUUFFNVZYVkJuSm40UVQ5Tks2L3JSRm9VOFZuS3RjYi9iS21jTjJF?=
 =?utf-8?B?ZW1GZlFYRFJHbDJYb0NaRTZTTDFseEVFaUJ3MmpNKzJ0M3hQUy9PY1BZOEpK?=
 =?utf-8?B?NCt5bjlyN05Scld4UjhOUEdWN044NWVsb2kxdm5VZjNxY2JkM3ZCTDgyQ2tX?=
 =?utf-8?B?ekZSTmxwOXVFZ0kwTFdwTVpkZ0hpQWdLSFNyOU5zS0lZUFh5Q0hhcERGaFVr?=
 =?utf-8?B?OTFEVWdFTFErblBnM3lOT0NUc2Z0TTVDalY1RS9oeFlhdndnTlVUM2dKaitk?=
 =?utf-8?B?YmU2OXhsNXhlNjk1MVBPMHcvNVVWQXlicHU5dWJnWXluRk81Y29GV2I0R2dD?=
 =?utf-8?B?TkRCSnl3eWh3Q04xSnVWclRPK0RveVIrZitSS1hzdHQrdjZ0MjlIMnZwZXZs?=
 =?utf-8?B?N1JYTllLYnBHUnFHNVJQTFRpNnQ4T3dQaFJkWklUdmlvTXc2OVRlS09EUUNH?=
 =?utf-8?B?bGJFWlFTTWhGSEZVZkNSbDlOc2N3cHJPSGRYdW9qSzNsRndqdFlvbGJqOFp6?=
 =?utf-8?B?WkRQUEE5NEZiOUFtbFFWamkyek5vZUorTys5ajlPQ0NDNWtHamQ3N1l1d1Jy?=
 =?utf-8?B?dG5FMnBrZFkvQ2k0cWJPM29xd0NLTjdDaS9EWXB4Z0ZoQkp4WnBEV0xHVXo2?=
 =?utf-8?B?OUN5ZTR6N01FT3N4bWR3OUxNcWwrUVFmOEJsTkM1eWdqZEd1clRGYmxiZlhC?=
 =?utf-8?B?eWpPLzVvMkZlQ0NlblVGYlJUd0tlSXJXeW1HU25vVUcrUDY3WnZia1RzTlE1?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27530ba-57a0-426f-ec83-08db535e1f75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 02:59:52.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud3r4Ck5DVTlU5FmpZdX95ynZN2gDYnl9vDA7+ly2dDLx54ca7W0Az1FmATpVer3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5517
X-Proofpoint-ORIG-GUID: OE28kQBrmHR5It5G8bqLCSfTATo8wzXx
X-Proofpoint-GUID: OE28kQBrmHR5It5G8bqLCSfTATo8wzXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_16,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/12/23 2:54 PM, Jiri Olsa wrote:
> On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
>> On Fri, May 12, 2023 at 9:04 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 12/05/2023 03:51, Yafang Shao wrote:
>>>> On Wed, May 10, 2023 at 9:03 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> v1.25 of pahole supports filtering out functions with multiple inconsistent
>>>>> function prototypes or optimized-out parameters from the BTF representation.
>>>>> These present problems because there is no additional info in BTF saying which
>>>>> inconsistent prototype matches which function instance to help guide attachment,
>>>>> and functions with optimized-out parameters can lead to incorrect assumptions
>>>>> about register contents.
>>>>>
>>>>> So for now, filter out such functions while adding BTF representations for
>>>>> functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
>>>>> This patch assumes that below linked changes land in pahole for v1.25.
>>>>>
>>>>> Issues with pahole filtering being too aggressive in removing functions
>>>>> appear to be resolved now, but CI and further testing will confirm.
>>>>>
>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>> ---
>>>>>   scripts/pahole-flags.sh | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>> index 1f1f1d397c39..728d55190d97 100755
>>>>> --- a/scripts/pahole-flags.sh
>>>>> +++ b/scripts/pahole-flags.sh
>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>          # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>          extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>   fi
>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>>>>> +fi
>>>>>
>>>>>   echo ${extra_paholeopt}
>>>>> --
>>>>> 2.31.1
>>>>>
>>>>
>>>> That change looks like a workaround to me.
>>>> There may be multiple functions that have the same proto, e.g.:
>>>>
>>>>    $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
>>>> kernel/bpf/ net/core/
>>>>    kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
>>>> bpf_iter_aux_info *aux)
>>>>    net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
>>>> bpf_iter_aux_info *aux)
>>>>
>>>>    $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
>>>> bpf_iter_detach_map
>>>>    [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>>>>    'aux' type_id=2638
>>>>    [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
>>>>
>>>> We don't know which one it is in the BTF.
>>>> However, I'm not against this change, as it can avoid some issues.
>>>>
>>>
>>> In the above case, the BTF representation is consistent though.
>>> That is, if I attach fentry progs to either of these functions
>>> based on that BTF representation, nothing will crash.
>>>
>>> That's ultimately what those changes are about; ensuring
>>> consistency in BTF representation, so when a function is in
>>> BTF we can know the signature of the function can be safely
>>> used by fentry for example.
>>>
>>> The question of being able to identify functions (as opposed
>>> to having a consistent representation) is the next step.
>>> Finding a way to link between kallsyms and BTF would allow us to
>>> have multiple inconsistent functions in BTF, since we could map
>>> from BTF -> kallsyms safely. So two functions called "foo"
>>> with different function signatures would be okay, because
>>> we'd know which was which in kallsyms and could attach
>>> safely. Something like a BTF tag for the function that could
>>> clarify that mapping - but just for cases where it would
>>> otherwise be ambiguous - is probably the way forward
>>> longer term.
>>>
>>> Jiri's talking about this topic at LSF/MM/BPF this week I believe.
>>
>> Jiri presented a few ideas during LSFMMBPF.
>>
>> I feel the best approach is to add a set of addr-s to BTF
>> via a special decl_tag.
>> We can also consider extending KIND_FUNC.
>> The advantage that every BTF func will have one or more addrs
>> associated with it and bpf prog loading logic wouldn't need to do
>> fragile name comparison between btf and kallsyms.
>> pahole can take addrs from dwarf and optionally double check with kallsyms.
> 
> Yonghong summed it up in another email discussion, pasting it in here:
> 
>    So overall we have three options as kallsyms representation now:
>      (a) "addr module:foo:dir_a/dir_b/core.c"
>      (b) "addr module:foo"
>      (c) "addr module:foo:btf_id"
> 
>    option (a):
>      'dir_a/dir_b/core.c' needs to be encoded in BTF.
>      user space either check file path or func signature
>      to find attach_btf_id and pass to the kernel.
>      kernel can find file path in BTF and then lookup
>      kallsyms to find addr.
> 
>    option (b):
>      "addr" needs to be encoded in BTF.
>      user space checks func signature to find
>      attach_btf_id and pass to the kernel.
>      kernel can find addr in BTF and use it.
> 
>    option (c):
>      if user can decide which function to attach, e.g.,
>      through func signature, then no BTF encoding
>      is necessary. attach_btf_id is passed to the
>      kernel and search kallsyms to find the matching
>      btf_id and 'addr' will be available then.
> 
>    For option (b) and (c), user space needs to check
>    func signature to find which btf_id to use. If
>    same-name static functions having the identical
>    signatures, then user space would have a hard time
>    to differentiate. I think it should be very
>    rare same-name static functions in the kernel will have
>    identical signatures. But if we want 100% correctness,
>    we may need file path in which case option (a)
>    is preferable.

As Alexei mentioned in previous email, for such a extreme case,
if user is willing to go through extra step to check dwarf
to find and match file path, then (b) and (c) should work
perfectly as well.

> 
>    Current option (a) kallsyms format is under review.
>    option (c) also needs kallsyms change...
> 
> 
> my thoughts so far is that I like the idea of storing functions address
> in BTF (option b), because it's the easiest way
> 
> on the other hand, user would need debug info to find address for the function
> to trace.. but still just for small subset of functions that share same name
> 
> also I like Lorenz's idea of storing BTF ID in kalsyms and verifier being
> able to lookup address based on BTF ID.. seems like easier kallsyms change,
> but it would still require storing objects paths in BTF to pick up the
> correct one
> 
> cc-ing other folks
> 
> jirka

