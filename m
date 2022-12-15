Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E864E118
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLOSjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 13:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLOSjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 13:39:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C50D92
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 10:39:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEn3Je029712;
        Thu, 15 Dec 2022 18:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=RJgCkbu50k839xBUeZNvGYb857w7O9lRHVVi54iDYnU=;
 b=j0oXD1RrXN66bSUtcgrRaxJBrX8Ru9gn4cRr8ghYKpQpZjPAXf2WlD7zEHBFtYQCfCv/
 QCxgGpgL6MR3NrubFBvpPcTU8QRcTMh1+SWFUAfQ+RcjD1u3e40ETAA2XxJfZMCoXFfw
 ISl90koMRYPFvFn4EycK24izw2em8sHb6aE1Y1l79AOzBHBsO9CrfuXuqeOLlKpdmh18
 7jolDo6pQU/88MVu8Ubd8FY+EV5dxX7s9FAgp3THlpSxbsyZ1YnTvtAZxYMFSRpAmZDu
 oeaDPEmShEMrqgv4H+9XQ5STVcZQ7w58eL9jiC+VmpscrRSUlZeLIFwULMMsWVDw8OEn Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewwvp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 18:39:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFHKpVa010007;
        Thu, 15 Dec 2022 18:39:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyepe0mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 18:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRLkqFUhSp1WzgoEHSz4iVjpJ4NPBPnavQDrcVNYtNKNAsmcZXQJLIcGJgaDMgtEuMJ5oEe17G1o+nW9LwiJC3VvMSve7tZhrYPW8hjlEuGVI3zpEtd6hKxmHGNRywv8C4oTsCZk6iic99B7GVKOQTYFmd0d09RJLgPUhHsSYpwguxrK1Sb5/gTjGL/twSfIDzLiZD1vajghrzjuOnhY0NPVprV4awWoLlT15pnX/4dZriCysldRVGRLp7G2ABJVKq7kZrGZn6hnarrBriZaLWmyxiOMctrQoZUrQ3eK2USQ41LzcHPo6DyCb7xunpzBdfO55K2o7XxzwdvkCTFsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJgCkbu50k839xBUeZNvGYb857w7O9lRHVVi54iDYnU=;
 b=INSTRfWvT4P8va9Mm4b9hvQVLZd/TcK7hCtVK65eHLkFrCYF9I00HTQeOVLmIZYka2X8zbh0MmHD6C757UJ8vLt9d+kfBrLN01G1OqYB55gQHR4QBrzfN5ib1M2H4hBnFxEyXxq3YQPsZv3KzEtqV8S+LIfrHpHGPbQv1nQsg1YWjJT5r4h41ZtxBVEEt4/Z96jeHkh/NSzKvYUBaKt3NipHgszxt0J4l26E7EAeELxHzNkU3sWfOxeyOZa2xqcfOW9LwPDTbEsq6nm1a1Cer97TsXwSnKVpIhMqMnAo0LCr7dTsjux5Yq5biSyPHr6ccIkDhkDMBGraHEX8Z9LbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJgCkbu50k839xBUeZNvGYb857w7O9lRHVVi54iDYnU=;
 b=s9LhKxPOrZ1KuBlNMNHBNhYeMJ2aZX/E3o6ZukTzf7Y1UDA61LCdrT3ancQ48Fjdi/bGppyChptttGgqrHJjaLjJrgzHlBE7vc4Laeq392la8IrcLIcNPD1gebEq7hfzdt+uBMojaH17wMjWUsljfE6cmPiRZ2LWnEUqXYkKFKA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 18:39:20 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 18:39:20 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Cc:     david.faust@oracle.com, elena.zannoni@oracle.com,
        David Malcolm <dmalcolm@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Follow up from the btf_type_tag discussion in the BPF office hours
Date:   Thu, 15 Dec 2022 19:43:18 +0100
Message-ID: <87o7s4ece1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0209.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::16) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b98a3a1-4252-4fc8-9ae8-08dadecbadf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ie4qFQ2FfQmOdcFRAdaVmp0CGSpJPc/LP0jymVG7C4d3YcQq/d4oJMmF3F2s5NZxrn7eWInMcMZbrZXMRmTdiCBWZsE38ekvBRe2FzXCrsBQMqd9xQwDo/2AR9OrzHd23UTP1KF/Ju1jO6+XT33Sp/BFR3BdBvua7xnnAYJTJAtr8PoEGfIMP1QOagNVOF5AdyDe6OjAk3tyA/JQ0hle+xXZNzbXFDof9F5jfszeClKcpmO3XNaCIsEkwRdKvlDUk2S+2bthytsQgg7EC+lILNjv++s/bjagmb+qjVrSd7wede7GdNRJ0+ugFlwPJp8CdzvCJ3l7/Vnr/G7PnKulB+TP7/ysdhT8ZltRCkLS9orzq0jgNJUwIY6mvm8NXt/qsKSiC2LP1R4AV274PqteV1d9GRXHrfwfGmgXt5a/YDkF4Txh9vBY5Qnx6RrP2+DwpjVHdohrW+EnJdvT9SbCptM5yOXaB+ETEzvf9TIqLiaYICusF6sn/u472xVLwsuUbIRJfVivCkO79w+2HY8o++4Z9/XHKzlZTmNU/cQTyQI0TO/IfK7+8TCs2nsIVVD2+nDIHt21GnWFzl0527rcSWmHtRP7DBDq/6Evzm8119lPtc0FjtQxRZBxSrxTbfDkSUho+EWghQYuiMb0ax1jZo7NNMI1Zpmk6SxywrV7pcJWyL5FOaUDOtF3XNmgD6twtCR0PIHQVCfIme7CSQlBsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(83380400001)(86362001)(8936002)(30864003)(5660300002)(38100700002)(66476007)(66946007)(4326008)(2906002)(66556008)(8676002)(41300700001)(26005)(6512007)(6506007)(186003)(2616005)(54906003)(6916009)(316002)(6486002)(966005)(478600001)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxQQg9vNbjC40UoB43njFNmQJR/xsWZEckC+KkM5VHeRGOpu9jVdc6i/XA+E?=
 =?us-ascii?Q?fOaQQoRJ5OAnW0rM9t4YecVOa15QVruHVkWjTWXLnEVJvOrhXQdU9TDVffV4?=
 =?us-ascii?Q?63h4CUw36OT+csASzr4/ZuDV4z0ehOG0nvQwBRXbj6gSERMdUxULTbkUl3oS?=
 =?us-ascii?Q?edmgAwIJYJxU5eeYJW+EIo78UTGW2hqKyHq15Z6P00tbFxctVyp6z7N4NG4N?=
 =?us-ascii?Q?/iBWmgPN2A89TikEhTtXhh3RHLMl2PExwOZDkROAxlfjcsXe3tt/ULT0gBom?=
 =?us-ascii?Q?c5z6ek/PZXfKgPXzacDY0NJMwlS5iDNa+9k5u1N3P9PrUPlUK21JVRSaj4yD?=
 =?us-ascii?Q?dc1Wq2ICgwSjbBR8W9dNrzXf5K6B0v1QvfhzT8B7psTsiOVahS8ujrxenZ1n?=
 =?us-ascii?Q?uXV46jM4sWaNV61VdiGU0oicWfl9potkdAbHfEwGB35GPHuruNkKc10WjruT?=
 =?us-ascii?Q?IklXgXevgAytZtokma+6ojZka6hL8xUprESRRVqefFt/+cPSSTNu5WkgIhE4?=
 =?us-ascii?Q?2xfEwzBfqqF+KavldwYWkfJhkdOEogIdh3ow6lONCZpXFPCyfyLyQQf0WnWn?=
 =?us-ascii?Q?U/ZvNp1PATUFfvGHrhncqmVsweNoLgkVvqmGIuqgbM6NYXFrZ8yCOVle3/UM?=
 =?us-ascii?Q?3qORo1ReLhhXxLHANMvANtvBL3FvyuB3k1/f7vwtmswZHHCwPpkbmXNEmd0M?=
 =?us-ascii?Q?3AK3X1LKDbsLxltnFcajHotAzOyzARTsWjDmOHdJELs/I63EGjh6rJ3NagG4?=
 =?us-ascii?Q?RYuF3DOSp9bTpTy1cLcHRHq6TVG7wTCTbVP0M0zgGu16g3lt+0P2uZFIYFWk?=
 =?us-ascii?Q?pzv4isdpgdlVioZYR1vvHTgnJmF7aN/620O7RLEW9NTQXsZ+q5rkdOEc6ua4?=
 =?us-ascii?Q?cAoH7kOi1GeARXckIxMG0WQ9pNybNcLI0lobudF2ZP8k5BymOerysXnr4rRr?=
 =?us-ascii?Q?7L0qrxIyN9wWAEeWXxJceyAtNm8SDmY+mcKT4c9EppGgtPTLWf1n+jZHTNwQ?=
 =?us-ascii?Q?WAwIuqGlu2zErelswkv/35SSKJXk8gAMPmJNpLuCYfOHIiWBY0bW12ma5dQg?=
 =?us-ascii?Q?/wPstJlBvEZEcM2TGai/Aqsm76NcXoGhm41iIsyuP2kFjyjL/07IYMgT02TQ?=
 =?us-ascii?Q?MMzJqhZOq6hSd+wwRoi7s9EbLHymNM7qSjoEBfA1zYGoeg+ojnOc3h7/d+vM?=
 =?us-ascii?Q?wsrjn5JXn/LiZ0u7iklszfgRQMMkuxnYN7CHoS4kd+fRv5uL+YJYRrMHFyvk?=
 =?us-ascii?Q?0joXbx7liuaSr9r/Zy5JllbEuoKZ0dicOjsVLCL+iWRSv3A6Bu4toviGkzGE?=
 =?us-ascii?Q?rA2RN1YXsI6P9Hnr7n7hEG3fK3JIIQTC2ZSxq956v+hYsWTrXB/J/bg/Uri/?=
 =?us-ascii?Q?sdWaeGZFqShU+liUuj3gHXBGqcgl6JLgA1D1TqTKiffZK0yczKD6qUEPdv71?=
 =?us-ascii?Q?XXWHjLgx9/ObGm7P0oWvlcmZHOFZz+MlIU6p/iGegpb2PxZgaTmdyLVEjV3i?=
 =?us-ascii?Q?fUe/W8qxoppgXNTcXyydYdoq083x2ostnz4bdX5BobBSI+IFWh/vbmPj4Vyv?=
 =?us-ascii?Q?01l2JoC8gder+iwvX5THuNGCR92ElsBgiH3SuqjMu/6ZfU5exqu1rjmLqLWy?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b98a3a1-4252-4fc8-9ae8-08dadecbadf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:39:20.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4X8giivkMtQJo5/tlWukjhRkgoFBc7fGOlMqJYsMD11k2dXNrtMGF8zpRQ5a68CcbrCk4EnCDtSGAJj9KcgohAzfpMMgp2OsTA/slG6ojg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150155
X-Proofpoint-GUID: kVMWbZtMFzXHMOXLYNeH758zFw3Qw7jo
X-Proofpoint-ORIG-GUID: kVMWbZtMFzXHMOXLYNeH758zFw3Qw7jo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Of the two problems discussed:

1. DW_TAG_LLVM_annotation not being able to denote annotations to
   non-pointed based types.  clang currently ignores these instances.

   We discussed two possible options to deal with this:
   1.1 To continue ignoring these cases in the front-end, keep the dwarf
       expressiveness limitation, and document it.
   1.2 To change DW_TAG_LLVM_annotation so it behaves like a qualifier
       DIE (like const, volatile, etc.) so it can apply to any type.

2. The ordering problem: sparse annotations order differently than
   GNU/C99 compiler attributes.  Therefore translating 1-to-1 from
   sparse annotations to compiler attributes results in attributes with
   different syntax than normal compiler attributes.

   This was accepted in clang.
   But found resistance in GCC when we sent the first patch series.

   During the meeting we went thru several possible ways of dealing with
   this problem, but we didn't reach any conclusion on what to do, since
   the time ran out.

We agreed to continue the discussion at the BPF office hours next 5
January 2023.

In the meanwhile, below in this email is a slightly updated version of
the material used to go thru the topics during the discussion.  If there
is any mistake or if you see that our understanding of the
problem/situation is not correct, please point it out.  If you want to
add more information, please do so by replying to this thread.

Finally, it was agreed that we (GCC BPF hackers) would send Yonghong our
github accounts so he can subscribe us to notifications in the llvm
phabricator, so we can be aware of potentially ABI/breaking changes at
the time they are discussed, and not afterwards scanning bpf@vger.  I
alredy sent him the information.

Thank you for your time today.  It is appreciated.

----

* Background
** Attribute/annotation ordering in declarations

   - By "ordering" in this context we understand the correspondence of
     annotations (like compiler attributes) with language entities.

     Given:

     : char * __attribute ((btf_type_tag("foo"))) * buf;

     What is the language entity (type) to which the attribute
     applies?  Is it char?  Is it char*?  Is it char**?

   - This is decided by compilers at parse-time and reflected in the
     structure of the AST.

   - Therefore this is a source-level concept, and it is not amenable
     by generating debug info with a different ordering.

** Compilers implement different orderings for different kinds of attributes

   - The sparse compiler implements a particular ordering for sparse
     annotations, which look like:

     : __attribute__ ((address_space(user)))

     The ordering is not documented, but can be determined by running
     sparse and/or by looking at the sparse parser source code.

     [The fact sparse annotations look like compiler GNU-like
      attributes must not mislead us: they are not the same and they
      don't order the same way.]

   - The GCC and clang compilers implement another particular ordering
     for GNU-like compiler attributes, which have the form:

     : __attribute__ ((noinline))

     The ordering is specified in the "Attribute Syntax" chapter in
     the GCC manual.

   - The GCC and clang compilers implement another particular ordering
     for C2x compiler attributes, which have the form:

     : [[noinline]]

     The ordering is specified in the C2x specification.

   All three entities above, sparse annotations, GNU-like compiler
   attributes and C2x compiler attributes use different orderings,
   i.e. the correspondence of the annotation/attribute with the
   language entity it annotates (type, declaration, ...) varies.

* The problem
** Re-use of sparse annotations as compiler attributes

  - At some point we got the request from the BPF community to support
    a couple of new compiler attributes in GCC:

    : btf_type_tag ("foobar")
    : btf_decl_tag ("foobar")

    These attributes translate into annotations in both BTF and DWARF
    debugging information.

    clang/llvm had already been modified to support these attributes,
    the new BTF kind, and a new DW_TAG_LLVM_annotation DWARF DIE type.

  - David Faust wrote an implementation, and used as a criteria the
    several examples he saw in the kernel sources and what clang
    generates.  He added the same support in BTF and a compatible
    DW_TAG_GNU_annotation for DWARF.

    He obviously implemented the new compiler attributes as what they
    are: GNU-like compiler attributes, and saw that they were being
    ordered differently to what the kernel sources would expect.

  - Then we investigated and learned that the intention at the BPF
    side was to re-use the already existing address_space sparse
    annotations in the kernel sources as btf_*_tag compiler
    attributes.

  - At present, it looks like support for several other sparse-like
    attributes have been added to clang (which ones?) and as a result
    now clang effectively has GNU-like compiler attributes that order
    differently than all other attributes.

  - At LPC 2022 we met David Malcolm, who has been working in
    implementing sparse annotations and warnings natively in GCC.  He
    found similar problems with the ordering of the attributes.

** Scope of the problem

   - This happens when sparse annotations are re-used as compiler
     attributes.

   - sparse annotations are NOT compiler attributes => there is NO bug
     in sparse.

   - These annotations are used very widely in the Linux kernel sources.

   - Compilers involved: sparse, GCC and clang

   - sparse annotations can appear in both BPF C programs and kernel
     source files.

** Ordering discrepancies between sparse annotations and compiler attributes

   Using these definitions:

   : #ifdef __CHECKER__
   : #define __tag1 __attribute__((noderef, address_space(__tag1)))
   : #define __tag2 __attribute__((noderef, address_space(__tag2)))
   : #else
   : #define __tag1 __attribute__((btf_type_tag("tag1")))
   : #define __tag2 __attribute__((btf_type_tag("tag2")))
   : #endif

   __CHECKER__ is defined by sparse, so the former definitions are
   used * while compiling the examples with sparse.

   The latter definitions with btf_type_tag are used when compiling
   with GCC or clang.

   Compilers compared:

   - sparse

     + Ordering information is obtained via sparse debug printed as
       part of a warning.

   - GCC

     + Slightly outdated 'master' branch, with the patches to support
       btf_type_tag and btf_decl_tag applied:
       https://gcc.gnu.org/git/gcc.git:refs/users/dfaust/heads/btf-type-tag-new-rebase

     + Ordering information is obtained via the generated BTF and
       DWARF.  Note that we have verified that the BTF and DWARF
       results are accurately representative of the GCC internal
       compiler structures which produce it, and that therefore they
       reflect how the compiler has parsed the declarations.

   - clang

     + clang version 16.0.0. main branch of December 14 2022.
     + Ordering information is obtained via the generated BTF and
       DWARF.

    Probably the simplest case involving pointers, shows how both
    compilers are mangling the generated BTF in order to reflect the
    sparse expectations (presumably the same hack is in pahole when
    it does the DWARF -> BTF translation):

    : char __tag1 * buf;

    - sparse
      + __tag1 applies to type char.
      : got char [noderef] __tag1 *[addressable] [toplevel] buf
    - clang
      + According to DWARF __tag1 applies to type char
      + According to BTF  __tag1 applies to type char
      : DWARF
      : 0x00000023:   DW_TAG_variable
      :                 DW_AT_name	("buf")
      :                 DW_AT_type	(0x0000002e "char *")
      :
      : 0x0000002e:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000037 "char")
      :
      : 0x00000033:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] TYPE_TAG 'tag1' type_id=3
      : [2] PTR '(anon)' type_id=1
      : [3] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
      : [4] VAR 'buf' type_id=2, linkage=global
      :
      : buf -> ptr -> 'tag1' -> char
    - GCC
      + According to DWARF __tag1 applies to type char
      + According to BTF  __tag1 applies to type char
      : DWARF
      : 0x0000002e:   DW_TAG_variable
      :                 DW_AT_name	("buf")
      :                 DW_AT_type	(0x00000044 "char *")
      :
      : 0x00000044:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000057 "char")
      :
      : 0x0000004d:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      :
      : BTF
      : [1] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
      : [2] PTR '(anon)' type_id=3
      : [3] TYPE_TAG 'tag1' type_id=1
      : [4] VAR 'buf' type_id=2, linkage=global
      :
      : buf -> ptr -> 'tag1' -> char

    The next example is from from bpf-next/arch/x86/kernel/kgdb.c:184
    and shows cases where both the DWARF and the BTF are different:

    : struct perf_event * __percpu *pev;

    - sparse
      + __percpu applies to struct perf_event*
      : got struct perf_event *[noderef] __percpu *[addressable] [toplevel] pev
    - clang
      + According to DWARF __percpu applies to struct perf_event*
      + According to BTF __percpu applies to struct perf_event*
      : DWARF
      : 0x00000023:   DW_TAG_variable
      :                 DW_AT_name	("pev")
      :                 DW_AT_type	(0x0000002e "perf_event **")
      :
      : 0x0000002e:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000037 "perf_event *")
      :
      : 0x00000033:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("percpu")
      :
      : 0x00000037:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x0000003c "perf_event")
      : BTF
      : [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [4] PTR '(anon)' type_id=5
      : [5] STRUCT 'perf_event' size=4 vlen=1
      : 'a' type_id=2 bits_offset=0
      : [8] TYPE_TAG 'percpu' type_id=4
      : [9] PTR '(anon)' type_id=8
      : [13] VAR 'pev' type_id=9, linkage=global
      :
      : pev -> ptr -> 'percpu' -> ptr -> struct perf_event
    - GCC
      + According to DWARF __percpu applies to struct perf_event
      + According to BTF __percpu applies to struct perf_event
      : DWARF
      : 0x00000023:   DW_TAG_variable
      :                 DW_AT_name	("pev")
      :                 DW_AT_type	(0x00000039 "perf_event **")
      :
      : 0x00000039:   DW_TAG_pointer_type (perf_event **)
      :                 DW_AT_type	(0x0000003f "perf_event *")
      :
      : 0x0000003f:   DW_TAG_pointer_type (perf_event *)
      :                 DW_AT_type	(0x0000001e "perf_event")
      :
      : 0x00000045:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("percpu")
      : BTF
      : [1] STRUCT 'perf_event' size=4 vlen=1
      : 'a' type_id=2 bits_offset=0
      : [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [3] PTR '(anon)' type_id=4
      : [4] TYPE_TAG 'percpu' type_id=1
      : [5] PTR '(anon)' type_id=3
      : [14] VAR 'pev' type_id=5, linkage=global
      :
      : pev -> ptr -> ptr -> 'percpu' -> perf_event

    The following case shows two different attributes applied to
    pointers-to-pointers:

    : int __tag1 * __tag2 * g;

    - sparse
      + __tag1 applies to int, __tag2 applies to int*
      : got int [noderef] __tag1 *[noderef] __tag2 *[addressable] [toplevel] g
    - clang
      + According to DWARF __tag1 applies to int, __tag2 applies to int*
      + According to BTF __tag1 applies to int, __tag2 applies to int*
      : DWARF
      : 0x00000023:   DW_TAG_variable
      :                 DW_AT_name	("g")
      :                 DW_AT_type	(0x0000002e "int **")
      :
      : 0x0000002e:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000037 "int *")
      :
      : 0x00000033:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag2")
      :
      : 0x00000037:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000040 "int")
      :
      : 0x0000003c:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] TYPE_TAG 'tag2' type_id=4
      : [2] PTR '(anon)' type_id=1
      : [3] TYPE_TAG 'tag1' type_id=5
      : [4] PTR '(anon)' type_id=3
      : [5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [6] VAR 'g' type_id=2, linkage=global
      :
      : 'g' -> ptr -> 'tag2' -> ptr -> 'tag1' -> int
    - GCC
      + According to DWARF __tag1 applies to int*, __tag2 applies to int
      + According to BTF __tag1 applies to int*, __tag2 applies to int
      : DWARF
      : 0x0000002e:   DW_TAG_variable
      :                 DW_AT_name	("g")
      :                 DW_AT_type	(0x00000042 "int **")
      :
      : 0x00000042:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000055 "int *")
      :
      : 0x0000004b:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      :
      : 0x00000055:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000068 "int")
      :
      : 0x0000005e:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag2")
      : BTF
      : [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [2] PTR '(anon)' type_id=3
      : [3] TYPE_TAG 'tag2' type_id=1
      : [4] PTR '(anon)' type_id=5
      : [5] TYPE_TAG 'tag1' type_id=2
      : [6] VAR 'g' type_id=4, linkage=global
      :
      : 'g' -> ptr -> 'tag1' -> ptr -> 'tag2' -> int

    What follows is a typical kernel example.  We get "right" results
    in GCC just because both tags are the same attributes, but
    effectively we hit the same problem than in the previous example:

    : int __tag1 * __tag1 * val;

    - sparse
      + __tag1 applies to both int and int*
      : got int [noderef] __tag1 *[noderef] __tag1 *[addressable] [toplevel] val
    - clang
      + According to DWARF __tag1 applies to both int and int*
      + According to BTF __tag1 applies to both int and int*
      : DWARF
      : 0x0000001e:   DW_TAG_variable
      :                 DW_AT_name	("val")
      :                 DW_AT_type	(0x00000029 "int **")
      :
      : 0x00000029:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000032 "int *")
      :
      : 0x0000002e:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      :
      : 0x00000032:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x0000003b "int")
      :
      : 0x00000037:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] TYPE_TAG 'tag1' type_id=4
      : [2] PTR '(anon)' type_id=1
      : [3] TYPE_TAG 'tag1' type_id=5
      : [4] PTR '(anon)' type_id=3
      : [5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [6] VAR 'val' type_id=2, linkage=global
      :
      : 'val' -> ptr -> 'tag1' -> ptr -> 'tag1' -> int
    - GCC
      + According to DWARF __tag1 applies to both int and int*
      + According to BTF __tag1 applies to both int and int*
      : DWARF
      : 0x0000001e:   DW_TAG_variable
      :                 DW_AT_name	("val")
      :                 DW_AT_type	(0x00000034 "int **")
      :
      : 0x00000034:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000047 "int *")
      :
      : 0x0000003d:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      :
      : 0x00000047:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x0000005a "int")
      :
      : 0x00000050:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [2] PTR '(anon)' type_id=3
      : [3] TYPE_TAG 'tag1' type_id=1
      : [4] PTR '(anon)' type_id=5
      : [5] TYPE_TAG 'tag1' type_id=2
      : [6] VAR 'val' type_id=4, linkage=global
      :
      : 'val' -> ptr -> 'tag1' -> ptr -> 'tag1' -> int

    This last example is another variation of pointer-to-pointer with
    different tags and different positions:

    : int * __tag1 * __tag2 h;

    - sparse
      +  __tag1 applies to int*, __tag2 applies to int**
      : got int *[noderef] __tag1 *[addressable] [noderef] [toplevel] __tag2 h
    - clang
      + According to DWARF __tag1 applies to int*, no __tag2 (??).
      + According to BTF  __tag1 applies to int*, no __tag2 (??).
      : DWARF
      : 0x00000023:   DW_TAG_variable
      :                 DW_AT_name	("h")
      :                 DW_AT_type	(0x0000002e "int **")
      :
      : 0x0000002e:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000037 "int *")
      :
      : 0x00000033:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] TYPE_TAG 'tag1' type_id=3
      : [2] PTR '(anon)' type_id=1
      : [3] PTR '(anon)' type_id=4
      : [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [5] VAR 'h' type_id=2, linkage=global
      :
      : 'h' -> ptr -> 'tag1' -> ptr -> int
    - GCC
      + According to DWARF __tag1 applies to int*, __tag2 applies to int**
      + According to BTF __tag1 applies to int, __tag2 applies to int*
      : DWARF
      : 0x0000002e:   DW_TAG_variable
      :                 DW_AT_name	("h")
      :                 DW_AT_type	(0x00000042 "int **")
      :
      : 0x00000042:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000055 "int *")
      :
      : 0x0000004b:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag2")
      :
      : 0x00000055:   DW_TAG_pointer_type
      :                 DW_AT_type	(0x00000068 "int")
      :
      : 0x0000005e:     DW_TAG_LLVM_annotation
      :                 DW_AT_name	("btf_type_tag")
      :                 DW_AT_const_value	("tag1")
      : BTF
      : [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
      : [2] PTR '(anon)' type_id=3
      : [3] TYPE_TAG 'tag1' type_id=1
      : [4] PTR '(anon)' type_id=5
      : [5] TYPE_TAG 'tag2' type_id=2
      : [6] VAR 'h' type_id=4, linkage=global
      :
      : 'h' -> ptr -> 'tag2' -> ptr -> 'tag1' -> int

* Solutions
** Reorder sparse annotations in kernel source

   [Julia Jawall kindly adapted coccinelle so it can handle this and
    the following possible solution involving modifying kernel
    sources.]

   This would basically involve writing and applying a coccinelle
   script to reorder something like this:

   : int __tag1 * __tag2 * g;

   into this

   : int __tag2 * __tag1 * g;

   where

   : #define __tag1 __attribute__((address_space(__tag1)))

   This totally breaks sparse so it is hardly a realistic solution.

** Add compiler attributes corresponding to existing sparse annotations to the kernel source

   This would involve writing and applying a coccinelle script to add
   compiler attributes corresponding to the existing sparse
   annotations.

   So from this:

   : int __tag1 * __tag2 * g;

   We would go to:

   : int __tag1 __comp_tag2 * __tag2 __comp_tag1 * g;

   where

   : #if __CHECKER__
   : #  define __tag1 __attribute__((address_space(__tag1)))
   : #else
   : #  define __tag1
   : #endif
   : #define __comp_tag1 __attribute__((btf_type_tag("tag1")))

   This would not break sparse, but would lead to a lot of (non
   trivial) redundancy in the kernel sources: both sparse annotations
   and compiler attributes will denote the same thing.

** Adding native support for sparse annotations to GCC and clang

   This would make both GCC and clang to handle sparse annotations
   using the sparse ordering.  This is what David Malcolm has been
   working on.

   There is some previous work From Tom Tromey to support the
   following sparse annotations: address_space, noderef and force.
   See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59850 (But AFAIK
   Tom's patch also falls in the mistake of ordering the attributes
   using GNU-like attribute ordering, not the sparse ordering?)

   For example, in this C declaration:

   : int * __attribute__((address_space(__tag1))) * p;

   The compilers would recognize that as a sparse annotation (and not
   a GNU-like compiler attribute) and parse it in a way it applies to
   int* instead of int**.

   At least two problems with this approach:

   1. This could be confusing for users, and difficult to get applied
      upstream, because sparse annotations look like GNU-like compiler
      attributes, despite not being the same thing (ordering
      differently.)

   2. sparse lacks support for btf_type_tag and btf_decl_tag, and
      these compiler attributes are more general than the existing
      sparse annotations.

** Adding GNU-like compiler attributes to GCC and clang with sparse ordering

   This is what clang does right now (or tries to do).

   Solves problem 2. above, but not 1.

   Maybe problem 1. could be alleviated by oddly-ordering compiler
   attributes to have a distinguished name, such as using a 'sparse'
   prefix:

   : __attribute__((sparse_btf_type_tag ("tag1")))

** Other solutions?
