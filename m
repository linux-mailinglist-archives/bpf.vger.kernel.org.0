Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49753502FB
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhCaPJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 11:09:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236232AbhCaPIy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 11:08:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VF1bEU000314;
        Wed, 31 Mar 2021 08:08:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QFyRnJLmwY/eMc5XW1sOdAfEKDqwkTgsHzhvZh/tmgI=;
 b=Tltu4NmRxWKEm+Vu5UfT2LrjXnLmuHdkFm6XbHQKnXBuQWcnIKE6/pPor9l8JwX2GQWh
 U2EbVy8rDYsQkUdBm0Hp1s6kPsFZo3PbrBJqqSPCXXVWUV5L/LlBiCMvBLQSuZghU/Kq
 iJTJhnG83N/tUKNDRlhEptRi9/ccp+oj9ug= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37maa5vs72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 08:08:50 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 08:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Int2quIy9JDJ80W17jWXFdkrfdFUkLgvUiP+DMck5uk+2f8Lt0gbfRSSpgIYI91sSDJsCXTzZ0XPs8Gbzc/UJAIeFxfSwWACQEW8myeZqTN33SIbxxtTsvSguj/Sy5kbw3isMyYsrqKPKMM+DXHwa1SnPb3XKKVcJhBa7z0D2yEHSOr6RjpoodwwXKeIMVgwu9FLyefJqnDMomROfBS4BTTjP0jdDlbHJkAJAmNN8RRVyR662+XCBs7Gq4GTtzk6ioDoI3iq6YlAKfCDbhNf5qnGf860fMtNbtyIk8Ga+L5dUoSu4K5/CoofKzjwEHTaAu/fCMSIXmb0J2KP5f8i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFyRnJLmwY/eMc5XW1sOdAfEKDqwkTgsHzhvZh/tmgI=;
 b=BoQrhAEoACsMojAH9rLQYwnCbNDIdSNW96QaMRWUeG54/LgRi+oL0FyI3ybPojlaKCRTXSYyZMtbLDs0yWUW8SEgiA0F8gGPHKNqSsMlHH7PLD/d6SqPqHkVqfdYNu9L3E8lNaU4Do3TxFgwkeOlZRbPIP+005ES5FtJxYbgRQQZd6K07Mv32qeW2h37FHy9u6JLFikdRnhbbKchuLJyVI1P4R0QmY3hiU4l9WbsjLW1IIAHFResCt32Vmqs/6UEhh+DR+6YbXakLcsgN0bV+W+0zwooS3LPf/CA3e0YwWPTCtBjf0tzm9jVYX6ZOCaGJ8EUf6Kc2hBrhOTuGf7rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4452.namprd15.prod.outlook.com (2603:10b6:806:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 15:08:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 15:08:41 +0000
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org> <YGM/Uh61RVExWnTU@kernel.org>
 <YGNpBlf7sLalcFWB@kernel.org> <YGNs4QxfGvQozqGS@kernel.org>
 <503f852c-a7f4-efb2-5fd3-8431721dd67a@fb.com> <YGR/Cc3/39V0kRuj@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0bca2e79-ed26-f483-88e3-f3225504a6e4@fb.com>
Date:   Wed, 31 Mar 2021 08:08:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YGR/Cc3/39V0kRuj@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:b9b4]
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:b9b4) by MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 15:08:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d80698ef-e20d-4c91-3ffd-08d8f456dea6
X-MS-TrafficTypeDiagnostic: SA1PR15MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44525389B728099D356C6EDED37C9@SA1PR15MB4452.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY16y7oN/tLcOXDF/rRQbwllYRlXtxJ0V3qn67Cqq4j5CAKB4NvCizewMuYhhDKCb1fJMyZxLN1inGWI6NUeC5xPuQoeH5yQoWZo04SF2u3hdwbc0ckqgf69II97cHXQAaBD5q15P09G0b6UJVVlM8FtOcQezZ4oPamj8ThocxTHtHDpnWeGcZOb1CUCY1/5ogW/nH4bwxJulvqDMImDL+iOrdtECEwaG6+J3hvpf8PmVus52e3/8quAr4aPKkWtQmLV/U3HhlQ5Lt69CltxrozmWdvQ6tISTdKAlq5rK9HOC86d5LJ4NgaLvwHXmeIWQ/6NG3N34zCyWWXpvrCA5VBAeYPrUSd0w0EwdZ5xRnypS0jGF2LEIMV3jaBeZLstArnMhPOnZVhRI0YINF3IFaSYZtOBRP1IcY/+6CGr1GRc38YQ5PV9EzHLyyAT1IJhTA0RChC0GUYJx5WRKSAGBqr/jQSB6GoSZB7wN57ifKOu50RsowJ5e4u9hluIyL7MJylACdsTSFEpa4W9OcdsvurGnvYc5/+5Bc1O96RjL7OVi1qwnf6nPYo/spG4Bcpu6+DjW2k6qvtiN4HgO678Lnk4sUvMQJV9Wj7tuLQCaLPIwOfRyGXtRPzFN2tkAI4qgd8lv8TiMefy3A+hh16cgFDNddq3eX0yA0C01y3KI85NfBhjN9SHFcHCFZFgNLkJZ3U6Z2meBiFFrq0dRs6jkCzBisZ5pKYz/WM14IP2v6mHzeGqH+UpaY/c0JTj593rUnKj16CootSaWCmj0fUiWQxB2gKr5GsW+AYGQi1y0Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(6486002)(38100700001)(6666004)(6916009)(966005)(2616005)(316002)(54906003)(5660300002)(16526019)(4326008)(186003)(53546011)(52116002)(31696002)(86362001)(36756003)(478600001)(8676002)(8936002)(66946007)(66556008)(66476007)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUdNWEZGS2JIYkd2RUFDOVgyWmxSL2VaTktoZWc1bzRhMUh4WjJYV2tXV0Yw?=
 =?utf-8?B?V0xhU0dSZDQyRnlvUFJheWdkSDdlNTZFZUdyckJwRndyQ2NzeXg0VXdxZG4z?=
 =?utf-8?B?THdDNUt5c1h4S25JUi9UbGFOaVZ4czZYY2ZndXNnRTFNYmplNzc3UlI3L1Vj?=
 =?utf-8?B?a0lqckk2NWFoNEJ1SHFBc0ZwWC9SYXJ1M05iN1hXL0kzVW1tRW5oT0NkZGNX?=
 =?utf-8?B?U1VTcFZadHVRbE8zNDNWdm5zWDBsUDNrMzBsMitRQ1pqN1p4aUxaVWFJVlVt?=
 =?utf-8?B?RUVoSzlYcml2ZWNFVVdocTVRRHNHdlVnOEI1QXorUGhqZWdPZnYyRThLWXk2?=
 =?utf-8?B?Smh1ZTdwUHpVRGdVbDRNOTNQT09CaCt5aHlDaVpUKzQxaU03OU1zYWJOcCtF?=
 =?utf-8?B?ZmxoVWtnNTZvdmRwUG5rcDBvdXlSOUU3WllZZm03TjZ0Y01Od2s0ODhWSjRF?=
 =?utf-8?B?MExaaDRTc3J2NVVENjNpdkJwWFlFZ1ZzdkxIcnZZTWprbnVwZnRpMXBmZk90?=
 =?utf-8?B?ME1Zc3gyVEJLVGs0QkR2aFkyOHVKKzdoTVBVSmwveTZqamhpaWFBTkdQaWZS?=
 =?utf-8?B?aXRQMzU2Z0FPREVyY2RWQnhQK1V5WkRzSWtXS082NFdjM1A2eFpVMDJpYTZD?=
 =?utf-8?B?L2lkYmRIVHNUK25zeVpPVHBSTk0zckxIWVBxUXJERGw4eGFxUm41TXl2VmRK?=
 =?utf-8?B?QU8vZFF1UTJEclNDZ1RyU0ZIY01sd1JPNkVManpkUUFXNDFIUkYxcGZ3RCtO?=
 =?utf-8?B?bEZOOHhpaldtbzFyV3RLMnp3bXR0dStOWUNqNlhMSGlkbi9vcXAwbjFNdElm?=
 =?utf-8?B?RzFZeGVma3Ruc0xwbXNzdVBsYkhSNVdkZlJPWk96N2FWVmtIRFN6TFZicUg2?=
 =?utf-8?B?blpqaEMzdWZGQXFnbi9PQ2FBelRIYUgvMWc0MWJJRGFwc2tVTGpXdHl6cE5U?=
 =?utf-8?B?WnAybzR0U2pYSmliWUZlMUcvT1JmS0MxZ3EvcUNvbnh3RnJxdWtYS3ZibVRN?=
 =?utf-8?B?bThnN2Z6ajZRdWR1RU1zWVdQNSthT0ZrYjBPZXdTemZmS0NCRDNhdlhlYXBt?=
 =?utf-8?B?R2Y3eG01bU1Ld3BXOGZUeFR6Z3MxaVBLOTk2cGF2R3NRL05WSHh3K3c0TTBI?=
 =?utf-8?B?dDBZc0JvaUJEQ3FDaERBeHIwdDlEL1ZrbmRBc0MvR3V2ZGdtT1YvYWtMcDVy?=
 =?utf-8?B?TGd3OGpVb3JzQ2p2UGk0UVJsWlE2MU5aSDlBT3htckl3RnJOSzYzSGR0ZXc1?=
 =?utf-8?B?b3RkN0ZNaVQ4U2Q0bFRzdFVqN0wwTjhSSG92Z3NKQ1NpMzl2ZzYvUEtJSUNq?=
 =?utf-8?B?Y3VjR3luclpHVkVYam4vampwSVJOVVJCN0Q3QzQ1TE8zU1d3YU44dHVrUnhX?=
 =?utf-8?B?dHRNaFVHNGJnUEhNM0RkZkJZT1VIMXlUcEM5RFo3TUphTy9iakZHS0V3eWhv?=
 =?utf-8?B?a0ZPWnlndStRNTJMRS9QMWpxbFFmdUdZQm5rNXlIWmxKZWZ5R1pZN1ZEU1Jp?=
 =?utf-8?B?Z0liNDVZYTlob1lZd1ZJQ1RpS3orWWluWlJoWFgwSTd6VHE2T25yM09sVzN4?=
 =?utf-8?B?UXhVYUcwakZreWtvQ2s3R0VUaWpiajhlaTVrL1doeXlxWEVoa0dObm9ydE9r?=
 =?utf-8?B?ZWpQNXBXNmdVUkxJNlMrTC8vTThkWDVNV1lyZ2FCY0lSU1pGSEZTRFpybXFT?=
 =?utf-8?B?ZGlRKzk5UkEweFdCOHJPRlMvWjlXSnNLRkNXUjYyMXNObkk5Qytwak02SXhW?=
 =?utf-8?B?cEdoUUtVYnNlTGQvdnFnd3k0OXZRTkNnbG44eXA0VDJvSDNiVjFCa0dha2V6?=
 =?utf-8?Q?b3TVhreWTz+vjHQEiYtRZ6g0XYL8YG9LdWix4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d80698ef-e20d-4c91-3ffd-08d8f456dea6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 15:08:41.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koiUe8xfielqHBRIGKcaYbmtJFYKULlGa2J/eSXV4xsn9Oe0Wob9e0qOesoCHuxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4452
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: mENuOf865YWyO5hDBv5aHajoNUynReBr
X-Proofpoint-ORIG-GUID: mENuOf865YWyO5hDBv5aHajoNUynReBr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_06:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=901 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/31/21 6:54 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 30, 2021 at 08:20:20PM -0700, Yonghong Song escreveu:
>> On 3/30/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Mar 30, 2021 at 03:08:06PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> [acme@five pahole]$ fullcircle tcp_bbr.o
>>>> [acme@five pahole]$
> 
>>>> This one is dealt with, doing some more tests and looking at that
>>>> array[] versus array[0].
> 
>>> I've pushed what I have to the main repos at kernel.org and github,
>>> please check, I'll continue from there.
> 
>> Looks good. Thanks!
> 
>> I will try to experiment with an alternative way ([1]) to check whether
>> cross-cu reference happens or not. But at least checking flags
>> approach can be adapted to gcc (if we want after comparing the alternative)
>> since gcc always has flags in dwarf.
>   
>> [1] https://lore.kernel.org/bpf/d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com/T/#m1b0b1206091c19a90b15d054aa26239101289f84
> 
> I thought about some other method, like adding a ELF note to vmlinux
> stating that this was built with LTO, that would be the fastest way, I

Adding to the ELF .notes is a great idea. Let me explore it. Thanks!

> think. If that note wasn't there, then we would fallback to looking at
> inter CU references, that way we would have the best of both worlds and
> wouldn't incur in per-CU DW_AT_producer overheads with the flags for
> each object file.

Totally agree.

> 
> - Arnaldo
> 
