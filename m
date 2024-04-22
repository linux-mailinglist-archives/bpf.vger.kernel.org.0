Return-Path: <bpf+bounces-27352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125208AC54B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED97282CC3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA453384;
	Mon, 22 Apr 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHn3HXH2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEF4B5CD;
	Mon, 22 Apr 2024 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770195; cv=none; b=MpgbN9UH022/U8Y0etB/hRIxWZKDa7lXhcHbnWLfdtxCrQ5lFQ5aTynpdJj2x5fPcpPWP67iygHrKIVusmoXG+7G0S6JPYgVpwqoWTA0GhqggIiih+C3n8BtiGHClxHXf1KDDARG14XhQNXTLMuBIOE5RS8+izFO209hM8ZB/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770195; c=relaxed/simple;
	bh=NfAfxY4XqZehCfrVo6N7fe6sz8Rh1GXdjQSYW+wwx44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ld6RmEiBhx1AVGw7rtMB+tp9+wj+MGLyjYQ3dX0pDoDTFuPTLTMr3nH8fIEEpm/ZxRE1epK8DCxusBKO2kl6iyBD2X4f7ACGIWz7UgpzEp+LrtmsLRCeaot6jKOPuLeWUvy0Km1vq5r6AC8/9fPzCK+xkgj3u7cQSuXPU72i/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHn3HXH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A6AC113CC;
	Mon, 22 Apr 2024 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770195;
	bh=NfAfxY4XqZehCfrVo6N7fe6sz8Rh1GXdjQSYW+wwx44=;
	h=From:Date:Subject:To:Cc:From;
	b=DHn3HXH2eCN2Mb4w2HpzvQHTeCkLsaR/+ccsCUzukakQ4Tq82aKmoFrqyui3aEsdi
	 tvm+AmP4HXZpsCiZLs4Bv/xzQ1EYRcFF0grrqjysrb528ZfaUQ5dQpM0ca0InUsY9Y
	 j4h1Xe28vB7M1l7Fz7RCmMR4bSIU+Zf+zbfS9s37g+jh/5HzDUZul17XGJamEmOw6+
	 ib+TGfN2Bv4JpQO6QLPze5WOWj/VnJ+5vpjeRtTb0mh+Oz3WZeaTFxEJFbBOl0GGX2
	 COfNVMUDcIF5ypOY+aIXByE6TeSdkQV/zQN/IMQ8GYkhVLTsEq4wWPt71WQROb5Jy0
	 AhjPz237m8Bdw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 22 Apr 2024 09:16:28 +0200
Subject: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMsOJmYC/x3MQQqDMBBG4avIrBuIISB4lVJkkv6NA6JhBsQiu
 XtDl9/ivZsMKjCah5sUp5gce8f4GCivvBc4eXdT8CH6GIKzDaicNiysyt+l6lHMwWc/pXHKnBL
 1tio+cv2/z1drP7hSVYdnAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770191; l=1344;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=NfAfxY4XqZehCfrVo6N7fe6sz8Rh1GXdjQSYW+wwx44=;
 b=BOoh+3TwqNJ3VgIIKuFS0X05BWosUogOThOQNNnoxXo2ZDKy2YK8wSwezXl2YpCCvtTMDFrbv
 nV7g17D1owCCy/3fLmUPTxsHFWWflmCJJ5mxb/Lhwb5Vqj5dSIfPKc1
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Arrays of progs are underlying using regular arrays, but they can only
be updated from a syscall.
Therefore, they should be safe to use while in a sleepable context.

This is required to be able to call bpf_tail_call() from a sleepable
tracing bpf program.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Hi,

a small patch to allow to have:

```
SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
{
	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);

	return 0;
}
```

This should allow me to add bpf hooks to functions that communicate with
the hardware.

Cheers,
Benjamin
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68cfd6fc6ad4..880b32795136 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18171,6 +18171,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
+		case BPF_MAP_TYPE_PROG_ARRAY:
 			break;
 		default:
 			verbose(env,

---
base-commit: 735f5b8a7ccf383e50d76f7d1c25769eee474812
change-id: 20240422-sleepable_array_progs-e0c07b17cabb

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


