Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A949AB22
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbiAYEi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 23:38:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S248462AbiAYD7G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 22:59:06 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P0RH8B028857;
        Mon, 24 Jan 2022 19:58:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wRB3lCMn+UC1SmE8GJn3XS08vpXhaJvJCxk8WktO0Oc=;
 b=TsviL3qrSN8QnKS5txuz+7dvqLh82ZCzkcfoxVtmJgKnydTpA8ovqlRslVxGrbDaIOPa
 nHSqeU/z6laXoUc3n3pPzN023DSK1jasuO9zR2ifEWtm0Yh4qqGXnYIT4Mzp5W9AQ3jx
 gMm2bpQoqZx5A4Zf6uk+TOxWcEdGhy4uH+k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dsrtsxpxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Jan 2022 19:58:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 19:58:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWDNQGBWYUuVs+Yqx8cc8sm/k8hFmuo3Vtq4fmrRvtaF293b1OQ4+sDpce8eNtIJAEottMHiwrE7m6Wyi02yXq1btJ/ovTsWVOc+A+0rTiTJm1b9LoiHe3aECsgD5OKu7+lYWX0h939gS+8XYgKqyLqIm8Zpds7pczDHi7Npxe/JVkrYyQrEYwM72G0K1rv4x3BovbJs8JJ0xD/0kKth/qcFvS+Meigo0QbmWtuQdo9197Vq+WPZG10ejq4vchnAgdoEzVYBDmuLM/yGDrFdkXTV7gVYpcOqVAqpcVb3IVg7cHnFYJ5xahCykMRkwfq3qnEf4DefWFvi34ZFNP59PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRB3lCMn+UC1SmE8GJn3XS08vpXhaJvJCxk8WktO0Oc=;
 b=f8hHvTr6+Oz3ecqvEBbs8s7KDo7EldZ2PnUSh10TLILxDIIVZvvfEvnxPukAEn4ysQY0bkn4HsVlAMWxTBeoL6JPf3g2yDgSLwiuZbLxoZFHu7m3OWbykwvPkNoP+bethgoq/PubHlp7hsRJFrO/Z6NiYXNCNKmMo3AWWUVxbaBtxHWVrkR33sMjI64pe871a2Kxqz53wGyuhlgi9Na3mLD/KegtH3FsjRi/yeYto6o4Fbp5TN85fsI+OuYuv38VTXf/BmjHbfn5z8nLn/MpFDAFoWK/uxGdPWZJQu7RAd/LFIjKuHrLksfccOtMkuuyPBwQF3OcYGhP8pDReHEKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5124.namprd15.prod.outlook.com (2603:10b6:303:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 03:58:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 03:58:29 +0000
Message-ID: <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com>
Date:   Mon, 24 Jan 2022 19:58:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001c147c-80bc-4775-4725-08d9dfb6f27a
X-MS-TrafficTypeDiagnostic: MW5PR15MB5124:EE_
X-Microsoft-Antispam-PRVS: <MW5PR15MB51248591770FC53D74216A0BD35F9@MW5PR15MB5124.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UBCyWBF4AGM8Sk3sHEoRNwpTWVo9EstQqHkSUcy6mk+FXtBI7gdGgfsQCibsA/KM+PqudDeLYpCShrakLCViIoxkp6mW8MRDIzua0+msD8cZN1JPTgojE2yGgR+YpPfnWAanoBQy0MX4VwNxPLdmiRURNZUTh9NxgX6sk3/7nug535grvL+w+FaTb1uBoUwnAY4aaXL1rzf8AZeDoUL7e/CcxTF0rvHgLYXa1HzFwlbA9GxGZQypasEEl7lfSIXa6d5lJ5i8IgLM7pxpc50DqiUPEJyUV0YLV9WsVhuLSZN4i9bjV1VS7gDsbSzRaoUsFybxsNgtOzOsn+tr4RtKpiTLF8cWAYSo5yH+HCx9yk+wQFuGMofebSgQ3u2jZrJLLCf345600MaiIT69fT/Z8ctSpMNRgT48jrgg6DOyNkD/mCipfNED85gfy/3bMg8gkFxSfGu8mbc9ZTvzWUdOx4X40UhLmEgJPrV2odkRQBStZ+CqA8hEn0bFk05yUglFjsB5tA3rs2js8hTb5adPDJqLK6jC8M8SXC10p9b/gJOWIWeVp4/MdR8YCw3AKR+GGzuZyewmwTfkeRnLAak8PSr98M0BuTgfY5N/l+wzRsHDJ2AKmabSLi4NybEIHzXPj5ZJaqpUm1Ha1qxVJEpPFvzO01WR3cmWl6B0cSJ33kjvdX7KQkZQbKxGVs+X/RLDh/rpx6dIgWAE+bLPiYQ19Bh9aTrVU8J0h7vGcsFuP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(31686004)(8936002)(2906002)(6486002)(186003)(5660300002)(66556008)(66476007)(66946007)(8676002)(508600001)(36756003)(83380400001)(6916009)(53546011)(52116002)(316002)(31696002)(6512007)(4326008)(2616005)(86362001)(54906003)(6506007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFhMzJoa2VSYjZDTnBoZ0hMTXg1MVJvMUdLRmRyU2p6cWFsaDFWeUtEUlpZ?=
 =?utf-8?B?TlZKZllMdGtiMGV1MElVbXpJYkJ3QWdBbVlRZGx3THJJaFJwNHVTMWhDWTVK?=
 =?utf-8?B?Vk5oZEErMXZXaVVGYU9pVEd3RHhGVTEzL25jT0NYWnoraG1aempmZDlZUk5w?=
 =?utf-8?B?YnkyN0h4ZVRNQWdLTFFDbFR0ZGw1NURvNEhURVJlendja3RjaU5Qa25PZmcz?=
 =?utf-8?B?NUxnTU92STlRbm5BK2RFYUVHMENwRVZ0RkQrVHRUVFFFSkYyTkxlWm9RRnZI?=
 =?utf-8?B?WkNpT0xLaFZsUXk5VllqMkM1L1ZTQVJsaWJVMG0xT1YvSGc0cVdKZDdDcXFH?=
 =?utf-8?B?S2M3bFRmYlZjOVduYXlSSS8wL1ZKNkVpcUM3elhKRDdNcHo5N25aTDFhdjln?=
 =?utf-8?B?dTJHRVplL1RtV0VaVmVkR2d3Qno4Q29LVk9xTFJPMnlHZS8wWlFYWlN3VFBT?=
 =?utf-8?B?OG1RNFRWWndhdFdOUjdpQkxGRUJZb21Feksyc3hSSHNUYzlDRVM2b2NYTzNX?=
 =?utf-8?B?dGpIVDRjNlg5dGl3c05lakp6c3BYbjJ1eENvOUQxdXo3bkJvRG1YdG02RlJG?=
 =?utf-8?B?NDhJRUpTeE1FMTh4ckFRSkJFdm9ubytVOGpCZzg4YVNnalJSc1ZVc2pUMFNW?=
 =?utf-8?B?OGhDN0hGZ0xKc0I1QjBLZEY2QUdOOFdvclFlb2dyd1RlTUI4YURQUHJpellC?=
 =?utf-8?B?OXd3eDVjdjFxRWtKQjRwU05NMTBDTmRSaThQbWZ3UEJPN0FGekpYeDFhQnRQ?=
 =?utf-8?B?S3NyUVFqbEtlMWxiR1Bldk9wUmFScVpkT0NKYVF4UGNITjMrcFY0bkUxTVNM?=
 =?utf-8?B?YjMvL0JrY00yamx0azd0VXQ2QXJlU3ZGcnBIMkhOSG1heHRKRzdHeDJrSktr?=
 =?utf-8?B?anAreDhway9mZ0liSXAzUUpaNlAwM3dPdGNIOWVEajFZelBrdXRreGxTajU3?=
 =?utf-8?B?RDJHMjlSSG5zdm9sOXZld2x4c29aZlJVbWFPUzVYQVRRSTlmMnJTZkJDZkox?=
 =?utf-8?B?SEtKN0h3WTltQW02R2ttaUg4ZEFLR1dBQVJZSVdraDBsOGhoamZab1Z3YXJK?=
 =?utf-8?B?Qi9aQ2ZHeHBnNk5pSUJjSTJKZEh3WnAyY3BxNmJad0lYVUxTa0NnNEJFQ005?=
 =?utf-8?B?RmFzdEV4NE4vQ3ZhTmtadDlNNWFLSnJhZHVHdzRESDNKbGw1RHpPQkZtR0RE?=
 =?utf-8?B?L050bjFxdE1HSUo4REZYTnlEWkxiQ1BVTDRmN3BjU0JkNGN1cy92NFhtWlRa?=
 =?utf-8?B?ZG9GY25KaThCZmZtcEVVUGVlQlFCN0JYSVhtOGlkbCt4RTRzcUdEZXJSK1pz?=
 =?utf-8?B?elZrWXozblA3cEFWLy9wODB0aEFjSm5odWlSb0V5TmdKbHEwNDJHQm9NeG03?=
 =?utf-8?B?SDlRb08xOTRwV2lWVjJxQ1NwczgwRTJUbUQxSURYLzViTFZtS04wWWRZZnc0?=
 =?utf-8?B?QlVnRDlGeC9COTY4M0pwd1lMTVBtcHFGNFBkMFFDZk90VTU3N3g4UmcyRTRn?=
 =?utf-8?B?MU5reFJUcG0zbGZ5SGtQVGNLTkRZcGNUSEJWckN2R21VdXRadWxjdUZvWVFh?=
 =?utf-8?B?K0ZWdllCNVpDNHZzTk5xUm11b2Y0dGpKNktwYXlWVkJGV2NCODJCeGdLTXVm?=
 =?utf-8?B?am9KWkd0S0E0eXV5K0RpdFZKUGhnek1mN3VLQW5PeUR2NEhPY05sRmlLYzZp?=
 =?utf-8?B?TDY4WUltMmZmdkJyNHBLNG9UMlZGS3RXUlgzVkxwSFVGbG5wYjcxQThhdTJL?=
 =?utf-8?B?dGZwcmFiN2VVdXFKL2pJSG1ZN0JvQU8rVEZRVzdFRmd1VUVZV1JMOENIUmlq?=
 =?utf-8?B?VjRQeEdoVU5BWmV4cG92VTN5NEl4TzlTY3o1bGtWUjlyKzIyN1FBbDkreCtG?=
 =?utf-8?B?NVVURUQyTERvMVQwb0tmbStwUDFqcitxc0NERTRVbzlCaENYUnMrTE1pak5x?=
 =?utf-8?B?RUYydmpHQXR6b0kwYjUvU09GYTE5c1FYYkFiMk92RmE1UlZuVmtDRGd0S2g1?=
 =?utf-8?B?WloxYS9vWEpCaStqYVc3THZDVFoyQUMxbUNMcitvSit1WnJDQWRuZ2Q0Njkz?=
 =?utf-8?B?Qk1PUkhUb0h3aGNYQzAzNXZCNzFFb3dkK0tqWENsdU9nb0VLYXIxZlpyTk5O?=
 =?utf-8?Q?Trm9ggtVZFv65eksMC0q+aYwP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c147c-80bc-4775-4725-08d9dfb6f27a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 03:58:29.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpppTFxyJbREv3kRZcDtQpL32F9vdBPvryl4J/eiugAj0OLnMcjmntXuINxNQOL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5124
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _eP9HXwflUeKeYgc43WJMOS9S1HZhaJJ
X-Proofpoint-ORIG-GUID: _eP9HXwflUeKeYgc43WJMOS9S1HZhaJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_01,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=799 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250021
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
> 
> Anyway, I will taste the waters with the other GCC hackers about both
> DIEs and attribute and see what we can come out with.  Thanks again for
> reaching out Yonghong.

Hi, Jose,

Any progress on gcc btf_tag support discussion? If possible, could
you add me to the discussion mailing list so I may help to move
the project forward? Thanks a lot!

Yonghong
