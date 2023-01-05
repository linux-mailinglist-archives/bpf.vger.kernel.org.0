Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3F65E9FF
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjAELeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 06:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjAELd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 06:33:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EE4FD67
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 03:33:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304MDwbh008873;
        Thu, 5 Jan 2023 11:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=qSR3sRM4epmmQaqqTr5ltXVl43+GlAs5d4Efz+niHrQ=;
 b=ca5bBkS5rpTPJY+Ej2C8BXbn2AeIdP+zBdX704b4aMCn1TEMWbtFjN+FI7JEXGhbCHWW
 jvLkK9uBq7e2tkNrGFRDOZk3z5nBaps1kr80cHQ/WFq8ApFpeQJP8IjjT5uuWhjRm+Tf
 opomvadkwb3jLuf2qgjssIMXE+X2zGKzoDME1WUIYSd11TIEbALv8Y01fZdwcc3ec2t6
 +5SbN91uvMYnv3hWfAX/SoxN0+Yjnum2rkenwlX48U7yOrq27oqkGYB722J2Di2GCtgK
 gPreMr/7S2lZwJBGDCK9tqXy+6RjbUi0lNj9Tdg1Yffv3p6tZIn9PvNUf8w7532ejZ03 5g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt8mh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 11:33:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305AB7Ql029099;
        Thu, 5 Jan 2023 11:33:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf09bvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 11:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEl/6/hdLHzHJlSV78JJYZT9PzLg7km63m7RTKwJsU7xQrmSU299wuQWftuWWeVxXhlHevz6VSrloNcX+5hBncxnM55D5ezoRS41IAs+lsC4RFmAQvi5vUQ00RixO/Rr6Tay6y9EvbYE5vbu9CRZ3OYAzd+PW/kw0xMENCmr4n3BcFKsKHPoRa5/wHriyVOnBpy571VKZ/MUEyNb55lkRJs/e4hystyEgFvT1ikPphefC2dxDfwZVykZtO7qwwcCPHX04jnhlc/Tq/WvRU7PC6S5ZZz2lYAjcUHBeP3BvCLuNFGvOkwg70O7qNtyODEhHvy7PMcNnGI0ajgfQDfSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSR3sRM4epmmQaqqTr5ltXVl43+GlAs5d4Efz+niHrQ=;
 b=cAtYShTbR7qFUjoIv0C5qqH4eas41raAMppc8BfMVNkb+yhivCzrttyjIBCPi+8ShprNVsftlNwFc0N8e/wxCka+VDMwtlyU0GBbScBNo+hesEuOotiurensLuJ8uMM9+k8N/vz6BELHCGfMpmGezvprWPIhJOQc1T/7yD/NX2KZ3QbG21KXCidQOxtJIrme71AxcLytFm0mkUQWmqptiAT8K7gttciXEz4Cx9SYI+XwrAR8IxiFfpKjYNwAvcQLkcr+Ad15z2JzBOOIiUt1J/bZhzPKkc6Jw0RrRvBVfoa59SkFgENgn0Xa9Dx7ioTuNdXNcUtHg1uoOqK41v0alA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSR3sRM4epmmQaqqTr5ltXVl43+GlAs5d4Efz+niHrQ=;
 b=R+otmIYvZmj9ndnK9biKTimdr8dReThgjYUZTUxozduBeifGGykPXTKj0F4UwUz+3JLwnuV5hp+S4QeTM4FjNaJ3Ts8vze7GsSZfW3HoqQObSFUsQQ2SiMECv3HHpbJctnXQzKYaMqF72iAdWol1iexTNu8v89Bh4ovL94dPFv8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 11:33:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 11:33:48 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Cc:     david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
Subject: BTF tag support in DWARF (notes for today's BPF Office Hours)
Date:   Thu, 05 Jan 2023 12:37:57 +0100
Message-ID: <87r0w9jjoq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf1f48b-23db-4795-dfb8-08daef10b633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2APsMrFwtL6TnZo9Aev/dYCHhuwTQAIeblICm3D26KwNvnJmEROk2oPgBF11f2WDFl3/rDQS2qx4TR4CA/h6pD1BF3pfRK0q/4WWPrsxBe+QAuW86PevL4XQKX8V0v0qfZZRenUdM3QxniYoyBtGDns4XnFR71q3nQUL1eg8jP0VbNi1Ab6aeQjLKK30/N5wXchu4lHjveadxTJsDDpMUjaIZepI9psjD4u0QnQhpHFyrxoUFTEch0RjkTm/gEkObzdMXqj8ky8xc83qN9nJ3xXNends/eOJ1C8LLJQw/VD0Vhp2cOO/Gzs9jR6KEaU3ThnZjwApkwlwBxQ42h7FADm/+5KQkLqHZnLno/XVY62V7kN9nKZ5XSRK43WSWV1l7aP0TjGMijQT8jMHeP47FhMEfDyRsCXuj9lzRmj2dlOfeobvuCDPBtyMWqGBLO97zum58+ZkBveWdaUJXabiaNwEn/Yc6KqqDXw56v4TaBbMGcqTCnzO0piKAyFgtYC62izlPJrF0v5c9Yz6+IxXFK2CH0djl0EQljPlVt7Nz31k9r9Ca5QD3lA0JrW6E5owyoFrKuN02ZB3BWy7VJ6mE3GRtyqsMkYZEV4NrM1OyT5hHumjgiOF28nsYEDjbY1cZpMTZvG2eQRUZSWR2aXAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(66476007)(4326008)(66899015)(66946007)(66556008)(41300700001)(6506007)(8676002)(86362001)(107886003)(186003)(54906003)(2906002)(83380400001)(316002)(6666004)(26005)(6916009)(478600001)(6486002)(6512007)(38100700002)(8936002)(36756003)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDch3FTUa2vixvo1ry2zo/WY+QlRbkh0V88lkdPbQSkcCTD2VF6Pyl2RSt4f?=
 =?us-ascii?Q?Kc4g4z7iZijb12GghAFZra7uyDuITJIDnNEXsLDmpLYm1feKBan8fotQXbMn?=
 =?us-ascii?Q?AHU/sBooWp2xE95qVubhg4yuUoCn8y1njv/j4KhEMeStPHJCdplkMQLz/dWR?=
 =?us-ascii?Q?BBoy+EZht/T3E9EHWqtzvOw0MuIHrSwdr7nldd50darucSOVJ465DLKmSqUG?=
 =?us-ascii?Q?SV/zkMIrF84bHQB3nMFqzgKRUcQ26KxE/DJObaC+hXSysSbf02T7mB0xtwUY?=
 =?us-ascii?Q?D4ew9jtx17+yrfPw2gtjTjbwRNVGALKjmp3ARzHkZ9VSGnFIyDxIrYN4tpMU?=
 =?us-ascii?Q?/ETCmvWYg0D6o8kWv+5QsB4dY8Fw2Rm1y7x4IprZ+1RcrhskAa+V8a9i+18U?=
 =?us-ascii?Q?C+ZoAB44LKraYVt46t/eepoGvBigklsWg5HuPIvKx4QMImBLNf1YzR754ht7?=
 =?us-ascii?Q?y/cPfduhm5JMYf1BjsheSQETc3VxA5SI0SNDuAKfb4lRKpK4ULKwt1/dqVGO?=
 =?us-ascii?Q?qE+FUjZ8s7l8xYOrYtQymaZZbx4utXUz3gtPFbDcRF3NKl1Sf1gaBLThEEXd?=
 =?us-ascii?Q?INZTnaRRr0c7VMjX2tP4ghmLZTZtiLLRChLHzPJZu2ZZ7pOQPhpTmjbGz2nC?=
 =?us-ascii?Q?egb5Dgaehn9JiKbAi3I5fZS9yVNNXeCW6qaPS3rifmCxJ3szy/089u+C5S8n?=
 =?us-ascii?Q?RnIYSj8GTGo+5z6w/ltUmfZ3AeoETU8jwr2GMx0ctB02hbidGu3g9lLHORbk?=
 =?us-ascii?Q?zRzJKAqkVrY1F6tBrZhnMGxdsO1c9g3wU+Lnt4dcg/y0uK5EHZvQT+p+cHs/?=
 =?us-ascii?Q?h85XAbeL0MCvfwM/Prx8mN2cYwf0gHtm4eww86bhR3KE7kEED/y5Tk4tv6Zj?=
 =?us-ascii?Q?tFek/vRPiXgE7500krS+isG6pZG9vNlsMLK46ydojxByDewVKXx3C3WK/Lc8?=
 =?us-ascii?Q?XFoEsGrDG+nNfKT+rRHNWORJG3mBPss74nKh8IFKq5byR4+dKsVW8kggjs3w?=
 =?us-ascii?Q?f5LfzmMD6VzZCisQtgmh3N+gC65ex2tWZLs7J83wajsN6mG7uT+0RJnPFRFL?=
 =?us-ascii?Q?huW9e/INV5vQCFeuAEhP44tK3/E8otKTbZNsspjlKW48UG28w61cvVvbiTy+?=
 =?us-ascii?Q?UaX7fF2u0K9k5m+WOwzimvTdd8vGqALnpfU2BBMSwxOtstPh9pDjmc5uoDIu?=
 =?us-ascii?Q?sbZ8yB7EG3K0iUX44HIIIHhwsZKBKEubAFgaLV1ILF13rATEImFhjTEGBFIY?=
 =?us-ascii?Q?DzfR+/Ibto6aC1htabkQcW0CQO1LeIGckQeeDDCn6HL/E0ohlQr1lmajHFht?=
 =?us-ascii?Q?vbqcAG2PHNox6ejj4SnhwXBxWiN7JVZo6xdVu3gQMVj4+qFmzQbgS/B1M9Sw?=
 =?us-ascii?Q?CtE95ckBw2icrmDcIRf230m/+zDojRA9vDROLA8hF9g/whr3WjHWCMW/WtDG?=
 =?us-ascii?Q?Wo73Zl5vVwuKfjxZ5uuFtqeREUiFofpajoQpYgQTncD9DN53xdEtbK3FMe41?=
 =?us-ascii?Q?hxmsHxd+zo9pu2uf5npZzabCWQlHZwr5vmJhGi+WgjcG68hjDUmgrH2n2r7B?=
 =?us-ascii?Q?CkmbDY1hzlJ6ozsh0eakbO0BE9U7jOTh+Qs+NkmhpuSzIqQ8W+jaTmftv5kt?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N6bUacKA1o/dMsVAqbgn/MHXcHfbfCq3i5B58zrY1UaEobXbEATTUK52gm4DWYV3A6sxzdx2Zn8A9uxVKdeaUDwhzMlAhKo8c4xZ41gqPeNTif1NNme1nai3zbOBY0LCiO8q+KryytwH2eImEj6+AVLZY//K1HdAJcHixF9mzgdN8nSI/5j5OohcJdH3yBgPRv8O/oFyDkiRc0WbDPYxe7bEmZvrDx7Vl1mH6PtkhzUukFlrsQoJ2owMKQUaJu+HvPHl77oDZ1nphxq7ezybJuBrRm/d7wcvOXepIj25PQf/yEdMg/8F9w4UGsWrL8X1G8HaiZ4Q2IMBzAqrYg+iR9HFjuvE0jcKBb58qrBJ/+LgTKaVgemH73x8WxVFkvsPZOAR4zTIfuZ5pn2izaYNicOHWsF+M1R4efUzNsZDmvpz3OlcshFVFHMIBMv1TPzThVeTbd3wm8BsGLJHDUXjpFNiJAcihfMmgs3jsYWoRgMzVTb3JSDsxA6DKii2sssknasptrV88MpVhuzQUB65icrqsjq1fFVV8B1QCFTGmGwYx09yefxwIqiLaMSbtr3lP0Lpo3BH9wvuAWSCrS/uQq0W6nZLiPT3O1RMxMrWi8CIvlkBxkZHl25zQLETen3j56JBEBargXL0uI//Vn2XyaNtEO1RKPyc6qS12C0f3jm9SpfgD9KDDxvcr8aacFqUln4i71NcOzKKM2ngws96BAM28/e0dq+rVdAMKJ5SMp5rA29NQh7ZQ2YUtxbzlRUmqRgJbdIKKn2L/uL2Yc6Ia680Ox0bTp4c/JsGhdQNsXtQPX/kNP9CqUEertw95ZOy3N+jc1eVcIppZInQIfrVgy2Wpy3aDogiHiXeW55kJQy8kRO+LpcahwcnqlK2+qQo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1f48b-23db-4795-dfb8-08daef10b633
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 11:33:48.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF/Cqy2sQmjyTXHO/FIYCcO0uw5Gq4EAJHGr60u5fNIT5Hk/mzDZDX6L+fvR7gvT+1jFDV54lcKwD0ZcYAwWS4KzYbOJsTDs0ljOxx+iKBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050092
X-Proofpoint-ORIG-GUID: UNEveLFLx_CcZgCEiRQZfSFUS-ZuECC_
X-Proofpoint-GUID: UNEveLFLx_CcZgCEiRQZfSFUS-ZuECC_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hello all.

Find below the notes we intend to use in today's BPF office hour to
discuss possible solutions for the current limitations in the DWARF
representation of the btf_type_tag C attributes, and hopefully decide on
one so we can move forward with this.

The list of suggested solutions below is of course not closed: these are
just the ones we could think about.  Better alternatives and suggestions
are very welcome!

BTF tag support in DWARF

* Current situation: annotations as children DIEs for pointees

  DWARF information is structured as a tree of DIE nodes.  Nodes can
  have attributes associated to them, as well as zero or more DIE
  children.
   
  clang extends DWARF with a new tag (DIE type) =DW_TAG_LLVM_annotation=.
  Nodes of this type are used to associate a tag name with a tag value that
  is also a string.

  Example:

  :  DW_TAG_LLVM_annotation
  :     DW_AT_name        "btf_type_tag"
  :     DW_AT_const_value "user"

  At the moment, clang generates =DW_TAG_LLVM_annotation= nodes as children
  of =DW_TAG_pointer_type= nodes.  The intended semantic is that the
  annotation applies to the pointed-to type.

  For example (indentation reflects the parent-children tree structure):

  : DW_TAG_pointer_type
  :   DW_AT_type "int"
  :   DW_TAG_LLVM_annotation
  :     DW_AT_name        "btf_type_tag"
  :     DW_AT_const_value "tag1"

  The example above associates a "btf_type_tag->tag1" named annotation to the
  type pointed by its containing pointer_type, which is "int".

  This approach has the advantage that, since the new
  =DW_TAG_LLVM_annotation= nodes are effectively used as attributes, they are
  safely ignored by DWARF consumers that do not understand this DIE type.

  But this approach also has a big caveat: types that are not pointed-to by
  pointer types are not expressible in this design.  This obviously impacts
  simple types such as =int= but also pointer types that are not pointees
  themselves.

  For example, it is not possible to associate the tag =__tag2= to the type
  =int **= in this example (Note this is sparse/clang ordering.):

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

* A note about `void'

  The DWARF specification recommends to denote the =void= C type by
  generating a DIE with =DW_TAG_unspecified_type= and name "void".

  However, both GCC and LLVM do _not_ follow this recommendation and instead
  they denote the =void= type as the absence of a =DW_AT_type= attribute in
  whatever containing node.

  Example, for a pointer to =void=:

  : 3      DW_TAG_pointer_type    [no children]

  Note also that the kernel sources have sparse annotations like:

  : void __user * data;

  Which, using sparse ordering, means that the type which is annotated is
  =void=.  Therefore it is very important to be able to tag the =void= basic
  type in this design.

  GDB and other DWARF consumers understand the spec-recommended way to denote
  =void=.

* Solution 1: annotations as qualifiers

  A possible solution for this is to handle =DW_TAG_LLVM_annotation= the same
  way than C type qualifiers are handled in DWARF: including them in the type
  chain linked by =DW_AT_type= attributes.

  For example:

  : DW_TAG_pointer_type
  :   DW_AT_type ("btf_type_tag")
  :
  : DW_TAG_LLVM_annotation
  :   DW_AT_name        "btf_type_tag"
  :   DW_AT_const_value "tag1"
  :   DW_AT_type        ("int")
  :
  : DW_TAG_base_type
  :   DW_AT_name ("int")

  Note how now the =LLVM_annotation= has the annotated type linked by
  =DW_AT_type=, and acts itself as a type linked from =DW_TAG_pointer_type=.

  Advantages of this approach:

  - It makes sense for annotations to be implemented as qualifiers, because
    they actually qualify a target type.

  - This approach is totally flexible and makes it possible to annotate any
    type, qualified or not, pointed-to or not.

  - The resulting DWARF looks like the BTF.

  - It can handle annotated `void', as currently generated by GCC and
    clang/LLVM:

    :   DW_TAG_LLVM_annotation
    :     DW_AT_name        "btf_type_tag"
    :     DW_AT_const_value "tag1"
    :     DW_AT_type NULL

  Disadvantages of this approach:

  - Implementing this is more elaborated, and it requires DWARF consumers to
    understand this new DIE type, in order to follow the type chains in the
    tree: =DW_TAG_LLVM_annotation= should now be expected in any =DW_AT_type=
    reference.

  - This breaks DWARF, making it very difficult to be implemented as a
    compiler extension, and will likely require make it part of DWARF.

  - This is not backwards compatible to what clang currently generates.

* Solution 2: annotations as children DIEs

  This approach involves keeping the =DW_TAG_LLVM_annotation= DIE, with the
  same internal structure it has now, but associating it to the type DIE that
  is its parent.  (Note this is not the same than being linked by a
  =DW_AT_type= attribute like in Solution 1.)

  This means that this DWARF tree:

  : DW_TAG_pointer_type
  :   DW_AT_type "int"
  :   DW_TAG_LLVM_annotation
  :     DW_AT_name        "btf_type_tag"
  :     DW_AT_const_value "tag1"

  Denotes an annotation that applies to the type =int*=, not the pointee type
  =int=.

  Advantages of this approach:

  - This approach makes it possible to annotate any type, qualified or not,
    pointed-to or not.

  - This can easily be implemented as a compiler extension, because existing
    DWARF consumers will happily ignore the new attributes in case they don't
    support them;  the type chains in the tree remain the same.

  - Easy to implement in GCC.

  Disadvantages of this approach:

  - This may result in an increased number of type nodes in the tree.  For
    example, we may have a tagged =int*= and a non-tagged =int*=, which now
    will have to be implemented using two different DIEs.
   
  - This is not backwards-compatible to what clang currently generates, in
    the case of pointer types.

  - It cannot handle annotated `void' as currently generated by GCC and
    clang/LLVM, so for tagged =void= we would need to generate unspecified
    types with name "void":

    : DW_TAG_unspecified_type
    :   DW_AT_name "void"
    :   DW_TAG_LLVM_annotation
    :     DW_AT_name        "btf_type_tag"
    :     DW_AT_const_value "tag1"

    But this should be supported by DWARF consumers, as per the DWARF spec,
    and it is certainly recognized by GDB.

* Solution 3a: annotations as set of attributes

  Another possible solution is to extend DWARF with a pair of two new
  attributes =DW_AT_annotation_tag= and =DW_AT_annotation_value=.

  Annotated types will have these attributes defined.  Example:

  : DW_TAG_pointer_type
  :   DW_AT_type "int"
  :   DW_AT_annotation_tag   "btf_type_tag"
  :   DW_AT_annotation_value "tag1"

  Note that in this example the tag applies to the pointer type, not the
  pointee, i.e. to =int*=.

  Advantages of this approach:

  - This can easily be implemented as a compiler extension, because existing
    DWARF consumers will happily ignore the new attributes in case they don't
    support them;  the type chains in the tree remain the same.

  - This is backwards compatible to what clang currently generates.

  - Easy to implement in GCC.
   
  Disadvantages of this approach:

  - This may result in an increased number of type nodes in the tree.  For
    example, we may have a tagged =int*= and a non-tagged =int*=, which now
    will have to be implemented using two different DIEs.

  - It cannot handle annotated `void' as currently generated by GCC and
    clang/LLVM, so for tagged =void= we would need to generate unspecified
    types with name "void":

    : DW_TAG_unspecified_type
    :   DW_AT_name "void"
    :   DW_AT_annotation_tag   "btf_type_tag"
    :   DW_AT_annotation_value "tag1"

    But this should be supported by DWARF consumers, as per the DWARF spec,
    and it is certainly recognized by GDB.
   
* Solution 3b: annotations as single "structured" attributes

  This is like 3a, but using a single attribute =DW_AT_annotation= instead of
  two, and encoding the tag name and the tag value in the string value using
  some convention.

  For example:

  : DW_TAG_pointer_type
  :   DW_AT_type "int"
  :   DW_AT_annotation "btf_type_tag tag1"

  Meaning the tag name is "btf_type_tag" and the tag value is "tag1", using
  the convention that a white character separates them.

  Advantages over 3a:

  - Using a single attribute is more robust, since it eliminates the possible
    situation of a node having =DW_AT_annotation_tag= and not
    =DW_AT_annotation_value=.

  - It is easier to extend it, since the string stored in the
    =DW_AT_annotation= attribute may be made as complex as desired.  Better
    than adding more =DW_AT_annotation_FOO= attributes.

  - This is backwards compatible to what clang currently generates.

  - Easy to implement in GCC.
   
  Disadvantages over 3a:

  - This requires defining conventions specifying the structure of the string
    stored in the attribute.

  - This has the danger of overzealous design: "let's store a JSON tree in
    =DW_AT_annotation= for future extensions instead of continue bothering
    with DWARF".

  - It cannot handle annotated `void' as currently generated by GCC and
    clang/LLVM, so for tagged =void= we would need to generate unspecified
    types with name "void":

    : DW_TAG_unspecified_type
    :   DW_AT_name "void"
    :   DW_AT_annotation  "btf_type_tag tag1"

    But this should be supported by DWARF consumers, as per the DWARF spec,
    and it is certainly recognized by GDB.
