Return-Path: <bpf+bounces-49085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26142A14279
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970C33A16A3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3945236A78;
	Thu, 16 Jan 2025 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pYXER8RK"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2026.outbound.protection.outlook.com [40.92.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66459234CE4;
	Thu, 16 Jan 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056528; cv=fail; b=Kb6x51PaVGBx8AfHp3B95WZmLaFgO8sRxB27vBAJIXKijcHCIamMnbw9SXjCx/8G3kcOCSsbMTmdrlgcy2kUJeqs/ezFX9Im3IkGpeFF5TF95klyg5ev3TvIo31jrCtMgFXuPVfoA11sVPxb0H65y6jCcugecJRkuU8RRsKDDkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056528; c=relaxed/simple;
	bh=yTQvdSOtuJcPj4ny6zc1xdoIzByebbD+8jrsXyzGG84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IV1K5Daqrj5mgaoEOLVl/FGmdoZzdZbqaZuj4F8s/Z+4/YxziM7M+AaYmtbT5b4F7VsI9HSVXxdNR8vaoXkJq/8C0WpZC0ORCree9F0jw9RH8k3FRtnq/RaNAVPokcNSRTNjk9e1LQdjwcWSQtyw8ZRwaNqNG75EdcgMa2gIuQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pYXER8RK; arc=fail smtp.client-ip=40.92.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNtzapdGchXMO7O176llssAz+/9YvqGhcaQRW0mMRLvg7KJ6ZwbHZ7yBfFiQrM0Y2cfioL0kx4Y/6ASeO1xXXSzMME/ZIgKY5RkJlzO8Mnhq4K+o8ep+sy8LJ/CcvefG5gZ3oYmDzmHFFL3RV8idO03uLy6IMqALntsw8yidXAq3HsEgcqdf7nqo0Wf3yS37RVwYdK34wJyqz5sMbR1FJJzvTW/DwQ5ExU2lZnZ57CI8qyWQJU+IOTSKgu8Qe5jozy374BX0WsqzdRs9AfoYPDdBurj0ri2oiigdr3n7lJkKCYD08vFGGE0JQB3wC0Uo4AmeEhhyKDdUCw5i9Xnpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGxmuHETQpwNYtW9+AVSXZNH5VfN43vz5MYkRkzXh94=;
 b=E6qlTrHPwngJml8bXKi9zDvm5y2J/X0OXs2nXDDz2ZTsdhFR+DzoSexHhBhrusgtcwusuENWPoNYlugMtgYj4RxQKOu+loEj3dDRu7x5+d4zUSK+5b9tlUQStugt6RV+MpPyB5oIqt6JNu31RCCC53+yCU85OyEjg7MFDq1xvad2veW86Bo+WqAVHkcLti7NWePgOOjxuymE9szTL6R975adieBosaT6u0Nn6BHYoGd3m+R0RHFmVvHvRz4UMAv4yucM+FGSvZrVtkIARWo8OfaCqEtktuUH+OPbgBDWz1lB46xlQ81wIHdB2xMi9yHNZ/XM4EiWaQa9QSH1xcCoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGxmuHETQpwNYtW9+AVSXZNH5VfN43vz5MYkRkzXh94=;
 b=pYXER8RKqoXU2k61QvYt02yADzEn+mkIEV5uhcKrunvp4eSJtMsW+FVPWmcKDve9yqOhG7SCF+5KbcBgPKwMk8B9khCjr2T9EHHU4ur/VSbFcYaERfWT56RLGWOz5vcJ8AwLvlJucT8HNUL3JsKXi74oJR+M6+Dpp5OmHmsTyWhM3aTUyCTpeG4Yw7DZN3eRcmKxzcXTc3isBFHwN7ILV5/50XmoCaOdrXk+GLTlTITUZtYTjI0+y3YB14BFvfsIs2OBQ5mAIGVdvqbEQJCMkfZZFqaT9rMvd8jQlnnS+KAL1pPHxhTk2scl9YFRr7UDcAqzqnCNzsUbbUAanL+ClA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:42:03 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:42:03 +0000
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
Subject: [RFC PATCH bpf-next 1/7] bpf: Add capability field to BTF_ID_FLAGS
Date: Thu, 16 Jan 2025 19:41:06 +0000
Message-ID:
 <AM6PR03MB508098071BC50DA59898EFD9991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 611c2115-ae97-4c2e-cdfc-08dd3665d9bb
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQowKaVx7aWRf9b2EXVRKJlixpb9KbybYeRvjszgbH2TPiV5QgSJ8uCbY8pah3QCemwVa6GoygoznUMIq/gd1yFtd9Sj4iX7pAuWRb9VWKj74Ajlq4tEOK+Oijmd2dTIyr3OPfEJ58CkN1xv8EDCx7lFZZV6UcLGdht2uGEF7kgi+QrAhjeOBvTpQpPnjq9qLWqozQ6KNW4dbNX0zrmnNOCqMPPM/l1OgGA73bQprIQzuvyAHCo5REE7CstKyBTKXRX35w2zCmzovsqBfSyPoyOdXYyD00FsbB5E3jk1EpAu2NkixOmVp4rkNa9raA0ITQtexMjIJVxe0PU5FeVmDPHMSUlWvrarypDhnxvWSjYF5NxWvrwoXXhDWL4cSj+PmVq3yaEhUhKVj/sSXvefZ6fgO/IfEe9fLM6X321Ii778We8WOVaUlnXdLqRTmAoLa2+StymLHUyXiu4eD4TxhXnHA48CW4G4BeWB4BOXgbTIZ/JGryM3w/vtBgzJ7H1Jww1OybmRG9vBWuTAcy9qMg4FViCohNFDIiBx2i45uf4h7LNU5wl6tcj1dGQlBOsRs92jjMPZZ/bVhGJQ7YhSyG3IN9FT3fi2P7pXqjMisfIkDJcNCKz5JzdqQvFLp935LlzFqB3u3Zq72WK6iZR23bAc93pukHwPOZTFOnKEpJUGcRsPcdHZL3j6+vnEz8u1pg3TfIdRIamec2/sAWr1OVZmyc+nWBjmpSEiXwV7jj8UVZjuUXEKOPNhr5ga62SIdeWnMXUqJ6J6kXaNhL+HWXT
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lEPWNHOocb3c+5KZ67VmJJeuGT9p5xTWFKcnnLa9bH+p4t4UAVbjIBhHleQr?=
 =?us-ascii?Q?QXiPoqU0514HZaskwKivXAswuxegKfKZGpM1PmO03LD3xZ+0Z1W43ENmvXV9?=
 =?us-ascii?Q?CcnZNeq0am4newCHuABOt8i/c/J4S0gztUCPPuZFjeqR8PdjRG+ZXUFMfGNq?=
 =?us-ascii?Q?pgCHGcZhM6RZUtH+Jz5iowH3UQAnNt2pzw+e2CGWMQJeNqxxC6HaGUuWyu8O?=
 =?us-ascii?Q?JRdGdRqBfv+i6m7/u5podraU0/MmdywM/p/mRTqguwY0BLkVpc7Ro2Zt7dbc?=
 =?us-ascii?Q?vpa3Iq1I1FrgsnfdT6POoO/GutHVDoiFmRD7y27MlSaHba6Re85JYM4mYL6j?=
 =?us-ascii?Q?j9ywFnCVcbvPP7YHKXoELqyi/Zk7EX8JxbNsU2QXERCP34hh89JrAqLL7SJS?=
 =?us-ascii?Q?wdms/WYEKicm7LH6fc2rk0OxzPEmFCArPvbjgkgLL0w5DC/vLmxEAG0mSS8j?=
 =?us-ascii?Q?yaMhxb9btIh/Q0UVYKMlJN3hyrSfwLEGjEfwFIhuDFIoQ+SmWKfmLxUCW1jG?=
 =?us-ascii?Q?Vk4x8Igc2z1o0GwhF1xoQWYt3oeA0NPvZr7ALhZX8WTBb05p2xcTHnqmqbcW?=
 =?us-ascii?Q?W9Ih+FfWduQfr9BfV1AW9VRJ9nc23qOaQENtl3Fepz2C4cWSvyhPy7BO2ynD?=
 =?us-ascii?Q?NxYjKAgBGJFibw2WHSvH0Z+RkARUla3UckxP7DMWNSFy7aqKo0IgdRKkO8K6?=
 =?us-ascii?Q?71YoXTMsu7G5wxObav1HPtpkNDBQX/lBLfXYT3idU0Ih30zIRsJkABX1GdjU?=
 =?us-ascii?Q?DSBVeiXkB27uw0kAV49RPDQBr5m8ADmr4tzbCVucvh19IpxTbZVKMFJyyDPO?=
 =?us-ascii?Q?7T6OPejZtv5ibSRvxiVLpPmFDXcblK5ZjcoMAbawjjG1PbIIjd1IfCgky8Sh?=
 =?us-ascii?Q?O7YVYJcrxfcwUZCy07X93iNqrUQjElZvnTNHwLhAOUmgBf0dPdnCIASqRmYC?=
 =?us-ascii?Q?7pkaUeitZopaG/PSAQ1kZNGMkaJ3SmN5XNY5RYOPZVLJ+LWLTITxVKWe6vsE?=
 =?us-ascii?Q?TfI91jF5ZIpI1XHvq+eQMQVVFFM5FCGtjWn0TbwHN1HFBts=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PiHwL0UxSJbZCgff5FACDPFhTH2B+5L1bW2MwC4RSUnVUaV0Qk17bia2RtPj?=
 =?us-ascii?Q?yJj2Th/t3nwSiZ93kuaQiUpLmueO6/5mkmF4XNScDK1rGsIdma0LL0/qKgI/?=
 =?us-ascii?Q?KXJ3yfYC+nA2rN7dSzPN6wr5lPvaPj5kF2mn3lBL7gd/dcDikdHK/8m1v462?=
 =?us-ascii?Q?Q+QNaSJJZrlPvLwSqGpgcCMfe49+ZdCBp0D3ljVlF46xnt4rVnQfYBZBMHPo?=
 =?us-ascii?Q?weC9XHjhGkFN1JZTQgMK8lMTnQaSqh/ro2+6N7Yrr+QzcKkIAtOL5M3REWyE?=
 =?us-ascii?Q?2TVj4iA4EsBnegM/y/XT8gkPl8TAq7wPaerU4rRzddRYWzqaOb+LhIdlc0+x?=
 =?us-ascii?Q?iSwvMTtGFbcRnNDcDptbqiZiMqOQsNQjg3CGz9JE+chP0oH0R42ycJtwxFDw?=
 =?us-ascii?Q?YfpmE9bfQaLzbnGmosgGQ1lngD+xFUOQnEyI5TPX7FqTBt7YVkL6tLmUDXnq?=
 =?us-ascii?Q?IlB0CE/VsJGiTwzVrWyISQTACzkojLGyyoCTUBKEIxCPXcJTOntwHTH9YD1m?=
 =?us-ascii?Q?pv47yVDJKSpB2hgPpGqnJ/lWOidjpv3OBgDZoX87EmnE7K+iZuyiDfI2O66b?=
 =?us-ascii?Q?z66L+Uq6HG44C0KqoTm8CgEqs81ExNIfdMaXJWISttOrMx+o6huowFO58jPX?=
 =?us-ascii?Q?xY80Yi6MnV0OTBrqqOUVB+bRmySPnRGHCYr8EQ90SANvOP7GHOSWcLWJna+G?=
 =?us-ascii?Q?agIqnGWLo2adJ58Q+EXT07Fq4lwXBztUW9YuSeCu/mDYaQFwriEFZnrs+wRC?=
 =?us-ascii?Q?yWeCug2L/rnBEY4/JmVrWXL/DCcLVVQiFDZTnyDzVikbIX4yW+0lGOqktCOb?=
 =?us-ascii?Q?/pc8JtUqrOLvzLPHGi1WvsmT6pPVSDssAOu2l+6j8s1H+CX4I6FiGTfvwhY8?=
 =?us-ascii?Q?uNXVYk2cv0R1gS89Jkj6ij1lH1d4737L/ewhszDQiwVz6scVYt75ulAiKQMQ?=
 =?us-ascii?Q?UnALZ3jtZ7P6NI89BSPBHQg29r6o6vOFGiv6U5hvTnTe/qh6c/cfZ8U/2lAD?=
 =?us-ascii?Q?2tFiF7QwDuATXo2wNyl3+Ec7bssE9MQufFcr/z1UuY/pJZ4zr3nO4zB1Kbps?=
 =?us-ascii?Q?WkfS751l2K9f103gS9/kU5/UswahrJPFWANbf7r4QrDx9+cWHE7Eb3DgLKk5?=
 =?us-ascii?Q?gJrGW2phCCNAX1LlZyRg/6THS1zkmcsKCneuC0GeQUapxHwnJd6ANQ5Uwp/y?=
 =?us-ascii?Q?Cqp2X6eJ2kERCVNK6FZzf5Dbb87iFlxMWeUX4lnmyhgsNCImNNl478YJl3cg?=
 =?us-ascii?Q?38jmk0LwzWPtEi+a2V2j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611c2115-ae97-4c2e-cdfc-08dd3665d9bb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:42:03.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch adds capability field to BTF_ID_FLAGS to record capability
information of each kfunc.

Note that the capability field is just a placeholder, the actual
capability value is set in btf_populate_kfunc_set_cap.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf_ids.h         | 6 +++++-
 tools/bpf/resolve_btfids/main.c | 2 +-
 tools/include/linux/btf_ids.h   | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 139bdececdcf..40231ea36058 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -19,6 +19,7 @@ struct btf_id_set8 {
 	struct {
 		u32 id;
 		u32 flags;
+		u32 capability;
 	} pairs[];
 };
 
@@ -65,7 +66,10 @@ word							\
 	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), "")
 
 #define ____BTF_ID_FLAGS(prefix, name, flags) \
-	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), ".long " #flags "\n")
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), \
+	".long " #flags "\n"				 \
+	".zero 4         \n")
+
 #define __BTF_ID_FLAGS(prefix, name, flags, ...) \
 	____BTF_ID_FLAGS(prefix, name, flags)
 #define BTF_ID_FLAGS(prefix, name, ...) \
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d47191c6e55e..48be22f9a14e 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -495,7 +495,7 @@ static int symbols_collect(struct object *obj)
 			 * that - 1.
 			 */
 			if (id) {
-				id->cnt = sym.st_size / sizeof(uint64_t) - 1;
+				id->cnt = (sym.st_size - sizeof(u32) * 2) / (sizeof(u32) * 3);
 				id->is_set8 = true;
 			}
 		/* set */
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72ea363d434d..a6c9b560b6ce 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -16,6 +16,7 @@ struct btf_id_set8 {
 	struct {
 		u32 id;
 		u32 flags;
+		u32 capability;
 	} pairs[];
 };
 
-- 
2.39.5


