Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45103571A04
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiGLMc2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGLMc2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 08:32:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14232079;
        Tue, 12 Jul 2022 05:32:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDhJl004919;
        Tue, 12 Jul 2022 12:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=q+V0myb+eflTMIo1mV6Q7IWyW60b50e1N2q5M8cTMXA=;
 b=oTsMghPcmncZU5liggn0WHvKNnd/9UtfH5zPJ0DbKObkFW97Yq14axqXSIg3oyCeu5+j
 ICVK8BsBBGU0vRJfKUEPf2qOgw41zXrU4p87TKz9u+lZ83Hsd+mL3bwGtWGd+6aXL0et
 AWv46kMSPdamUMyd7lhDS4LZYCwl0cCuBplwl7Ek/DixhlatWWR1BYWHh/t3xeRDbPLk
 dHeTelQPz+6AsTqvnAI7Wvs4YI1jvATrEWxAYC2EJr7FK324OdF9X4OM96t0tuNC8NTl
 Jte1WG83q7e6ov9Mt1M/JaHrJup44Uvj5gaMkd2jRQECQFa1aWNGrhCofUXMthPLkKYM 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfxj23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:31:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCKlSM026759;
        Tue, 12 Jul 2022 12:31:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704360xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m19Serowj+uBXV1M+x3njhJd6bBGVs82NWv/VjUDYBAEqdWtrUqVsCLK9etNIP3klq2TA/JFGL+rpivJbgETYvACS7M/MsSMaU0XevdQlUMkv17yjBYmIAtO+w99Rb44LocirHDX1NJYZOypABufJyTZ3OdWa36Q44t1S5OJnc5mIlIj60gk+tMIGBjburmRdSSZJ2w7+NesMtR1WC3jYPQJURxR/oodoNfT/10IGfsDhZBt3rugVnfcSyB+EJHTzRMnTLesAofKxEZPaNELpgGiY/NjtC55R7Mm7wgWdVuERm6FusNURsLuJObe/f6KNlLzKuqz/xDvRcGWhzDnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+V0myb+eflTMIo1mV6Q7IWyW60b50e1N2q5M8cTMXA=;
 b=LddCMypm7l6Ic4d4H7ZI868sdemvvMumFMzu2N01/3p6qU6ircB8QjBp651SQfDCO6y5C9pOuCvonKmfPWyewCZRJvQNHdE2sIG230mpDFNM1S5p3lhXmZSDrVBomiNpJ/IoftrU+WGrqbfD1HweSYXOdYjO3xxsDS9gUmuetM1P1eNcdpxlMTw6UtFH0oaasBLTOhkwcuAdg+N39AK9scKrPHCZ+3MmBiHzPsBU3IIjaUqpzqgki1B4xJFYen7od7kLUJf+oP2p3bBb8Q4iygtMtwpT3p2KCsh4KH7pYhaW0tM5+GMhMtX0SlgwMF7H+ahlKRgYo7PFS0oxw5JoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+V0myb+eflTMIo1mV6Q7IWyW60b50e1N2q5M8cTMXA=;
 b=FUITbr9cxNo9+3bO3tmQkZIbPI0Ip14lG6OdJRMPMLp+dgM2iz5QbtzMS7wixXVBoGn81L8Ij4YvhUcOYfaVMWrbNkOICuTyIF6kBVYDvOWdvhOKmIZYbPnzjsjMxJF/QIBhEgtdhPhHpmgY6KTs7kiNHX4DQ7gk0K3Ov5re6z8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 12:31:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:31:54 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 bpf-next 0/2] bpf: add a ksym BPF iterator
Date:   Tue, 12 Jul 2022 13:31:43 +0100
Message-Id: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4327e7e9-9aa3-44c0-a1d8-08da640280d2
X-MS-TrafficTypeDiagnostic: SA2PR10MB4426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsxwUvyBR7zFcGCUrumo3jOgRh5MST9DmepVbaUFCkl46nY5Am2Emm3j6T73v3+qoVO9399Fu/+M2N/7REx+ipKzBeZtoS+UizQDJOX1/jjQIa87AaRQGSlVJvn8pmihiKxVEwBRe0m1QsumDyRO0HY+ofCfEvif8HYI0LkD8a0Q7LMcaaSF1gPUw56Q++0DFntK3gGOOusy5QIoRD6iKDM4wTARmDCRrh4QJfMR88ffXrYzB628f3AuLepUw4hwK2QCBXh7gH8TLNoil2bqBMDW0zC8iwDNj5EWJknmQ1m4FQB64vjkitZa0GJaDV8gINHmZeICM7mgsXZ+itqQs79VrQFlb8SKBFSZbM9Vsiu0t3fW6FLTKNeT5/RCZpBQGU4mhPO24GXakgqE4jjSh7MSu4nbvmmfOgs4cbivArODjN6+kykD6udJfPb8rkRGydNLeZHD0wLuf0ZQdt/6WuyP/LVEPR13U/9VCQZbVL6erPKYj/EDDXgaru3k1V7hZHIan5mPAXkUPbB0VAMNRyRsuQDdl4uN/xqMnoUuz/FU2HfR/HKPMu1X7yvGvgU/KVO3cwvkMLBV1O1/O2xzWjC8oYd8ucWfzGn1invAli4uCPiz/PfPmsSNHCHfcb4PFg8tCF1jUhYJZId9ykvZSJsexBkFB27jah2wwCMfLTArSzVgTuK+UAfeopj8HSrG7zBqyOGyNim5ZCasXICU35A1nVVq2tLrYhsyTYksm+SMQRCpuRv56sxwXr4dFcRvpsKH8RrWJUVjBKrKSBDt8oyAaq0xBE2leitOIMr/ZTMgxkn4M1fJQ3WcrihosLgcxZ/IvL6C2wnD60czD3Ao2i9peCndTjbcC+L68evp7HisLXwgn3wWM7Toga0UhlOb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(26005)(6506007)(52116002)(186003)(2616005)(41300700001)(6666004)(8676002)(478600001)(4326008)(38100700002)(66556008)(66476007)(38350700002)(2906002)(966005)(8936002)(36756003)(7416002)(5660300002)(44832011)(86362001)(316002)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25vMSOrAmulC/ivBCyrnPGW7K2g9P5B7xg7EEocT8lUAD5FqJhAHMgyRxZDw?=
 =?us-ascii?Q?SqE7wg77lQqh3L+zknzRKbtb5HH9zc9qb30cx12xaHHriQboE0+RZPfAoXf0?=
 =?us-ascii?Q?pRb2DmrnTCjD+Kg27+Mh/8DbX1K7uecbNRzhPHNcmdCnYCZyzU/sG9IPy2mc?=
 =?us-ascii?Q?DlFlcSswUzqol0BMVVpLAm2/5ajZKixu4J19TAn8OD1hpQ2V42Fh8zK+KyJK?=
 =?us-ascii?Q?n/XcuoN/b5FOPuS38dmoVj3wc1q2Fjy4/7IUV3iTAkN2MyASPkmkBY8H4HAQ?=
 =?us-ascii?Q?v/UcXHOmKEWlx4TEWd5DlmKORCB++/5tdLzPUlOmxmhjz3SDCD7vQHUJsmF6?=
 =?us-ascii?Q?/pmYVR4sD6QC5EAdIQvou1xUCkWJVFTfectCnwZfyMMVzcfOWYYsPDBRzQJc?=
 =?us-ascii?Q?o8Tvg/LmFBFjgXQrNUmzYEBctRYo0gpVK6bUY0dgB9lQMVWgB6HMuy5ocs0T?=
 =?us-ascii?Q?2qHAJVjg/hoMjuxtlB+OFN36CJHfFDjEV2IcSKRYeeuRDOqw1ZAC1vGka34h?=
 =?us-ascii?Q?+iQs86JN66WgL9auT+XpDjp+WPEd3OxS/0q1i01L9sHzECzVRAKtlagy9795?=
 =?us-ascii?Q?Rbr6ehLeWuK2tdHjuvk7YGN+QeXsGE7qnSZm/qq6rYGJ4hbxaJbgDiwi8XQs?=
 =?us-ascii?Q?Zyvyj8IVtlJV00NPV0VSN5IuaSlvAlIMmd48g7he6iCI6BYdzVqruO67TcFV?=
 =?us-ascii?Q?YnTAn7Pe1vPMZ0LU+5QgO/KbdRuxQ/6z8XM0t9KxoztiGBR5na1AHIH0CSeW?=
 =?us-ascii?Q?ttJg/XGQfrG8jB1PvmMOHrlKVfP8a0zoqa+Li3txHt8Q0eZSCE0x9y8ymWES?=
 =?us-ascii?Q?u3eBdyXoqGlt+B+747JoGLndjtWfvNiy1mkO7tDg3NoNaGgLLYx21V0HTQ9A?=
 =?us-ascii?Q?Fdy+RtLifzzzZmm93kSeASKTqZf9JoBIYPI4TjiqE8Zwc+fV4o68Ao9WMr46?=
 =?us-ascii?Q?r0l2Pzldl/FG3GKovs84NJW0vSDNbNe+e4961lPRlD5NWddKn09NPvMcrvFk?=
 =?us-ascii?Q?hj9TovzbtjV/hUd5IWh5YC8L1Pod0egYSmYBY/gj3rjzaFB9LGTXHc74H6L9?=
 =?us-ascii?Q?RjskfFyzD16i0OgntFMW0obiaCEVM1W4E2BOWiAWYgBXzAuB7bYKEyZ5d4w1?=
 =?us-ascii?Q?6WhzbIEqkNIkbU+3DQPFypnfuKg5oThsanpJX7jypVTyQYhd8PQxRKLc3Djc?=
 =?us-ascii?Q?JZ31k0Wlns0g0X5Wcp+F5ixglihj/0NKs0Im/XJKeqykpzXPrkSMD569nc1J?=
 =?us-ascii?Q?zGin8ktJQdTcjvpcMOnrgk2gtJfUsfzIeKib18zPFoo1dbW8z36TGpcfqwha?=
 =?us-ascii?Q?abC2ac4380JnkwWgzjHk2djb4VZLVAPOadtmh1y90bP0CbK025lwaSJhsC+L?=
 =?us-ascii?Q?nJd9U1dATS+uzM7D3bqYq3v9+NRb4rZPr9pyUaS5Cjvc22ClYzV84mqreaWr?=
 =?us-ascii?Q?OVtvAJIbp5JugOVdMZ5eyrJcXgO8izYbIbvDH/ZfAnpHtqxjfPfm+2tejWl/?=
 =?us-ascii?Q?ezy3YpEMKSZDx6zvaq9FqIrSlXPOHvpUPDvzB1EKE5UIM8T49PsRhHN8YBkV?=
 =?us-ascii?Q?fLe3yAUQZ2leAfSurR61kGcm+P3B5+9b7+dLpo40wyNwu9llmqaDJHU5Ew9g?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4327e7e9-9aa3-44c0-a1d8-08da640280d2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:31:54.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWRBPSWdOysphL6qaR0V4XLIDF9qOY9Ki+T5yycHbOsvHYjxxnzOYeX7GfZUI/OtNa+tll1IXIIcuJMSjKI7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=900 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120048
X-Proofpoint-GUID: PN3YBJ2PXtMjdj9Ib0cqjwLuWpnslx1K
X-Proofpoint-ORIG-GUID: PN3YBJ2PXtMjdj9Ib0cqjwLuWpnslx1K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

a ksym BPF iterator would be useful as it would allow more flexible
interactions with kernel symbols than are currently supported; it could
for example create more efficient map representations for lookup,
speed up symbol resolution etc.

The idea was initially discussed here [1].

Changes since v5 [2]:
- no need to add kallsym_iter to bpf_iter.h as it has existed in kernels
  for a long time so will by in vmlinux.h for older kernels too, unlike
 struct bpf_iter__ksym (Yonghong, patch 2)

Changes since v4 [3]:

- add BPF_ITER_RESCHED to improve responsiveness (Hao, patch 1)
- remove pr_warn to be consistent with other iterators (Andrii, patch 1)
- add definitions to bpf_iter.h to ensure iter tests build on older
  kernels (Andrii, patch 2)

Changes since v3 [4]:

- use late_initcall() to register iter; means we are both consistent
  with other iters and can encapsulate all iter-specific code in
  kallsyms.c in CONFIG_BPF_SYSCALL (Alexei, Yonghong, patch 1).

Changes since v2 [5]:

- set iter->show_value on initialization based on current creds
  and use it in selftest to determine if we show values
  (Yonghong, patches 1/2)
- inline iter registration into kallsyms_init (Yonghong, patch 1)

Changes since RFC [6]:

- change name of iterator (and associated structures/fields) to "ksym"
  (Andrii, patches 1, 2)
- remove dependency on CONFIG_PROC_FS; it was used for other BPF
  iterators, and I assumed it was needed because of seq ops but I
  don't think it is required on digging futher (Andrii, patch 1)

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
[2] https://lore.kernel.org/bpf/1657490998-31468-1-git-send-email-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/1657113391-5624-1-git-send-email-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/1656942916-13491-1-git-send-email-alan.maguire@oracle.com
[5] https://lore.kernel.org/bpf/1656667620-18718-1-git-send-email-alan.maguire@oracle.com/
[6] https://lore.kernel.org/all/1656089118-577-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (2):
  bpf: add a ksym BPF iterator
  selftests/bpf: add a ksym iter subtest

 kernel/kallsyms.c                                 | 91 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 ++++
 tools/testing/selftests/bpf/progs/bpf_iter.h      |  7 ++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 ++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

-- 
1.8.3.1

