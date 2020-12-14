Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CC2DA0E7
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502870AbgLNTyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502847AbgLNTyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 14:54:04 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E80C061793
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:24 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ce23so24254702ejb.8
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOWpV9lRo6kWGpzmW7Fn/629/O9f1famaE6ps2CxfmY=;
        b=yWiwENx4QU1rsL4JvCTKQIL8dx7nW8cvui8kdZgYAN/di0cTwP8nrQNvwj9FYvMyCg
         WXZnZNNp2KP7kjOGFikeOy03ILkA9t80oXZypdb2cnCR4Puyw7/kAe5qITtS/vfYxo0r
         VqqRllrrYlCBG67bSb61wsOBXR5u2M3PX1kwtSdxaqnnjIem+LmXURXdndx+uN4HrLAA
         HS+978vMpySPZi+zqFPeMGRzBiwbh1ly3n8KqFnCAyuV35UeH7uomqv1MeNFyKq0On0w
         aIDYUmjiJlR1+dIpGE6m5DHF8/shPUN4VMAGNwMPHgNGhOG2LYL3D2aj2Av666LGkn9C
         Rfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOWpV9lRo6kWGpzmW7Fn/629/O9f1famaE6ps2CxfmY=;
        b=Pb3y2lEqjb0bJSlXAfP2H6VIduB4wr0YQ8Zka2Vm23KBGX4DRjCUjNBnysF1N4Atoy
         b72OmwHF2yng2qH4B+/8+V3ti/MfhxSQKZ/Uc/Rp+oZ5tJNtbhElhybYD9HBOQEQXSKx
         ptTajqmY6tRxlAnu73CeP0kUB+OsbdY31NfRyCTTqEZngYu2Un8GOOG5D/3nhJM7Dilv
         CXEhVpEFoan2dVbISrqmVDq+mxDAXzfdDJFSnyRprxOZmVYehPO12A8OGK9GLAiAHwwt
         bAQ6MI0alW/3J2XxJ0hGI++sxzB0VgTmiXO91EDBGfRl2hlw+iLIn7Z0eWrP5936e5Cu
         kSGQ==
X-Gm-Message-State: AOAM531nyOf2uRazLK/T+OLL5tEFrS89L8koh4NLu2+coPNp9xOxIwAF
        amzBGoyDDEtnrX9SELnxVUqlDSDbMtj2JlpSWUY=
X-Google-Smtp-Source: ABdhPJya+WO1A06q3q5c287jg3Do+nRKQQKaitA1xcuxYECP1exwAOyerd6Iv+tDupOrvFukdlCD7w==
X-Received: by 2002:a17:906:d152:: with SMTP id br18mr3295964ejb.297.1607975602554;
        Mon, 14 Dec 2020 11:53:22 -0800 (PST)
Received: from localhost (bba163592.alshamil.net.ae. [217.165.22.16])
        by smtp.gmail.com with ESMTPSA id w10sm14525939ejq.121.2020.12.14.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:53:22 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next 2/3] bpf: Support pointer to struct in global func args
Date:   Mon, 14 Dec 2020 23:52:49 +0400
Message-Id: <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1607973529.git.me@ubique.spb.ru>
References: <cover.1607973529.git.me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an ability to pass a pointer to a struct in arguments for a global
function. The struct may not have any pointers as it isn't possible to
verify them in a general case.

Passing a struct pointer to a global function allows to overcome the
limit on maximum number of arguments and avoid expensive and tricky
workarounds.

The implementation consists of two parts: if a global function has an
argument that is a pointer to struct then:
  1) In btf_check_func_arg_match(): check that the corresponding
register points to NULL or to a valid memory region that is large enough
to contain the struct.
  2) In btf_prepare_func_args(): set the corresponding register type to
PTR_TO_MEM_OR_NULL and its size to the size of the struct.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/btf.c             | 59 +++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 30 ++++++++++++++++++
 3 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e941fe1484e5..dbd00a7743d8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -467,6 +467,8 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
 int check_ctx_reg(struct bpf_verifier_env *env,
 		  const struct bpf_reg_state *reg, int regno);
+int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		  int regno, u32 mem_size);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8d6bdb4f4d61..0bb5ea523486 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5352,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			goto out;
 		}
 		if (btf_type_is_ptr(t)) {
-			if (reg[i + 1].type == SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a pointer\n", i + 1);
-				goto out;
-			}
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
@@ -5370,6 +5366,30 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					goto out;
 				continue;
 			}
+
+			t = btf_type_by_id(btf, t->type);
+			while (btf_type_is_modifier(t))
+				t = btf_type_by_id(btf, t->type);
+			if (btf_type_is_struct(t)) {
+				u32 mem_size;
+				const struct btf_type *ret =
+					btf_resolve_size(btf, t, &mem_size);
+
+				if (IS_ERR(ret)) {
+					bpf_log(log,
+						"unable to resolve the size of type '%s': %ld\n",
+						btf_name_by_offset(btf,
+								   t->name_off),
+						PTR_ERR(ret));
+					return -EINVAL;
+				}
+
+				if (check_mem_reg(env, &reg[i + 1], i + 1,
+						  mem_size))
+					goto out;
+
+				continue;
+			}
 		}
 		bpf_log(log, "Unrecognized arg#%d type %s\n",
 			i, btf_kind_str[BTF_INFO_KIND(t->info)]);
@@ -5471,10 +5491,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			reg[i + 1].type = SCALAR_VALUE;
 			continue;
 		}
-		if (btf_type_is_ptr(t) &&
-		    btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			reg[i + 1].type = PTR_TO_CTX;
-			continue;
+		if (btf_type_is_ptr(t)) {
+			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+				reg[i + 1].type = PTR_TO_CTX;
+				continue;
+			}
+
+			t = btf_type_by_id(btf, t->type);
+			while (btf_type_is_modifier(t))
+				t = btf_type_by_id(btf, t->type);
+			if (btf_type_is_struct(t)) {
+				const struct btf_type *ret = btf_resolve_size(
+					btf, t, &reg[i + 1].mem_size);
+
+				if (IS_ERR(ret)) {
+					const char *tname = btf_name_by_offset(
+						btf, t->name_off);
+					bpf_log(log,
+						"unable to resolve the size of type '%s': %ld\n",
+						tname, PTR_ERR(ret));
+					return -EINVAL;
+				}
+
+				reg[i + 1].type = PTR_TO_MEM_OR_NULL;
+				reg[i + 1].id = i + 1;
+
+				continue;
+			}
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_kind_str[BTF_INFO_KIND(t->info)], tname);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dee296dbc7a1..a08f85fffdb2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3886,6 +3886,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	}
 }
 
+int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		  int regno, u32 mem_size)
+{
+	if (register_is_null(reg))
+		return 0;
+
+	if (reg_type_may_be_null(reg->type)) {
+		const struct bpf_reg_state saved_reg = *reg;
+		int rv;
+
+		if (mark_ptr_not_null_reg(reg)) {
+			verbose(env, "R%d type=%s expected nullable\n", regno,
+				reg_type_str[reg->type]);
+			return -EINVAL;
+		}
+		rv = check_helper_mem_access(env, regno, mem_size, 1, NULL);
+		*reg = saved_reg;
+		return rv;
+	}
+
+	return check_helper_mem_access(env, regno, mem_size, 1, NULL);
+}
+
 /* Implementation details:
  * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
  * Two bpf_map_lookups (even with the same key) will have different reg->id.
@@ -11435,6 +11458,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
+			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+				const u32 mem_size = regs[i].mem_size;
+
+				mark_reg_known_zero(env, regs, i);
+				regs[i].mem_size = mem_size;
+				regs[i].id = i;
+			}
 		}
 	} else {
 		/* 1st arg to a function */
-- 
2.25.1

