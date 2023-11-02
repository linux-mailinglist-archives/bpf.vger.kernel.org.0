Return-Path: <bpf+bounces-13907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA67DEC62
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26A21C20E89
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D28441D;
	Thu,  2 Nov 2023 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eo2c/t6V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29784C92
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 05:40:04 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23425127;
	Wed,  1 Nov 2023 22:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWoYVNkaWa/HwppkdMZcBVeT5hB/saKhby+rI7l0mRk4TIhPGZHNtt+nAK9Q3rRpyOWobGX3F09Jzyi6Wo7f4rswiVzloKJ/eE7GhQdSlSeReqBTi+IiRsgpSyxG54e7WJDlqKQqeHBgUYFxmXOL4B4AGxNivAKJQ+5ajGhXDvHC7VNNrxPQmWSlRO5iBhVGeuv9/CcXHOR/+viuGewFNRvsCFdy+Mugw30Ml6PXj4QcCNzqwiWNrVHQyySknmZuWpSHf8JGrUmBCL8tQXsRsLMobkDS9qWL8YmoFUpzM+50k0d28SkiU00Z22nwWKfQHFOVZ5yObSlYRt7RmIv9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoeMHK1uLtLSRZ3BZi7F8b7wPIodeCsSUeSs0Hy+/G0=;
 b=GF4KL2MfanMmRX7tpjR5eGbbya08p1D05Tx8hk+tFDSJzPgS3Wrh2fgcqIL34irOCjFq65N+pnpfDfnRo4gew8l1FHkeUZNrDmaTLOm+B5lMPbF1gO6Ljz2Rrd3QIviH3kWUyIVkBqj6aOVRj1hEGw6YDFNaPllMa2WpokjWB5FhlW3/TA65UuYdcQyAfKI2M0hcpbNrUSPNYkrJn7YNC9TnYAOEbKx6zIpblyzTZoHBgnv4Eymnwo6fKy1jSB4ToTiDlFMmFNySJQEX+H4rCRjJQiWzP5S9mf+nxxA9j2L1GFol18LDyose+1RjrEBx5qDaTfihkwtO6VbdOh0MIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoeMHK1uLtLSRZ3BZi7F8b7wPIodeCsSUeSs0Hy+/G0=;
 b=Eo2c/t6VGTwzh4Bl/b5odNJsLOQla/66ROvZxbAPXnUsGOxB6upyabX1pD/sXfsBQE2vGPmJfpuo1+X7hW8jH3nexYLhlqAt1x0OkCDopyLwZSVwHnQgFtNgmlrPySTIkLRx0pQ50yZBdnf6apZ18X7R5XpG9xX0CZswwMUL554RQQFAni8qOmMECeio5BBemcPHl/H1OJYlkhleAciKUGhultyO6WXLMMpcW+twmWGVMA68Mx7ihGrcwwaUjECEdz0a5/v3mPCy8gDVaxjbO5RaRwRm1wjYxQNa8KZTGoBAQRC+xCva+LbjdbBRgb4UPQ1KgJN9qbh5dLkrn3Zi6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 2 Nov
 2023 05:39:56 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 05:39:56 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	stable@vger.kernel.org,
	Mohamed Mahmoud <mmahmoud@redhat.com>,
	Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH bpf v1 1/2] bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
Date: Thu,  2 Nov 2023 13:39:03 +0800
Message-ID: <20231102053913.12004-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102053913.12004-1-shung-hsi.yu@suse.com>
References: <20231102053913.12004-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 21093481-b571-4f27-be44-08dbdb662583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TlkcW0bz/cnsBBJwUveg5h3ESl1tFfDPIhqdBoNXamUBPSJGY8eEFlscCnGkG8ZpfCFxzfsGLbLW10rbG94kKjyLJ4/UZIxZ5dIuR0nwvB268R+ZCQVNnDAajT07roQuIGX5BL20Oa9xAYbh5QK1YQM0cGGwczQLR5MyWqJie0m4J90XtNilNx1w+qfhem6fz/XP5ceL7CtXPPG0GrmyKfhz8TdW/yJrwMflJ3a0EAgMykWnTswjBE+PyAqTzEgcAdpk+7uIo0fdXyCNUB5DBg8/EXI5W/YssRaRFsDvB1pj9t+AbTxOM4QsQcMAJIIMQQwqdBOexfapdkwYPNqgJKQNI2UGacte/HaU5sg2PgYaZcsYPgwfUmZWwshXEUEBdboo5Q7qqx9oL56L6iBfA/bRXgi1Xxk+OLsqb7iw/cx/cgDSoxbcbZAlOvCiW37nqgUeAynmoAqsi+awOQVHznEwfLQQdZjuv/5t/f35Fn+TE2720QbRSSeMaoMqCMg72vRpmF7i22YxTPLIEx+QOb3OzGCL5zuA2fkLTPUhTVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(7416002)(41300700001)(54906003)(316002)(6916009)(66476007)(66946007)(2906002)(8676002)(6486002)(8936002)(5660300002)(4326008)(478600001)(966005)(38100700002)(6506007)(2616005)(6512007)(36756003)(83380400001)(66556008)(1076003)(6666004)(66574015)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3F3dGxuaVk3UGt2ZEdqYjh6MDl3K3diNmkrcUEzdnAyTTMxQXk3QnFZZnlv?=
 =?utf-8?B?ZEllOEp0cXZMWGVVZmcvZXNJT3hMeWdGWVl6Wk92YW9TOHYwOFBkcWpCaWxN?=
 =?utf-8?B?N2JIN1dyQTYwVTZ0b21BZDJJNEI2NjhyZWQ0ZVNZemQ2TUp3RzI0QlV3c1FT?=
 =?utf-8?B?V0VYRlBoYXVENDIwRUpMVXUxdXBucHRnZjFtRGdpeXgvYnlhRzlwdUVoUDZm?=
 =?utf-8?B?dDJsSTFJOGFXU00za0xqTG0rVjQ1U0dmRUZ6TVNGNkJBSTFXd3ZaWUV2UzFz?=
 =?utf-8?B?YUJQd2N3Z2I0ME9oQnY2V1N4WkJiWFFBSk9xS0NCNk5tbWNwQ3dUaS9raisz?=
 =?utf-8?B?NzNEMWt3S1NkbS9ZVmpnL1RGRERzbWZ6V21qWnpmNkxUckZjR0Vuajh1YTRU?=
 =?utf-8?B?L1Rtb1dxeVE2M1h1WURWM2V6U3c5RXR5VnMySUNsVlcyY0paWThiZ2dWSTRJ?=
 =?utf-8?B?aUltK0Y2a2ZhQVlkekxNdEVoYVhVTDA0VFdkQzdkS05lZDFibHVJUS9oN1hN?=
 =?utf-8?B?bWFkdmRjd3BvN3dUNW8vdndMSWRGRXEyV3hVeC9nbGhYcEdsMU1XYUtYblpl?=
 =?utf-8?B?YTFIYzB1N3VxTkJRUjhYUHFYbDk3dWdjVzRLb1BocnVMNUpEZm8rL3pQVnA4?=
 =?utf-8?B?YnZwOE5qY1Bkcm9xOE5zeEo1UFpSVDQ5S1pOMG5BNGVBRGxqYlVLbHlnUDRI?=
 =?utf-8?B?c0JrU2d2VFVoOWNsak1mSGk0Z2IyS0VxWkdSSFpkOGp3dnZ5RWRkRnJiUnQ0?=
 =?utf-8?B?dk5oUFhuNkRJSjQzMUZLTXNOZHV6SVRQQWo5aXdsVFVPTkJpdTVuRDVHaHUz?=
 =?utf-8?B?Nm1FQmRFMkorZnB3M01tSWtLejMvUG1MM1FncEtHWHpGS3p1Qk5aeUE0Y0Y5?=
 =?utf-8?B?T0s2YlQ2VlBmOS9QbHFMcHpuNzlNb3J2QjBtanNHU3gzR2xkQ0J0TXVUZnZp?=
 =?utf-8?B?UW1Ma04wbWg5WlhOanBWMTAyUnJvdlBjUlRJZWNmR0xKeDk0eHF4eUdWeS9L?=
 =?utf-8?B?S1dyZk0ySEh4S2d2SVFmdWhWZWU3Mk8rb05zWS9DTk92cWJwTlpEUzVxQWpT?=
 =?utf-8?B?NUE1UGdKSEE3Q0VXVmFtNVkyTlRsd0dlS0dkWTBMMVJmK1QwUTlaYm5HZi9T?=
 =?utf-8?B?VXA2T1RKVDZhWXVsZ0h6SU5kbGFlVXYxSFZjTUpOWmcxeFFOZHV5S1ZISWlC?=
 =?utf-8?B?T1A2M3U3Uy9uUDNJdEhsSU1ZMTJDQmNLbjZDeEVTZXRKVnlCcjYzV0tLaUdv?=
 =?utf-8?B?Z3RXSTl0L251WUkxbWxsV3V5bnZxYjBMQzl4SjdzUytXSjZCZFB4ams4Zkcx?=
 =?utf-8?B?ZnBjb3VoR1g5UmhmdTNiNHJNQ1NuZzlUNUVEUCtyVys0ODBjQW1EdFN4VTJ0?=
 =?utf-8?B?cy9VSXA1MEF4bk40UG5Fb0ZuNUdjeGJwa1ZibTlkMTNGYThaSVcxL04wbjda?=
 =?utf-8?B?QVFwVTF6Z0dzWUJrd2huRXdQVHY2dFpVakpKcXc1V0JySFd0bDlqV3pBMExL?=
 =?utf-8?B?amk2TE9KcWkyTklRUndNMjY2RHNsUEc5ZjU2dmt3OFVzTGhBZnpjaXVOSHdU?=
 =?utf-8?B?aDJ1QXZ3ZEdrejFWYzZsclJzM2N0QklTbGs1bmtXSWNSckVpclZlOW1pZzRT?=
 =?utf-8?B?b3J6RnBYNGIvQThtYzZWcUZsZ25iMzc4YXlmNm1pdjZzMlYvYnBTd0dRMzhM?=
 =?utf-8?B?NzdzNDVJeHFkTTZJaHBBczFqRDFLc2liOEhpdytiUTFqeHhPNktPaG1VQ1ZC?=
 =?utf-8?B?WXU1UnoxV2hCZUk3TU4ybHNNTlg3K0UvSUpZUVNzcGsvWm9PT1pnYU0xUVZy?=
 =?utf-8?B?bUtMUTB4THUwTWdxMno4ZTNFaEpSeTZrTkk3R3UwWTBDOTgyVlQ3cTlnYXdN?=
 =?utf-8?B?WmJGbHlNUzdHZlhsRlVGcmlIejRFWDJ6Q2JaQkxkZEI1Zms3SHE2QjJsTTM0?=
 =?utf-8?B?aTc1dWpGZGNMRlRaV3BVdlhuQ1VFTlpRRVVVZUNTV0FRMkI0TDdKSVU2R2hV?=
 =?utf-8?B?L2lteGV2UnhZQmdCaGRMY2Q1eHdVVmRkeWRjSjFRRWhXQ2dKUEQ1TFVlOUdH?=
 =?utf-8?B?Y1dEeDhlL2pvSXlRVkRPQkxqT3FmcTlObE1CcEtMeE55am5uTWtyZXYzdDVX?=
 =?utf-8?B?dmFiWlY1bTZrMGlsQTEyeWNSN00rVUdJVlF2UHpXY1F3OHZMOWwvWHBhMWJp?=
 =?utf-8?B?UmozdU0rQTF0VTBXV2NiRy9sT0w4RUF5TnlzWTU5eGxhY0RVeWwvZVhwaTZu?=
 =?utf-8?B?WmFMSzNITzlBUGZEYVFDbFVUcEJBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21093481-b571-4f27-be44-08dbdb662583
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 05:39:56.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+gSebNpj7dKuCAAy3DjecUoUtdWpBKyjStwNuftHm5wsjhutbTedswssDLz/gGMVEfiOarbD0ei6PfjkZTB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687

BPF_END and BPF_NEG has a different specification for the source bit in
the opcode compared to other ALU/ALU64 instructions, and is either
reserved or use to specify the byte swap endianness. In both cases the
source bit does not encode source operand location, and src_reg is a
reserved field.

backtrack_insn() currently does not differentiate BPF_END and BPF_NEG
from other ALU/ALU64 instructions, which leads to r0 being incorrectly
marked as precise when processing BPF_ALU | BPF_TO_BE | BPF_END
instructions. This commit teaches backtrack_insn() to correctly mark
precision for such case.

While precise tracking of BPF_NEG and other BPF_END instructions are
correct and does not need fixing, this commit opt to process all BPF_NEG
and BPF_END instructions within the same if-clause to better align with
current convention used in the verifier (e.g. check_alu_op).

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Cc: stable@vger.kernel.org
Reported-by: Mohamed Mahmoud <mmahmoud@redhat.com>
Closes: https://lore.kernel.org/r/87jzrrwptf.fsf@toke.dk
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Tao Lyu <tao.lyu@epfl.ch>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 873ade146f3d..ba9aee3a4269 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3426,7 +3426,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
-		if (opcode == BPF_MOV) {
+		if (opcode == BPF_END || opcode == BPF_NEG) {
+			/* sreg is reserved and unused
+			 * dreg still need precision before this insn
+			 */
+			return 0;
+		} else if (opcode == BPF_MOV) {
 			if (BPF_SRC(insn->code) == BPF_X) {
 				/* dreg = sreg or dreg = (s8, s16, s32)sreg
 				 * dreg needs precision after this insn
-- 
2.42.0


