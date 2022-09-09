Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01695B4283
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIIWav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIIWau (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:30:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5690197
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:30:49 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 289LdD49009285;
        Fri, 9 Sep 2022 15:30:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=snmKJe7kFqbAqp+SCXiuAl77f6k6F1sQ0FuhJELgPLA=;
 b=DHX77qcjV1B2eUlkXaGAwMu5LGbS13Ja9qNYCiwiHOhc43FvUNmyeyBQhmS5kpn/y47s
 CSOixfk5hsKDjiP0zwAGKNbNB7gRe9uOw5xzFh8bdGsN+KvyQsicGHkCAY+aATsaVS6I
 NS5J5ac6XqGv3ngXuUvMQp8+p/600C46GPA= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jfu2wevta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 15:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKZU8tTDZy1Jw/TiPKiVhakrte3FakwgDgH4AOFEX6kQECNUAAGzW4qnLo4DGht7rJkvlDq5WrElMxXMDA5MU5lugXO3nYAEYs/SAqeuYYlqYXK4tWh2SS9oEbAWTE8aj/efu4kJDvm1waXBvFGzyzlpPC5mjkBJ41Y/SZ2C6cXT2VNxPIlngPjbgtzaWUWV9takrxi4t4yzw2n0P5hNIdugYZFsVy+4p/ctmuTAKILgIBlaLkQU9xBI4LHy7j1Hl96sWJr6byXNn+jfrg3KdqWcqOXITk+SEME5pU0b+KQ+sDEOuGl/hCnj8CdLcZQSXasyyrkGoFwwhhGkjI2NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snmKJe7kFqbAqp+SCXiuAl77f6k6F1sQ0FuhJELgPLA=;
 b=TZ3RafDe3nTsdyMk27cRyJCZJy4sCMIOLogoTg8pNgFnT1PXG3zmZ8Hy+RU3igPjoDKAzbs1jI3ogh8ssplKiSAcsqutOZRUvMBf7/m69V5gFiXWBo7yaNSMbLuMtTWu5xkD9jnt3NhjyW1oQv6ubxuQvJ1Nu/jro6vmJoE1PWNEkQCWeWCjlKbECapZFRozqTv4jk7PshfHnjxlujP33uhqCYgrYmlFDXC6z1iCDZjDLvR6Ba4wmk2J4bkfAhBbTpvJoi+mcRKSr+0G79BrygJeeIck2EEemJVxLlGUW92j8Bgjp7xStSPopJ4C3ZBZS54JTh1L73btLRFWAXBwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB2797.namprd15.prod.outlook.com (2603:10b6:208:12b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Fri, 9 Sep
 2022 22:30:31 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 22:30:31 +0000
Message-ID: <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com>
Date:   Fri, 9 Sep 2022 18:30:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
 <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e84582-6b40-464c-d2f7-08da92b2e770
X-MS-TrafficTypeDiagnostic: MN2PR15MB2797:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSK7Krb0aj6gbVabqKDes2SSiTVIJT0OHCU+f2Q3fPBdcyTbEp2lpJP72uPPWQXawU94wimYDzlvhkSmC4Ap+xBvjrEiYK0Ck+zb8VBHtfsqOMJyX+7MTAG9wPZ73XJ/5Z8hZuHz3LR4AbtF9dwCE/cQduzoXilU/+F2an3uihhtWAY8uPmol05Z+eyxbuMdLwXxk3cMbKP2GY1KA7PgGBSGDNbRO5WMYGigEz86ougwFP1jA4Gb+17yMA0+nT1m/z9e63BX1napuRb1mKJdlDD7uw6RkSEF6fUrR/BIxpRr4K4izjn3uaDjt1xPiZFUagp8JlB1bTsYFDan2o5e+AJqPLehYxjqzV7IxWUvqIbZjpl+AXgOJ9xfzz5wFo6LCDWIgIUUMPg3fFOBbMMVQNyuVMNyydHexDuHrarh5vRnRYoYBUjEgmiHSM9hBw/slGOOM5xV8RtJzQT8QjBIJjtMfI8OjSKLZPaMpxVpLERUw3krZ1o6k78xDlNInYdsHfq7qHvhmjtirBMPiYjNhiOZ9A8y16zjZyqv/zRuvvgyeiE4bV0LfqRNe1/OARN/819mZPHAIiK4vbJpP2T2tBftQNmKp9VI6Q7CnlGg4MdOjGBMQntcGZCvbAhCTBBM34Isimfcg5u232AndUe1R4T6aYZ0cfU6xyZNxKYvlarU3quFkn2biRp51KXxUOkOVe1tMmjIXYpSyS/c7y+tKW8yaoivLrEDGNqbKE2kfnKonqRV7VpJmnq/5wYHsHnaFElLyspmvd1EKw/R3NYx1bPZnKhzC6cyNMNLFH9jaRbwCXCBkqyKKDgMWZrm8CZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(66476007)(5660300002)(4326008)(66556008)(186003)(2906002)(38100700002)(66946007)(8936002)(31686004)(8676002)(36756003)(6486002)(478600001)(31696002)(86362001)(41300700001)(110136005)(54906003)(316002)(2616005)(6506007)(53546011)(6512007)(83380400001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUQ5c25YeVFPRWZuTTVsY05FQTVTSEI0WG5jdVFPYjdSSFBjOFk1RmNacGMy?=
 =?utf-8?B?Qm5CaXBkK1RicmlEM2J1M0Z6b0FxS3Rhdlh5SEhqNDVJMzNEbzJVYy84QW9q?=
 =?utf-8?B?UnNMcmVCb2pSVTQ5YjNxNW5vM3RpWjByNnl4ZHY3UE5tVjROU212UG5aLzhE?=
 =?utf-8?B?T2dQK0xxcE5FbU1Ka2ZITDZZQkRmVUxaNXZpdjEzUkhIcW9zUFBMb2k1d25l?=
 =?utf-8?B?SkRtRGJFbzFjTE8vTFNDNHNQaE1Vbk5lY1k5dGU1eEhTc0RtcU81Qm9aVzFW?=
 =?utf-8?B?L0VTKzVDTFJPUkJ6ZzBpb2JDVVcyOFlsVjhaU0UxaEUxQjY1WGJLMVBrbmM5?=
 =?utf-8?B?ZVdOa2VMWk5qT0xySWtYc29IMnk5d2lobUJLT1gzSU5qeFV1ekI4QXBMZDY0?=
 =?utf-8?B?MFU3Ym8wTzNnQitPdUtrdHJ0bWk0SStXalM2TXlpUmNvUFM4cVk2TDg1VVVn?=
 =?utf-8?B?d3lNbjhkaWpyQVV3b2Z4cW82VTg1K0JGSW5xczJGdVVENEp0NW1kYUg0K2FH?=
 =?utf-8?B?OVdqOGxnajJmeUtoT3JLbExqTWhkOHJLMm9URU4zL3RkYk12V0xiUk5IMm85?=
 =?utf-8?B?bERnU1NKa0xpUzZtNXBiS0V1blkzV0txZmltY1VEZGpGaDU2US9jMjJ5anN1?=
 =?utf-8?B?N0lVcnFSZGx2LzRIYWEzRk8xK2RjdXZiWFlpeUdWdS93WDRBeE9iaXZDUjVl?=
 =?utf-8?B?ai9tTlVwVjFRbmNKTXhYSGJzUUVqNytNK2NiQzBKY1dxSERlbkhnTS9sQUIw?=
 =?utf-8?B?Zjg3MjZLWklqRGI3ZXM4THVUSTZKT2pBSmN4VHkzV2tERWRzMUVFYW1CUUFM?=
 =?utf-8?B?RlR6NWN1eEpTQ1l6SExPUnFoRE1Uc1puMXhGQ2RWVk00OXR5ZytaWjc3eDVj?=
 =?utf-8?B?eVc1RzMwUXVuNGJqMkRZOFBCS2xNTEpsOEVRbWliZE9Lb3JOcCtQdXpDZnBE?=
 =?utf-8?B?VnNXU00rdExRMWd2TUpmUzR5THpGS3BaQ3JheW5HYllLNlRjbDNCYks4Nld3?=
 =?utf-8?B?MmZxQlMySFBIYWpCYmxBVTd3T2J5dlNRRGR4cktNblJtZFoyeHdCbzg2dFc3?=
 =?utf-8?B?N3U1dFdJb1V3V2gxZys5ZGl2NDdVTzVJNG93ZmlXZEViTEttNmtxNmRDU2hW?=
 =?utf-8?B?S2t3S0VsaUc5N0FuRFhPcWNYblhjYkJuU1NoZC9FWnJNeUgxQVNqTFdQOUxi?=
 =?utf-8?B?ZjNKWERCeG9pR29aV0ZaRElVOGxXczkvcWloYklMbVlkRmlwLzhsTmlGRGo4?=
 =?utf-8?B?NWlPZjJIZUgrT3lQbFM2ckhrbDV2QzA1NkVqSW9VcUR0ZElmcVY1QXRFWVpz?=
 =?utf-8?B?MjJneVFVYjYxVXVoZzVpTFJUWkhFeUlUcVJXL1JwQ2llRzVZTkxjMUVpbmJU?=
 =?utf-8?B?R2lLY0ZMM3M4OEl1V1MvTXdTV1dlaDVjQzJYWUlBRTVPQ2hLaENFUkpnOVlh?=
 =?utf-8?B?QUJBZzN5d05RUlFHbnFTQ0hSVWF2Qlh3YnVHT1N1RENCV2xVQzZaSlFNNWRm?=
 =?utf-8?B?MnpDOXphNDVHM2hBUE1oeDlXem5uTUErSkcvNENxaHFwcFNmWDZMVW5QWEp6?=
 =?utf-8?B?MlI4aGFzcHVYdGE4SGI1ZFlrZVdPTndyRE1lVTlheVdoWFhGUTRzdnRDaTJC?=
 =?utf-8?B?QzE3ZCt5RENlUGk3Z05UMDBBYzNYOENOTzAyTmNHVUt2aFArZnVDQUkvK0E0?=
 =?utf-8?B?U1BtT1lGdFB0QnhRamlmOE1xTTF3L2gvNDdLSk5kdUpBS1ZGeEw1Nyt3SnQy?=
 =?utf-8?B?eVBPQm9pWEVMQ3pLaVJuOWNtUUZsRWYrcDZpWDJDNUM3NjlCWjE4MHd0dDBK?=
 =?utf-8?B?UW5aUlFLcGgyZWRvRjdXWlQybnBkYTMyQmQ1N2xMOGNCbDBvWVZvTkhmTm5q?=
 =?utf-8?B?S0xjK0pSZ25uUjNHKzduVXlhUEc2N2RjWTAvNlUxMi9pYzlRUHpadE4rWGI5?=
 =?utf-8?B?WGxTSXZjQTFITTZEcC9UeU5MQVBwL2lvaG5kV2ZVKzRVaEJIZnY5T0Urankx?=
 =?utf-8?B?Z3U2cmdpeVVPVzZ1bS9OVS9NQlNKa0VTQTc2NkorMDBQZXRZYnM4a0c0ZzRE?=
 =?utf-8?B?Y3cxUmYvenFweURCbFB6WHc5VjJFMUI5eWlRN2lQaktpYmNiZDY3WVN0U3NE?=
 =?utf-8?B?bnRVVlF6alNDcW5VU2VrUy92cExVcmN2THkvN3E0UDBSbXhnUXovU082ampH?=
 =?utf-8?Q?YMv/BNQTQzuzT2vMYMUL3XI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e84582-6b40-464c-d2f7-08da92b2e770
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 22:30:31.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtSMISb3JrHG+U8n9ar5CZ9btuNVdabCUN4RnEUtJTYgXh+66YgaWkOlTup6PxRp775EH/agi892pRqVfrCiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2797
X-Proofpoint-ORIG-GUID: jqa2kiZ4WXgpmMW67T9WqwfufkV86_8j
X-Proofpoint-GUID: jqa2kiZ4WXgpmMW67T9WqwfufkV86_8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/9/22 3:25 PM, Alexei Starovoitov wrote:
> On Fri, Sep 09, 2022 at 11:32:40AM -0700, Andrii Nakryiko wrote:
>> On Fri, Sep 9, 2022 at 7:58 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>>
>>>> On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>
>>>>> On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>>>>>
>>>>>>> On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
>>>>>>>> Global variables reside in maps accessible using direct_value_addr
>>>>>>>> callbacks, so giving each load instruction's rewrite a unique reg->id
>>>>>>>> disallows us from holding locks which are global.
>>>>>>>>
>>>>>>>> This is not great, so refactor the active_spin_lock into two separate
>>>>>>>> fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
>>>>>>>> enough to allow it for global variables, map lookups, and local kptr
>>>>>>>> registers at the same time.
>>>>>>>>
>>>>>>>> Held vs non-held is indicated by active_spin_lock_ptr, which stores the
>>>>>>>> reg->map_ptr or reg->btf pointer of the register used for locking spin
>>>>>>>> lock. But the active_spin_lock_id also needs to be compared to ensure
>>>>>>>> whether bpf_spin_unlock is for the same register.
>>>>>>>>
>>>>>>>> Next, pseudo load instructions are not given a unique reg->id, as they
>>>>>>>> are doing lookup for the same map value (max_entries is never greater
>>>>>>>> than 1).
>>>>>>>>
>>>>>>>
>>>>>>> For libbpf-style "internal maps" - like .bss.private further in this series -
>>>>>>> all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
>>>>>>>
>>>>>>>   struct bpf_spin_lock lock1 SEC(".bss.private");
>>>>>>>   struct bpf_spin_lock lock2 SEC(".bss.private");
>>>>>>>   ...
>>>>>>>   spin_lock(&lock1);
>>>>>>>   ...
>>>>>>>   spin_lock(&lock2);
>>>>>>>
>>>>>>> will result in same map but different offsets for the direct read (and different
>>>>>>> aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
>>>>>>> this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
>>>>>>>
>>>>>>
>>>>>> That won't be a problem. Two spin locks in a map value or datasec are
>>>>>> already rejected on BPF_MAP_CREATE,
>>>>>> so there is no bug. See idx >= info_cnt check in
>>>>>> btf_find_struct_field, btf_find_datasec_var.
>>>>>>
>>>>>> I can include offset as the third part of the tuple. The problem then
>>>>>> is figuring out which lock protects which bpf_list_head. We need
>>>>>> another __guarded_by annotation and force users to use that to
>>>>>> eliminate the ambiguity. So for now I just put it in the commit log
>>>>>> and left it for the future.
>>>>>
>>>>> Let's not go that far yet.
>>>>> Extra annotations are just as confusing and non-obvious as
>>>>> putting locks in different sections.
>>>>> Let's keep one lock per map value limitation for now.
>>>>> libbpf side needs to allow many non-mappable sections though.
>>>>> Single bss.private name is too limiting.
>>>>
>>>> In that case,
>>>> Dave, since the libbpf patch is yours, would you be fine with
>>>> reworking it to support multiple private maps?
>>>> Maybe it can just ignore the .XXX part in .bss.private.XXX?
>>>> Also I think Andrii mentioned once that he wants to eventually merge
>>>> data and bss, so it might be a good idea to call it .data.private from
>>>> the start?
>>>
>>> I'd probably make all non-canonical names to be not-mmapable.
>>> The compiler generates special sections already.
>>> Thankfully the code doesn't use them, but it will sooner or later.
>>> So libbpf has to create hidden maps for them eventually.
>>> They shouldn't be messed up from user space, since it will screw up
>>> compiler generated code.
>>>
>>> Andrii, what's your take?
>>
>> Ok, a bunch of things to unpack. We've also discussed a lot of this
>> with Dave few weeks ago, but I have also few questions.
>>
>> First, I'd like to not keep extending ".bss" with any custom ".bss.*"
>> sections. This is why we have .data.* and .rodata.* and not .bss (bad,
>> meaningless, historic name).
>>
>> But I'm totally fine dedicating some other prefix to non-mmapable data
>> sections that won't be exposed in skeleton and, well, not-mmapable.
>> What to name it depends on what we anticipate putting in them?
>>
>> If it's just for spinlocks, then having something like SEC(".locks")
>> seems best to me. If it's for more stuff, like global kptrs, rbtrees
>> and whatnot, then we'd need a bit more generic name (.private, or
>> whatever, didn't think much on best name). We can also allow .locks.*
>> or .private.* (i.e., keep it uniform with .data and .rodata handling,
>> expect for mmapable aspect).
>>
>> One benefit for having SEC(".locks") just for spin_locks is that we
>> can teach libbpf to create a multi-element ARRAY map, where each lock
>> variable is put into a separate element. From BPF verifier's
>> perspective, there will be a single BTF type describing spin lock, but
>> multiple "instances" of lock, one per each element. That seems a bit
>> magical and I think, generally speaking, it's best to start supporting
>> multiple lock declarations within single map element (and thus keep
>> track of their offset within map_value); but at least that's an
>> option.
> 
> ".lock" won't work. We need lock+rb_root or lock+list_head to be
> in the same section.
> It should be up to user to name that section with something meaningful.
> Ideally something like this should be supported:
> SEC("enqueue") struct bpf_spin_lock enqueue_lock;
> SEC("enqueue") struct bpf_list_head enqueue_head __contains(foo, node);
> SEC("dequeue") struct bpf_spin_lock dequeue_lock;
> SEC("dequeue") struct bpf_list_head dequeue_head __contains(foo, node);
> 

Isn't the "head and lock must be in same section / map_value" desired, or just
a consequence of this implementation? I don't see why it's desirable from user
perspective. Seems to have same problem as rbtree RFCv1's rbtree_map struct
creating its own bpf_spin_lock, namely not providing a way for multiple
datastructures to share same lock in a way that makes sense to the verifier for
enforcement.

>> Dave had some concerns about pinning such maps and whatnot, but for
>> starters we decided to not worry about pinning for now. Dave, please
>> bring up remaining issues, if you don't mind.
> 

@Andrii, aside from vague pinning concerns from our last discussion about this,
I don't have any specific concerns. A multi-element ".locks" is more
appealing to me now, actually, as I think it enables best-of-both-worlds for
this impl and my rbtree RFCv2 experiments:

  * This series uses (map_ptr, map_value_offset) as lock identity for
    verification purposes and expects map_ptr for list_head and lock
    to be the same.
    * If my logic in comment preceding this one is correct, downside
      is no lock sharing between datastructures.

  * rbtree RFCv2 uses lock address as lock identity
    for verification purposes and requires lock address to be known
    when verifying program using the lock.
    * Downside: no clear path forward for map_in_map general case,
      can make it work for some specific cases but kludgey.

  * If ".locks" exists, supporting multiple lock definitions, we can
    use locks_sec_offset or locks_sec_map_{key,idx} as lock identity
    for verification purposes.
    * As a result "head and lock must be in same section" requirement
      is removed, and there's a path forward for map_in_map inner maps
      to share locks arbitrarily without losing verifiability.
    * But I suspect this requires some special handling of the map backing
      ".locks" on kernel side.

I have some hacks on top of rbtree RFCv2 that are moving in this ".locks"
direction, happy to fix them up and send something if I didn't miss anything
above.

Regardless, @Kumar, happy to iterate on .bss.private patch until it's in
a shape that satisfies everyone.

> Pinning shouldn't be an issue.
> Only mmap is the problem. User space access if fine since kernel
> will mask out special fields on read/write.
> 
>> So to answer Alexei's specific option. I'm still not in favor of just
>> saying "anything that's not .data or .rodata is non-mmapable map". I'd
>> rather carve out naming prefixes with . (which are  reserved for
>> libbpf's own use) for these special purpose maps. I don't think that
>> limits anyone, right?
> 
> Is backward compat a concern?
> Whether to mmap global data is a flag.
> It can be opt-in or opt-out.
> I'm proposing make all named section to be 'do not mmap'.
> If a section needs to be mmaped and appear in skeleton the user can do
> SEC("my_section.mmap")
> 
> What you're proposing is to do the other way around:
> SEC("enqueue.nommap")
> SEC("dequeue.nommap")
> in the above example.
> I guess it's fine, but more verbose.
> The gut feeling is that the use case for naming section will be specifically
> for lock+rbtree. Everything else will go into common global .data or .rodata.
> Same thinking about compiler generated special sections with constants.
> They shouldn't be mmaped by default, but we're not going to hack llvm
> to add ".nommap" suffix to such sections.
> Hence the proposal to avoid mmap by default for all non standard sections.
