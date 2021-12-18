Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B847479C86
	for <lists+bpf@lfdr.de>; Sat, 18 Dec 2021 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhLRUQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Dec 2021 15:16:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47688 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234086AbhLRUQg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 18 Dec 2021 15:16:36 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BIAbd0G029303;
        Sat, 18 Dec 2021 12:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XYfbzwfQhy1rdrOce+S2VPiQpX2Is4IMlYRC1+SmfSA=;
 b=hpCA2onlyYY9ENMUNhqvx5hK20IOws0U6l4Noy9PaXUnEnnZRUhVKXtU/tzBKAbvWvEe
 7k4veWWQkQtxfP3HA7wbJWWMz6DE0hwgGYCxw+q8n/SYdmqm2P3HDH73d2KtT9SLBsJ+
 yTRzCg7DoLF3IgAA/nF4IhED6LuyQffZONg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d1e22ak6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 18 Dec 2021 12:15:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 12:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6/ZxT5oS/g61rRNoF2VlhEmIq1GhsGpOYGDJvNg466fAi69jDhL9Ev7C4G6LrcoS9ggN7hKpJ6CI7mY8PIPMfl0moyteFoebpjtMoHVa/CNcCVmjJF6lJ0FDpFCjWY0x28yB9JSit8S0XB9jpliBmibXrn61kmVBm9Opns1oSEra/wydT2rvv60Bf/bYcOheq/5hw50vBRFxVkBzSYIXPkYKTH1sdHk4lpPAOZ009ToI+WM5ccOyTCSD8LT1rLaSoQMxefhOLZhQNOTFzlHIv1qZVVJxKsy2GcHcD7F6N7GiOEDowk3mIEI2I0Oa0UTjQaQdQtjf3dkyPOwHs+swQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYfbzwfQhy1rdrOce+S2VPiQpX2Is4IMlYRC1+SmfSA=;
 b=Cqn7BPFZJ/4G8PH4b4JkjTLQD2+O/KuBicZ/N+5gGidFAyX3pYT2dpx+6hBv+DIvQt1+/IEUIiLPtBGfpbIrE+w1VVaz0I4X5/GuMDLdS03hpgv7xN6RWpQOFKC7kzjHJceWatB20KAfesl/1ru2niaKxlZTSu0jhp+wafe4XYZe6A6Rfc/B4UbtRistmw2dqHNn6FUkocArP1t4reHv6NoIzx7oxdDsng5MYEMqChIiF/LyS1ohLq4cRgD/AVbbq8uDOCQACjRCbUwPeQvcxtQdP67Uzyb5NvA/tIaYCc7frNs8ydsoH/ebQT2Z0ssRsXBr5q6po85IkjLPaoQmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2333.namprd15.prod.outlook.com (2603:10b6:805:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 20:15:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.019; Sat, 18 Dec 2021
 20:15:43 +0000
Message-ID: <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com>
Date:   Sat, 18 Dec 2021 12:15:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
References: <20210913155122.3722704-1-yhs@fb.com>
 <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com> <87sfy82zvd.fsf@oracle.com>
 <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com> <87ilvncy5x.fsf@oracle.com>
 <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4288f5-0427-474a-578f-08d9c2632b09
X-MS-TrafficTypeDiagnostic: SN6PR15MB2333:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB23332D86CA2768D883FF99CAD3799@SN6PR15MB2333.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJs2bk5FTT3qUcyJuiCA7BBpAuebzEb0rQ0BRJ3qLfDoLsmCUuAhvueM68HvU82zR20RYoWIw9cFbUpnxUpc+nrKlQ2abvb2/STyNXfC4TtNQiBiVDuAQ8NWgrpryRbpeN6v3y3hTt+LakgoFhTzu2e1VjhBF51EE1eWSIvt1hKqm5+enicrJcyIfmgIcMBJdmkAsIhnbBtXhbrd+SBUG4jGgbJ9jIHNDAF6slx32D+66LvO6nB/yQ6+XnW/zuneeCHepJULjPWxYiY0/fw3xKFeIWkFATbaEoOBKTEFHP636GZ15JRH/LLor7cq5o6XZeBJaG6uR0tTyd8M8iGtanYBiWAETDDOyI6QTMUhwoFuLlFjMOpJKmAJy8+4ymGfpdCpjUF/PCW37GIpqlXdIAanQSoCqooS4/UrnQvQtd5+PXTIO7ollk4Hv8Cno3EetoQ9pYk1WpM94vxQt3+LB+QD32jnOZ/TAdEQzKuhSntka++k+3CPxWRh5tTf/e7lNLc9mQg/fxk/bx7NY5YoA4Ao2kTnEAHBgY6fDJZEYQa+ssgtXqE90CaMSss44cvNEnzflKZb6zZhH+ApBQkjhgscMzkEkaCKZt/ZAw4AZ4UR/3xN9EHirZD51wVUylpe4d9/js29Ujag8UkL1uisdiqx5WE22cpfs14OMP1chWiSnTi/SWQxGW48E256H6iPuifpJXRxGxYrsOCvEdVEAQD7tHbB6RlP5bR09fhhmoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(52116002)(4326008)(316002)(31686004)(508600001)(6512007)(31696002)(186003)(2616005)(110136005)(53546011)(6666004)(54906003)(8676002)(83380400001)(2906002)(66946007)(66476007)(5660300002)(6506007)(8936002)(86362001)(6486002)(36756003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExsK05hc20zV0dQODVKY2lXODZDczZlWEZWQVMyZFlUazlCT0lDeU1PTXNI?=
 =?utf-8?B?MTJzRzdCajlwOWFkaXovZlJNVjJ6bk4yWWhhaTM4OUt4TzZERFVlTmk5amN3?=
 =?utf-8?B?SDNEVVQ4b3dyTkFIeWc5d2ZGQTM2QzJEd0h6QkVrdE1RUHc0a1l6MlE5TVJj?=
 =?utf-8?B?dVJ4VjlacUhhaGpZUi9iUEhDa3VUYWt0YkdVWWVuQTlrbklhT1VLUnJQcGNZ?=
 =?utf-8?B?NmdvKzBwUGVVTFNqSW02SnFZeS9qMFBnY3B4UkduTUwxSGVYMnRJTjFhZmFj?=
 =?utf-8?B?UWlZSW1Xb1I5ME9MZzVHK3d3NWJITjd6cmhPTzVnZTBhQlQrVEdMeERXbHNK?=
 =?utf-8?B?YXZGR1hRWE5UbmZ0QWtMVFdwSzBJUHluTXVjR0tBZW9WN2R2UmVBODNEbWNY?=
 =?utf-8?B?VnBFdmN3ZjVsZXJEc2hTSDdXdnJ3Zlp6d2hubEN1ekh1c0ZnQ01uK3M1VzE1?=
 =?utf-8?B?U3pXb3dORkpjRFhTbmliMDVEWHNQZGtOcmlFd3ZhdWcwT2NRc3lrWTc2N1JF?=
 =?utf-8?B?SzNpeEsvWk03SW0vRnlDZU1US3lNbllERWoyaWttNEx4a3pVZlpBVlEvT29D?=
 =?utf-8?B?dG5iWDlWNUtrQ3crU2JuVW1OWTBrand5M0xkeG5sOUVVRVlVRjNjakhKQnlp?=
 =?utf-8?B?YVZCU0dqWUxJVzA3VmJlSHpxcUxnSm1NQXZpYjRoTHNPMlplL1piZU52OHJa?=
 =?utf-8?B?UURNUmN4MVlEeHA4UmdMZFZvdWc5T3o0bVMxb3pLVWNSNS9FNzBqRHplN2Er?=
 =?utf-8?B?MW04L1cxTWhxdVF1K0l6dVJubXJNNHZpRE5pWTQwbTg2WUJtSHVjRHlRVmsw?=
 =?utf-8?B?TTR5VXpKWTRnQlkwa0YveWlPdXpiYXV6cjlRTlVsQTFKd2hSazEvNmU1bC9Q?=
 =?utf-8?B?K0VZbU9rWG5tcmJmRmVxUmVBZVBVcVFMZEtrYkJuN1FjVStKVzU3bk4yVXJJ?=
 =?utf-8?B?K09KR25UR2szbXF2TktDdjNmVmQvaHdlYzZMUmZ2SWpKRXZTTWNnUlBHWHBS?=
 =?utf-8?B?enZmYkQ1QW9WYWhrVTYxczdPc0dvTUExeE1qemtsY3VxUTVXM1lURHRtcEY1?=
 =?utf-8?B?WnZVRVhMcGd4VWorY0VCblVIQ0J4Q1dYR1Q0Nnc0eDBnaUNtYVBXTG9iQXMr?=
 =?utf-8?B?VVBlZzNlYW9MdVY5Qm95c0twVTFVZ3RaNXZEenZzNysvUUcwbzl2bkZmUHVP?=
 =?utf-8?B?NUp4UzlZSkEyaVVINXUyQlFtdTFITWFlanBxSVFMQ2ZrbCt1M0N5R2wvK1Vv?=
 =?utf-8?B?M3B5S1Y4RjBNSlZReC9RckhDRzhtTzNkanUzZ3Rrbi9DT1cveEk3bmFiSnMr?=
 =?utf-8?B?MG1UbU8vSUR3NmpFMEFuMGp5QnNMd3VXbEduVnVBMk92M2FJaGtnMDhod1VC?=
 =?utf-8?B?V1l0SFM3akVBSHE1dVBYWDBoZWo3QU1FM0NGU1dvYVFKUXM3MnNqbGZ0Nmk1?=
 =?utf-8?B?NXBCYmVWS3JTUEZTU2VVaXNNdTY1OVNhS00rK2xUQ2p0RWxyMXEyTjlUdFRX?=
 =?utf-8?B?MVVQYnlTeUg2SE5MemJ0aXJhRFNOOHduWFYwZTJJVzRmbDBUSHI3aUFyOW5K?=
 =?utf-8?B?NDg4dmhSNS9pWk5FNWpoSlo3UDJiQkJDNE1ncm1ZOUFxdTdaSnEwaVcrZEND?=
 =?utf-8?B?R1o4Sk5WY2NlMEM5U0RCK0NwbWhobzlnTTlyVjRBWTMvQ2NXRTkzdjd3NEFU?=
 =?utf-8?B?eGdWVTVJbEI5S2hPVENPWTZsZGJ1TUc3Z1c2YklNc0hkRG14OE1GTDZLUEVp?=
 =?utf-8?B?U1BmaGhMUDlLQ3FqODU1eDg2aVJrWHIwNEJEMUEyUG1sdXd3N0hYR1l3MDRi?=
 =?utf-8?B?UHNiTDlsWEFjblFKRDNwYjk0N2tWSXB1YnZMNHpRWDI1eEhBL0xEMm1sTHJ1?=
 =?utf-8?B?OTBadVNUSGRwb09WWW81dDl6S09IV3NZblZlRitZMTEyMm5iOHJJMm9wbUc2?=
 =?utf-8?B?UVpLY0N6ZjlENVNzZVBGQ2JPNkZnSlF3RUJQbTM2emlaRTV1SWs3WEVVZkx4?=
 =?utf-8?B?TDV2d3dRT2JUMW15WjlIVGlBWURuUXZmZ1dqNU1oeFhxN21BZDNWSUVNSmlx?=
 =?utf-8?B?M21XLzhrc0lWUy8rMWFydzRVNFZYMEtRWC9zTk1wQWZiRytQYjRKaWlyR3Yx?=
 =?utf-8?Q?7ucco9kBjLz1R/5rmU1WNb5rZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4288f5-0427-474a-578f-08d9c2632b09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 20:15:43.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p71JeqOc4rITjRa2AqETlfbo9k8JX+8zHJzrsC0L4qXVzp4wQ6SFRnH0XAmCLFZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2333
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: t9kG8CQX3eyv-pBuEzVxW__62lXMgKB7
X-Proofpoint-ORIG-GUID: t9kG8CQX3eyv-pBuEzVxW__62lXMgKB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-18_08,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=905 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112180122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>
>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>     as members of struct types.
>>
>>     The motivation for this was originally the way the Linux kernel
>>     generates its BTF information, using pahole, using DWARF as a source.
>>     As we discussed in our last exchange on this topic, this is
>>     accidental, i.e. if the kernel switched to generate BTF directly from
>>     the compiler and the linker could merge/deduplicate BTF, there would
>>     be no need for using DWARF to act as the "unwilling conveyer" of this
>>     information.  There are additional benefits of this second approach.
>>     Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>
>>     However, it now seems that a DWARF consumer, the drgn project, would
>>     also benefit from having such a support in DWARF to distinguish
>>     between different kind of pointers.
> 
> drgn can use .percpu section in vmlinux for global percpu vars.
> For pointers the annotation is indeed necessary.
> 
>>     So it seems to me that now we have two use-cases for adding support
>>     for these free-text tags to DWARF, as a proper extension to the
>>     format, strictly unrelated to BTF, BPF or even the kernel, since:
>>     - This is not kernel specific.
>>     - This is not directly related to BTF.
>>     - This is not directly related to BPF.
> 
> __percpu annotation is kernel specific.
> __user and __rcu are kernel specific too.
> Only BPF and BTF can meaningfully consume all three.
> drgn can consume __percpu.
> 
> In that sense if GCC follows LLVM and emits compiler specific DWARF tag
> pahole can convert it to the same BTF regardless whether kernel
> was compiled with clang or gcc.
> drgn can consume dwarf generated by clang or gcc as well even when BTF
> is not there. That is the fastest way forward.
> 
> In that sense it would be nice to have common DWARF tag for pointer
> annotations, but it's not mandatory. The time is the most valuable asset.
> Implementing GCC specific DWARF tag doesn't require committee voting
> and the mailing list bikeshedding.
> 
>> 3) Addition of C-family language-level constructions to specify
>>     free-text tags on certain language elements, such as struct fields.
>>
>>     These are the attributes, or built-ins or whatever syntax.
>>
>>     Note that, strictly speaking:
>>     - This is orthogonal to both DWARF and BTF, and any other supported
>>       debugging format, which may or may not be expressive enough to
>>       convey the free-form text tag.
>>     - This is not specific to BPF.
>>
>>     Therefore I would avoid any reference to BTF or BPF in the attribute
>>     names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>     makes very little sense to me; the attribute name ought to be more
>>     generic.
> 
> Let's agree to disagree.
> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
> come up with the best ISA that would JIT to those architectures the best
> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
> only. Hence it's called this way. Whenever actual users will appear that need
> free-text tags on a struct field then and only then will be the time to discuss
> generic tag name. Just because "free-text tag on a struct field" sounds generic
> it doesn't mean that it has any use case beyond what we're using it for in BPF
> land. It goes back to the point of coding now instead of talking about coding.
> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
> go ahead and code it this way. The include/linux/compiler.h can accommodate it.

Just want to add a little bit context for this. In the beginning when we
proposed to add the attribute, we named as a generic name like 'tag' (or 
something like that). But eventually upstream suggested 'btf_tag' since
the use case we proposed is for bpf. At that point, we don't know
drgn use cases yet. Even with that, the use cases are still just for
linux kernel.

At that time, some *similar* use cases did came up, e.g., for
swift<->C++ conversion encoding ("tag name", "attribute info") for
attributes in the source code, will help a lot. But they will use a 
different "tag name" than btf_tag to differentiate.
