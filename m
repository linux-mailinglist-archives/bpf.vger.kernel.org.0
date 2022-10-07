Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C85F7C75
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGRtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGRtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 13:49:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76698D25A0
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 10:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt3H49y8Pe8S3oeXbRNnL3/L2P6Gsv9nE1sVudgvKIaYPXJhRmRCnAOD7WqE0gqv9pFFsm/jLn5rR6jhPSgRg2l1y6OOiD5vYn42nGMdafCTwuzmtrytuRJgaS58bpL70ngIppMSUFwGNPAY+zSu0MxFHnSC6yR3c1DdYrUkmPHmmBSstiBq743oL/vOeoxD/hybYj3GqFx30oLMZCF0qRqtGcJJhEfpuR2sBfSn8jcoLxsIeUI6uK9FnB1CUyk7W24YJG23zKevrC0aUwlmvqRaDxkxAh9YvSHAZcqlw8fptvDJPPjGm5mTr359P5dREJOMrZWZBl/S7tVoGYs7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK/kMhFrVxCSGz+k8IhhyJ5v/0prUf3UkZentdTFKhI=;
 b=cvTljSNcMH0bSUq7TuKihwWWgVP/xcCOYWS92v0woMNOAf74NzsPwbDbHTg5LYllFLrUc8x2ga0sesrnIVNKRbRWQxDjyafSRZKeFowl0+AgMQDRzOQtWXs3bidO2fGmVsndPsl9nZdXXPyy0hVHq9rXnrAhc8t39ia/5qJhCymMCuQjvs/vo/vKrJ5H8Puriay2WGTcD/iTT1raWLRO7zlpvHJzvO6aPd0UhpeHsI7+PkhzWS/3Lgf2nfLp58PqlftjY3smJR2e/MUkDdLvRsQ2WhEsZYclphzFTGXpZpVB2OO+trTeOtHA8+OYQZDqL3PizNJx7RWpt3vYurttUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK/kMhFrVxCSGz+k8IhhyJ5v/0prUf3UkZentdTFKhI=;
 b=xUrvoGwzZp4zTQLPsjzr/NcjKg5e5xYdbk5np4r+DyoWnnPKYm0sjUw4xNSFmEkNAauGfPSldRo71cuTTy4/WfahOhqZ+j3kQTgU0uP14jie4ZHVJPMffGpa+xvkofwFmIKcgIfO/YjuG8J3NcXzaMwWLjMFf9W1CZ7lp2yHSaIYQK2ZrcjhHwE8f/U2NINwxQ+yGUp6sJGl0E082ph2DnjSE6tsBX2vw0CcFMCCNcXKVBUGFuRE/hLJtl8NKMYPUAWYyu6aJJOXXJcqtxa6pMCmbFbTOzBlj6rup1x8ZQmnhERxow8W13IUoVY95BVRedVZKrMaQxsW6WvBC9i6AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 17:48:58 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 17:48:58 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf 2/3] libbpf: fix null-pointer dereference in find_prog_by_sec_insn()
Date:   Sat,  8 Oct 2022 01:48:15 +0800
Message-Id: <20221007174816.17536-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007174816.17536-1-shung-hsi.yu@suse.com>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f5dc0a-e152-4824-cf8e-08daa88c3659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsPhunHuC92XYXRJSmOzSLlwllzsTDz4/BjRb6N5P9sr28SrcWti5uq/8bhoDw1MmItbYk13lFeW7wgJQth9ku+AnYljpnlm8vqIz8Qk/2LKiCfw0+J32nZApKBdMBJLL23nB4BB7KpIGFlEqVzaZNSLOigS1lHyB40yQpJXoJgFIT8aIrF6cfeUMBzTPep53ypsNuKYSPOV5EenE4fpBNUlZOy4Pob1Jy0y68JnblTd77WAAXlc/EUk3IV8uGuwYnDXE3hlwBU4+WZGVziaML14g2kYnLvob5zpXUdUAKC9KaYDjyhJV0CVJsRtQqT8Ab6SJHpXGfHphy1KFU8OOwmU8T/B+kpZ5b/8CF7zkMVQt5zwZEytaLXL5Qm0aHRGGszqurZ3QUKRnChd9FXiC2p1fbUNNhuJpuJ4DgBMUh41AsJtT719YqLTwuUiXL1DEHMoD3TxTI/dmkdf+0o/GujNuZtH7Bg3dYBvD+QNryOOSlV68Tlz/0VtFaTesZHWL7L8W8S0Fpb/efJlJVHOXFW0AIdHq9cFyzmMh1KQKGoHHH4G8sGkrreP1HpoPRgfSZOZDPivrnfINtZJpuvh8pP8meT7wTRnsboqS8qn3IdFb3eaI9awF5XSZ1pBarFbxF2Fi0EHWWmYLSbqX2urB0AOgb1PoTWEe24AVR5FNxV7NWgW/o1neOUvOSCY/VA55Yb4Al4sw7DYuA3VK8FvPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(1076003)(41300700001)(54906003)(186003)(66476007)(86362001)(7416002)(8936002)(6916009)(66556008)(6486002)(66946007)(5660300002)(8676002)(2906002)(316002)(4326008)(6506007)(478600001)(6512007)(2616005)(38100700002)(83380400001)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gnl9vFnfjYEJw4NuxhxYNhPPd8auU+OptZf2WX6kVtxpkU0L5GRjCLB1dJN2?=
 =?us-ascii?Q?Ig1iOVn30OMz2QshzYSkViO59fcPygFgN/Px9C3yxSHYrPIs1Dswepb29YwI?=
 =?us-ascii?Q?4H0v95VZ8/XJYZiRoxUdYhgTW+1ceT0gexjbVQoBhyXkSmiOk843qFvi1/uA?=
 =?us-ascii?Q?uPNXPCamgxE+WvgGt0WWXmuqOoK0mFt8SYiPYAP72+xyM7kuY8as9vz/DAZm?=
 =?us-ascii?Q?P5PKa0NYWVGJUq+vW34RZgtebVnJWVJW5jDBojhjR5mhgy2HleTD1oYDb+L8?=
 =?us-ascii?Q?gn405sWyb5PGhrKT5/kCenywYS9n2ii9MpANxaTKF7F697EeXB2Jvc9JL7aU?=
 =?us-ascii?Q?gSbUiKJW0iatPPyWJOiKCjMY8O7HvNLvS3/MxkKAIvCQaNuG10FcUjzCaEaC?=
 =?us-ascii?Q?XzgGlRzW9puoQlimV3+rTXls7022+zmdd03CINiNpUnfcPQ98iqo0/0qKUFw?=
 =?us-ascii?Q?lDqJZb/jnAg7cBkVJZNX/cxE9tPtQGCTqL0BXLawMBz65mH6F/pmKkiCeX9a?=
 =?us-ascii?Q?osCSVNWK/yk9/B3eDZ/h8wZauXDXVZdHkFzgTNOQRIhpOf9S1iyvajrS575I?=
 =?us-ascii?Q?iUkYTCIk2AumnllhCLyCJVva5wE66URp8R1SxkDk7xo8H9dCh3ABrQv88h9+?=
 =?us-ascii?Q?jTGQzYnvXDsnQe7mBJ1zOtgPFHgKSjAa2Eoa41jFrXDyUFz0aO4bt4pdP5Ab?=
 =?us-ascii?Q?EH9GHvT5gpiq32klv6TqR/SekvJYivm9JoJf30obEjwICPemaWFyKnxCcLvR?=
 =?us-ascii?Q?B/3a1lkApek22umz/lPX0bhNgIPXRBxZ+1F0hEftcqJqOkYSkf//U5J304Ro?=
 =?us-ascii?Q?T7rTU9Zspd72aV8w6nWPwbIcS3eIT23ko3gW1pRCi0PXAMiLsy3UeYjuVr3l?=
 =?us-ascii?Q?jAUIAcJVWaPyJ2wjKB4GP6OrvAgK4YOZWEnzIQe38IR4Nlm0jXHUeeJdOo8C?=
 =?us-ascii?Q?mQs7oKgPdwAilbVnzo0uPILcm3MCcBh+M6mLFgaFECCBW0GtWqGz/Ckkw3rA?=
 =?us-ascii?Q?8EDc4CPPqQ30hsWBdD/YguKuAlmDJbkq81AUR+hPFts7Kpco6gUy1G47VyVm?=
 =?us-ascii?Q?67RGOa0f2I4zVzlQOwPG9nE/nv7FifdLkZLXPV2v2xF/HqG+kSxRskD8Git9?=
 =?us-ascii?Q?bn3Yw+1nep77lYw0N4EUbcgoZaCsZHaWYPRqnGQvCoIJs1cWFuHI0/VPXbsV?=
 =?us-ascii?Q?qPbNVftF3LxVMVo0QsK4fyygyKUl45462zTrFSeb/eE7+lBQ9VLxU8C1VyPu?=
 =?us-ascii?Q?MM7MXO13HZ+NxQlR1TF8VdziHhwoZcnVnY40c89mMSjGmtiXOWrVwY14M7L2?=
 =?us-ascii?Q?yLcnuLSQdhytzX+uAS4jWiA82rpjIg/KiwCkJig66SRG3GrjQvqHW+5VnH1O?=
 =?us-ascii?Q?luz50VmwblSYtaJ8Y816c/G7BzSwybgw/sP/qMb5jM3JCoNVMFu9PCitNlwC?=
 =?us-ascii?Q?JNZvkSQuxN4wRZhHcszY48Mo3vbnIb+aRQXjpqAmGTbZPOJEh6NnlNrPtGKk?=
 =?us-ascii?Q?B42VIm8CnM4OQSAUVmWOxLy9w5pFL4xk8xy4akU1sBjSsjswbCQyYoZqYGwG?=
 =?us-ascii?Q?5QEtMQh2cZoVaqUjBNdzuMIYN8dWeFZBVqvZEVJF9ls+MdvVr/pPjARa36Yb?=
 =?us-ascii?Q?ag2w1E7maW7R91uLXajFACM5d7DYS3RnMOeA77ebQNGp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f5dc0a-e152-4824-cf8e-08daa88c3659
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 17:48:58.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyiEZ515Pby8XNxnOwozrAT3Vg+imYK4GRya2UVdFAHyuLZ35dPKzOs2H0EQXUWvIRez4SD3XpmilcZ3gBzdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When there are no program sections, obj->programs is left unallocated,
and find_prog_by_sec_insn()'s search lands on &obj->programs[0] == NULL,
and will cause null-pointer dereference in the following access to
prog->sec_idx.

Guard the search with obj->nr_programs similar to what's being done in
__bpf_program__iter() to prevent null-pointer access from happening.

Fixes: db2b8b06423c ("libbpf: Support CO-RE relocations for multi-prog sections")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a64e13c654f3..c700489239e8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4112,6 +4112,9 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
 	int l = 0, r = obj->nr_programs - 1, m;
 	struct bpf_program *prog;

+	if (!obj->nr_programs)
+		return NULL;
+
 	while (l < r) {
 		m = l + (r - l + 1) / 2;
 		prog = &obj->programs[m];
--
2.37.3

