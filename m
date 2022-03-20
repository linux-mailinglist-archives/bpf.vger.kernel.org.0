Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB294E198F
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 04:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiCTDjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 23:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiCTDjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 23:39:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4770F7E
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 20:37:50 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22K2ccuj016671;
        Sat, 19 Mar 2022 20:37:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CaMIfaKf2n/HilQG1TUBCGAe3kixidIDlvBmrc4ezCc=;
 b=PK82vdEwFJdLnwYiXaiQ/mutYxA84XP1rm404uZKjPnrzVU9yWNTCQ6UyKc9et64o3d3
 4ghb2l9DSZIcWIs4Yoi6bS16nWkIQiZqe7MvDmjCX/JaFoqJQoFTL1EyOVgYygONKGNy
 IZhGqyQqCwJLCFQTsPkeDIQ9zWuzGJltWlo= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewags3fm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 20:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLkhOdNYuFjd0URzvf8ZYz6hqG+uhRRMn6NeBCsxITCwNI84/6wmsf1mzomR1gFROKP6GZzeht6CN7kTDA0g/STNPZQpUlC1k/7jmsGqPQjstKQQNe1mfNiwJnFKDZblVRFvFMtQaAHtZjrmGtL7s/4m/KFoeENAnG2bdguBrzce75CDkxtB8QodA75cRz9LHtkanNNpXsf1bzPLjP7Rj6tmLEXaWrNghy7ng6dtTTomTCCkQqUwv1BxXf0wJUs/4OOY1hm107GiMYoW2/o7UhcM32zeD+4OR7PKGWv2KH52WJFRbvsj1HS6N/9GQ54fpQlC/f7V78LD8z/5ibh+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaMIfaKf2n/HilQG1TUBCGAe3kixidIDlvBmrc4ezCc=;
 b=dCq/7OUJg6G4hBO5CVOzGO6G9IDJ3R/auaynNGVDIsTT7wugoX1rK0xBr6jxOu/gIFiXcFSAl1aWcXgvlfgQBDvWSJ8QBmKcW7E6dF5+zNlxnbzfUjUa2HGqw8yDECqlr/vLYy6xC8hUPsNfAIkpuedd8it9yfF4uC7Cw8YwC7FyIkl6+NMwAsXi1nSia879WOqtN7KBA/1ZdU4L0tHbojIZ//9JRErcLFXIrVDTQ2wyHCkdf4nVevkrIzeKfk0cWzJhVjy2dPS5XADcbXQmsnwlrfxKI2gzT3fCxQfLstd1/lpVp44TSluqHb4m3HtJhRQVf1DqMvGRbjWpY8SB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3686.namprd15.prod.outlook.com (2603:10b6:610:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 03:37:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 03:37:33 +0000
Message-ID: <3f326c74-f86d-abac-998b-427ff9c4bffa@fb.com>
Date:   Sat, 19 Mar 2022 20:37:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next] libbpf: avoid NULL deref when initializing map
 BTF info
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220320001911.3640917-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220320001911.3640917-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d031d232-981f-4c48-24ba-08da0a22f80d
X-MS-TrafficTypeDiagnostic: CH2PR15MB3686:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB3686B65C514612D75E9BA109D3159@CH2PR15MB3686.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zJcnZW3KPsV0/s7t4TQZKXhBU14atdqktx1Q/GkhiobeRuj1CPahJHybKkZAfKjjdrF/hF/vElvCh8goSRvj6afELHcvh/Les+XmbJA728jlWrJUpfCCJCncPG/Ueb/FWdqDqbtSQ0jX+PDqk4ToxhZkQVKwSb/qNn4cfhSEUqa+czd0AeLE35d5N80KB0WyE1Wu/16nEbTl9YEHQjjQ9X0CGuET5exTi1+wd4GpQCYUujgESiho4ZulJOuw1N6/nh1wUCsqOgMgWSkcNPYuuVXxhk0wjN4iA43GmuwrWzxMPaOfsxvvbgyG4RpoFxHEjv/MF1Yl4prIU0REo0X88gfQRzeWgFc63B8mnJ7EkCBRVpUbZBAeU9jEOXdM5PsOCbpvTtR0wNmXlyiBGnlXYg2eVy7PjrltA2ohiLfozoiixLho2KtFZwUYwXPJ4bZmb2Zg92HmePZ5s42z/GtJxKZI4sMP/lr4OFr7NRJ4Dyxm+S4bKfSse8ZPFXiZv/O8Fl9GpIy2B7On3aD+5j33uh21quipvZN2+bRuuZQDAtvuXKOAdzfwujMIuxE7jCRzxWbxpeR6iE/qxZWci4hFlJS/yYrR6GTKGk44jxYN5NmEI20dPQcoHHAuh12S7JnP9Dv7s7dFhthyBt+5wbwNWzOsv1wTTAiHuv0lm3c5EKivW7iM0dgas6YHqdJczCWTAy40Sry1169B1Ge2m/NQphf7hCll4/VNm2xiiXOYyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2906002)(508600001)(31696002)(83380400001)(66946007)(66556008)(4326008)(8676002)(66476007)(316002)(86362001)(38100700002)(8936002)(6666004)(186003)(36756003)(6512007)(2616005)(6506007)(31686004)(52116002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGU3V0xVRUhvVjFwalhXM3IyMFE1aXlWSm9mcU84MFZSMUs5Q0xwOTFDTkxZ?=
 =?utf-8?B?aHFEMHVjWFBNYW5seXVWN2hDditYMTBlUk9ubGNJRmJVQTVGcytVajJibE9I?=
 =?utf-8?B?Y2IxZTN2Q2U1K0NPS01nRG1xczZCZnpHSFlTYzE0THhYSjFZR3RCVTNVSXBw?=
 =?utf-8?B?dkg0M2FQVUhtYXZMWUg1M3lKUzVrTEFMS2RSL3ZkTXdCZFp5WTFPak5pbW54?=
 =?utf-8?B?dzFmRlR4K2l4a2VlTEd2VVdrUmZBWStORVI2cTZzQzFoQkhoNW04TEN4ZjJr?=
 =?utf-8?B?MElFUVlRUEJOT0FGeXpPVEoyc3FDbEFnMWNHRy9aSHVlRkZQaDR2ZVZpL1pM?=
 =?utf-8?B?Mkx6Y21xT3RyajNXeE5rRDRTdFA5dE9LcjUzZXZINHgzQ3ljZVk4QkI5SGZB?=
 =?utf-8?B?dXpXZ0N0K1NOakYraytGUDZ3YVhOZEJYT1IwQXZYMDdmdW9ldlZGT2lTWWJG?=
 =?utf-8?B?dWM2Vk53MUN6YVdpQzVoTzR5L0czMzdQb3JkczdLajNSR2FFNU9Ya1UrTGNH?=
 =?utf-8?B?MWw0ZXgwdlVncHgrZkM4dnQycXp0ZmdrYjAwaTc3VStQcEFkQVNqQ2RmOVNM?=
 =?utf-8?B?TnVoeDlFNWlIdWkxemIrazZITWZnM1VGTDYyUEQwZnFIV2krdk94RHQvN1h0?=
 =?utf-8?B?b1FlL1RZZ3Fvb01xQiswZXVVWFhwNHFNK0ErUE5ldEFuaVJDRktpN0VOenJO?=
 =?utf-8?B?OWF5MmpQSFMxeUJKME1RYlA3WTZrMk5ZazJLL1p1WWhUbUZxeFAyOFJSQnhq?=
 =?utf-8?B?bThWUW1STDNoWVlyR0dTZWxPTElva0NLb08vTGk1K0xxRDBkaTAvMUxtUlZZ?=
 =?utf-8?B?YURMaWhjYTFWZ0tEbzNYR2diNTFiKzk5SGRGTHlGSjdSTmRSWWk1dkhOSWRa?=
 =?utf-8?B?bHQ2U1A3SGFGUG9UMXp0VUhUNyt2TFlMNnVlK3hydldMZjFxODMrWWRxaE5v?=
 =?utf-8?B?ZXR0elIwb21QbXpLd1FuaVBmLzRISFZoM0F3UUMzZkdFVFRRVjhyS2tZUUwv?=
 =?utf-8?B?blAxdG4zVmZFRFhqSzhhQWYremE3bFF5THRMdVNEQUg1a1VpanhXK1lrVjk3?=
 =?utf-8?B?K2F3alY5dzg0SGp0TDlXOHdSbVNCZkIwM2FjdmxHWFdHRGQyd1ppVHpwVXB2?=
 =?utf-8?B?bEt0S3IyTjk5OW1wYjVZNjJwUUdLWDY0TE1NRzNSRFZxK0dhS0FUcmRMVmhy?=
 =?utf-8?B?TUFWeml5UzhHT05PRVBzczN3RXhQdzFsV1ZPcTNvK21tc2tYQW8zVzNnMG5F?=
 =?utf-8?B?T0JKNXFlNmE3Z3pmSHpBQmd3SUdGVjRQZjdDWVpVSFh4KzBRbU9sZEpsa1h5?=
 =?utf-8?B?eTRYODJ5NFlEK1FwZS9taDIyOVlVR1ppY2k3aDlqVGJvbHRwLzV6YlRORkFk?=
 =?utf-8?B?WjhYU3JwRWNMWEFMTlFCakEzT24ydk13ZEdkYXJzOFIyaXVPd2c2c0Z2TmZP?=
 =?utf-8?B?TjdDcHk2S09wUWM1YUNTWS9EMVBnaGhoWFlFRmNJbkNYNE44bEVJUUVMYUdI?=
 =?utf-8?B?L3krM3lVdzNmalBzVHpBRlFzTkVGeW9yb0RWZ2R1ck1vMlJHL0VCNHNNYnFn?=
 =?utf-8?B?bHNvb2JiT0tWb2o0eEJxOHRPWDE2TDVEU1Y1T0lyVDgyTnIwMXNHQWlOOUZH?=
 =?utf-8?B?dkR4MFR1RWJaVG9vck5MWDBqeE1DS1BaaFVjbHFua3JkT3U4R21JMUlQeDV3?=
 =?utf-8?B?TWpqTWJocEtpNXBhSUlsTUhSSEhwRzF5aTkreTVlMDBSek9WUmU5WjVraGNR?=
 =?utf-8?B?U1ZVS000ZFk1aWYwczBvL3EreEJvYVdZS1RMRzdHZGo1dWpNUEgzR3hQaDlP?=
 =?utf-8?B?UFN0azN3RWZDTHkwV1k0YURzYXBLVWxlQ2VFQ2J0ZFlMbDdIMEtUSTF5SGFi?=
 =?utf-8?B?b2pKZnRBNzlyTVN6M0E0WTVaK2s1MURRdnZHc21welFOSWRtZUFldE1sdnNz?=
 =?utf-8?Q?uh4WN3QbvZyOpsopHtZCiGPHLI1sb8S7?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d031d232-981f-4c48-24ba-08da0a22f80d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 03:37:33.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0ysi/bwRjxhCObpf3C7LN6BtkXZeHRx4S4/a64aD86P7SuUfQ7P6ZDzpmYPI/MH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3686
X-Proofpoint-ORIG-GUID: mmh1CNdQobIHmivqg3hkyNUFDSFeGBFL
X-Proofpoint-GUID: mmh1CNdQobIHmivqg3hkyNUFDSFeGBFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-20_01,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/19/22 5:19 PM, Andrii Nakryiko wrote:
> If BPF object doesn't have an BTF info, don't attempt to search for BTF
> types describing BPF map key or value layout.
> 
> Fixes: 262cfb74ffda ("libbpf: Init btf_{key,value}_type_id on internal map open")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

So without this patch, we may have segfault or other errors, right?
It would be good to specify that in the commit message.

The code change looks good to me.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/libbpf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7526419e59e0..2efe9431c1ba 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4197,6 +4197,9 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
>   	__u32 key_type_id = 0, value_type_id = 0;
>   	int ret;
>   
> +	if (!obj->btf)
> +		return -ENOENT;
> +
>   	/* if it's BTF-defined map, we don't need to search for type IDs.
>   	 * For struct_ops map, it does not need btf_key_type_id and
>   	 * btf_value_type_id.
