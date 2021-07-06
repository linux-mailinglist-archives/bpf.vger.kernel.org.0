Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17293BDAD8
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGFQF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 12:05:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20239 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229770AbhGFQF5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 12:05:57 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 166FsrAl021986;
        Tue, 6 Jul 2021 09:03:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kxulZfA+HtLYE6zGHloHLMyOSMwvih7NPxXnB3eeFac=;
 b=GcjwllOUTzopTzwJ3FGd3duiPtTfmNI5Rif09DK4vYj/SAZcPQfPsueFSRVuexcaW9iO
 xkMcvvSteRlqm5uQW/6iufXlrjHDtqJVxLA533aX/ncRSoiCC9Ewzdpi47npcunGv4/Y
 XF8dbkzB1b3GHmPCBTP+pyS3nDoO0983XQU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 39mhtdtsj8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Jul 2021 09:03:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 09:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOgKkDGkIJ/Kux0pF1Y+QaQisJQKapXZJB/G99rwecB11g4gLz/+5WC5aPkRKKnTDO++tH9ou0kr6JMDDDOvpONNTXZcLmB/sQOYbCCOGVdHyysNTmFD2W3WlWvbPoE5qGbggReOG/9pWQAvlih4Qql++EQ+s1Q9i77P+VVptpqC1Vo636j2k8PueJBh9FubYOxg9gXiylZTXl0mzLC5BdqMEf+HvwOlwFmkRdk6ywrxnjU5hpmBvpvpjLFg77rciAxSQNcOjTcMobipD9+7VLe8KjhwJLny/j3oypYelZDubaM3LeAfn4/26uTujJFsgAUPkLP4ENXI7GgdopBf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxulZfA+HtLYE6zGHloHLMyOSMwvih7NPxXnB3eeFac=;
 b=laDra/DZivlyBOvc6vMpl7dgLhqJN23MbEZuGs67GxDXKfR5rUbc2uBMmcxtbAkvOs4KoKNsYfY6bWbMvXw1bm6hSCdTaDaU3UMCN3kQnh48F4SaINbfuumjdmU2N6A2vpARBWzTb7MSGcA5P0c/dkB2p8VoYxXuk0KogY37xl44pEzADhWMF6MXUdMIkDBTElZpoN98MjwWdahqPfLlf/qQjc8OIEYwMuW0QCqvqsfD36uMIoKJb4K2aOU6Y/OsAtS4Nq/IWHIbv0BazZy/1I18S7LaJWe0WZJx6ujMp9N4n5BpxYYJ/PMUv0Ram6SYoyPbyFSi3MEecNoKJVFJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4706.namprd15.prod.outlook.com (2603:10b6:806:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 16:03:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 16:03:14 +0000
Subject: Re: Failed to attach to kprobe (non blacklisted)
To:     asaf eitani <eitaniasaf@gmail.com>, <bpf@vger.kernel.org>
References: <CAAihumD0AOem=UhqRBDULQ6ZDL=n2vhn-3rLJq+mOm5-q2Wfjw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <30a11562-d804-122b-97c9-27cac1a24f77@fb.com>
Date:   Tue, 6 Jul 2021 09:03:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAAihumD0AOem=UhqRBDULQ6ZDL=n2vhn-3rLJq+mOm5-q2Wfjw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::19fa] (2620:10d:c090:400::5:e2df) by SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.7 via Frontend Transport; Tue, 6 Jul 2021 16:03:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374d7704-f8bd-4daa-2037-08d940978fbc
X-MS-TrafficTypeDiagnostic: SA1PR15MB4706:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4706A197C8301C3E6B1E03FDD31B9@SA1PR15MB4706.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +i58TR7U64gpcgLkbRB9i7B7O+2XaS7SYY6HyxcDZEloGeJfXNcWhLjoPpTU96jHqP9ZLCp8cQqWWpcwxL6YZIOuJi+Dos7dL5z/07gc5z+eDftz+6vyDERbP/zuSx5jHj/YXKUlG7Qojqd5GD1KuSEkSV8wDfJrESI60nsRT4HzRnsijGDyLVsRZEpLwo/XYtyi/aqGmGYhd/G+5b5TzI6FB06iGGtaoYSA6WjtMKayT/ZUYOwdr+azgRPFfgThi/IaC6YrqtgZ2UitpCf3Lqt87a3XHPpfbepE753GXeSMBXS3gkpOkyzILWIBKuLVrH780voaVYUiszXhT+iHtDDyv/9UjsfWZ5r4OeB/5qwKGCFbHAgv3V8EM2Z/i0gkm7wnI7dhtuoZ09vMyNi/KEtMK01j/bP6wROG+B93ijffuWotRE40s+tey9DMykYhFvC7c4iKLvGr+a7iibmLDBWIK0UpmWWxoIHQovNSZtRzLCvA43IlSRLWQWqF66C1/7QhtdN1B9xhTSttn1vBUv/Hk9/IuHHvQoNCsbuIKy/DGEVvw2aUh9gxCY1VBuvrZoVcJa+lXxEJ1lPXyeth6Op6lcqVwYn19JTDErOxxaZ8jVaMDzqR1mr+AxqPnYNaXFK/KKOEJYhv+woz7EVtlMeMjb9WX3HPVEKB0R8hk5PO4lTa23uNgDlEUB4gWUKcEK75Cuxs4HYgHtofK1GtYbZobGnXL/usITYQF7fDiQeJtgHKYBD4WsAKQSIYeb8oEMOzlI7Pf4nX10ZD/cXAKheMOYcy1QsnP43BRNMYPkJKpxKtcRb7GfE1qi33ZpDcbPDgUTVc09iFO9Vu5iUZgoItoK52zMiH5oGub8HcKPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(8676002)(186003)(53546011)(52116002)(2616005)(5660300002)(8936002)(478600001)(316002)(31696002)(86362001)(6486002)(83380400001)(38100700002)(66476007)(66946007)(2906002)(31686004)(36756003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGQ5UmNEZVBaaDRTUnNJdVVPaVBMUm1YSnV0NngwWXdmUUFhM0NyR3FyOVlH?=
 =?utf-8?B?YXJuMW40czdHL2dQMnd1eFRmbFhiWExYUWhJRWs1UUF1TnNJOFNrcHovVTFa?=
 =?utf-8?B?RlpPTmt6WEI2UjExYkROb0ZhZnpnOGJvTXpBczhCN3ZCRCsrVUtGeFk0ckg1?=
 =?utf-8?B?WldxejFUb3YxQkxaMWNwZVNWWlBobEpDU1VFN1R6RGQ3bXdzc2Zkb2Q3K2RN?=
 =?utf-8?B?V3pmcDlIWWNBb2ZUVjhTN3hwTnU5UHdEQ1RmNUNaRHFockh3K1JuVlZtdlV3?=
 =?utf-8?B?bTk5N1JPbE14M1c3UDhMQXBHTVVpdmxMQ1Bjb1FXTTQ2ZllxeUpzbkVXNURv?=
 =?utf-8?B?dmc3em5KUGxuYkJ2TmwwVFR0ZVBGK1JEcXJKRU5Db1ZPUXFSbGZCWW1iZmhh?=
 =?utf-8?B?cC9kTWc2YWl2QVBwNFArUWZUTys0ZGpzWlBPblkzSkNsOVErdkc2UG5TU2hZ?=
 =?utf-8?B?R0Nac3Q2VHBua2ZrVGYxRkZPWStiS3RML3lQRXZsOFZIeElwVkZGQmw2VUYx?=
 =?utf-8?B?Z2V6RkQ2SnU2REljcjFhaE5oZjl6ZU1ZMEVLU01zRGtvOHIvTzgrYWFvSlFU?=
 =?utf-8?B?UEh5bThCa0xwSG4vUFE3dmJpWkFaTERpRWRicFhwUXdvQ2lPUW1leGJjTkV0?=
 =?utf-8?B?QjJmNFNlcDZ5MHdOQzdMTDY5ckFQdlM0MmRwUm9UdkNHUisyaFBsT1piUjM2?=
 =?utf-8?B?dDJLWE00bHFRZ2Q3ZXVTNlVJSTJ5R0lwTjV3eGY5aHZzVWREdDAwcGZ2MHBJ?=
 =?utf-8?B?WlFxbDUzK04yWU1yL3NGUjloRHhNaDJIMFVDWVgyVlJyYVBVaFFZbDNXWkNZ?=
 =?utf-8?B?ak1YOEZ4Nkt2UVNlNEpWdS93YmVXNnBlUVN6RWxEZWNKTmVUZ29vd2pjNkx2?=
 =?utf-8?B?T0hjZmhDMEgyWFJxejR4aStOTEdVTGZ5SU9sQmoyeWFOcm40RWN2YjZQS0g4?=
 =?utf-8?B?SG1EaGw2RUFMNlRSYzRXWFRocE9ySkpwL2lNOEdnZlM4dnB3U0xxL1d5NExY?=
 =?utf-8?B?ZGV3QUFlMWpXcno1NGM4ZGJ4aWc3WnRQREI0TG83cXlwNHVqaFEyd1dhZ0lV?=
 =?utf-8?B?TU51ZXZYL0pEcDBJZ21nNVNJMzM0TzM2OE5LY3pxMmhnZno3eDFBNzh0aXVm?=
 =?utf-8?B?bkE1djBaTitRNXhZZU9WV2xhcE5YMVV5SkxZRFM4N0lOay9jQXBZRk1xNXdN?=
 =?utf-8?B?eThaVlorNDZMaG1mTEhVbENtTzFwbmZzOGtRL1d4Y2NydEhJM1ZhU3JqdUZK?=
 =?utf-8?B?UTZ3YmducGhiaTBCVmpvNXRXMXlsdnJiams1WDdSRGUvRFk2MGpGTmh3N2pq?=
 =?utf-8?B?cnZFRTFzSVJsTWlVWVV4SGpIanN3UGFjMFNKMXluTEZPM1EyZWdSNklWakFR?=
 =?utf-8?B?bGRKZFk0VE1mSW5TNGZHQkl2dWRSck9UOVpXelFEUktuQkZ2dHpFN1dmdFpH?=
 =?utf-8?B?SUIzRTl1d0tZNFNidnc3VVZlNEJYSXovY3BkZ3IwblRJOWVUZ3VhRW1EMytF?=
 =?utf-8?B?TGFxcHFyR1l4NnJBRUlYVEN3NmtEZXJ5elZqOURCMUV6QURNUDRIQWo5UStK?=
 =?utf-8?B?WFlqaXFJdGd4TE5JVVJLQmM0bXI4SWlKVE1wcnVaNXJrbFFYWXowcTRocEkv?=
 =?utf-8?B?QUNvNysyc3lwWjdlWjNac25SeG5FS3FZbjAyOXZhSllsMjBpZ05vNEpVeDBp?=
 =?utf-8?B?V1dQaElqTkM3RnZXU2dUM3hNUzcxMXN6b3Q4ci85Z2ZUNDRYQ2luL29qSHIz?=
 =?utf-8?B?cEtrVTBReW55V3hPZmluWE52ZFZYTHEzbm9CYWFFZTloa1d6VkRMNEFJVVFS?=
 =?utf-8?B?dHpFT2hIV1g3QjNjSlBvQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d7704-f8bd-4daa-2037-08d940978fbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 16:03:14.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyfF8hu/dinb8oCzrA+rUP0IEGE/9mrZbuE8q70kvq0K/r5RGruuyxoyq+tlHr03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4706
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Cw0z2F-bmF8Mo_We5eV88gzwzjm-12UK
X-Proofpoint-GUID: Cw0z2F-bmF8Mo_We5eV88gzwzjm-12UK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_07:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=750
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060074
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/6/21 4:56 AM, asaf eitani wrote:
> Hi BPF experts,
> 
> I'm having issues to attach to certain kprobes and kretprobes that are
> not in the blacklist, like ftrace_modify_all_code.
> There are kernel modules that are capable of attaching to those
> kprobes and kretprobes but I could not attach them using libbpf.

Any details what kind of kernel modules you use to make kprobes work
for ftrace_modify_all_code()?

> 
> I tried using both tracee(https://github.com/aquasecurity/tracee) and
> bpftrace(https://github.com/iovisor/bpftrace) to attach to those
> kprobes, which to my understanding uses libbpf, but both of them
> returned an "Invalid argument" error.
> 
> As the blacklist doesn't seem to cover all the functions which are not
> attachable to kprobes, is there a way to get/compile such a list?
> Also, what is the specific problem with attaching to this function
> (ftrace_modify_all_code)?

The file trace/ftrace.c is compiled without FTRACE flag.

See trace/Makefile:
ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)

ffffffff811888b0 <ftrace_modify_all_code>:
ffffffff811888b0: 41 54                 pushq   %r12
ffffffff811888b2: b8 02 00 00 00        movl    $2, %eax
ffffffff811888b7: 41 89 fc              movl    %edi, %r12d
ffffffff811888ba: 55                    pushq   %rbp
ffffffff811888bb: 89 fd                 movl    %edi, %ebp

I doesn't have a call to __fentry__ like below.
ffffffff8101cae0: e8 7b 48 be 00        callq   0xffffffff81c01360 
<__fentry__>


> 
> Thanks.
> 
