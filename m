Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECED63993B
	for <lists+bpf@lfdr.de>; Sun, 27 Nov 2022 04:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiK0DVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 22:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiK0DVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 22:21:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C961111441
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 19:21:35 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AR3L7P7026937;
        Sat, 26 Nov 2022 19:21:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=V+12CArCOxfOiiCtvEi+tmmBN8s2ysLAQSZ6kZ6AnIc=;
 b=Zvpev2MmgYYpSzeySEcdWqycikuTh/RS0tEvhajq1qUswGyxOGbF59UgnPSDG7dioc+q
 7gjnHsLbhUV4VIEMdZ6dcZsTYiByiiWI6+8MOYo4cJN9/4d/z0sUqTM21vOnn/h568zm
 ILhMfai5hyGcVp/lFMji0uFvf2CUc/q981KYSOX29mY6C074Ogj9bL6IhDX5RpyE7JiH
 xxKfxhD5A9OSHH4UpHN0RRp5CGnR9TV6es1AoL6TRBEqpEZ9hwY35vUNDE/PNGCapHto
 cpnJqpfY1ev4H1GqpbmtaF0+YTFNv+NnSU53LzR/R5xWj2rWbYAvG58mbZorfNMcrDD9 7g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3gsymnuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Nov 2022 19:21:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4TRtjofTmJudvPCF2o1SWs5FPN5P62JWndfd4yson6Tw1uvV1U3MCUcxGhfxfpmB63lgDfltjnAA/Jps6Bw6M6PqKfbYJ0J4GGbCPZDHAwR9/I0cgLiYnzgKvPHNl35sVIRrwCl+R02Ihh+mnIZQ6w1Y8BD5zRssk7UJncR2g98tXorgYSDCp+MUXR0NITH0C/60uz3OJqboH2YxswdQ1o72FtiE9L0uprdxvvfDEo3fW/Eh42PHCfhBXx5RO5MYogWNyPUkX7WNXz1E6f+erUzTw1mhZ/jFiWwKnxcvBnEoY3mrKOELEz5P8toLQRXvflRYuH+IBtr5LDHY5Vobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+12CArCOxfOiiCtvEi+tmmBN8s2ysLAQSZ6kZ6AnIc=;
 b=EeWP8fuF/qWMyixW50uKt9poopK1nYym8z61zxQBCc6rwZ3uyoLtt8b2n7jdepedtqAgVJcKdfShdW2KOvgMtNtHT5X02CLx8e/lpH0d+Dx9sKrqmd0R2XjMxjL5n7Cihgrcy2Gws+zl7mZhSZ/VkMSf/TrnimTiVkBk7tw0a5g4Oabrk+PBAgCaJaybg0kHG8SArsPvBx1HIawE7pQeI/Jx6vgFJoPOtZJZb4I4LEvOEj19lAf+1zy/w9butEpAN3g0CFIw2sygLyP4g2Y96/m02m6FVJgv2ZO6xJPcRvPrXgShWf9v0qaX+Dok8Tk7stLfVY85GM/Lx9rFxVhpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4736.namprd15.prod.outlook.com (2603:10b6:510:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sun, 27 Nov
 2022 03:21:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.019; Sun, 27 Nov 2022
 03:21:08 +0000
Message-ID: <ca360165-2473-abaf-40ba-cc54345f74ec@meta.com>
Date:   Sat, 26 Nov 2022 19:21:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com, toke@redhat.com
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221126105351.2578782-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f295795-1833-4383-58fa-08dad0266d36
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlLshJbxe7TKHOj3g0xSjqhIlfYomDB1PpMhApxFuU1exBk/l1NEybB9CBmWfD/BdVJVwhhydwdalNEV1R7GP98IhSRieG+s1sdP6oYfkv7RAp1VIUKTrOQYdxWuCfPZwLQjiBvYRH1N27IW2wEEYCKhBOnhKVfVcMEdDWGryd3L/hvVNzgAAFFNTI2xaRFMaeLfhElDeJWyY7Aar7oeAKYitPPyW8xBkg3wskrBTE3kexQIgAULY/9lrjPznbL84TfuEnZoAT9q/9IhVCXaEZ8JO8qJauaZHHZXcvWdk8SZVHmISzsGdV2dJPswN6HaYeauDxPhZv8N7UqQAPD/OI/NKiTnvp8gq2xXnlw3WOzQCR6NEGwdMSMPvwhYBlG1N6LKF/vHpJ10XHeATpiAnHFzg01D6Qen8vzRXVRFjSQr/1R5LTOxd7hO/pPUul904tELzI3Pb3mJtlZEJ+lp1z717DvRpY1UiGBnqgWXGGa9qGJnMgmRFeSjlPs0Ehu/80CL5PaROT+FyNIqA8VxxDKJxE/CGQ2oszRx7cv5L4O9R+oi1a/SSO9Cgwe8uI1HlX04fQoPCTG+dBlwc2K2KPEFEPfzJ/VcM2BRRlWkoBWmaT2lJFohNShM2/vSa1BQK4SNU6mk6oRk0zP/i/Q3LGntbHsy5DmWDca06pY/v+H/+aVwPtsiZU9OKTXRKyWc9BeUToZetO//ubdlJ2cZ3B/VrB3ggGoqM0+WPtrNp/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(36756003)(186003)(66946007)(41300700001)(8936002)(4326008)(66476007)(53546011)(6512007)(66556008)(6666004)(8676002)(478600001)(2616005)(6486002)(31696002)(6506007)(86362001)(83380400001)(2906002)(31686004)(316002)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RMTFpHZ05qaGd4bWhlZWhqekN2SkZPNytGWDB0SU1Fa291VlZFREszcjIw?=
 =?utf-8?B?Q0pZMGhibUh1SkQ2b2NNSGNYSUtVWnZFMlRqUDhBOEw1UlVmWFJXRTV6OEh0?=
 =?utf-8?B?cWlmaWd3WEx0QnZsN3MwcVV2czltT3Q4akVkN1VRZ1BEL2ZDeVNIbThLTXBT?=
 =?utf-8?B?RUM1WXY1aWM1R2J0cUZmeFlkbWdTSVA3b2Z3MlJ1NXFmeWVEWFNYVDQ0cEh3?=
 =?utf-8?B?V01uUEZzaUNic2FhemNYNDRZaEV1QjR2RU5EUituTjBFYXdHcHd0cWRVcDlt?=
 =?utf-8?B?WGxVZnZmanFBNUIvbWRtR3RxQmFHRWdpQWRmMFBYbFdja0tNeFd6MnJkdlF0?=
 =?utf-8?B?U0Jqays5N0IvNjhtQ3FJaEpXT2lsejBNKzFpcjREbEFxOXBhRFR1YWFNSzBv?=
 =?utf-8?B?MFJ5UXdYbGdzNlNwampyQ0FwOEpPWWZpQnI0U2pOVHJ4OGxBYW1tN3JyZ3hI?=
 =?utf-8?B?MXkrUlhGNEx5cTUxb1BqWktJMHpoS3ZEQ0hmbnl1M0ZyUW9uZWQ4U0QzZlV6?=
 =?utf-8?B?NHNRNzRlNG9uS0N1UHRhTnp1NmQ2U3hCYTRxRjFrWWU4U0M1WnI4cEFNZVJF?=
 =?utf-8?B?SkZTWWdWOGdYMkJyc2MxYStEeGFLUGFXbm1KTnlXaklzNmRqazlNY2wrMWIw?=
 =?utf-8?B?ek9XYWszekFUOVh1akRaMUcyalRRTVNuRTgrcXV3Tnk2SnN3YnpXOU5hcy9W?=
 =?utf-8?B?cklKeTBWZUtzR2FmN3NBQk9aL2ZvL09oeTl1NkFXbXE2Y1Y5NzJYWnk4VzA0?=
 =?utf-8?B?YXFTRkY2TlFLa1VDN3diZlhzeG5MZHdWQitSbnk0NU5ReGhrWHJiQjZjanJ6?=
 =?utf-8?B?VGFEZUtBUVVsZHZsdjEvQ1BzUmJieit5OU8rRTdLbTFVT3hXL2wyRis5ankx?=
 =?utf-8?B?eHdzZWFXQ1dIQ2tFQXNzenV5dGNUK3MyS1M5TlFNc2ZJdnlNM25aNkF2T2p1?=
 =?utf-8?B?M2F6Q3d2anU2YmpqeDZSYWNxVlRldzZLdEdwTmRwMmVuVmoxU2gvQ0EvOTFR?=
 =?utf-8?B?N0s1Mzc3RjhTL2x3NjJWVG8wdE1OZXd5SHNrK01VN1R5bjVhRVlRbVcrY3hh?=
 =?utf-8?B?NkM3dlRZVHkzMXJvbWJjMXJLTlVYeXpjZUlEZFN3QUJ0RDQvSGovcU9BL2M2?=
 =?utf-8?B?elJicU1JYUVjUitweXBJUVM3cnZQSHJWZGV1WGpiN1drSWM0cGRWcW9vRi9D?=
 =?utf-8?B?YWhleVV5QWQyeWZOZHNheEJmVWM4M3YxLzBGWUtLUzlNN1c5U01iakpoZTlI?=
 =?utf-8?B?cXc3ekhNL0NkNk5Rd2RZODEzSnplSm9weVZiSVlNWWZUcW5jQWhoWEdyTmpG?=
 =?utf-8?B?OU91bXhXVG5nV0hhOUMybGhMNUJSN2RxZkVWZHVIaWNLYjBrbzExNGZialBI?=
 =?utf-8?B?YzVJRVQ0eHp1dDJoaEdCalhEQ3pYVGVHZEZqMDh3bDBrSENVRFdma3l2SDYx?=
 =?utf-8?B?QjZkZkpRYUR6Rk5PcEhqSktRckRMTU9zcGYzd3hoOFhJVjRjV0UvTFhCc2Zl?=
 =?utf-8?B?K3FubTIwUnFlVlFJOWF6SFdwcDNWdi9rRGpNYjJBaEZZbU05UG5sUi9xaG9X?=
 =?utf-8?B?eVhPQnNZS2NiY3k1UWJWU09FbmFDbE9sUng1ZElFaStjWVVSRG8ySUVrVkl0?=
 =?utf-8?B?b0hHekt5ZjZUNSt5Z20wcEdQcW01cGRqdFNDUEdRYTNSZnE5SVA1NzZ2Q3dQ?=
 =?utf-8?B?UDNUeHhIeHp5MGxRV3JOS1ZDUjBDNGxoN0cwMEI1STRDV1JRT1hzQy9QZFNT?=
 =?utf-8?B?Mnp4K0NtajBjV0VIY1Y4aGNJa2Q3TmlOV0dlaEZ0Qlp4dHgrRW81YTh4bDhC?=
 =?utf-8?B?Z0lKMlNIOEVKNTFWelArRXRFTmg1QlduWFZSWlVtRm9aUC9CbytIVWp1YmRq?=
 =?utf-8?B?YktsTi8wOHR0UFpPL0IzbC9xSnhYYzIvNnNxalVOaFpGOW1PQnNQRHFzYzBX?=
 =?utf-8?B?b3BXSWJCYVJHWFpuUUlncG9wcVhDeTdTb3ZZcm9GSUttU0JEL0t3VWppMGhN?=
 =?utf-8?B?bjlDYmFZelhKdDVxMFdXSXk1bEZvYjFPVzhaeXZxZi9scjErNXdsTlJiV0dI?=
 =?utf-8?B?RVFwa3Uva1MxQXpaU3dGVTJYOEl1QW5oTEhNVlVZcEZCblBGKy9wZTc0QnQ2?=
 =?utf-8?B?UEZhRTcvWXJuR3dsVzNFYmFKRDBpeW5NL1ZmZDBXaU1xeXN6R2lvTUptYkNX?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f295795-1833-4383-58fa-08dad0266d36
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 03:21:08.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRn/2+xTQTQ8mnxKvTyPcHcUH1KodHilJMHdiYsFZ9HVNWvKj1uPS7sc+y+1Igv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4736
X-Proofpoint-GUID: 2HyzPrah348u3FRtLv0V1UpsrIrTk4b1
X-Proofpoint-ORIG-GUID: 2HyzPrah348u3FRtLv0V1UpsrIrTk4b1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_16,2022-11-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/26/22 2:53 AM, Hengqi Chen wrote:
> The timer_off value could be -EINVAL or -ENOENT when map value of
> inner map is struct and contains no bpf_timer. The EINVAL case happens
> when the map is created without BTF key/value info, map->timer_off
> is set to -EINVAL in map_create(). The ENOENT case happens when
> the map is created with BTF key/value info (e.g. from BPF skeleton),
> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
> In bpf_map_meta_equal(), we expect timer_off to be equal even if
> map value does not contains bpf_timer. This rejects map_in_map created
> with BTF key/value info to be updated using inner map without BTF
> key/value info in case inner map value is struct. This commit lifts
> such restriction.
> 
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   kernel/bpf/map_in_map.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 135205d0d560..0840872de486 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -80,11 +80,18 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
>   bool bpf_map_meta_equal(const struct bpf_map *meta0,
>   			const struct bpf_map *meta1)
>   {
> +	bool timer_off_equal;
> +
> +	if (!map_value_has_timer(meta0) && !map_value_has_timer(meta1))
> +		timer_off_equal = true;
> +	else
> +		timer_off_equal = meta0->timer_off == meta1->timer_off;
> +

Is it possible we assign -1 to meta->timer_off directly instead of
-EINVAL or -ENOENT, to indicate it does not exist? This will make
this and possible other future timer_off comparison much easier?

>   	/* No need to compare ops because it is covered by map_type */
>   	return meta0->map_type == meta1->map_type &&
>   		meta0->key_size == meta1->key_size &&
>   		meta0->value_size == meta1->value_size &&
> -		meta0->timer_off == meta1->timer_off &&
> +		timer_off_equal &&
>   		meta0->map_flags == meta1->map_flags &&
>   		bpf_map_equal_kptr_off_tab(meta0, meta1);
>   }
> --
> 2.34.1
