Return-Path: <bpf+bounces-10391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758727A68DC
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB30281621
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48B3AC02;
	Tue, 19 Sep 2023 16:28:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FB37158
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:28:33 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C2AB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:28:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so4141627a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695140909; x=1695745709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f1AVwovpL24lJLWq2FFaf/DoCZReplBk9pHDQ5T0KMs=;
        b=TCp66mTLAitkb0DbjmlR7ZPKNCax2JfLcXBIjQLkYQYjBrY/7xtnH/4e+vEao2LBcL
         pqw1Knh5pS7QFrxf1FBR99wvVOkH1Q1uzMkhA5oQYuYQpE3CsL5pvWJv9bqJ1BDyBXVp
         5w0s2LUh3eUXB5GnyM7TJKYVI/WlPnoVP1jw6a8giGOPDKf4Tj8mmlY3agy9SV7/yrw1
         6eEiCcUbmqFGJlb/ROt4Bz+zIWXfvmn2BKkaXTXr+8o4cWA1IHRT+CvPdUSW630CtRGs
         DdjetMQ3VAvwTOSK5Q6xaWV+qxA3+qqtixWkABr7g/J6CJHkNFolDW3QjzTnNY1igj+Y
         RIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140909; x=1695745709;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1AVwovpL24lJLWq2FFaf/DoCZReplBk9pHDQ5T0KMs=;
        b=DCdoGy0cZ//os14wAWmNdbafM6sGb4IYVkWkLrnd8fP+PcYaraP9rs/BTX5chzFDL1
         jFz2tLIsVRYzmWQ584/8tcljMTidNhMW4dUoHbImXry+E3gJ/c3i/q9dO07FfdDssMo4
         3zPprPv7576icuKSwcYdU5THrKjCdm9hAJQVvPameudl92TmYpPFvuFG5k9hk14LLKcM
         479AZ2FgskOMAR2GwDYs0CEIqbglwPs3yVPUSCd3h6YnreRE96v/N82lAizWGzsANmBq
         xFWIsFDZuG1h+Qm0lPJIUhNIqW99MLZ9bBFE1PXKC0F/BuLghR0RLlTF3v8sUKJ0caC/
         itvQ==
X-Gm-Message-State: AOJu0Yy8ylfPLhL3nN9hqzwO1TDhZKHvoJGLxFTGvsX3O+OFXRaiTNC9
	avTOjuktKlVV3GzHdNpMcbQ=
X-Google-Smtp-Source: AGHT+IFn7FnR6eJP7qdF3Scnxa3siOV0S10/GObe2xuvZnCx/dCcMa2n7hu1jXgtBnizlfPhDfo9+Q==
X-Received: by 2002:a17:906:5188:b0:9a1:db97:62a1 with SMTP id y8-20020a170906518800b009a1db9762a1mr10462648ejk.46.1695140908532;
        Tue, 19 Sep 2023 09:28:28 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e7-20020a1709067e0700b0099bd0b5a2bcsm8033608ejr.101.2023.09.19.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:28:27 -0700 (PDT)
Message-ID: <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 19 Sep 2023 19:28:26 +0300
In-Reply-To: <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
References:
	  <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
	 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It looks like I hit a related but slightly different bug with bpf_iter_next=
().
Consider the following example:

    SEC("fentry/" SYS_PREFIX "sys_nanosleep")
    int num_iter_bug(const void *ctx) {
        struct bpf_iter_num it;                 // fp[-8] below
        __u64 val =3D 0;                          // fp[-16] in the below
        __u64 *ptr =3D &val;                      // r7 below
        __u64 rnd =3D bpf_get_current_pid_tgid(); // r6 below
        void *v;
   =20
        bpf_iter_num_new(&it, 0, 10);
        while ((v =3D bpf_iter_num_next(&it))) {
            rnd++;
            if (rnd =3D=3D 42) {
                ptr =3D (void*)(0xdead);
                continue;
            }
            bpf_probe_read_user(ptr, 8, (void*)(0xdeadbeef));
        }
        bpf_iter_num_destroy(&it);
        return 0;
    }

(Unfortunately, it had to be converted to assembly to avoid compiler
 clobbering loop structure, complete test case is at the end of the email).
=20
The example is not safe because of 0xdead being a possible `ptr` value.
However, currently it is marked as safe.

This happens because of states_equal() usage for iterator convergence
detection:

    static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
        ...
    	while (sl)
    		states_cnt++;
    		if (sl->state.insn_idx !=3D insn_idx)
    			goto next;
   =20
    		if (sl->state.branches)
                ...
    			if (is_iter_next_insn(env, insn_idx)) {
    				if (states_equal(env, &sl->state, cur)) {
                        ...
    					if (iter_state->iter.state =3D=3D BPF_ITER_STATE_ACTIVE)
    						goto hit;
    				}
    				goto skip_inf_loop_check;
    			}
        ...

With some additional logging I see that the following states are
considered equal:

    13: (85) call bpf_iter_num_next#59908
    ...
    at is_iter_next_insn(insn 13):
      old state:
         R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3Dfp-16 R10=3D=
fp0
         fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D000=
00000 refs=3D2
      cur state:
         R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp-8=
 R6=3D42 R7_w=3D57005
         R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) fp-=
16=3D00000000 refs=3D2
    states_equal()?: true

Note that R7=3Dfp-16 in old state vs R7_w=3D57005 in cur state.
The registers are considered equal because R7 does not have a read mark.
However read marks are not yet finalized for old state because
sl->state.branches !=3D 0. (Note: precision marks are not finalized as
well, which should be a problem, but this requires another example).

A possible fix is to add a special flag to states_equal() and
conditionally ignore logic related to liveness and precision when this
flag is set. Set this flag for is_iter_next_insn() branch above.

---

/* BTF FUNC records are not generated for kfuncs referenced
 * from inline assembly. These records are necessary for
 * libbpf to link the program. The function below is a hack
 * to ensure that BTF FUNC records are generated.
 */
void __kfunc_btf_root(void)
{
	bpf_iter_num_new(0, 0, 0);
	bpf_iter_num_next(0);
	bpf_iter_num_destroy(0);
}

SEC("fentry/" SYS_PREFIX "sys_nanosleep")
__naked int num_iter_bug(const void *ctx)
{
	asm volatile (
		// r7 =3D &fp[-16]
		// fp[-16] =3D 0
		"r7 =3D r10;"
		"r7 +=3D -16;"
		"r0 =3D 0;"
		"*(u64 *)(r7 + 0) =3D r0;"
		// r6 =3D bpf_get_current_pid_tgid()
		"call %[bpf_get_current_pid_tgid];"
		"r6 =3D r0;"
		// bpf_iter_num_new(&fp[-8], 0, 10)
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"r2 =3D 0;"
		"r3 =3D 10;"
		"call %[bpf_iter_num_new];"
		// while (bpf_iter_num_next(&fp[-8])) {
		//   r6++
		//   if (r6 !=3D 42) {
		//     r7 =3D 0xdead
		//     continue;
		//   }
		//   bpf_probe_read_user(r7, 8, 0xdeadbeef)
		// }
	"1:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_next];"
		"if r0 =3D=3D 0 goto 2f;"
		"r6 +=3D 1;"
		"if r6 !=3D 42 goto 3f;"
		"r7 =3D 0xdead;"
		"goto 1b;"
	"3:"
		"r1 =3D r7;"
		"r2 =3D 8;"
		"r3 =3D 0xdeadbeef;"
		"call %[bpf_probe_read_user];"
		"goto 1b;"
	"2:"
		// bpf_iter_num_destroy(&fp[-8])
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_destroy];"
		// return 0
		"r0 =3D 0;"
		"exit;"
		:
		: __imm(bpf_get_current_pid_tgid),
		  __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy),
		  __imm(bpf_probe_read_user)
		: __clobber_all
	);
}

