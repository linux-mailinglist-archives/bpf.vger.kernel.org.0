Return-Path: <bpf+bounces-55872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82344A8883A
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AC18994FC
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F9D27FD6B;
	Mon, 14 Apr 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3MqYTqJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1427F73A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647291; cv=none; b=KnMKrV1+47IqRnEGqdYOoozu2h2TwAOLnCGwC6I4uhQEcHZor+bx5KTD8bSfpb8JvqIvYD3EcutHzYCO91l1fR2T5aDLF65M3k0wQ38CFalqLHWL/HOu4IJLHyqavo4U6gd584neo6b3QJby7Se54kEcjSN2I6z5dJjnTqltHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647291; c=relaxed/simple;
	bh=UZqHCgr3Qem8b5CoRvgWnqKSmQi3s8YU42ScMpLy6M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHp4E40pjqi4rhS82INk1E1Bg7vAWyPmD4aumBiWn8CxhLFsPjdHSPt9wl2V4c/efgF218HEMPIEp5nCoNxle3PkBXFfGVM4k7qQdSHkH0koCvDyrsLPSFD1WcX7p6ocIWijOr90gXGBtrOEs9G/2mtv5NIGir/oKCpwIi7S3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3MqYTqJ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso35011205e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647288; x=1745252088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miqY0irivqXhuHFeGO7x7uEmo0JekINP2hUEMQE87Ec=;
        b=h3MqYTqJpKsrJmXFEe1C/UOYFX0D/IJNN80KeBVR6wCdflg1N2CmjYTzvxHUIecndT
         k55rYErzcvyced8BBriWXhUUFRjxUOjmVODlB6QardA/PAw4Lo4yhzIPFgj5RW/f7jt0
         BtXVnqrAxWIcI1LKwiEl7HcQcTi09NPcEYflu7YcZYAAEFQZXF4u4GL1zh6Al1AZqI4R
         b3U8KVNGV+9sgoZOiOI7MHvmPjkcg2gDXW9g6v3qqYHUz2XeCqmBdnNCXSc6mwOrN2Hq
         RDou5FUonBbhU7PcInMqunQLgpVeHX94Vdh8eYLypQdkcLw3HBwpi+XopY2Pbb7cuzUs
         DoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647288; x=1745252088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miqY0irivqXhuHFeGO7x7uEmo0JekINP2hUEMQE87Ec=;
        b=CFtRz0/D5SB1CFlrgpK0CW2Cy5txoGN91jWqgfLQaGg2Tpr3DXtOfAPEIBiigzb1xW
         1gktplbiw7JuO3qMoskFlHTo3TYsJldo09Hm+uiOOqihXaYppmcXR0h/WK5KvzAY7TJ9
         SU9avz30F9Zz9xcGdpLR/AWO4BvEO6KhOGNGNfmZRhaAhktHfBgsM5qVzfOFiYxPDGMq
         LS517zMX+RexWyWafHwnJ5Oaw5mDhg6BVYYNtgxSXS/Ej32LsJJc+b544WyPKBVyP7Iv
         97JOAe//dvSkUKUp3uDf/ebk7XG2tBFeBY9kpWHP+iPPlbZccbFkeM3ugRzaHuP6GouI
         /jhA==
X-Gm-Message-State: AOJu0YwEwve3tWyngj58y2Jwy4zrmk61Pp8/pgrt/LSBlOTobsqAd8mP
	eel09wZ3I1120AmTpJQV+R+eDFn2u9hV1RBdXWo5Xgjx2O7mq4U1NzyGiGR0D4A=
X-Gm-Gg: ASbGnculBXuPg5VFTfFZclnQ4lz/3len8C9s/0+wUqKuO4Lnf2PZdv/S9NQ3VNRnefa
	GvmxaWNZE16WYA3Veh7/KjU8yPkURCTzUQgy3BlgA2apaph3qIMGzEMJNK1PYzRPIG0pf7gextZ
	Ck7rLrimhzOHURDvyHSYTnJRSQL8tKXtSOvXEz1FeWfSLR7FHyeAZTjRJOdKVnA2GAt1c5qTy4m
	JUh44GGyMlfIDGomatx0yzymEFpG8mFj5QUijvQGVXHiXDgAfzVi3EQjkA4Z03PhlNUibmAOoVQ
	8LgW8vveGwyxgrbGXdRsna8BWA+Fyh8=
X-Google-Smtp-Source: AGHT+IHsopRuLD0r1Weu5qBGVf6iO4j/nemtp9D1wG3fz3n9MJXaUM+ulHZHYc4aww5TJuX5SR5/7Q==
X-Received: by 2002:a05:600c:698c:b0:43d:49eb:963f with SMTP id 5b1f17b1804b1-43f3a9a70aemr113770185e9.24.1744647287466;
        Mon, 14 Apr 2025 09:14:47 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338d802sm190094535e9.1.2025.04.14.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 02/13] bpf: Compare dynptr_id in regsafe
Date: Mon, 14 Apr 2025 09:14:32 -0700
Message-ID: <20250414161443.1146103-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; h=from:subject; bh=UZqHCgr3Qem8b5CoRvgWnqKSmQi3s8YU42ScMpLy6M4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOIeVXF+4Wy4klk9nnaPlHm6RGNU2DZchEov8cJ vUtBJqGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziAAKCRBM4MiGSL8RynSeEA C8VX1yxV3odYEsXouZi/UnbKLVI5urg3NBEoITqYxbl10DsWsrNMtkHsh8xMy4c/FtuQ3VRqZFuwW2 JyVBz6u4GV4PzsueTpsh1P3KYWXYi5JJr6Vor06sbL4/AwtbKVc4l8c7tmQ/pweJ1srIw1ildgsQRt 7WHPOGXEE3QLbQ71w/TQKeT5X6m9AaQeaQNRaJ3RZT/WwXkDcTJzYTbEb2i/LrjwWbTBu8BjBOk1QV rja05Si4QCypX1BshoK70mRJfN1/V0kgbotQkLtUojay+kl1ib9UofSm/sYekpJ4xX3SL8kVg5vNuo kT8Zau4Oo20KQoUYcyFOyG64CAFs0Gdru1/GqPEpP/mmLlUWBHBb6Zesx0x7IjqFLirfAHr191d5V+ oHNKwCKVPaT8805EHilvAwNPURto5eFrvLhbJ628gZ8YhEmtByS2gqenulSnOsJ1PIEVXsKVWvaR/n 5PALKhHuISnrEZoEtOcj+ufOu0LZXi70o9wPwkOrK1z+CVyT/Pfuh/AukHFOihhUfowHpVM8SyHC27 UCLskaBWeeCSC1imfhJ8jfcX//cEoGepKg/1QESaOkq7NAHdCmOMAdlMhEV7uCvYNVgAB9a9myBmdF 0hbb24OcaDSV7wBDnoW2pxiCfiD6l/HGLISkb9bufVn9KBJyeD9Ewq7dl+tA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Now that PTR_TO_MEM can be invalidated due to skb going away, we must
take care to be more careful in regsafe regarding state pruning. While
ref_obj_id comparison will ensure that incorrect pruning is prevented,
since we attach ref_obj_id of skb to the PTR_TO_MEM emanating from it,
it is nonetheless clearer to also compare the dynptr_id as well.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a62dfab9aea6..7e09c4592038 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18426,6 +18426,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
+		       (base_type(rold->type) == PTR_TO_MEM ?
+			check_ids(rold->dynptr_id, rcur->dynptr_id, idmap) : 1) &&
 		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
-- 
2.47.1


