Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270364E3A3
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 23:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLOWLI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 17:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLOWKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 17:10:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA224BD8
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 14:10:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFL4Wl5017507;
        Thu, 15 Dec 2022 22:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=vMCYcNtUe5CoExL51ei6W200qQWqMZZ5C07c85fp3po=;
 b=gIoGc/MXFW8DsOLRY9jgGjImT2BrX3ArS8TROIhFc9Xk26uf7V9ZeYh8NrTUJ+vhzah8
 V21VFgJ6TGsFdwcS+Ut2wG73qun+KsVwjEw9M7m1n/dBDc8QYpGNn2BRrfqm0fHAy51L
 GR3FX9YhpE0z/uiPZiQk1WrHnaUEnSqms7X8E2Idjy739y6IoBzWZvusI8T6oj+7wxll
 trmk28Nd7Gng/jSShxAUznxiAc23/C7T2XPoUwNMXD9oHbvO8eJ8lOwBA9eCXQMgYq29
 AYplN7dDbOHKc6/DqcAhYs4gbhqkplrZywbk8vEeIEOTitdfRvgZw1zlWw7Ck4Ylmxp4 kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewxavu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 22:10:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFKnXqs011253;
        Thu, 15 Dec 2022 22:10:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyewft2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 22:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am908mUAVYDtpIpqUXJECZ+OiuFLtUa072UE5+SaVAlLNQ17rzgY5pRX5aB/gEWMhZXcCzzTVu99XiWOQZ6adrJGxN/ts0vDz2nleh3E4UfT851MMr5dgokhj0NmeRSPphRr/dLYUdvv1E5OKUT6X+/la9HndOJypeUl4ak/y7Bs3yul/wrFlqQvCZCbzV4BiGzHlqcUuvuQeQ19bZFBjwbLTUuwhhBj7EMX4wKbwDfzSWOvQMP9PwjYAbMy/y4ad75gNkXj4SeCEyWim4tWXFF12Bw3IWluqJ2WSuhb+Lyd/uRL2HiMR0zEsZdgfmYpgkWangmuq6Av5Tsp7ERFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMCYcNtUe5CoExL51ei6W200qQWqMZZ5C07c85fp3po=;
 b=n3/IAU7+ZDfEfDGH0BSlPXOq5uf3fij2hWWkjxiKSxwEXAaykQyPaV/aemAoV7uy0/32e4+TF6JwI1AGTgHAaPjaAXiEp2dCMJubXjy2Z+q1LY+Tfc9FyBh1f+JZvCLhDEOrpZsZbS5o360lFQNJPXY0/wkqvA/O6cH2207/tlsE9SUZNpkEb8HK02h8W6OCxt/pc47ZX6R2mQI7QgAqnM1fPlvjpEMGOV+BDs58tmPmdFWE0eAP8O1Uagxx3W5UASdH0jdXmFrmLO8mMjUOzmo/+vY58IR60gH4oBVzNUPZW2CanA+VgQY8ETubmwzF/mUirvA7o28uLxAEnrCJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMCYcNtUe5CoExL51ei6W200qQWqMZZ5C07c85fp3po=;
 b=oTOU616IvGeRFPRIkz5uhOk3VS88EIT0H12tz932wD4tL9X27ZZTbZcTaGYCYSTwsYVuC9MKnRNA53ZyKQeXekepZXTv2eS7Hr9WJwUBeAUlkR7gs/EtiwPrYEzdo1AtBxro8gvMPHG6d64hKK/fs1NS2TuKlfC2W4N5IuxH0qs=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 22:10:39 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 22:10:39 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Cc:     david.faust@oracle.com, elena.zannoni@oracle.com,
        David Malcolm <dmalcolm@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: Follow up from the btf_type_tag discussion in the BPF office hours
In-Reply-To: <87o7s4ece1.fsf@oracle.com> (Jose E. Marchesi's message of "Thu,
        15 Dec 2022 19:43:18 +0100")
References: <87o7s4ece1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Date:   Thu, 15 Dec 2022 23:14:37 +0100
Message-ID: <87359ge2lu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::21) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc53716-297b-48f8-406b-08dadee9330e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+VKY4g2hhBToH/MYvUp47FOAK+ryHkmgCwhHz9qvLSw/GV2wgKPZdEH1Vf3JDk0aMN6f9x9uJWH/+CjY6+XjcqgVG99XJZTj9ZcRO0dPqYgXO7rue+AVfF99y/6SCQHxmxkhsyT8k/DaczbCzOwVPVFArDPL9yHk4zDNh8WH/t8Ks68rHA9/ePHN/1wdiO2udf4DrAuR63DrG43Xm1FxFh32Iwls781F6DN4LBgYvjG6E5af0pMPjs7X7LrZeL6kRdPKOeNONaNSsTseIksmZkgVL/Gp/WPYtxkqGhiWcIp//rR6t9QpT95RqBXRaEmECPhoYdTl5mFlWGz4BBy9evhPAaoprWkBIeJyioeUiLbHlPUuOmhuaypyxCrSy29cLRSJos/kKyAmmzr98EnqOY1n7yqp0J7MrSmOIIMm8a7/NSqjzh0gugfSixGJPeqYZN3XOL1pxTLDRgLhqpUZx6RF6XgN/8+Fju5q9tWwPuMXsF72+OV5BgFuyjRwk6ip5DR3oFd/JNf8DbUw3shQ1297PEwaygsaYRyjoofHtOTcEQ7eWp4Gi9YRo4wjJLJM3wildo50dOv5hitWDsolLtKRMWL3VFhOaKTKhSNeEPQz/9SPa0K0x+HS/QWAgHyIKK/LTDglaTmP2vW6fQ8Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36756003)(86362001)(66556008)(66946007)(4326008)(8676002)(66476007)(6916009)(316002)(54906003)(2616005)(38100700002)(2906002)(83380400001)(6486002)(6512007)(26005)(186003)(478600001)(6506007)(41300700001)(66899015)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R37PoIcROiSiyrrqtHTq6CtKCw7wkNEMlwIM4yorwygibfNcHjCgC/Qd2JOw?=
 =?us-ascii?Q?ZNstY4v4ASSxCPlW6YTShVIHP4Tu7urwzd9n+jnPdDKvScHgJTb4+VjSPQl4?=
 =?us-ascii?Q?Nk9L50VMF0QrivcaDOaMpLRG7HmJapQ+McV4bVVl3pzX5xGL8sdvBzJfj/cU?=
 =?us-ascii?Q?Cbescr5v4HptV5PU5ZYXZOTf/zq0Qb689Erlq10LSCkxlE9/h5vu5cqAT+MV?=
 =?us-ascii?Q?ZeAaHOGCjEfY0AmqSVCDk+wRlfXuE8hMoI2JQDp7rtiwkn41nBtbI+ZxSaAT?=
 =?us-ascii?Q?Z0tuV16PxXIXS1NX1ZVgPfQ6Kc6yqTJECW2zhO9D1PEuES4CbUWq1Ry2P617?=
 =?us-ascii?Q?u3hDAKASF/wjA48ET5ixng0TPlZ+RylgMHfRvNWsz30llx5j5wPSKl3PKcy7?=
 =?us-ascii?Q?p8/9O8AbA4cmCLcuY/ZkFWWckFb8nylLM4gZBpwoe5kv8VuzxXSwjVN9zWzG?=
 =?us-ascii?Q?sxvkBUh8AbWAHPsMa8euvambX6NBx08nqG9jK/eDbjcwUmDy4WYGL11FShWO?=
 =?us-ascii?Q?pZabr+4DARLU6QPr3G+7WafexvugGIBYO/37X+ZAWu7pd4JQXRVKspFDrMLx?=
 =?us-ascii?Q?yewsa+Ou5BFWTkYja7mcOwQ5LhirwUD4JeCrY4hKQfrgwTZ4efE2nwlPAoq0?=
 =?us-ascii?Q?/zp4t5m0udjGHFjWlqVU4PmJBIFlviq0uPfQxIsU3JaznGrw4oGqi3Mj0ILz?=
 =?us-ascii?Q?msvRH4qLua6Op7X9LUcCkRQpEEi/QuRSCx6R5S5jffPcypdoUzIa4DgUzE0P?=
 =?us-ascii?Q?sGkLUFmTjB0rlkN2pyprDTFE+f1PNkAjpwU0txVQ2v9V+QfCnRhtRd3W3nrS?=
 =?us-ascii?Q?e2pq16pRAqDRjyhWauD4usaIw/C7CrY8KKiFRirAOghbHB9PB90sYQ7n1/e+?=
 =?us-ascii?Q?W+JTKVdgoLcr32LhPdkuIjnsDZvS0g3g0LzGpkTDVlvIpnwgRJ3gPwbsEQbM?=
 =?us-ascii?Q?bXubBa/MI1384UvOBSld05xCe1Yyt2bAB9DJsUR/RRUoxWRI8WTqq3a4mhmd?=
 =?us-ascii?Q?h8aAwS4enbR9MEbu4i4TSJTU5BB8wdV6GdgAzNXzd3Vyt44a2M6ywkKrTfrd?=
 =?us-ascii?Q?OHV/oFQrrIUlVp84rbiCCudG4quVTyIGe7bA/nTD+6hPDvgmKIPH1Gznngz4?=
 =?us-ascii?Q?IbzvAv4C3UpTnHNVEAa988G6xGlSy/OMah05D2I47ppXHMnr392QjIB4o5KN?=
 =?us-ascii?Q?kebdUjI7Z3sl4RC8MjsdqZCdwu10xKO2CWy4Qu9+aYplSDn2Ar5HwHTXHmTB?=
 =?us-ascii?Q?pVuXElCDq4+OObZcO82wjtvNKb32RHdTp+6iYoXZSZmhIg4di9/+35cdnjxv?=
 =?us-ascii?Q?cuakf+hyMkK5VQLLzaDwobSjAuXDRMRL3wM+QbhiAFsAgCoSKA95Sr2u5392?=
 =?us-ascii?Q?agamC1GSwzvs0e5Iyct/PjW1KOBgHWRmT6GblHR6LaZKEDM6ABDFY6JKSo4D?=
 =?us-ascii?Q?+cOkZSqfjziFq7CcCKdz/C1+8kWH+2OVnXWsdGbwCfaxwMqrhVFR4wzCxjJj?=
 =?us-ascii?Q?sxKogzTFYEBwJSHbVobVMiVpAixJXt4EsxLhpWnEjxFPk7fFt6kKpoM+p/Uv?=
 =?us-ascii?Q?+DPNY7iGvcwNlmfykDlAeZkx3GkjHlk2S3bCVI3hKjuhzQ/bOJz69zY3Qnzh?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc53716-297b-48f8-406b-08dadee9330e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:10:39.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQuKxMoEQTq/2vFAWiot0t41cefPzSw0H1TYqgieoNAqswDyJC5eRIE7SUjmG7M1deVsk/dS3FOgdxpFStOk1kn9zw/HnYM8OGGE6bDnCC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=693 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150183
X-Proofpoint-GUID: ym_qiyVbntb3Yls0MTwpl0lOOvKTwkd4
X-Proofpoint-ORIG-GUID: ym_qiyVbntb3Yls0MTwpl0lOOvKTwkd4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Of the two problems discussed:
>
> 1. DW_TAG_LLVM_annotation not being able to denote annotations to
>    non-pointed based types.  clang currently ignores these instances.
>
>    We discussed two possible options to deal with this:
>    1.1 To continue ignoring these cases in the front-end, keep the dwarf
>        expressiveness limitation, and document it.
>    1.2 To change DW_TAG_LLVM_annotation so it behaves like a qualifier
>        DIE (like const, volatile, etc.) so it can apply to any type.

Note that the non-pointed based types don't have to be basic types.  The
limitation also impacts non-basic types that are not pointed to,
including pointer types themselves.

Therefore:

>     : int * __tag1 * __tag2 h;
>
>     - sparse
>       +  __tag1 applies to int*, __tag2 applies to int**
>       : got int *[noderef] __tag1 *[addressable] [noderef] [toplevel] __tag2 h
>     - clang
>       + According to DWARF __tag1 applies to int*, no __tag2 (??).
>       + According to BTF  __tag1 applies to int*, no __tag2 (??).
>       : DWARF
>       : 0x00000023:   DW_TAG_variable
>       :                 DW_AT_name	("h")
>       :                 DW_AT_type	(0x0000002e "int **")
>       :
>       : 0x0000002e:   DW_TAG_pointer_type
>       :                 DW_AT_type	(0x00000037 "int *")
>       :
>       : 0x00000033:     DW_TAG_LLVM_annotation
>       :                 DW_AT_name	("btf_type_tag")
>       :                 DW_AT_const_value	("tag1")
>       : BTF
>       : [1] TYPE_TAG 'tag1' type_id=3
>       : [2] PTR '(anon)' type_id=1
>       : [3] PTR '(anon)' type_id=4
>       : [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>       : [5] VAR 'h' type_id=2, linkage=global
>       :
>       : 'h' -> ptr -> 'tag1' -> ptr -> int

In the example above, `tag2' doesn't appear in neither DWARF nor BTF
because the type int** isn't pointed itself, and as Yonghong mentioned
in the call, the implementation of btf_type_tag in clang ignores these
cases.
