Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4375557877
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiFWLKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFWLKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 07:10:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166948E6A
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 04:10:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NARZpx009478;
        Thu, 23 Jun 2022 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=fkPV0jk/z8lsgNWchrlg/mE0zt0/0ns6LUhIsldWapg=;
 b=oE8lEDNwGieysbsNuKyAX3CcpVS408/FT6P1U/godLSutXO1ZIAeDDFsJJsXp7LukNoG
 8sBvT9R83cq64Yh/cMz/pvX33npf4rMvSBqnzTRJuBc7VeV35iGUF4LNmNMVQnGuk1pw
 mlP1Nt5nH3EXCBXmNf4nhbZqXQ1FHw6MVxuA0TzwjQn/nnM+nYeMVi5a/2u0SerPIuzV
 rh59T116EAPDXGJhUtu8F77EdF8T7FkdMRWw4mo9LuUQPNsZjl8sWpoQfNOfwFgc4le7
 gq1BkJip9vEL5PDIG5+R0958CsV4tpk/C8CNxxz61g9mWH1vn8hzHbMtcLMs5TP7o6K4 OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g22xk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 11:10:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NB0vUu030574;
        Thu, 23 Jun 2022 11:10:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5ehwkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 11:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvdVKHLtQDgrGV+oAL+IzQzbPdNlslxF3F/evRoK00X96/LE7FfTZ0zSj/RLOI5JFxp1O2OZbldefQ0K2ZZfCLlZH9RPQ/NM13W+vldo0RZksKp2oqXND9yXi8FTsHZQP1PnzJ8xq8FxRr6NWiW3OsU89ufHwgFf8izwkat1cR3IxhjN22d1aDBx7/17G5wQtK2ykxSqSyMx+/I1Twtykk1fj1GovIRs7IMaipT8dwHiaoOGrH777xEgiKpLoF5JV5c6nqDbBxBk3zpnNEcdb5+4s8eQS3futi+eQ4gyaiyqWjtZTPuD1BdXSfUysa4c4sO41mceSOHivHB2vNv1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkPV0jk/z8lsgNWchrlg/mE0zt0/0ns6LUhIsldWapg=;
 b=mbP/G/MXuDsBv2T2dt3m/1nLl45USxl9jJa0vWS+oCHtW7ZTV4IXsKj8U3uF6ArG//VIsaI0njZpyrbVFrlv/BpMECq9SmnONBPj99qJWCuWDNUz5Qni/7gLwv1N9Mbm3tESHw+Q4jj0mIiZ4BnfyyUJbn+on9saqnqv2GAbz/WWbfS84dsC9pxM32uJHYpvkW6PydntyTE1GR8pTWdt65mEAu+sHC0Huph52iUqF0e2ZmAP4j9ncgNv+NfQUOT6OMUQRC3FAkQ1+y6yzj/y+7SdQAgNlMRhZ+xEn+O3wsPxVX+1yDtaRNfGh9P2A6CPcwKK0/PonWtaVtztrk5PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkPV0jk/z8lsgNWchrlg/mE0zt0/0ns6LUhIsldWapg=;
 b=Y4oGWYdg3gsgnVjZA7opfhBz30ydrt2uy+203If2WmOodUBJZW4IXQdASK9hkr6ytGxiQTw5s4G3BqQC0pI26poAtmdeYitGF3nsrJamJuwX+Ns6c4L0Whxyfmlri2+cFE6pnGMhOxPTacoZIxaKjjKxZQU0N2zWRQfayN8A074=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DM4PR10MB6159.namprd10.prod.outlook.com (2603:10b6:8:ba::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Thu, 23 Jun 2022 11:10:20 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c%4]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 11:10:20 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: support building selftests when CONFIG_NF_CONNTRACK=m
Date:   Thu, 23 Jun 2022 12:10:14 +0100
Message-Id: <1655982614-13571-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0270.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::35) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b22089ad-25be-41b6-3b96-08da5508f60b
X-MS-TrafficTypeDiagnostic: DM4PR10MB6159:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB61591F72877119D368C77F70EFB59@DM4PR10MB6159.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Gk/ZFdUXpJvYDgtYAma2T3WgfFgV/RvjQBxxG4QMgBZnfuKXlkiRIIauCFV13EXGH8KWZNCrTTfRcd9Fw2nyhPE0OrPsrZqZDsKNvXxTnR142KdbxD4zbADOwV1cmw7s8lzsyT6ydGoqpP+Yg881jLEJ1k4PihV2JTtUOYiNs515xm2s0UvxH3ZWbMc9HH25RPE1e/cb1r9tOLHHwFlRzlXbYBj36jqTcb/ky9ym0XfpQIenUabUDo87mgPy9gfFeHfsmfh+OKauNzCuTJYKSn57t3CsgH10h0IeLGTgtT/O5bcKRn7p8OB8hy/ma62uYxsyiFGdqPFq+wYRamcUwnHiTYKKBYkz61G1FKHt+BBEhu/9UQ51crEmCSbD9/7TzvwGVaBSKEqFEyfdmMn7KlffNSPWE0EnDawfXSVOeN6TdxWX0v47jQN+iw864WSceP8wGhxRmLXi3u+ri1sUCMVocwC+ZQi4kB3qQHEAvjzj0DZcGejVMjkpShX5riFXltvS4/AE3kXX+OzyatbXOpCasv6vaMQ6F3/sPmpR6icz7OHR2MHlAbQXlXSjmPnaoTfHCVgO0j/wYa9PigTbI92uZ8K6qKffXmigoJkOtVPqKl3EQqn73/rnF0P4ThPzvamU0ajx4KgAxvYnJhFsAwOa9m5wiVI+2GczBff6cS50ulbcloMeQA34RATCEUwewcHFCpCDDLrieXN6re+YOBd7j82LmgbvBUAYhq22liLKJIKKqID9tclMz+pU2cx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(396003)(346002)(136003)(52116002)(6486002)(26005)(6512007)(478600001)(66476007)(6506007)(6666004)(41300700001)(83380400001)(44832011)(2906002)(7416002)(5660300002)(8936002)(2616005)(66946007)(38100700002)(86362001)(107886003)(4326008)(186003)(38350700002)(316002)(66556008)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3213vYmOK3jPWwX1K3D6XLP4Lv5O8hbdXm1EhBumu+lF6BsAoT618Jradur?=
 =?us-ascii?Q?qPQH//h6edLm5mGfUWMIwNjM4Fo7vDlaDogg4xZNsA/B4zhT4kfQiGIlJcIZ?=
 =?us-ascii?Q?/O9F5Rv+/YSAhtt5bOjpuXa2dt6kIaw9qTs7So/z2uc5YT696totB2SCghCE?=
 =?us-ascii?Q?3uzUp2rP2iM3PduKI4eBKczfBM91cqHpabdnbBrBIfKiEMDs3Ropw5vFjLjr?=
 =?us-ascii?Q?w42pQUixNelPc/y0ZaQDjN+Dy8+THK8AYyHpviEO0C1nXac0c2FnGC7IB5CB?=
 =?us-ascii?Q?e00RQ9D9Jz8mthvYPvJi2u2EC49aZjP+jaGjJ8See5pvrWwpMTP7QH7PT68Q?=
 =?us-ascii?Q?y74BfhXABnID8Ie1KsUu5usDN60gC22zpOKEnEN4Oz2sXSERdt0vsxYF9ZcN?=
 =?us-ascii?Q?xgLrOBnyMK6WxQ90r5u6qIss3rFrfvUbgHZDpiJl40jMNS0xJrXeBuaKtQzD?=
 =?us-ascii?Q?0fi6F33JB16jCKF6RiJsZw2Syg2sI03D4z9SlBX7Uzr3k3/tR7F2oAseD1wG?=
 =?us-ascii?Q?PDDFP6ThoTFcPoDyUxuIJYZvbdz6U+NxLObgz6npbPBABguiFeiu/hXfG4Kr?=
 =?us-ascii?Q?EJIvZ6RHD0Bj09J7ijSLVI3CHjmAa3khVkmskQFwZv1Np+vrxvGL0LiVAzOX?=
 =?us-ascii?Q?4HSDVgd/EVCc/by/DkHs2btXt0sJp0/TzdtzThvGltRNuB2cpjdMNYtQKttz?=
 =?us-ascii?Q?tCdvIlboPnwFRTTGXuCTTvkBP0wB6kQrJtsFveFKKl16vyTXSPIfoDp1Y5Bx?=
 =?us-ascii?Q?qvBWHyTBePeUwweo9+xwgsxkVVNv2cM1zB4RCY9LbocYa1Qd2OKX3UkzcQHf?=
 =?us-ascii?Q?R4SZJFSMeG0v16RoIMgd6yl5Tm5IOCCnOn/eqoMK0OuiGdzlSWHloocOrL0M?=
 =?us-ascii?Q?opsXASTMku5BUPAjewaelNFK6bEuXmA6QDax8SgjCLkQ4jsr8vHJ1NDt+oO6?=
 =?us-ascii?Q?LvLA4t+RLWr0lBeNYDFJMU7qfYNBuYgS7ePZTrSBAlrk2vh14LhzqxS6+bxz?=
 =?us-ascii?Q?UxQ+2gbt6I+BKOVKWyVjEUT9t1pyy9JQmi7GrqOJHMaZPGsjiVID+93AX33J?=
 =?us-ascii?Q?YkF1zwL1DoGusi6EbkCBUZXW9vL7PbaTiRyUKwutaPflwMojtblHtm2woab5?=
 =?us-ascii?Q?uomVwcWLO2gCSuzFdmGySeg+naLjCgloo/R4m3QN6RVL+v0urKncIa7QI/yU?=
 =?us-ascii?Q?E9/6HAvra5RXa/DgiYZQs0CXjyAR5J6OFjD8RjSA1DJjQM/fw+sgUK7WwS6K?=
 =?us-ascii?Q?AXeNL64j73MHv6TEhbNfkhztTz1btZp9nxoHKSO7z9slyD6naH/2H072AXSP?=
 =?us-ascii?Q?nJkB7/QTzME0wbNY/HJCOymlVmFcGbqT+/OtHwXpfsngwFxCbH8YWlFQgMGt?=
 =?us-ascii?Q?1wGZmO0er+EdjAfgblHkTKUFA6TS9lHW7sK+NCIJVraoFXVRoS/tToysbUui?=
 =?us-ascii?Q?/rn50cPj5SMpdiRIl0YhxzuOGJ+UjoA4kuIsawBEzRxwjhsvTEXc4hmNbpMd?=
 =?us-ascii?Q?FCsc++ALR+9dnHCtegdbMXJUTw09QpgGWtDRpQ0gkDYrPonj+r8mchYPmagF?=
 =?us-ascii?Q?MUZyNI3d/9bpw7I4JYq5FDhKvNYfYWjzWFQJ1TQX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22089ad-25be-41b6-3b96-08da5508f60b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 11:10:20.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F1FZXSuBZ5+JXVOx+GTjm5BkHjdp6aIdHTIQILZMCugXDLxNOQJG5aGnYC/Bn+IQJCoUGT8O918CoQ8d0V0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_05:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230045
X-Proofpoint-GUID: M204fCTT9ndOSbo_9c2Aq6GQ5hyjP7ng
X-Proofpoint-ORIG-GUID: M204fCTT9ndOSbo_9c2Aq6GQ5hyjP7ng
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

when CONFIG_NF_CONNTRACK=m, vmlinux BTF does not contain
BPF_F_CURRENT_NETNS or bpf_ct_opts; they are both found in nf_conntrack
BTF; for example:

bpftool btf dump file /sys/kernel/btf/nf_conntrack|grep ct_opts
[114754] STRUCT 'bpf_ct_opts' size=12 vlen=5

This causes compilation errors as follows:

  CLNG-BPF [test_maps] xdp_synproxy_kern.o
progs/xdp_synproxy_kern.c:83:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
                                         struct bpf_ct_opts *opts,
                                                ^
progs/xdp_synproxy_kern.c:89:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
                                         struct bpf_ct_opts *opts,
                                                ^
progs/xdp_synproxy_kern.c:397:15: error: use of undeclared identifier 'BPF_F_CURRENT_NETNS'; did you mean 'BPF_F_CURRENT_CPU'?
                .netns_id = BPF_F_CURRENT_NETNS,
                            ^~~~~~~~~~~~~~~~~~~
                            BPF_F_CURRENT_CPU
tools/testing/selftests/bpf/tools/include/vmlinux.h:43115:2: note: 'BPF_F_CURRENT_CPU' declared here
        BPF_F_CURRENT_CPU = 4294967295,

While tools/testing/selftests/bpf/config does specify
CONFIG_NF_CONNTRACK=y, it would be good to use this case to show
how we can generate a module header file via split BTF.

In the selftests Makefile, we define NF_CONNTRACK BTF via VMLINUX_BTF
(thus gaining the path determination logic it uses).  If the nf_conntrack
BTF file exists (which means it is built as a module), we run
"bpftool btf dump" to generate module BTF, and if not we simply copy
vmlinux.h to nf_conntrack.h; this allows us to avoid having to pass
a #define or deal with CONFIG variables in the program.

With these changes the test builds and passes:

Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/Makefile                  | 11 +++++++++++
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cb8e552..a5fa636 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -141,6 +141,8 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 ifeq ($(VMLINUX_BTF),)
 $(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
 endif
+# If nf_conntrack is a module, need BTF for it also
+NF_CONNTRACK_BTF ?= $(shell dirname $(VMLINUX_BTF))/nf_conntrack
 
 # Define simple and short `make test_progs`, `make test_sysctl`, etc targets
 # to build individual tests.
@@ -280,6 +282,14 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
+$(INCLUDE_DIR)/nf_conntrack.h: $(INCLUDE_DIR)/vmlinux.h
+ifneq ("$(wildcard $(NF_CONNTRACK_BTF))","")
+	$(call msg,GEN,,$@)
+	$(BPFTOOL) btf dump file $(NF_CONNTRACK_BTF) format c > $@
+else
+	$(Q)cp $(INCLUDE_DIR)/vmlinux.h $@
+endif
+
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
@@ -417,6 +427,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
 		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
 		     $$(INCLUDE_DIR)/vmlinux.h				\
+		     $$(INCLUDE_DIR)/nf_conntrack.h			\
 		     $(wildcard $(BPFDIR)/bpf_*.h)			\
 		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 9fd62e9..8c5f46e 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
-#include "vmlinux.h"
+#include "nf_conntrack.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
1.8.3.1

