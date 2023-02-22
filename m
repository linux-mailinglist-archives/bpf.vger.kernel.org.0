Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836569F7C4
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjBVP3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjBVP26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 10:28:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAA2B29F
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 07:28:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ee7so16836090edb.2
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i38xkA2hqxg0YJ86fYPq5VTBa5PbX+ROzB+VYqTDc/s=;
        b=jHVwb2oReiUdgvhYdP7MWQy/dOvmUznFYd2DwZZ/uHNgxX4IDuWhqpuT/sKaH7hJOd
         JthchwV/M4Gqay1AS0j7WxAc/jCtvlyQvCN3Vf0c78xegJewJR41TlsDE13kBN8rP2Pq
         jVEXpzfEFt5OTvcFQ4S+pfMu9vFzGFboSjqmtQ0WkF5brWrGYM4JR9NKZZ5cnb9cBsFO
         3Y8euxVLUHWGYyPhJM/vKJoC9N4E3yeOiFKGcvRC0YeCKDtqC0UWNOTDmKMMRm0haByl
         On+n3gQtvwD2JHQmF8GbEIi2YLci/OoO4Si8rNEZgFvTm/DL1nT0rWznCQKVVjNkGWE4
         4zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i38xkA2hqxg0YJ86fYPq5VTBa5PbX+ROzB+VYqTDc/s=;
        b=0SL1/bJW5UsJKi0puCHzXterzO3ufDH3u2SleuB615ERk4bhZFSsQTgZEJDMX84pJx
         PkzEpQjsFGilBHAUjLtcrqTF9njUEU2TUtRz6vCiYgV9QfZh9obFEuo7jnUxg2jWXHDC
         0TB6ZMc8nVZPLRnAMXcZ6RiduCupJQpiXfFjlZU/rK0q9oc6nW9KabIWwcm/xln9Pm90
         GGid+o9I6iG5ZqlbPeb1QGVC71byNjXKyF1ErO3REtcE1uGFRQSzVzh/5T3K4DmgsoLm
         25ny1cC+UFM0xPr0ViikPbYJmSu/4enPnZQTGa7EnpcZVpxrd/8ID5youmLdq8Pydjcq
         Wzvg==
X-Gm-Message-State: AO0yUKXzeVyF8/bfBOqXEKXY2i/p1VNDucFnzRPRkLk5k9l8CyUCLRmN
        h5mrI6JZO16fGupsjuhquRg0Qr69is7sig==
X-Google-Smtp-Source: AK7set+FRbIABfdvvZJtPCh9ECeVyTpKxvkql87CbM+i9LeXCdCKtiN296P+DOcirFKERJ4GNC60YA==
X-Received: by 2002:a17:907:7255:b0:880:3129:d84a with SMTP id ds21-20020a170907725500b008803129d84amr19084318ejc.60.1677079733816;
        Wed, 22 Feb 2023 07:28:53 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906199500b008e34bcd7940sm1615773ejd.132.2023.02.22.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:28:53 -0800 (PST)
Message-ID: <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org
Date:   Wed, 22 Feb 2023 17:28:52 +0200
In-Reply-To: <Y/P1yxAuV6Wj3A0K@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
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

On Mon, 2023-02-20 at 22:35 +0000, Matt Bobrowski wrote:
> Hello!
>=20
> Whilst in the midst of testing a v5.19 to v6.1 kernel upgrade, we
> happened to notice that one of our sleepable LSM based eBPF programs
> was failing to load on the newer v6.1 kernel. Using the below trivial
> eBPF program as our reproducer:
>=20
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>=20
> char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
>=20
> SEC("lsm.s/bprm_committed_creds")
> int BPF_PROG(dbg, struct linux_binprm *bprm)
> {
> 	char buf[64] =3D {0};
> 	bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 	return 0;
> }
>=20
> The verifier emits the following error message when attempting to load
> the above eBPF program:
>=20
> -- BEGIN PROG LOAD LOG --
> reg type unsupported for arg#0 function dbg#5
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> 0: (79) r1 =3D *(u64 *)(r1 +0)
> func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 137293 type STRUCT 'l=
inux_binprm'
> 1: R1_w=3Dptr_linux_binprm(off=3D0,imm=3D0)
> 1: (b7) r2 =3D 0                        ; R2_w=3D0
> ; char buf[64] =3D {0};
> [...]
> ; bpf_ima_file_hash(bprm->file, buf, 64);
> 10: (79) r1 =3D *(u64 *)(r1 +64)        ; R1_w=3Dptr_file(off=3D0,imm=3D0=
)
> 11: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> ;=20
> 12: (07) r2 +=3D -64                    ; R2_w=3Dfp-64
> ; bpf_ima_file_hash(bprm->file, buf, 64);
> 13: (b7) r3 =3D 64                      ; R3_w=3D64
> 14: (85) call bpf_ima_file_hash#193
> cannot access ptr member next with moff 0 in struct llist_node with off 0=
 size 1
> R1 is of type file but file is expected
> processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0
> -- END PROG LOAD LOG --
>=20
> What particularly strikes out at me is the following 2 lines returned
> in the error message:
>=20
> cannot access ptr member next with moff 0 in struct llist_node with off 0=
 size 1
> R1 is of type file but file is expected

Hi Matt,

I tried your program as a ./test_progs test using v6.1 kernel and
don't see any error messages:

VERIFIER LOG:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
func#0 @0
reg type unsupported for arg#0 function dbg#5
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
; int BPF_PROG(dbg, struct linux_binprm *bprm)
0: (79) r1 =3D *(u64 *)(r1 +0)
func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 3061 type STRUCT 'linux=
_binprm'
1: R1_w=3Dptr_linux_binprm(off=3D0,imm=3D0)
1: (b7) r2 =3D 0                        ; R2_w=3D0
; char buf[64] =3D {0};
2: (7b) *(u64 *)(r10 -8) =3D r2
last_idx 2 first_idx 0
regs=3D4 stack=3D0 before 1: (b7) r2 =3D 0
3: R2_w=3DP0 R10=3Dfp0 fp-8_w=3D00000000
3: (7b) *(u64 *)(r10 -16) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-16_w=3D000=
00000
4: (7b) *(u64 *)(r10 -24) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-24_w=3D000=
00000
5: (7b) *(u64 *)(r10 -32) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-32_w=3D000=
00000
6: (7b) *(u64 *)(r10 -40) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-40_w=3D000=
00000
7: (7b) *(u64 *)(r10 -48) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-48_w=3D000=
00000
8: (7b) *(u64 *)(r10 -56) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-56_w=3D000=
00000
9: (7b) *(u64 *)(r10 -64) =3D r2        ; R2_w=3DP0 R10=3Dfp0 fp-64_w=3D000=
00000
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
10: (79) r1 =3D *(u64 *)(r1 +64)        ; R1_w=3Dptr_file(off=3D0,imm=3D0)
11: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
;=20
12: (07) r2 +=3D -64                    ; R2_w=3Dfp-64
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
13: (b4) w3 =3D 64                      ; R3_w=3D64
14: (85) call bpf_ima_file_hash#193
last_idx 14 first_idx 0
regs=3D8 stack=3D0 before 13: (b4) w3 =3D 64
15: R0_w=3Dscalar() fp-8_w=3Dmmmmmmmm fp-16_w=3Dmmmmmmmm fp-24_w=3Dmmmmmmmm=
 fp-32_w=3Dmmmmmmmm fp-40_w=3Dmmmmmmmm fp-48_w=3Dmmmmmmmm fp-56_w=3Dmmmmmmm=
m fp-64_w=3Dmmmmmmmm
; int BPF_PROG(dbg, struct linux_binprm *bprm)
15: (b4) w0 =3D 0                       ; R0_w=3D0
16: (95) exit

I use the following revision: 830b3c68c1fb "Linux 6.1".
(also works with current bpf-next master).

Could you please provide some details on how you compile/load the program?

Thanks,
Eduard

[...]
