Return-Path: <bpf+bounces-13604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B07DBA8B
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A925FB20FB1
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8251816426;
	Mon, 30 Oct 2023 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z9PnSkn6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C917168CD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:22:50 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9416A2;
	Mon, 30 Oct 2023 06:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dla6VXlmI9EPm/GisKeS+uvYh+VmmSOT369H8rUUSvBqhusENMatg1kATpCgXU5k5liEaUw0rVTJVZLhlY/RdiYIKv/2tl3Dv2p38S6XVhiHDDJmOSz8CcZngKjAhOV3GmMgNpN6w0UWfK0ZMAKjNdPnbhjzJbeZE3lu/EL7E+oBJB+L02UeHwCfsK/80f9mg8Vd5RY7Wm4/OfoBwC8ywsP2ZAU8fpdRxPch1+SB4lZU1twGmPIv3EZdeRRJUs4VzrwqmuvmBcTlERcXKznMczy2uQ/O97RZtIsX5oZxjiosMnIY4mujmWUax+zaY1C3Lg0F/wfLIzfa+Tau99SkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1JaIFbsxQXpTD2y87bIOS/wVTfYiIg7pmieucBTK0k=;
 b=FOBEFPzXYgMbT0Oe2kyKSmbwXkprQkJhj0+F2TfTOJqRD8q6MOWLoHIs/aPPCJLJiwmdHWlTxXAhKW3K2As2le1h4IPJzr2IkpBog8EWAZ7tjfZ+E2GuUw8fGwzS3zT3DaJX1lxF7F8fLMovlybvORWoPmhXq/vymOa4DcI6P1QVN+uhj+TGeWU27wPg1UtS6kft9qICUg5mv5BM5Pdb7adrkN5KFksAh+DSFSEs7F+mwKmodLojU2lpT/tf0mwq9ac6k8umPW35w+OJPS8Wv6qEVWJFW7MyFC+76mmCldKBp3QK36qAEBPHLYP6BoOgaTmF246e5yxv63qbSUArqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1JaIFbsxQXpTD2y87bIOS/wVTfYiIg7pmieucBTK0k=;
 b=Z9PnSkn6FIlWxjOw9FMgWMOBwpMztvhmFNP4qlALxFwXVEDwp7DzFca5wG4mll8thZp4XX2r9iXjZzbRAzBleLx/indTSz++B8a05hyCGovCQM3oW8fdrA6JR0NM+Y/Zz8XE7QSGoLIV85JxfME9gA5ZmMiXyeAdtnEOITkt38ZqeBaQ+cz5RftJUP6qlsd6v7TnpiXStrT8gV3O0cC3l/PhlDYJ+ASR04wmBOl9GHA3qGExt/Jv3mY8pd5zvO4MXHpmmN7rJodLCD80Wk7+Mkh28dQCKHEG3ROg79f4kYlt4mUR0x7l4WPcIY0xpJQbBT+iNGxfVTVhgDblWzW3Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8861.eurprd04.prod.outlook.com (2603:10a6:102:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Mon, 30 Oct
 2023 13:22:46 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 13:22:46 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andriin@fb.com>,
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
Subject: [RFC bpf 1/2] bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
Date: Mon, 30 Oct 2023 21:21:41 +0800
Message-ID: <20231030132145.20867-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030132145.20867-1-shung-hsi.yu@suse.com>
References: <20231030132145.20867-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: cc81144f-34ec-4d94-6a12-08dbd94b4e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0/p+QXFO6f6hYu1XVkteZ90++4ESDMKzevkVQpgPSz2rYlDo6DW2cgB4QURYHrWlooa3Oon9Vd/4HtuRN8ks8WOAiipAGlSJnNNvrHArgGj4Qvf0baNauav4eIM7XD+a9LNKf7xdu9h3BaLRhH9p+S+X18P1gVewV/KGfp0rn4Gi5lXp/ZfIaJjyf+5/ItzPLY7D0VngTQXwDQdPxkUFmXTf9VDEm0FFa2n0p4XDMbklpD/AwYdD2xNaxYP+laMygnuE0WV+yashkDN73qPCvDaLHnA+WWINKPmGsKXhgwzDUqCWPZmfmkzk29VNhKLOfPHj7TNJSuoaVMV1Y8RfjhcbtKHfuq4bLx2fVVgbHC3wx0ycIpjv2ikb8M5LDMloIBrsDl3qcjjazJeyc+vhoOjAsCkN3UtX4HiN13o7F+wOo32dyCUVEwD03WLYL3i5fNcnHhHvP41jEhHLFRFR44Xx/9z3N7DR6xcFPiLDKkJL4SO8sS7wZH2acb6s+EAfGw+VNqIEVwSpr7Ez65P6kM7lWQhHKMOS+0PD1pI17VYDmlkGReto9wWvWyEpmhmM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(54906003)(66556008)(66946007)(66476007)(6486002)(8676002)(8936002)(4326008)(478600001)(316002)(6916009)(38100700002)(83380400001)(86362001)(36756003)(6506007)(6512007)(6666004)(1076003)(2616005)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1dxNlJNYzk5Z3REaXVrQUNEYmtHZkljWEVwRXlta2wxdUViZitkUFlUWFNE?=
 =?utf-8?B?Z2JCL29IOHhIeitPaDEvTEU3MHJSR0hteFQ5ck9sejJyVjUrbW9JYThrOXFC?=
 =?utf-8?B?ZEFMWDgyN2hXK09VeGtjWktsbmdCdTlGZGJKQTdxYUF1Nnk2T2ZFZDRXc2h4?=
 =?utf-8?B?YVc5ZEhwaC9vSG9EekZJQTdGQlU5US9kamFaV2d3ZUw5dzdwdVpudWtReWZU?=
 =?utf-8?B?QVlLS2l2Ung2aVQ5TXBaeGNvRFkzR3NQcXZRcHlDSzc0VlpJbG11UHAyQUNN?=
 =?utf-8?B?NUs0NlJVNFkzQnNRQzgxVGpHaTVyWW54OEM0cVFCRWVlV0gzdWRDc2tEUHR3?=
 =?utf-8?B?S0N0R2d1YXlJK3A4QXg0MnZhdGlSemVhY0Juay9DRkpKdVpVWGV2L3B1YWZl?=
 =?utf-8?B?dDJVSTRhaTlPRFc5SkNsaEJnbHNSV1p5aTZ1TG9Zdlo0NDVVeHVycHdNVVho?=
 =?utf-8?B?V3Y3akVvRWM3M3ZoTk5pdVFRSVJ2d3B0bjZZSlJySnczWTRYNHZjajJxTUhE?=
 =?utf-8?B?THJ2SXYwOUlONlYyWkRIbTRVQzdlNFVwUlpqOThSMmwyRnl2NHQ2ZmxGdzJk?=
 =?utf-8?B?QXdOMytPYndUcDBBd0xLZ2MvZVMrVUMvRHl1SXBXV3VjRWs4VHJkRmI2MitM?=
 =?utf-8?B?SmVaT1NGNThnQnQyTUxIQVUxQ3hUS05KcDNhUnJ4VlFNcGZIanM1cjkzeTUy?=
 =?utf-8?B?d1ZseEdrczYrbEZqTXdGRUpJZnJmT2x3N3lQZmloNUlSUWEvNUZPZmVEYWZx?=
 =?utf-8?B?bkd1WXRPM01YNHp2bEY0anNZa2VrVjBjUVBMTHFycXNHWUIyVHJrR2F4bHlv?=
 =?utf-8?B?MTRJWjBiRThvamx2dmNENnQ2QnZZNjJueDduVmNoUGplRU5pZU0rU3ErcDl2?=
 =?utf-8?B?TU1lR3NTQVVBbFk3eGZOYmtqRUxLNC9ZZXRadDVaQmNhc0M2bk1qaENqZlYr?=
 =?utf-8?B?VmY3M21PUm00eXZPT3RPMzVwRHN3ZVRaWVRCbitMMktDeUZ4clRBRVc1Z1JS?=
 =?utf-8?B?S09EMlRoSllXWlp2blpxYzFpQkVtbk16b3RFK1ZENFkzZ0FLOE5MT3l4V1cv?=
 =?utf-8?B?TVZUdkI5N2ZSV2k0YVBudVFNWWxRcUlTSFNXbS9yZFNQREpycytkbHRCZTZD?=
 =?utf-8?B?R0h3MUR5RDJ1UUwwazVVamtwY3p2WXgySHp2Qm45ZEplMnQzdDUxOVlNaWJJ?=
 =?utf-8?B?MjlnU0RNcHN5dXZCU1o4eWd3S3B1TFpTYVR2d1B0eENYYTdGbkQxK2JoWWtH?=
 =?utf-8?B?SkMwNUE3SkdqN1ZJUFA5ZHlhb3c4QkhTNTJHVGNWK1R0RDN3SEVUUWZUR2VI?=
 =?utf-8?B?Y0F4enMwSy9rNzJER1VUOElhTWhQZFJCSDlpSU5WVHZTUkQ5TjI2b2ZIeFhs?=
 =?utf-8?B?T0xGbjk5d3RLMmE1clZHZVMyQzdtZ0ZjemJnZ2dseW55aTNvMUhhaE5YTWNi?=
 =?utf-8?B?UEdaS2oxNzlrTWoxcnlCb0wvL2xLUHJmTHJFMmdLM0RyZVRmN2pSVE9KeEhD?=
 =?utf-8?B?d3BoWlZHNW0xMlZRWEhwT3hhUjNXWHRNTy9KUUlDbmRaa2RpbGYzcjdTeGxj?=
 =?utf-8?B?a1ROa2pwRWhBVVJpMWZFclpkN0FOTVNLZWFLQnRqdGp6QXhza3VCM2hzTE50?=
 =?utf-8?B?b0N6VSs5M0gzRWVoWndHLzhENDhFK1pjb0RZaXR2ai9nMmphMVJ5b2FVZWln?=
 =?utf-8?B?cE5zN1Y1ak56b2U4eHJ6anVkOFFFMnFhZFJrdmlQRGZUYUpZMmVMQnp4K0c3?=
 =?utf-8?B?STdhR0RmL0sxV3NBZU9VcHduc0ZvL0svL1dGZlNCaTF3VlBHZC9WQU5ReUxx?=
 =?utf-8?B?SVBWWW1NMjhMNFphQUtuUWlKcURrN0hoZU5qQW80Q2QvL2duOWZxY3BGenF4?=
 =?utf-8?B?dFZPZ0wrcTNiT01zV3F5dFpyU01wdXNaMXIwT21UejI2bU1oSjZDNnRBajYr?=
 =?utf-8?B?dmhJcUNiM3FjL0ZkQ1QwS0t3WWJObFFJOGx0UThRQW01VXFVOGpZRmFNNjM3?=
 =?utf-8?B?RWJ2d2UwaldxVmlhY0lieTRxeHN5Mno0Y2ZSSXdIdWRoOXY1Yk5EbENUcjFJ?=
 =?utf-8?B?d2UvQUZEa24zYllRQmhXLzFkeW44TmRodmtqVXdMbU5SUjhCMG5XNjJFcmFB?=
 =?utf-8?B?amhoS3RmR0ZHZXFBVEVmRy9kT1l0VHJaZk9TaEdMNVcrZElWOUpOTWwzZXRo?=
 =?utf-8?B?eXB0SERuWGw2SDZIYURRa2xiMkpoYTM0N0k4N3ZNZEhYZ0lPOFN1L1ZxNm9l?=
 =?utf-8?B?UWhJUXNsVm1nc3l3Rngwa2tNemxRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc81144f-34ec-4d94-6a12-08dbd94b4e29
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 13:22:46.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVqGTs+d1dCVpMR+kR21oolhfzzdBQ70OdwcL2NeI9w/NFX+aa/GLKdJAuH9Tj1V5Cs7oB2aOlz0LxAShO2XOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861

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
correct and does not need fixing because their source bit are unset and
thus treated as the BPF_K case, this commit opt to process all BPF_NEG
and BPF_END instructions within the same if-clause so it better aligns
with current convention used in the verifier (e.g. check_alu_op).

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Cc: stable@vger.kernel.org
Reported-by: Mohamed Mahmoud <mmahmoud@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 873ade146f3d..646dc49263fd 100644
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


