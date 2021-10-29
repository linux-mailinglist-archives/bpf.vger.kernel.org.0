Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4738744059D
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhJ2W4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:56:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhJ2W4U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:56:20 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhdVe005719;
        Fri, 29 Oct 2021 15:53:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oMJrz+HzHgr195vw5uyaCJ+JszkFLnnrw0ICgPvsc3o=;
 b=SEs05+mzSmq5rtiWYT0MY/1GR4Lv2ie2YZnWWPQKcn2JVxp3B2PQZZHJWADSMLFainEk
 73LWZ6/K64Srg7DZpPK6L5VjKztshW8rz0XHrelLm3e9jcERceW1hDiVi0bW80NAnIHY
 Po4apx913PjWm5ZSkA18aaG8hH5/0dTB3iE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0qu50xut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 15:53:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBkBd5XBkqZfTPF5P0XGQtqw+l34sJokcGZuZJM0B+cwUdEGbG4FuHnuyAFkicsMQkn8PVr29U/RIJxn0Kt2xuX5OYJ0YOLas1ojgZGY4ZAkc5jCkyMK9lVi/nFesyH8uXD9tceHRtab1/bqZGqcqz+HfsjVkto+VeVqyW3Qi2kGkPgXcAxD4cAodQQ6ZCRVrMpy33tryL6BOA8awfZgXofiXBIfadGjIOVTxAl9FHWs6ASDcd8UZgq04esFITAVNPZ60olco6acWVSnVSgtpWn6NGDuZXNiFjgeJNFeaTBed1yElFaoHCfPR5U3CFtQpHvMmf6rZ80gBw2NUhd2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMJrz+HzHgr195vw5uyaCJ+JszkFLnnrw0ICgPvsc3o=;
 b=ld5v+HxjnwMcTqtZy3M42QIL6Iv1yCWHvy418LTa/z//3glqvNRlzGT0ZEFYX87skcVOWMnLVOpvZ7UnK677WEGwuSaRJPzviek2BscXO4e9QCwU+riZYOHcalHQTcRKyQHKYhUsmd4TtBPzg1IthQgQjUWyq40pdzO8CWwCsKUYXbnzyGHK6/CqgDKIqLip9p+O5LcOENSBu0hv8QLmgSz75jvzBndsoW6dzbNi+IphHnd68/vs0H3Q6qCnzhBGkCJQSCwZae2O1V85ATNNXnVqg3g11cTAxXBlmx7JWVNfYUGzjk0tjOxfa7Xg6pUSGpdqS90+TPrCUgyPgD4NuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB4572.namprd15.prod.outlook.com (2603:10b6:806:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 22:53:35 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%7]) with mapi id 15.20.4649.017; Fri, 29 Oct 2021
 22:53:35 +0000
Message-ID: <aeb3c512-5ba0-786f-d758-3559f4ff4f35@fb.com>
Date:   Fri, 29 Oct 2021 15:53:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next 0/3] "map_extra" and bloom filter fixups
Content-Language: en-US
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>, <yhs@fb.com>
References: <20211029224909.1721024-1-joannekoong@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20211029224909.1721024-1-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
Received: from [IPV6:2620:10d:c085:21c8::1716] (2620:10d:c090:400::5:9469) by MWHPR13CA0030.namprd13.prod.outlook.com (2603:10b6:300:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 22:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7357bc9f-46ce-44be-7eed-08d99b2ef06d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4572:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4572B8BCEF6722F03DB44237D2879@SA1PR15MB4572.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt9MRz5gWllY4TQjcRfaa8ncI1Y8cSBBrOfycmyDkeVYoDhWgMkk+WTa9KX9E6BahLKBYJJxYH77jrKal6G4ZO/8ksmYUzChcBiesUaPsZil5QtDn1UHlAtO5ku+tgDxuCKPjXFNbhX/Y7XlqloOqlYZc2PHoXDciSNoQGBVx3glJAvsgLmIi8+LuYvyMLDOBE0zsVuSCOkfaBfD/QD2rEolN6UfL9ByEZMguPE8uruGoAIa8oT8BDuDMUHbs5qwfYyEdi0U8HQ6krhEfUUyWEvwnf3/kp9VewMnPusxjLIyvXvL+rzODVtbXzlMIS/9tZpZp1w2pq76kshboQ8aLHoUTY15IQhsqaW0hVzO7PFw6MqQaKEJaRSl/AGKeg8GygnaRL7Ycy9tWTTxBFb7t2+tsy+Hz3Jn2sChfds5pFtUBU96c7wLsbwDp4kUqkM7lv+PvPrXpgKVsYFpc3xAlUPYq7MUX1lm+E8C8+JoS80BBAItTw4c2aPhxyNCRCZxAJz8h0l5/svLcHKS+xHhh34ApUnne6aIbM0wTy1fsRka/SVXGKv+rqH6pdXDQ/CcQdyrgrCoiffOrtDEGwgXr12O2lzqBDsGsyLnRmOxgS1tsbOkfp2uT4NHMZAlP1MmVNVCwAIAX03UB9Y2lMf4A8J5DUaqFQijXUoR/ziV3bIlJCj382C6GbgtwJiJ0GJi8wmNZ/SaYdwqzlp+jrt87dxXAhHsUTBekbVPRbGCt3FPexJT6oTebP8/EUrNE5hhKrFnmmin5MzcfC17MJcXF5Cq1qLTi0RmocgOpUSdSuaY875x5sEyy9XUnoas4BF5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(86362001)(186003)(316002)(66476007)(83380400001)(8676002)(66946007)(8936002)(31686004)(2616005)(36756003)(31696002)(38100700002)(6916009)(966005)(508600001)(53546011)(5660300002)(4326008)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blp6UTcxU3EvZHN3RERhelpzVWxJZk5YeW14ajhlN29GemhUT3Ryb1ZMM1ZF?=
 =?utf-8?B?R1F1bmw0SmFzZXV5bFVHRXRCdlpoRG5EMzREdWFQdG1VeGtBWkdvbE5Tem92?=
 =?utf-8?B?YU8wOENLMXRCbHpKMnB5QjJoOWNNRUlMbVZLSFQzTnYyN2xrMHRXaFRVTStn?=
 =?utf-8?B?SjVGNFFEblpoSHhlazJkeWpaSDg1VFFJNzFPWC81eWRWMTNMN0hrZkQvTjdZ?=
 =?utf-8?B?OElEZEU1VlBSMHpBYTJCWlI0WXhXelMvNTZVNXZOS0RKTklUOVVHQ3NsL1c3?=
 =?utf-8?B?SVR0WU9Idmk3eXcvc0ZlVFlKbzBVYkord0N3aWVnOE1mTVhBeUkxTVJHRUJr?=
 =?utf-8?B?QjRzeHBJQ1NsWk5pSWFmV1QraVYxYlRVbjFWUUVma3JOeHFGWHQvRWc3QlB5?=
 =?utf-8?B?aDRoYnZlWWdWQVVsRjB5TG9FcmlSYklpdGxLSkxTNDhCVjlvaGlGZmFXSUJK?=
 =?utf-8?B?K1NDMHVUUGgvQmc1NE9kaTMrM0xISk1ZNE51ZGlFZjZ1QWNuNGxRL1EvUGJE?=
 =?utf-8?B?V3N4b1YvcjZjcW15WGhzTjhrOURZQ1MrdXgyYXNOSHVPUEtLUE0xQ0djNTU0?=
 =?utf-8?B?cHFoODdLOWJnYnJEcGt3TVprdlNDUHlyckI4b0FSb3cyUVRFRitHQktmbDRV?=
 =?utf-8?B?QmN5OEhUdG9kakJ5Q1I4VS9CRXdmMDNDVVdodkh0ZzRScUQ2RWxTcndUQnZK?=
 =?utf-8?B?Q3dMeXJsdi9NOUZMZXBwNDExeWtyRnBLK2RVZS9NbFhkd3k2b2ZHeURGYm4r?=
 =?utf-8?B?SVhSeGlWcGEwa3NJbUc1cWw3NjFXU3U4UzNRd1ZJa3cwem5hTU1UazUyYnFk?=
 =?utf-8?B?SXJpT01tRDA2TEVzQUpheUdZNWhPajlRcmZjM3ArcnlHQWJtcVlCMnZBSURF?=
 =?utf-8?B?WDdpMExKRHBLMEFJTkpndDdBNnJpYW02REM2Q3RQWFI5MXFvQ09GQlk5S2hE?=
 =?utf-8?B?Q0lDaFdweDJ1c21wbEdXYWZDZ0N2cmZzM0Rxd1JMZTY3K09mMGErd0lPMy93?=
 =?utf-8?B?MHdXSTU3SktYcC9RWXVrTGl1TW0yd3ZMNzZBYitFWG1wTis5WFRMSTNUZjZj?=
 =?utf-8?B?MExPd2phWlpkNnpMWGZPdExWT3lqVGx4cFp1SFNLRUxwalJkTVZhbTU0eExE?=
 =?utf-8?B?ZW03cXkyMU50YVZSbzh4dW1HU0JtWmpSdm4wWTJjcmFEUlVGOWlYMU9TWnI5?=
 =?utf-8?B?VUVKamczd2t0QXRVdkFJTkt3b2MzME9tdXNUcWdPTFBrYVphZ2lCY0xyQTl0?=
 =?utf-8?B?SGJWd2YrbG1SYzlrb05oVkFmRW5ablRlVDA1cXhXVnREcm5YSXhhVHhkbjdN?=
 =?utf-8?B?Z25yL09hQTJtbnVMYmluK2F3K2N1YUxaTzRCOVZMLzIrOW1Rcm1TYzFDeTFU?=
 =?utf-8?B?U3ppSkl6UEEzZURhbFdtMzJKOFhxM2VWWVNLbFNSNGM2aTVWRzExVTh2aEU2?=
 =?utf-8?B?TkxUVmVseHFLTjlPVE5KdGxFRjBmSVlNd0tqQUZ2VjZMTDBKT1ZkOVh1TnVi?=
 =?utf-8?B?Y1V1UFo5eFVsYW5kTFJwdFZQSDRySnJLSklFVlZ6bFFnRkNNeHZZcGx0bkpS?=
 =?utf-8?B?dmltblNDOWFwbk01V3Q5cFpNZFRWNk54UU44Tjg0SHpxdndFS0cyeTRnUkVV?=
 =?utf-8?B?SzdUN1hkekp3VjJDclAzWWFySVNvbzdFbjZ6bnp5UjJpajVOQmE2eGl0bUZ4?=
 =?utf-8?B?S2hwZysybVRUbXNJSWkzOTJsZWVmMTlyd3dVbFV5U0ptdmdTa2g3bWhmaHRZ?=
 =?utf-8?B?a1dvTFRsNHQ1V2NSZURkNVJBeGRjN0I0T1g2SjU4bFZxTjQ2aFRER054MEJx?=
 =?utf-8?B?aWtZeXBYa3ZKaSswZHVRYlR3djFXRkpETGZSUEdJZDdDYVJvSC9QcFQyNjhS?=
 =?utf-8?B?dWFWSnJMbEs0NTJ3bE1OTU01c0RINXpDc0pXY0RWTmRUNC9jdjZraVBHcEVD?=
 =?utf-8?B?SG4remlERlRMaitNYkFtZDNNNXkyL3dEOWRTdUNzN1gyK1dJUnRWbEdXdncr?=
 =?utf-8?B?cTNGMTNPWGtCRnNSV2o1Tm9QVVJWQWZqRTd4ME5PVllUSGxjK0k3aGw0V01a?=
 =?utf-8?B?UTczOUwxTHhjQld5NVN4NTIrcWR3V1pNQ1hXSDBCclczZzNaUXFrWXlhUE5C?=
 =?utf-8?B?OU43bEM4ZWtqdjd2U1Zkb252NGFaZ3BMZ0dmbVhkZ1RDek5vc3BzdEg3bUdR?=
 =?utf-8?Q?FfrUpR9bjiTBy4o+1w4HZ6ZDYZ+H3Dy2n4ypWlLN4wN+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7357bc9f-46ce-44be-7eed-08d99b2ef06d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 22:53:35.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2LikoANM6TqaOGXlTvB5Z9zqYJ5Y/6r3d1zkqTTTueb9xK806pZw9kwwDamdiUZuMMr/2g/KObMA96ipuJKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4572
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MQ9LuD4axi7iF4YI-2bbnZtxtR9oft7-
X-Proofpoint-ORIG-GUID: MQ9LuD4axi7iF4YI-2bbnZtxtR9oft7-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Apologies, I forgot to include "v2" in the email header -
this is the second revision of the patchset
(v1 is here: 
https://lore.kernel.org/bpf/20211029224909.1721024-1-joannekoong@fb.com/)

On 10/29/21 3:49 PM, Joanne Koong wrote:
> There are 3 patches in this patchset:
>
> 1/3 - Bloom filter naming fixups (kernel/bpf/bloom_filter.c)
>
> 2/3 - Add alignment padding for map_extra, rearrange fields in
> bpf_map struct to consolidate holes
>
> 3/3 - Bloom filter tests (prog_tests/bloom_filter_map):
> Add test for successful userspace calls, some refactoring to
> use bpf_create_map instead of bpf_create_map_xattr
>
> v1 -> v2:
>      * In prog_tests/bloom_filter_map: remove unneeded line break,
> 	also change the inner_map_test to use bpf_create_map instead
> 	of bpf_create_map_xattr.
>      * Add acked-bys to commit messages
>
> Joanne Koong (3):
>    bpf: Bloom filter map naming fixups
>    bpf: Add alignment padding for "map_extra" + consolidate holes
>    selftests/bpf: Add bloom map success test for userspace calls
>
>   include/linux/bpf.h                           |  6 +-
>   include/uapi/linux/bpf.h                      |  1 +
>   kernel/bpf/bloom_filter.c                     | 49 +++++++--------
>   tools/include/uapi/linux/bpf.h                |  1 +
>   .../bpf/prog_tests/bloom_filter_map.c         | 59 +++++++++++--------
>   5 files changed, 64 insertions(+), 52 deletions(-)
>
