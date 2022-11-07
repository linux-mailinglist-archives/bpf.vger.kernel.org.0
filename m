Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D3561FA0D
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKGQiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 11:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGQh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 11:37:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20195F86
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 08:37:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GTKFU009034;
        Mon, 7 Nov 2022 16:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=K5MWXdT7GL00Ranh7ycqu4zRFiz/nBZOIfEmvda+eXY=;
 b=mUJc3Vh+afcNxGMbA/liH77jafI6IsVN/WtVmnBnjwppyFqooS4NmqRE//FA5NAdXDwD
 XUit3HG2L0bJZ+6Fs265+VKch9JTe1jZzrZYT9kkuRGJUduReoS0ywNCToa0ev465FUL
 QT4wCU21hOE2id1FZ9mnvJhIOEDlc5AzKLXveRIpJVzecSUqN09f+jGaYZiLXb3URQ63
 vzIM584MhWSVz+xlSYM8RKvH/MB1iOtJbDUKGGicZUdMzpMW3ZU1q6m17q83fmGy0cGq
 G2Tj3h7Nz8XW7BBkI370P1n4DOkIWat/v0ssqAYOIsjXlg9Z7k37E32wAuJxjDLkqqge EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngremedj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:37:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Ehglv003310;
        Mon, 7 Nov 2022 16:37:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctb780r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbOueZ/Nnow5BAUWK8gFoe07znF14X0kIZpIxuA3zyBZrA9CIsD0maE8fO55RRBIyQhKceLuy6Xvr8QVqzaWC7/zb28j0ULuTAAVRMaMAi7Bxq9QueXoxz2z+q0M59rnx+UZe9N1r0xXsiw921RBgYJVh966Ur3gYsY9YMn43NjOs8SeglHIuuOy5FFOZ7G1Tgcke/leHmyiks3kN/CdPzvNLJW33JBbBl6VIikNrbcvf4HKoqV9ih6DlqEOWOaOb0rLHKcifuSZPAwSl+ZY/UIbg6guigCBZu+TyRNmjX3QwctoDVhP8xpRSifPCgrieL9Gb/CP0tTRFDc2KrN8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5MWXdT7GL00Ranh7ycqu4zRFiz/nBZOIfEmvda+eXY=;
 b=oCs2I8BDMoZWnBpX2djA5SWRWUsCB0yJMgdCoGADaNmaQKLeXBVQpHo7e7pWQlyhAqlY5G2PZ8LXabnQBHiN0rjP5aun1rakn04ShdpBQTAOSYAoMtPp8K20unSCRWqM/V2klRWAgj09ESBDqb62uyCTmmWjn/h5FtB6txbqnFQEdsxHmOKY7n/m9yLClxrPQLOJfXd59ICCRf9Ko/3a78LlYVTMYUevoGKbPZX9wyGZYilv7koTtlUIkCgYXWwxH+rVHdWFXwWGmuTj8RKqQKU0LcF05MvOs7y2qa2IWVaaw5hwdyMNJ971+X7JnkeL1eTrBxq/OD0iDiEdkSbP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5MWXdT7GL00Ranh7ycqu4zRFiz/nBZOIfEmvda+eXY=;
 b=I69UWB4dCbuMrfXyuTkNbId1RUYdhL606VxwPHscGpLAF0enMnVpca+64aPljL4UeNtPiYTJ6LK22rhHXlWznxm8k5wCGbFFLIwqNdEO+wCQ8DDanBuXI3/Ds6afGIIGBvR1PF4FqbGPhJ8FwoK1jg31pwSeVX2F9sKBEX7HRUA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 16:37:30 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711%8]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:37:30 +0000
Subject: Re: [RFC bpf-next 1/2] bpf: support standalone BTF in modules
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
 <1667577487-9162-2-git-send-email-alan.maguire@oracle.com>
 <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <1b17769a-7e22-b8ce-afaf-70314cc31f4f@oracle.com>
Date:   Mon, 7 Nov 2022 16:37:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAADnVQJ-WXrTj86Qd4PHMFo+fyyn+qWCLMVOHR+upj=fog7zNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baf1dd6-a5c7-4507-625a-08dac0de5cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUS9RQQjMYNNtpOFnxetRBW0KhYwMIIe8O19LjnbVxa3omt5UeA8pdGOwjBFb443248+9BXyI+QRc4frhnQH2yBCNFg79SHYvLqAKZ00XvuraYaEv5LlLYq77crG+93xJw0ViAP5h7eMmH6XatLXB0BcUSIGwcHONQyCwD+SL9olX0CtY1hkUG7QzmbLHiK0NpjgQXRaYdMih9fDT27V1qJaggaM7iWjQtozYBHhasn0i2JVU/6Idl4sz3KON7v/482scHUf0nM2LMqXVt4DIGWE8liibc6xbW8kY0/vcdWHiMDvZZcBjX0W6JvRcTxKJPYrC5pDNcR0q43IzDRso5J/CkYo07sOt0miUBLMboV4Jby9LUbppDORtVpOoSH6OpKBQdoJl/KY65z+W9BokPs9V1uqkMIiShnaDxnRQY/VGd4MyTDV/imCdyGhpUdW5o18lwhzfpv3uHKzAFOne3Sp9zIjInCOWC0k8fwXafDRMUOZsiCw3ACfAoEsPyedzPGjweEqBuDHVX4GIvf9j7mrZQJRxINcsh9xq1ZTZ/5CvYWYUDZ8KDJR6wytbQ2gDps69FTJWd794RAV+y4JDp/7Ryo6Q8oN0QVCJithnYt746eiy4Bbxnp6mqOnrpUfG/tQCJr0ccbhemwp8Ja12cQv80CqPIi4zs3ZnIGAzjdyicHWvR9pNNOKeaHCUFBlQ+CnTpipiqJl7a4jzfxrZX+ZPHYMMcV5z0Ps+JH5l7PKbGLQkWGKOvLJYpzKGqkjCnAwvPJ2bh/jJ61W7FIoRLYYOqjjWCVvKDitBzsLZaRXXyp+nk40pQ/6tD0GdjXkhK4Wtl0lMCvrznrpGpKfGLZyyWuDTZt5iuZx5LSZCY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(186003)(66899015)(36756003)(66946007)(4326008)(66556008)(8676002)(66476007)(83380400001)(44832011)(966005)(5660300002)(6486002)(478600001)(2906002)(6916009)(316002)(54906003)(7416002)(41300700001)(8936002)(53546011)(2616005)(6512007)(31686004)(38100700002)(86362001)(31696002)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNXS3ZESWVMNkNGN1lvY0lwWW9GYWVBbWgvUGRWZ3U1SHByT0NPMWVzeEli?=
 =?utf-8?B?eWtSK0QvcFA5dTh3b21meGJqZVFIMGNpS29WSmI4Sm5rZGw0T0hoU1UyRHVo?=
 =?utf-8?B?TURMdm5ZekVQMHVmTmE4bGhVQ0FjWDRqREhObTlmdkZoVkpIdU11NzlxZ2xi?=
 =?utf-8?B?S0Q5YS83VjEwV1EzRFFGcmU0em16Uml3bU8rTTRWa21wRm14TWN2T1h5Z25O?=
 =?utf-8?B?QUNXVmRMMi9aQTNvN0lFUGpuSWtQc2ZOWlF3ZTVOWWZUc2tjTjgwcWFCSFZs?=
 =?utf-8?B?V0J2bCtTNGxHeDIvTUZRTFBhRFU0VG51b1Z5c0ZBL0w1eGlXRnhvLzR5cGNk?=
 =?utf-8?B?cnVBK2I4VEZYa3VBTmM3L2pXWC9xa2dtWlVvdXpPSVFYYW0veUQyWE52aFR1?=
 =?utf-8?B?QjllcDhsamQxNHJvdmhhcm03bWFCNEY4QW04Smt3VHQzd2Fma1lRVHVtK2tB?=
 =?utf-8?B?L25BcUpIVm43RzJJdndtbjQxOGk5Y2tZYjJZWkl2MzlVY3YrK011VkdxVlJt?=
 =?utf-8?B?OE1RakNuSWJDblpINkFwWjZPUkl0WU9RUkNMTTFBWTVDMmliNngvbXAvQTFn?=
 =?utf-8?B?RUlqeW9xd215eFo1ekt3ellHWUhnd09HZm1JNmZsMlN3eFlNd1hhcTg4amtk?=
 =?utf-8?B?bU4vUVlJcjkycEI1TFlic2JYM0VMYklqMERHR203T1JKNXJkN0RZc3c0UE5u?=
 =?utf-8?B?cXV4TG43VVpxbFNWTWFPWlQyam5SaGxBVm1BUVhDcFBkT3BlWndJb2FwanhF?=
 =?utf-8?B?a3BKS0VidWRLU3pEUG1adTVjTVdaVWFPM2QwZWovdldmNTVQekFJMjdYOUhV?=
 =?utf-8?B?SFBmaHJoUEhHc1NCSm1Hc0dSc0l3bHF2WFVQWkxPRUhJSGxURlU0bUM3Mmxu?=
 =?utf-8?B?dkFZR3d3OFE0ZXhSUjkvNUVZTGNnM2NWNlZYODBsRm1WWmpoNUhFS3lqbmtr?=
 =?utf-8?B?Y2MwdEMzWmFoWG1KdkdJaXUxM054ckoxSndNRHNuajhmWmtVQVBUdFhRMGpp?=
 =?utf-8?B?eGFsaFNNN2NVNzFWckZvbnBBMEhva05FcmhSNFpFWkVWUVJ1eStteDZ6c1kv?=
 =?utf-8?B?K1Y2dC9IRHpEaUI0VUdueEM1M20rTFh6ZTVCbGhZU1BlMzFKcjFnK2crNGdu?=
 =?utf-8?B?TnNPRXNmVDdKWFpKRC8rc2kxOTE1bVpuTFdqOWhvalNrZUJzTDdQTXZSakt3?=
 =?utf-8?B?dm4yU3RZd3h0a2pPVFVGRStRSUNwUVBKSGtVcENxUlNlZWlnMVZ6ZElvWXZW?=
 =?utf-8?B?MVdCL0kwZ2ZaMlp4S0JPaUxhelZRd3I3K0xudlUvY01peS90R1JhZ1U0YjZy?=
 =?utf-8?B?Zm5hb2VxYTNLNFFVc1liYXBsQk1ZMDVzY1c1TW1rSUNtenRKM213N1VsaFQy?=
 =?utf-8?B?SFN0QzAxSWpxVEZvOGNFVFVKd2QzVTdoclhnTm9WL0VySmFwQThiQWJVdUQ2?=
 =?utf-8?B?MHlLNDVKcFJWKytmbFE1Tld3aVFrTDBlY0tOVTNFNVZudlRmbGJkbmNhUnZ6?=
 =?utf-8?B?SUl0eFVSbXd3cVVTMTlXd1owS1R1Tm9oUXNhWXZUc1JsU1pxR0xCSjBNeWhG?=
 =?utf-8?B?VGhvNWNuRFNnQi96dlZkTDdsZDM0a3BYZXFsQXFna2ZqV0lDMk16eTdXQzdC?=
 =?utf-8?B?YmUxdjRWQjExcU0ybnAyd29mbVBraWlyYWhsaVBINDdtZEx1N1BYRjJsRS9p?=
 =?utf-8?B?MG5qK24zSC83ZjYvT3pwZUxoV05sWWFSNnllUk1MZVJ2YVZxRlJtaVdiTEdH?=
 =?utf-8?B?UnlwNUNleldZSnpjRS9naE80KzRNdzZXcS9mSzUvMGRKSkpGZFM4TTlPaXdJ?=
 =?utf-8?B?Q1FaWGoxUUlhSEVPRmY5UjVoZlE2cHoyOEYzOWlWUHJNdThvcHN4czNWZjVz?=
 =?utf-8?B?RjM0cmJNdTdWaDJaUGdwdmdYNzRGOXZwWDNROG00bTBPNFBlZlpHSmJmTVMr?=
 =?utf-8?B?dWF4YnBuQnY2Ly9WNitTOHhBaVJUWjlydVZWa3BkdXQ1eEl3UTdBYzcySHV6?=
 =?utf-8?B?MytKb0ZMWExDQmIvU1pUbndLdGxtcHJmRURaUHFZdmhFalIwa3BaWkxOYzN4?=
 =?utf-8?B?ZFRkQjRZd0c5N2FHb09IdTBYanpOZGZ3NGlEOFQ0b3RmMWUwK2I0eDl0QXRj?=
 =?utf-8?B?Z2tNcmZKdXVXMG15WEl5SEpVZnljME5jQmEwNXF0TjlkLzNveGlzNk1uWFFk?=
 =?utf-8?Q?WkEIK3f+Vt1rZ+RVo8aikyg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf1dd6-a5c7-4507-625a-08dac0de5cce
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:37:30.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Dm6QH2vKUqM1xnE3ZE8FeAP55xMgfYP/uHKnLKwE8OHagigPh4YTa3g8Jdo/5oAnIoyR8fWLOMx4FEMJwmPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070132
X-Proofpoint-ORIG-GUID: Y1SP4GD7pdb1XANX33O_kX9rmxVQPUK2
X-Proofpoint-GUID: Y1SP4GD7pdb1XANX33O_kX9rmxVQPUK2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/11/2022 22:54, Alexei Starovoitov wrote:
> On Fri, Nov 4, 2022 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Not all kernel modules can be built in-tree when the core
>> kernel is built. This presents a problem for split BTF, because
>> split module BTF refers to type ids in the base kernel BTF, and
>> if that base kernel BTF changes (even in minor ways) those
>> references become invalid.  Such modules then cannot take
>> advantage of BTF (or at least they only can until the kernel
>> changes enough to invalidate their vmlinux type id references).
>> This problem has been discussed before, and the initial approach
>> was to allow BTF mismatch but fail to load BTF.  See [1]
>> for more discussion.
>>
>> Generating standalone BTF for modules helps solve this problem
>> because the BTF generated is self-referential only.  However,
>> tooling is geared towards split BTF - for example bpftool assumes
>> a module's BTF is defined relative to vmlinux BTF.  To handle
>> this, dynamic remapping of standalone BTF is done on module
>> load to make it appear like split BTF - type ids and string
>> offsets are remapped such that they appear as they would in
>> split BTF.  It just so happens that the BTF is self-referential.
>> With this approach, existing tooling works with standalone
>> module BTF from /sys/kernel/btf in the same way as before;
>> no knowledge of split versus standalone BTF is required.
>>
>> Currently, the approach taken is to assume that the BTF
>> associated with a module is split BTF.  If however the
>> checking of types fails, we fall back to interpreting it as
>> standalone BTF and carrying out remapping.  As discussed in [1]
>> there are some heuristics we could use to identify standalone
>> versus split module BTF, but for now the simplistic fallback
>> method is used.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> [1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
>> ---
>>  kernel/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 132 insertions(+)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 5579ff3..5efdcaf 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5315,11 +5315,120 @@ struct btf *btf_parse_vmlinux(void)
>>
>>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>
>> +static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
>> +{
>> +       return name_off + btf->start_str_off;
>> +}
>> +
>> +static u32 btf_id_renumber(struct btf *btf, u32 id)
>> +{
>> +       /* no need to renumber void */
>> +       if (id == 0)
>> +               return id;
>> +       return id + btf->start_id - 1;
>> +}
>> +
>> +/* Renumber standalone BTF to appear as split BTF; name offsets must
>> + * be relative to btf->start_str_offset and ids relative to btf->start_id.
>> + * When user sees BTF it will appear as normal module split BTF, the only
>> + * difference being it is fully self-referential and does not refer back
>> + * to vmlinux BTF (aside from 0 "void" references).
>> + */
>> +static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
>> +{
>> +       struct btf_var_secinfo *secinfo;
>> +       struct btf *btf = env->btf;
>> +       struct btf_member *member;
>> +       struct btf_param *param;
>> +       struct btf_array *array;
>> +       struct btf_enum64 *e64;
>> +       struct btf_enum *e;
>> +       int i;
>> +
>> +       t->name_off = btf_name_off_renumber(btf, t->name_off);
>> +
>> +       switch (BTF_INFO_KIND(t->info)) {
>> +       case BTF_KIND_INT:
>> +       case BTF_KIND_FLOAT:
>> +       case BTF_KIND_TYPE_TAG:
>> +               /* nothing to renumber here, no type references */
>> +               break;
>> +       case BTF_KIND_PTR:
>> +       case BTF_KIND_FWD:
>> +       case BTF_KIND_TYPEDEF:
>> +       case BTF_KIND_VOLATILE:
>> +       case BTF_KIND_CONST:
>> +       case BTF_KIND_RESTRICT:
>> +       case BTF_KIND_FUNC:
>> +       case BTF_KIND_VAR:
>> +       case BTF_KIND_DECL_TAG:
>> +               /* renumber the referenced type */
>> +               t->type = btf_id_renumber(btf, t->type);
>> +               break;
>> +       case BTF_KIND_ARRAY:
>> +               array = btf_array(t);
>> +               array->type = btf_id_renumber(btf, array->type);
>> +               array->index_type = btf_id_renumber(btf, array->index_type);
>> +               break;
>> +       case BTF_KIND_STRUCT:
>> +       case BTF_KIND_UNION:
>> +               member = (struct btf_member *)(t + 1);
>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>> +                       member->type = btf_id_renumber(btf, member->type);
>> +                       member->name_off = btf_name_off_renumber(btf, member->name_off);
>> +                       member++;
>> +               }
>> +               break;
>> +       case BTF_KIND_FUNC_PROTO:
>> +               param = (struct btf_param *)(t + 1);
>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>> +                       param->type = btf_id_renumber(btf, param->type);
>> +                       param->name_off = btf_name_off_renumber(btf, param->name_off);
>> +                       param++;
>> +               }
>> +               break;
>> +       case BTF_KIND_DATASEC:
>> +               secinfo = (struct btf_var_secinfo *)(t + 1);
>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>> +                       secinfo->type = btf_id_renumber(btf, secinfo->type);
>> +                       secinfo++;
>> +               }
>> +               break;
>> +       case BTF_KIND_ENUM:
>> +               e = (struct btf_enum *)(t + 1);
>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>> +                       e->name_off = btf_name_off_renumber(btf, e->name_off);
>> +                       e++;
>> +               }
>> +               break;
>> +       case BTF_KIND_ENUM64:
>> +               e64 = (struct btf_enum64 *)(t + 1);
>> +               for (i = 0; i < btf_type_vlen(t); i++) {
>> +                       e64->name_off = btf_name_off_renumber(btf, e64->name_off);
>> +                       e64++;
>> +               }
>> +               break;
>> +       }
>> +}
>> +
>> +static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
>> +{
>> +       struct btf *btf = env->btf;
>> +       int i;
>> +
>> +       btf->start_id = base_btf->nr_types;
>> +       btf->start_str_off = base_btf->hdr.str_len;
>> +
>> +       for (i = 0; i < btf->nr_types; i++)
>> +               btf_type_renumber(env, btf->types[i]);
>> +}
>> +
>>  static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
>>  {
>>         struct btf_verifier_env *env = NULL;
>>         struct bpf_verifier_log *log;
>>         struct btf *btf = NULL, *base_btf;
>> +       bool standalone = false;
>>         int err;
>>
>>         base_btf = bpf_get_btf_vmlinux();
>> @@ -5367,9 +5476,32 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>>                 goto errout;
>>
>>         err = btf_check_all_metas(env);
>> +       if (err) {
>> +               /* BTF may be standalone; in that case meta checks will
>> +                * fail and we fall back to standalone BTF processing.
>> +                * Later on, once we have checked all metas, we will
>> +                * retain start id from  base BTF so it will look like
>> +                * split BTF (but is self-contained); renumbering is done
>> +                * also to give the split BTF-like appearance and not
>> +                * confuse pahole which assumes split BTF for modules.
>> +                */
>> +               btf->base_btf = NULL;
>> +               if (btf->types)
>> +                       kvfree(btf->types);
>> +               btf->types = NULL;
>> +               btf->types_size = 0;
>> +               btf->start_id = 0;
>> +               btf->nr_types = 0;
>> +               btf->start_str_off = 0;
>> +               standalone = true;
>> +               err = btf_check_all_metas(env);
>> +       }
> 
> Interesting idea!
> Instead of failing the first time, how about we make
> such standalone module BTFs explicit?
> Some flag or special type?
> Then the kernel just checks that and renumbers right away.
> 

I was thinking that might be one way to do it, perhaps even
a .BTF_standalone section name or somesuch as a signal we
are dealing with standalone BTF. However I _think_
we can actually determine the module BTF is standalone
without needing to change anything in the toolchain (I 
think adding flags would require that).

If the BTF consists of string offsets all within base BTF
string range, and it contains a definition for a BTF_KIND_INT
called "int", we can infer safely it is standalone BTF I think.
The nice thing is we are guaranteed such an int definition will
be there in every module, thanks to the module init function 
signature. These tests could be put into a btf_is_standalone() 
function, and it would avoid the need to fall back from interpreting
as split BTF, which was messy and polluted logs. If that makes sense,
I'll respin with that change.

> And combining this with what we discussed in the other thread
> to load vmlinux's BTF through the module...
> We'd need two flags in BTF to address both cases.
> One to load base vmlinux BTF from a module and
> another to load standalone module BTF.
> Maybe add another BTF_KIND and it will be first in all types ?
> Or use DATASEC with a special name ?
> 

I'm wondering if we can minimize impact on existing tools for
vmlinux BTF when loaded as a module; even if the module is
called vmlinux_btf, we could special-case how it appears
in /sys/kernel/btf such that it is still represented as 
/sys/kernel/btf/vmlinux I suspect, rather than as its module
name "vmlinux_btf". If only part of the core kernel BTF was
in vmlinux_btf (CONFIG_DEBUG_INFO_BTF=y and say 
CONFIG_DEBUG_INFO_BTF_VARS=m as per [1]) the vmlinux_btf
name would be used to for the extras.

One pain point is that if vmlinux_btf was loaded after other 
modules we'd need to iterate over them to (re)-load 
their BTF, so I think CONFIG_DEBUG_INFO_BTF=m would possibly require
CONFIG_DEBUG_INFO_BTF_MISMATCH=y, otherwise late loading of vmlinux_btf
might block other modules loading, as their split BTF would be invalid
without the base BTF. Even standalone modules would need that to
get their BTF renumbering right. But that all seems doable.

Alan

[1] https://lore.kernel.org/bpf/20221104231103.752040-10-stephen.s.brennan@oracle.com/T/#u
