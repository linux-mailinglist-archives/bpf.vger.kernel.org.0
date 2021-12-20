Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92D47B0B1
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 16:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhLTPwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 10:52:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231790AbhLTPwg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 10:52:36 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BK88nj8022932;
        Mon, 20 Dec 2021 07:52:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lGqHbCNTWy41C4fwt2LSah/d7AA3av5gcIbed/qid3g=;
 b=MOIQiKwfsYCyQm43wkNzvHI6diIUXhfqDvN6yTbc7uny8N8GEhFUgW7XsFMn3OdcJgKk
 2I9RMlNDyN/9RY+HRDshwL+VeKqVxU9CYQYVkr1xE9HtQ5Gy0rZh8clfMVKcg65G1UZ6
 SQZsmrQqEj1JwkNYoSxIhxcGY9ge7+eLGkw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d214kr6kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 07:52:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 07:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN9xn8C00HtRRp9kctrlw9Z0j1j4nA3xE/MNNv8W9ZfNmdxW88x7v6hXsXU+uZAKBkvW395CQ6cZy+Mlc0ZgmE2xQXDgreO10X55s447ydfYpkwAnFTGsorGS8foogiuhMmQAHEvEdMeW1zoQpgOuZi0n4+QmRujSKI7FUjICwJ1DqBPFL4ETFKVRt05Bnyuem+4nsCvRevaxTpRPYIo/GnecySdxW2o7aZUaSbP6dB3y/E92wO4sKwEQX9Xks3BLME7Cr4dPMfLBx+eYldQ/yzi1w9rvLP5AghTzAaH77en8EwOlT3WymY44QSndxsxA2FNiBwTt0TyPb3b7fINiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGqHbCNTWy41C4fwt2LSah/d7AA3av5gcIbed/qid3g=;
 b=ksk6D/jhaI4jAQiCLVXmT3qWCnbqtXte8PddWFGLgeXCd5f4fBOeTgyN4CjoHOuwNkbT0yDIIM58SyiGw93hbHHutIpmgZw48qGQlp+GetYn0fdBTUsrld55QU7WxDHoE8/iCCV/FV9vJ7dj+gvuo0Bqu6OIQzDRjFgxxtVvyMXZXKctgaZhNkMpV+7fQpuFBYBfV2XjsGJzBfMYb58FQrJVzXVahslJuCHx1vu2uBY/5y1nAGtWGbL35+2QvX/q1rLauAdxPKSkQzz/en/cRbahFfNZSAogaGMYyOYoNeZptiwWfjNg9tZTErdzdfyOlwGONLDK2JmyLKIqcq8k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 15:52:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 15:52:10 +0000
Message-ID: <0cbeb2fb-1a18-f690-e360-24b1c90c2a91@fb.com>
Date:   Mon, 20 Dec 2021 07:52:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
References: <20210913155122.3722704-1-yhs@fb.com>
 <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com> <87sfy82zvd.fsf@oracle.com>
 <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com> <87ilvncy5x.fsf@oracle.com>
 <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
 <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com> <87czlr4ndp.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87czlr4ndp.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7794d3c0-1cb7-4060-880e-08d9c3d0ae88
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB196872FD5905A4069CC46C9BD37B9@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4sPJ5UAtUEQe4kFa4u4zAnnOMpHT9hfJIdLBFMkXuwLH8CjgD/fQ1r+Pmr//MADtYH94TaribQcyi5smYk0mvGhwVTrmuWK1WLWzzhEgAJCBPZIS4ZXGxZP+rkS8Y5SWAi8i5uaHRQZ8zR0jCV9ndARfavZtqLq/ZhE1TK/T4vGOaPowWQ7O4LwWBXeGIeONbFkmhgqqsglRqyWH003whjnYjUhXuA9AY30jGT5dQwNt3UkAKPb/dD7jAXlMbppGJ4UKSTN1Cs8HQBXsKr0uSf8LC2jtQimbcZ0iaJF0V59MuU9sZYOcfPxDEJsCQfpFGMK7mEPcQ+3O8nNzJwTdHnNefKBajffhhZdoMHKEdEY7WfK6eylZd3TpE4H0Z8XE2nFk7vQrf6dl/BJVWDb0dwhnDqn0POSQ7W2nxaVxL8XZbajqfkxgjUJKcQNAfopzC+ZSzQWrJ9CDEve2rfQ2tsaI08tj1w+mSSK7twazUosq6njN0d3OuUHMnTEL4IX2gwdNtQA7adtexwmPiMLNqR5D++zJZxkgxrM2XVxSZYFdgxN+NqgKPkfjIhlOFd09IdvfbgRgqlPm3WQTyOfsBBr0ssNTSvo3ZoYMAEq/ayVKI1uxF4o/u9S69hFQ9k/X+rxt3VF60SQXaQVbf+9bjvvohr/MQTxWepcNYsCqw1xM8ESk++biTXcX/53oaI9vclWmwa1hRRDmij5+EmQBvsjmnYh6lLlJlLrD777Ca13/eeLn+tuUWOaJAog8xBb+HTSSS46MKoGl5u2WCm4fnXrttoc/sTgtrzM3Y7dtKEbkb/XC7cDYXkVOfAKhVgK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(86362001)(2906002)(186003)(31696002)(6916009)(66476007)(66946007)(52116002)(2616005)(31686004)(83380400001)(316002)(8676002)(6666004)(36756003)(6486002)(66556008)(508600001)(966005)(4326008)(38100700002)(5660300002)(54906003)(8936002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFRRmJEOGJ0SE1jdUlwQlVaTytSWVJ5akI4OFBzMEEwYTB3eks1QnFHalBu?=
 =?utf-8?B?L0hoTUlHQUFHaXI3WEJkM1VtWVJyNjhHUDRyTlIzY3g5Y2tsSGJhWmpqaW1k?=
 =?utf-8?B?L0NvaldhbE91dWVVUklJaHRDRUlIRUhPM3U0TlkxbTRzVVVUdkIyTzBFL2xi?=
 =?utf-8?B?ejdJQkM3ZEFMTUVaUHRUd0c1RW1BZ0RnazNRZEFrRUtza2NuQnB0cDY2azRy?=
 =?utf-8?B?MWhTN0F0NGFDTlVjL2RVTzMvVVhDMk5aSjYyUHZFMk14cTJ3dU5lQnE1cjAx?=
 =?utf-8?B?ODlDRkU1aTlnazVtT2ZWSnJWMndMeENHQmUwUVd3bEFrUVByN3Mwc3dhUDlF?=
 =?utf-8?B?Z0dqSlV0Ym9oaC9teC9DRmFxKzc4SWpqM2wyNXhubkdTckVZemxZcXNCNmFY?=
 =?utf-8?B?blVvVzkwWC92UW1tVG9TMVMvYXBFTFI4NkNGWDRxQUlFNFAveHpvSXp5Zm1S?=
 =?utf-8?B?ek15Y2FMdm5RN2paeFV1TkwrWlRQeFZTb2Y2ajhXVEJpM25OYUpCTVFaSVZK?=
 =?utf-8?B?enREZ2NiTGE5azZEQ2JJYXZ1QklyMlFZdStEVVp1Y05naGRCTVZFczlERUhY?=
 =?utf-8?B?aUR3NlBxMmlOdU9YaVFNdmV5NG1DREE0eFdiR0dOSjB1OGVOclNLVWcrSWZ4?=
 =?utf-8?B?RHdCeXJRTVlTajlZQmdBUDFFWk9OWi9DZHB4ekQ2cEJtNFprT3pCQXlCVkh1?=
 =?utf-8?B?dml3aTlHb2JtZlRmVnJTTUVqRzdweHVnaFJVdTFvZGdGR0dNUUdNM2UrcmxH?=
 =?utf-8?B?aVo4Q05YT0FtaU1ldGs3Q3prVWE4bllmQlBvQTlnbldTNUNwUFJjM3VydkM0?=
 =?utf-8?B?bzV5enRkV3VaSWJleWw5c3BjcWVueC8rYkRac1ErZVNYZmxXZVU0VXFTb3lQ?=
 =?utf-8?B?TXg4OFphbDJGLzNYKytkR2J1emVxdTcxWklSazJLQnExeHBsbFBYa24vSXVo?=
 =?utf-8?B?VytCMHJlNzRaOHlNUjNFSitwZm5yM3pjOURLaWZuVzd5VUJpeGdhT3VEQUtV?=
 =?utf-8?B?Z3d1SXFNY1htMTRWQnUrd3pCOCtWaTNReUw5RTNJbm9MYTJhMFhWMTErWEdM?=
 =?utf-8?B?VFNmY21rSGszUjFJV3YxL00rR2habFJ5ZHNJdGJuRHcza0VrR0pIVThvUHNp?=
 =?utf-8?B?NVFEOXZQc2ZXWjdWZlhWc3hHMGgzaG5UelRBUkhkODhKd1Zkc09Id2NZNUdx?=
 =?utf-8?B?Kzd4dnZ2b0NpcmxMbnFneEFVNmx0TjZkeDNRY0YxakxkZTA0ZW5YeWpBTGpD?=
 =?utf-8?B?VHBkQ1dLKzM0VDVESk0yMFJKampRdU9ESnpyMG5IU1k4cGhqMG5zWXo5enlG?=
 =?utf-8?B?WW9RaDBkbnVyemZvT3dpZUZhcThpamUwSGRrRVh3d1ovd0FWTnVNTnV6ek9L?=
 =?utf-8?B?SlMrTTR1bWhRYnA2U21nai9tbnp3Wi8raGNyRTZldHE2bjhiQjFVcS91VS9a?=
 =?utf-8?B?NnkyMFZaRFlxNU1SYU9KWFpqa3RFTDlWTHZnZGFKLy8rYWh0dTFkNTN1dk1P?=
 =?utf-8?B?SlpPd2JiYTZrcDdMWXYraEVHb0txN2hBbmpiQldQWEFSdkdIcFh0NHhRMW40?=
 =?utf-8?B?QmNVaS96ZFlYZzdlSHNSeUpXS0lvc1NqWjdlSEwrWWZCYnhKSkROY3ptNnBt?=
 =?utf-8?B?QUlTc2VIeEEra01za3ZxcjIyakVzQllyQUEwN1JUc0xNTVByUE5IZkp2WHJY?=
 =?utf-8?B?aWVheDJUUFVsTURBVEJwZE9sMU5uZkR5ejBia0tFL2EvRGt3dGJuVUZRKytY?=
 =?utf-8?B?dmsyR3g2Z0UyNU9pUjhUYVZMMHNYS3hqaUdmRWNlMDVNL2Exdlk4ZW1MN0VF?=
 =?utf-8?B?TmZJZHlGRkQ2V0ZSeXhLcU1CeGRTN1VWaytqbzN1OTRUaVE1RDZNb2pyKzh1?=
 =?utf-8?B?KzdJRlVHK056am42WkFjNG13MmkyeUlNTWFyaTdKOVhtM3Y0MlNPd2hGRHRR?=
 =?utf-8?B?SUptajhKMTNmMWF1RDMwMyt6OVZyaWJHZmo5bnovK2dqRlpPRDVJakhyaW9L?=
 =?utf-8?B?WXNQMnBDN0gxWkwxenE0RzVaYmlUMXd1U25paDM2SGoxNHBkbFIxTmdaNndX?=
 =?utf-8?B?MlpWR3Z4KzBYamhlOGlrdVU1OHNhRGxwOXZEOXRQMURFdVA2ZHV0ZDBOS0xL?=
 =?utf-8?Q?VU1cuRYC4LC03msIFzxuy7FBS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7794d3c0-1cb7-4060-880e-08d9c3d0ae88
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 15:52:09.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/lBwuH8XKpn+ODLLDwVdF5OycW+ajU8HND6OPJFJMR9spyUrklqOJBsVeay4ndh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: DNj854v3hDc5iOQ5uOd9zBROq9nISd7t
X-Proofpoint-GUID: DNj854v3hDc5iOQ5uOd9zBROq9nISd7t
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_07,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=941 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/21 1:49 AM, Jose E. Marchesi wrote:
> 
>> On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
>>> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>>>
>>>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>>>      as members of struct types.
>>>>
>>>>      The motivation for this was originally the way the Linux kernel
>>>>      generates its BTF information, using pahole, using DWARF as a source.
>>>>      As we discussed in our last exchange on this topic, this is
>>>>      accidental, i.e. if the kernel switched to generate BTF directly from
>>>>      the compiler and the linker could merge/deduplicate BTF, there would
>>>>      be no need for using DWARF to act as the "unwilling conveyer" of this
>>>>      information.  There are additional benefits of this second approach.
>>>>      Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>>>
>>>>      However, it now seems that a DWARF consumer, the drgn project, would
>>>>      also benefit from having such a support in DWARF to distinguish
>>>>      between different kind of pointers.
>>> drgn can use .percpu section in vmlinux for global percpu vars.
>>> For pointers the annotation is indeed necessary.
>>>
>>>>      So it seems to me that now we have two use-cases for adding support
>>>>      for these free-text tags to DWARF, as a proper extension to the
>>>>      format, strictly unrelated to BTF, BPF or even the kernel, since:
>>>>      - This is not kernel specific.
>>>>      - This is not directly related to BTF.
>>>>      - This is not directly related to BPF.
>>> __percpu annotation is kernel specific.
>>> __user and __rcu are kernel specific too.
>>> Only BPF and BTF can meaningfully consume all three.
>>> drgn can consume __percpu.
>>> In that sense if GCC follows LLVM and emits compiler specific DWARF
>>> tag
>>> pahole can convert it to the same BTF regardless whether kernel
>>> was compiled with clang or gcc.
>>> drgn can consume dwarf generated by clang or gcc as well even when BTF
>>> is not there. That is the fastest way forward.
>>> In that sense it would be nice to have common DWARF tag for pointer
>>> annotations, but it's not mandatory. The time is the most valuable asset.
>>> Implementing GCC specific DWARF tag doesn't require committee voting
>>> and the mailing list bikeshedding.
>>>
>>>> 3) Addition of C-family language-level constructions to specify
>>>>      free-text tags on certain language elements, such as struct fields.
>>>>
>>>>      These are the attributes, or built-ins or whatever syntax.
>>>>
>>>>      Note that, strictly speaking:
>>>>      - This is orthogonal to both DWARF and BTF, and any other supported
>>>>        debugging format, which may or may not be expressive enough to
>>>>        convey the free-form text tag.
>>>>      - This is not specific to BPF.
>>>>
>>>>      Therefore I would avoid any reference to BTF or BPF in the attribute
>>>>      names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>>>      makes very little sense to me; the attribute name ought to be more
>>>>      generic.
>>> Let's agree to disagree.
>>> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
>>> come up with the best ISA that would JIT to those architectures the best
>>> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
>>> only. Hence it's called this way. Whenever actual users will appear that need
>>> free-text tags on a struct field then and only then will be the time to discuss
>>> generic tag name. Just because "free-text tag on a struct field" sounds generic
>>> it doesn't mean that it has any use case beyond what we're using it for in BPF
>>> land. It goes back to the point of coding now instead of talking about coding.
>>> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
>>> go ahead and code it this way. The include/linux/compiler.h can accommodate it.
>>
>> Just want to add a little bit context for this. In the beginning when
>> we proposed to add the attribute, we named as a generic name like
>> 'tag' (or something like that). But eventually upstream suggested
>> 'btf_tag' since the use case we proposed is for bpf. At that point, we
>> don't know drgn use cases yet. Even with that, the use cases are still
>> just for linux kernel.
>>
>> At that time, some *similar* use cases did came up, e.g., for
>> swift<->C++ conversion encoding ("tag name", "attribute info") for
>> attributes in the source code, will help a lot. But they will use a
>> different "tag name" than btf_tag to differentiate.
> 
> Thanks for the info.
> 
> I find it very interesting that the LLVM people prefers to have several
> "use case specific" tag names instead of something more generic, which
> is the exact opposite of what I would have done :) They may have
> appealing reasons for doing so.  Do you have a pointer to the dicussion
> you had upstream at hand?

Jose, the llvm-dev discussion link is below:
   https://lists.llvm.org/pipermail/llvm-dev/2021-June/151009.html

> 
> Anyway, I will taste the waters with the other GCC hackers about both
> DIEs and attribute and see what we can come out with.  Thanks again for
> reaching out Yonghong.

Thanks!
