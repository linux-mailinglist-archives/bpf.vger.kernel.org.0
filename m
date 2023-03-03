Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493F6AA0F2
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 22:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCCVRY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 16:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCCVRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 16:17:20 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2D61507
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 13:17:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z42so3640339ljq.13
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677878236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ytYCypX62CV4W+hZT98/Wbwcda9oHb7moK585e6LPqQ=;
        b=Y3V1cgcH0t4aqwe8B6Qt8wZ2jbwXrjtOrOcE+xOYS6QO0jRqO8b7e2EvUTcNcPWHib
         QhQyFVG/dcGymQ6kJWKP3hUx4ujvIUXIMt1We2fnQhBZnrCa9aCeMiQYO6mDTVPdTHiK
         HGbAu9ubiAqpXS3w+5rIj5AXoNKVl/fNiDPaSoVcfo4l98Jb3mgM1iVfR3ZKVCnnjZ5U
         ehCDhxZPpxZeX945Uq+7+k6SooRS3t6oOSdlxHTxT1HPerp7suPP/Rc9s1SB1AcqK75e
         dxxITK33ADmMFWnrd2JiKRmPBUaAttioD7ZHMx4PerzllvH5Zxz7U/2/nXHjr/4Ip+5X
         GsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677878236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytYCypX62CV4W+hZT98/Wbwcda9oHb7moK585e6LPqQ=;
        b=MlVg4pBlk2627cDMW8GCoDJNTHAUqmzHN9fsOrJqoAnqGnDLRtsdf8A4fqvq/KslHQ
         MLWnvipGrKg/dKWDc5vLGYpuwFUTNujQZYyTV6aws8rPBI5SyPMXvdCTldubrDQFogN5
         woRyrbVfdKlMfgTPairTKD6TddNmFCzxGzfx8Hgcva4HRxJEUw1SThLu1WgnJTyIEOeY
         GT85HgOfphRcJbClMfUHQC7YaUC9CyWur/HZIQ8QIqHKbQPApBUExRkdfRW8LfU/d5u+
         bvgKF0aJ5uUJNoEz7vkQaUNzoFLrU3f0cIlQ0wydvikpsLYNQUJhsL43+B4emL9mGOsK
         yP7w==
X-Gm-Message-State: AO0yUKXsh09C2OyndoNXeg4Z7PVcNT0bAJD1ib+SIQy6bxMxxYmJLi7e
        4eqou7pEKxsE63/sIhqJHko=
X-Google-Smtp-Source: AK7set/MncYyKhRijj1pTCNL3FSDJaGPZjujQNqfvmW5C5fuEQIYYckndiOjUcqete89GJh5WUn2Hw==
X-Received: by 2002:a2e:9c8c:0:b0:294:6e44:91a6 with SMTP id x12-20020a2e9c8c000000b002946e4491a6mr955095lji.19.1677878236135;
        Fri, 03 Mar 2023 13:17:16 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2515a000000b004d6f86c52fcsm535909lfd.193.2023.03.03.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:17:15 -0800 (PST)
Message-ID: <bd55a7335616c78c94dd2ebfc0c8135090185954.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: allow ctx writes using BPF_ST_MEM
 instruction
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
Date:   Fri, 03 Mar 2023 23:17:13 +0200
In-Reply-To: <20230303202104.zoldj5z3m35ikkv2@MacBook-Pro-6.local>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
         <20230302225507.3413720-2-eddyz87@gmail.com>
         <20230303202104.zoldj5z3m35ikkv2@MacBook-Pro-6.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-03 at 12:21 -0800, Alexei Starovoitov wrote:
> On Fri, Mar 03, 2023 at 12:55:05AM +0200, Eduard Zingerman wrote:
> > -			prev_src_type =3D &env->insn_aux_data[env->insn_idx].ptr_type;
> > -
> > -			if (*prev_src_type =3D=3D NOT_INIT) {
> > -				/* saw a valid insn
> > -				 * dst_reg =3D *(u32 *)(src_reg + off)
> > -				 * save type to validate intersecting paths
> > -				 */
> > -				*prev_src_type =3D src_reg_type;
> > -
> > -			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
> > -				/* ABuser program is trying to use the same insn
> > -				 * dst_reg =3D *(u32*) (src_reg + off)
> > -				 * with different pointer types:
> > -				 * src_reg =3D=3D ctx in one branch and
> > -				 * src_reg =3D=3D stack|map in some other branch.
> > -				 * Reject it.
> > -				 */
> > -				verbose(env, "same insn cannot be used with different pointers\n")=
;
> > -				return -EINVAL;
>=20
> There is a merge conflict with this part.
> LDX is now handled slightly differently comparing to STX.

Merge seems not complicated, will send v2 shortly.

>=20
> > -			}
> > -
> > +			err =3D save_aux_ptr_type(env, src_reg_type);
> > +			if (err)
> > +				return err;
> >  		} else if (class =3D=3D BPF_STX) {
> > -			enum bpf_reg_type *prev_dst_type, dst_reg_type;
> > +			enum bpf_reg_type dst_reg_type;
> > =20
> >  			if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC) {
> >  				err =3D check_atomic(env, env->insn_idx, insn);
> > @@ -14712,16 +14719,12 @@ static int do_check(struct bpf_verifier_env *=
env)
> >  			if (err)
> >  				return err;
> > =20
> > -			prev_dst_type =3D &env->insn_aux_data[env->insn_idx].ptr_type;
> > -
> > -			if (*prev_dst_type =3D=3D NOT_INIT) {
> > -				*prev_dst_type =3D dst_reg_type;
> > -			} else if (reg_type_mismatch(dst_reg_type, *prev_dst_type)) {
> > -				verbose(env, "same insn cannot be used with different pointers\n")=
;
> > -				return -EINVAL;
> > -			}
> > -
> > +			err =3D save_aux_ptr_type(env, dst_reg_type);
> > +			if (err)
> > +				return err;
> >  		} else if (class =3D=3D BPF_ST) {
> > +			enum bpf_reg_type dst_reg_type;
> > +
> >  			if (BPF_MODE(insn->code) !=3D BPF_MEM ||
> >  			    insn->src_reg !=3D BPF_REG_0) {
> >  				verbose(env, "BPF_ST uses reserved fields\n");
> > @@ -14732,12 +14735,7 @@ static int do_check(struct bpf_verifier_env *e=
nv)
> >  			if (err)
> >  				return err;
> > =20
> > -			if (is_ctx_reg(env, insn->dst_reg)) {
> > -				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
> > -					insn->dst_reg,
> > -					reg_type_str(env, reg_state(env, insn->dst_reg)->type));
> > -				return -EACCES;
> > -			}
> > +			dst_reg_type =3D regs[insn->dst_reg].type;
> > =20
> >  			/* check that memory (dst_reg + off) is writeable */
> >  			err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
> > @@ -14746,6 +14744,9 @@ static int do_check(struct bpf_verifier_env *en=
v)
> >  			if (err)
> >  				return err;
> > =20
> > +			err =3D save_aux_ptr_type(env, dst_reg_type);
> > +			if (err)
> > +				return err;
> >  		} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
> >  			u8 opcode =3D BPF_OP(insn->code);
> > =20
> > @@ -15871,7 +15872,7 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
> >  			   insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_W) ||
> >  			   insn->code =3D=3D (BPF_ST | BPF_MEM | BPF_DW)) {
> >  			type =3D BPF_WRITE;
> > -			ctx_access =3D BPF_CLASS(insn->code) =3D=3D BPF_STX;
> > +			ctx_access =3D true;
>=20
> I think 'ctx_access' variable can be removed, since it will be always tru=
e.

Sorry, missed this, will remove in v2.

>=20
> >  		} else {
> >  			continue;
> >  		}
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 1d6f165923bf..8e819b8464e8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -9264,11 +9264,15 @@ static struct bpf_insn *bpf_convert_tstamp_writ=
e(const struct bpf_prog *prog,
> >  #endif
> > =20
> >  	/* <store>: skb->tstamp =3D tstamp */
> > -	*insn++ =3D BPF_STX_MEM(BPF_DW, skb_reg, value_reg,
> > -			      offsetof(struct sk_buff, tstamp));
> > +	*insn++ =3D BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
> > +			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->im=
m);
> >  	return insn;
> >  }
> > =20
> > +#define BPF_COPY_STORE(size, si, off)					\
> > +	BPF_RAW_INSN((si)->code | (size) | BPF_MEM,			\
> > +		     (si)->dst_reg, (si)->src_reg, (off), (si)->imm)
> > +
>=20
> Could you explain the "copy store" name?

I want to replicate registers, code and immediate operand from `si`,
hence the word "copy".
The more descriptive name might be `BPF_CLONE_STORE`.

> I don't understand what it means.
> It emits either STX or ST insn, right?
> Maybe BPF_EMIT_STORE ?

Can use `BPF_EMIT_STORE` one as well.=20

>=20
> >  static u32 bpf_convert_ctx_access(enum bpf_access_type type,
> >  				  const struct bpf_insn *si,
> >  				  struct bpf_insn *insn_buf,
> > @@ -9298,9 +9302,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
> > =20
> >  	case offsetof(struct __sk_buff, priority):
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -					      bpf_target_off(struct sk_buff, priority, 4,
> > -							     target_size));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_W, si,
> > +						 bpf_target_off(struct sk_buff, priority, 4,
> > +								target_size));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  					      bpf_target_off(struct sk_buff, priority, 4,
> > @@ -9331,9 +9335,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
> > =20
> >  	case offsetof(struct __sk_buff, mark):
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -					      bpf_target_off(struct sk_buff, mark, 4,
> > -							     target_size));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_W, si,
> > +						 bpf_target_off(struct sk_buff, mark, 4,
> > +								target_size));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  					      bpf_target_off(struct sk_buff, mark, 4,
> > @@ -9352,11 +9356,16 @@ static u32 bpf_convert_ctx_access(enum bpf_acce=
ss_type type,
> > =20
> >  	case offsetof(struct __sk_buff, queue_mapping):
> >  		if (type =3D=3D BPF_WRITE) {
> > -			*insn++ =3D BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
> > -			*insn++ =3D BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
> > -					      bpf_target_off(struct sk_buff,
> > -							     queue_mapping,
> > -							     2, target_size));
> > +			u32 off =3D bpf_target_off(struct sk_buff, queue_mapping, 2, target=
_size);
> > +
> > +			if (BPF_CLASS(si->code) =3D=3D BPF_ST && si->imm >=3D NO_QUEUE_MAPP=
ING) {
> > +				*insn++ =3D BPF_JMP_A(0); /* noop */
> > +				break;
> > +			}
> > +
> > +			if (BPF_CLASS(si->code) =3D=3D BPF_STX)
> > +				*insn++ =3D BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1)=
;
> > +			*insn++ =3D BPF_COPY_STORE(BPF_H, si, off);
> >  		} else {
> >  			*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
> >  					      bpf_target_off(struct sk_buff,
> > @@ -9392,8 +9401,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
> >  		off +=3D offsetof(struct sk_buff, cb);
> >  		off +=3D offsetof(struct qdisc_skb_cb, data);
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
> > -					      si->src_reg, off);
> > +			*insn++ =3D BPF_COPY_STORE(BPF_SIZE(si->code), si, off);
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_SIZE(si->code), si->dst_reg,
> >  					      si->src_reg, off);
> > @@ -9408,8 +9416,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
> >  		off +=3D offsetof(struct qdisc_skb_cb, tc_classid);
> >  		*target_size =3D 2;
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_H, si->dst_reg,
> > -					      si->src_reg, off);
> > +			*insn++ =3D BPF_COPY_STORE(BPF_H, si, off);
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg,
> >  					      si->src_reg, off);
> > @@ -9442,9 +9449,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access=
_type type,
> >  	case offsetof(struct __sk_buff, tc_index):
> >  #ifdef CONFIG_NET_SCHED
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
> > -					      bpf_target_off(struct sk_buff, tc_index, 2,
> > -							     target_size));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_H, si,
> > +						 bpf_target_off(struct sk_buff, tc_index, 2,
> > +								target_size));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
> >  					      bpf_target_off(struct sk_buff, tc_index, 2,
> > @@ -9645,8 +9652,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_t=
ype type,
> >  		BUILD_BUG_ON(sizeof_field(struct sock, sk_bound_dev_if) !=3D 4);
> > =20
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -					offsetof(struct sock, sk_bound_dev_if));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_W, si,
> > +						 offsetof(struct sock, sk_bound_dev_if));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  				      offsetof(struct sock, sk_bound_dev_if));
> > @@ -9656,8 +9663,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_t=
ype type,
> >  		BUILD_BUG_ON(sizeof_field(struct sock, sk_mark) !=3D 4);
> > =20
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -					offsetof(struct sock, sk_mark));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_W, si,
> > +						 offsetof(struct sock, sk_mark));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  				      offsetof(struct sock, sk_mark));
> > @@ -9667,8 +9674,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_t=
ype type,
> >  		BUILD_BUG_ON(sizeof_field(struct sock, sk_priority) !=3D 4);
> > =20
> >  		if (type =3D=3D BPF_WRITE)
> > -			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -					offsetof(struct sock, sk_priority));
> > +			*insn++ =3D BPF_COPY_STORE(BPF_W, si,
> > +						 offsetof(struct sock, sk_priority));
> >  		else
> >  			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  				      offsetof(struct sock, sk_priority));
> > @@ -9933,10 +9940,12 @@ static u32 xdp_convert_ctx_access(enum bpf_acce=
ss_type type,
> >  				      offsetof(S, TF));			       \
> >  		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,	       \
> >  				      si->dst_reg, offsetof(S, F));	       \
> > -		*insn++ =3D BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,	       \
> > +		*insn++ =3D BPF_RAW_INSN(SIZE | BPF_MEM | BPF_CLASS(si->code),   \
> > +				       tmp_reg, si->src_reg,		       \
>=20
> the macro didn't work here because of 'tmp_reg' ?

Yes, macro uses (si)->dst_reg in this position.
There are 11 places where this macro applies.
There are 4 places where `tmp_reg` is used for destination:
- 2 in cgroup.c
- 2 in filter.c

I opted not to add new macro to common headers (given that it has very
narrow purpose and not very descriptive name) and use BPF_RAW_INSN in
these cases.

[...]
