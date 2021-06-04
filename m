Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900839BC27
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFDPqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 11:46:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhFDPqS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Jun 2021 11:46:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154FTMuh008728;
        Fri, 4 Jun 2021 08:44:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HYA8PpKBG7gNvHNOylF6+UYJBCT53I1RHMdVRBB/c2k=;
 b=pjeIgzQZhtWg5KxaN0tIVKPFmz2PL4Uv7pcnm0WgliBuOZ6wObPKZnXLyeVawEMspZht
 /MDyVBXfFQjQi/0CyOWbR61AczDj7yGYiF44JcLLuQ46nzbrYpcqweYXFozQoReTYhZN
 F12mhJs231e3EdZllEZ1N3B0Wxh5R8D3b24= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38y501dnh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Jun 2021 08:44:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 08:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaU7yHj0AyA3PbjNCikQQVyjlt8Nsk6E65hTymdAN/wR9WRM4tQCRi8oSnM5xSyK2sU7Prgl63l1K0WyWWaM09LL5MA4tOu4yYu/88pEnV4s/t0x1Dt6pJC/YL2vPq4ktUsD+NIk+v0KetdcNKRdxnpRR+NDu7GGyzqM4IDq+RJgkqLijUAisOImDx87hPe5StFPHNYqeHyRwVt3SIm8m8NaILbn9iTCSi1WyC4FNWG+mMXnQehSH47tn5NNj23kYmvxGOXK8F7IME8leEuAdmHLJTHuGFwk/Ju61MiOKahvrnAD7zGgXRxCVMQtl6O5NaW5aflAxNEER+tRNv+rhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYA8PpKBG7gNvHNOylF6+UYJBCT53I1RHMdVRBB/c2k=;
 b=A7n4Gk4PlMPrMQ2zBx4flpMN1QkC9ZdCEY3eRyxgqHc040rzWOijhxE657yyc+wV66u/P/3pm4kMGqqgcfYLxtYOHruCdhoa8fGqnzDU7dL7vMK0gAmXGaNCR5uqzo9gULSEJEQ02LAESt4pNJseji/dkg69MC7DGSW8sEgYOlnMz2M7+xmTgE4sLvonu/zqnIGtNgMSi7cv6J7c4Y6Cej9Nyxt4ur+Q0oshZWttQXesxszWjXNwBhlStOcJk4jDmLPKHfs/nKRhXdnVwZ78IAZbD+5v8J03lI06tew6qZHmgMPb/ogohsPz4/AOZSKirnkML4RaG4TP+j4ykgLm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 15:44:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 15:44:21 +0000
Subject: Re: [PATCH bpf-next] use correct format string specifier for unsigned
 32 bounds
To:     Benedict Schlueter <Benedict.Schlueter@rub.de>,
        <bpf@vger.kernel.org>
References: <92abb6ec-84d9-6210-df13-ea563e0d1fa1@rub.de>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2c41854d-4199-266c-9836-088d0ae080f8@fb.com>
Date:   Fri, 4 Jun 2021 08:44:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <92abb6ec-84d9-6210-df13-ea563e0d1fa1@rub.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:a57b]
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a75] (2620:10d:c090:400::5:a57b) by BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Fri, 4 Jun 2021 15:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf59c80-881d-4471-d070-08d9276f9f13
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-Microsoft-Antispam-PRVS: <SA0PR15MB406248250D9A32222764F9E1D33B9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVRBwpqQyATMIwaCbhk/88BLf+zj44A4aJcrPb3cpVsV9DVDW0qrTxsr/QwJo7p+B7cE+N349hdQ36Hv7Eer9kk9RQ0fWviAsAdePoM3wPTygZTfXE5kfHGnSN6ztE+x4f5AiFl36Ejv/nHd4nqp6tTB4NmzM6neRvPcdtjxAEU0FkipXnPOjLMErIWDJkIZ0EPMjmZ3Cg9XY0nxfv8VzS6ZyXO9KkX/CD94MVCQdYAQ9G61qBoo3LHmIZRm0QHTBW9Qt8fErxIeeV6ODWA+REM3AfF1awPVHyMTs/lQpwoxDCAsYI5CY5WWIDPsygbPyCFD+VBaR2zXOfcXfr8/nJXDQc8rTwHM4NppUMb0CfULM2IfqxHMQPdy2bH+DTyIRTYA5rZ86jsE7C5RPG2JcSKXTeR6XYo5OWfqmDlYcZOrdqGkq8QzSo8HHtjr+8m5g+rCfypgXsuJhAECPgn+NBzqK0rFPDLb7+3US8eyf0F6QyxCn3A5oprPrOg7fph2eUb9hnGwE9yYN3eIDnFPGixhJl7LwHxWBrYTQz0tv0XnM02udNy8XAltCmJvZeOiBPoVkUwd52RgTIl/9vTZFlSGSdMNVg96+FbuZqbxI1QblFIPfEXxKdt6kVNqFe0329lamcTtB0RnYkiy2mJ00N2uZi0uhAvi1m4S4vDqqRnVpGIDyUqP2Ju+JlAmL6P0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(66476007)(31696002)(8936002)(66556008)(5660300002)(53546011)(478600001)(8676002)(66946007)(16526019)(186003)(36756003)(31686004)(52116002)(83380400001)(6486002)(86362001)(38100700002)(2906002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXVEM2pISUpqVWNXb3V3R1FIYXlFd2V1TzJKVFZwaWpvU0NZaFpONmRycEJt?=
 =?utf-8?B?ZXhDaHlQV1lBUGlUZGRHM3N2SVlBQ1pLcTdrWHBOdVZSNW9MQ0RwYU0raEY5?=
 =?utf-8?B?SHNNN0UvWG1hVUhIaEtaSjh2Y2JOZmRQZWYwempIamxtdmhWM3NyZUdyOS9m?=
 =?utf-8?B?ZVZnNE14a05TVFQ0a0dKelBoTXA5R2NPSTFhL2drcVdOSUNpdnIvNWVQZDZz?=
 =?utf-8?B?WEt5MFQ3UXRVQjdHWnh5bk95TWdpVXpXbmovZ3JFQU5SbnVIQ0tkZjRRN3VQ?=
 =?utf-8?B?RFpjN0dZRkxya05IbE04SjVCTVJvZlZFU1ZmbzZQbG1QOEUweWNWZnZGSFUy?=
 =?utf-8?B?bGJwR0MxMkpraVJrc2EyU3k0aEU0QndKRUhhNHFVdXMrdTYwMUpQemtXeHZy?=
 =?utf-8?B?NUdDbUNBYmlkMGI2bHRBWmdKRVB3UVBlQ1daTVlyWG9VdnVpMDhIbEFkcnJk?=
 =?utf-8?B?a2ZNalRrcFVBaDRuT0J0UFVjQ2ZjTU1MNDVuRnNJTnlFSWFSZmRrelQwOEdp?=
 =?utf-8?B?djlZdm1LMThRTW9oYmdERElNUjAwYVJYbjNXenRINGlhQW9ycDVNbWNyTkNv?=
 =?utf-8?B?bU15NUhvQjdFMzdNSFJNTDNGeXVRZ1VmSmJYTTNPcFJhaTFLWTN0MEQ4TDBs?=
 =?utf-8?B?LzUwbTArMVRIUWg4dGU3ZVRTelZDaXIxT3ZjY1dDaFBGV2hWV091WUlEdVYy?=
 =?utf-8?B?R1lkaEk1S2tIUUxGcVkyVlVLWGtQaXcvbEJ5c1lVOUg2NlVGWDhoYTZTT2k3?=
 =?utf-8?B?RzQ2OFNGTFhieXNKVjNjWEJhM2ZkT0NKV2V2WVR1dGdjT1ZuZEl5Y1BuTFB5?=
 =?utf-8?B?a0N1ZE5DN3YrcE9IQlV0UWo5NllKZWwxaGd1SlUyb1JBV2FhVy9YZGp4SVNV?=
 =?utf-8?B?NnN0NWkwVWtmeS9mVEFCNGMzSGZyQXdLZlpLbXgwTU1vemZOVlA1U3ZJNktK?=
 =?utf-8?B?ckZqU25zTnA2cmpNWTloWURLRTlpNjFGbFVxVWQ2MG1Ec29PcllLMVhFMFBM?=
 =?utf-8?B?MG9ydTlIQ1FqOTRORENiM2swR0lSeHBYMllOUEVlNTUrNVdoUjhJSEV0ZlNT?=
 =?utf-8?B?U214TTNqNWIyZWE1RXFCRzJhL2ZoR3NlbDFYMkVpZzNhSENZcmpwNmZ2V3Ev?=
 =?utf-8?B?eUZ6Y1lOMHVsVGVvMVlhNHMyY3ZJQWlwZzJoNFIxTDl2N29UN0UzZlJnK2g0?=
 =?utf-8?B?akZsbm1KNGdjdGJrcDVudzY1OGtYS2krekU5OW8yMDRIN0VMV0Z1RjhYUXFT?=
 =?utf-8?B?QzI0MHYvVHdrTFJTdjNYbHdYUFlCOU9FOXlRcTdqcm9PQUh6cFBXWjA1aFg2?=
 =?utf-8?B?ZSs2YUVheEVSQkpBVWkrUHRwKzYvTlZWYWV4ZG9zQi9HbnhRMUR4WUt0bUlJ?=
 =?utf-8?B?djNJVjhhbmFraWloTGhBQ3NBUEs2TXc3ckJiWkxuTjgrR0JoZ1EvOThESGJ3?=
 =?utf-8?B?TTlDb25GaFh4WFRsUXdGa2Z2RnpoU0NpT3JMODZaL1JZeDVGNUpyQ1BXUGM0?=
 =?utf-8?B?cFI5SEVWeVREK1lVUEZoSzk4TVdlaUNDelUycGhOaHlRSlQ5YnlUSG5MRGs2?=
 =?utf-8?B?RWJVQWdSWmZZVzNMOWFFZ016Y3NGMUF5d3pWdjI2VzEzMjBscXVPSEtwdW9j?=
 =?utf-8?B?RCt3LzljUDNSNmZ0NjRZUTZnUERNcG9iZVk5RzF2SExTcldtWGhJeUJtOE1l?=
 =?utf-8?B?V1QzVk1nVzVNbmlJRFdoeGhGb1UweUM4M00yYjBUMzVvL3NGVDI4QmsrRzIv?=
 =?utf-8?B?SWJPd3MxUkh0QWN5V1FCYmJOQmlMcjErVEVLTUJ3Mk1rck1rVG1BSGNTREMv?=
 =?utf-8?B?dGZxVFZGaDEwWkxGM29xUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf59c80-881d-4471-d070-08d9276f9f13
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 15:44:21.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrhQ/84GqwIXmA6evo6j/DsKQyK9yoXJUfC/Gr3HVUGklW/ajLkZ+Jjp2SShBf04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FKtuT_MK8NGe4uV97MO_ESnDHoQcZmCz
X-Proofpoint-GUID: FKtuT_MK8NGe4uV97MO_ESnDHoQcZmCz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_08:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106040114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/4/21 12:50 AM, Benedict Schlueter wrote:
>  From fd076dc5f2bd5ec4e9cb49530e77cf2d3e4f42c2 Mon Sep 17 00:00:00 2001
> From: Benedict Schlueter <benedict.schlueter@rub.de>
> Date: Wed, 2 Jun 2021 21:42:39 +0200
> Subject: [PATCH bpf-next]
>   use correct format string specifier for unsigned 32 bounds

The above email header is not needed.

> 
> when printing an unsigned value, it should be a positive number

when -> "When"

to be precise, "a non-negative number".

> 
> verifier log before the patch
> ([...],s32_max_value=-2,u32_min_value=-16,u32_max_value=-2)
> 
> verifier log after the patch
> ([...],s32_max_value=-2,u32_min_value=4294967280,u32_max_value=4294967294)
> 
> 
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
> ---
>   kernel/bpf/verifier.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1de4b8c6ee42..ea482ebaeb26 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -690,12 +690,12 @@ static void print_verifier_state(struct 
> bpf_verifier_env *env,
>                           (int)(reg->s32_max_value));
>                   if (reg->u32_min_value != reg->umin_value &&
>                       reg->u32_min_value != U32_MIN)
> -                    verbose(env, ",u32_min_value=%d",
> -                        (int)(reg->u32_min_value));
> +                    verbose(env, ",u32_min_value=%u",
> +                        (unsigned int)(reg->u32_min_value));

There is no need to cast to "unsigned int", reg->u32_min_value is u32 type.

>                   if (reg->u32_max_value != reg->umax_value &&
>                       reg->u32_max_value != U32_MAX)
> -                    verbose(env, ",u32_max_value=%d",
> -                        (int)(reg->u32_max_value));
> +                    verbose(env, ",u32_max_value=%u",
> +                        (unsigned int)(reg->u32_max_value));

The same as above, no need to cast for reg->u32_max_value.

>               }
>               verbose(env, ")");
>           }
