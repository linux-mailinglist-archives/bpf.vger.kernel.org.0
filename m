Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097E54B2BA2
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbiBKRVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:21:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBKRVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:21:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFF9E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:21:36 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BCA6L7007948;
        Fri, 11 Feb 2022 09:21:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+uC1nYO4PNcbLcNhBN86yQLNzGb1J54rYVyfFh9e8jI=;
 b=oM8QeJSDyjcuATb21Rwe+zrGYzyWVRkxrC2W/0VR33bZIT1gEvZGjXye6QkT4J8ypBBp
 +UQg89BNW8MDBkRc83ErD1dWFtaZFqBQOV90wKzc8kzCisAmN4sERtKdcEvgX9L4gk2r
 yv1/XvAekMcJcNeOqiEA202c5pIAdRDLVI0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5853fcm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 09:21:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 09:21:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8vRNuiUhMmoClHTPMEczqAHk8+e7ECOUxVp8HBGTeMKPDnfhHzOiemR8julkgYx//+v2DF3aSBo2/pJMZ4IhgEUz839a0ES0RQhHncv7Wjsv/BsMcpPalJ1K4ZnsXeM2i+Zg72Ibo4cro2O5dYQYili5Lrqev56ycRiW2O+8Xqjsbw8HNDVI4tW71MNNBXz7iQLLaufN5akPuw9TnN19IiEirmbx5DGZPELu39TBKMm4uKqSHlUqnxjv7VyeqxHAUYaIQ+oObU/VkT0OM2GHo8iZ/0oS7nhwBdmnviy2CusUMkqsKv96hn44Ulb1PR6YKGUQCvG3WEk19QDlkRxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uC1nYO4PNcbLcNhBN86yQLNzGb1J54rYVyfFh9e8jI=;
 b=Dr8730osLwVDcgyu5zHU43KSM648A2V+e6YEEgWTUBCKFYgyBOmjCTQmvSD9rDRysqjSTWmtmtw43WlVVzwhQXFG9uTMzaOJVRTMs4GFa5JirPu3e946fj2RJYfI/qgBCb9hQMsRtjnYzA4drgRgLQNXM8KJZb48Jw7RPirYXhDOs/Ok62ptzJhltRQQjlUghs6W1OdA/HW7QkLCZK7L1LjKrE3bnBPoaXMxecKdUUk82HvzWj82VKwUmQA8p2YMJ15UCKo5OOL9kSod+jnUYqViGfV2lB6f7V5nYmBR4jlf/OGBWqJeJ3FOf3uBlBKBdpkXwF/mDjbs7urDbPQaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1321.namprd15.prod.outlook.com (2603:10b6:3:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 17:21:19 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 17:21:19 +0000
Message-ID: <e3ce949a-b55b-40e2-6b7a-fd148b543100@fb.com>
Date:   Fri, 11 Feb 2022 09:21:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH bpf v2 2/2] bpf: emit bpf_timer in vmlinux BTF
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211152054.1584283-1-yhs@fb.com>
 <20220211152104.1586041-1-yhs@fb.com>
 <CAEf4BzZ=pKn-tu6vBaQwXKN+m0JhRVy0zJhhV_p6ZAQn=gwjvg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZ=pKn-tu6vBaQwXKN+m0JhRVy0zJhhV_p6ZAQn=gwjvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:300:13d::18) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d96cafa-742e-426d-79ba-08d9ed82eaf4
X-MS-TrafficTypeDiagnostic: DM5PR15MB1321:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB1321129BCB9E3715D2B80C3AD3309@DM5PR15MB1321.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYVygNIsl8JBHpMSbG4Yp4M0h0wShKZ1i8uWLWgHxyoy6pTzj7ZP6qQiRTTCfxhOwjugcoqz/yReZg0hCYylUROrM4u1RWEAJOe87UqJ67gJIjB+wdPCTo1Ib/kH7p1sPX+bRW+vHQR50xiO/G+/e5RzvMSp74D1jk2S+7r0aC3UMNvhVod/7QftO7KKM1AeLKAWxwYjiDzuIol0DgRA/WhG6pwS+yMDkBs7276742GYTWmCcVGf0X/NAcNKvAQc1QKJmsZsfIeB0KKhGS2+c1qJTen1ljp1ByKSeeBfmTJo2LsWK/upTYN9er+25XFXcTQ4nsQshfSl1elqVLyghVLC2BePgD/r3Szl0ixLulDyHe1rpKAYclzQ5F4or4GwfkpMzvyvPjWkU5V+MrdywW3b/vvO1FqfvvnUY7s+wNvUQOb/W96wBaOVFyaZ6qSoGuexbabSC8lzDMg1zALf2eTd3JfAYMTcgfJEQqMFFxiF3xECeS+eek1bq3UFfbExNpQMk0fv5TL4ZhuJMQOvbebs4FuMd0MgOGKcKim4AtKiKVk8HXG2RObp4wsE3V6aGbBe3d0U9A/EXmh6VIi08ONSjbg4pE/muS1x6XJLaNRFyKgW01YnuIggPr/Xcvo+174XaByneEyFabGuTCT/Bxj/d8NNrhE/k4yknBtu2fBuFUPb2LA0Uf+hRsdCYPhVkbfGVt/hoFiMNIxTfd6Lv3o11o6IdhfJhCmGQfPrlWxn7fmJwUzo5fm5RqZWPoc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(53546011)(52116002)(316002)(86362001)(6916009)(6486002)(31686004)(36756003)(54906003)(2616005)(31696002)(6512007)(4326008)(2906002)(66946007)(6506007)(66556008)(66476007)(83380400001)(8936002)(508600001)(8676002)(186003)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDVUQkJib2hBWHQyY3hmdkRwb1kzcW1tazNHLzNqN1FKVDc0WVMzNis3Zll6?=
 =?utf-8?B?ekNETUxGNDF3VmtNZGIxczNrclRSd0IxZ01FL0ZoanMyQnpqaWhnQnlzaTNq?=
 =?utf-8?B?UkJhdXNaRyszS3pkOE5hd3BSaUZydFJnZUdvQzhtY09MS3MrcFBOdWo2Ry9C?=
 =?utf-8?B?QVExMEhKa0sxQ0lYZlZIV0FETHJqaWlkUEZucUJjQTAxRFJ5Tkd6SlVRcjhI?=
 =?utf-8?B?Tk1pd0tNRUNVbVlBMFlySDhrZkJnVk0zQkRvMnRQMmNlRVh4OVNhUmRSUmVs?=
 =?utf-8?B?Ri9kQ2NqeFNlRnp1STlzdlJISjlkN2NJWjdCK2kxTGtHVVZrVEZCYjYxWW5Y?=
 =?utf-8?B?dGFvYXg3L3ZPVEtHdkpDNmZUZmNNQVpiM3lZdFY5QVNIK1l0bHFTcVNLSURD?=
 =?utf-8?B?T2hrdk9talZVVSszdHdvRjNxSkVNMHEwQkhwakZLSEo2M2F6aW5hY3ZZdnhs?=
 =?utf-8?B?cVlBM2ZUalU2WGgxdEh3R0dobERhcTVNRm5DaWZOMFRxM3ZYN0lBZlI0bmJq?=
 =?utf-8?B?T3pwSjhVaEJEV2RBWjFQSENGVksxUm1tNEJzQWR0Zkx6VXpqUDZtZFo0elVp?=
 =?utf-8?B?RHlpdml2aldTVVN1aWF4cXIxcEJxK2FVa1o5RjRFcEdabHoxWlpCNVRNR1lz?=
 =?utf-8?B?L3d5T1pGMVZXc1dUVDRKSjZMRDhHRjRhckxGdnJjbzdkTlhvdmNwWHQ2MFFJ?=
 =?utf-8?B?UnBsUlVjeXcrdTdVYW5rTDlsMUZmZE8xSTF6NENkc1BTWkRUejZYc2U1Qysw?=
 =?utf-8?B?ZGtKeWFLUkRNb1MxZ0NUSHZEaWZVejRIenFncjY4TTJqMi83VW1SbkJENUZR?=
 =?utf-8?B?ak1DVUlmaUI4QlBzeFlzcjh3cWFISmUyT1N3UTJUK05XSG1ndytmTmdJSVhL?=
 =?utf-8?B?ZkFWUVNER3R3L3hhWkY1RllncXZsY0JNenU2eW82WjIzU29OS095TXh4VHNy?=
 =?utf-8?B?VWdVenBKalVxejJoTEFkd0pZU3VWUjdTM0pKT0Vjb0VteXhZZ2dXT3JPZjN2?=
 =?utf-8?B?c2ZHRk1BS2tKU20rSHlEdVJtRlQ4YnM5T2hTTnRKYXdZRmhTSEJzNk9tT056?=
 =?utf-8?B?ei9kb25ETDBnVnQ4V3U2dUxUNlgycE01cEVyNmF3SWUydzJZUzRPSTVXTlp4?=
 =?utf-8?B?UkVrRzZmdThJSXp3cEZ5NVA3d3pZTDVvY3NkZW9pVGY0SmV2NG05TkU1TGNS?=
 =?utf-8?B?eThPYUc0Z1lBR1pJby9BcU42d09SV1YzQzZJT3RHZnJvaTc5QytjQ0pYUHdQ?=
 =?utf-8?B?OHlyQzQ2a01iWUsyRDRMWkhDQ1E0d25RbXFlNDJ4alJmTWgwMUtWY2ZkdllN?=
 =?utf-8?B?RjI4RGplc1UwUEhweXBjWlYxZlhCSExMYUI0eFlRWUxEcHN2aFpJdmw5YzJX?=
 =?utf-8?B?bit3bHlnVGI4aFBLNDVlb1k5dVZnMWNVN2tPOW9pTm1PZjZwTzBsMmpSaVFP?=
 =?utf-8?B?bFpsOEhYT0dtcXZNSG5BT1hPYTBBRUhTbTFENU1nQk5FNWlVUVRSdnlnOVhD?=
 =?utf-8?B?eGJtMlIzaTRxMDNzK1EzVEtYdkx4OVZ0MG1XdGNZZ1lwM2JOVFhDVnA1YVY4?=
 =?utf-8?B?WjVQazhyOGZXVlNrTzc4MFRNZURha0JncjdFZFFvU3FualpWbmhBNWJqamtP?=
 =?utf-8?B?Q1BBaTZEMVFYYXIyTnVwUUZIUVcwd3BBQWM0dVRFbGhCSzFucE0wc1dvTFJW?=
 =?utf-8?B?bUpzQ0MxcUQwWDlRWVhyVGtvazFyTHdvNmU2WXhIekFkK1VBL1o4Vk90bUIz?=
 =?utf-8?B?Sll1QVJ3V0d0aWxidEl5M0IyL1hXaU1qRGNENnIwRW1wMGdkUDVreENqeDU4?=
 =?utf-8?B?SWJ4V1d6YnNCem45UGFaSGJaT1ZCVWE2akgzNGVRU2V0cTM3Tmw3TGpZRWZU?=
 =?utf-8?B?dC9ZNEZGMktTbXcrQ2xtcDhWdytRNTlXQXJhWTJ5UmVJY2hzaytWMjROMVlr?=
 =?utf-8?B?S2diRmJQSnB1cXRZQW5OaGdpNzBBVHhzT21UVnhudmoxeW8yRDBHMjNvdnRS?=
 =?utf-8?B?eDlpSVhJbEN0NUpWblZIUEZIZGhwRlo1ZkM4VC9LclRMWlZBUnhybGVQUDJl?=
 =?utf-8?B?T2dLc1NxK1NKaDJtSTNmbkRkYWdIa1pmd0JnV3BwdFVQZCtScjlLdXVrTnN6?=
 =?utf-8?B?bGxJblltTVlKNjhQOVMvYkNYeWpwMSt0Y1lNL21wU3dlQ0ZSMWxtRTNiUWZq?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96cafa-742e-426d-79ba-08d9ed82eaf4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:21:19.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuFwzkFObFgweYiD7gS2sFXDvBY4X3glihvi36izncn9OQt9D+QAymNKxJjhs0n9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1321
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: IJjkBQe1hqgN2kiZmJX8NDOCNks5Dc7K
X-Proofpoint-ORIG-GUID: IJjkBQe1hqgN2kiZmJX8NDOCNks5Dc7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110093
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



On 2/11/22 9:06 AM, Andrii Nakryiko wrote:
> On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Previously, the following code in check_and_init_map_value()
>>    *(struct bpf_timer *)(dst + map->timer_off) =
>>        (struct bpf_timer){};
>> can help generate bpf_timer definition in vmlinuxBTF.
>> But previous patch replaced the above code with memset
> 
> For bisectability the order of the patches should be reverted then.
> Otherwise we have a commit that will break selftests for no good
> reason.

good point. will send v3 later.

> 
>> so bpf_timer definition disappears from vmlinuxBTF.
>> Let us emit the type explicitly so bpf program can continue
>> to use it from vmlinux.h.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/helpers.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 01cfdf40c838..66f9ed5093b2 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/pid_namespace.h>
>>   #include <linux/proc_ns.h>
>>   #include <linux/security.h>
>> +#include <linux/btf.h>
>>
>>   #include "../../lib/kstrtox.h"
>>
>> @@ -1075,6 +1076,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>>          void *key;
>>          u32 idx;
>>
>> +       BTF_TYPE_EMIT(struct bpf_timer);
>>          callback_fn = rcu_dereference_check(t->callback_fn, rcu_read_lock_bh_held());
>>          if (!callback_fn)
>>                  goto out;
>> --
>> 2.30.2
>>
