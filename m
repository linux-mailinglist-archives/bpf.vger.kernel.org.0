Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C46F0045
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjD0E6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD0E6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:58:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C783AB6;
        Wed, 26 Apr 2023 21:58:50 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLZE4Q003755;
        Wed, 26 Apr 2023 21:58:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=RSbS2gJpCxYo/z6jmS5Lc5MAKLSapYDUegFhDeY9LFg=;
 b=PGT1DN+Wzr6mXUKaEFzhq2zw2V+4r10wMsin+07OhCI3M9itiyKtC/BNmoK8Fx324Gnf
 lOsSFyongj7MDM5/I1tfrln7lg0Cc6dlfV6iPXvRSFjsZC3687bFkOg2cF5PZvInlj9p
 H60KJ0GqbxuB8vzpFcBLbFj9I0ei2DdhcsJvx0jAIl1DhgAYuy7oRSYxa3h4wK6RdtuE
 vI79XOz0PROml3M2MryOVEh/l2LG3ZYWv3mLopAW0HZPRRMLS+HvvWNW8omg5sqCLa7z
 1o2LmuQiWyI76OYlQCkWcRWD2F1xE96+hJmKo47XSNr7VkM3f3sTmbyWDIOx0+RTSS8d uQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7av52gaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 21:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jim26ZqDfaSHy8xuHatjHqqXyZHNeY1dhCTTXJGHMiEMxm7CPZ7XTPDs1cs47bY/ATpdJZgTethBtKaGuPR/YV5YPiaO3zb90KRsibDURxhasNTxIFMpSdtoSZ0aNGEqTPkVhd2WUOfGkmKcq/9MM6wafGFtsRCavvb2bZjRkzkVYhsAD8cwPo0+tBl0Rtaptuun0ZByEIC03GprGtzxQ8bke64LUiJPcjZgi6iL0stJ/V6sstdJbSRveoEIMpBrbBESyeA5GF1EUpPjrV/8SCai8JKvlWyOFaFKNfDmmyWgQJ/mgqTM24PHYqhT2ciiKgUZCiwNu6n+as9m4bMyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSbS2gJpCxYo/z6jmS5Lc5MAKLSapYDUegFhDeY9LFg=;
 b=cGfKLTCkor5Ciz6np83XTjBdxZSWW8M69xlBY2e8AQaYrIrTfsa98+RnkqBeLMhVgTxNyzG4FtBYgo11VsGdwWP2QQUylA8pxV/7NT1EU3Rc127Fx0yrG93dfRVdARAcmOYmPvdzGsGqZOr1yOVFwUElsqKUnaaUBomJaLGohlrSXVMxupod4w4EzRC6stkI3IRYAU0njOPRcci2wrWzfre35cSKwtcRE1h+ktmlOsjo4QX6kIteX8knQKTGWK8tHF5J29S2+oV5bSpXchcjcX0hwgyA4ssqFclYGqIZb6yZ0SOisgk4OjQ2dagzfBwy6W+owFMWsrJXFfbaJe3iww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5823.namprd15.prod.outlook.com (2603:10b6:a03:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 04:58:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 04:58:21 +0000
Message-ID: <9c49d2a7-0729-6ed3-2e09-6d07f3eda04b@meta.com>
Date:   Wed, 26 Apr 2023 21:58:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v3] bpftool: Dump map id instead of value for
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
References: <20230427041949.93752-1-kuro@kuroa.me>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230427041949.93752-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 302efdcd-0fba-4a99-0422-08db46dc0637
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8W5hl2p1KU8c/aZgn6gqsKZfaa4LL0GkAM+nSzOg3Jr8du8f+2ukYgztXZyEPa858CNweV4G3Inko2baeFby0jpHHMfGdMGgfa8kTBGLAqy0ekR4VCEzACA7X2WTrdSk2AdkDv+X2A2dxPSdUMBN/ZX5hmiT9rxlegyK/vEFx21MBavaknm2g8h+BL0WBeTohh8oPzcvQKRiIQiG+175zRhq7ncgOcWWlXL4rhtqPtEkt5Dd+S0mWx3viekFX31g+sU0+3BPxUKKXRbeAMZJucHiM4c1JSYpz3ZH64P4bhsvxFzAy8EmSYg97FqkYFhi+DxHAJ2PYAvlFKS2Sd9nmAwwba70Ry3N0eycqJf4zEqIinAyaph9NFpChIkmEvqhZH82KfdfBbpu0WmAxGU2WhncFcA9EvCTgdS5/we6exGXeFMBTtP8/Ju+YM+MoXNes7jxCMNfQr9Zrxd2DZBnVdIeohM2OTweda4S5pZv/vGfmjK03QL9KMrYNe4xkG79FU9L6iMDuVuaCH7aiE3QuX/Ug7Uk0210faeuI8IeroOS8K+fbRW7s4+HHjh2KGOJ1OKD5UYnw4D3MNgxUuYvetGAcllSEVCXPLsaCVjnB3xLfwC9q0/PrjyijNUqOdMB5QC+lDQh/SeOeOeXW3Jdmxwf7/Ss0//h8E18vCp3cXurjpQBDpOcSCBVhp4Me3P/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(36756003)(110136005)(8676002)(8936002)(54906003)(478600001)(66946007)(66476007)(4326008)(7416002)(66556008)(316002)(41300700001)(2906002)(38100700002)(186003)(86362001)(5660300002)(2616005)(6506007)(31686004)(6512007)(53546011)(31696002)(6666004)(6486002)(83380400001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhISlJJSVMzOE52VlpROFZRYmNGRlJzMEk1REFoa2g1SENiaTRLc01rbU9l?=
 =?utf-8?B?cDY3dEc4OGdaNWZkak1iTGY3WXlyYTY3V01mYlhVekdFOUx2bEsvY2h2ME9J?=
 =?utf-8?B?NDRPRHkzWHlQajQrdUhHZVIyVXdCRU04OHRwZzlRNnZYTWdGRy9NQTF1N3dL?=
 =?utf-8?B?eUtZbnliaGxERm8vTGRCN3BQUEh1emIvdDRWOHR3Q2VPeVRTS000MlRONEJr?=
 =?utf-8?B?WHY4Mjc5ci9wSStkZ1I5QzdkQ3I4c0k0NjBZVldTWVdQOU9UQW5zdWVUaTd1?=
 =?utf-8?B?RmUrZzV0UUpHaEFwT2N5WXczZGNFREwwUVlCMEd5bUh1K1dEMWxmaVlKeFhr?=
 =?utf-8?B?NWVZRVdyRkEvUWlxbFA3NGZBU0gzVi9jVnlpTDdSaGdvanFBMmIwYVBNNUFR?=
 =?utf-8?B?dkh4NWhsQWdCcnhBVVM1WUVXcHBIamtTOUJETWlCKzZpa01COXRBUDhnOUpl?=
 =?utf-8?B?QnB0SGErRFMwYlZHcFZ6OWw3eGVRbExQZ3luU3o4Uk82bjdDSDEvN0dRdEpi?=
 =?utf-8?B?MnRLN0RHdFBEWEtac0tvdjVWcDlQRUhleWJNWGhaVnFDWjVtOVNTMlRsaXNt?=
 =?utf-8?B?WlR4VHRrWTFvak1aSHMxWmIrOFV5N1pOUXJVS1RNZXpuNHRsU21nTWhIQXNW?=
 =?utf-8?B?akRzWTFFU3VoK3gzN3czQ0l3ZzFVOTQySVBpekxnVEF4RTJaSFhpL0FYZUxh?=
 =?utf-8?B?dXJjL2dNQkJ0WS9yaVhpaWlHT0tCNnRaa1J6eWFVdXJaSGhURytmUHlhRWc4?=
 =?utf-8?B?OGljckJQZEdqYjJad1g4SHlzQ3RNWkp3WkVZb1NEdTFqb3dQdzZJdlh3TmM4?=
 =?utf-8?B?UVFJTVZiblBZWDhuam1USDYxUk1iVTczaU1sS2YrZzcxZ1RoU3hDa1FQOVpG?=
 =?utf-8?B?RklOMHMrdzhwTnU0MEV0d2Y2NGcrWTdXaTZ2cFBNY295U0NEdnlmVEI2U3N6?=
 =?utf-8?B?Z0xGOVZTZER0OWEyeWVGVVplVTdaRnN2U08zN0l6RFlDa1paN3B2cjhWeDVG?=
 =?utf-8?B?TGdoTkxPWGxnTjdrazgzNVhDYlpoVjZuYmtlTFBKNk0vZmZmSHFPZHFyMlB6?=
 =?utf-8?B?YjdXcDBiMGdlNVYvSjZxbExSOGJjMm1xWXFkekpCejJoYnNseVdPclNnc2tU?=
 =?utf-8?B?ci9Hd3c2WEVaUGNjUWMxaU9keEhzR1g5ZTU4QnJyWTEzU0VqYStOQnRDK2Jq?=
 =?utf-8?B?Q2dKNi9DY3djSU9WSnZlNjZzbDczdGQvVms5UGVGQSs0UjErTUdWRVN4and2?=
 =?utf-8?B?U2h0ZzZYQzRoS2duT0s5ZndNMjkwckg0RFB1RVpaR2dhTm1LUlllRitsVmE2?=
 =?utf-8?B?Y3ZNUWpuYjlXVjdmK1IzL25UTDQvMWppcVJFSkpUcEpZdlhFMUNkUWZKM09Z?=
 =?utf-8?B?QXhrV1dNbnpBYW9YTGx6REQydkpPaTRDK2RGSkgzRkcrZXZGRjJ1dG43N3ZV?=
 =?utf-8?B?NDBJUGJVajNHVzhjWVl0TzQ5TDlacnpxUDQvRHh1ZlNQOWRRaTc3WDdCQlJL?=
 =?utf-8?B?TVR1eUdCTXZoWXNCanBpR1RGdFIyS1FTWkZsaWVlU0RXSEw5QUNQMXM4WndG?=
 =?utf-8?B?K0dDUW95bU9DcHJZU2QxQzhJbmg0d2R0czRUeDRMeDVqcVBrWWpPanNLdFJB?=
 =?utf-8?B?dWg0clZhODdBUmdERDlsNzJzMUVYb2IzVEFncXJjUUZKdE5pZDgzZjhIb3VS?=
 =?utf-8?B?d0hvaEI3OU5SOGI2c0lFMW1sWWl3M0FieXhYZDBpMmVMMEhEb1B1QTdoQmVZ?=
 =?utf-8?B?Qys1WTNpQnB5cTdqbzlnL3ppbEtiYU90ZE5vTjlScUoyaUdEUVNmaHljTlZ4?=
 =?utf-8?B?NUpJYTcyN3praHYwWTJHVWtqS2lGYkxndlc2ekRYQ0ozalpKcmxCMnorc0Ey?=
 =?utf-8?B?UmZacXdaMnpmaUJScXRFYm0xb3RRTE5RRGxNVUZDVll4Zmp2ZGIwZ2Q3bW5h?=
 =?utf-8?B?QUNBcjNnQkE0dVNPZDdHNXJkYWZGY0NzT3JwTHlSUTQwa2RHaEE3ei9QS0Fj?=
 =?utf-8?B?eWV1WWp6SW0wa0oycjlkR09Ya0hFUUxTWEZZVitWLzk0T3ZYbTQ1L0V5aC84?=
 =?utf-8?B?Vmc4K2lXbU9xQWtpRDdsSE5EVTRrcmVma3lWeHhTNWFpNG1qL1g3UGxVRHpp?=
 =?utf-8?B?ZzgwU2w3dU91Mnh6a1JCelZYVnNuQmJaS0NIenRRRDY2QlJDNTlEa3M1Q0kv?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302efdcd-0fba-4a99-0422-08db46dc0637
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 04:58:21.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hKHmsp2tM4lHaQYJSQHzFbopsZHqzQ8qin8begXXUA+cIhKr+gLoRdanCjZk+Pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5823
X-Proofpoint-ORIG-GUID: XLmZW8DGfN2eyWqPGcpk5nwaEgl9TQo-
X-Proofpoint-GUID: XLmZW8DGfN2eyWqPGcpk5nwaEgl9TQo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_03,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 9:19 PM, Xueming Feng wrote:
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

Ack with a small nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
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
> Sorry for taking this long, my compiling machine is acting weird. And thanks for
> the reviews and suggestions!
> 
>   tools/bpf/bpftool/map.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index aaeb8939e137..afcd8455db74 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -139,6 +139,10 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>   		print_hex_data_json(key, info->key_size);
>   		jsonw_name(json_wtr, "value");
>   		print_hex_data_json(value, info->value_size);
> +		if (map_is_map_of_maps(info->type)) {
> +			jsonw_uint_field(json_wtr, "inner_map_id",
> +					 *(unsigned int *)value);
> +		}

There is only statement under 'if' condition. The above
parenthesis ('{}') is not needed.

>   		if (btf) {
>   			struct btf_dumper d = {
>   				.btf = btf,
> @@ -259,8 +263,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
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
