Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707FE62EB72
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiKRB5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiKRB5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:17 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F8742F4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:16 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g62so3523020pfb.10
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0TBqBybCrP7H73ygmD/bqXm75De09U/u6313JRic9Q=;
        b=ly6oGWyeamGD94MN0GSQG+tznYN9qUVkds/1KUt6ck1j4VYviw7hQpkvsGeO+6I5RC
         jwyR/j0a9ag6omB+qPl5HZ2OadC8aHfA6iwjPr0g42mXzZvVESfzgQeVI3hRMlIfMnfA
         VQuMDTkCSGzR3+mB9Zi8qLw/GoGF0nq7JOeOjBO8UFew0PZ7F2v44QL8dMTAjsimtsxq
         Q1ZPxBS1TiSkkpK16cK9tbAIeajhQjTDbBnIf7oF8WuqzEO3mKPSSgiVG0TyEy2tz1sy
         m9KcQhywK56uQwsZlFHklDbP1H51Ofnq78Rmn3/LcCAZQs0Gdm45IBLvAOORy6fUcBVU
         Lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0TBqBybCrP7H73ygmD/bqXm75De09U/u6313JRic9Q=;
        b=bxMAEoySF6TorRI/rGS2OUnv4SCGvovNLlJg3A/OXAu/WJTs55kLQIUYZPvTFW8/Tl
         akd8SCVXkm1swDc0U+qJLhyWTnU/ZbyheDhe90e6FaeAdS4zL4JRN0TbxE7VHhjx82hO
         Ke2q0ZTZ6A0zr4oGB3uc2yAwLL0bjEdLIgWJRllfH6f8vpUJ6sgr8SjjXMcwxYPlsPH0
         qfCV2nGrxhfj7amyuoC/uH8n3LIgyucwxRYn6FUTTox/eKnlH1Urvv9iY9JY0DGbirAS
         U8r1ppjbfU6xnapCCCzj/axcn5x9IueSxoyG3C6sDy1RgOhJj/89Cuw+CPPdbG2e+YjQ
         +jgg==
X-Gm-Message-State: ANoB5pku0p48+wtZs55PDBeq6Q9LQWaV2yG9qTA5Gm4gvyVBiLJOAley
        Kj6R4zb76UmRKEUcsKtCESchFK6Ny0k=
X-Google-Smtp-Source: AA0mqf4m1VpEkuK84rEDO+Fey0V7WHhOFE67nltn/vXLVO6Kz+lHyVQVYCZfNXIJy+9+76BcRbXJOw==
X-Received: by 2002:a05:6a00:e89:b0:56b:e64c:5c7e with SMTP id bo9-20020a056a000e8900b0056be64c5c7emr5595813pfb.18.1668736635565;
        Thu, 17 Nov 2022 17:57:15 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0017849a2b56asm2188801plh.46.2022.11.17.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:15 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 17/24] bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
Date:   Fri, 18 Nov 2022 07:26:07 +0530
Message-Id: <20221118015614.2013203-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5501; i=memxor@gmail.com; h=from:subject; bh=sShnKY3A2vDVp4q3DwqCQuH5YnkdT9OcDGOomuId1HQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXP4roW2PEfsiXSVtKrCLVtFbkGjexwZ8j1/0BX IH1m98aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8Ryth/D/ 4paUdkU5qasVzoxEDfp3PpUD9d3F+lcaHRCkGjZ5UVQkFXlOmdvpX70GLOjrTnGX52Dqf6+Eqd6LaV pcAOqwBdw1CIBp5z8+UhMWb+ltoVeWt0A+z6mdZ46nbLYgwB18S/qm+SQFeBv2PPCbtW2HiYKdG02x jysGgSp80A/4Bk4EODW69wkK8XzlLk3jmZBfzz7wrxtw4f+dicFaKL/sWh/e/nj/jsEQAAHyjQvuhh 1w8O0OVIBfJu0FtJJiRW4f1nFzGLgoudWzZE7FdPk6amSOWDU7UKmUSDsOwClRsdTbyFCMaZTfmPTh ueIUGTk0iPZiBFOT3RXYaJNk4J7aLo0TG7ZKHx+9b5mJj3sR6cgdbi4myEir5krnketX4pa3lZOaiQ 2bQQR5b8i2zene6ulAvGZJsA+Zy70PP6B+2faNBj4D/h/4mrN+NCo0I8t4PaX/XoJ/OAhDkW/zGa0A ZDDkF309Onw0W1APa8iftXXV91tz2LNR/ADPsF+jnlcEdoBqnQ1XOoYdStpX8Y0rYT1t6hfISY2y+U 4w03OP6MzyZxxZZJ8jLTPiHMs0kQGNRG5veDuQgtJt8KchaP0d4sNd9IlkZpQkftGX+e1kGpWaLVy2 kpyrPVoq40uQ+Axt88m/Ql0x+h6xp0PheT0VpNUEfGjOlrDAOHUFrQ5SbIyA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit implements the delayed release logic for bpf_list_push_front
and bpf_list_push_back.

Once a node has been added to the list, it's pointer changes to
PTR_UNTRUSTED. However, it is only released once the lock protecting the
list is unlocked. For such PTR_TO_BTF_ID | MEM_ALLOC with PTR_UNTRUSTED
set but an active ref_obj_id, it is still permitted to read them as long
as the lock is held. Writing to them is not allowed.

This allows having read access to push items we no longer own until we
release the lock guarding the list, allowing a little more flexibility
when working with these APIs.

Note that enabling write support has fairly tricky interactions with
what happens inside the critical section. Just as an example, currently,
bpf_obj_drop is not permitted, but if it were, being able to write to
the PTR_UNTRUSTED pointer while the object gets released back to the
memory allocator would violate safety properties we wish to guarantee
(i.e. not crashing the kernel). The memory could be reused for a
different type in the BPF program or even in the kernel as it gets
eventually kfree'd.

Not enabling bpf_obj_drop inside the critical section would appear to
prevent all of the above, but that is more of an artifical limitation
right now. Since the write support is tangled with how we handle
potential aliasing of nodes inside the critical section that may or may
not be part of the list anymore, it has been deferred to a future patch.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 ++++
 kernel/bpf/verifier.c        | 58 +++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3dc72d396dfc..23f30c685f28 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -223,6 +223,11 @@ struct bpf_reference_state {
 	 * exiting a callback function.
 	 */
 	int callback_ref;
+	/* Mark the reference state to release the registers sharing the same id
+	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
+	 * safe to access inside the critical section).
+	 */
+	bool release_on_unlock;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 00d3122086c2..7f10b21f2dfc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5652,7 +5652,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			cur->active_lock.ptr = btf;
 		cur->active_lock.id = reg->id;
 	} else {
+		struct bpf_func_state *fstate = cur_func(env);
 		void *ptr;
+		int i;
 
 		if (map)
 			ptr = map;
@@ -5670,6 +5672,23 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		}
 		cur->active_lock.ptr = NULL;
 		cur->active_lock.id = 0;
+
+		for (i = 0; i < fstate->acquired_refs; i++) {
+			int err;
+
+			/* Complain on error because this reference state cannot
+			 * be freed before this point, as bpf_spin_lock critical
+			 * section does not allow functions that release the
+			 * allocated object immediately.
+			 */
+			if (!fstate->refs[i].release_on_unlock)
+				continue;
+			err = release_reference(env, fstate->refs[i].id);
+			if (err) {
+				verbose(env, "failed to release release_on_unlock reference");
+				return err;
+			}
+		}
 	}
 	return 0;
 }
@@ -8260,6 +8279,42 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
+{
+	struct bpf_func_state *state = cur_func(env);
+	struct bpf_reg_state *reg;
+	int i;
+
+	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
+	 * subprogs, no global functions. This means that the references would
+	 * not be released inside the critical section but they may be added to
+	 * the reference state, and the acquired_refs are never copied out for a
+	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
+	 * critical sections.
+	 */
+	if (!ref_obj_id) {
+		verbose(env, "verifier internal error: ref_obj_id is zero for release_on_unlock\n");
+		return -EFAULT;
+	}
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].id == ref_obj_id) {
+			if (state->refs[i].release_on_unlock) {
+				verbose(env, "verifier internal error: expected false release_on_unlock");
+				return -EFAULT;
+			}
+			state->refs[i].release_on_unlock = true;
+			/* Now mark everyone sharing same ref_obj_id as untrusted */
+			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+				if (reg->ref_obj_id == ref_obj_id)
+					reg->type |= PTR_UNTRUSTED;
+			}));
+			return 0;
+		}
+	}
+	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
+	return -EFAULT;
+}
+
 /* Implementation details:
  *
  * Each register points to some region of memory, which we define as an
@@ -8433,7 +8488,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 			btf_name_by_offset(field->list_head.btf, et->name_off));
 		return -EINVAL;
 	}
-	return 0;
+	/* Set arg#1 for expiration after unlock */
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
 
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
-- 
2.38.1

