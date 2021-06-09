Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FAD3A0D1C
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhFIHG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 03:06:28 -0400
Received: from mx0a-00007101.pphosted.com ([148.163.135.28]:8852 "EHLO
        mx0a-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234509AbhFIHG0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 03:06:26 -0400
X-Greylist: delayed 2169 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 03:06:26 EDT
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
        by mx0a-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1596F2bI015311;
        Wed, 9 Jun 2021 06:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=tDeJiBp9EiItayGZn4Cr2ZA77sl4RiolPjaao6euqCc=;
 b=QjYiqKfu/YU9IWpEWD08G4WnGgGISrFpo32c2HXKv9HJ8FkjYU41e4uVVjkDD4VNPpMs
 jtDcSQs2XoIvNO+PYkMvXHiwdBUX6WxrqmT1sce0NJ6W/R61GboSBUjsK6L/YHc84N4N
 7TdIQeBH2pO1rV4nMgVIOTgQZRW9dNqrGGzHr/dtAtK6yJGKHUHtyCIVXj5o3GudXiCv
 +lDWoXdsQmwsozHpSn/4aqWJOVxEooQrFXNjsCstamYBelBTYWEtMRgr6nX6bZK/WISf
 1Taxe7tSK0/ywsc4tydh18/CNVuAJ8Q3/G2NYF5LB4MpqozmCcrV2ibyaf18SteAlk+z wg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00007101.pphosted.com with ESMTP id 391qnn43nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 06:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5v7DW8k0GtFzY+W86Ln8DLHin+d7b+xnvdq8BG775VI5lw+5TXBuBhqKDvtE2iU5JWY8U2e0VFHYplAY1AH0ZhWeYMMEWpZ5mDnuiv4mSVj22kyeVZ5mUDE57qXoD/+5oEHHuF+HDEg72B+WL9zXtSyYqnxBmY5+adn44GrmSmGofivZC5SR7fHjDQEv5D/TladpXbktbjuGtgTXISPQ/yggiIv6LPiEF0C45xOdgAEtMMlkegbT/S26/Zahb08ir5jFc5ZqozEC/7seNI2r4LCJwkpuWBTpPGifia+Y0l14AoBf1OTvKTjAitPO2Uov7QRO1e12Yp5Jjl0TNYWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDeJiBp9EiItayGZn4Cr2ZA77sl4RiolPjaao6euqCc=;
 b=Kmh/ReVT+/ImBrYzbfMAp/6NNMZcvmWrntUbUr4QKRZdWrWStRKzCZiRiZnTv8cHTWsNjXMptF5WFUOZeVg4Ph8sxhN/+ffVm8vdhlGQI8zWdN8tGu50mR6G+Nf7it9uHvUE6tWKX0e7HrO1rlgYhwDeTe9qni+D81FqLz9ZM3qOLNWv8pV+rVS6NZy4wwJW4E9pbuSdtwsx6Ay/N5nt+3dBpbadnGsVb+++wxRy2Cx5YLR+/3G3LCfEcP6TiYUXZn9/VefbxPAF3pwsh1hVfNmO3JmWr3gOUIvZiZB8c2GHtrZuj7qcRlrwBg37Ok2KZ1U+mqJutd3bURh6j4SeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=illinois.edu;
Received: from CH2PR11MB4454.namprd11.prod.outlook.com (2603:10b6:610:45::22)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 9 Jun
 2021 06:27:31 +0000
Received: from CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::7c:abd3:683:d04b]) by CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::7c:abd3:683:d04b%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 06:27:31 +0000
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tianyin Xu <tyxu@illinois.edu>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
 <20210520085613.gvshk4jffmzggvsm@wittgenstein>
From:   Jinghao Jia <jinghao7@illinois.edu>
Message-ID: <cb42261b-d3d4-9da5-1ffd-a1de4762f74f@illinois.edu>
Date:   Wed, 9 Jun 2021 01:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210520085613.gvshk4jffmzggvsm@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [98.228.56.157]
X-ClientProxiedBy: CH0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:610:32::27) To CH2PR11MB4454.namprd11.prod.outlook.com
 (2603:10b6:610:45::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.8] (98.228.56.157) by CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 06:27:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86bc7c8-6d40-48f6-b012-08d92b0fa940
X-MS-TrafficTypeDiagnostic: CH0PR11MB5233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR11MB5233BB75FBA82AD494DD8712E0369@CH0PR11MB5233.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4Lmzm8sAChSAylMyaue2VkihpDCQI1pOCQDVYtvOsvVnEgDI8ceLhww1t2AfQq6RGKDi9gzsk+yZf4yneKQmD0Ne78sdcNXjp5uBCKeD9qMQBBN0tEf4XgTHcu8AAGM29+tyKXYBFQdbnPa04TDPqs4TTrHl31EHGahqBBZUUgJkapOBi/aPgMIQziQYVZSeDpkpc66ZTCW0txn0kmS8ssNeh2Yv9Q4+HyK61p0rsz3dkUdCv/FerDbceaIbTNe356aXHcx67fGs/TcrT7o1/oBXChJ9JVgpU5/0tSh/RAnwyCcyjMCA1DFUnspNgrgY5Vo/2kGUUaCFalEN/CNydUiyXuMlElQGdcBk8cc66lBIqEJWnjSXHIQUSXfHR72NLF2v9QosJ4kjMHULQZCmHfgLzHaEIKgAGE6r/SNadnS/t47NlQtCdksc1xsbji+8H+RHfzoKdBFR6pqQM38fr7KCJ6dwjkPDgas29hc+u0qPRSKevHS5Qdn5WZwDTi4V5cusHZqZPK/kglhA9hEft+c5YxJNVjUwPSiKO0CwrXmybdvwKMvrIXeqmrgGX4C57JZXpHYFzsnaJZKfpTcNdVko+B4asmzjHmo/6SxViPjdHyxnZFKZP+4KRXByp5U+iM/B7d9WXDGSvd+VExRtSFJNGUrzeEfKCq3VgtrkYL2mWtnHgMXXlytuZGjh4pruWZJjX90vHzNp+Rg2YUnYyknbLTVLBwrZbTGNpy/WXXKSEC2u4L0bGqqJxUKW381Egjd8W70q0ADjZ7jExFaYWZ+aFLw3GS+wcOwESHMrT4r9XNKP2ElVTchJyKcAMy//+K39alySGPswaqxzaTlvUeBrIc6qsRe5bBW5Xx0h8LhLYMfb9H6ck9NBc24it3i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4454.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(83380400001)(5660300002)(66476007)(66556008)(75432002)(66946007)(110136005)(38100700002)(54906003)(38350700002)(31696002)(966005)(786003)(4326008)(6666004)(16576012)(31686004)(86362001)(316002)(6636002)(8676002)(186003)(6486002)(36756003)(478600001)(8936002)(26005)(7416002)(2906002)(53546011)(16526019)(2616005)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZrR0wwMXF3TEZSRHRsaVg3YWk0aS9MR3MyRUxPdVVEcStCTDN4YXdabEZk?=
 =?utf-8?B?Zmc0NHpqU09GeU1TSUFCYW85OWx3Y0Frd0tRcGo4M2J3TVpjNGpiMnFicnNI?=
 =?utf-8?B?a0NpMm9SSlNjNnhzSWczNTNyc1ZaeTNDdzQvbHNNM0NvVUlOdmd3STcwS1Zp?=
 =?utf-8?B?L0ZuaE1yV0xjUjBJS015MEdIVHd4c1RDMEh4R2M2ZS82Yk8rY0Z2VzhsdWF3?=
 =?utf-8?B?OVpNSm96S0E2cVRkcU5VWElka2Mzbkh3cTc2VWhBK1RkNkpwRjRTeW1nNERJ?=
 =?utf-8?B?dlFLUVhkMGw5ZElLREZIdFF4TC9oOTdNbWpZK2ZZUWlCY0toMUR6ZERQVmFI?=
 =?utf-8?B?ZnArWVNobGZzQXdiRUExZFdPODBMMXNoK280ZW1TZjVzRS9HTVBwRUs1dWxK?=
 =?utf-8?B?K3B5cDZ6enVmcGtXanA4Q09wZjhzS0dkVWM2bW1WQi96OHpsNGs2S3ptd1Zq?=
 =?utf-8?B?TnJpalFoTnFIRFBEUXdVRkU1dlFwTytYaUdIUTBRemFVejJCWVVtd25NUzRV?=
 =?utf-8?B?ZTdRYjV5SUpmZkVOclpRQy81RUdNVEh4Rk9Ra2hIczU0MjF5d2EzWDBmV1pO?=
 =?utf-8?B?R0w0a2UrUXIwSloyR0t2WnpnbkxkNGhRNnQ4V0VMeGJoK1JvR1ZNcXY2dGgy?=
 =?utf-8?B?ZmNlNisrZ0JRcVE2WUtjSTVxVnNWSXZkS3ZEdXlYZEtZWFZ3RHZ2ZitWelZI?=
 =?utf-8?B?M2xjRjA0VTVlSEJXcVYzWVBDdTBjWnBXWEpMRnp2Tk9WQ1FqK2lBenRDREl1?=
 =?utf-8?B?empxZ1l4ZkdBMjhGVVdKSWticGVyVEFBOG43dklhUEowdkFRSG9hT20va2l5?=
 =?utf-8?B?YkcwdG9WaHkwTjk4V2NuUEFtcEtFT01VMkdVVks1UktkVitpTzJXdVU4cmow?=
 =?utf-8?B?Z2VUWEE3VENTRU5QZzY4MENQVk5zR0FrWjhPTkhlZ0F4QlJ6QTlpSnliVG95?=
 =?utf-8?B?L2llcHVNdTZxUTVPcnFBbExjc0FQUzJ5NzNEMitJRTQ0bWlkZGw0YUpoZmpP?=
 =?utf-8?B?N09hUk8xLzVNZE9pV2tNWkNOSUxxeUZxMFlZZlRkZjI0SStpZTFrZG9OTkxo?=
 =?utf-8?B?WFp5UkcwNlBxb1JsK3lNcmIvZlUzSzFzU0o3cVcrRFdYZEtOMmljSllrSzQz?=
 =?utf-8?B?RC8rWU1NLzFYbEhBUVNkVWNTd2tBOXpGMUFYMUhYL3V2VlRrSlBWMTB3eWxB?=
 =?utf-8?B?bDVMNHlscUxLVURHNHJnSnBhYnovRUNTRTQ4QlJrZWo2TmlYSEJwZ0taWEZX?=
 =?utf-8?B?SEg0bEh6YUR1cytPckx2K1Q4aHh0VzVQODlMQ3QrUW9PSzh1ZTlCNHlkU1Q1?=
 =?utf-8?B?eUtEWnJSZ1FvQSswSm9oWFoyK1p1U0lVQUNBa2VudFFWbEg2aGxDREc0M0JR?=
 =?utf-8?B?RVlrdytZN3ljRGZFUE02R3VqN1QvWW50U2VMUjBFTDYzSWd3N3FNZHdkMDZQ?=
 =?utf-8?B?YVgrdzNQVHdxL1h4bDhsRXN2bDlCRTNNQTdFQmI4OE1lYm1ERVF5MkhmMFh0?=
 =?utf-8?B?U2JFbTFsNnJpejBydFZiYjFidnRud29PeS9tdlFPY1kwVFNNU1dsT2lzSEdx?=
 =?utf-8?B?alFvamhVREdBTXdmQUFvZ2ppbUF1SWpCUzk3RVZzS2VwaGU0Nitqd1VsNm5a?=
 =?utf-8?B?TDZSOWE4M0dhdkh5L0hkeTdtYlVCUE53UHo1cTJZdnduaU9QemRpK2RMTGlV?=
 =?utf-8?B?SXV5cTh1SDJkK0MyM3Z4bEt3b3c4VzRrMVZNQjNCNTRXRU5tbEp3alY0OCtI?=
 =?utf-8?Q?jG06qnQXg+njRl+VX+zsXg+vYP1gVtKkgyotNYh?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c86bc7c8-6d40-48f6-b012-08d92b0fa940
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4454.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 06:27:31.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldIfrATamDNt6kmFfh4YBdVeNqDmW9AkQTC8N8vLezX7tEOTZ8X4WXueBhzdsYHkq34gqPnqRgZeeR+si58h8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-Proofpoint-ORIG-GUID: Mk6nd35yMrLpv9CMMWTzhT3e7P9I0__L
X-Proofpoint-GUID: Mk6nd35yMrLpv9CMMWTzhT3e7P9I0__L
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090021
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 5/20/21 3:56 AM, Christian Brauner wrote:
> On Thu, May 20, 2021 at 03:16:10AM -0500, Tianyin Xu wrote:
>> On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>>> On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
>>>> On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>>> On 5/10/21 10:21 PM, YiFei Zhu wrote:
>>>>>> On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>>> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>>>>>>>> From: YiFei Zhu <yifeifz2@illinois.edu>
>>>>>>>>
>>>>>>>> Based on: https://urldefense.com/v3/__https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
>>>>>>>>
>>>>>>>> This patchset enables seccomp filters to be written in eBPF.
>>>>>>>> Supporting eBPF filters has been proposed a few times in the past.
>>>>>>>> The main concerns were (1) use cases and (2) security. We have
>>>>>>>> identified many use cases that can benefit from advanced eBPF
>>>>>>>> filters, such as:
>>>>>>> I haven't reviewed this carefully, but I think we need to distinguish
>>>>>>> a few things:
>>>>>>>
>>>>>>> 1. Using the eBPF *language*.
>>>>>>>
>>>>>>> 2. Allowing the use of stateful / non-pure eBPF features.
>>>>>>>
>>>>>>> 3. Allowing the eBPF programs to read the target process' memory.
>>>>>>>
>>>>>>> I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
>>>>>>> even less convinced by (3).
>>>>>>>
>>>>>>>>    * exec-only-once filter / apply filter after exec
>>>>>>> This is (2).  I'm not sure it's a good idea.
>>>>>> The basic idea is that for a container runtime it may wait to execute
>>>>>> a program in a container without that program being able to execve
>>>>>> another program, stopping any attack that involves loading another
>>>>>> binary. The container runtime can block any syscall but execve in the
>>>>>> exec-ed process by using only cBPF.
>>>>>>
>>>>>> The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano.
>>>>>> @Andrea and @Giuseppe, could you clarify more in case I missed
>>>>>> something?
>>>>> We've discussed having a notifier-using filter be able to replace its
>>>>> filter.  This would allow this and other use cases without any
>>>>> additional eBPF or cBPF code.
>>>>>
>>>> A notifier is not always a solution (even ignoring its perf overhead).
>>>>
>>>> One problem, pointed out by Andrea Arcangeli, is that notifiers need
>>>> userspace daemons. So, it can hardly be used by daemonless container
>>>> engines like Podman.
>>> I'm not sure I buy this argument. Podman already has a conmon instance
>>> for each container, this could be a child of that conmon process, or
>>> live inside conmon itself.
>>>
>>> Tycho
>> I checked with Andrea Arcangeli and Giuseppe Scrivano who are working on Podman.
>>
>> You are right that Podman is not completely daemonless. However, “the
>> fact it's no entirely daemonless doesn't imply it's a good idea to
>> make it worse and to add complexity to the background conmon daemon or
>> to add more daemons.”
>>
>> TL;DR. User notifiers are surely more flexible, but are also more
>> expensive and complex to implement, compared with ebpf filters. /*
>> I’ll reply to Sargun’s performance argument in a separate email */
>>
>> I'm sure you know Podman well, but let me still move some jade from
>> Andrea and Giuseppe (all credits on podmon/crun are theirs) to
>> elaborate the point, for folks cced on the list who are not very
>> familiar with Podman.
>>
>> Basically, the current order goes as follows:
>>
>>           podman -> conmon -> crun -> container_binary
>>                                 \
>>                                  - seccomp done at crun level, not conmon
>>
>> At runtime, what's left is:
>>
>>           conmon -> container_binary  /* podman disappears; crun disappears */
>>
>> So, to go through and use seccomp notify to block `exec`, we can
>> either start the container_binary with a seccomp agent wrapper, or
>> bloat the common binary (as pointed out by Tycho).
>>
>> If we go with the first approach, we will have:
>>
>>           podman -> conmon -> crun -> seccomp_agent -> container_binary
>>
>> So, at runtime we'd be left with one more daemon:
>>
>>          conmon -> seccomp_agent -> container_binary
> That seems like a strawman. I don't see why this has to be out of
> process or a separate daemon. Conmon uses a regular event loop. Adding
> support for processing notifier syscall notifications is
> straightforward. Moving it to a plugin as you mentioned below is a
> design decision not a necessity.
>
>> Apparently, nobody likes one more daemon. So, the proposal from
> I'm not sure such a blanket statements about an indeterminate group of
> people's alleged preferences constitutes a technical argument wny we
> need ebpf in seccomp.
>
>> Giuseppe was/is to use user notifiers as plugins (.so) loaded by
>> conmon:
>> https://urldefense.com/v3/__https://github.com/containers/conmon/pull/190__;!!DZ3fjg!qjoih4kOsHD09Yg41YKmYQrW_YhB3AzV0sgWZsRK621KIf7eTKiMMhAiew-ySWA_vbUt$
>> https://urldefense.com/v3/__https://github.com/containers/crun/pull/438__;!!DZ3fjg!qjoih4kOsHD09Yg41YKmYQrW_YhB3AzV0sgWZsRK621KIf7eTKiMMhAiew-ySfWBbnxD$
>>
>> Now, with the ebpf filter support, one can implement the same thing
>> using an embarrassingly simple ebpf filter and, thanks to Giuseppe,
>> this is well supported by crun.
> So I think this is trying to jump the gun by saying "Look, the result
> might be simpler.". That may even be the case - though I'm not yet
> convinced - but Andy's point stands that this brings a slew of issues on
> the table that need clear answers. Bringing stateful ebpf features into
> seccomp is a pretty big step and especially around the
> privilege/security model it looks pretty handwavy right now.
For the privilege/security model, I assume that you are referring to a 
way to safely do unprivileged ebpf and to make sure the ebpf features 
can be used by seccomp securely.

In fact, the privilege model is carefully implemented in the patch set . 
As mentioned in the cover letter, we followed the security model of user 
notifier and ptrace in a way that our implementation is as restrictive 
as them. Let me elaborate:

1. We require no less privilege than Seccomp or eBPF individually, (e.g. 
filter loading and uses of BPF helpers)

2. The new seccomp_extended LSM hook restricts the use of advanced bpf 
features (maps and helpers). Only when the hook permits the access can 
filters use standard helpers. The LSM hook is implemented in Yama and 
uses ptrace_scope to determine whether to allow access. This is based on 
the idea of reduction to ptrace, as the eBPF filters can instrument the 
process similar to ptrace.

3. The tracing helpers require additional capabilities (CAP_BPF and 
CAP_PERFMON).

4. For user-memory reading, we require CAP_PTRACE to read memory of 
non-dumpable processes. If the capability is not fulfilled, the 
bpf_user_probe{,str} helper would return -EPERM. This is, again, 
reduction to ptrace.

We acknowledge the concerns about user namespace pointed out by Alexei 
Starovoitov. We are more than happy to roll out the solution in the V2 
patch.

Best,
Jinghao

> Christian
