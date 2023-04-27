Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67CD6F07A9
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 16:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243987AbjD0Oob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbjD0Ooa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 10:44:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A503A9A;
        Thu, 27 Apr 2023 07:44:29 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RDcjJ8025502;
        Thu, 27 Apr 2023 07:43:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=09Iy/xk4ChHFwi9hTD1xPPZL98gtSS17cCAZ2iDLTsY=;
 b=gDVsSThN7ax4RqCTfAgjvY++9Nc3sIl//IsYfsvLR97fu21mHaWnikIw8h61+PxKuCX0
 MSlChfBaumW1BqsUCPOmOGBb4SRHbtrbNYWrOC+umDDWtLBjLzWnJWy3qdw/7t8qXggJ
 9oRF5frZNOn/tnZaHWgcFLNLz1aLCJzMuuKLYOMYjtScNRP9K3+631qcHmN7fd/iGm7H
 NBgJHq9H2Tn4HtkmQTLsbUcY57rTJX3dPt/zEpxr+CiEteUd02rOIi/kmaU1PMUy0oeF
 laVYoub1/MmxOFiBs0Wg9rbVODF86T2fm7MBPjtXyKncd8y5OlQ8jXX+uxaxc7Rat5o6 pA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7e8hcufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQmNI+0lhd7tTQRWwc1FiHPLwXWTRXPVAR05As0myoCpVX9K33VNTAOiCuSiwrnmzAYJjBG4dboXVgDOqEW1e+sN52LwdAVVK20SwFxAVJwmVp7a+1pgJsU43OwGwmjR6bFKIan8mrp2ATGvabPglztmLGfCbEIuo5TPjMguKA23OgLldDoEozqDFsYCb3v9nyDQdwnHEFbfmW/WfFzShaSWm0lbyVf9WmVXRnWOeqK4EGexz8VYYqad+eb7rt//jrLqk/PIVxagAILeVEXiC0Ptj8KoS4wvuUU0Kgr2EfZIhlauTYczh5zuTswnld7c4T92L0GlvHWfBXCGkikTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09Iy/xk4ChHFwi9hTD1xPPZL98gtSS17cCAZ2iDLTsY=;
 b=T6B2GtdLtQCvX6PbbZMzlz5VDnPjTUNPZYxaB19mww2QhRARF825US/bwi9pvM020B4N1mPkeztJy2WCRK5FNkT78MqjUoNFE8gqhOytrTZeZ26lWz87l7y57L//kyhZRLgYSvwTZwPk+r1epDPO7z25LjppAvdcEUubFvTTmwp4KuB8Cw3EFdu9sbeXjIwwsnBCQp1/OqoMVv2rpz01rPviA/bwwLP3hjvlRa+kJOZTwQyYuBONgVFpSZRglyBUu5HwH8M5T0h0hQ+rSbDCZUNxUguuywBBH6aepwSVhBrRpuSSKBQHibaW/0SzqWpe56VnL1E4JoQpjtm+ATBW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4613.namprd15.prod.outlook.com (2603:10b6:a03:37a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 14:43:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 14:43:52 +0000
Message-ID: <3a96ec27-9175-e161-32ef-5cb40f4e1ea2@meta.com>
Date:   Thu, 27 Apr 2023 07:43:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v4] bpftool: Dump map id instead of value for
 map_of_maps types
Content-Language: en-US
To:     Xueming Feng <kuro@kuroa.me>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427120313.43574-1-kuro@kuroa.me>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230427120313.43574-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: e82e41d6-7caa-4b4b-9585-08db472dd1f1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdp7JwiOMaOfuNN60F73mfPBRiVRNK68yP9rck9kj7/e38mQmaS1Ixn/d1vtUX39PLaNxucn9KLXxjeFmgze9ENe+dATfLrMvjvXJXTxB5R3iR1qfolXmLp9klk8dwMw90Ydwz+SLiiX6sNgzSWfxqZGJrq3b8YqkzklS1/NopOl6tKoe1YGHBtcN4w83Kt0hJd5Po2E1EU0sIq+Qww21wYPeLUcgvSUXmUmot8MUZ37UyNnwtfPDC4HzD4e5ozjTsY+oleQfWwzjNIMndFT1+QsnB1mLbtWS/zT10tb3w0gxWWqL3tdKp5CwsRjMvYc8a6ETY6yo+INi2B3i4LgPqMQmsvUVux4aSqiq7qkfYS4MbRvtG8BNIjACfWVpEPH3sEpaqDMgXIB4z6NKxABupbdezg5wc8vCOn9NkwBMGPYO8WSiiG2qYXB+1IJOSZ4JkrgG64a0RNqbXdCHQ6Wa5CEiTZstHE7Aqw6q1SK3jEjtJAsjJ3C2kMyC15ifkAayBLJf27kE9WxRbfl9CvFvnhG/nLjlymI3nsVuo8ObjYNwAY3QtEDJ/cnBgr+gbJV0AMSf7j/os0RnRBtn3VIW/YR4YI2kXKb2wVbKEGSPfpi8ol36DzpYW8iMjeY6+hCENw3OUHdG3orGu2QZ9whVXB+k39v95E841jiwwIuGRQA1e2pcc1BD/9+7egBriqc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(31686004)(38100700002)(6666004)(4326008)(6486002)(110136005)(54906003)(66556008)(66476007)(36756003)(316002)(31696002)(478600001)(41300700001)(86362001)(6512007)(6506007)(2616005)(186003)(5660300002)(66946007)(7416002)(8676002)(8936002)(2906002)(53546011)(83380400001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUV0aUdPZXdmR25tNnFVd1BsV2tCTVk3a1NYZG82OWgvYm4yR1JUc0lOUHFJ?=
 =?utf-8?B?Vi9kNnVoMXlWSWFDQkFvWjVJWTlrTGdXeStyMUd1Qm9kUGNnTXNqYm84dTR0?=
 =?utf-8?B?UWk0QzJIRjc0VjJIRS9xUGtBTlpIc2ZpdnhDanpFb2l0OTM4NlBpQ0VHd2Iv?=
 =?utf-8?B?M0V4TE9iWi9nVVZldHdNS1ZrNGhPVzJYOWR0eEp1VWpFcTlNZFprSmdTa2or?=
 =?utf-8?B?ZkRwaVR1NVI1Qml1VWlWSWFSa2Nkc2lyUHlPaVExUGp6dGtHTkFKNFduOERS?=
 =?utf-8?B?MTM1V0RDdVloUEJDWGp1MGZacUpYcU15TjIvcHF4L0tOeE56azFlVmVQMjA1?=
 =?utf-8?B?dU1ncnA3WDJ1T3Y5R3M3N0Q5c2xzNG91MnMvSFAxaW1wZXNzazU1ZjZweU5k?=
 =?utf-8?B?dmN6TjJEaUFVdCtiVmV5RnMvM3M4SDBpR3ZZNllmWnAyclBwU0J3aXJCZVIr?=
 =?utf-8?B?VnpLTGhZVG1wbzNzNFJXQkNad1hSVHo0Zy84eUUvaTdKUHZxbitwaXFJZ1Vl?=
 =?utf-8?B?SXJvL0NEUjcwb1BoWlMzN1FNTko5Q2lvWUNJcEV5dmQwUmVOYVpyc2s2bVhr?=
 =?utf-8?B?V2JYMHZvQXByNHpmdm8xOEZmaXNnbkIyWFpyTnNqeitielI1bGFVcXJmSTc3?=
 =?utf-8?B?bnp5ZG1uSWZVNXJzckpZbTREMU0vaHRPdVlwOW5RN28yUlNqMi84OStSakht?=
 =?utf-8?B?VjRvRVcxblc4RTVscXVjNGJGTWVZK1piM2ZpeVpibXliSlRPczVtaktENmpP?=
 =?utf-8?B?OU1pbjVMRWFqdi9zTUpWb3dkblJ4MlVpMlk0STZBVkdwT1dKdWZaekM2a3Iv?=
 =?utf-8?B?eGZSSHN5b3E1YmNQUXZybTM0QmFJay83MUw4TExIZ1ZzTzlEUldkUE11eFM3?=
 =?utf-8?B?SzhualdCaTJxWDhvL1FMenRML0lqaW1ZdjZNays4L0NQOU53WnNobTZmZ2NX?=
 =?utf-8?B?eFlSQkNRMmY0SVBqMVkvTVlBQXovSkQ0N25OaWJDelkzNjlBdUVBbUFlcUtY?=
 =?utf-8?B?RktSNmc5UUZwdWFaWTJ3ekgrR2Y3MG9CMmZWRVpIVWI1algzLzdQdHlmTXNZ?=
 =?utf-8?B?ME51bE1WWExPWXloUFpwajIxNHVoQUx1NWh2eVRUZTRXQVRkcnFnVTFwMjVH?=
 =?utf-8?B?UmNFVExZd0J5NDdGR1ZEL1ZxOXdTOWgzaklDZmhIMWVWVzM2NnNBSllqUytN?=
 =?utf-8?B?T0c0SGpGU2ZuOHRHSnZRNjlGdzlqTmVxYXphOS93alpzK1BwYWxVZWV1aThT?=
 =?utf-8?B?TlpOOUc3VVZKQ2JOalpPVWxNNVBhVHp0RE90WisvVVpQZkNKa1RCNEVHRmQ4?=
 =?utf-8?B?cld3eHJnbjNDT2VlS2RWNnVGRGpKZi85V1IxVlplUkpCbXg5bFczWXVWMTJY?=
 =?utf-8?B?dFVMTjJDdmhFL1gxMTJnT2FlZU9FVHFXZDA1UWJTTzZwVVNUK1VoT2dJcEN4?=
 =?utf-8?B?bHZQcnFsL3ViUmZ1US9oVHZTQ2YzcERuY05HTS9ndWorWlNPVVBEbldLOTQw?=
 =?utf-8?B?V2QwQkJMRFdaS1oxVzZZZ3NIblB1OWRlRndhUnl5RmN0Vmx2OWdKVlhzUHJ5?=
 =?utf-8?B?dGF3Um9pekliQkNBUmFkcm9YSTRUTzlDNG15L2dSTWYyRUQ2WWpHRGNsUGUw?=
 =?utf-8?B?b2RMcGdqOXBPTjQ4WVp5TGJxa1FtMm5HY0hLQjRSNkM2YzE3bVNXbXhkNnJ1?=
 =?utf-8?B?bldWc1ZubEhvN0JhVmw3RUxZTlkvclpvdnlqSVNZd0JDWmFFOWhHV3dzV21G?=
 =?utf-8?B?OGljMWhDaTJHNUs0SmFJazVhSEtDc2kvRkNnc3AzQitMMHZZSFJrZWFXUW9m?=
 =?utf-8?B?UHZRMkxhUC9CbVpqc2h1bEk2b3ZkMnAzRi9sRjV3dUErMmtSbSszdjhxTVRl?=
 =?utf-8?B?WU5DT0JHQWRQMXpiclZSVjk4N25VUmpkM3ZiR1VhZzY1S0lBVGQ5WnpCaGs4?=
 =?utf-8?B?UVYzWHNYYWVwOUtPQ2pFOVlrUThHSkJIVkxaclBBbDEvRzJydU9JUVRGeDY2?=
 =?utf-8?B?Q1FHdUdVY0pVZWNTcHI0TzBRVFpaVEx2dnpBNnJGVVpKUG5oY1N1S3gyWGFi?=
 =?utf-8?B?VDFSWjBkeTBaYW0xZFlmSUU1MDQ4ZVI3MGtBWUVQYkRaUTh3eFBUaUp0VEFJ?=
 =?utf-8?B?WWlIRmRnaXpzSEVBbVZHRGJjQ0syK08za3loS2NrUzg5RVNISUFaQnRWWHlG?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e41d6-7caa-4b4b-9585-08db472dd1f1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:43:52.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrs0btlT1E7TiY9iUR19L0I1hPsOdmVwYDnOIrlQrosU9Mm321i8WJ5At3uIkR1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4613
X-Proofpoint-GUID: OPfyUbi5NSWUWCThse9NNBHUNwXVjQ4V
X-Proofpoint-ORIG-GUID: OPfyUbi5NSWUWCThse9NNBHUNwXVjQ4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/23 5:03 AM, Xueming Feng wrote:
> When using `bpftool map dump` with map_of_maps, it is usually
> more convenient to show the inner map id instead of raw value.
> 
> We are changing the plain print behavior to show inner_map_id
> instead of hex value, this would help with quick look up of
> inner map with `bpftool map dump id <inner_map_id>`.
> To avoid disrupting scripted behavior, we will add a new
> `inner_map_id` field to json output instead of replacing value.
> 
> plain print:
> ```
> $ bpftool map dump id 138
> 
> Without Patch:
> key:
> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
> 27 16 06 00
> value:
> 8b 00 00 00
> Found 1 element
> 
> With Patch:
> key:
> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
> 27 16 06 00
> inner_map_id:
> 139
> Found 1 element
> ```
> 
> json print:
> ```
> $ bpftool -p map dump id 567
> 
> Without Patch:
> [{
>          "key": ["0xc0","0x00","0x02","0x05","0x27","0x16","0x06","0x00"
>          ],
>          "value": ["0x38","0x02","0x00","0x00"
>          ]
>      }
> ]
> 
> With Patch:
> [{
>          "key": ["0xc0","0x00","0x02","0x05","0x27","0x16","0x06","0x00"
>          ],
>          "value": ["0x38","0x02","0x00","0x00"
>          ],
>          "inner_map_id": 568
>      }
> ]
> ```
> 
> Signed-off-by: Xueming Feng <kuro@kuroa.me>

You can carry my Ack from v3 since there is no big changes.
Anyway, Ack again.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> 
> Changes in v4:
>   - Remove unnecessary parenthesis ('{}').
> 
> Changes in v3:
>   - In plain print, use printf() directly since inner map id is always a 32bit int.
>   - Remove unused print_uint() function.
>   - Rename `id` to `inner_map_id` in plain print output for clearness.
>   - Add a new `inner_map_id` field to json output.
>   - Add example output to commit message.
> 
> Changes in v2:
>   - Fix commit message grammar.
>   - Change `print_uint` to only print to stdout, make `arg` const,
>     and rename `n` to `arg_size`.
>   - Make `print_uint` able to take any size of argument up to `unsigned long`,
>     and print it as unsigned decimal.
> 
>   tools/bpf/bpftool/map.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index aaeb8939e137..ae9e822aa3fe 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -139,6 +139,9 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>   		print_hex_data_json(key, info->key_size);
>   		jsonw_name(json_wtr, "value");
>   		print_hex_data_json(value, info->value_size);
> +		if (map_is_map_of_maps(info->type))
> +			jsonw_uint_field(json_wtr, "inner_map_id",
> +					 *(unsigned int *)value);
>   		if (btf) {
>   			struct btf_dumper d = {
>   				.btf = btf,
> @@ -259,8 +262,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>   		}
>   
>   		if (info->value_size) {
> -			printf("value:%c", break_names ? '\n' : ' ');
> -			fprint_hex(stdout, value, info->value_size, " ");
> +			if (map_is_map_of_maps(info->type)) {
> +				printf("inner_map_id:%c", break_names ? '\n' : ' ');
> +				printf("%u ", *(unsigned int *)value);
> +			} else {
> +				printf("value:%c", break_names ? '\n' : ' ');
> +				fprint_hex(stdout, value, info->value_size, " ");
> +			}
>   		}
>   
>   		printf("\n");
