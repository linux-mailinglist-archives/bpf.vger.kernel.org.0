Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD865112D
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLSRXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 12:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSRXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 12:23:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1525C1B
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 09:23:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJH3xOp024515;
        Mon, 19 Dec 2022 17:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lA3Kr5kSI0Abd5guCMpaAkg+T/mBc0yu0qegDvKaZk8=;
 b=uhJTgqGZgUp9zD+LEgWwF8SIYPpy4m7pzFbl0HqMvq7hGjZ1JjytCKtdcCpTHLrz+3c4
 gJChjrp+4R8jmrGNEdPphDe7djwHQkgHJe47c4cNoqB9vLKljNg6s/Lmkkd+nhVxnmk1
 Z500FyPiw7xFuCF1UKp+e+nN8GdIr45OXTadmqg9KYrxULZCfQO8xkf1qXy2MN9y8uHD
 uk7zBVNuOZOdYtUUTvr98wU8q3F/ayCxly3wJLBwTRVLUxyxINNZAN3S3/YgPguJsKSi
 /JdWWy09cXdqP6s1bB10gTutuoMgRl8hfM+V3V64Xt08I7m4Zduec61eand3qoimGDDG Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tsufd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 17:23:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJG16FZ010924;
        Mon, 19 Dec 2022 17:23:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47a3pns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 17:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq0NrczDdXUxotCPqzgxc4KVhBk6n9B8wBBbbRnFk0AvO8si2xt1P7z9iz6O0o26tS9lw/p5nYmeNFtsb6jFqrQKH5AfLJQtmGx6nyfVHAIbGgXj+xCwuFRmVyZiiIooLCpQSqeDlF2lgVfxuvRVITO9ICH4yNgxohVJrZIiBza87RE05VZqDk5+5HJ6M7mlMx98CATDgcc4Ip4qQ6zzyre0OEveWT3PHsOqgCXqpUih0bAXuIjmn74R3PPbg5NeqhrD9hqiUs1vRRgWMU0Ja3gdvBBx7FWqr3kfw/Jc2TGM/E0L0/moAx4z3ExTaVHrgEvLOCBn8u9b0nsGe91RTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA3Kr5kSI0Abd5guCMpaAkg+T/mBc0yu0qegDvKaZk8=;
 b=ESLNIMXj7jy30jqR+W/NZ0ZZtMSiM6v6tYZ3PaZvGl9UHI3B2BTxXlFuwAqyEiJu3oFq2zns7nkYnOjomi6n1kuPcr8qoLgfXFMBC1p6YuqzptAhW/fotSAf109i3xPphlUbV40c78DQS/CUtTDynClS3R/ioYHuTNSffo1oIqJ05+bUmyPD+cf+4wrpgRj9fmHGfs2JM8tTxsGmg2/zAO5kZF6wFdynSR7+WfXY4qJsDXjBZmwqngdaO5rv5tMOCO30Uw9q006MARXFXgtRfbvMp4XRtg1vkuHndY6pf+wkIbi+rWOla7o5OiKidyCSMTfXMBO/WF0qDHlyzovCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA3Kr5kSI0Abd5guCMpaAkg+T/mBc0yu0qegDvKaZk8=;
 b=ZNLY1QWKm1IFQ1j7Oxwc7ZPA/CHt3HCTBU8IqHDLOoXO5kxuMYSlurOBnosvpJ9EI2EgHwJZdFVbdEjYQt1QREYDjFT7Eob32p4khxNHs9ufe0qbzxMoiuZVoD9EsotaIV0tr9D9p4juLhpqiigSZgTWZUz7jDwyvlrsd0o0HEg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH0PR10MB4501.namprd10.prod.outlook.com (2603:10b6:510:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 17:23:30 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 17:23:30 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, david.faust@oracle.com,
        elena.zannoni@oracle.com, David Malcolm <dmalcolm@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: Follow up from the btf_type_tag discussion in the BPF office hours
References: <87o7s4ece1.fsf@oracle.com>
        <757e5dde-75ed-80e2-9a34-ff7c2259de78@meta.com>
Date:   Mon, 19 Dec 2022 18:27:32 +0100
In-Reply-To: <757e5dde-75ed-80e2-9a34-ff7c2259de78@meta.com> (Yonghong Song's
        message of "Fri, 16 Dec 2022 17:38:50 -0800")
Message-ID: <87h6xrfgmz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0561.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::10) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH0PR10MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f836d5-b42c-45be-91fd-08dae1e5bf23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHYsDJuV+zFbZJqLlRsel5tloFkGVmski79hFrkPIBgZolDSpLRBPsUHNCzBwRO0OWABvfucjuVbaBSClP4nm2R2shuirbmna56Oy0VROKK5AfTOXvQcmnfUJGGAH3PwxLagApbh1cpUeAiUVsrvhpXjCiLYCIbjvvZFcpYrsveYlUZgWV4fYo7JXofivWsxyZZue5n7ualh67nJAf/mYO4+3rg3wtnkofAZRb9BGmvQZ8CR+OUOsIwdHHbJ8AT195CPYNjsAk/OAdnWe7/v9a4oWUBaT9+/dNNMBORWti3CQXFRowfP2mhvTFE6r/CzMpW2ke1uYV8Fvf1MBt1slD1r4NgeNZ9VqUD840B1lONck8k0Hi0C97UMxmkV+ekKidVt7jNRUya6vTiv6dDOjhi45/S5Sh97+1k6CK3KetBTNRo8gYLRBKbCCdYohO0nR9razcDdNqxZe4uyiXufsR95EIE3qMhj68LL1muUHs+3gFOc8q8UAyvLxJ7A/hzveoItrzSNEziJc7G7PJuhmccwCckYLyqNG1oxpsz+YJQq7bZmJOoGGSnAhv3lF9sL5Zy7lEuTF6Ru3qjH3kvGmkff5L/r3X1L64zFd93yTUarzo5rEi3yVur+GASp0ZqaREfsRpj/BuXmmp9MgiE31A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(2616005)(83380400001)(38100700002)(86362001)(66899015)(66556008)(66476007)(66946007)(4326008)(5660300002)(41300700001)(6506007)(8936002)(26005)(53546011)(6512007)(8676002)(2906002)(316002)(36756003)(54906003)(6916009)(186003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqigAcLyuBjZ5tV171xEz409hLnbZ24eqQobEkCCjK0pqcwAJY7aO/7Oz6Ms?=
 =?us-ascii?Q?YhzR0k9oLB1AA7iaLm3e9kLfijMDnnrk0MOvdPEdTz89ZwJjwHXyPL/V9rU1?=
 =?us-ascii?Q?PbqGO01ecDR89EbOgtWGS1hiouFOOT514CmWzOwRPJ3LiKqBZiwLv3/NTOBH?=
 =?us-ascii?Q?ucjl0UvBw/oP+tVHozZOWD006SnKPThuIK/306B1l99hDNPbg9yFQCxQ1VBQ?=
 =?us-ascii?Q?OT9WoNHkKdrxPRhXoEf8v8v60TnaseFBitmkOJnjKuqrSGHQAnFKXHis4jUE?=
 =?us-ascii?Q?CjRVTgdlhJpHX6cG97+pzTlIRmJz1PD+g6SHaGd5vii4xCU3pSNZaJHmWLdl?=
 =?us-ascii?Q?E0rOgoYsL97kpJThnS8xWE7h0llV8oFRWNPCzuBbStdOXV0yXKgJ0i1YKpH1?=
 =?us-ascii?Q?b80Svn9J7sMn8VWju7llzuAQDB3+jAOzUpoJTYhY3G3HcYrylyZT+2w5eE9/?=
 =?us-ascii?Q?6vRLsCom8XWG7HG9QZhs9vUCVFfNhLfuaZUN1DTlRkvME7zEDZhsIiF5yZ3F?=
 =?us-ascii?Q?25wp6EfR1S1gB9EGdNHs27C1U2ycI49pBGkE8pfAtuPbFLpzo2J676bp1Drr?=
 =?us-ascii?Q?vno1K1GApCo70YdnnyUjaTvg0x+c4fAXzwRgP4/uW2gdK+9DJcmvplwvcI6i?=
 =?us-ascii?Q?IzcVKes7VCsc4Iqej8un3FTGyRD5At283B6nwoZ75UJgTlP9zcfoutdwzHP7?=
 =?us-ascii?Q?lcMqFcDPqAFjlxtStLgVcZqz2rN1Ca4vhscwA6euPafxZQ9a0zkhkig197Bj?=
 =?us-ascii?Q?vPMbeiz11hbHrz3YEDLP33zfYmo5bpidmkppsH8AkdonYJ4Ge9RoEYaR4Xt6?=
 =?us-ascii?Q?6zmopwSscmWUG5NqzMO/X+BLyfVj7cJFNMmQxpFnw+ja1iTbSkEHKjGj86x6?=
 =?us-ascii?Q?RTCShRMLN2G2VvnibKJ/THdcLq90ryWqI4XLq/QP8zsNhjy48pWrsqdkMcEF?=
 =?us-ascii?Q?V8nRXjOgvnSrKrL00f6QtILAYp5a79CZ9n0bFZMHmkuesK1BdJugIAIFfM2P?=
 =?us-ascii?Q?gd+caUh6pPNwg0b+sI5inf/uJbcEDfOKtLNGqvnYFuYoKs+wLPHmO6hFXnUe?=
 =?us-ascii?Q?+odHMted+vUibCBqxoVysLgZG1Ir5icOw1gQBLNCVlxXtzuC/FRKNWjA5Hxh?=
 =?us-ascii?Q?91eVhoTS9aEWJLgyNyJYF9U9E6Ug/8Uv3HjIAUZ+uPheEnnFRUfQ+Hje7vIY?=
 =?us-ascii?Q?205UTt98206GLXc54GL4Qe3ZrSCcAlpesNSna7QjDWjD5J8odQ7IufuxQJDH?=
 =?us-ascii?Q?fXXMwup6Xw9yPGpc193pfsZwjhlh+UAEdkoAPyFjq0zHg1Db6WZk58J/UgYN?=
 =?us-ascii?Q?lTl4nWNLPopCJKBblluFs3G8MSzkClNqdSca3PDv2HcR7hIUgDAeqPD/R94H?=
 =?us-ascii?Q?6X23hDAayt8FBulli74HaFXRg4YEyYPNVM1QY+EbbAAeGS72vXIqHkQsd/Ga?=
 =?us-ascii?Q?LuE2KhWRVnlDujhni6fm6Vfx/K5HQIKY5lX1nQLN0XiOpwwf+5lcb3EhrlLZ?=
 =?us-ascii?Q?5pED2bE5YJgFRIDP9+kNVduRyKPcxUVcghb+wBiYaAAdRGTS5eBaiq39YFy0?=
 =?us-ascii?Q?4ziPNY75ySb1DhfurCIG0xpg0kIMBDH08g5KeemYUAp1SPk4Y7xVXW5iT456?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f836d5-b42c-45be-91fd-08dae1e5bf23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 17:23:30.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ot4srQfpcywoDhLdh0+Jm7QedWkEHY8b/afRu8sPm4DukAJ6Oli8D1YpxzFI/TtLjg3g+B8/90hwSkw7DVUbyDqLT/q5NV9NVExlqgBwG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190154
X-Proofpoint-ORIG-GUID: z3Hoe5GxgXlD4Rq8aQg00hTjL1FOrura
X-Proofpoint-GUID: z3Hoe5GxgXlD4Rq8aQg00hTjL1FOrura
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.

> On 12/15/22 10:43 AM, Jose E. Marchesi wrote:
>> Of the two problems discussed:
>> 1. DW_TAG_LLVM_annotation not being able to denote annotations to
>>     non-pointed based types.  clang currently ignores these instances.
>>     We discussed two possible options to deal with this:
>>     1.1 To continue ignoring these cases in the front-end, keep the dwarf
>>         expressiveness limitation, and document it.
>>     1.2 To change DW_TAG_LLVM_annotation so it behaves like a qualifier
>>         DIE (like const, volatile, etc.) so it can apply to any type.
>
> Thanks for the detailed update. Yes, we do want to __tag behaving like
> a qualifier.
>
> Today clang only support 'base_type <type_tag> *' style of code.
> But we are open to support non-pointer style of tagging like
> 'base_type <type_tag> global_var'. Because of this, the following
> dwarf output should be adopted:
>    C: int __tag1 * __tag2 * p;
>    dwarf: ptr -> __tag2 --> ptr -> __tag1 -> int
> or
>    C: int __tag1 g;
>    dwarf: var_g -> __tag1 --> int
>
> The above format *might* require particular dwarf tools to add support
> for __tag attribute. But I think it is a good thing in the long run
> esp. if we might add support to non-pointer types. In current
> implementation, dwarf tools can simply ignore the children of ptr
> which they may already do it.

I wonder, since these annotations are atomic, is there a reason for not
using an attribute instead of a DIE tag?  Something like DW_AT_annotation.

The attribute could then be used by any DIE (declaration, type, ...) and
existing DWARF consumers that don't support the new attribute would
happily just ignore it.
