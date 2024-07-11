Return-Path: <bpf+bounces-34542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6F92E680
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00D1280E11
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E21649BF;
	Thu, 11 Jul 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C+hXiCQD"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011078.outbound.protection.outlook.com [52.103.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E1158DC8;
	Thu, 11 Jul 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696882; cv=fail; b=bAHXs3WaY31NYCZuNa0UjHTTLrzgJipBfPl+bnEZAJzm26OMDRVh/X5zQgMQQtozV2qBQfNXRpOo3Fmg030G523HtvFRciIh7rsXSseKkrjhgLjvfGvjxnLKDmZHgiPaUGOCZUiTST4CF5SmMRrwOmdOOH3xDClilNWfgAs77FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696882; c=relaxed/simple;
	bh=2VzsNC8RjhBFsaoETzi1HALEC+WpHCOX/RqlEcxIgQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8J8v/VqM2G4ruDVms0oOmmOH1mRmYof4PV23xBjurtk+ii7QCHluMpIubC8lqJK9YUYSYrDagPNFQ60jNQJ5LhqqD6JOLhp6Z8Nbqce5fcw2QbGQ2uzkVtH9Ly/ukBtlGujJMPEz/5S850+037ZXHBXaYWsv2tdgX6zdSUdFAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C+hXiCQD; arc=fail smtp.client-ip=52.103.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVs4z9tpDxwjuBCkEh0ATTiQcRGAurMZKR6s0okrkIFsxSoZ8nsJsLMryf7Rhma8CCd8aL12oUrqeC1Ww8JI0JFlK6kDj/8vinzVJffdyL3v0G4wJli20ojk6cQn2KTRM9EBSvgP4DhtmF9juRLeo+OGkxmpXxkDVDYFu7r7vnyD37OHD+US+umI8Zqpyuy1Nz4bf0z6Y415NMKnViQSHGWYi2CGS2dkOAk//PvzRbo4jSvuH2cEMhiE8vq9+fXj1+Bl7AIhHzi1HkPt90h8f6bzCcjaLnKiHNfoKeQMKXIz/9+4X5xGGLyNCBrWG+n10e8QpJ/CenK48Yhvi6+OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfFwhFFn2kM4OMK4kA50yiuRJuIhkfv0Ti3LY/dxRIk=;
 b=zJqpIMee04bcjABPwsgAdTBN8fU22HW/GvJZT1u+FPlTeCBFit3LV2Cb4rJW9LsrDikSevlHSvQb644q3Q8EG3u8BJwAkdc+Yj3ZLiEi+RJ3t+wgDa8CI6qCT+eeMjqFIbira53wDchaG3++iptWg8Ez6bjNjt8GVsG7I03x3mqPhpzAOdfNFvzwhtIpAkKCzKrFd+DhDFj2r7JGiyAFblJutBX5j0aoZLU6nMRK9k7QCkBwbr0bzjJAuEQzX1geMNo37lh132e1+M0LGmWGO+FwcoVwm7YQ8dOapd3CJUYSW1lgAwohUVbGLwxZ2M0LI3fS0e7vqXKsnVQHKvJ0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFwhFFn2kM4OMK4kA50yiuRJuIhkfv0Ti3LY/dxRIk=;
 b=C+hXiCQDvl6xWYOzg4zvUWWATvH5FhRsf/jWffp+uGFnKCjEuzzYtOXFFQh5CFbw7fpnSG2fxutMcZYL9BGgceHX/gYMtp4NAQ5fx1/WwLq/P8IggWWU+wvF9reyS9dKaxxzneQEC9VR6v4nK/ylZtTZP6BFe/pxNktPU9IRyHgXuZpEuDhlfS0AeG9F/1UBuy2fYrnNnfcbc15urE6aHYNkafYe40NWdJWGjZNIoJ+7s/wiSdR9NSDQyxJQSnXxG83IFiuZ1X7Y2VcbRw2O1QAqQIeS/gEJnux5pEDtnfSs+UtPiCzP/bJ8YDfTQkAr3TEPEobHK3iXvdpJhOb6rQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:21:17 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:21:17 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 02/16] bpf: Add KF_ITER_GETTER and KF_ITER_SETTER flags
Date: Thu, 11 Jul 2024 12:19:24 +0100
Message-ID:
 <AM6PR03MB5848D4913ABD926D8FD5BD8699A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HAWyuuwcuLmLvH+O5r3YDIc9jLIvz6Lq]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e45a542-d889-4cee-f4cf-08dca19b94cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	Z+M9QJdfM3Kl2ygrEklSkFSLzIljxZetfWxA/rYZe8/zz2FZooQbZji0GI4tzBek9hLDx6yEMe0iKvMY+gwunQcwh2Wxkcutef9vazFnbj5MPvjjGy5E/MgvdxR8p6XlCXvxthl1OAbGJeJXIcLByP2s9qmM6/KlRBx+wbG8/wBcrTqncQmpEXHhOmKq4SSvfdBLqOgtJRddVX3ayIVRRaMSCGm/MxXcnd0aTecrFdp7B6SozRKHqEV6QVm6NuEfu+/4JOW9jh25927vTz9FO+ElO0els2EMwi1VhW4ZYxjdVuUqt0Ax+eaYrfFtX+7ZIb3eqCoaT3hTz7seSnfK/rbCusmyZiX7xwcBdOM0dHHxmcHdsjyabUeoE6lZ4+eK3OiVQ39wqfI5ADHNN3bHPAnVDJMXXMSjPnzI3/YGQc1AlV+zi8dHcZnCLFCfmpfoagYfbFkVjYLmeYLe/hn87y5reY0PO/kRqOeTWF4z7C92NxqcrksUIgQyAlWmWCJuk4ykMHQ4551VszFnGYAliqDdgZiHeT7SwqNuJo3oKBVLxjzMFSimHtEmiAaghdGlY4OYKZmHVrPNrC9bSviQXNolh6ZoZEjZbLLRLqIC1OOUiYIn5uTif00wSaI+0oFEEYn+sE12BnVhhA6PTZd4Jg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bv0FbxNySRJrcIMvgT9XUHel3jl3ctqFAuq7DaP8bQBRuzLMOmd+t0QaHYf4?=
 =?us-ascii?Q?xrFkIcz5qpHUwm/lClDwbovipAKWS1Lvk4a2DoPYov+aSp2c1KIRfWWwQNCF?=
 =?us-ascii?Q?2ObvZ+DxpssIn9rhrhZXN6jP5XFuYZ/ai94FZT6q2kGG7yn2SaN7/u+VBQLj?=
 =?us-ascii?Q?h1p5O2KaS1mesW/Afa/L8yyRcmCRE9QzM7jQYZY7BAMiM8KSYd/eqsXZiwKL?=
 =?us-ascii?Q?FpY8UgqdKNAJCgx/D9MrJErXsSnq2hovbBMnJd6hscinBEbywYv2HZd0Qft6?=
 =?us-ascii?Q?YSMBmKLBnjPH+m3tzNgK2ubLQg0rEvqO6FuB+XR8vj2PnFqsZ0ZI8ditStC8?=
 =?us-ascii?Q?P80sDj7mFiRzhB2wEHr9MeJD0rndSDOxMaDoQhUk047fPPdvpyb1veOJhzx1?=
 =?us-ascii?Q?NXEFmNDaqj3CGF5dCwAVs/Bboq0SD1Cihod+FBGehUYu9heAS8VGT0atCmj7?=
 =?us-ascii?Q?M8TtUFh4v6BHnFi9nxd+qU7Hi9tYnSVEBVcwFgTeDefWvjWjaUokgHHvNY5H?=
 =?us-ascii?Q?j9VlJ/AUcvFTfhPTXFU4EnyPdYkGJUvH8rcNw0RkZCa5Z5DMVNa4I/SAuwSo?=
 =?us-ascii?Q?GTQefxs/UEEQyMJxCTRIL+Tv1m+MLEjIRkPJJxFTOkDotwCjg6EAThTaMv+W?=
 =?us-ascii?Q?c1jKx1GvP3ShxO70wgHJ9iBzPbrswJo38yBr7hHfndcJpaquk/TukbC1fJjC?=
 =?us-ascii?Q?shILVRtpaNQnVmF4LrAGjtLtthBgRTcl4NJYAUpXocD2wOliKBXVFTzGhl3L?=
 =?us-ascii?Q?D0M0x/GSpkHqSHRqlOlSwdvp+Be8ji/TbIlNPAQg3UjPE8gcFrKOLaa0b9ch?=
 =?us-ascii?Q?yZtZ6ray/OegGLL19NnFzCxBP9WCSzQwYMDREOsgUjuVwSCO08eO4DR7yzEu?=
 =?us-ascii?Q?3s2NsnYo8jALVnM914GuaGHKQ8i3+sHd+Qiq9ZwjWCjZVEnrIWCuv5qPanw/?=
 =?us-ascii?Q?r/U+aDI7JKPCOJWmSpwpRUO1tQB3lFgxHWI0otX8RljrlgcWbXOY1LrcAkMm?=
 =?us-ascii?Q?B8Zs6rzcbmGT0hlwT3GBX4uZR+ytfZ4hXRGbrm64lRxbxxQI9jsydasZbGvU?=
 =?us-ascii?Q?xohpiuX/Zb1GIYqpyBE/9d/mrioMSgMWFmACh2n06Odv7W1Zf3Ctt2wglcEW?=
 =?us-ascii?Q?Kx5kdCKvLYnqL8HpllD50NofmqlpBQlg4dWUsMBF+sdB1L5CRW6lUOcGh3im?=
 =?us-ascii?Q?l7O637gKq9ynQ2G0dROueICyuaL+1fvF3hg1BowupWjVn9TctxFKsxduwq8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e45a542-d889-4cee-f4cf-08dca19b94cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:21:17.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

Currently the only iterator flags are KF_ITER_NEW, KF_ITER_NEXT,
KF_ITER_DESTROY, but we cannot get the iterator status information or
change the iterator status through constructor, next method, destructor.

For example, when iterating over process files, in addition to getting
a pointer to struct file, we may also want to get the file descriptor
corresponding to struct file.

Another example is when iterating over packet data, in addition to
getting the data, we may want to change the buffer we set.

In this patch, add KF_ITER_GETTER for getting iterator status
information and KF_ITER_SETTER for changing iterator status.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h   |  4 +++-
 kernel/bpf/btf.c      | 30 +++++++++++++++++++++---------
 kernel/bpf/verifier.c |  3 ++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..323a74489562 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -70,11 +70,13 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted pointer arguments */
-/* only one of KF_ITER_{NEW,NEXT,DESTROY} could be specified per kfunc */
+/* only one of KF_ITER_{NEW,NEXT,DESTROY,GETTER,SETTER} could be specified per kfunc */
 #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_ITER_GETTER   (1 << 12) /* kfunc implements BPF iter getter */
+#define KF_ITER_SETTER   (1 << 13) /* kfunc implements BPF iter setter */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 306349ee3d6a..d053f058bd91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8054,14 +8054,15 @@ BTF_TRACING_TYPE_xxx
 static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 				 const struct btf_type *func, u32 func_flags)
 {
-	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+				  KF_ITER_GETTER | KF_ITER_SETTER);
 	const char *name, *sfx, *iter_name;
 	const struct btf_param *arg;
 	const struct btf_type *t;
 	char exp_name[128];
 	u32 nr_args;
 
-	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY} can be set */
+	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY,GETTER,SETTER} can be set */
 	if (!flags || (flags & (flags - 1)))
 		return -EINVAL;
 
@@ -8088,7 +8089,7 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (t->size == 0 || (t->size % 8))
 		return -EINVAL;
 
-	/* validate bpf_iter_<type>_{new,next,destroy}(struct bpf_iter_<type> *)
+	/* validate bpf_iter_<type>_{new,next,destroy,get,set}(struct bpf_iter_<type> *)
 	 * naming pattern
 	 */
 	iter_name = name + sizeof(ITER_PREFIX) - 1;
@@ -8096,15 +8097,25 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 		sfx = "new";
 	else if (flags & KF_ITER_NEXT)
 		sfx = "next";
-	else /* (flags & KF_ITER_DESTROY) */
+	else if (flags & KF_ITER_DESTROY)
 		sfx = "destroy";
+	else if (flags & KF_ITER_GETTER)
+		sfx = "get";
+	else /* (flags & KF_ITER_SETTER) */
+		sfx = "set";
 
 	snprintf(exp_name, sizeof(exp_name), "bpf_iter_%s_%s", iter_name, sfx);
-	if (strcmp(func_name, exp_name))
-		return -EINVAL;
+	if (flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+		if (strcmp(func_name, exp_name))
+			return -EINVAL;
+	} else { /* (flags & (KF_ITER_GETTER | KF_ITER_SETTER)) */
+		/* only check prefix */
+		if (strncmp(func_name, exp_name, strlen(exp_name)))
+			return -EINVAL;
+	}
 
-	/* only iter constructor should have extra arguments */
-	if (!(flags & KF_ITER_NEW) && nr_args != 1)
+	/* only iter constructor and setter should have extra arguments */
+	if (!(flags & (KF_ITER_NEW | KF_ITER_SETTER)) && nr_args != 1)
 		return -EINVAL;
 
 	if (flags & KF_ITER_NEXT) {
@@ -8144,7 +8155,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
 
-	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+			  KF_ITER_GETTER | KF_ITER_SETTER)) {
 		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
 		if (err)
 			return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d6306c363b7..51302a256c30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7813,7 +7813,8 @@ static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *r
 
 static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+				    KF_ITER_GETTER | KF_ITER_SETTER);
 }
 
 static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
-- 
2.39.2


