Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BB592914
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiHOFeV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 01:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFeU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 01:34:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E471582B
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 22:34:19 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F1fwnm031003;
        Sun, 14 Aug 2022 22:34:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C0M3lGUkUjIW646XuxJZ1So/1+QbNfPblXFEonQVG9Q=;
 b=rJWzMeP+0dm1DS7lFVD1PNygo14i0dpPZx88IXgmZSl/9lnImLj9aG1fawi2XmHJZ8bq
 2/88Ew8XEAEZOnBQ5QBQc8Q7adOBnWfjfTJLJHAIIbkT+hA/ucxj7RaKSbe0lRQfD/xE
 kJIrq4q6SEGgLLUozm2hf3TvXrzXaqKo468= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hxb93qrk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Aug 2022 22:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njga1rLg2nxaNZkYqvuGQ6UDz/QKgo1cOZfYNJLG8JNPFpCKTqSGqEtgGA+7l1cA0IGawZVKKoUPAq7NJdWfuu5UzzUBlZ5NB/8K1I+hyIZYmKEZRE0A+J8s3k6KNduRVqd8b0jGCUyoKI/sVcrlcBMyQCip/RGzZziPjayyOKWTGP6nGPI6SjhAkLGiI1knZYMofM0h4BslcNNlpe7PX4HJJAQzpMlYTh54eNuzBhNQbP3oxFQhT7weApfHowAjLxjwQ0G68fxx863xiPM1Y0eSH1ROw4/lQzM+Ygp1DdCIuRgYGsQ0Enn6KMwd1gjDVnkyDOOK9Hi7VM2V1Ify2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0M3lGUkUjIW646XuxJZ1So/1+QbNfPblXFEonQVG9Q=;
 b=CFWy0K1KbxTfW8KHrjuIbJ9DntVBUf0LXyQIeHbpAU/gQ2R/NzfC8ummEnx4VfUWreHqS07Ua+DusRyAmGWISMiu04Da90Qwpt8wS2f99FaIBzAM+TDeRO/mMwv3KXhcyqgO6YUyo0yr7xPPZyPLhYyAIPx78Sz8wa+LIbISgEkv6Vrbc8yWeGgbk+PVPy7MjEHFdk5oCKPntBrJ2y6JVPUAvS0OzM0ij2zTOMe08hlwx0rZQP33V48v2dz4AfIcfApzmfLd14nyr4TBMllSTTTs7vXOqNR0JArXY6RBD+PXSHE3PDfJRuD2GralbAT8AJMokhZ7j6a27jRHRmgQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4779.namprd15.prod.outlook.com (2603:10b6:303:10d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 05:34:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 05:34:01 +0000
Message-ID: <18a8e565-95d0-80e1-b596-95babf279912@fb.com>
Date:   Sun, 14 Aug 2022 22:33:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to
 rbtree
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com>
 <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
 <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ae8398c-ac5a-41da-72b3-08da7e7fc27d
X-MS-TrafficTypeDiagnostic: MW4PR15MB4779:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL4Cn8NYvGUOVkFJmJF70nHsL1Ma9fbk7HDKiFsz3CKlIYnhTs8ndK9jd6EMEmMdwHWC5plLsYKtab8xw/UruQCHr9XJlciO4NBb9xeeQo7Co245/BhQQwPvqcaiOw4xu6Iu9TZtS5yd5YGTpeyMd0XlcUd2gxNuwF6/oE7tXdjE8vCulPWhZbDW3Wngr0kdT2/WnPnQoY4eTPEFGOdtAh8iErmsulei35B+MkLJF54qYqNPZMjcbFkDhKl71HcTVp8zP692VE4WE+h+TvUUvO2JFqag6niIjsTfATdhytETeVcRsuZxptHxxqGc5fI5kFQfGcLwcXDa6x70rripvF6TShCLmpZDOr/JEHLjtlyijkw5BtTifua81zgoNDjSfb4YZBOia2qdbo6C462z2HPNfm+jxlbEbCU0E3YT5nZ2M5X8bFAabEyvpHbZk3vIhdqKfYrU+0iuT93zNxLRxf5rDLf5rSIODiTeRI5/G7VJd+U6ur4vLxYLNS5Hs+sbjm5aI9Wqbi3vAhO9UOvR9CbdWNVOqLEk4Q6QIBNshZgFTwyHA6oXKidxomkjHFGEt6UFkbE6lIjY/MLALDSYyXw4CWtq3cdb45ucogTAeQqQCtX+AvvSWIk6CmwcEqt2Hwm1BxGuaJ3Fkrtof2uP8+VI/cvd2ysIfIspt8H45bgSAJSCIFdEXCvVF2HzjrMfNdcWFCGxbFPlGCduJL0+pbt5EL0CE+hpup72BUVj2HIgVFXFHugVO+Ooo41dW+HCGdBi+AGdEd5RiGh/nuewxvN32wCaXBCAwXS9Iys1T8BbqtT1vPhr8hEODKwG94x5eNKT7LvztRCuTzJbjevdtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(6636002)(66946007)(66476007)(316002)(8676002)(4326008)(66556008)(38100700002)(110136005)(2906002)(8936002)(5660300002)(54906003)(478600001)(86362001)(6486002)(31696002)(41300700001)(36756003)(6506007)(186003)(2616005)(83380400001)(53546011)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVrakx5a3RnaTJ3NTc3Uzg4RE9JcElDSjM5SzdZWXBIWk9hbmtNNVA5OWd1?=
 =?utf-8?B?cUZRZjA4WDkxUWJvb1JaZFNOaTVOc2s3NjNSSkY3S1EyOHJibGRRdVpPbENR?=
 =?utf-8?B?SWJXNXQ3eDFiczhkWVhZWHRGSTU3QmZJUFJuK2FjME8waDc2b3lNZWtET1g1?=
 =?utf-8?B?cHNxQkpkVm5UdVZ5blRHSUdxOHdEWUpHRkxyTjRleW9UU01mVWNiMmVwS1NS?=
 =?utf-8?B?QzUxbEU0U2s5WmRmQXJEZ1Jzd2VoZmdEN0puZ1A5Wnc3YzRmdG5neVpudmVX?=
 =?utf-8?B?ZUJDeXN1UitiSVlvbGVGWHBpbFRIWkJ4ckxaRzVrMUM1LzhrZHY3NGg0MTBv?=
 =?utf-8?B?d1hNQkNTQ1gzTnZDTUhwejVXRzVtb0VlZXVLaUtWQlNzeFI4dzNQWnhhcndO?=
 =?utf-8?B?cy9SRm55cFBqVmw5VmVxTGQyQ2tZK20zMVU2QlBFMTREaVgwOCtCbUFtWXRB?=
 =?utf-8?B?djE0TzVZYlFhVmM5eXBEVnRncTNWTU1ZaHVZNER2VDE0OUpMbllBYlYvNGZP?=
 =?utf-8?B?TklFMGd2UFBudTZ0SXlybGVsV3NtcTRsVEVkRFQzUmpGcmx6QzRyZlc0SVZt?=
 =?utf-8?B?ekNkQ096aG9peUZzRUpuSVNOWVRQUjVNQWdCVDhzbDA5aFVQNDViN1kzMlQw?=
 =?utf-8?B?SkxIeDZuNStta3h6YW1yRDdtWjRVTkI4R1Y3K2tuM0dtUjlJdXhGNDIyYzRy?=
 =?utf-8?B?OEpRUjZ6eGRJVDh6dm0xcm5rL2F4aU9aNUNUdlRWYXVZOTl1UDR3b0NsUFVI?=
 =?utf-8?B?Q1hZK1FSY09yVWNFYmtaWEU2ZUE0akh5Rzc0ZjV5eUI2emtTNWozNDNVWmh0?=
 =?utf-8?B?TWZWVmx1SFYwZjFTUjBEaERIOWJVbTBJR1BFSWNIN0NaMUFZZ2NjU292bGJD?=
 =?utf-8?B?bmlVU2lTZE5ibWY0Q2FYRkFkVTYxelBkRFhoSFJvTWhxVVhna3p4eEl4OWc0?=
 =?utf-8?B?bjFBYjJUQk1CaWZrWnlNMStNSUNpWmU4UmMvNjBUazRQME5IOUNGNUxPZDNZ?=
 =?utf-8?B?NzArdzFtM00zQXE2RGhOSzJSSnJiVzNPSUhFMDB3R2NUVGN2NGVEKytncXBx?=
 =?utf-8?B?NU1Ba2doOU5Ka3VkWG11VkhOL1hGaEcvQlJDa3NQR1M2ZUE3OUxCNjJuSTVz?=
 =?utf-8?B?RzdCdkp0b0lvY0FTZGI0UjB3dXVGeEM2aUFTVWZHNy9jeUhpMW9CTFU5QXU2?=
 =?utf-8?B?RjdVRzhCUWtzNnFYMVQrZHoxc2k0ZzVYRFJFWk5WRVdFcCt3aHJHYXFabXRa?=
 =?utf-8?B?a1lXMngxVXB0ejc2YlpzeDBrMVhjZ3g3SW9qOTVYbHdQV0w5bmRUT2JETUpz?=
 =?utf-8?B?ejh2NjNGYVR0ZE10d1JvOVNqRDZNakFCUmtQdmFkc2gzVGRqenZLZ2w5Zytl?=
 =?utf-8?B?b0UrWFpPYmhlMCs3R1l0bHZLbWo2Mk81MkFpb1pPWkFaQzl6cThKRkxTWTNy?=
 =?utf-8?B?anByRVVOemJKcHJoM2prZHF6YTE4R21BVS85TVBDTnpqbE9CaU9XVEpzdm9E?=
 =?utf-8?B?L3dIdUJYZ2VPbW9XQm5RMkY0UldoU3pqUHBHUElQT05lT1hyWDJFcmhyRFU3?=
 =?utf-8?B?aCsrR2ZhYUQvU0haUXRNdVNqLzVuc1lQdzNOS2FTUVZSbktvZ1RuRmlDWkZU?=
 =?utf-8?B?cVFDbTFYRloyblNPMFpadWZSbFNINmdyMlV4b3pVSkQzRURzY1BqamdBSWVI?=
 =?utf-8?B?b3djT2Q0NzN3VjNKRDFYdEZQMWgyVSt2SlZTUkhqNmIyZ1dseG1XbXF2bisx?=
 =?utf-8?B?Y3NkWlZHdVFiTStGbXdjNlloWiswTXFWQ2pWMUxUV083VEx6cDhmU0pKTEdW?=
 =?utf-8?B?bUk4SkQ4SGptcHN5VnlLZ2VwZGladXh4TDI0QWxRbjlMQjFHWWN0dlhjQmJy?=
 =?utf-8?B?czMyOUM3QVdtdmpONms2SXpnc29qSFRqMXBOQi9UVzlDSHhYZGRlbWRYWk5w?=
 =?utf-8?B?cS9KM3NjU0srQjhOWnpHWjV4dmtMQjQ4Mi9GMFNJYXFZMnNQUFdKRG9DM0pG?=
 =?utf-8?B?c0FoZCtQYy9lU3owR1doNjRQVnBFWmtPRTlkWUZLTE9VbjRlaU5VVmpJU2dZ?=
 =?utf-8?B?cWZYNlFvUUI3UlVvT2dBbkU0SXBERzRRVnFUN1RkajBKSlVqZlozczJ4d3M2?=
 =?utf-8?B?dEY0aG5pbnJQOWw0VS9vWkpYb0Q2QXpaTS9jK25pdlZZY3ZEaWticmx5L3Q3?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae8398c-ac5a-41da-72b3-08da7e7fc27d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 05:34:01.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FseBNKUXRNHM9b94yzkXhXelgbj5Z459KrLswvH+1OiE6L60LGEiEbwFT0civKPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4779
X-Proofpoint-GUID: x__YfvZuftwHI_AlC7GqtkTziYX4cE8Y
X-Proofpoint-ORIG-GUID: x__YfvZuftwHI_AlC7GqtkTziYX4cE8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/10/22 2:46 PM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 2 Aug 2022 at 00:23, Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>>> This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
>>> well as a bpf_rbtree_get_lock helper which allows bpf programs to access
>>> the lock.
>>>
>>> Ideally the bpf_spin_lock would be created independently oustide of the
>>> tree and associated with it before the tree is used, either as part of
>>> map definition or via some call like rbtree_init(&rbtree, &lock). Doing
>>> this in an ergonomic way is proving harder than expected, so for now use
>>> this workaround.
>>>
>>> Why is creating the bpf_spin_lock independently and associating it with
>>> the tree preferable? Because we want to be able to transfer nodes
>>> between trees atomically, and for this to work need same lock associated
>>> with 2 trees.
>>
>> Right. We need one lock to protect multiple rbtrees.
>> Since add/find/remove helpers will look into rbtree->lock
>> the two different rbtree (== map) have to point to the same lock.
>> Other than rbtree_init(&rbtree, &lock) what would be an alternative ?
>>
>>>
>>> Further locking-related patches will make it possible for the lock to be
>>> used in BPF programs and add code which enforces that the lock is held
>>> when doing any operation on the tree.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> ---
>>>    include/uapi/linux/bpf.h       |  7 +++++++
>>>    kernel/bpf/helpers.c           |  3 +++
>>>    kernel/bpf/rbtree.c            | 24 ++++++++++++++++++++++++
>>>    tools/include/uapi/linux/bpf.h |  7 +++++++
>>>    4 files changed, 41 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 4688ce88caf4..c677d92de3bc 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -5385,6 +5385,12 @@ union bpf_attr {
>>>     *  Return
>>>     *          0
>>>     *
>>> + * void *bpf_rbtree_get_lock(struct bpf_map *map)
>>> + *   Description
>>> + *           Return the bpf_spin_lock associated with the rbtree
>>> + *
>>> + *   Return
>>> + *           Ptr to lock
>>>     */
>>>    #define __BPF_FUNC_MAPPER(FN)               \
>>>        FN(unspec),                     \
>>> @@ -5600,6 +5606,7 @@ union bpf_attr {
>>>        FN(rbtree_find),                \
>>>        FN(rbtree_remove),              \
>>>        FN(rbtree_free_node),           \
>>> +     FN(rbtree_get_lock),            \
>>>        /* */
>>>
>>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 35eb66d11bf6..257a808bb767 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -1587,6 +1587,7 @@ const struct bpf_func_proto bpf_rbtree_add_proto __weak;
>>>    const struct bpf_func_proto bpf_rbtree_find_proto __weak;
>>>    const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
>>>    const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
>>> +const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
>>>
>>>    const struct bpf_func_proto *
>>>    bpf_base_func_proto(enum bpf_func_id func_id)
>>> @@ -1686,6 +1687,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>>                return &bpf_rbtree_remove_proto;
>>>        case BPF_FUNC_rbtree_free_node:
>>>                return &bpf_rbtree_free_node_proto;
>>> +     case BPF_FUNC_rbtree_get_lock:
>>> +             return &bpf_rbtree_get_lock_proto;
>>>        default:
>>>                break;
>>>        }
>>> diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
>>> index 250d62210804..c6f0a2a083f6 100644
>>> --- a/kernel/bpf/rbtree.c
>>> +++ b/kernel/bpf/rbtree.c
>>> @@ -9,6 +9,7 @@
>>>    struct bpf_rbtree {
>>>        struct bpf_map map;
>>>        struct rb_root_cached root;
>>> +     struct bpf_spin_lock *lock;
>>>    };
>>>
>>>    BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
>>> @@ -39,6 +40,14 @@ static struct bpf_map *rbtree_map_alloc(union bpf_attr *attr)
>>>
>>>        tree->root = RB_ROOT_CACHED;
>>>        bpf_map_init_from_attr(&tree->map, attr);
>>> +
>>> +     tree->lock = bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock),
>>> +                                  GFP_KERNEL | __GFP_NOWARN);
>>> +     if (!tree->lock) {
>>> +             bpf_map_area_free(tree);
>>> +             return ERR_PTR(-ENOMEM);
>>> +     }
>>> +
>>>        return &tree->map;
>>>    }
>>>
>>> @@ -139,6 +148,7 @@ static void rbtree_map_free(struct bpf_map *map)
>>>
>>>        bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
>>>                kfree(pos);
>>> +     kfree(tree->lock);
>>>        bpf_map_area_free(tree);
>>>    }
>>>
>>> @@ -238,6 +248,20 @@ static int rbtree_map_get_next_key(struct bpf_map *map, void *key,
>>>        return -ENOTSUPP;
>>>    }
>>>
>>> +BPF_CALL_1(bpf_rbtree_get_lock, struct bpf_map *, map)
>>> +{
>>> +     struct bpf_rbtree *tree = container_of(map, struct bpf_rbtree, map);
>>> +
>>> +     return (u64)tree->lock;
>>> +}
>>> +
>>> +const struct bpf_func_proto bpf_rbtree_get_lock_proto = {
>>> +     .func = bpf_rbtree_get_lock,
>>> +     .gpl_only = true,
>>> +     .ret_type = RET_PTR_TO_MAP_VALUE,
>>
>> This hack and
>>
>> +const struct bpf_func_proto bpf_rbtree_unlock_proto = {
>> +       .func = bpf_rbtree_unlock,
>> +       .gpl_only = true,
>> +       .ret_type = RET_INTEGER,
>> +       .arg1_type = ARG_PTR_TO_SPIN_LOCK,
>>
>> may be too much arm twisting to reuse bpf_spin_lock.
>>
>> May be return ptr_to_btf_id here and bpf_rbtree_lock
>> should match the type?
>> It could be new 'struct bpf_lock' in kernel's BTF.
>>
>> Let's figure out how to associate locks with rbtrees.
>>
>> Reiterating my proposal that was done earlier in the context
>> of Delyan's irq_work, but for different type:
>> How about:
>> struct bpf_lock *l;
>> l = bpf_mem_alloc(allocator, bpf_core_type_id_kernel(*l));
>>
>> that would allocate ptr_to_btf_id object from kernel's btf.
>> The bpf_lock would have constructor and destructor provided by the
>> kernel code.
>> constructor will set bpf_lock's refcnt to 1.
>> then bpf_rbtree_init(&map, lock) will bump the refcnt.
>> and dtor will eventually free it when all rbtrees are freed.
>> That would be similar to kptr's logic with kptr_get and dtor's
>> associated with kernel's btf_id-s.
> 
> Just to continue brainstorming: Comments on this?
> 
> Instead of a rbtree map, you have a struct bpf_rbtree global variable
> which works like a rbtree. To associate a lock with multiple
> bpf_rbtree, you do clang style thread safety annotation in the bpf
> program:
> 
> #define __guarded_by(lock) __attribute__((btf_type_tag("guarded_by:" #lock))
> 
> struct bpf_spin_lock shared_lock;
> struct bpf_rbtree rbtree1 __guarded_by(shared_lock);
> struct bpf_rbtree rbtree2 __guarded_by(shared_lock);

For the above __guarded_by macro, we should use
btf_decl_tag instead of btf_type_tag

#define __guarded_by(lock) __attribute__((btf_decl_tag("guarded_by:" #lock))

Currently, in llvm implementation, btf_type_tag only applies
to pointee type's. btf_decl_tag can apply to global variable,
function argument, function return value and struct/union members.
So btf_decl_tag shoul work for the above global variable case or
below struct rbtree_set member case.

> 
> guarded_by tag is mandatory for the rbtree. Verifier ensures
> shared_lock spin lock is held whenever rbtree1 or rbtree2 is being
> accessed, and whitelists add/remove helpers inside the critical
> section.
> 
> I don't think associating locks to rbtree dynamically is a hard
> requirement for your use case? But if you need that, you may probably
> also allocate sets of rbtree that are part of the same lock "class"
> dynamically using bpf_kptr_alloc, and do similar annotation for the
> struct being allocated.
> struct rbtree_set {
>    struct bpf_spin_lock lock;
>    struct bpf_rbtree rbtree1 __guarded_by(lock);
>    struct bpf_rbtree rbtree2 __guarded_by(lock);
> };
> struct rbtree_set *s = bpf_kptr_alloc(sizeof(*s), btf_local_type_id(*s));
> // Just stash the pointer somewhere with kptr_xchg
> On bpf_kptr_free, the verifier knows this is not a "trivial" struct,
> so inserts destructor calls for bpf_rbtree fields during program
> fixup.
> 
> The main insight is that lock and rbtree are part of the same
> allocation (map value for global case, ptr_to_btf_id for dynamic case)
> so the locked state can be bound to the reg state in the verifier.
> Then we can also make this new rbtree API use kfuncs instead of UAPI
> helpers, to get some field experience before baking it in.
> 
> Any opinions? Any brainos or deficiencies in the scheme above?
> 
> Background: I have been thinking about how I can bind kptr and normal
> data synchronization without having unneeded atomic xchg cost when
> lock is already protecting kptr. In my tests this guarded_by
> annotation has been proving very useful (you mark data and kptr
> protected by lock as guarded_by some spin lock member in same map
> value, verifier ensures lock is held during access, and kptr_xchg for
> guarded kptr is lowered to non-atomic load/store assuming no
> concurrent access, and kptr_xchg from outside the lock section is
> rejected).
