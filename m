Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964447A76E
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhLTJuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 04:50:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61820 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhLTJuL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 04:50:11 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BK7S5c5009970;
        Mon, 20 Dec 2021 09:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ayQ4LBFnsKS7i0oijbbJAUqzVrRAwe+ljq4WFcH4qIo=;
 b=GI5DEY2R+rmYjqzK0QGurCV2JBgWtQtVIufPHPTF8CPo5bT9kOx5gMafbfeBPw0p7KiA
 iDn54NcVHoU3X5tdRkxXZTwpU1PAArzKs6qc5yUHUyJXOIk+AvdwfL/0jqOEQAZseQGz
 T/xRMxsSjq7E3Vq/gibSfs1zilJpRIhAm5TGecSCfXq0CdRfGo3FBw8M7n72lszRXdqw
 dWOmap74nrye86mNu1Vt7oc8f4uMRCwI+XMZcR6b58kLQ8JhHKtONYmJ5mHbZxOa1nyp
 XaqxWpeUK8Ghc+23++RaklmpPPB61M5P1rFIsnm/dlol9KaXTrf/D4Lj//0udtqU1sIp 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d178t2ynt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 09:49:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BK9erjR133525;
        Mon, 20 Dec 2021 09:49:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3030.oracle.com with ESMTP id 3d14rtv04a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 09:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2/RB1EU0H8B9b9kIMG96YIKwZIGuBKwP6GqovClgTKLR2saSETUxLP3btkznrvMmdCBSjk32XW7CY0Ecx8iIG427anD649BQj55vMKgQt/55ptrC7VGoRsyMeL1/eYn8G1JsikO7Xa8Bh8KOXWdDsOlA3ZGRfdghm2cTKQUCt5LwxSE3hxuO/X4entR+7OSv6FS96Oug1srleCrlq2oq+v3zHYip226mBTmnmwj5mofFQ9FlTqNexPisC+NGr5/QaGGR1X2Umv6N347iC7MqgOFzf2OWmB8y811HD7czR9PoBhE/n/2klde8IL++eZlzGjxWEdJtELnY3h0HgVufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayQ4LBFnsKS7i0oijbbJAUqzVrRAwe+ljq4WFcH4qIo=;
 b=GzoTvo8NUeueL89l1SIEpbP0Oy+O4hXlRQ6stMARt5inuwQyEdrG8XMUzoUVHW6mItkAjH81PvXqgxYs4cGKJZEcbhjn23waAx9u+UXpU/ImkS38SVZq9RtuG3TE0ZKe3XliGadABGGoC3iPkN+0UpMMhT2/zRwkr7OSm0n7UNlDm5Wf9C3Fv/eU4RbZnC1gVyktrQ3qAh26R/AmUrf+RuXpBStaygJxCyXZ4XKa1eFKivRGkNZ5AgfVQpnBokzSn0xFE5TCydwWtLiBqnQmu1IRFxfULvoWXA606EWDH8Q5c8ZC3yNvPMjy8yxptTYTbdN2zmiTavGj7hVeIKc9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayQ4LBFnsKS7i0oijbbJAUqzVrRAwe+ljq4WFcH4qIo=;
 b=SN9IPtiC9pvoVVFKJjMt46LsLuq8dX7HYqxMs80ohlcx3hCia6xD8x/U4vYNyojlYhX5qu6Jlz1Dx2Xle9iHDSDgkf9w8N+44MuuUau9lUXcGCR37OMaMR6qaAWzNLTrZIkc0QQG2xqYbMQAgXHMnBJx8cHZyJZLEE08TOw1R8c=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB3429.namprd10.prod.outlook.com (2603:10b6:a03:81::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 09:49:31 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::8966:789e:5a45:942]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::8966:789e:5a45:942%7]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 09:49:31 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
        <87sfy82zvd.fsf@oracle.com>
        <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
        <87ilvncy5x.fsf@oracle.com>
        <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
        <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com>
Date:   Mon, 20 Dec 2021 10:49:22 +0100
In-Reply-To: <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com> (Yonghong Song's
        message of "Sat, 18 Dec 2021 12:15:39 -0800")
Message-ID: <87czlr4ndp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::13) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c866bb13-69a4-4cf2-2d7c-08d9c39e0597
X-MS-TrafficTypeDiagnostic: BYAPR10MB3429:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3429398A6F9A59000185BEF4947B9@BYAPR10MB3429.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHe1svwFKPkE9RHpbRXu1S/68yfjGyWf3JJL0azhJobdSawmvEykjQCQSRPMI8IFnYNTp0hU2A+MvkuZJgnTj6q4cyeMzXi3gyb3tJKTheI0SiIVwHSeAMOEnAbOseN+pgCpo5r9XV2Pjfi9u0uN+Dr08mrWvKmjVLetUVMN/t8NlO6SZRWcrQEww+EwkwyBil9A0PjmdwRRO/3OtAmF2jHEua+vAbFlUB8aqv42uD+dfpRmcHwz3hI1UUCcNLYPhy5xCAAiVXeAI3PbmQVMXcAyXoZvQsxxe7fMP39RerDSoB1O45LHI7IHx27RKGDyuBIYEthdDh7PIMkUblipNHjQKq94xwHZ+auhYuPAxOU2G6hX2CgzQPERojSX5T0F6haXW7zQTGBUmXd21FlMnYEQzWu+vrTzGngcfr/dsxa955WB6mkAGLovAjWZpuE35NXLoCppZ8eHS2hwCC1pmGHc54kU8JQRtma1bsFtAk2tqjtk46XnEYSMyNz9f4R55OoIjs0x55rxO2+B2xu3P7I2fNrYmdeepdzRsr6EOAsy/O/GsLb/86XXcAdU7bE0jjR+qIy1Wupwr4ggP1O29rqu53ALlofJXY1FPNz1p21cvEpWu92GmhY60xgubbVamyNaeiFrupO8Um+p6ltOz9uK9n3Fv79v0qoZ0TSRK8Zpw8PqZaLjLplxCQaFfcrjEWelQOdnMX2/6pu5yy3d9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(2616005)(8936002)(6512007)(316002)(54906003)(8676002)(83380400001)(186003)(6916009)(6506007)(26005)(508600001)(53546011)(66556008)(6666004)(66946007)(66476007)(4326008)(36756003)(2906002)(5660300002)(52116002)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbkvYnae6JItzlOIxt5LVacAtTnrV3Hm9SD3m1l1vuxBcUgASjQ1AQl+8Qa9?=
 =?us-ascii?Q?oCHAtNKq1b92FL7SW4ybu2JNye/nrChuPWO4mlf86TJwYl/DL8y1n0x2X3ra?=
 =?us-ascii?Q?fg1gH2rB8bsksqTgl9F5lfQvpRsaeOzNBRXZE0/HBHTe9KzmD1YXY93S4xO4?=
 =?us-ascii?Q?FVjtzk7W1BoMAZ5+q7bB46Iw3DyjfyuxDzfmL94CxAVFrXn9PSGZL9IRvaaK?=
 =?us-ascii?Q?4n68zR8lLfztNvSAxCSLRssVquyrXg3+gfYzmUzYT/RzbvbcyyFnSM2jak/O?=
 =?us-ascii?Q?Z/Gu0Txu2Ysmmb/KOQQ/MZXVVEqX8VyZtsDVUy4LhUfnBUDJhuQWndNN6wwt?=
 =?us-ascii?Q?yD+pcNuA2DTB5+L50k9lKMEqwhuTv8LUuT19n0tqC2q3gGs/tLf9dmNRK3wq?=
 =?us-ascii?Q?T4uPJO9XWR3MXRJqfEbffIc4KWWZuZPtDmHIAedf2pXQvJgZGmmu8MugtRkT?=
 =?us-ascii?Q?GXdoYlcf4TjOhZ+CO60l8ah9wbGYY/1jmOlAmPqj4QOZDeLHxV7UR+4h8w95?=
 =?us-ascii?Q?LSvzInJEZfQDfID1N3/n+UWK8r7ht1w6ndhxLGbLD3ayDfSv5DtO/a3Rw92U?=
 =?us-ascii?Q?9h/+njqfN83uyL3P4Wvc4YJGs40RX2KNOJ2/lF22lx/jMgYNe3/JMFbRiXgq?=
 =?us-ascii?Q?3ZkJptJJhoNy1eb+kik26/gl8XycIWZoSGNaaA+G+XIa4VNgkoruqJiafvkf?=
 =?us-ascii?Q?947OLAo5pXOqOiO0mXWEq4obFzK+KkIWru4GsoSTLNhLCFBoQ0Li61Yd8lhi?=
 =?us-ascii?Q?vubVS8vckMrpuaRKC/4nvbJsag6kXHhdx7hW/FwcICoLbyt3IATbdgbyXk4H?=
 =?us-ascii?Q?g+iCd7KiUWMRL2Qv2TuhiNoEbgcJXKOr3H+i1/ejDC3GN8iebs4CHFvTH9gB?=
 =?us-ascii?Q?I2sDLhPDn0Msmr1CB8B30nh7KpnEYp/euEdF23PCQZQl5PxVbLeQLGWuUWmi?=
 =?us-ascii?Q?lDy4e2G005EJZ/O/VA6Pns7oDKM/tPlEEO9268mhdXc1DM6L035d89Lc8Ip4?=
 =?us-ascii?Q?DCfV25a8r7CGpVrbMqKB8uAJ5Wt5jLFDh+MTyGU0TpW6qNTGyQ3NGoQ5k0MS?=
 =?us-ascii?Q?zIXrxD4pesJ79MJFYzRMrwT9Afsd3FA53QXuOqtep2fiX3bki0JiHO0IdGAK?=
 =?us-ascii?Q?V/U7fKc50qah6GTf7EfxMjZPXFfQtMoW43sFWE5Wjx5FnKh/hi2mwdlt7ssV?=
 =?us-ascii?Q?0OuKbAEy6ru+PbP7wG+QBt/qJ/vpBige27TZjUSYjH8gjzuI9I5YsTHTZC5V?=
 =?us-ascii?Q?yROfuch9I+adHKK3D8svvnYoD+1bR5kRShYtiE3pOOLda42dtH1CbL331kOw?=
 =?us-ascii?Q?CKnZUHt+bETBdCe5O5TNBWIZQ55b/deMXfPm9Ufyy1AcrSRm4b/lh4j9+TI4?=
 =?us-ascii?Q?rT01By6jzYGePaWUhr0neLSLsMuWD0upI3zg8TDi1x97pjpEvPYyNVIQ5HJX?=
 =?us-ascii?Q?TOBY2Q0CPGNNfWwP3QdmvAPTq9HFUUSFJt3r1mFAntR1AU220VTADZ4W8FIM?=
 =?us-ascii?Q?ehIGu128w6ub6cJJMJbovQ1I//oi0zCxUKImYwlmQKqxc+Kbr2RWpEkbAY9K?=
 =?us-ascii?Q?ADmB5vLrkQLrGxnCmpLPSnnv4VlETrM1U7raoLzCohVRRnscV9ansghCGP7P?=
 =?us-ascii?Q?5q8LKgg/aWCZdmGgOMwROHj5WAlpiS5qiUB84Z3FfBk45Xl110nom87G5Lfq?=
 =?us-ascii?Q?vxWacg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c866bb13-69a4-4cf2-2d7c-08d9c39e0597
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 09:49:31.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCshg9SQ+oNAh+KVAUxUjg97rdPrLM9wPYEzJvkinQbR4FXEW2ZxaPA8PdnVgzxhJA8UmVQFRhlQQ4vQ2B4OaCl4GcIrpHLvu91zkLn90k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3429
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=949 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112200056
X-Proofpoint-ORIG-GUID: qw70Or6u1ZJl75yzx5ZdEaSa9F6qBuTp
X-Proofpoint-GUID: qw70Or6u1ZJl75yzx5ZdEaSa9F6qBuTp
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
>> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>>
>>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>>     as members of struct types.
>>>
>>>     The motivation for this was originally the way the Linux kernel
>>>     generates its BTF information, using pahole, using DWARF as a source.
>>>     As we discussed in our last exchange on this topic, this is
>>>     accidental, i.e. if the kernel switched to generate BTF directly from
>>>     the compiler and the linker could merge/deduplicate BTF, there would
>>>     be no need for using DWARF to act as the "unwilling conveyer" of this
>>>     information.  There are additional benefits of this second approach.
>>>     Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>>
>>>     However, it now seems that a DWARF consumer, the drgn project, would
>>>     also benefit from having such a support in DWARF to distinguish
>>>     between different kind of pointers.
>> drgn can use .percpu section in vmlinux for global percpu vars.
>> For pointers the annotation is indeed necessary.
>> 
>>>     So it seems to me that now we have two use-cases for adding support
>>>     for these free-text tags to DWARF, as a proper extension to the
>>>     format, strictly unrelated to BTF, BPF or even the kernel, since:
>>>     - This is not kernel specific.
>>>     - This is not directly related to BTF.
>>>     - This is not directly related to BPF.
>> __percpu annotation is kernel specific.
>> __user and __rcu are kernel specific too.
>> Only BPF and BTF can meaningfully consume all three.
>> drgn can consume __percpu.
>> In that sense if GCC follows LLVM and emits compiler specific DWARF
>> tag
>> pahole can convert it to the same BTF regardless whether kernel
>> was compiled with clang or gcc.
>> drgn can consume dwarf generated by clang or gcc as well even when BTF
>> is not there. That is the fastest way forward.
>> In that sense it would be nice to have common DWARF tag for pointer
>> annotations, but it's not mandatory. The time is the most valuable asset.
>> Implementing GCC specific DWARF tag doesn't require committee voting
>> and the mailing list bikeshedding.
>> 
>>> 3) Addition of C-family language-level constructions to specify
>>>     free-text tags on certain language elements, such as struct fields.
>>>
>>>     These are the attributes, or built-ins or whatever syntax.
>>>
>>>     Note that, strictly speaking:
>>>     - This is orthogonal to both DWARF and BTF, and any other supported
>>>       debugging format, which may or may not be expressive enough to
>>>       convey the free-form text tag.
>>>     - This is not specific to BPF.
>>>
>>>     Therefore I would avoid any reference to BTF or BPF in the attribute
>>>     names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>>     makes very little sense to me; the attribute name ought to be more
>>>     generic.
>> Let's agree to disagree.
>> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
>> come up with the best ISA that would JIT to those architectures the best
>> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
>> only. Hence it's called this way. Whenever actual users will appear that need
>> free-text tags on a struct field then and only then will be the time to discuss
>> generic tag name. Just because "free-text tag on a struct field" sounds generic
>> it doesn't mean that it has any use case beyond what we're using it for in BPF
>> land. It goes back to the point of coding now instead of talking about coding.
>> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
>> go ahead and code it this way. The include/linux/compiler.h can accommodate it.
>
> Just want to add a little bit context for this. In the beginning when
> we proposed to add the attribute, we named as a generic name like
> 'tag' (or something like that). But eventually upstream suggested
> 'btf_tag' since the use case we proposed is for bpf. At that point, we
> don't know drgn use cases yet. Even with that, the use cases are still
> just for linux kernel.
>
> At that time, some *similar* use cases did came up, e.g., for
> swift<->C++ conversion encoding ("tag name", "attribute info") for
> attributes in the source code, will help a lot. But they will use a
> different "tag name" than btf_tag to differentiate.

Thanks for the info.

I find it very interesting that the LLVM people prefers to have several
"use case specific" tag names instead of something more generic, which
is the exact opposite of what I would have done :) They may have
appealing reasons for doing so.  Do you have a pointer to the dicussion
you had upstream at hand?

Anyway, I will taste the waters with the other GCC hackers about both
DIEs and attribute and see what we can come out with.  Thanks again for
reaching out Yonghong.
