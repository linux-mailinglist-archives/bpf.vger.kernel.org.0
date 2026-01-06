Return-Path: <bpf+bounces-77993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50411CF9E3C
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4343198084
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0833ADB8;
	Tue,  6 Jan 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="auEtpelz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D133AD8D
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720982; cv=none; b=WySBd2GFDy+L9Y0ZA2pQmA2iPzPZxcoPLzxRjrz9vA0tDTrpV+hxlODJ3UTldD0zBmp2+3t7tEihOrQiv9inHC+S+Nk+3H76ldoNpS+iCIP2vdBcTbwahhzSSiG+KEtiw30xEhmEZ9SI+D1Gpiyf2awPT2tT+GiA3USo1sMVLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720982; c=relaxed/simple;
	bh=fo6/8+kdlZ0dFLmNumPcPKDPDCvmXdAKosj88KnESN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UThq4wamk4Ii+Ka88S+HULCADwtw2zU1+KXZyh4WT4xU7YlacaWoZHEH0RjasXbuenUAN1WZ3CvYTheq4Sdm1+7mSQc/KJUydTZn/auVEM7pB1wmoFU5XSdEdBR/T+FPjjJE0yMcx9vsYPdli6A/5qgTb/UIYPk/VJYfNoAzu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=auEtpelz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so207439666b.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767720978; x=1768325778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP9E0qysQZIRA2vm7VM8VwpeWASEBJ2dhbY3Y0RyprU=;
        b=auEtpelzHBX8/rzqtGh/pOOG2Eb4R6osmpBLoMBBqIER/47XKxjOdt3kwI2u9XLymr
         /CuZ8yMszVWrpUOAmV4o9mU5jyDb4lrVP3WE2IouWAzhvj7pjBLsEx/lBjlpti74/utw
         8CjjsSZ5aeMQbUmWgSfYnrstjuEGR2cfE1VfwfFZFIuDJlW67mpv4uftMw5rqUghFUTd
         k3jwekxXFLquvv1iJzppHcmZJ85PRYMj/yN6G1SJktR19QAGBLrZrJcFIsIh9hUc4s1W
         n8AzJDlnXCuuv533QBHIXxafru9LOzXftBg1JNFi0AhBUlGSx3ZXX7I/d67yELcBiWzX
         p6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720978; x=1768325778;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wP9E0qysQZIRA2vm7VM8VwpeWASEBJ2dhbY3Y0RyprU=;
        b=Yiv17JAXE1iN2KboslMl432iEQ+fNd+80/EnegJNqQj7R/pT9OwAle6tWH00BJSnEE
         jlewvgOl9Suqx2YmSY4Z4V91xmLrV9F5n0jyzuVKjERGQgO+Omh9LXqZBe3pniPmw3tR
         2ZyrMI1SNtExHATfhyvr36N9qnoYnqPvgGc5N4CHujpLrBYNzNFdDrBF5mmHBijBfk3y
         WMHFmxss0kZ+fhCawCST18qNq1zq9d1IuSfw6tvFlyTpLGfgUsAtj3/EPVaIkgotVGel
         esWg04oLu5yb4BtXu0rY1GYrDqgnqNY2PbH8NlDeN8LmRkYUxEQDnIDCN3SlD1jFHaDO
         E83g==
X-Forwarded-Encrypted: i=1; AJvYcCUYNOAuz+yluzCRI/kXkv3S7qONY/tAq3TZs5KnCcsxDC+LL+nA35/Yx5fKcMG3o5IZAiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94kguDA5FrrbSmbWYZBDolDxstWx3ao4ZcvzOZxyQzw0X2m5t
	EkzRV9s0mvbQCDSDY7ofrMRw9uka5VEFu3YfCDJQ4WBcparRXtFfx79/F7RsNUImBAU=
X-Gm-Gg: AY/fxX7/lAQ637jzGnzhyIvXnc1+VtWX/lxSbRqV5MTvWO+Q0/GxCMJvhgCNp2xMOdS
	sMk0A7ag1vXhbEs4hL3HAU0sNt0F8WILaSDSnrVj9DgKV2taqhksBNHs1Q6SwsxTqHCefmtCwlT
	JQ7ri96FVDwQP9VE+ii5wQ7iHF2xeUtKAwoLLsZ36UOjge8XHY/bJJz8l18QDBzikGedmaoQFaa
	3hqf7E9UGPu3RKjPbae8hYy+rGEUiQlcoY+osJPQmLJL6G9tMLmG0z9XQx5OBY+iYRoGud3ieFA
	rhA9zX6VGYzrJuJUW0CfjzqHyTGws2jHz7P201Wov9SvoVP3qJzuU0Zv/jGrcDh4XYMvtxUnrvm
	65a+Zo0qDCOtKxhMpsTX07KyUMD+RNx62nSYscxo4lSN9jLR6/ghLh1CDZ4P9jHy0KfogwivIpv
	1oS0c=
X-Google-Smtp-Source: AGHT+IGv5m5chqO7/NkQLwJTvhAjypa9+J+Q2oaCM/gLRdVDnPUP9exZPGKs9mpar/FC8P/F7/XzUA==
X-Received: by 2002:a17:907:940a:b0:b80:4032:147d with SMTP id a640c23a62f3a-b8426cb60d0mr322618966b.29.1767720978417;
        Tue, 06 Jan 2026 09:36:18 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c665sm275508866b.15.2026.01.06.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:36:17 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Martin KaFai Lau <martin.lau@kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Network Development <netdev@vger.kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Song
 Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP Singh
 <kpsingh@kernel.org>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 5 Jan 2026 18:04:28 -0800")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
	<CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
	<CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
	<e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
	<CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
	<d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev>
	<CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
	<CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
Date: Tue, 06 Jan 2026 18:36:17 +0100
Message-ID: <877btu8wz2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 06:04 PM -08, Alexei Starovoitov wrote:
> On Mon, Jan 5, 2026 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>>
>> >
>> > >
>> > > I guess we can mark such emitted call in insn_aux_data as finalized
>> > > and get_func_proto() isn't needed.
>> >
>> > It is a good idea.
>> >
>>
>> Hmm, insn_aux_data has to be marked in gen_{pro,epi}logue since this
>> is the only place we know whether the call needs fixup or not. However
>> insn_aux_data is not available yet in gen_{pro,epi}logue because we
>> haven't resized insn_aux_data.
>>
>> Can we do some hack based on the fact that calls emitted by
>> BPF_EMIT_CALL() are finalized while calls emitted by BPF_RAW_INSN()
>> most likely are not?
>> Let BPF_EMIT_CALL() mark the call insn as finalized temporarily (e.g.,
>> .off =3D 1). Then, when do_misc_fixups() encounters it just reset off to
>> 0 and don't call get_func_proto().
>
> marking inside insn via off=3D1 or whatever is an option,
> but once we remove BPF_CALL_KFUNC from gen_prologue we can
> delete add_kfunc_in_insns() altogether and replace it with
> a similar loop that does
> if (bpf_helper_call()) mark insn_aux_data.
>
> That would be a nice benefit, since add_kfunc_call() from there
> was always a bit odd, since we're adding kfuncs early before the main
> verifier pass and after, because of gen_prologue.

Thanks for all the pointers.

I understood we're looking for something like this:

---8<---
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b32ddf0f0ab3..9ccd56c04a45 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable cont=
ext */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu=
 alloc */
+	bool finalized_call; /* call holds function offset relative to __bpf_base=
_call */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ca5c5e895ee..cc737d103cdd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21806,6 +21806,14 @@ static int convert_ctx_accesses(struct bpf_verifie=
r_env *env)
 			env->prog =3D new_prog;
 			delta +=3D cnt - 1;
=20
+			/* gen_prologue emits function calls with target address
+			 * relative to __bpf_call_base. Skip patch_call_imm fixup.
+			 */
+			for (i =3D 0; i < cnt - 1; i++) {
+				if (bpf_helper_call(&env->prog->insnsi[i]))
+					env->insn_aux_data[i].finalized_call =3D true;
+			}
+
 			ret =3D add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
@@ -23412,6 +23420,9 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn =3D env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23423,6 +23434,7 @@ static int do_misc_fixups(struct bpf_verifier_env *=
env)
 			return -EFAULT;
 		}
 		insn->imm =3D fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call =3D true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1) {
 			subprogs[cur_subprog].stack_depth +=3D stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7f5bc6a505e1..53993c2c492d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn=
_buf, u32 pkt_access_flags,
 	/* ret =3D bpf_skb_pull_data(skb, 0); */
 	*insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			       BPF_FUNC_skb_pull_data);
+	*insn++ =3D BPF_EMIT_CALL(bpf_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
 	 * return TC_ACT_SHOT;
@@ -9135,11 +9134,8 @@ static int bpf_gen_ld_abs(const struct bpf_insn *ori=
g,
 	return insn - insn_buf;
 }
=20
-__bpf_kfunc_start_defs();
-
-__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
+static void bpf_skb_meta_realign(struct sk_buff *skb)
 {
-	struct sk_buff *skb =3D (typeof(skb))skb_;
 	u8 *meta_end =3D skb_metadata_end(skb);
 	u8 meta_len =3D skb_metadata_len(skb);
 	u8 *meta;
@@ -9161,14 +9157,6 @@ __bpf_kfunc void bpf_skb_meta_realign(struct __sk_bu=
ff *skb_)
 	bpf_compute_data_pointers(skb);
 }
=20
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(tc_cls_act_hidden_ids)
-BTF_ID_FLAGS(func, bpf_skb_meta_realign)
-BTF_KFUNCS_END(tc_cls_act_hidden_ids)
-
-BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
-
 static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_f=
lags,
 			       const struct bpf_prog *prog)
 {
@@ -9182,8 +9170,10 @@ static int tc_cls_act_prologue(struct bpf_insn *insn=
_buf, u32 pkt_access_flags,
 		 * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
 		 * r1 =3D r6;
 		 */
+		BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
+					  (void (*)(struct sk_buff *skb))NULL));
 		*insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
-		*insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]);
+		*insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);
 		*insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 	}
 	cnt =3D bpf_unclone_prologue(insn, pkt_access_flags, prog, TC_ACT_SHOT);

