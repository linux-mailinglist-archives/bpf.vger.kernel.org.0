Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D965B5DDD
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiILQCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiILQCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 12:02:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408217A9C;
        Mon, 12 Sep 2022 09:02:53 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CAMXD7006546;
        Mon, 12 Sep 2022 09:02:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xPVx4Fi3Dxe//IsrnqeZqQ2IVGJKtoy6ZqPdzbgZ4Hk=;
 b=ewlWw3xAGf+E4f93U3/m8mTcmlo1LN7QVbHXsYYV+BvIVRZqKJBCsIYcc4H4HVimQXyu
 ZRXyoT5J6WQqQxnSLzn5wRvs5wvn224lopr18QmrYbuoxKOcE/1wAPJ7/7nHGOiFnJA6
 43AvWvdIqe754ta46GRBgk6AnpzE9USLabE= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgr9sjnrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 09:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkpF/8kjRdbm/VKq2lJ8PzkroMWbm2f5INy3wo/87GtD+H1l1YXiZsbWNLjI36jHIhOnMKAR13q++myZCM1X0s1PJe83YK2uXFw8/SfsQ2l2qWOByuRmfMMnEjsGvCDi6nIDNwEEcQGHVyMOLyFKW7CXNU1eoHFnf7OmUtWkO0fJsWqKLtqGlCw1ZGTNbUkNWv337ZiBLDPEt1faYxOVzdJ6AmUC4YkRxzn4xkpR+wM8qBEaBlwyJ8t9I5jhn7gdNCPOTAFSuPUbQ+nVF+eMiK6D9nWnUzlUoPEc862YTb2wbL3hUxw0zGA0tVCtJRfrXP0Ds+KfFuiiVHQ0yW7VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVx4Fi3Dxe//IsrnqeZqQ2IVGJKtoy6ZqPdzbgZ4Hk=;
 b=d620gHy+lE/Ev8oqPYPNJLVan/r5oh6Ka7G01BLOWLEt4iPP6JshwU7Sr7JHYCVCiqZ+0/vMlbCYSLsivDoJ+prliXsreCjfEeZB9aZZcKm8QinJbv0vQdd0l8xZg9KYw2wi/abVPWj8o5bhwpkxHWVmPml2GBSvqminbem4LmlBC5P9KwSwcPfmdjyu7YSnmLsv9l70FAoa25YyMfCt0y4cSSlET3OYdnasHXT6CPTdBAjZRSjORHm1Zd2PRg9fcnjdTY9LXoMuQR1JD12pRo1uiqXg4Ysxn9Vr/CMd7sKZRfuUITlz8FlZh0yDS5BVfLv/1ZJOCrckh8zT0CGr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1801.namprd15.prod.outlook.com (2603:10b6:4:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 16:02:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 16:02:29 +0000
Message-ID: <a6e56396-f1f9-d939-cc25-201db242e3b8@fb.com>
Date:   Mon, 12 Sep 2022 17:02:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/1] bpf: Ensure correct locking around vulnerable
 function find_vpid()
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
References: <20220912133855.1218900-1-lee@kernel.org>
 <243f7ca6-41e1-7522-a6fc-6a35d8104bb5@fb.com> <Yx9Mv4ltoNhuU0Om@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yx9Mv4ltoNhuU0Om@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1801:EE_
X-MS-Office365-Filtering-Correlation-Id: 34701259-7126-4eb8-84e6-08da94d8317b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGKrZ6J/ic3zphTv7EIjYMm/846EUcUzC0GtUq46ALjNnFUf2YC3Hc/7+fBbs5UZfFYPHsl+ps/UKmzra2jTKo5yr90GIDQCT+n/ZDnfmZGDSusdDl2oN6or1tFThiL6wleMwu46RIuFKhIfBJMKNXkf69fZVW5H6c8iZ40RFjqccU+ZQl0EIZ6wIxYS80hNK93byerK7UxNtugz2Gp9UF2eYishh4hTeKrHhj905RjW8gvb9Ki2OxK9Zhl0gJdQXbUenBx8LwwzMbo67lrt51A9digDLcK9S5MaD+5CZs9bxvcly23EQauiqneAk2ZJzQMuGYhA0rQBv0+aPl7sBBbcYN96n6yEdMLggN/+3M69bYjjqnQ+BDYBpQXfpcarK+w4obyocZSQllkWRGjcfUkvLaQ7uM0m7xOe9JtyrEbPympjS0trBc4yLgmID4BaI98nU/ZLd8Oj0pvEEVo6bnJqkl24Pi8stChvwbTQ5jbKD8PkWrG38VjxMSLEo+iOrvdPACOD53Pc7Mf6BP/HWHVN1Qo9VCwy8S3iw/WKxmUi+dxTNo4S6q+0R82/Wo3TP5CL5RqT/HGDXrjL4QB2dyUsZilu6yTKwBeasthb+bwzerS4Oh5lEyCt/Z/2PVx+Ih2h+YzMwedmOxxNBJ5JQANTenQjtbqrbnOsea9TeMDhSBERfYG3DDS3jmUX2grH0cfYW5jodK3ltuPJiahr96d3C9koXOu2C8aWHCzkKvOBtia0AxlUvrmH4F7NTukmh1qYE7gJyEJwHPXJxcUzzu2zDxqb0f1rKd1t/wmetsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(38100700002)(8676002)(66476007)(66946007)(4326008)(66556008)(31686004)(31696002)(86362001)(36756003)(83380400001)(2616005)(6506007)(41300700001)(186003)(53546011)(6486002)(6666004)(478600001)(316002)(6916009)(54906003)(2906002)(6512007)(5660300002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9oYjQ3YnJaNHZtYnBFekVrd0JTVkZOdjA4TE0wR0MydFl4YlBFTW1CSmtl?=
 =?utf-8?B?RzFhekt1VjVqWGlrckVyYnZicVRTOWJ3ZmlQUWZjNmNja1BzSjBFcTJVK2Nx?=
 =?utf-8?B?ejFBYXhraS9RUDRsRDdaOXpUYTdleEp0SVhpalhhVm5KS2tweDMyK0QxcGNF?=
 =?utf-8?B?Y2JhOTNZbjYrNUhlV1hVWU43aFZYK3NJTlZ3SE11WGxkK2RWbm1vSUpJeGFV?=
 =?utf-8?B?Wk9Gd1ExNUR1elNDUStFZ2NkbkNwbTBlZVJINmdrcVY5UWNWOVlpK1FhT29n?=
 =?utf-8?B?bW1uaEFENldsUytXQ0F6YnlPVG5tZlY3dU1Zc1ZNL0tMbHB0VnZ6Y0VVUEwy?=
 =?utf-8?B?bkxNa0NWby9rRjJiYVUzVFNvaS9ZTFdNNzlxMlhyZGdzOXpTR2F4ekU3V0dH?=
 =?utf-8?B?R2NORG1RUVZ6YzRYdEg3RXp4UTVnTE0zSlFEOGhqR1BQYnFMZU0xRE54YWZV?=
 =?utf-8?B?eTNydmN5cDRHRDUyaFA5djhlV1N6NTBBKzZFQzRtemM0ZU1hMWlUYlc0dnV2?=
 =?utf-8?B?Z0J3a2p0N2lrNXY4UlBHZ2I4N0hHVG9WZ2RCN0Radzkxc0hueXRVb3RhSFMv?=
 =?utf-8?B?TkdKTFA3WDFYazdVRGN5c2dXSWJkZnZOVzRhYnFzUnVnaVlydmlBTnBDc0ZT?=
 =?utf-8?B?bTRLMnFTcVgxSlNNMEZtVStKQUh6UmRXZ0FyNUk2WW1Qb3VuNUVRdDFzZkNh?=
 =?utf-8?B?VG10Rm5qRllacXprcm1iNGV5WkU5cmh2OVl5VEp6aTNsL04xUmxNY1Qzck5I?=
 =?utf-8?B?emFVdUYyTk95Zk9NMmJUVHlBWSt5a1pvYUt4YXFRSTFVVEoxaTVIc041NVhq?=
 =?utf-8?B?NEVLbHN0YkxnM2Izb25EMlp4REcwc1hpczNXRlZSVHBUZlcySlBYS1c1KzB3?=
 =?utf-8?B?eDB6NDYydlREZDNQZWtrdDhYZmdxN1pTd1BIWjVucmVQUit3N2Q3YkFQM2Zz?=
 =?utf-8?B?RExDOTkwWDN0aWhlM09HNWx2dUlraThWT0gwZjVnQUV3ZDdYVnVnbEpBUysx?=
 =?utf-8?B?dDRDRzRiY0FBaEZ4VDBYWFJHMm96NSs0NXpReE9SQnVoUjloUW1IbWtIZEFa?=
 =?utf-8?B?YjA2YXQ5NXR4ZjduZmtPT01WQjl2UXVldC9tcFBkMjhaZWJYUmZTV3NNYUk0?=
 =?utf-8?B?ZlZDSndIOUp0S3d6YUFFV0NVbFU3RTM2TUNBeTFFanJIN01lOTRJZTl1TnN0?=
 =?utf-8?B?cGh1bE5FZWV3bUk5MW1KZHgzQWNTRmpTa3F5SEJyTldSbXpTRDQwTnZUcHgr?=
 =?utf-8?B?V0FrRmhsVlRIWDl1WStqZVFzQSt2cldabDNZRUxpZ21KM2FCTHRTdVU4aGVY?=
 =?utf-8?B?bmhpZWRxL1RXaUFvMzRoSFpZRVY2dU9JNUNqaGwxUDV6VVFZV21hUWlneGp1?=
 =?utf-8?B?MHNyZUlhS29GUHpLMzJuSEpXMnpPMDY0bE5FZ0VZZ0VhUklUN1VZS1Fkd3BW?=
 =?utf-8?B?T3k5UzFoMWl3OWFOUjE1alpUelg3MkNWNnB5L0cwZGFqUnVwTTZ0N2xOT0h4?=
 =?utf-8?B?WXBSaDMzbTZXNjU1U1ZNMzZ6a0hwMXIrMDQ0MnV4MUsxbVBQUWJSMGZQMWxI?=
 =?utf-8?B?aXhlc3oxQnRTYUUxUlFudS8wVGdaOGNSYlJNdVg4TXY1YXV4NWdjM1ZOazJ2?=
 =?utf-8?B?eFRtRFI5bDlrK3ZqRWRiZDNBeFZLV3oxc0p0MU8zZlFaQjcxdHJkTnFSRURT?=
 =?utf-8?B?VUxzcTQzaTdENkVuclNrMVZzMEhGcHlZY3ZZMVh1WHFMeDJwU2EwTGZFOEg5?=
 =?utf-8?B?NXlVODJNekpNQ2FqTVdKenF3M0tyRG50dUlSMXJyanlTOU5jd1M1OFZ1L0Zt?=
 =?utf-8?B?a21sSml5SUo0bUhjTnc0b25sWkNUanc1Z3NKVytnZlRaTm9PY3U4RUs4aEJC?=
 =?utf-8?B?SnJFMHNuWXpNRTNYekVsNWtNSzIxNUpjVVIyRjRxSTIxNnpFbmx5UnJLb3Z5?=
 =?utf-8?B?WDNrK2dNQ29IZ0JvR1BRVHIyakFRczRTWDlaUTQ3a3FMelc1cTVIcGxWNWY5?=
 =?utf-8?B?NjhpTHorVnFna2lwK0M2THpZVFBDZTFuK0xXa1pUVldwQWhXekZsU3Iyc3NR?=
 =?utf-8?B?eTNIQlJRdFNCeTgxZHpDenVESkRuWDJWa2FIZytWSkUySnFhL09ab1l5a0ZS?=
 =?utf-8?Q?7KUjvlhnNqGzcz8Sxy3DN5sue?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34701259-7126-4eb8-84e6-08da94d8317b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 16:02:29.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5A8gdxWX/JSRaeH3grRPXP04EeLXLuxwE7G15DaxErKR1ueKggL4ZZ+YKbRTzyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1801
X-Proofpoint-ORIG-GUID: 3YzhbF9NLv5ZaGLoRKsGJ1EOsuel8sl5
X-Proofpoint-GUID: 3YzhbF9NLv5ZaGLoRKsGJ1EOsuel8sl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_11,2022-09-12_02,2022-06-22_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/12/22 4:14 PM, Lee Jones wrote:
> On Mon, 12 Sep 2022, Yonghong Song wrote:
>> On 9/12/22 2:38 PM, Lee Jones wrote:
>>> The documentation for find_vpid() clearly states:
>>>
>>
>> No need for the above extra line.
> 
> The intentional blank formatting line?
> 
> The commit message would look worse without it.
> 
> Is this really a blocker?

Not a blocker. Just a suggestion. I won't enforce it
if you do have this extra line.

> 
>>>     "Must be called with the tasklist_lock or rcu_read_lock() held."
>>>
>>> Presently we do neither.
>>
>> Presently we do neither for find_vpid() instance in bpf_task_fd_query().
>> Add proper rcu_read_lock/unlock() to fix the issue.
> 
> I can expand this.
> 
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: bpf@vger.kernel.org
>>> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>
>> Ack with above a few suggestions for the commit message.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
> 
