Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1964CE2F
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 17:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiLNQiY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 11:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiLNQiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 11:38:23 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBA5FDD
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:38:20 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f20so7158256lja.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdKdJaogu3SfMUkqu+uOGkLX7woyixTspG7p/fxImRA=;
        b=f7Andn54JuZj2yo//dd9TRMjkMSyNPPpZ1YZLm70+2elsclVSc3MAw98/tZaFXN4uv
         hTT0/mByN6EoE27qE/LnwKQyXy54P2lvAvxPgth9tGNqOL6M3Vwze7KKM6LEuPQNMUDI
         tElS6zgA6ubz59hNpl6No/ZNzsl68L3bFtzzS2RLdHSUTLLxuRK70Hn93HK7bfTuPMav
         Y9ASNIT7l4uV3EPsRrsDPN37Fjij5FBJJNF9wMV2zzlssK+hzCbS4S+dx9UtaXJzRcfP
         4UFVBCZbsul3EVCaPAoCOGPHtM6cYxlK9fHMXpC/h5TXvJijHKbkpa+CkB03Vs6NRi1g
         LlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdKdJaogu3SfMUkqu+uOGkLX7woyixTspG7p/fxImRA=;
        b=BehidGo4mYpm1ch6EDsQL+V+8cLR5bHwUoYsTR4tBXPUil7yqt/ra6/oGOjh75hBUB
         H1V2+8qfWrZE+NOLgwDRpbB/xDadz/pcVlgy3eK6dpqkk7eB2q6ZtAvWMwQJhmrs3wq2
         OsOMhv8YCtulGZ+BmehcdirSmA5vEwqSazok8v0SfE2sAtmuiKMQlhh4kUROjsoSRQaw
         wXXPnesq3O/nDaRUCc1fqTe/s6+ZmAkAX6RtoPowkDWAoZ9S1AJmVzcxerWHe1rUU4qN
         3Oz0EF/fkGkd9PBN70dH4G/SL0valOEDiJdFDP9lYkAJ3JaVaVpQ2MxIfvXxT2hOhN5j
         w6lA==
X-Gm-Message-State: ANoB5pmCKfLW3SLrfI0llGz6g2bRTqBEzfxiDNDqEfafZNMYFwPNxEdn
        uJbJy+XtUCnzabkytyCB/SY=
X-Google-Smtp-Source: AA0mqf6P0ZkygvI3EQsvZ+sqJG/Qid72qC4pKwlXEkkmrWzK7wrVBBFX3LYthvofnm4TwyYXZsjEwg==
X-Received: by 2002:a2e:300a:0:b0:27a:3d9d:81f5 with SMTP id w10-20020a2e300a000000b0027a3d9d81f5mr4911554ljw.5.1671035898813;
        Wed, 14 Dec 2022 08:38:18 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id t14-20020a2e8e6e000000b0026dcb07122csm646956ljk.117.2022.12.14.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:38:18 -0800 (PST)
Message-ID: <943ce05e135fae9450d2b6e0c59f50f11bf022b2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: verify states_equal()
 maintains idmap across all frames
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Date:   Wed, 14 Dec 2022 18:38:15 +0200
In-Reply-To: <CAEf4BzZ7VEdYb+qSFLnY2jkvUHEfNHtzK7WYWMKezyRcjkV=Zg@mail.gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
         <20221209135733.28851-5-eddyz87@gmail.com>
         <CAEf4BzZ7VEdYb+qSFLnY2jkvUHEfNHtzK7WYWMKezyRcjkV=Zg@mail.gmail.com>
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

On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > A test case that would erroneously pass verification if
> > verifier.c:states_equal() maintains separate register ID mappings for
> > call frames.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> It's so hard to read these tests. Moving forward, let's try adding new
> verifier tests like this using __naked functions and embedded
> assembly. With recent test loader changes ([0]), there isn't much
> that's needed, except for a few simple examples to get us started and
> perhaps __flags(BPF_F_TEST_STATE_FREQ) support. The upside is that
> using maps or global variables from assembly is now possible and easy,
> and doesn't require any custom loader support at all.
>=20
>=20
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D70271=
3&state=3D*
>=20
>=20

This is very nice, I'll try to use it for the next patch-set.
How do you think it should look like for test_verifier kind of tests?
The easiest way would be to just add new BPF sources under progs/
and have some prog_tests/verifier.c like this:

int test_verifier()
  ...
  RUN_TESTS(array_access),
  RUN_TESTS(scalar_ids)
  ...

Thus reusing the build mechanics for skeletons etc.
However, it seems to break current logical separation
between "unit" tests in test_verifier and "functional"
tests in test_progs. But this may be ok.


> >  tools/testing/selftests/bpf/verifier/calls.c | 82 ++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testi=
ng/selftests/bpf/verifier/calls.c
> > index 3193915c5ee6..bcd15b26dcee 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -2305,3 +2305,85 @@
> >         .errstr =3D "!read_ok",
> >         .result =3D REJECT,
> >  },
> > +/* Make sure that verifier.c:states_equal() considers IDs from all
> > + * frames when building 'idmap' for check_ids().
> > + */
> > +{
> > +       "calls: check_ids() across call boundary",
> > +       .insns =3D {
> > +       /* Function main() */
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > +       /* fp[-24] =3D map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NU=
LL with some ID */
> > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > +       BPF_LD_MAP_FD(BPF_REG_1,
> > +                     0),
> > +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> > +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -24),
> > +       /* fp[-32] =3D map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NU=
LL with some ID */
> > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > +       BPF_LD_MAP_FD(BPF_REG_1,
> > +                     0),
> > +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> > +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -32),
> > +       /* call foo(&fp[-24], &fp[-32])   ; both arguments have IDs in =
the current
> > +        *                                ; stack frame
> > +        */
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -24),
> > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -32),
> > +       BPF_CALL_REL(2),
> > +       /* exit 0 */
> > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > +       BPF_EXIT_INSN(),
> > +       /* Function foo()
> > +        *
> > +        * r9 =3D &frame[0].fp[-24]  ; save arguments in the callee sav=
ed registers,
> > +        * r8 =3D &frame[0].fp[-32]  ; arguments are pointers to pointe=
rs to map value
> > +        */
> > +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
> > +       /* r7 =3D ktime_get_ns() */
> > +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> > +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> > +       /* r6 =3D ktime_get_ns() */
> > +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> > +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> > +       /* if r6 > r7 goto +1      ; no new information about the state=
 is derived from
> > +        *                         ; this check, thus produced verifier=
 states differ
> > +        *                         ; only in 'insn_idx'
> > +        * r9 =3D r8
> > +        */
> > +       BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> > +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
> > +       /* r9 =3D *r9                ; verifier get's to this point via=
 two paths:
> > +        *                         ; (I) one including r9 =3D r8, verif=
ied first;
> > +        *                         ; (II) one excluding r9 =3D r8, veri=
fied next.
> > +        *                         ; After load of *r9 to r9 the frame[=
0].fp[-24].id =3D=3D r9.id.
> > +        *                         ; Suppose that checkpoint is created=
 here via path (I).
> > +        *                         ; When verifying via (II) the r9.id =
must be compared against
> > +        *                         ; frame[0].fp[-24].id, otherwise (I)=
 and (II) would be
> > +        *                         ; incorrectly deemed equivalent.
> > +        * if r9 =3D=3D 0 goto <exit>
> > +        */
> > +       BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_9, 0),
> > +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
> > +       /* r8 =3D *r8                ; read map value via r8, this is n=
ot safe
> > +        * r0 =3D *r8                ; because r8 might be not equal to=
 r9.
> > +        */
> > +       BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_8, 0),
> > +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
> > +       /* exit 0 */
> > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > +       BPF_EXIT_INSN(),
> > +       },
> > +       .flags =3D BPF_F_TEST_STATE_FREQ,
> > +       .fixup_map_hash_8b =3D { 3, 9 },
> > +       .result =3D REJECT,
> > +       .errstr =3D "R8 invalid mem access 'map_value_or_null'",
> > +       .result_unpriv =3D REJECT,
> > +       .errstr_unpriv =3D "",
> > +       .prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
> > +},
> > --
> > 2.34.1
> >=20

