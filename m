Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00739646149
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLGSwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGSwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:52:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45CF68C48
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:52:28 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7Eo2Gh007616;
        Wed, 7 Dec 2022 10:52:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MeD5OY+ANWfMHULDittecT3pFt+ysF5F5rod6NgcWn8=;
 b=JXkwSiCkbwkuQJhP1mwuFhR8U8MoZqcVtLmE6whXvwJErffkQlrUGl8L7zRACxuH4SlS
 SMQq/i/YH5B7xLOz3atEjBN+QCLzlMUPktuZUfcaPU++828atF/TZpYjDv0zxiGCrH9z
 h634iIr4Vz1ysZMxfGUW3822N2fuUFD9Qalv/4/CKepmo8urt70XE+8Kt4X9OFE5M6wR
 L7pkLYya44tIOBKMwfRIC+GRq6fIBLW7x0rrfRxmP7+p1rpdHu7NZj+ljyoNLtmoTUkL
 8dWYjjc1fXpL6N+IgRVW4zISBv7dTFdlKQ1Rjqxhmo7psYdVI7+iUHicX2die/0ECW32 Rw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mafq9ebdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 10:52:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL3LrxAhKtNkWY5lx2DarhjBvY4p5NdQa/d5fQQd/ys13T4/YCKV9afl5kDvtunXZpPnuCYz9db8x5h4Co5OleTfC+od9D+wmiUv0y8XlLEJtLmGuZ9N4LKSC8TXrcxfXWP5yVc7YNcWZXhNGzP8n9SraAXGnNdK/le91inQDEDdjQJO1hT84AUh6AVIZzJtUsy7euK3vL5D5YYKC4NARZ6wJz1HwGTT0e4XnOYuM6CBd+wYj3MX7dXX+ja9c/fWI0LxkibkI+LvgwCWw+YMvelPpLzB/z6YeGqi3dymRHRYpYYQOjSEoJPrUEiJcVcDrV8V/spYqRscNqCTHKTyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeD5OY+ANWfMHULDittecT3pFt+ysF5F5rod6NgcWn8=;
 b=dJfiVEQ2xv5NeTEasgjBUPjJJRF4RjSO+LPtEIyQJTdFt5aJNpiz0JssA2ySZLu7roeijAXRL1s80Ndy3WSQgKO/avMqxaDhkYOc6GOsVdpa8O+yrdZdMH2Aui0+gqDhfTJasxV6dJ/yFP5wtWAH8pAQyzIVBZF5bKiVtmzZX0VKFMXgk9RO5RZoY/kVN7ZeEujKBW/YChLLX5W4RYGAj24GPy5Wp9en98Q0ObPhZul+0xiqGG+0oCI4C5QxnBPn+cJIrIjx6mbJ1TcIH+43VKAKD/1sWSoImf19a7pIHu4vQOFD9jQwZgJYGvYnP/uzfSEYzB94rS+Yx30r0uTwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by CY4PR15MB1527.namprd15.prod.outlook.com (2603:10b6:903:f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 18:52:10 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:52:10 +0000
Message-ID: <22579c38-a478-d6e1-d2c6-f79ffa4555aa@meta.com>
Date:   Wed, 7 Dec 2022 13:52:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 04/13] bpf: rename list_head ->
 datastructure_head in field info types
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-5-davemarchevsky@fb.com>
 <Y4/vQ11buRVt4CBL@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <Y4/vQ11buRVt4CBL@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25)
 To MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|CY4PR15MB1527:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ec3166-5671-4792-9a06-08dad8842557
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +a8kiRS3mWee1RmyNmmUhT8HhD+Ry/YXP95oB7Zz1qMkiTCTcWvVbczTVdDimKEGqbsjgnS5xNHjRez8CUQohdnm5YvUScWqXG9eVVpeHSPP4oCRlVDDYihxlQ66AmCVJgvB0KeiZkyetm2d9XGkrMuYMVi06ezbrqAyAL9ElDhDgeWF9cJBBAoNOvCymWriOunhz4UA9n5nonAyvUo8iFxh2DaBBCpMk+KoYB4X4Rhov6csZT9mztsdWTQ9yduGTliFefJx4jLnrDBTpMcuMeRN98TxLW9O3WqbCubnBXB0bBb+ADDaoHy3VGfwSdaWycCN/Dijo1oCP6x6JJy9hOb1kgQZ3+z9T6jfyYdO8hOXO4H1HpqjM2bgYoBsvcDy3+4mq7DTQJKMPuCZHyg0AVc+UYtwmS/pHVx14BdCcjev6wcXKKSeEEEGnmZVj8BAHunLF4CN+EkZsI5exvN0vzMX1R5Liad4dOfyClwQgJ5Ux63SGnMNJJguTulUKIQi2Sg+2MzBfroAQ45qmAGGfD0Z2EO0x7sWqahqmBKOOHepSjO72DTKe6JeVYKXCWFHzk57Jegv7eq/pRtyX37EReguhZD0XNRABrHvP46xZOfJDmhhWDJ7x2OGeZUI4o5akRPYZGsYrGyd47cp5OLfRR0dy3qcrgH4f1KQglB2NxJoj0Y52iO0ciC7Sy3zJMuKvQ+jBojGv/1LhFk7Vc05wRQDJbg3fu02EG/HP2gfJLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(66899015)(31686004)(478600001)(86362001)(53546011)(36756003)(6506007)(6486002)(83380400001)(186003)(31696002)(38100700002)(2616005)(5660300002)(4326008)(41300700001)(316002)(8676002)(6512007)(6666004)(8936002)(66946007)(66476007)(110136005)(2906002)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UyszSkFIWGJuUlZ1Tll4bjh6UGYzS2xDNTZZczZjZTdGSk1nWElJZ3lDQng3?=
 =?utf-8?B?NmxpdmlwV1YweW9hMmZkZHBGei9TUkdOZHd1RXNyb0k1N1l0QlhUcWNjWVJP?=
 =?utf-8?B?bzIvNjREUEJBcWZiaEJGa3RVelplVFZjRzJkNktwZlFXNG1iZ2ZTbDRYRjVR?=
 =?utf-8?B?S011YU1nZWthbTM0RWQ4K1JlSmtnNjUyNkduenhKTnpMVHY0ajhoK3ZIVXF1?=
 =?utf-8?B?K0RjRitQeEJpTkU5UlZCZHl2V21YTmJRZmRyeFg2bytCTDNLTWhSY3BGbmx5?=
 =?utf-8?B?R3JpbEpsNXVtUEhiWUY0S3FsTUErZ0pVYXlMTVgyYi9XbjIrSzBlNUtFcVR4?=
 =?utf-8?B?TmpLZTJBZmdFcklzRFh2SUxINFpVOGFEc2tjeWw2eDQvYjdkQmVvek9KN0U4?=
 =?utf-8?B?S040akd2bytvSFNNdU11Zi8yTjdqT3QvNzZKK2RMS2FhYnBPclREN2tlVTd5?=
 =?utf-8?B?VkR4SEh5cTkvOGRRUU9qTDZ6eG5IcUdjS1ZYRXhEL1oxYUYxalQvK3ZVSnJP?=
 =?utf-8?B?ZUdGajZPd0JIVHRHY1lER2hGaVNUTHkrcThyN2VKKzR0dmRZcy9tRVdnVWtm?=
 =?utf-8?B?UG5LTGxSMkhhTkNaMkUvQlNaSVNyNVJITHl4UXFBNUs4UEhjNWx5emxuUG1s?=
 =?utf-8?B?cGpibzN6WDF3cFhhd0I0QnRKaC9adGNhRmNURDZTU2s4STVEdTZFT2VRSnRu?=
 =?utf-8?B?SWVqWGNwKy9VUXVUU016Lzg4UmNuR2NvYktPdFdZLy9ZOTl6aGxjb3k3NXhU?=
 =?utf-8?B?dkdTbTg5ajNudDZEZG9qMURZZUo0a1ZoUVNaY3JHZkFrZ3psNGNvcDFvWk5z?=
 =?utf-8?B?OGN4Wm1TanEyeERZUy8yZHdaWFlINjRPTGFnSlo2Ym9jeWd0WHlCT0NBd3Fj?=
 =?utf-8?B?Rk1zM0pjR0hnUVdUN3htTE4xSXkxVEQ2b0JyQit3L2dRTnVlamx4OWZHOFdv?=
 =?utf-8?B?cnl2ZHFrQWxmWjhlSWgvNnNtR1U5dUdGN2Q2Um41emJBampHVFVSWlpja0hu?=
 =?utf-8?B?bDFEempNeks4WTI4ajZNaTl3QlZJSng3Sks0KzErN0tjc0EyT08vTzhockZh?=
 =?utf-8?B?Z1JjUmJQOTQ4TXdZeVk2djEzL2VJU2Y5M3FBUUNvdWJQa01IZ20yLzFiRWUr?=
 =?utf-8?B?aU1zN2kybEJRQlZscndvZ3ZzMVpaTTJkOS9lR0Y0T1NrSlhRY0VYZjY4S292?=
 =?utf-8?B?ZVdMY3RjajhFK2VNNTc1aGdOaExISTdlRkRUQnJCc0lOSm01M0YvNnZ0YWJK?=
 =?utf-8?B?Yk90b1JNUUp6b29Qdml2M1ZPblZDdFU3dmo0YmxjOEFnU3R2WnFpTFVRQks3?=
 =?utf-8?B?elJmeFRRa2hTa0xhOFNTckxhV2dxUnZwRkNjcEtoa29rYmQ5dEpldHNZeFVu?=
 =?utf-8?B?NEFuZnk5YVBuRDQ5bUdnRk5ReFBhUzRQd3pHZDhEZXAwb2kraFNQZVVnOFBr?=
 =?utf-8?B?RW9zYlJpYlNMUHExeWJaeUVnbE16YmZVbW9EMWpLbEpYK1pSaTAwZFl2Qzgv?=
 =?utf-8?B?dkpOdzRhdm81MmpWbk1uRHdjRzQ3NXVJSDZDRlRMNWJJUC9KOWFRN0ZmTFR3?=
 =?utf-8?B?QXhEZS9FWjR4aXBWazJvR3pYdUQwaWFuVGFUYjFZcFh4L2RSK3JnZ3BldEQv?=
 =?utf-8?B?MnM0Y25TTGpuKzQzOU5wN0ZMaDFZYlFKbEJUV3lDSmNWTC94cjQwd3F6dGNv?=
 =?utf-8?B?cVA4dGRDNTNKK2kzSCt2SmtuNHdtVmRkL1Q3VU5ud3Z5SWFWVmNOeVZOU2FT?=
 =?utf-8?B?YUtObFp6VGZRR0xuTG40dlp1UG5zVHczUi82VEJZQjJBcm56RVpVZU5pZ0pP?=
 =?utf-8?B?WjErR0pDVll1czNGSWVhVHk3UjlsYnpqalJ5YVpFRVJYNXU5d3R3RzRSSHJH?=
 =?utf-8?B?WXEzd1NoUm8xRE5QM081VUpFRDU1SkJZS1QxTGcyN0wvM09jSVlKRmxBSUJT?=
 =?utf-8?B?WkdEWWNoSGtwVXhTVkwxenNCeCtqNXlCNFY4UHlXR3FydWpuWTFOTllhZ1RH?=
 =?utf-8?B?U1F2dVQ2SmpnTkZwci9ad1RoOE1UZEtJSi9LaXJTUTA5Z1l2aEdzVnEyY3FU?=
 =?utf-8?B?eCtNSEljS1Nxb29PL3pDV28zaWo2UjlNV0JCOUhmeXIweUsxSFRrM3puNjBM?=
 =?utf-8?B?UFBXdjYxMmlnR3ZwM1JOMXlLZG9FNE16U0JhN1dDY0pmTXczcEtGYVBYanBr?=
 =?utf-8?Q?3Bgns+2mMbgbghBEImXz4iQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec3166-5671-4792-9a06-08dad8842557
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:52:10.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajVty4ZyfZjLoxfgBP+F7WovcFXqyvVo/GwEXohkPzDt+raH82+7ysKh6qBYQeCw3Rl0iFmMKMIXyDtZQbROZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1527
X-Proofpoint-ORIG-GUID: xFFlOLAFrIQomnSSWa7WL0D0vzDttyJV
X-Proofpoint-GUID: xFFlOLAFrIQomnSSWa7WL0D0vzDttyJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/6/22 8:41 PM, Alexei Starovoitov wrote:
> On Tue, Dec 06, 2022 at 03:09:51PM -0800, Dave Marchevsky wrote:
>> Many of the structs recently added to track field info for linked-list
>> head are useful as-is for rbtree root. So let's do a mechanical renaming
>> of list_head-related types and fields:
>>
>> include/linux/bpf.h:
>>   struct btf_field_list_head -> struct btf_field_datastructure_head
>>   list_head -> datastructure_head in struct btf_field union
>> kernel/bpf/btf.c:
>>   list_head -> datastructure_head in struct btf_field_info
> 
> Looking through this patch and others it eventually becomes
> confusing with 'datastructure head' name.
> I'm not sure what is 'head' of the data structure.
> There is head in the link list, but 'head of tree' is odd.
> 
> The attemp here is to find a common name that represents programming
> concept where there is a 'root' and there are 'nodes' that added to that 'root'.
> The 'data structure' name is too broad in that sense.
> Especially later it becomes 'datastructure_api' which is even broader.
> 
> I was thinking to propose:
>  struct btf_field_list_head -> struct btf_field_tree_root
>  list_head -> tree_root in struct btf_field union
> 
> and is_kfunc_tree_api later...
> since link list is a tree too.
> 
> But reading 'tree' next to other names like 'field', 'kfunc'
> it might be mistaken that 'tree' applies to the former.
> So I think using 'graph' as more general concept to describe both
> link list and rb-tree would be the best.
> 
> So the proposal:
>  struct btf_field_list_head -> struct btf_field_graph_root
>  list_head -> graph_root in struct btf_field union
> 
> and is_kfunc_graph_api later...
> 
> 'graph' is short enough and rarely used in names,
> so it stands on its own next to 'field' and in combination
> with other names.
> wdyt?
> 

I'm not a huge fan of 'graph', but it's certainly better than
'datastructure_api', and avoids the "all next-gen datastructures must do this"
implication of a 'ng_ds' name. So will try the rename in v2.

(all specific GRAPH naming suggestions in subsequent patches will
be done as well)

list 'head' -> list 'root' SGTM as well. Not ideal, but alternatives
are worse (rbtree 'head'...)

>>
>> This is a nonfunctional change, functionality to actually use these
>> fields for rbtree will be added in further patches.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  include/linux/bpf.h   |  4 ++--
>>  kernel/bpf/btf.c      | 21 +++++++++++----------
>>  kernel/bpf/helpers.c  |  4 ++--
>>  kernel/bpf/verifier.c | 21 +++++++++++----------
>>  4 files changed, 26 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4920ac252754..9e8b12c7061e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -189,7 +189,7 @@ struct btf_field_kptr {
>>  	u32 btf_id;
>>  };
>>  
>> -struct btf_field_list_head {
>> +struct btf_field_datastructure_head {
>>  	struct btf *btf;
>>  	u32 value_btf_id;
>>  	u32 node_offset;
>> @@ -201,7 +201,7 @@ struct btf_field {
>>  	enum btf_field_type type;
>>  	union {
>>  		struct btf_field_kptr kptr;
>> -		struct btf_field_list_head list_head;
>> +		struct btf_field_datastructure_head datastructure_head;
>>  	};
>>  };
>>  
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index c80bd8709e69..284e3e4b76b7 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3227,7 +3227,7 @@ struct btf_field_info {
>>  		struct {
>>  			const char *node_name;
>>  			u32 value_btf_id;
>> -		} list_head;
>> +		} datastructure_head;
>>  	};
>>  };
>>  
>> @@ -3334,8 +3334,8 @@ static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
>>  		return -EINVAL;
>>  	info->type = BPF_LIST_HEAD;
>>  	info->off = off;
>> -	info->list_head.value_btf_id = id;
>> -	info->list_head.node_name = list_node;
>> +	info->datastructure_head.value_btf_id = id;
>> +	info->datastructure_head.node_name = list_node;
>>  	return BTF_FIELD_FOUND;
>>  }
>>  
>> @@ -3603,13 +3603,14 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
>>  	u32 offset;
>>  	int i;
>>  
>> -	t = btf_type_by_id(btf, info->list_head.value_btf_id);
>> +	t = btf_type_by_id(btf, info->datastructure_head.value_btf_id);
>>  	/* We've already checked that value_btf_id is a struct type. We
>>  	 * just need to figure out the offset of the list_node, and
>>  	 * verify its type.
>>  	 */
>>  	for_each_member(i, t, member) {
>> -		if (strcmp(info->list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
>> +		if (strcmp(info->datastructure_head.node_name,
>> +			   __btf_name_by_offset(btf, member->name_off)))
>>  			continue;
>>  		/* Invalid BTF, two members with same name */
>>  		if (n)
>> @@ -3626,9 +3627,9 @@ static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
>>  		if (offset % __alignof__(struct bpf_list_node))
>>  			return -EINVAL;
>>  
>> -		field->list_head.btf = (struct btf *)btf;
>> -		field->list_head.value_btf_id = info->list_head.value_btf_id;
>> -		field->list_head.node_offset = offset;
>> +		field->datastructure_head.btf = (struct btf *)btf;
>> +		field->datastructure_head.value_btf_id = info->datastructure_head.value_btf_id;
>> +		field->datastructure_head.node_offset = offset;
>>  	}
>>  	if (!n)
>>  		return -ENOENT;
>> @@ -3735,11 +3736,11 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>>  
>>  		if (!(rec->fields[i].type & BPF_LIST_HEAD))
>>  			continue;
>> -		btf_id = rec->fields[i].list_head.value_btf_id;
>> +		btf_id = rec->fields[i].datastructure_head.value_btf_id;
>>  		meta = btf_find_struct_meta(btf, btf_id);
>>  		if (!meta)
>>  			return -EFAULT;
>> -		rec->fields[i].list_head.value_rec = meta->record;
>> +		rec->fields[i].datastructure_head.value_rec = meta->record;
>>  
>>  		if (!(rec->field_mask & BPF_LIST_NODE))
>>  			continue;
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index cca642358e80..6c67740222c2 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1737,12 +1737,12 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>  	while (head != orig_head) {
>>  		void *obj = head;
>>  
>> -		obj -= field->list_head.node_offset;
>> +		obj -= field->datastructure_head.node_offset;
>>  		head = head->next;
>>  		/* The contained type can also have resources, including a
>>  		 * bpf_list_head which needs to be freed.
>>  		 */
>> -		bpf_obj_free_fields(field->list_head.value_rec, obj);
>> +		bpf_obj_free_fields(field->datastructure_head.value_rec, obj);
>>  		/* bpf_mem_free requires migrate_disable(), since we can be
>>  		 * called from map free path as well apart from BPF program (as
>>  		 * part of map ops doing bpf_obj_free_fields).
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6f0aac837d77..bc80b4c4377b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8615,21 +8615,22 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>>  
>>  	field = meta->arg_list_head.field;
>>  
>> -	et = btf_type_by_id(field->list_head.btf, field->list_head.value_btf_id);
>> +	et = btf_type_by_id(field->datastructure_head.btf, field->datastructure_head.value_btf_id);
>>  	t = btf_type_by_id(reg->btf, reg->btf_id);
>> -	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
>> -				  field->list_head.value_btf_id, true)) {
>> +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->datastructure_head.btf,
>> +				  field->datastructure_head.value_btf_id, true)) {
>>  		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node at offset=%d "
>>  			"in struct %s, but arg is at offset=%d in struct %s\n",
>> -			field->list_head.node_offset, btf_name_by_offset(field->list_head.btf, et->name_off),
>> +			field->datastructure_head.node_offset,
>> +			btf_name_by_offset(field->datastructure_head.btf, et->name_off),
>>  			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (list_node_off != field->list_head.node_offset) {
>> +	if (list_node_off != field->datastructure_head.node_offset) {
>>  		verbose(env, "arg#1 offset=%d, but expected bpf_list_node at offset=%d in struct %s\n",
>> -			list_node_off, field->list_head.node_offset,
>> -			btf_name_by_offset(field->list_head.btf, et->name_off));
>> +			list_node_off, field->datastructure_head.node_offset,
>> +			btf_name_by_offset(field->datastructure_head.btf, et->name_off));
>>  		return -EINVAL;
>>  	}
>>  	/* Set arg#1 for expiration after unlock */
>> @@ -9078,9 +9079,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  
>>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
>> -				regs[BPF_REG_0].btf = field->list_head.btf;
>> -				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
>> -				regs[BPF_REG_0].off = field->list_head.node_offset;
>> +				regs[BPF_REG_0].btf = field->datastructure_head.btf;
>> +				regs[BPF_REG_0].btf_id = field->datastructure_head.value_btf_id;
>> +				regs[BPF_REG_0].off = field->datastructure_head.node_offset;
>>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
>> -- 
>> 2.30.2
>>
