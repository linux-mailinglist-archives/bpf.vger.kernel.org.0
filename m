Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB313AA926
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 04:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhFQCvg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 22:51:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229614AbhFQCvf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 22:51:35 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15H2dYA4010170;
        Wed, 16 Jun 2021 19:49:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+0o5jLG8Wayvs6L+ExIsuMFIsmCfRoSUGVCuhgYN6so=;
 b=KWwUADQOLk5ymsPiL1F0RZ8o5vCdzUTx450vwMSxvjW0mouhOCNw7n3Q0MXybTBhc3Cp
 B8VUqVVtZq1XOg9MgAIy3VvJhOlAeKbMDcSnVqVUAMFkjkdYKNGGTABrlzNCOqeVL6L/
 TXdgiLNki7YS19UTT8PtdbqEjEXhkFdvp7k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 397tf690jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 19:49:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 19:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmjZgr6R7fT7XZXY9RxHz2doq12Zwqe5iEFHNrpnmyEE2s0f8lUgGcii/8Ykh/7VzQGCuTURC25movkF2LvH9BW8xa9gaQbDbbD86Hne6cbEbCJ7ddW6XC+Mg8YgZKudBKGhpqptRzX+4D1P+17zLCNxi88uVaKnY3SWnpt5gwezctnrt6KuFyUMF9UzymcJfrc53jIT23kQs04DS35cDmbFpEFzoAYGr7posEPB16PUl3O/+Vc+U0CyBtMSvHeRRCjnjqLtyfYgm2lrrHiQ4i9CepgQsbVQ5U+9waDKE1y6hsQonHZ+aENl8/GnamJuG/ZFP+S9bU2Iltl90BIUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0o5jLG8Wayvs6L+ExIsuMFIsmCfRoSUGVCuhgYN6so=;
 b=bp8bJxyLKP1b555JDk1hzye5FjZwks6HVzzA4VTtFQl9Pm31qYwu3vw7GyqGk2RAMTvgfO9AoWttD72PqNw+XLIRM2Dt4/AiSdo5CyCVtY5Rl/E9v2tPPkAjRG8ObU5TNagt/J6/N+rWE2mwDqnoCHPp0Y5CzkeN7yVETwl/B5se+EWzX+Xd7mmerIFYZIb1/zWKlb3QZSWT6/c8PcuTYw/wAFJqu50us27AhCLi7nEY51K47h1bdv8YO2ozmj1AwXbnV66H+UdnORqeTi5pIpJwvKuBxnka9KMBP7llY8Cl5pNaXd7CA9B2osBqRHMH7qsYk/CNSpr+paj+E828vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4387.namprd15.prod.outlook.com (2603:10b6:806:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 02:49:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 02:49:23 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     Carlos Neira <cneirabustos@gmail.com>
CC:     Blaise Sanouillet <blez@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
 <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>
 <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
 <c176cb4f-26d9-28b3-3f6e-628c1a5fa800@fb.com>
 <8b656897-8241-daed-861d-d33beff7934f@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f4974f3b-ecf1-78a8-026e-f04b17a88c40@fb.com>
Date:   Wed, 16 Jun 2021 19:49:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <8b656897-8241-daed-861d-d33beff7934f@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:e45a]
X-ClientProxiedBy: MWHPR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:300:ef::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:e45a) by MWHPR22CA0021.namprd22.prod.outlook.com (2603:10b6:300:ef::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 02:49:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1998c4f-bbd5-4f19-54e0-08d9313a832a
X-MS-TrafficTypeDiagnostic: SA1PR15MB4387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4387A71E4DC8A2AF18AC3ECBD30E9@SA1PR15MB4387.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb7zzrMdnwsogqDoPxEXVxk12DCHfVoqRs4UFq5hyAPsfq2Fci7QA8cvXSLZtNEB4a0mSjtAcFV5T0K5DX4sRRs+MWyAjBZc/cTi0mkrBkgE3aM/9HSKXpLKgiyx8TGL74SDEpNvj6IKu01AwEcAYUA5g/PP6my2tOPDOdkI1SWm/4CZc/edsj6dkBo6f63DzLjkU0hW+eBLe6bx70tm7UIRZhdx9mw+TL1PF/JS5AeAYWDrUh7VzX088m1VpkcgyZTuH4vMD6KutKDwxRDPehO5MNMhLVZslQrXYxnr9MJbcy6PsWIGjH9LYgViN9E+Td7IMG7N5z0Qum7vi6KB5pECaRqxac6VfP8kRQWzHgnxNLkzCRPxUcLz9TzTRakWvV+OqPp1/yW/oprbs+fnFOTwJVsbP6stkhUX6LPtUX/gs2BqUsBVuq4/6hvpOFPeE0nKEOjFaGcyWgvXstUHhrZ0sW7iLTCsCEZVqVUqajDC70pMmsiik6y3wUCiUxhnuEp26DSMPInrXO7WTkdBby4gVNod/kxkRL8o+6DyD4zeRvfnDVVaUu4yslduQ01KdUlaKY0hC1FEruydAasu7g8nPs7iV8hl3tPXR8i4MJMw7g5+O02CRytz4TlSiSdzlpIx35HGrTcKDEk8e8h/Knc4xNs7K8VRzQGXZOc0Ga52vd+LxUam9FHiO8CzynIos8nRofSmDHVoDy4ZEaIZHg/WkIb1o6+6y5bBWbkWT5yjuLaXNh09JRZBCudZF3YXXrqSHOZ1UrWv+wsS9zdE0DMNjGVcgbccDrL1YdyA75xKZAXkERP0gO3dOQPOW90F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(2616005)(53546011)(316002)(186003)(16526019)(52116002)(5660300002)(478600001)(54906003)(66476007)(66556008)(966005)(38100700002)(66946007)(86362001)(31696002)(6486002)(8936002)(8676002)(6916009)(7116003)(31686004)(36756003)(4326008)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDQxT0VBOXdBSk53WFJSM2tKYzVocXhkandDVDk5b0xWL2h1cEpyRkg1VUVY?=
 =?utf-8?B?OEVvQWtKeTBQeFlsdjJIT1Q0cTh4OVR3eGpTTFUvSjdhYmN6S01rZ3pVWHg3?=
 =?utf-8?B?b1JnSnFXYVhBVGx2RndJSHJ4UWNBMlZMS3dCaFJXU2drUW9BaVFyb3orYWRi?=
 =?utf-8?B?N09BUVZobWhXN0g3QmhDbmhoTVVrMEMvQkE2djEvbG10YndVNzNYSU1qZUNX?=
 =?utf-8?B?N0x6YWdZMWduWXltUENxc01QV29WQnd1dmE3SEZFWXRVdjA5Nm15U1BVOWxX?=
 =?utf-8?B?djZabWxZd2NOUlJpT3MwWm10ZnYyTUVOUEtFK04vU2Y1VEhIeUpPWnQ0TWEw?=
 =?utf-8?B?bGxmeHpmUU5aK1VRZkZxSXMybUxGdFZiY3FTajlVK24rWHVNYWVNVVhRbVdx?=
 =?utf-8?B?OEZOVmdaMVV3ZU5wTGdkUTU0NFRSYXdncXJFZHE5Q2NWaS9rR1FjWUR5WklV?=
 =?utf-8?B?U1VkMEVBZ1Jmd1c4Wm5laUt4ZkxjQitZTzgwc2ljaG5MdDhydkJjeVZwcEVM?=
 =?utf-8?B?RmlXSUZFSEYrbDU1dnhXOWx4WktucGdlUTRWY3h6WlY3d1ZVdEkxV1dKMi8r?=
 =?utf-8?B?dWNsbXlBMzd1NU1YZXdCZUpZOVJ0Ti92cVNpVG9hODV3eFkvMlF4aUU5bXpS?=
 =?utf-8?B?K1FWSjJibHVzTFJRQmVOL0FNdi9oSUhnOERGVUFZbXBjNUFEZE9iY0NnSXM3?=
 =?utf-8?B?bm1ZcXY4UVNSRWFIS3JPby9YY3ZkOEFrVml2d1hwN21VSUpCSmtHeVh1SEtC?=
 =?utf-8?B?QnB4ZGJYNmk0MjN0bDF0TXFUSXBxK09INmZQMFhIcHM0b2M0VnhEK0pOTXo5?=
 =?utf-8?B?c3JwSmk5eWYwSVVCSGw2VjJNeEVpQlprVVVBY2VnMkNiM0ZhaGFVeUR2aUJx?=
 =?utf-8?B?S05vSS9mZkp5bzBSTW5kNk1TTTF1MkpjK0xVRWN1M1dsTVFDYk84c2RhTUFh?=
 =?utf-8?B?VEtmUVZSNXRYMFNQU2FCQUo0ZzlSSjAxSWxacm1YSFd6cFZHZkV1a09qbXN4?=
 =?utf-8?B?TUdtTTFzSXVKem5LQnRJb01Za0ZQNUhLY2x5VDdmYWJUUlhaYm0wbW0xcUdh?=
 =?utf-8?B?aGF4blhLeE43WE5HZks4bXpBQjIvRnJvZjd1TWtFU1k1bEZSeVQ0UlVpdi9n?=
 =?utf-8?B?cjdHaU95bnArVzJ0NUxtKzQ0SDNudkorUVArUkxleTA4WTR1OU1RR05neXB0?=
 =?utf-8?B?cDE5Ui84bWcyR2l6OGdFR1VIRVFGQTcwMDdKZGpmM2JITGlwZ0FWWGNkUTFo?=
 =?utf-8?B?bHRENUlPVEhOOFlXVVdrTWR6YS94SzFjU0xXcncrRHJkcjIzQmVwZklHSFlz?=
 =?utf-8?B?di9NT2hSSWFBT21qeXRGKzlVWjBqS3FEd0VhTGJKcFV6ZmU2RStRZUNuREtQ?=
 =?utf-8?B?Sm93S21WZzhYT2R1d0EvQnAvaXowaDV4VHRoanhUTllsVEdpTVhsZzZpMlh0?=
 =?utf-8?B?MVdvWGpaNFpDZTRIODBPWnBQaWpZNkpHemp5QzZZZGZJR3NWY3hSK2laMDVp?=
 =?utf-8?B?TWF4bXdjUit0RC8vNWhZZUI5aGpBUnAwdmFQWVBocUdlRTNNalRURm84ZVk5?=
 =?utf-8?B?RWJsVkZZU0kzVHIxVCtKRzRrN0NBSDlORGF6Z2IzNkdYWUNuOEQxRFJaSk5y?=
 =?utf-8?B?OS9nMUM2eDNhU1ZhSFZzUEI1QjVVVjJ4cTJLUWc2UW00c0xWYlpTZFUxUUhJ?=
 =?utf-8?B?Lzh1bzluNHZpZnZVeTIyRTFlT29ER3hwMFdMb0pMMWFoQndXdFhMdDU1eFhS?=
 =?utf-8?B?Rm9lVDRWTm5DNlFTSDllOEx6dyt0YWsrekl2cnNSWm0waFdua3BZRzRManVR?=
 =?utf-8?B?WmM3QWJZZ09QeWQzaXBJdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1998c4f-bbd5-4f19-54e0-08d9313a832a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 02:49:22.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTGQrEtOo368iCSEfu/dKuEyU2phz+DkAIl+AYXO4yMqeWBtAUaEhpE0/w9bTXUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4387
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: K40sKBUU_IouONPGrH2HoGElfZGpCaE_
X-Proofpoint-GUID: K40sKBUU_IouONPGrH2HoGElfZGpCaE_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_01:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 2:44 PM, Carlos Neira wrote:
> On 6/16/21 1:02 PM, Yonghong Song wrote:
>>
>>
>> On 6/15/21 6:08 PM, carlos antonio neira bustos wrote:
>>> I'm resuming work on this and would like to know your opinion and 
>>> concerns about the following proposal:
>>>
>>> - Add  s_dev from  nsfs to ns_common, so now ns_common will have 
>>> inode and device to identify the namespace, as in the future 
>>> namespaces will need to match against ino and device.
>>>
>>> - That will allow us to remove the call to ns_match on because the 
>>> values checked are now present in ns_common (ino and dev_t).
>>
>> I understand its benefit but I am not 100% sure whether adding s_dev 
>> to ns_common will be accepted or not by upstream just because of this.
>>
>> Note that if adding s_dev to ns_common, you then need to ensure s_dev
>> contains valid value for all usages of ns_common, practically all
>> namespaces, not just nsfs, otherwise people may argument against this
>> as existing mechanism works and the change brings little value.
>> If you go this route, please ensure other namespaces can also
>> take advantage of this field.
> 
> This route seems like a long one, but is the easier solution that I can 
> think at this moment.I'll read more of the code to have a better 
> understanding of the consequences.
> 
> 
>>>
>>> - Add a new helper named  bpf_get_current_pid_tgid_from_ns that will 
>>> return pid/tgid from the current task if pid ns matches ino and dev 
>>> supplied by the user as now both values are in ns_common.
>>
>> I think current helper get_ns_current_pid_tgid() can already do this.
>> Did I miss anything?
>>
> 
> The problem with get_ns_current_pid_tgid is that device and ino provided 
> by the user are compared against the current task pid namespace ino but 
> dev_t as is not part of ns_common is compared with against the current 
> nsfs dev_t. So the helper will only return pid/tgid from the current 
> namespace but not will be able to do it for a target ns due to this 
> limitation.

Okay, I see you want to get tgid/pid for an arbitrary pidns identified
with (dev, inode). That makes sense as you need both to compare given
pidns (dev, inode) info. What is your use case? I guess you try to have
a daemon monitoring selected containers, is that right?

> 
> 
>>>
>>>
>>>
>>>
>>>
>>> On Fri, Nov 13, 2020 at 1:59 PM Yonghong Song <yhs@fb.com 
>>> <mailto:yhs@fb.com>> wrote:
>>>
>>>
>>>
>>>     On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
>>>      > Hi Blaise and Daniel,
>>>      >
>>>      >
>>>      > I was following a couple of months ago how bpftrace was going to
>>>     handle
>>>      > this situation. I thought this PR
>>>      > https://github.com/iovisor/bpftrace/pull/1602
>>>     <https://github.com/iovisor/bpftrace/pull/1602>
>>>      > <https://github.com/iovisor/bpftrace/pull/1602
>>>     <https://github.com/iovisor/bpftrace/pull/1602>> was going to be 
>>> merged
>>>      > but just found today that is not working.
>>>      >
>>>      > I agree with Yonghong Song on the approach of using the two 
>>> helpers
>>>      > (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) to move
>>>     forward
>>>      > on the short term, bpf_get_ns_current_pid_tgid works as a
>>>     replacement
>>>      > to bpf_get_pid_tgid when you are instrumenting inside a 
>>> container.
>>>      >
>>>      > But the use case described by Blaise is one I would like to use
>>>     bpftrace,
>>>      >
>>>      > If nobody is against it, I could start working on a new helper to
>>>      > address that situation as I need to have bpftrace working in that
>>>     scenario.
>>>
>>>     Yes, please. Thanks!
>>>
>>>      >
>>>      > For my understanding of the problem the new helper should be 
>>> able to
>>>      > return pid/tgid from a target namespace, is that correct?.
>>>
>>>     Yes. This way, the stack trace can correlate to target namespace for
>>>     symbolization purpose.
>>>
>>>      >
>>>      >
>>>      > Bests
>>>      >
>>>      >
>>>     [...]
>>>
> 
