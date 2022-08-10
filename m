Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BB58EEFC
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiHJPJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHJPJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 11:09:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBF73338;
        Wed, 10 Aug 2022 08:09:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27ADBWWE006645;
        Wed, 10 Aug 2022 08:09:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=N9l01EkwY/9kgvBGXWUNtTyLtqRY1nIxJTVllHQIiFM=;
 b=rn4wwbTIBLWTZg9Uovn2JNvY7NPHDO5L8sGQwP8zPhUPGihLrmkgNoHlp0MSqN7hm8bt
 n+8vKIJSZwojwjSqAQzwn1js4bz2pTwhSZWugvi0bcmR7lh4uZGmK59OwY0FDFsFMbGK
 3vQZBh0vCUGZQPuR6Qk+OLgiOTG7ocXNvVA= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hvdb5rwj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 08:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv5MYXQN9K6E9DfjK+Lcb30piP/KGyyDRhxb82+qq6xgtKP7WR7aRyJgWNT5QkqI/MzwXOVJVjuOJKl8tpj6FVL39F1fsIRxGytdvArWhjG29Wf64ebrT/ncQCbkheowoJ3gQ8J8la2BPq6TrqJiDa3R94fIGjRGa5/JpNmqmA2l93fP4J20mgJDuX7gTOYZEwXLnxbyvYBaIfT0//G9j/t8sRmS2tdCFWe/xzTgrZE+4w5V8Tcc1eNppIYGzdB+a1QvriFOm24Fi7FQAYAsF/CWjCloz0Ij1DdGg6NAotiKTDDh4yd82sKA7Qv7dJWUbwVwupBQKhItV7JxVZfOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9l01EkwY/9kgvBGXWUNtTyLtqRY1nIxJTVllHQIiFM=;
 b=koYKI09T1xf+5Iu+b6rCATqy0Ce8D/9RJyMY+c9AzNa9dajzGIc8u0ExC5enNAIK9j2rmVxFDYoRg9dv+OfsOg7fbUz+BUe7bOE0iuocJf/SxTKn5LyNbPYe7JuWaFcX7HXx2rcSYL/Ly926JgsMss434PLfpIoWqSdLrKcMIm88AkaHoDFAAXNRrOVP658jWUTVAXmauNUAjtGk6XQVIghIvwqMUM0UrM2f3oAIV4VDFHsbSo4b1whmU6zYGVbJUewvJ2+kPXiW/rYOsXca/TffA1IUE0pBAD1kqAg8H75wuCImBN/md8rAj86auPuEy9oNQnUBpp28GiIcaiwy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3510.namprd15.prod.outlook.com (2603:10b6:a03:112::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 15:09:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 15:09:12 +0000
Message-ID: <5aa15b12-d193-b505-5786-3e187751323e@fb.com>
Date:   Wed, 10 Aug 2022 08:09:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20220803134821.425334-1-lee@kernel.org>
 <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
 <YvIDmku4us2SSBKu@google.com>
 <CAADnVQ+5eq3qQTgHH6nDdVM-n1i4TWkZ35Ou8TDMi3MqGzm63w@mail.gmail.com>
 <YvOQhTUD1x6W0ozO@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YvOQhTUD1x6W0ozO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a88c04-a1b3-4763-7538-08da7ae24845
X-MS-TrafficTypeDiagnostic: BYAPR15MB3510:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP9LoIr3mh2P6+UdhiOOOpyGSVWCbFhJDIfAsqB3Xrraxhn1+IAUgzKQZO9BflwrZQg26nX8JD21AqRkpeTlZXyCXJUjF4ybibgTYpU/VHiOvjoawNug/UdRQSjnnVHnjINP4RrT5rhssa+/7hj2go7IOtIsjlNK6PAmfbgbzESxaTmIEhRWuvYL3b7D/aEiNKGEYfqWLJVIMmvetAWywsC0t0cIG0Zg9J49cj8YM4Fz0xrPK2itU54dWYTBIO+oU1UOFre2ucbT9gquQn6TthrL4Ko3U0MlnDd1hhzlZ+LWush84r/QwtAUdvtboDRjl9Oc8sDGBzU4qR5XBcTSF22+h6lpy4SY+PGA47S0k4mQRaj0hbk+ZDJB73+LR+uA0mRZgxafgPa6y290IHund8cFI7WcNvbuas0NKv+FZz3WDaxR6fn2tnBygmlPkRoBcOdZ8KHYZ+qgvF5IpiWBhNxFe9vOT+MGgVwBf9VkRnbxywROiWJHZUZ0zhxP/35t823j2e/I74558jtJg2M5uHt0J6FONykQCeWwPO8ydCgxc8odSc4vvSJJUMVdHwOYp9OZIgH+ZVG+QCxMpSo3L/0SmUpM5Q3DHw7gkQ4tOX4erx0i/4RPdlPJX9TsjeJm6ALyDffWmdtQ5wxDXKDsuQKyBzv0uWlOUjpZm/FPwtRVhkOogwT6YrRE2n6qK8HDgmENNIpF5L382bXoT29xMp5uA9NVl+zoM13jwzDdg/lOGXCeQyA0nhZlCDqDo0O+mXKLJmMqTtDej7iOxwdlcLTJt+m4vBUMNbPccy5HG8llyQ2DDqhFeRTWmKY2OlfIDdQQXSSzUDnj7WTJgG9I6wqh6IEN3gfY6WNX8jXNg3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(53546011)(6506007)(83380400001)(2616005)(186003)(6512007)(38100700002)(5660300002)(8936002)(8676002)(66476007)(66946007)(7416002)(4326008)(66556008)(966005)(2906002)(6486002)(6666004)(478600001)(41300700001)(31696002)(316002)(110136005)(54906003)(31686004)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NDN3VJU1J5TXdndFREaWNjMXRpOU1CZXQyOGZkeE1JSmhtNWxlUXZJWEVS?=
 =?utf-8?B?b1BsRVExZldGcUJzMjNTY2JQQVJaY0Y2NWpaQWxTNThQYTl0RkdHQlFBelFq?=
 =?utf-8?B?Y0xBb0NBcE9BaStvalM1SCt2MHZSV1gzdk9Dc1B5UVdBZm5ncXhrOWFUQzM4?=
 =?utf-8?B?Zlg2MHJtbWlVQzBjMUlDOWVFQ1cxVzN0VWIxb3pFTWh3TmJ5WFlvYkI3NlR4?=
 =?utf-8?B?bUQrN2FoeTd5ZVc0S1lBVE81ZjN6TjBqWm9adXpsejArQ2Zid2JSTVpyNXhS?=
 =?utf-8?B?VmdyK2FPcGtKaGZHNzlGWjViMnF1MDRtQi9IN3pmU1d0Smx3bncwRHcxMW9R?=
 =?utf-8?B?ck5uU3lQeWZXa3lIY1hvNjh1TnBGRXRaYnk3ZGxhMFFDczkyL2FMc3dhYjNT?=
 =?utf-8?B?bFJKYlRyNjgvWmhTWG5SOW1jTzVQZnJFSVR2L3ladU1zQ1JkalNscHVsaEtn?=
 =?utf-8?B?Nzk2MjhyS2VBOXFTSnhjNWF4VzZoK2lkOEFMUVBSQ1RpWXdFTkRlSHRwcXdy?=
 =?utf-8?B?M3FQK2pZemMwK3UwM1VQSkIxS1BPNGRCMUhUdEREWVVzUjE3S1pLMXRlR3BU?=
 =?utf-8?B?NjYyanA0bmlHNlF4V3dLcjBHR0VVOTJKMzBYVFpDRjM0d2o2SWJIckZHU3Qr?=
 =?utf-8?B?NGFIc0JkUHV6bm42bDBZTW9DZFozdkZHNDRBKzhLeENXSUZVOXFwWElRTzRV?=
 =?utf-8?B?U0V4ZVFFSVE0K1dYWEF1VDdQekhvMExGbThvN0M3UER4aXFMS0FYL1BIV2k1?=
 =?utf-8?B?UE5LbXpqRDVLRGNTTHdjU0lzcWs4a3hXNVB2QVNDdmxic1I4NFVGOFdwdFRQ?=
 =?utf-8?B?THJ3V1pLaHBlKzRCYjJ2L0V0eEVFQlBZR1NuSmk4dlpWVDZUbTFyZDQ1amRT?=
 =?utf-8?B?UFI0Nm1nSkJOSmVxL0x3cUhwOHNESzFTUGd4ZWtNYnFyc3MrU3Z1NXY1cE5D?=
 =?utf-8?B?SERveGxZQlo5UkFvblFLOEdyT3I3NGtaMktjQkZGTHRjWXlWZzJUeFRIejZH?=
 =?utf-8?B?amxMdzNpMUltWjZwUUJTZHpDMHdlVGlqL1NtbjRRZE00VkRjQ1Rsb05BQ0I4?=
 =?utf-8?B?Mnlud3R0Vkk4N3I1dTVKTk1WWE05dVZROTNjOXhKcTRiV0E3bGVJSVZTNjYz?=
 =?utf-8?B?WGp4WUVXMzJLV2V4c2JyZ0lZaHRFejNvYzZFcGREMXliemk2dXRQSHlLbTcr?=
 =?utf-8?B?ektHWFRGUG0wT1BBSjVRcm5TeHloR3ZXKzYxdW1wRkdBdGJ1TkQ3UGtGY2l2?=
 =?utf-8?B?bXZibThzZ0l0OUdOYjlxMXRDZ0hZbEt1SittZmJEODBmakZYMlN4UElxVml4?=
 =?utf-8?B?MW9BeE1yOEg4SFdZWGQ3dG13ZDBoWEhDcTNidjVDRnVlS0trWncvSnI3TFBC?=
 =?utf-8?B?YnRnRHdEWTdHREF1alNRV2NscHFXLzdmdG1SYi95dzdJN3UvdGpJa0o1UTNN?=
 =?utf-8?B?N0QvYUgyU0tuY2hHRVpOQXZmc21SQ1lGbS9JWHo2WHpWRXVhWmZMOC9oZ1FD?=
 =?utf-8?B?OXBvb09VTE1JQThoQ1J6UmUrZldRSys5TnJZQTFSKzNNbEJiRDF5TFlKL1Zz?=
 =?utf-8?B?cUpnRXdldUNnQjBuNGlFTVdrZVhpNE1EVHZRL28yYnRnOHFmTG5TcUYxUm96?=
 =?utf-8?B?M2pqbzgrWlMvQzVJRDRkN1ZnZXFScVB2WlQ2eEpJNlU5RGdvblRsNEhrRDIw?=
 =?utf-8?B?OTlVVTVjWVZoQ0piYWxURGRTK3o1L3VVUkRjbVZ0YVJ4TXVIYmNCYXFHenh1?=
 =?utf-8?B?N0dFUW40RjRjSEF5dXBpZEFmWnk3ZkVZaGZSTi9kclNHYzlFRHVxUnhGRnZt?=
 =?utf-8?B?Z2E5dzNZajVlckkrKzlJVWtCNDdrZjNQdnF2czNoS0dsa0M3N1FuU1BYb3Bl?=
 =?utf-8?B?d1VNN1k1NkQxcW1XdEZuRG9iZ0l3WjVyaWt3WGh2Vk1OWFJWbGdUSXQ0TWVW?=
 =?utf-8?B?a0RITUZCVnNhLzhRUVR4Z0FLeW9FSUF4a2xldkdqQ2c0RWZoMU1iL0lkbDli?=
 =?utf-8?B?c3grM2FVRHZtR2NHNGo3dG1sVHlVYkd5KzF2VEZSUEd6T2RFYkhHeDlNWkRz?=
 =?utf-8?B?a0p6YVg4czdIVzVxV0VXamZLYi85MTIrVVFNR2xLSVIwZkdSNXdUc0cxaXdP?=
 =?utf-8?Q?ntQDtkakW+bbmkw/DB3WSkk59?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a88c04-a1b3-4763-7538-08da7ae24845
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 15:09:12.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fGCtwb9GHf+Y2/PQmn+yzYbfLHj9G82GNnMuVypAQkWalG1TMk7An30xxpfo1FN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3510
X-Proofpoint-GUID: qGDiUzLqS7oNlkqu7OOlRUQLQZxEtL_R
X-Proofpoint-ORIG-GUID: qGDiUzLqS7oNlkqu7OOlRUQLQZxEtL_R
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/10/22 4:03 AM, Lee Jones wrote:
> On Tue, 09 Aug 2022, Alexei Starovoitov wrote:
> 
>> On Mon, Aug 8, 2022 at 11:50 PM Lee Jones <lee@kernel.org> wrote:
>>>
>>> On Thu, 04 Aug 2022, Alexei Starovoitov wrote:
>>>
>>>> On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
>>>>>
>>>>> The documentation for find_pid() clearly states:
>>>>>
>>>>>    "Must be called with the tasklist_lock or rcu_read_lock() held."
>>>>>
>>>>> Presently we do neither.
>>>>>
>>>>> Let's use find_get_pid() which searches for the vpid, then takes a
>>>>> reference to it preventing early free, all within the safety of
>>>>> rcu_read_lock().  Once we have our reference we can safely make use of
>>>>> it up until the point it is put.
>>>>>
>>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>>>> Cc: Song Liu <song@kernel.org>
>>>>> Cc: Yonghong Song <yhs@fb.com>
>>>>> Cc: KP Singh <kpsingh@kernel.org>
>>>>> Cc: Stanislav Fomichev <sdf@google.com>
>>>>> Cc: Hao Luo <haoluo@google.com>
>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>> Cc: bpf@vger.kernel.org
>>>>> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
>>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>>> ---
>>>>>
>>>>> v1 => v2:
>>>>>    * Commit log update - no code differences
>>>>>
>>>>>   kernel/bpf/syscall.c | 5 ++++-
>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>> index 83c7136c5788d..c20cff30581c4 100644
>>>>> --- a/kernel/bpf/syscall.c
>>>>> +++ b/kernel/bpf/syscall.c
>>>>> @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>>>>>          const struct perf_event *event;
>>>>>          struct task_struct *task;
>>>>>          struct file *file;
>>>>> +       struct pid *ppid;
>>>>>          int err;
>>>>>
>>>>>          if (CHECK_ATTR(BPF_TASK_FD_QUERY))
>>>>> @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>>>>>          if (attr->task_fd_query.flags != 0)
>>>>>                  return -EINVAL;
>>>>>
>>>>> -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
>>>>> +       ppid = find_get_pid(pid);
>>>>> +       task = get_pid_task(ppid, PIDTYPE_PID);
>>>>> +       put_pid(ppid);
>>>>
>>>> rcu_read_lock/unlock around this line
>>>> would be a cheaper and faster alternative than pid's
>>>> refcount inc/dec.
>>>
>>> This was already discussed here:
>>>
>>> https://lore.kernel.org/all/YtsFT1yFtb7UW2Xu@krava/
>>
>> Since several people thought about rcu_read_lock instead of your
>> approach it means that it's preferred.
>> Sooner or later somebody will send a patch to optimize
>> refcnt into rcu_read_lock.
>> So let's avoid the churn and do it now.
> 
> I'm not wed to either approach.  Please discuss it with Yonghong and
> Jiri and I'll do whatever is agreed upon.

Hi, Lee, Let us just do rcu_read_lock() approach then. I am okay with 
that. Thanks!

> 
