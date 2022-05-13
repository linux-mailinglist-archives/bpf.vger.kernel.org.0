Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE650525B1C
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbiEMFr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 01:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377127AbiEMFr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 01:47:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AC4D9C4
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 22:47:53 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMMhK013632;
        Thu, 12 May 2022 22:47:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gZL3vBdCWUnNHYkZAIiFwk3E6xIAnd0iQpEo+nIQHkY=;
 b=Sr1wT8iP1ZwHWyGIwG7cLCklgH6y5i+nV25sm+ftn3+U1DirBVaZcpnYPzyG83GudtCa
 CCrPV8hYSX4qAjvKspfPPpThcYqU/Be02tgi6yGktg7TYjRZcggJWq3hiSFVJpg9ZYZD
 qA9MXAJS+unhqwQTvzA49I04uCikkYn5tEs= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g19w9tj4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 22:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqDJ2RdePBWl/p5EHFu36FnC620/VLg5jr1mPCnSau5+hUvzUuZ9NlkZ2XKcAZiX/1IjNWJDZw0mp4rytuhN7BXnQ7H5RHifJBJ4w7hlbJPh/ap3clcTL2L6J+5q3nRQ/zWjQgxxv8fFs8SYcjUEEO7tq+kBsphIA44RDUutkLB+m0DInvf0gcfnd4xH7g+37E3wiezzKPJkPWNuOV4b5tRvpRsQC5M79KUMS7jdHAV0UgNFxve7ARpSJJjQ7JVXTWOyq5pRzrgiMnlT5LVJm6s/QUdLrIgIM06H+B8s7Rg1oDphzzqhg2uvKmRTINgZPzNLBfiRUtp/nVg5e+qqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZL3vBdCWUnNHYkZAIiFwk3E6xIAnd0iQpEo+nIQHkY=;
 b=fPtSoIVZ+SIisQTNtTe1N1tpqH5Bb8Wyih2verIg63RLUnEX2VgZvZRE7H49iYExln2ShrEtUSPgFEgIXXwD/OOJqSXvS5ivhCmQAG70gZNfPM/94lyxu5FsXutYVqgjoIGZi8NcAvaoPGIsi1WrKGLWfWsLnsFZu+OJQi+jk2Ul61ntxKgFdQVjhglcO/v359R+6YHMvuDCGrQcKnYyHWX9EPIvtXW+E7NK6IE1ggi5e+/Jr4hob9oUgOmDoTi6i4xZaItluSFCqHzOJC36ZGu0Cbwr2vJOlxYHekic1uKnUyx2O+vO7p1+QZ1VoHdw67h/syXnFJUqn7Hc9EcJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BLAPR15MB3985.namprd15.prod.outlook.com (2603:10b6:208:274::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 05:47:35 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3%5]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 05:47:35 +0000
Date:   Thu, 12 May 2022 22:47:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix combination of jit blinding and
 pointers to bpf subprogs.
Message-ID: <20220513054732.5v7lgyuecthenc5p@kafai-mbp.dhcp.thefacebook.com>
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461aa281-1621-40da-06cf-08da34a414be
X-MS-TrafficTypeDiagnostic: BLAPR15MB3985:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB3985FE8817E8849416682552D5CA9@BLAPR15MB3985.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCs3WkkNNmG/6cBzfhcAHzp/XfMSJHFDiAtM5ivcWIsq7VjTZCJ6JrRLDOQTyUJpcjnNc1NyS0TyssWIRL5feUwdaSHHP7c82nnmbDkK2Og0nmufWk/GqRC5RpU+RFVcAm+lAPW8toIeiDZxBbff3rSUZekE3ptCjOyQlwSKWh85zHkEu1dQ+GPJdYJbdl8wHCVQ89jFnSi4tTf22dMcxzXk6imQBUb8J1h1/G0rauVNKS4S01Mp28RUF2uF6XJYxWnuum3nUEVHyAHyxVOVHs4jd7h3Lg5qWkWKtHh2bHHfB5JaGk9prSctvd0DIin1X1FWiLbzQCCx94yOyUf/wDVi4MCkPajRNiiK8H/yihUJ6bvEqTShhPI5XNPRl3LuUY1CxcZZMoYTtp5H580ToYJiHxKdPbAhGkaiXIHL8YjSV4MvnkBscZFTnH7Sn9R7faS0jOJdSkoYE5ZfkV7OlZgyA+lWFJ4HqHAnjMUKz4xsJOCXC6xDeeVKS2UZFS8OIzNojWeXsS1FHaSOoq2t/tFhgZFg5Pthv3yZIK0XrgApCIGmcPkSObgVbM+qAMsD/yZzTh4XaVeAWdVvMwknNYjjuniTQmh+bvrwR9i+iVTviGwtEXi+wjWq7fcvRDayz0KUdwnZGuctPNxR34PiXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(9686003)(6512007)(1076003)(186003)(86362001)(6666004)(6506007)(6916009)(5660300002)(38100700002)(316002)(8936002)(2906002)(66556008)(66476007)(83380400001)(52116002)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3wn3CN1SKCEU4QDqFXXWanOQgnzHQgze4BnSej0E+QiosIli+5weAAbvJz3?=
 =?us-ascii?Q?PdBsFV2ZRyU36edrVnEOHZs6+g0CiyPbRkAK1fDWQXjwxMuBNRTqOGDthmED?=
 =?us-ascii?Q?DzY9VWeg/E4vou2ngnRLSv3fHSO0jLkO1nnr0aeCakFe5SERqPFhwGRkqtLH?=
 =?us-ascii?Q?l7ZZIipmwYtbiQICWznAIMYxtvP+6P5CPdt+w0p9cBnzU+qUbmTvbjc3lCKv?=
 =?us-ascii?Q?lO+v/N73VKk5PP0KlxZr38cGv80gBfrRdAEG69lM57Tlk7zPdwQL1XXPcI6h?=
 =?us-ascii?Q?ZF70qYTSNR4vMyJYDFGJ6LA5gq8rUdB3Hp0YL+S2fY9B/7TZJ+2td6Fd30Um?=
 =?us-ascii?Q?dj9YYinewnqdBq5yWnr910pOAzwqFoGWzt+BVqIBflaIxg8jszu5XBMS6M/+?=
 =?us-ascii?Q?as/DZ5pgpTer4upWVfmk2Gdh+M9dTplyM/IwqFVlMxIvrTqiptZcBRMnMjXE?=
 =?us-ascii?Q?+L442qhYTU+SB/7R9CwS9hV6So/Uz87eQ55jor/HdjnkkWtKhwVKPwQ9N4it?=
 =?us-ascii?Q?2WT/0kf/huVXxNgbO5RZ9ElXkUZfn2y96rmJs0GONKI2RgaGcqtvTzVcDWQ0?=
 =?us-ascii?Q?qbDo20lXJjGanpZlPYsscpOQzvEJe9cpcQwYY0I+BhIc+1/LIqB8AsxzMOWh?=
 =?us-ascii?Q?CFkXaGovEFmKQx1u2uasTj6r+5LiRByGPYNV3n3on6kd1NVp0aUeZds3Mj75?=
 =?us-ascii?Q?2fj3v7Zr+FQaYAlFGSYooxg6hy6prvFflbRztOIjman+Y7j6ps7ZkTHFZLCT?=
 =?us-ascii?Q?e1xQbtuLe/XGAYe3+lJ8+fw76Bu4nvu+nJAtBPckD5tXqbO43Dq7peoUd44k?=
 =?us-ascii?Q?q9KiW/+2KeI9oKE3KMQmoACR9FVtBWDs5CC4vhqtaAuNOZhCQvSnY0haUxbY?=
 =?us-ascii?Q?RgYcHkziOhJam/SK0l+OnMfU8ds23Af2mHgeJ+gy+lEFU3ivGDkfEkaaTxXL?=
 =?us-ascii?Q?I1i5DI4ZoLUb/b5fG0zITB8wDA4tOk+F1BxDz+QvbzgfRBW2KFqHuE3V2mAI?=
 =?us-ascii?Q?s4pasd9OKEJRiGgGYf+swOJRmAVFB7dLBfYMyL2VcidZHGF2TGagkKH1cIwg?=
 =?us-ascii?Q?gD8CHJDd44luxsiE5/qmO+AREKDm7Cwa23sT6CmRthXJV3/T/zP0EubBOIFQ?=
 =?us-ascii?Q?DEO5cME2LSPH5KZrZRAaHC/35RAY7xbqKwnekKoVkcrUqo0xfNnWvmZPt2wG?=
 =?us-ascii?Q?3XEcmw1n8TXha2kAw9nKgrxw4iuQssJqCalSC+KCL4Ei7soJaLJMRNmpoQrc?=
 =?us-ascii?Q?42EhxngdoVbtKaFCB7Dbo+MGbVOZGquQrBz4nMaV48o5uaWHxNjuxrh/Z7c0?=
 =?us-ascii?Q?zzs0LaNRexZ34rx1ZfcRkvlPjQMwSeC8niCCE8DTrG0dmxRKALiHbM/+m72J?=
 =?us-ascii?Q?d+O/CJVk12Hhwo9pjIRrXzoNIaUppmq4Hbs5X9sKGC40qyI7GAFrDvFDkUIh?=
 =?us-ascii?Q?viv3C0BXqdccnEeUDKEkcl6qsPdr9G35slBg/nz5z9X+A0FB8IpwErraASFB?=
 =?us-ascii?Q?sRqa3gob3gmaVsv0QEU1l+xtoTJtwIHsuxt3Tchu1VnLFs1QOfaKuMRXdy5V?=
 =?us-ascii?Q?8Ap5IEYKRkT/GgRz329hcCVWgz47PWAPmbgEbYxTYH6QC1MHSlaX5M2wH/fY?=
 =?us-ascii?Q?lhSTRT/hzDGlzdk4abU1u0dhk3QiA3BqWzkph/GHFGGRm9yxarmEnCAExC4h?=
 =?us-ascii?Q?X5BQsCJmIN3Hm9GYybM6CJ03kKupxs/00Ff/fAx4Ht/0134JcZY9g4W65W7B?=
 =?us-ascii?Q?ZCE+v5IC7/7iL/D7xn7O33jxEtq61fk=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461aa281-1621-40da-06cf-08da34a414be
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 05:47:35.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxa8+LNi930WEfxuATN7buJd5QJgDepDRCkgNnTfiveZ234BUAfV/1mwKehE3XUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3985
X-Proofpoint-ORIG-GUID: 0rI3nWJzh3t8gSVY1_pakSIEvpXfN3AO
X-Proofpoint-GUID: 0rI3nWJzh3t8gSVY1_pakSIEvpXfN3AO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_02,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 06:10:24PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The combination of jit blinding and pointers to bpf subprogs causes:
> [   36.989548] BUG: unable to handle page fault for address: 0000000100000001
> [   36.990342] #PF: supervisor instruction fetch in kernel mode
> [   36.990968] #PF: error_code(0x0010) - not-present page
> [   36.994859] RIP: 0010:0x100000001
> [   36.995209] Code: Unable to access opcode bytes at RIP 0xffffffd7.
> [   37.004091] Call Trace:
> [   37.004351]  <TASK>
> [   37.004576]  ? bpf_loop+0x4d/0x70
> [   37.004932]  ? bpf_prog_3899083f75e4c5de_F+0xe3/0x13b
> 
> The jit blinding logic didn't recognize that ld_imm64 with an address
> of bpf subprogram is a special instruction and proceeded to randomize it.
> By itself it wouldn't have been an issue, but jit_subprogs() logic
> relies on two step process to JIT all subprogs and then JIT them
> again when addresses of all subprogs are known.
> Blinding process in the first JIT phase caused second JIT to miss
> adjustment of special ld_imm64.
> 
> Fix this issue by ignoring special ld_imm64 instructions that don't have
> user controlled constants and shouldn't be blinded.
Acked-by: Martin KaFai Lau <kafai@fb.com>
