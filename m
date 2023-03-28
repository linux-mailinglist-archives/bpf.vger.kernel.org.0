Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16956CBF96
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjC1Mqq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjC1Mqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 08:46:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97855AD17
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 05:46:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so49103220edb.13
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4q9/iwM65tb/OvTKZFpk+w9s73Eu6LVNDglMXspTfE=;
        b=l5ETRQXTbeJuN4EV4y4/9Cx2MGG4rrcK3nPnMVKXY//m55aclD75WJ7Y2VptgXva8u
         cIXUSI7sNPRkCfuZvk18XIQfmVePlhib/BJx9eFWdAi0hui5OmByQ9cD8vynPfwiVqf1
         u0sLjPbAHDvDoPddPjGv+mkQ/M5L8t6scM1g4PGizMlWLCiHzx+5GC8V+7j56339eiRK
         LI2sWq9xpwiMzvzl02OwnW4SsJAG4RqyDb0rC9ZO9VEf2fh5Xcg/3B59KnXd5Thy/voH
         WZo4fZdSD0JL2DzzJJtqImyJ4Q0OP3mfUMMwjA/vcHjawKL5nj1aI8/DQeko/47iLYDt
         X3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4q9/iwM65tb/OvTKZFpk+w9s73Eu6LVNDglMXspTfE=;
        b=PK2dRL0XR/5plWQniqK0TMxbIpWRK8m94fAcJC3rFQhDTybx3y5FfTji4DsxIxiAT+
         G4DN+4ZsXs0orBskT9vVk9D1CfHtH6zD09c1KTmHVfh9NyL/oPRoZDC8hp/zudHv0rth
         /8W4sCZOGDU49N4VMyNH/kZIfZnNQsDLuaJc/UK8GLkk34FtxWQ63OoxxinDZbCqXZHh
         WB+05c3ISfWq69AnBTKwUloOUdeUOeJ2Ixakwpy5/1YZj5ykWyeWROiXbYZOErKdoNDb
         Yid4GMriPZs8jI92+OjlPlNBHoPYvWYEZ3HfwI6Hc+IBr1ZLvOVfYMwjqmYli2sG1Qq/
         5plg==
X-Gm-Message-State: AAQBX9eHa777ljjln/idiOTZU0qy5o98iVbuZoVX2d/ySOS+NpuM4sQ7
        BgrAvPcYoftdduSn0Afli7h7ZlDIwymEFQ==
X-Google-Smtp-Source: AKy350aUJ53kqggBr2RRS1vDt7+IMhBPoWYuxw4w0GXPlxRXrElbpY02BgKjqHXWwhQ+iMQnczOJyg==
X-Received: by 2002:a17:907:2e19:b0:930:9f89:65ef with SMTP id ig25-20020a1709072e1900b009309f8965efmr14845562ejc.11.1680007560435;
        Tue, 28 Mar 2023 05:46:00 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id hy16-20020a1709068a7000b00931d3509af1sm15140326ejc.222.2023.03.28.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:45:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 28 Mar 2023 14:45:57 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v3 00/12] bpf: Support 64-bit pointers to kfuncs
Message-ID: <ZCLhhUmzeQY7amRC@krava>
References: <20230222223714.80671-1-iii@linux.ibm.com>
 <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
 <8e53174c5d5bae318a38997a7e276d7cdbccfa00.camel@linux.ibm.com>
 <CAADnVQJ9-wBrAw5+Y17Bxv4+CrLHmtkjuU143eD3fwhpQ1wvKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ9-wBrAw5+Y17Bxv4+CrLHmtkjuU143eD3fwhpQ1wvKA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 24, 2023 at 04:02:50PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 23, 2023 at 12:43 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Thu, 2023-02-23 at 09:17 -0800, Alexei Starovoitov wrote:
> > > On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > > wrote:
> > > >
> > > > v2:
> > > > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/
> > > > v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
> > > >           Drop the merged check_subprogs() cleanup.
> > > >           Adjust arm, sparc and i386 JITs.
> > > >           Fix a few portability issues in test_verifier.
> > > >           Fix a few sparc64 issues.
> > > >           Trim s390x denylist.
> > >
> > > I don't think it's a good idea to change a bunch of JITs
> > > that you cannot test just to address the s390 issue.
> > > Please figure out an approach that none of the JITs need changes.
> >
> > What level of testing for these JITs would you find acceptable?
> 
> Just find a way to avoid changing them.

hi,
sending another stub on this

the idea is to use 'func_id' in insn->imm for s390 arch and keep
other archs to use the current BPF_CALL_IMM(addr) value

this way the s390 arch is able to lookup the kfunc_desc and use
the stored kfunc address

I added insn->off to the kfunc_desc sorting, which is not needed
for !__s390__ case, but it won't hurt... we can have that separated
as well if needed

the patch below is completely untested on s390x of course, but it
does not seem to break x86 ;-)

I think we could have config option for that instead of using __s390x__

thoughts?

thanks,
jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2d8f3f639e68..b60945e135ee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2296,6 +2296,8 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
+		       u8 **func_addr);
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b297e9f60ca1..06459df0a8c0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1186,10 +1186,12 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 {
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool fixed;
 	u8 *addr;
+	int err;
 
-	*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
-	if (!*func_addr_fixed) {
+	switch (insn->src_reg) {
+	case BPF_PSEUDO_CALL:
 		/* Place-holder address till the last pass has collected
 		 * all addresses for JITed subprograms in which case we
 		 * can pick them up from prog->aux.
@@ -1201,15 +1203,28 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			addr = (u8 *)prog->aux->func[off]->bpf_func;
 		else
 			return -EINVAL;
-	} else {
+		fixed = false;
+		break;
+	case 0:
 		/* Address of a BPF helper call. Since part of the core
 		 * kernel, it's always at a fixed location. __bpf_call_base
 		 * and the helper with imm relative to it are both in core
 		 * kernel.
 		 */
 		addr = (u8 *)__bpf_call_base + imm;
+		fixed = true;
+		break;
+	case BPF_PSEUDO_KFUNC_CALL:
+		err = bpf_get_kfunc_addr(prog, imm, off, &addr);
+		if (err)
+			return err;
+		fixed = true;
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	*func_addr_fixed = fixed;
 	*func_addr = (unsigned long)addr;
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20eb2015842f..a83750542a09 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2443,6 +2443,7 @@ struct bpf_kfunc_desc {
 	u32 func_id;
 	s32 imm;
 	u16 offset;
+	unsigned long addr;
 };
 
 struct bpf_kfunc_btf {
@@ -2492,6 +2493,23 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
+int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
+		       u8 **func_addr)
+{
+#ifdef __s390x__
+	const struct bpf_kfunc_desc *desc;
+
+	desc = find_kfunc_desc(prog, func_id, offset);
+	if (!desc)
+		return -EFAULT;
+
+	*func_addr = (u8 *)desc->addr;
+#else
+	*func_addr = (u8 *)__bpf_call_base + func_id;
+#endif
+	return 0;
+}
+
 static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 					 s16 offset)
 {
@@ -2672,6 +2690,9 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
+#ifdef __s390x__
+	call_imm = func_id;
+#else
 	call_imm = BPF_CALL_IMM(addr);
 	/* Check whether or not the relative offset overflows desc->imm */
 	if ((unsigned long)(s32)call_imm != call_imm) {
@@ -2679,17 +2700,25 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			func_name);
 		return -EINVAL;
 	}
+#endif
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
 		if (err)
 			return err;
+#ifdef __s390x__
+		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, func_id);
+		if (xdp_kfunc)
+			addr = (unsigned long)xdp_kfunc;
+		/* fallback to default kfunc when not supported by netdev */
+#endif
 	}
 
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
 	desc->imm = call_imm;
 	desc->offset = offset;
+	desc->addr = addr;
 	err = btf_distill_func_proto(&env->log, desc_btf,
 				     func_proto, func_name,
 				     &desc->func_model);
@@ -2699,19 +2728,15 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	return err;
 }
 
-static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
+static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
 	const struct bpf_kfunc_desc *d1 = b;
 
-	if (d0->imm > d1->imm)
-		return 1;
-	else if (d0->imm < d1->imm)
-		return -1;
-	return 0;
+	return d0->imm - d1->imm ?: d0->offset - d1->offset;
 }
 
-static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
+static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
 {
 	struct bpf_kfunc_desc_tab *tab;
 
@@ -2720,7 +2745,7 @@ static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
 		return;
 
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm, NULL);
+	     kfunc_desc_cmp_by_imm_off, NULL);
 }
 
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
@@ -2734,13 +2759,14 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 {
 	const struct bpf_kfunc_desc desc = {
 		.imm = insn->imm,
+		.offset = insn->off,
 	};
 	const struct bpf_kfunc_desc *res;
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
 	res = bsearch(&desc, tab->descs, tab->nr_descs,
-		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
+		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
 
 	return res ? &res->func_model : NULL;
 }
@@ -17886,7 +17912,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm(env->prog);
+	sort_kfunc_descs_by_imm_off(env->prog);
 
 	return 0;
 }
