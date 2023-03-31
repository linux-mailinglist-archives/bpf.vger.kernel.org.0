Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240616D2A6D
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjCaVzq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjCaVzZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 17:55:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B910C6
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 14:54:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q16so30645619lfe.10
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680299658; x=1682891658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hEPk0QvPMibuGO+SFKeRmXGJLUoYGUv2Z9sX5G6wjVs=;
        b=YBMkAj1HG5KKU5BGPj1ou8PYQNGfV/SwPeURXiFDxULt6rIhpE/0C36BG6zhMMkZw5
         /wn9axJIVEgQd1fBrreG0ULECi+KeCCAjWjAwUxq+ph6RonrrL6gMK/Sz1OV6MpApJEl
         oac/BmhxWbqXU7sbziafx8vXUP34wX1vDHg6M6BegJExSrfYk30oXu5nxMCA3YgQBW/O
         ti0xP3ulEIg7TWP+guSp1lALwSJLHUelNCITaHddMAGfAp39PewCIC2FPG6iPMAI1/Ei
         dHEXKWarLW8YXma02SO2jvzGs5biTmDn0i2yIqGj5YCOG6si7rc1YLacs+ArIMgEK5qD
         C/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299658; x=1682891658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEPk0QvPMibuGO+SFKeRmXGJLUoYGUv2Z9sX5G6wjVs=;
        b=lMmOYP4f84XMvglVnX7ERIU5tFWmnN6mhmlgHq6afgn4Q265NS12QcGPN1B6qB+L9N
         eoVQZBGM9od5nRQF+XA6/xI3Sre37u7tdsh5lp7026pYRTIWddBfLyVT/SD2UijuwG00
         AsBP0urs59rQOqfgkFTGYyYVk6NDKuXri2y0v+xW2yEf38GiHStE40gvBzU9/IdSR7B4
         H87PN40jEyUneS4gUlrmVaXtCeBByTb4Ghfh9P0ZPOwZfzy1EiRvSqhK93hqa1ALw354
         8pY8fHaPztfm//6oaRZrI36B3ik9CuvidOw/DtdpFf9FHf1uyyjO07RKZ9U1ewe+DX7S
         PT2w==
X-Gm-Message-State: AAQBX9eLw9mScI9+YbRtIQVlhZpco029jgpQmogyedeABU4sa5Wn+4On
        b0m9b72UCdDkXNpB8wfmsTk=
X-Google-Smtp-Source: AKy350YHN3JV/eXyjLbiMX+QSaN/dxThcSRRpSadKV/BnBdCsaeGCN18xu3Ciwo2K5x7vKxv+kY/sA==
X-Received: by 2002:ac2:44b0:0:b0:4b6:e494:a98d with SMTP id c16-20020ac244b0000000b004b6e494a98dmr8420301lfm.44.1680299657496;
        Fri, 31 Mar 2023 14:54:17 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b004d85f2acd8esm530390lfb.295.2023.03.31.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:54:16 -0700 (PDT)
Message-ID: <7a5563bbbb29288588413c551effa6bca90e0670.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Date:   Sat, 01 Apr 2023 00:54:15 +0300
In-Reply-To: <20230330055625.92148-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
         <20230330055625.92148-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-03-29 at 22:56 -0700, Yonghong Song wrote:
> For a loop, if loop index variable is spilled and between loop
> iterations, the only reg/spill state difference is spilled loop
> index variable, then verifier may assume an infinite loop which
> cause verification failure. In such cases, we should mark
> spilled loop index variable as precise to differentiate states
> between loop iterations.
>=20
> Since verifier is not able to accurately identify loop index
> variable, add a heuristic such that if both old reg state and
> new reg state are consts, mark old reg state as precise which
> will trigger constant value comparison later.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d070943a8ba1..d1aa2c7ae7c0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
>  		/* Both old and cur are having same slot_type */
>  		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
>  		case STACK_SPILL:
> +			/* sometime loop index variable is spilled and the spill
> +			 * is not marked as precise. If only state difference
> +			 * between two iterations are spilled loop index, the
> +			 * "infinite loop detected at insn" error will be hit.
> +			 * Mark spilled constant as precise so it went through value
> +			 * comparison.
> +			 */
> +			old_reg =3D &old->stack[spi].spilled_ptr;
> +			cur_reg =3D &cur->stack[spi].spilled_ptr;
> +			if (!old_reg->precise) {
> +				if (old_reg->type =3D=3D SCALAR_VALUE &&
> +				    cur_reg->type =3D=3D SCALAR_VALUE &&
> +				    tnum_is_const(old_reg->var_off) &&
> +				    tnum_is_const(cur_reg->var_off))
> +					old_reg->precise =3D true;
> +			}
> +
>  			/* when explored and current stack slot are both storing
>  			 * spilled registers, check that stored pointers types
>  			 * are the same as well.
> @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
>  			 * such verifier states are not equivalent.
>  			 * return false to continue verification of this path
>  			 */
> -			if (!regsafe(env, &old->stack[spi].spilled_ptr,
> -				     &cur->stack[spi].spilled_ptr, idmap))
> +			if (!regsafe(env, old_reg, cur_reg, idmap))
>  				return false;
>  			break;
>  		case STACK_DYNPTR:

Hi Yonghong,

If you are going for v2 of this patch-set, could you please consider
adding a parameter to regsafe() instead of modifying old state?
Maybe it's just me, but having old state immutable seems simpler to underst=
and.
E.g., as in the patch in the end of this email (it's a patch on top of your=
 series).

Interestingly, the version without old state modification also performs
better in veristat, although I did not analyze the reasons for this.

$ ./veristat -e file,prog,insns,states -f 'insns_pct>5' -C master-baseline.=
log modify-old.log=20
File           Program                           Insns (A)  Insns (B)  Insn=
s    (DIFF)  States (A)  States (B)  States  (DIFF)
-------------  --------------------------------  ---------  ---------  ----=
-----------  ----------  ----------  --------------
bpf_host.o     tail_handle_ipv4_from_host             3391       3738   +34=
7 (+10.23%)         231         249    +18 (+7.79%)
bpf_host.o     tail_handle_ipv6_from_host             4108       5131  +102=
3 (+24.90%)         244         278   +34 (+13.93%)
bpf_lxc.o      tail_ipv4_ct_egress                    5068       5931   +86=
3 (+17.03%)         262         291   +29 (+11.07%)
bpf_lxc.o      tail_ipv4_ct_ingress                   5088       5958   +87=
0 (+17.10%)         262         291   +29 (+11.07%)
bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5088       5958   +87=
0 (+17.10%)         262         291   +29 (+11.07%)
bpf_lxc.o      tail_ipv6_ct_egress                    4593       5239   +64=
6 (+14.06%)         194         214   +20 (+10.31%)
bpf_lxc.o      tail_ipv6_ct_ingress                   4606       5256   +65=
0 (+14.11%)         194         214   +20 (+10.31%)
bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       5256   +65=
0 (+14.11%)         194         214   +20 (+10.31%)
bpf_overlay.o  tail_rev_nodeport_lb6                  2865       4704  +183=
9 (+64.19%)         167         283  +116 (+69.46%)
loop6.bpf.o    trace_virtqueue_add_sgs               25017      29035  +401=
8 (+16.06%)         491         579   +88 (+17.92%)
loop7.bpf.o    trace_virtqueue_add_sgs               24379      28652  +427=
3 (+17.53%)         486         570   +84 (+17.28%)
-------------  --------------------------------  ---------  ---------  ----=
-----------  ----------  ----------  --------------

$ ./veristat -e file,prog,insns,states -f 'insns_pct>5' -C master-baseline.=
log do-not-modify-old.log=20
File           Program                     Insns (A)  Insns (B)  Insns    (=
DIFF)  States (A)  States (B)  States (DIFF)
-------------  --------------------------  ---------  ---------  ----------=
-----  ----------  ----------  -------------
bpf_host.o     cil_to_netdev                    5996       6296    +300 (+5=
.00%)         362         380   +18 (+4.97%)
bpf_host.o     tail_handle_ipv4_from_host       3391       3738   +347 (+10=
.23%)         231         249   +18 (+7.79%)
bpf_host.o     tail_handle_ipv6_from_host       4108       5131  +1023 (+24=
.90%)         244         278  +34 (+13.93%)
bpf_overlay.o  tail_rev_nodeport_lb6            2865       3064    +199 (+6=
.95%)         167         181   +14 (+8.38%)
loop6.bpf.o    trace_virtqueue_add_sgs         25017      29035  +4018 (+16=
.06%)         491         579  +88 (+17.92%)
loop7.bpf.o    trace_virtqueue_add_sgs         24379      28652  +4273 (+17=
.53%)         486         570  +84 (+17.28%)
-------------  --------------------------  ---------  ---------  ----------=
-----  ----------  ----------  -------------

(To do the veristat comparison I used the programs listed in tools/testing/=
selftests/bpf/veristat.cfg
 and a set of Cilium programs from git@github.com:anakryiko/cilium.git)

Thanks,
Eduard

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b189a5cf54d2..7ce0ef02d03d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14711,7 +14711,8 @@ static bool regs_exact(const struct bpf_reg_state *=
rold,
=20
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *ro=
ld,
-		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
+		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap,
+		    bool force_precise_const)
 {
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
@@ -14752,7 +14753,9 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
 			return true;
 		if (env->explore_alu_limits)
 			return false;
-		if (!rold->precise)
+		if (!rold->precise && !(force_precise_const &&
+					tnum_is_const(rold->var_off) &&
+					tnum_is_const(rcur->var_off)))
 			return true;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
@@ -14863,13 +14866,6 @@ static bool stacksafe(struct bpf_verifier_env *env=
, struct bpf_func_state *old,
 			 */
 			old_reg =3D &old->stack[spi].spilled_ptr;
 			cur_reg =3D &cur->stack[spi].spilled_ptr;
-			if (!old_reg->precise) {
-				if (old_reg->type =3D=3D SCALAR_VALUE &&
-				    cur_reg->type =3D=3D SCALAR_VALUE &&
-				    tnum_is_const(old_reg->var_off) &&
-				    tnum_is_const(cur_reg->var_off))
-					old_reg->precise =3D true;
-			}
=20
 			/* when explored and current stack slot are both storing
 			 * spilled registers, check that stored pointers types
@@ -14881,7 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
 			 * such verifier states are not equivalent.
 			 * return false to continue verification of this path
 			 */
-			if (!regsafe(env, old_reg, cur_reg, idmap))
+			if (!regsafe(env, old_reg, cur_reg, idmap, true))
 				return false;
 			break;
 		case STACK_DYNPTR:
@@ -14969,7 +14965,7 @@ static bool func_states_equal(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
=20
 	for (i =3D 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
-			     env->idmap_scratch))
+			     env->idmap_scratch, false))
 			return false;
=20
 	if (!stacksafe(env, old, cur, env->idmap_scratch))
