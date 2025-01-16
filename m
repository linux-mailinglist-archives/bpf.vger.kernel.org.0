Return-Path: <bpf+bounces-49091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C3CA14295
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD893A231D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F022E41C;
	Thu, 16 Jan 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VF5Z4Kj8"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2042.outbound.protection.outlook.com [40.92.58.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDB18FC8F;
	Thu, 16 Jan 2025 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056827; cv=fail; b=ULQkWwiJc3hU+mZDsx7XsD/YzOFeBR3lszStEEjhyzz43KnvkBEbLxvbTc6MadIiK2iUxxJ+aWkHSMGAo2ZMIN5w9PgyS4JG5STO7QAxITW1ZYvMFrX+jPgksx1C3v6WdKzxzYbNs+oRCRMbmaw53tQ55KBWJb3+jVv1zeqvtsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056827; c=relaxed/simple;
	bh=h/yO9mzimRtH0uPK0V4jx5i2zzSQi8FD0DauO9EDAMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXEcx3VFcGYk5cyquOxtYc/bFW3CI7kadM1/n93vUGesTXxt1DIs/8HDHP/orNHR9SMv7ttVCvWqGvfaJw7KSsNThtxZW5sJQsNavzgMOBf9xsdA1AOfoysVVmzig3faxMicj74ClOALS8Nv7tFt0PdHf4/chhpcm1tYUKM6P88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VF5Z4Kj8; arc=fail smtp.client-ip=40.92.58.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngCR2FXKFHtqiJbrap1tEY+9a43Lsp7doE73ckcuFuouMcYXEzZwSWbrjMiu0Slja3cV4RnrV9jeP8H/afM8D7QvubShGPjaPpFPQ3UQVxPnGPCw2/HCTZuM/kdHP3DAy8MkIT5LHw/xZdtHBKffeefbeey/bEBSTgGtYl8jf1IX4dlFIH2tw12GNNvRbdCgwZN0NDInurgs3E43jfBsucTu2k2Ro8FBgnpImLoEzzaL0nqdZyu4hpA5DRlu2sZTql5dTdmajJ7tNb5zO+BYtEvpOsqngWi2Wet2H4NA6MbrGFT3H4vKO2re/IxIX6B6RMD7KG7QpLKERNeuNgnX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAi8EqhndCSzb6lqFAf7g3rU5YiypcIsgiRlRo9eF5w=;
 b=dur9/jYuHO3kggjpY36xMPsZ5/7EMqz2lL2/3pd6AmMA0tdxGYVWcTCex+4yZTbGGhRTtEAtNHF81cZ1Q+xljyo/791+dRPWo7FwXH5aKTWXt+Rww1Dw1RTH6EQPdLxgCS0QrB06mXBzy/I9pbyMKJ//sWxxrDWcAU5mevVrz2LMMnGR+71V56nHGVmnGWlBYecTSAQxztFb65bAOhhCb/TcVctbq1P4LMj1cjGunZVofnUY+Au84mPv3uilu6SM8LiBo2n9YhlrQuEm8A/ZjQFv8sazu5lb1V8iHir0Ku5eCBHDFYXnGNnZ6ljy/zmlUl4id0Q4s70zRcpeXUuKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAi8EqhndCSzb6lqFAf7g3rU5YiypcIsgiRlRo9eF5w=;
 b=VF5Z4Kj8LAMSF5v394pdC7y6f+dpUgOLYcPwhxOb3azCeSGZwJd4CbaF8viXwR2AlkCTUSbCl5rnKQB6Hc/gzduKoggTxmB2kooMyfK0VWLKL1TURZG5mazJi0SHVy/2dz60tH35UhV5tdiB8qlNJ3FuNbVnwz/VitV9k/iQYrZbgngU4LT2Z0dZAcOZs8aLt+FfI14gfnJSuPSrT/CLC37UuRMTOvHUKtphD05rMbxCb0HU3IcXNs5lzIFRO/993Lh/GFWxYkhhjbYbT88PwsL8vH1CQI6mS32EWlFYa1ScRNWSMfx4kl8gqi9j8bTXvZrqBJTk+MdUaXz2uj7OYg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:47:02 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:47:00 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
Date: Thu, 16 Jan 2025 19:41:11 +0000
Message-ID:
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-6-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: cd326940-f1cd-48a0-9c28-08dd36668afd
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwU46ctkesNAQSdI89rGQphJV0Vp+aV5YQnTXSmvWD3oESLrA0oPkVumYcW+fPl4RfaHXr1HVIModBzlDINeRapXZ6ohk4e2CHXxx8YtecRO9Iufa3N+edvlW5SYlD00e8DdCIAXCthxzEWEdQr6VHxkvFgn//CBMDyXotgQ1JIVlSxbmoFUiE6/lcon1ZNNOs/Pq75Y/O5NSSQt2PHA/tFXJl/8pAfG9qpJXXVpYmzXmeS/3dhgRVALEXJCNSdz7o7v6WogSgQm5Ue6JVbIrL4HX+r4ogrtw9WPdmVhSFSqgDRF+GO7GypUP13B0tW3d/Mgm3rA8Et6mH+PL1qh6fSYlLq/RrZF5Z946OY3OwIwxnPf90v5d9gPOYrvoa5Q+vbbRiA8QwpbshI43JKdEIFdcOsZ8iDzzBNudde5TmNL7idLyvMboWtxf7IN8NlpzQLY3lbWvtaOssfPGI3Im25+ZxlD2oxgIFtb7BbDMq7fcmVZqVcVnX2zA6+eeDm/PcmSj6yyYAaJscmbfBjJ9/RmA87TeoTG6iqmGqFrBrStPbfhQjrffa208qU9ysrvoKVabp3bfkhka0JVYwZqdy2ync2x+fIYp/XbDEKQZ+P/2rND8mkrpUbMP50rng+bYvm7J7rRtrxQSgEm1H9bpu9EpQ+8FkURikhgNoEkB10d6yYWNvCYjEYzznfhENObs0VZ2eeozFWYFsNWvqp33Gq496NiAoEAyaTEF4bZ+6ZkZ9/qW4NXimC/LGUdTFUOUcU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmiOiaOPlpAQPZPzDbmQa5hnvKRvg9kIkOZX7llf7wDirddua9wpAxqtXY9Q?=
 =?us-ascii?Q?/9dkRfr4KfB8szNRPpp31FXvVUsu/+a0ogJZjVQlsKR1KztYNHlwcRYGyGlf?=
 =?us-ascii?Q?1irtW32qk08AwJUgoJck3/yWhoy3362MjoWviteOUGC8VsKMKDEs6gtzi5fk?=
 =?us-ascii?Q?D0q0rbA4D3oL8vy0RUyXA6+OrmvdzInH4dSKOCMWJ7v5s3wf9BWbTj9P3s8o?=
 =?us-ascii?Q?A+Pwj0GfqXFjxE20NEA2AHM5Gugpt8k3YIplurMCEbfQiOyEu2TGsGWMxbKW?=
 =?us-ascii?Q?wi/YWuiufcV5LDnfeiWyWwEVcZd5ELKWUxLYUdZPOsRasRTLE+qpEZ/bAIcB?=
 =?us-ascii?Q?Tio5ejMc3YPS2hkC/XwPjm5H7qhZWI7xV2voR1pNjOZW6k4ktcIWopZF2qMe?=
 =?us-ascii?Q?dPGVLiwI8hM3uIvLJpWDbJHs7kNxPy7/EWitkqfXFCOk/MQ/N4c9VbNgbHQd?=
 =?us-ascii?Q?cXJRBigrG0Ms/HkAcr6R7+agP3ZRgjkC6mdCSCL09IEqUIlSqlRZh4xR9PeO?=
 =?us-ascii?Q?PR4amF64HFROXsNANDG0u0JyVp4y/k/FSf+o4E/obqt0O2UziTz5lMzDSFrx?=
 =?us-ascii?Q?ZBnrUZElwuGT44WbRq6gEzzu6pTjt7HRumcVo3AVaHCCF338gp1tg7VCTTfp?=
 =?us-ascii?Q?iBXlgaLppQ4ofMi3L4NyhJVw6RKnkd8ZdCWV4oyu7BbIviRLYOqJrhqTTSSc?=
 =?us-ascii?Q?hBDWbI9dYH4YkhQjVO+Xga89F/mZ2vT1L6PKhYYnIZIY4tJ548Gmi61AEZCv?=
 =?us-ascii?Q?2ZPzQEzlmSzgeyoUWMCEAo0PAQF8yzz2S26gU3iuVargy0eQqBgvN51hT/E6?=
 =?us-ascii?Q?rI5AT8TMr9Eo03WOaP5bYVecSb9oqkWxB8ITdEjJN/Uvn79IQHnqVPxW65is?=
 =?us-ascii?Q?wPq4DJ2OCQq+/Coz7OP9X7COXBKM+cPOYVukItz+Vr0USThPn78lpPnTgOzj?=
 =?us-ascii?Q?q8Wen/Aa1xlMjybOopVKVlRVv4COvTuUDMX31qLF/h+BNWl8UdtQSR4jc3ms?=
 =?us-ascii?Q?zsJmJN5ZmPv2cGI1QnDlj/xRNeDEf1X+MHLSLQH5eVQgbNOGdsremWmWRery?=
 =?us-ascii?Q?/NaY8pKpJYi5uGDyJicgqzWyYA5dzA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdQ7pumU4WLSN1TEOwudtPjZLsHbFhxfwfnkwx6iJ50IprBlTlUcLCkYAo1G?=
 =?us-ascii?Q?w74h0XBmn4x8jGkDANvIJjYW0VWGkbmltxnx/AHUfMsu6rWbRPiSRsbIW3QJ?=
 =?us-ascii?Q?rRV56KTwjSC6nCWp8Mo6AfoD1VCV+PRkbjiWtolSwU6hmxtdwnd/XbhR5WDx?=
 =?us-ascii?Q?7e94ywsgL4IcZ1HYutmhj5wAoo/GSoP1f/vjW/dOKTYQ0vSmZhXgSRd1QehT?=
 =?us-ascii?Q?eprZwGlEL1+Ma650NOZgAXERgbbKlWXB5WKt+zW2039jmoPqwGijPJH486UW?=
 =?us-ascii?Q?3oYmPwEDQ01cPtmyZZyyK9dgaseOIvUxeHwjhI9xk+kEI0QKMfMN+AURDVdX?=
 =?us-ascii?Q?/ccRLgsr/PTLTOR05z/N/XIcOlTrRt2be8JmnWSjZ8Xa0DBilbQZU0ssCCHm?=
 =?us-ascii?Q?J0trTr9TX6d4s/sH/YIIU/kBCjMDwQyWar8laMhKFocpAgA1CcjuhnrEieJ4?=
 =?us-ascii?Q?mnrxXI1dn0o2Y5VVX7XK63wuJguCx8L1D/dKWZlyEVEJXbGtxoqQMvvC4b5+?=
 =?us-ascii?Q?FJhgQAECMjYBShVf7a0dDyrKx8N8/0B4Ci2lWTspaGbNvoHS1FIMz+p8ySac?=
 =?us-ascii?Q?4fR99l4munKPMPqtAtZBGffFsQFT353t3FEHKJL36szJLze/hnzPdGZOncRk?=
 =?us-ascii?Q?tku8n7TUdjVZuawLRkkxEracHe64lBsgoL8YjgLvibFJxnz1zX5dUEiERO/y?=
 =?us-ascii?Q?5tNKInp61wgQroEQeTWh4bWYlskhvBwV6Ib2dgz9yVQkE/yUZCeorp2MQXbZ?=
 =?us-ascii?Q?8JO1Q2cXgPeaiNc5VUGuvZfI6bz7XV92HVvCWjGDT63OUmObAM0AoUg6lVhz?=
 =?us-ascii?Q?h92kr0PuKWNiNcHMcVcJ6QzCeCGn9ly9y1RDAj2zM2hjhtz26k3DobKFF+nh?=
 =?us-ascii?Q?uhNBC/RbITNPqm3+egNDdhM1f2qU9zc7YhIOmR8X3OFv8AevFx/KHdeHw5Uu?=
 =?us-ascii?Q?H0/QPvGIQUKsWh6ckxb00BooBb8weUoYmsS5EKoMnDkL/DiKk+nnMOYau95x?=
 =?us-ascii?Q?KUH5BXBhidymLQiGfVh6RzWg2OQ/jTFATs1Z9WYjQJzxPhMDd+efMB405LYs?=
 =?us-ascii?Q?NnVKLoA4X3HWr7RjjE3r+jRt/6shF2AP8be/lN1hLrTEujT9iwn+h8ujgefA?=
 =?us-ascii?Q?Cv+TzVuffEUHrMjHv3a3mIxXNSsU0sQeWUgKNnO76Jlbk/WOMnWKYyVtaFe2?=
 =?us-ascii?Q?GAo78dOsDGlcKvlmAHXtKNasTCghI3Paccvuj6VFM35A453z5oIh5C3Ade2R?=
 =?us-ascii?Q?9c8owH2tH8b17tX/go7O?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd326940-f1cd-48a0-9c28-08dd36668afd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:47:00.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch modifies SCX to use BPF capabilities.

Make all SCX kfuncs register to BPF capabilities instead of
BPF_PROG_TYPE_STRUCT_OPS.

Add bpf_scx_bpf_capabilities_adjust as bpf_capabilities_adjust
callback function.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 74 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fff1d045477..53cc7c3ed80b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5765,10 +5765,66 @@ bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabilities,
+					   u32 context_info, bool enter)
+{
+	if (enter) {
+		switch (context_info) {
+		case offsetof(struct sched_ext_ops, select_cpu):
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
+			break;
+		case offsetof(struct sched_ext_ops, enqueue):
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
+			break;
+		case offsetof(struct sched_ext_ops, dispatch):
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_DISPATCH);
+			break;
+		case offsetof(struct sched_ext_ops, running):
+		case offsetof(struct sched_ext_ops, stopping):
+		case offsetof(struct sched_ext_ops, enable):
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_REST);
+			break;
+		case offsetof(struct sched_ext_ops, init):
+		case offsetof(struct sched_ext_ops, exit):
+			ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_UNLOCKED);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		switch (context_info) {
+		case offsetof(struct sched_ext_ops, select_cpu):
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
+			break;
+		case offsetof(struct sched_ext_ops, enqueue):
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
+			break;
+		case offsetof(struct sched_ext_ops, dispatch):
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_DISPATCH);
+			break;
+		case offsetof(struct sched_ext_ops, running):
+		case offsetof(struct sched_ext_ops, stopping):
+		case offsetof(struct sched_ext_ops, enable):
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_REST);
+			break;
+		case offsetof(struct sched_ext_ops, init):
+		case offsetof(struct sched_ext_ops, exit):
+			DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_UNLOCKED);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
 	.get_func_proto = bpf_scx_get_func_proto,
 	.is_valid_access = bpf_scx_is_valid_access,
 	.btf_struct_access = bpf_scx_btf_struct_access,
+	.bpf_capabilities_adjust = bpf_scx_bpf_capabilities_adjust
 };
 
 static int bpf_scx_init_member(const struct btf_type *t,
@@ -7596,23 +7652,17 @@ static int __init scx_init(void)
 	 * them. For now, register them the same and make each kfunc explicitly
 	 * check using scx_kf_allowed().
 	 */
-	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+	if ((ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_KF_SELECT_CPU,
 					     &scx_kfunc_set_select_cpu)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+	    (ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_KF_ENQUEUE,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+	    (ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_KF_DISPATCH,
 					     &scx_kfunc_set_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+	    (ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_KF_CPU_RELEASE,
 					     &scx_kfunc_set_cpu_release)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_unlocked)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+	    (ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_KF_UNLOCKED,
 					     &scx_kfunc_set_unlocked)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_any)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-					     &scx_kfunc_set_any)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+	    (ret = register_btf_kfunc_id_set_cap(BPF_CAP_SCX_ANY,
 					     &scx_kfunc_set_any))) {
 		pr_err("sched_ext: Failed to register kfunc sets (%d)\n", ret);
 		return ret;
-- 
2.39.5


