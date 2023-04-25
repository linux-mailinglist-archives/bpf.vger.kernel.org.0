Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3F6EDA19
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 03:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDYB5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 21:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjDYB5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 21:57:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825DAD29
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 18:57:13 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OJjsLY001186;
        Mon, 24 Apr 2023 18:56:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HMCtoITj+w5abXsJRPYES8jl8DiUV4OHoi8RnEKZvds=;
 b=kotPTp11fJLq3Wwri5DWscuhMCCXojx72g/ZD8EWayISDDiiDfzfaurmGU0dsZSvSSUJ
 t5JQ/yCXHzSXKmxYlRhRCQWwCvnQVSmk4aMkdKaNS/+zfPAEarl3oDkP5mIhkxvAFh/h
 uH+nAeY1+6/Y5J/gPnEhia9wp2Vw+yTshvwsQ9sJNmEy42A1FhPtuIZru+OePLGxIZSY
 OVWH7mhl+dzCdXwgzvpsoc1zQhk8gooFXP4PqDcClVoEXFYYRFesyjVZQrJJWpW83tCc
 U5LTsAESpMjxiRWVrnIqcu9C62XsMVABM14Cj7I2B3DeZRPqkc/Y4FHYJGbiwVtn16hm 4Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q4ew8nx4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OagWjoC7Dh+un/jSfuo4mffJmLbrsgkms2W3fI91RT6eL+8u5j7l0FTkeEIZY5ZF98EuxLlrKL1G+Gb7oLv5zXhkeSE0uBWNFjlnTy1hFhr3wCcDpv3kBDPmobXTBlLy9L5lyvua2YUTj3uRwyeYrvZuZutCP4YuwxK7hbKObv38eW1MVzChfdIRZgrsXF+U1Fps27+qNGDQrFIIEvukiDhWFmRN9VK9dkMYSPYIGWyl9AGPF3/AUmXc91pe0+HQeUH26WWkWge16dhuWcRj1IC4lfJLfeGGUQYtN42ipTlaEp4GewM7yvsEQcNw+bJJiQPQEcIvYxklEmPXjg8P4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMCtoITj+w5abXsJRPYES8jl8DiUV4OHoi8RnEKZvds=;
 b=OaIVQB9wRCbN5hxnHg1qmXnURHlZMYv8TMvP64/scq7ESrY3rewNAe+JKOUWWKwn+FyiDnBcCtN1OHrMsaCEgAb08FojbuSg6WcKoIkBafJo62z1IPebGjWkCip3iOufB9r1M6x6G/9JIj1BJMxqPD6ld6379DR8FMKxSZ+8Ql/rYVKPBbWsN2EOFAW6GnMFyw7KdZra3PdlzfvMCTkInKwcEus9ftsulyn7Tw9SewKG3rgYP5ToU56+RfDD8yDPcHg2ES+kwsSBYIGF3w4rtJuhQIEpXro/35c0ebhJghIJX6GDicHsJxA1AREZt8C1YGCLFzHxBeHXLKLN34wy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4439.namprd15.prod.outlook.com (2603:10b6:a03:374::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 01:56:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 01:56:52 +0000
Message-ID: <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
Date:   Mon, 24 Apr 2023 18:56:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Peng Wei <pengweiprc@google.com>
References: <20230425000144.3125269-1-sdf@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230425000144.3125269-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c706d2-19ef-471f-22fb-08db4530571b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvh7FJ/h4ula0TdE2eNeB0d1r8azEqu/52DvTKdxn954yY43liMIbOYaBAlF8M3FXZxexnjkKxkGaCZEClVxLXVoINnxQZP4DqgnsqRlCj6SvPXjfDFh7yVZt5VXOWOydBhrlVga6FPycjSlloC3fzpYLfKatRSsitsjsMk62dhuo41gFTb9zFGcEFDu48erj2XiPrBMnmlpZqbDySUFANZ1b4GZQcEmOeH3x1t51B5xBWf74nEy9ouGofe3FK+g2/NWgZzhxEdAJVu8m/jovNqfN6U3crkSL0Ji2zio26ZVUkBAlrsmgd+HZEg0bpBKr+LyWC9Ray9uuP8RCA/uh7P0YBoLbbgRsDMugtPc1Y+RQl5xxNCQpv864tALLzdEOjRUHi3eq1upUC3Bx6gkI+g0Q8OLyZDfFHic10KZLhjmgO9whYB8qusXe2KdThrafBuO9o5779PDRdL6EoWH1Nylz9fTVSQD0/c8WL3Oxe0JpzceBn396WYjx4Qb2+EBgOKECQLwIk1ZtVkCPu6yeckuvczIy62//8V2cHbLZXYU5RdfMAvvVTNGOjHaOgZ5WSTCRGjzA8WGXGiVYaKR1XcIBu3IABvgIRxml/WvvONHjrF5f16VEOSlNpae1qa58rNH0dssGJzO3KAGJPLAFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(2906002)(41300700001)(5660300002)(7416002)(38100700002)(8676002)(8936002)(36756003)(31696002)(6486002)(86362001)(6666004)(6506007)(6512007)(478600001)(2616005)(31686004)(83380400001)(186003)(53546011)(4326008)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REczRlBieE9ycUR6cndLRUM5UG1obXZmU1BlTkRtRGNRS0tiaTdvc0l2Vmhn?=
 =?utf-8?B?bXFOcUU1MkhsUXB1VmRjMUVJTXhDSTUvSlBLMmU1VTEweXVkQmtFaWpSWkJu?=
 =?utf-8?B?UDVGM0hMc3VkblYvbWs1dHBvUDR1UXZjU1QrbFdIWldUczhjLytUcXlFSGJn?=
 =?utf-8?B?Z1BrRmRKenNvblh5eENoOHZpZUUxQWVGNERtL1ZsRExJK2hFbk1JWkJ5bTk1?=
 =?utf-8?B?bFhDNnRjMytDYTNGVjZkL3VlNFo3dlBIYWdPN3FheWlxbWZKYXJsOEdDYTNN?=
 =?utf-8?B?dGE1VDlLNDV1UFN5YUt2MXpjS3FBREJNRHhqTUd3ZTRXVTFvMTNKUzhIYWxt?=
 =?utf-8?B?UEovdVFoL1NVM0JGRFZoNmJvNk9sNm52bUJHSURwcDRBR2pmSDhkS3l1dTcr?=
 =?utf-8?B?TGFkWkFib0YwOHVnNUVRZ3krdW14Zm5vV2IzdU84b0twbUhaWllMcWJZaFdo?=
 =?utf-8?B?MWl3L2lFZXVpa0RobEVlY0trZkplTEFsTmMvWEw4cGRoL0xxWEVDUWw4TSt4?=
 =?utf-8?B?YTJlOUFVTUF3R3NiSmFpWFRjQUZrYW1oNEZRSDU5L1R0cnlCZlpGTzlKYjdZ?=
 =?utf-8?B?cUU3bnY3MWNVeGFoRHAxWjNNTUNsNVlTK3hFaXJDZHJYWmxiVGk5RGJhdU1K?=
 =?utf-8?B?UGl5RXRWeDJJTkdBTWVMY0h3UUlVRWI1VENrYVNpUDY2MjBNQ0N2emxHTTFU?=
 =?utf-8?B?UDZZbkgxRHhpVmw1dTJqRmtENGRpZ05IN0Q2KzVuWE0zSGdPYmVvSitYRWJ3?=
 =?utf-8?B?UUlvR3FDeVl3eUo4Y1IxQ0ozRVFTUGdBOVpRbjlLeDdLYnRJbk9Ca1E5NzFQ?=
 =?utf-8?B?K0w4aHZqOTJMdHFpRXFwSVJlc1lkSWp3RWMvS2d5eXZDMkdyUWxGY05qVTh6?=
 =?utf-8?B?L2hzbTB3ZG5MVGVyaHoxeEFmVXVjejZYV2daZlF5NHNQWWF1L1ZvRlFUMkNt?=
 =?utf-8?B?NW5GeWRRMDNyOWlpTm1pczdMUDgwV0xZWURMd3NBWDM3UnowVE5HUk5RZ2Ex?=
 =?utf-8?B?L0hTUmxnVGl1VmhnTHZMd0EycmxneStjS1A2Q2IyUUxpWTF6QjNnTUplQmp0?=
 =?utf-8?B?bEhscTZsMlkrd1pNeWRGRSsrM1NCbFdmQTB3WHlZQkExeWx4OVBwK2Z6TzVo?=
 =?utf-8?B?djlUbGxNRHBDV2NWQ0tKZ2x1MmFuczdBUmliQlc0NEtQMndhdGNMaTlOa09N?=
 =?utf-8?B?MVpNSVQ4YTdhVm5aTTVzUnVNOWIrZ0h2QURxaWhrbnRxZHJ0WVJrVUF4Y0hm?=
 =?utf-8?B?aDFtSit3RWUvTXBTK0dwa0RtWFY2dUZKd01uT3JhZWtWYWo4N2hzbUpDTzIw?=
 =?utf-8?B?UnFpSWcxekY4NHpjWEdoRUtFMUVXTHN2NnIyeGxjTFdvcTNVMlJPaUJFUXlr?=
 =?utf-8?B?bWFPQjAvT0FETk5wSWR4ZGt6aTIwWEF0NEEwWTVidVlaNHdSWmJwamovMUlK?=
 =?utf-8?B?bVdzci9WUHRQL2dTUGgzY0xCSjFpQlBHU0NQbWl6cGVqK0xnY1Bab2M0TTNT?=
 =?utf-8?B?S2d2M3h6S21wMVEzS29DL0ovUGFFdlJSYXFOZGJEeXlCS0F1NUdYVmdncFcx?=
 =?utf-8?B?b2NnWmgrSi80SDQvOVAraUFxZjF6SWVCdzEvUXdpd21DRnNvUkJLdTg3ZWk3?=
 =?utf-8?B?aGpzRXFLMGtXRVVBMmF3cytmMnVKZVdjL1pMM2o0cFZYamQ4UUVVcGY3VVpq?=
 =?utf-8?B?RG1QL09nMkpYRVBNVk9rcDZXVTFZeW5OWVdPNnRZeUxBNFM5cmFOeFlicUFW?=
 =?utf-8?B?ajhHc1g1NXFhZlB6ZlVIeGF6NnZWNUtEU0pCbFZHRzVOeDFjS05QVnlHTUgy?=
 =?utf-8?B?TVI3ZEIvMERSa0R6b2lQc09PZjJpWFVYODc5dzJIYUVEdWVBUldzck91Zzlx?=
 =?utf-8?B?TndWWkhxRkFhZ3BoWGI1UlN0MVduMFRMREhuNUZTeEVuTjlrR1p0bXdaYVg5?=
 =?utf-8?B?M3lRNWdCMkthTUQzY3hKMUhZQWhuaDIwR3hnbW1mODFwcnp1NU5yUElaT0JY?=
 =?utf-8?B?dmw0QnN2dXdSUU5tSzlXSVB5ZTcvMmxoUmt3ZjltaXl6L0c3SFRXRWVjZEVQ?=
 =?utf-8?B?S3BZbWYwZ3pFc0NzcmZqSHRzeVdpZVV5a3JZL0FEQThuSUtnSjg0emU1RFZX?=
 =?utf-8?B?aEl5OVV6VkZaSm5uRmFKRGQvbTBTeVRtQnhuZlRSM1JDRDVrZHpHb2hZMnBl?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c706d2-19ef-471f-22fb-08db4530571b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 01:56:52.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KA2ULzWZwnMyaFBur0kxDUciz96CWoRL+YuY220UKEcLLQfMRMzRrOWVDamb8vgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4439
X-Proofpoint-ORIG-GUID: a8Wep8NrZ6olY2BKcwF6hg_utHxUvw5_
X-Proofpoint-GUID: a8Wep8NrZ6olY2BKcwF6hg_utHxUvw5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_01,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
> From: Peng Wei <pengweiprc@google.com>
> 
> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> possible due to stricter C++ type conversions. C++ complains
> about (void *) type conversions:
> 
> bpf_helper_defs.h:57:67: error: invalid conversion from ‘void*’ to ‘void* (*)(void*, const void*)’ [-fpermissive]
>     57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>        |                                                                   ^~~~~~~~~~
>        |                                                                   |
>        |                                                                   void*
> 
> Extend bpf_doc.py to use proper function type instead of void.

Could you specify what exactly the compilation command triggering the 
above error?

> 
> Before:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> 
> After:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *(*)(void *map, const void *key)) 1;
> 
> Signed-off-by: Peng Wei <pengweiprc@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   scripts/bpf_doc.py | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index eaae2ce78381..fa21137a90e7 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -827,6 +827,9 @@ COMMANDS
>                   print(' *{}{}'.format(' \t' if line else '', line))
>   
>           print(' */')
> +        fptr_type = '%s%s(*)(' % (
> +            self.map_type(proto['ret_type']),
> +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
>           print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>                                         proto['ret_star'], proto['name']), end='')
>           comma = ''
> @@ -845,8 +848,10 @@ COMMANDS
>                   one_arg += '{}'.format(n)
>               comma = ', '
>               print(one_arg, end='')
> +            fptr_type += one_arg
>   
> -        print(') = (void *) %d;' % helper.enum_val)
> +        fptr_type += ')'
> +        print(') = (%s) %d;' % (fptr_type, helper.enum_val))
>           print('')
>   
>   ###############################################################################
