Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E5C43C0C9
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhJ0Dct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 23:32:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37706 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237941AbhJ0Dcr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 23:32:47 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QHIdIH007631;
        Tue, 26 Oct 2021 20:30:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xZCRceKzomuMr4p9ib9VKHpf1mcpLbmT50Y8AtjlukI=;
 b=Xh+QOOFm3z5Yz/+K22aNINZO3fuR+vwYJ7sDZcv32QchFmNqBdzgQ/w/t/ywJfLfHBdb
 S/PiSDjWclrShZb4cgjncSGGEWpnVtTUy16g8rguZtVc6E2hxmt3vem0aHvGTktsKs3K
 avC3aSrQ4ar/mgInPrXjVS63MJS9rmO25Jo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxny4bmaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 20:30:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 20:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX+vnFXCAfQ6HM+dkU8Q5UCQVuWPPyFzk1RZiL8MJ5N+OeqF0BF8Ihgl4+vy9xmXdhSXrpb0IBEPMGf9U+gLgrfQ/lZ+uCmeRnWfZwQCnuw/3p35f+iCHHa64z80rMpyblEUOMZeDVl0/bDON3eBtM4juTd1nhU+l8LpEvVcbhMWkmC03etfS3o+GP1SLlJueHIyx+lR8Z06uE7nrgQmsNZyReeJTJcVCBvbu+llKot4DAuy36Kq+42D/uPLQuClX4u2I6rTiE17q5x3mx7ZYFBH4yojEm4PDqpJhlCl4EXP+JodPcPIXRkrr2RSWoNsfgU18Gt/hJpMTdGUYR2ZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZCRceKzomuMr4p9ib9VKHpf1mcpLbmT50Y8AtjlukI=;
 b=ONgQVmv5Gzcrk7Eh25E3riCIWFsX6XpJfpoJlT264skp5UhyX9rbH+XiQHwH95Gu3Jioqe/G71h1JGXAS1hKZ131ZGAE+WvjE8WDtsiopPhasRlNKIPlbiQdHFgfyPkHLzmdvMmfbDSWLEeyjPH964wuIpGBtHC5eApZb1U5JM5/oKbhqPIT2qlUOFFeANf1I8EYhzJAkrBfrRGv1T0GKRlvH8UYn4ZVD+BPxgckfg3NZ9a6XY73CZH6lrChOWQQcRWUgaS8I4iwYE2nQnFOM+3sgMwQgr7DlqatmMFVK7/CrHkjYSB7MdXKOyTHEDVFIvy6ow24cX4LyU9sMdr/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MW3PR15MB3980.namprd15.prod.outlook.com (2603:10b6:303:48::23)
 by MWHPR15MB1597.namprd15.prod.outlook.com (2603:10b6:300:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 03:30:17 +0000
Received: from MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075]) by MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 03:30:17 +0000
Subject: Re: [PATCH v5 bpf-next 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <3bc83103-6c5a-6cfb-9ea3-1b98fb50352b@fb.com>
Date:   Tue, 26 Oct 2021 20:30:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211022220249.2040337-3-joannekoong@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:301:1::21) To MW3PR15MB3980.namprd15.prod.outlook.com
 (2603:10b6:303:48::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:2103:b2:4e6a:72dd:1ddf] (2620:10d:c090:400::5:8f40) by MWHPR11CA0011.namprd11.prod.outlook.com (2603:10b6:301:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 03:30:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5018ecf-ea53-4bfb-e1ea-08d998fa186f
X-MS-TrafficTypeDiagnostic: MWHPR15MB1597:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1597F02549B2927D2A9A631AC6859@MWHPR15MB1597.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0FJIKr0r0+t12XL3E03L79fzZJIaW1Ed7UaQC1BQ2jAXF4CXNunc+SYP94zDRZ8SvZApwnamd7IxrTtB58jmItW+Ls+HaxT3Pubc6I15jUBsQPzwIUb86QeUWQtAPfszuUYsJOPoONI0qZS1vAO9tVWgy5BOQv0vd7EJ58Re75LLDhEV4pF4MY1ipl8Kp3YAXg8kbSU+RsupcAmovQRKzDiNJRcXpUM2jLGm5dxFnHUrEuAZJbmMpFyTWsFI/jUDL2XfkPUsT1Shw90qXqDueNs99spkULd7mn6VqYSrVRcAePCl758GPjWCxz96RRWPCRz6WefdBnHNzbJXFEen1TIpeoa+5RCX3aXExR7pgQ3fqMZaR9pyS1pNfqtICDtwZsPk4M6nVIbC0lTkRq3E+jDlEnmskhdRe3ocmEHQTIuXmvqe+My8MLw3/sxFY0KrNKAXcyVh15fYQhzofVuTVZweKZ6rnpwSVTCKvre9+daxkuhFDZqviBmIHJXtijzCbjJuDceg2SlfQQR1vA7NZV1LwLHfsBm5Tl9puMjeiIJ62wSOR6qvcIPD+Ca7nhS0ZuX0kj/tWF7bgsKN4/bydrGKwam6FzJrRzuBXKatp8503pAMQYZUluZS6W5XTuk3mBxHLyNksKMENyqiz55wYN2YQlwqJAAkEmrQfiYDNV/tzbkOuUdWCHmzNPMae2343PyBtj+Ua1l2m1E5Y1N5OHVfjdNF0eKP3qevrT7SX6QeyPZZHDrDYEwQs7h7wZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3980.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(8936002)(316002)(31686004)(86362001)(83380400001)(6486002)(66556008)(8676002)(66946007)(66476007)(36756003)(53546011)(31696002)(4326008)(2616005)(186003)(38100700002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWQ0RHpoK0tEd2I5bWVVclByRWJVUjBUVHRaV210Tllja3Z6SlprZGlOMjlx?=
 =?utf-8?B?VkVvbmE2OEFpUjdXdk5MbXl6UGFvaGd1MnFQRXBWTWNVemlVdzFteHFLeHdt?=
 =?utf-8?B?UERTYmhPRTMzeWova3R6RWNJVW9HdjN4b3VPQTFaUEEvN0U0Y2N3Z28xRlcv?=
 =?utf-8?B?eUIwMGpxTjRaUE5KUVNTcExFQThTQ2tPbVIvUGNIK0ZoaFptNVpBdzFtSTlr?=
 =?utf-8?B?TmkvQUlpUDRWVU5Ea1lDR3pJbmV5a3cwaWZXNERrd2JveFpldjVwNnJ6cnR2?=
 =?utf-8?B?ZEdZQXkzbnZ2ZGNpQmR2TUd3MnRLdkVHR2hsdm8yQmFhQTg3Q3E2a2dDRVlT?=
 =?utf-8?B?azQxVW9sR1NGYythM25JNDRidTBxVFdUZ1FnNGRBU0V4bUdYMVZTME5HVFMy?=
 =?utf-8?B?YWFTeVNYOGxFY3JZSjRuVVZEUUZENDFoYlFQemI3OXB0V1pkT3I1VUIwcit3?=
 =?utf-8?B?QVZ0ODNIbjBXczV6dU1oelp3eVhRTWd0SENmdEt6Z0FwRUFrK2RyK0pUTnEy?=
 =?utf-8?B?eHFjRWZMYnBJWTJ1ZklWT0pXaXFXL1l3aGV5THZnTThNUm1MYU5WRVRSY3VT?=
 =?utf-8?B?S2NMWDZnUVlqdEVtTlAybUhyd0FBbnp6YnBvWlZTejFvbjMyZzdyQXNNVEdr?=
 =?utf-8?B?bGcvSDI5eDZBRnZnYXpwR1RFaEllSGduV2lMWXpIZ3ZlSFFRZS9ja2prK0JR?=
 =?utf-8?B?SmFmdXVaRHROVnhvbEFXZC82Y2V2SGM3WlJXWUxvdFB1TEMrMDZNdUJWaGJn?=
 =?utf-8?B?Mmwrb01Qd0dxQVdxUXpQV1NGNkJHSEk5R1ZCRDF4ay9jNWpWd1ZDRWFXbkdF?=
 =?utf-8?B?cVc4R2ZFSXZkaXFESy9jeGJqTlhDR2NwV2RSZmlBbS9OQkY4YzlkbGZ0WFRs?=
 =?utf-8?B?U0ptUEc4SThDdnNTODhSbG5ENU82Zno4cjFFdEdHb3huTTJKRGx4MWtDeGVK?=
 =?utf-8?B?VUpRMGtsazFjQ2w0MUdid0QvckJLc2dubk9ta0VQM1JHQmg1dGZmamU2SXJE?=
 =?utf-8?B?cTd1cndJWEdGUHB5c3hQN2VidGEySmc2SlpoT3JOQ0crN3ZlSTdCZTlzbmFj?=
 =?utf-8?B?QXhvekE5c1NBWng5RDErZ0tmV1JuRS9UZlZkQ0tLYjhGMEZpQjNUYWNXYWFl?=
 =?utf-8?B?RURWKzZHYWFmSDRjT1hjK296T2lMZlMveXpGeHVYaS96bVVhdnJyNVBNOThu?=
 =?utf-8?B?a1Rlc0FLUm1IeUd2dDR5SndTdXRiaEdpRDI4THlSdktIbjc3MHNxdGdKa1Y4?=
 =?utf-8?B?R3g4bHB3dm16Wk9jMm1nUHZIQjFPSU9YTEFDRW1mL0YrSUZtajhVa3prSURz?=
 =?utf-8?B?WUpJZzRiNU02NEVTMnpYK09SaU1ScHBoZUw3emN1dnZZOTd3MTJ0MTZlVWRO?=
 =?utf-8?B?VTg1Vnd6RVh5Q1NFb3dTaCtvbGR2UG9uTkNlTjVFNURDc3dQNUVmeWZpZGFn?=
 =?utf-8?B?cTNNdUdCSWx5RWhJdk53ZUl0QzFHeHZ3TzF5NW54YkM5WGJXV3czcEsrUFVi?=
 =?utf-8?B?R0diQXFqNXYzMXVYRWkvVmcwZkNiY3pQR1FjcERVcktmbU5JMnRpeENiNlpj?=
 =?utf-8?B?OVBzWHIwMDhMQTltMmhCcTBBSXBkWXMyZjEwU0dXWCs1bmdCWW5LOGNFZEcv?=
 =?utf-8?B?NGpVWk9IalU1QTBPL0xqY3p0OFNJako2V3d3cTkxSjNPaWYzRlpkdFhBTFgx?=
 =?utf-8?B?TUFSSmdHMlZYVWg5azBVcWIrbEIwSTZNSkc2MVhEV1ZoWHNLUS91d3kyTTdD?=
 =?utf-8?B?VUhDdmVDY2ZzL1BxRGVKSDVLMzl6bFpMMzBUaVU5K2hKeTBSd0M1Q2FxOFpk?=
 =?utf-8?B?bVhYMzJ4eXFJeGdORkxRQlk3Z1BiSi9KVUtyTGp2SGNlNTRNN3hMVnBETis4?=
 =?utf-8?B?Rmo1QVFIL2x4WG1VWktZTHlINlNFOW1MbVhzVnBIdHU1YTVDU3Q5VzFqMDcz?=
 =?utf-8?B?WTBrYWtLbExKWUVBMmZEVUNhVEpBRHQvQlRLMXVmNFFuZ29YZkFuL1NYcDZC?=
 =?utf-8?B?S2pEK2xYbVpVdDduNXRISGgzT0d3OVQyc3ZQYmNGdkxJUk5aS1crZkdsMXd3?=
 =?utf-8?B?OGJJTSszanp0QW5lbXdXVVJnb3UzK2d0V3dMcExkMW5UVXd0VDBvRWhCNG80?=
 =?utf-8?B?YlAxSlZqeUwwTTRsNmJoYm5QNEppWml6RFg0VUJjM204QWdpcTg3WWZLSFgx?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5018ecf-ea53-4bfb-e1ea-08d998fa186f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3980.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 03:30:17.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yQdVk3xV7pdzD874XA4VvnAys5ZgDouStWk4DOIELDwNOcfNmFW37w93PnU+aW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1597
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: f19Izs0oYsEXDhYKJJKeHpmtRzcTpxDy
X-Proofpoint-GUID: f19Izs0oYsEXDhYKJJKeHpmtRzcTpxDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/22/21 3:02 PM, Joanne Koong wrote:
> This patch adds the libbpf infrastructure for supporting a
> per-map-type "map_extra" field, whose definition will be
> idiosyncratic depending on map type.
>
> For example, for the bloom filter map, the lower 4 bits of
> map_extra is used to denote the number of hash functions.
>
> Please note that until libbpf 1.0 is here, the
> "bpf_create_map_params" struct is used as a temporary
> means for propagating the map_extra field to the kernel.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   include/uapi/linux/bpf.h         |  1 +
>   tools/include/uapi/linux/bpf.h   |  1 +
>   tools/lib/bpf/bpf.c              | 27 ++++++++++++++++++++-
>   tools/lib/bpf/bpf_gen_internal.h |  2 +-
>   tools/lib/bpf/gen_loader.c       |  3 ++-
>   tools/lib/bpf/libbpf.c           | 41 ++++++++++++++++++++++++++++----
>   tools/lib/bpf/libbpf.h           |  3 +++
>   tools/lib/bpf/libbpf.map         |  2 ++
>   tools/lib/bpf/libbpf_internal.h  | 25 ++++++++++++++++++-
>   9 files changed, 96 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 66827b93f548..bb64d407b8bd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5646,6 +5646,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> +	__u64 map_extra;
>   } __attribute__((aligned(8)));
>   
>   struct bpf_btf_info {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 66827b93f548..bb64d407b8bd 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5646,6 +5646,7 @@ struct bpf_map_info {
>   	__u32 btf_id;
>   	__u32 btf_key_type_id;
>   	__u32 btf_value_type_id;
> +	__u64 map_extra;
>   } __attribute__((aligned(8)));


this is kernel UAPI changes. They should go into the first patch or 
separate patch. And you probably need to extend bpf_map_get_info_by_fd() 
such that it actually populates map_extra field.


>   
>   struct bpf_btf_info {


[...]


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index db6e48014839..751cfb9778dc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -400,6 +400,7 @@ struct bpf_map {
>   	char *pin_path;
>   	bool pinned;
>   	bool reused;
> +	__u64 map_extra;
>   };
>   
>   enum extern_type {
> @@ -2313,6 +2314,17 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
>   			}
>   			map_def->pinning = val;
>   			map_def->parts |= MAP_DEF_PINNING;
> +		} else if (strcmp(name, "map_extra") == 0) {
> +			/*
> +			 * TODO: When the BTF array supports __u64s, read into
> +			 * map_def->map_extra directly.
> +			 */


Please drop the TODO comment. There are no plans to extend BTF arrays to 
support __u64 sizes.


> +			__u32 map_extra;
> +
> +			if (!get_map_field_int(map_name, btf, m, &map_extra))
> +				return -EINVAL;
> +			map_def->map_extra = map_extra;
> +			map_def->parts |= MAP_DEF_MAP_EXTRA;
>   		} else {
>   			if (strict) {
>   				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
> @@ -2337,6 +2349,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>   	map->def.value_size = def->value_size;
>   	map->def.max_entries = def->max_entries;
>   	map->def.map_flags = def->map_flags;
> +	map->map_extra = def->map_extra;
>   
>   	map->numa_node = def->numa_node;
>   	map->btf_key_type_id = def->key_type_id;
> @@ -2360,7 +2373,9 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
>   	if (def->parts & MAP_DEF_MAX_ENTRIES)
>   		pr_debug("map '%s': found max_entries = %u.\n", map->name, def->max_entries);
>   	if (def->parts & MAP_DEF_MAP_FLAGS)
> -		pr_debug("map '%s': found map_flags = %u.\n", map->name, def->map_flags);
> +		pr_debug("map '%s': found map_flags = 0x%X.\n", map->name, def->map_flags);
> +	if (def->parts & MAP_DEF_MAP_EXTRA)
> +		pr_debug("map '%s': found map_extra = 0x%llX.\n", map->name, def->map_extra);


%llx will cause compilation warnings on some architectures if used with 
__u64. Please cast to (long long) to avoid that.


>   	if (def->parts & MAP_DEF_PINNING)
>   		pr_debug("map '%s': found pinning = %u.\n", map->name, def->pinning);
>   	if (def->parts & MAP_DEF_NUMA_NODE)
> @@ -4199,6 +4214,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>   	map->btf_key_type_id = info.btf_key_type_id;
>   	map->btf_value_type_id = info.btf_value_type_id;
>   	map->reused = true;
> +	map->map_extra = info.map_extra;
>   
>   	return 0;
>   


[...]

