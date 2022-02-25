Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7F4C3CFD
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 05:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbiBYETA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 23:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiBYES7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 23:18:59 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4324CCD3
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:18:28 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P29VGD028628;
        Thu, 24 Feb 2022 20:18:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8PFtg8rB3beqBmCNq2relOZWuQhCda7SGp5i55OUiCs=;
 b=kny3ZI9KzDXq2s28BW5ie+JtW+AXrI59y8MndUcIuQm3B0FES5b0Ak4SDKHU0wp0saQe
 oOvcAIsGNPG1HVDWDQm6bd7EyOZqP3B14LAAf2LSRIwM7eAQbpNqVuHn9nVCZSfOfS27
 O6wtD5XLNEdRX3IBzWovQlteTqmQgc6V6kk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ee1rk83c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Feb 2022 20:18:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 20:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeBywTEuhMbHUc+7BxjrYVTG8SmO47C5dvDzjO/KaYZkcMRUtWS8sqIPUrmpFdOAgLXqXHq+ckGfe61PuUf4i7A6xXQnjQMeITtpkxdBIoAaUUmEnv2W5OYwTSGZO6XOn0ueUATF03rdyZL0w/EdvQwkwToLBfo+6xbpioHf/doz5z8JyJEMKWjrVgs+0VolLXiT2D4wjaE7PWwkTtPDJmqXVOMkdkwTm8BUOj8QG93QXKXe5A6R6KOskLMR/R9Z+05gYsPZBnB7sIVhSXDZhjgJUcoJgsu6wPQh1Qf4PdoxyseY9zLS/t/5b7wAjIMaXyFp5ylyXBohMEqn7w0b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PFtg8rB3beqBmCNq2relOZWuQhCda7SGp5i55OUiCs=;
 b=Lh9CC3tIWWE39kqn8ZltdYCzn2P1i58TS7P8l4mn4ggOPL9sPF+Oy8RqhPyLf6MG9QhXcT0GbHfCeci+Gqxa77xBKX1/CA542PKRtuWAVLNk5dSUrUHV6BYmwkW0s/kYQmco4mgT1RQMZ0bOzpqtYislcN9aIqW0pnuTDD+4EBlEzel55RSvPdGo3OTdKMTKhp5Jptbyb6EdfLZY8Xh04uSAa8p7ZtT9e+s+wFY+yo/XdFtPhp+pEeL8qjAPT9SwR5uVCx+IEJGqYXvx2QxG+zm9Nl5rOG0q3eKaLShZcvO5Eadugur/XWzXnXkT0Ioc/voyw6TOzIzblez7lBT4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1800.namprd15.prod.outlook.com (2603:10b6:910:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.29; Fri, 25 Feb
 2022 04:18:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 04:18:23 +0000
Message-ID: <cc86b899-5a23-ee09-2fcb-7f0f4a50b9df@fb.com>
Date:   Thu, 24 Feb 2022 20:18:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
Content-Language: en-US
To:     Song Liu <song@kernel.org>
CC:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        <andrii@kernddddel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20220224214928.826717-1-fallentree@fb.com>
 <7bb7006a-9f2e-a41e-7fb9-e14438536b83@fb.com>
 <CAPhsuW6aQv3RL2MHF7TZ7kv-8zQgZamqO2NGCtsXLZ5ZPWqx9w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAPhsuW6aQv3RL2MHF7TZ7kv-8zQgZamqO2NGCtsXLZ5ZPWqx9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8fa9e7-bde1-4a2c-258e-08d9f815dccf
X-MS-TrafficTypeDiagnostic: CY4PR15MB1800:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB18001CAA66E1F1B058A33000D33E9@CY4PR15MB1800.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtDZPQJEwhN9Cqie3sRC7+1Yuyq3D6+1gAWNnkkTlf6WxNqnAAjDM7NaDN2cMD4KJqEQBrEKNePuAb2PZpnJ5lBTqfHk8kvjptj3VmVWTugl+95BgGAYxwwSq6B28S+EmGHVrlUbMj8g9y5HbR9QkwYqvJ7KgCG0ZDgB1GNqj6+C5/xjl/5HmpWQ/vDHO7q/J/jAgeDrFGLifcLrMNIMNHzKYIIlcWhasbVJfs0YSbYiUR2KZZnh0+TlBhtj8gRlq29K09v6GJEj5SDUN7n2DOd5muBWrvlAIyRnDcngoXLzg3oB8RjnwJKLSAX0rkjgbvn/7RxOINMKELu+4MazyrJZYUxYFea0jF8PHr+mNDNsqZKEjSjPAXKsiH9BTHAJG2Aef82rZB6l0Hwv1knmteoZgc9Ifuq9gm49e3PuG8thjHbc00ziEHFI8Zd6Alvb0wfZIqxmYQ6c9zVzIQ+CLPx+O1Vb/X+5A2lXeAFrfaCHUDzc7U2v14DgmsAsf21APS1UgNWkqRTj8gEWpcYyhpPtJhpiXh+WLXCtP+q3BCfoC8bQQyEFtKX6j0IZPF38YWUVnBBEGGylJgjPLgo88XBeknvdf66VWuHzCUwhpjG/PFj3KBZag3uBEBvAv8xvpG48bKxW8ccLVL0HE9Dsir0mSsHk4amNuo74+w4ZZMY74a1YGox1YlvxDvqjxhuCMWTSziACWzjVFfhthf5fD929cWocCe+b//eifiWZClF/wNT5l6hxCFc4Ajly8WQOkHvyb7x4c4Jj7LtFEO6EjsjcTDO0Na90Nhp62Qjv5NKCcI4tLE/hTSPuJrzixKYPS0NsKOCUvbu7SqqNXMBCNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(4326008)(83380400001)(6506007)(86362001)(966005)(6916009)(53546011)(316002)(8676002)(52116002)(31696002)(36756003)(66946007)(66556008)(66476007)(5660300002)(2616005)(8936002)(2906002)(54906003)(508600001)(38100700002)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dWeUZvaFBSSVBHZWtJTVUvK0pyUms5ejdkWERpRUY0dnNpRW5yZ3NSbmM3?=
 =?utf-8?B?ZVZlcnhLSFU1S0JJUnZCanlwNGJ1NkZDbk1GWlZrRkhvVUJRT2VwY1RRQ1BW?=
 =?utf-8?B?SVNwSUwwOVR0RUV2Z0QwbmVqd0FmMDhTbHlTeGYyS2JCd1gvdDdUc2JTa3Br?=
 =?utf-8?B?WVJHZDJPek1yNytJNlZRLzZsd0ZnQ2hlbnllUVdkVFUrRzhET09DV2paaHN5?=
 =?utf-8?B?aXFhR24vaHp2NXVjd3ZQQlUrbDdObUtWc1pJVFZvVjRBQ001NVQ3NHl6NDZC?=
 =?utf-8?B?OEUwL0I0bmZROTRYZWJUVlIzajhFRjBqcFZvNXdicGVrcXphZFVzUGg1R1Ba?=
 =?utf-8?B?QVpIMk54QzVreHRKRU9yTENxczU2ZjVZLzFWL1J5S2dqU3V1TkVkZkliRXlJ?=
 =?utf-8?B?SlBqam5XdHlZZG1DeWdFMmlMZG9tSzMzWHlldFl6cHpDeWRteFZLajdtV3c0?=
 =?utf-8?B?MU1xNGQzamwyVmM1eDdoYmJEa2pMTEtwZjZYa3lKRVFJOXhMenJrc0FvZ3NE?=
 =?utf-8?B?SC8ySkNHNzgrL3NOM1hmeW10YTBxQVFRaGxDWjVkaElHZUlqeGkyTElhQmR3?=
 =?utf-8?B?cnZOU014VGRFU1RiMDNHb2tNWkVYcWJLbDhWR1JwN2VpUVlnK29DZFdFWmts?=
 =?utf-8?B?TythTnJ6S3ZzWTVodHRUTUFhaE51Rkc4MndvTlozeDVENFVlZ2VPYWkrWkFW?=
 =?utf-8?B?R1l4RCtPY1dHRjFNN09MMVB3ZmhZQlJsNlVMd2xIWGNUclhna2xBeDJxTjFJ?=
 =?utf-8?B?ZDZldkM5U3M3TzB2MlFYR2YrTXFxQ012N216bDV4ZVlEbUV6NFJrSDVvbWpH?=
 =?utf-8?B?TTEyVUk0SkZPbURPYVY2TmRlU1JpdkhhYzBRWngxZWc5RUlTcEtsbnoyRm1z?=
 =?utf-8?B?cm9tQmR3cTQ5SHRpSmovQW8wSEcyZzVEaU96RFg1S0VjaEh5R2wvSFhzU3RV?=
 =?utf-8?B?WmZ3NjRIQ0Rhdzc4aytjU0dOMmFQWW1EVUVJandvdWxESlB6NlBpOTliYTI0?=
 =?utf-8?B?NHoyZFpZUDdaRUYzTUNlam1FSlBWWmp2cXE5TG5sSFQzOTlQcTN5UEZ3b2Mw?=
 =?utf-8?B?MlZGUWVpQ0NwWEhUaVoxbkQ4aXJQOTFRVGNROWpOQVlPOHdjaW5LMTRnNjZo?=
 =?utf-8?B?M0hZNzlhcVlhYWpiN002c005dS95cGl2d3lWdkdFZVNURlZJbHpZNUV0T1I0?=
 =?utf-8?B?ckdpQTJHOEVkQ0NDb3U0NEZmMTEvQmZtaFJUVXJQczdsRTVoZzJhL0RMNTh0?=
 =?utf-8?B?MHZsM0Y0SitGekV1L2d2b09jUkpKa0hPdFdiQ0NsM0gzak4vNVlFS3lqMW9t?=
 =?utf-8?B?ZWRXTnVRMHo5RDRuS3JkOGlxL2Jpcm56ZlNGMjdmOWtQMXdTMTNZR2JMdVU2?=
 =?utf-8?B?Uy9YN1M1N1NEMjQvelYvQldqSGVsdHd3c3YyKy9hMUFLWWVZc1hYWHQzOGNw?=
 =?utf-8?B?U0dUL0E5ekh0Y0FYZzdSN2lETGg4MHloQVhTRDFyaUVSSXZuQll0S1hoRGlz?=
 =?utf-8?B?VE5HQklEb3FhUXJkdlo2QVJpbHNQU2lPbXdQNWRGa3h2clVxR1NKblBNcjlW?=
 =?utf-8?B?RkI2YTkyTVVoL0o1Ti9pd21pV1VCK3lJY1d1bFMyVXlINVBBMys4ZEo0Q2FB?=
 =?utf-8?B?VkduU0tKRWlDaHpxWWl5eVZKMVBDcXFMS2VDMUNiYmlLc0JxRTRpTmhkV3o5?=
 =?utf-8?B?WjA5b0lGY1ZBb2loU0JvT0hNUjJBUzhOQzZjNzhBRW83dnVFQjFlcjdKQWRk?=
 =?utf-8?B?a1lmaGtwTHpYN3pQS0o1UWs4ZDZianBwbnI2M1VyWXV0a2wyQkxhUkhpclpK?=
 =?utf-8?B?TGd6b1oxYzBkY2tKeWdmOEM4Vk9NZitzU3M5SDZ6eFNnNFhVVHBQWTR1SEVW?=
 =?utf-8?B?V1dPRTFaSUFod2xsbWQrNnk3Z0FUN3Zja1FpM2JFSTNuZTV0a2JYRGo3aVds?=
 =?utf-8?B?UCt6TVQ1NUZSYi9ZcGV5WmNOODdlV1RQV1RXOW4rMk4yLzRvMll0SVJ6SE94?=
 =?utf-8?B?R05qd0UwT3U2ZzdwZU93SzMzWldUQnkyYzNBNk5EZkpCajhmRDFZOTI2MVR0?=
 =?utf-8?B?Y2NVdGpTd3BSQi9ySUloM1JKRUViZndjd2k2RlZwSldPSGhwWTdEanZkaTF2?=
 =?utf-8?B?ZkpTcTJWbUl5eW1KaDRlWWx5SDJrRWRVdnV6NEthWHdvYXRTbVJyVm03UkJr?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8fa9e7-bde1-4a2c-258e-08d9f815dccf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 04:18:23.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai705wCwzco4XSv5GOiA9d3ogVsznIDYzB3STBU1cqbf6cKnkwf8Wj0rMODzGcpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1800
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: xKg65QGmTmyRgc5C06RCaekDaACjS8Zh
X-Proofpoint-ORIG-GUID: xKg65QGmTmyRgc5C06RCaekDaACjS8Zh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_01,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250021
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/24/22 8:10 PM, Song Liu wrote:
> On Thu, Feb 24, 2022 at 8:04 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/24/22 1:49 PM, Yucong Sun wrote:
>>> In a previous commit (1), BPF preload process was switched from user
>>> mode process to use in-kernel light skeleton instead. However, in the
>>> kernel context the available fd starts from 0, instead of normally 3 for
>>> user mode process. and the preload process leaked two FDs, taking over
>>> FD 0 and 1. This  which later caused issues when kernel trys to setup
>>> stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
>>>
>>> As seen here:
>>>
>>> Before fix:
>>> ls -lah /proc/1/fd/*
>>>
>>> lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
>>> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
>>> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
>>> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
>>> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
>>>
>>> After Fix / Normal:
>>>
>>> ls -lah /proc/1/fd/*
>>>
>>> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
>>> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
>>> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
>>>
>>> In this patch:
>>>     - skel_closenz was changed to skel_closenez to correctly handle
>>>       FD=0 case.
>>>     - various places detecting FD > 0 was changed to FD >= 0.
>>>     - Call iterators_skel__detach() funciton to release FDs after links
>>>     are obtained.
>>>
>>> 1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d
>>>
>>> Signed-off-by: Yucong Sun <fallentree@fb.com>
>>> ---
>>>    kernel/bpf/preload/bpf_preload_kern.c          |  1 +
>>>    kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
>>>    tools/bpf/bpftool/gen.c                        |  9 +++++----
>>>    tools/lib/bpf/skel_internal.h                  |  8 ++++----
>>>    4 files changed, 19 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
>>> index 30207c048d36..c6bb1e72e0f1 100644
>>> --- a/kernel/bpf/preload/bpf_preload_kern.c
>>> +++ b/kernel/bpf/preload/bpf_preload_kern.c
>>> @@ -54,6 +54,7 @@ static int load_skel(void)
>>>                err = PTR_ERR(progs_link);
>>>                goto out;
>>>        }
>>> +     iterators_bpf__detach(skel);
>>
>> In fini, we have:
>>
>> static void __exit fini(void)
>> {
>>           bpf_preload_ops = NULL;
>>           free_links_and_skel();
>> }
>>
>> static void free_links_and_skel(void)
>> {
>>           if (!IS_ERR_OR_NULL(maps_link))
>>                   bpf_link_put(maps_link);
>>           if (!IS_ERR_OR_NULL(progs_link))
>>                   bpf_link_put(progs_link);
>>           iterators_bpf__destroy(skel);
>> }
>>
>> Since you did iterators_bpf__detach(skel) in load_skel(),
>> in fini(), we don't need iterators_bpf__destroy(skel), right?
> 
> iterators_bpf__destroy() still cleans up some other things, so
> I guess we should just keep it?

Ya, we do need iterators_bpf__destroy(). My mistake. I mean
we don't need iterators_bpf__detach() inside iterators_bpf__destroy().
But since it is inside iterators_bpf__destroy(), to create
a separate function like iterators_bpf__destroy() but
without iterators_bpf__detach(skel) seems a overkill.

Maybe add a comment for free_links_and_skel() to indicate
iterators_bpf__detach(skel) is already done and repeated detach
call inside iterators_bpf__destroy() is a noop.
Otherwise, people may confuse whether we have layering
violation or not here.

> 
> static void
> iterators_bpf__destroy(struct iterators_bpf *skel)
> {
>          if (!skel)
>                  return;
>          iterators_bpf__detach(skel);
>          skel_closenz(skel->progs.dump_bpf_map.prog_fd);
>          skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
>          skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
>          skel_closenz(skel->maps.rodata.map_fd);
>          skel_free(skel);
> }
