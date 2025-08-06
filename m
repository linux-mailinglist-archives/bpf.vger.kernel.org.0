Return-Path: <bpf+bounces-65152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09620B1CD3A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065747A55D0
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513792C326B;
	Wed,  6 Aug 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8fuUZi+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8A2BEC3C
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510981; cv=none; b=dk8czKVCgSxeyC6KOo5GC1peCg5gQJsIXAeP3vjqSDn/zz8cDP6jEn6paeFkeDTX3JWZdXP4PXWuBhr/19ClS50olRQfFDoazOyQRPKxV2Xe5alBTiHPN0WQV4fagTNc2ZYmXejbRW6DYD8a5ZmrQDtlv7wRaw5LJTzzQCEHzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510981; c=relaxed/simple;
	bh=ezta6JwwyJC5oL7EKaGTbkrxfvzulqtpndBVeq0HIpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVcadSvmCsEDWBwi8U0ABVLB6VgxCm5PLE+PuiocPc9DfPiErT4R+ngkGqQVUMbaPhG9AAtQ5gvnWrhPBwGZM5TfipGsZUrTRd0uSfLwt/kv9kL2YZEoSAhQwl0PZOeiGyj9cffoMMwPgt8zIJVRiReXrVlupVDZz5Mp/4UBuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8fuUZi+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2406fe901fcso2389325ad.3
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510979; x=1755115779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADx9h7D1a6KncarGDyZh6MheRVoQxKCsejxYjj3D/P8=;
        b=f8fuUZi+0jmCfzF+oNgybulSQqusGPNUqv+xV/wlKpd7rGG3HZD/Bm1Cri9PrACNQ3
         vk3qQkDXjMHtreVQTn+ycSphR9cWomlWm9wtGOONSaVsHki9MtmsIzNe7DyofhBjOFpu
         +IOpvKCkXTw4uCNiyuOggpYqVYD2Nze/4cemnfXXyBrjz/bp2t4kokCp0miHf80QLerp
         j3eD/9GOd+7Rgx7cMLfUoI/UYhTDLJ1nnDr8g6KIFjJDbPHZHqgpcoxbbHv1VXfUfgL7
         4n/8W0HbJjwcx5zex5wNeYvZbkDaBPAIG5rr0choDgtvW1ymWNf28GGQEA2hCEexM/8Q
         CVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510979; x=1755115779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADx9h7D1a6KncarGDyZh6MheRVoQxKCsejxYjj3D/P8=;
        b=EdAAj/U45mm5AG1NgWlvdpiapOb2G7smBJdloZqNwc0u44OFLb2Ol9v8ewrpSQXulT
         AjFeUZqpfHwXaCUMz2kMmDqLd+4hJk+zIhiZYbPM4w6vr/lZR0rMXG88l05kXdwWru4c
         N+SWm2gA5iJYtAS4EmnCKUK0Vm1pweD5vA/e6q/7CcqvwE49L0xDiPycwHujmRy7N8gd
         +XL+dEemDM1qkuheaZeuoOZawAGxFPNf/pPOYaFyqalBzXkD7/c27XqWJX/Ln3IjSNM9
         axWZqj4Wyn98GXLrCzbWrLzgQJZuaKaplNUa59NLEJKpnXWwRRZ/L3V3LKD7TZ+ZtRDV
         Ncqw==
X-Gm-Message-State: AOJu0YzQxzLprEKDdjWHk/XIQ3mUJWhd8XaBemm537PEAz3c2hLRa5RG
	1ewrVozu3pZrJLiXlQY2ckp9zCVLnTwU72jlDPORaCF3WxbKO15BB7m6gxr/j0bL
X-Gm-Gg: ASbGncsfPmhswjnaG+I4Vf8tLLdxLP1rYxaSxNF4S7WJyO0CYSqSLZv35oTRFCMgD6U
	UdmIyl9ZcVqJPjJwPF63L4CFekWU5zXGmZrloIkoBBJUUQWhOBq6e6tgKV4mIVY5TUhXsR1UkZ8
	bnLZ6kK0Qe1GnkaIjEU5nAwB+C1tNISHQOdg7anYYaEzcAVHyl3j457IX00sDbfzNCH4N3kR4cB
	cgP68ysINqWgQNbzfmwShlk2o/ftaU4Velm2eiO0R2z+WkGZttpTX7HhsVr6MKUjwHSh0oI5u5s
	6HXtOvj5YDpeUABzD7BUuC7E2zRIYoCQ6q488MRXwsRs0IMMUn7jl2+Z2gb2GZdXojKfVMEmZhb
	aCxrWXlLQRp4nxPKVEdGT5WPALxUoEpnkBBd5vY8VGtyp
X-Google-Smtp-Source: AGHT+IEeHsetmFZ2Kn/SNQgQ4YHbyeE4YRapsDNPhjTT1RDeHmJox7AriVhWhCUPY1a5ZmlXvBb7Fg==
X-Received: by 2002:a17:903:908:b0:234:9cdd:ffd5 with SMTP id d9443c01a7336-242a0ad07ddmr47740815ad.25.1754510979353;
        Wed, 06 Aug 2025 13:09:39 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef595esm165032665ad.13.2025.08.06.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:09:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 2/2] bpf: use realloc in bpf_patch_insn_data
Date: Wed,  6 Aug 2025 13:09:28 -0700
Message-ID: <20250806200928.3080531-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806200928.3080531-1-eddyz87@gmail.com>
References: <20250806200928.3080531-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid excessive vzalloc/vfree calls when patching instructions in
do_misc_fixups(). bpf_patch_insn_data() uses vzalloc to allocate new
memory for env->insn_aux_data for each patch as follows:

  struct bpf_prog *bpf_patch_insn_data(env, ...)
  {
    ...
    new_data = vzalloc(... O(program size) ...);
    ...
    adjust_insn_aux_data(env, new_data, ...);
    ...
  }

  void adjust_insn_aux_data(env, new_data, ...)
  {
    ...
    memcpy(new_data, env->insn_aux_data);
    vfree(env->insn_aux_data);
    env->insn_aux_data = new_data;
    ...
  }

The vzalloc/vfree pair is hot in perf report collected for e.g.
pyperf180 test case. It can be replaced with a call to vrealloc in a
hope to reduce the number of actual memory allocations.

This is a stop-gap solution, as bpf_patch_insn_data is still hot in
the profile. More comprehansive solutions had been discussed before
e.g. as in [1].

Perf stat w/o this patch:

  $ perf stat -B --all-kernel -r10 -- ./veristat -q pyperf180.bpf.o
    ...
           2201.25 msec task-clock                       #    0.973 CPUs utilized               ( +-  2.20% )
               188      context-switches                 #   85.406 /sec                        ( +-  9.29% )
                15      cpu-migrations                   #    6.814 /sec                        ( +-  5.64% )
                 5      page-faults                      #    2.271 /sec                        ( +-  3.27% )
        4315057974      instructions                     #    1.28  insn per cycle
                                                  #    0.33  stalled cycles per insn     ( +-  0.03% )
        3366141387      cycles                           #    1.529 GHz                         ( +-  0.21% )
        1420810964      stalled-cycles-frontend          #   42.21% frontend cycles idle        ( +-  0.23% )
        1049956791      branches                         #  476.981 M/sec                       ( +-  0.03% )
          60591781      branch-misses                    #    5.77% of all branches             ( +-  0.07% )

            2.2632 +- 0.0527 seconds time elapsed  ( +-  2.33% )

Perf stat with this patch:

           1132.77 msec task-clock                       #    0.976 CPUs utilized               ( +-  3.47% )
                80      context-switches                 #   70.623 /sec                        ( +- 31.57% )
                 1      cpu-migrations                   #    0.883 /sec                        ( +- 37.27% )
                 5      page-faults                      #    4.414 /sec                        ( +-  3.59% )
        3307816503      instructions                     #    2.20  insn per cycle
                                                  #    0.15  stalled cycles per insn     ( +-  0.05% )
        1506171011      cycles                           #    1.330 GHz                         ( +-  0.55% )
         488914539      stalled-cycles-frontend          #   32.46% frontend cycles idle        ( +-  0.94% )
         729783557      branches                         #  644.246 M/sec                       ( +-  0.05% )
          17312298      branch-misses                    #    2.37% of all branches             ( +-  0.23% )

            1.1602 +- 0.0443 seconds time elapsed  ( +-  3.82% )

[1] https://lore.kernel.org/bpf/CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=5w+ppRWWiYSGvQ@mail.gmail.com/

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69eb2b5c2218..6ef7dc6079a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20699,12 +20699,11 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_insn_aux_data *new_data,
 				 struct bpf_prog *new_prog, u32 off, u32 cnt)
 {
-	struct bpf_insn_aux_data *old_data = env->insn_aux_data;
+	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
-	u32 old_seen = old_data[off].seen;
+	u32 old_seen = data[off].seen;
 	u32 prog_len;
 	int i;
 
@@ -20712,22 +20711,19 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
 	 * original insn at old prog.
 	 */
-	old_data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
+	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
 
 	if (cnt == 1)
 		return;
 	prog_len = new_prog->len;
 
-	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
-	memcpy(new_data + off + cnt - 1, old_data + off,
-	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
+	memmove(data + off + cnt - 1, data + off,
+		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
 	for (i = off; i < off + cnt - 1; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
-		new_data[i].seen = old_seen;
-		new_data[i].zext_dst = insn_has_def32(insn + i);
+		data[i].seen = old_seen;
+		data[i].zext_dst = insn_has_def32(insn + i);
 	}
-	env->insn_aux_data = new_data;
-	vfree(old_data);
 }
 
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
@@ -20765,10 +20761,14 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	struct bpf_insn_aux_data *new_data = NULL;
 
 	if (len > 1) {
-		new_data = vzalloc(array_size(env->prog->len + len - 1,
-					      sizeof(struct bpf_insn_aux_data)));
+		new_data = vrealloc(env->insn_aux_data,
+				    array_size(env->prog->len + len - 1,
+					       sizeof(struct bpf_insn_aux_data)),
+				    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 		if (!new_data)
 			return NULL;
+
+		env->insn_aux_data = new_data;
 	}
 
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
@@ -20780,7 +20780,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		vfree(new_data);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_data, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
-- 
2.47.3


