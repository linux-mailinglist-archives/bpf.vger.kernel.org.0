Return-Path: <bpf+bounces-7172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA977281F
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919B628143B
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8CF101C7;
	Mon,  7 Aug 2023 14:46:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66B20FE;
	Mon,  7 Aug 2023 14:46:02 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F710DC;
	Mon,  7 Aug 2023 07:46:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c47ef365cso691109266b.0;
        Mon, 07 Aug 2023 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419559; x=1692024359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAlba8j5WNsUJrqq14ThkPmUT4lIimPw4652fzwMMR4=;
        b=A+xUi1Aug1Dht+qcl9x83hPQb5fNj4iSVUvtAgxaUP6G+rmyTlDrrAUTUT/g9wUoZS
         vnW4K8v+IkW72ddlwr0dl7YDPdXPiihrBT1HuGEB6wKcrZZQLX0CEu9kN6KZ5EAwXQ3E
         181yq5k6s3W1Q99G9OSyXkHAsX3I+g5dpTBa/88fu9+7BYFlHjYBzPElKSnB7EeExfaF
         n3X9/+Q2JggBAIC9Kxb03eEPwNZ0q8Q3nPgyL5aihbluFH9zW9cAohfDq6YZGhDQpCsz
         8WBRXbpoqecoEqnlLckFzI6vFPJkQAh3845jOvbsj3iIGV0GHygLow1sGP9Oj76mzFyd
         Gdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419559; x=1692024359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAlba8j5WNsUJrqq14ThkPmUT4lIimPw4652fzwMMR4=;
        b=LnL+w4g2uid6jsr/anH6cPgMioap86x2vXoOWHiI/8tBpeBY6PD2TmAwwu8kBhiiWA
         Vzy708xfM0hhYZ8JelRY1jMmSMBfvFzL//+u0sK6JjC9cimPRNWuwkMWSZEF8iTycGn4
         bjMuNcj5AR93zGxMOQyk4UZMayKOQLi7rjgnXUYTWkJJ541FZtdcohH3Cdwt924UzNdT
         dl8zPfa7+Y7nLCYpoYWLFHeqsOlqB5a8QbwImqM8EzYO+Rs9mPnvf1DZkfKyxI2NmP57
         cMFy6Z4kb4ztCIHeLXxI80mHJ2DnUWdMpS+bh3ze7Vwuu9oim5QXD7BjogxPC9d9xFvh
         zIWg==
X-Gm-Message-State: AOJu0Yw1aaIZNs/Qm/Lq2d5OGp5cKd8bPgiBzIVsByi/+0xnMv4lkMXF
	XHRaC+HAe29l1kF9ePcEFfs=
X-Google-Smtp-Source: AGHT+IFYYxUG11Fu8DIQ2vdtlUyk+6wNpqkNFpRzgx0gu7BNpd2ZblEVe9sa86EpMu7L7EW/zB/urw==
X-Received: by 2002:a17:906:51d7:b0:994:9ed:300b with SMTP id v23-20020a17090651d700b0099409ed300bmr10035935ejk.16.1691419559044;
        Mon, 07 Aug 2023 07:45:59 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906c20b00b00992d70f8078sm5329200ejz.106.2023.08.07.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:45:58 -0700 (PDT)
Message-ID: <72e2ff187fb8cd031a6330e4c3cd8e66a0590fc1.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in
 ieee802154_subif_start_xmit
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, syzbot
 <syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com>, andrii@kernel.org,
  ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net,  haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org,  kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
 syzkaller-bugs@googlegroups.com
Date: Mon, 07 Aug 2023 17:45:56 +0300
In-Reply-To: <bc69afd6-6eec-a070-ab96-05ab137aaf0b@linux.dev>
References: <0000000000002098bc0602496cc3@google.com>
	 <d520bd6c-bfd3-47f1-c794-ab451905256b@linux.dev>
	 <9c8f04a0bf90db4bb8e6192824ab71f58244b74b.camel@gmail.com>
	 <bc69afd6-6eec-a070-ab96-05ab137aaf0b@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-07 at 07:40 -0700, Yonghong Song wrote:
>=20
> On 8/7/23 6:11 AM, Eduard Zingerman wrote:
> > On Sun, 2023-08-06 at 23:40 -0700, Yonghong Song wrote:
> > >=20
> > > On 8/6/23 4:23 PM, syzbot wrote:
> > > > Hello,
> > > >=20
> > > > syzbot found the following issue on:
> > > >=20
> > > > HEAD commit:    25ad10658dc1 riscv, bpf: Adapt bpf trampoline to op=
timized..
> > > > git tree:       bpf-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D147cbb2=
9a80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8acaeb9=
3ad7c6aaa
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd61b595e9=
205573133b3
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d73=
ccea80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1276aed=
ea80000
> > > >=20
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/3d378cc13d=
42/disk-25ad1065.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/44580fd5d1af/=
vmlinux-25ad1065.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/84058761=
8b41/bzImage-25ad1065.xz
> > > >=20
> > > > The issue was bisected to:
> > > >=20
> > > > commit 8100928c881482a73ed8bd499d602bab0fe55608
> > > > Author: Yonghong Song <yonghong.song@linux.dev>
> > > > Date:   Fri Jul 28 01:12:02 2023 +0000
> > > >=20
> > > >       bpf: Support new sign-extension mov insns
> > >=20
> > > Thanks for reporting. I will look into this ASAP.
> >=20
> > Hi Yonghong,
> >=20
> > I guess it's your night and my morning, so I did some initial assessmen=
t.
> > The BPF program being loaded is:
> >=20
> >    0 : (62) *(u32 *)(r10 -8) =3D 553656332
> >    1 : (bf) r1 =3D (s16)r10
> >    2 : (07) r1 +=3D -8
> >    3 : (b7) r2 =3D 3
> >    4 : (bd) if r2 <=3D r1 goto pc+0
> >    5 : (85) call bpf_trace_printk#6
> >    6 : (b7) r0 =3D 0
> >    7 : (95) exit
> >=20
> > (Note: when using bpftool (prog dump xlated id <some-id>) the disassemb=
ly
> >   of the instruction #1 is incorrectly printed as "1: (bf) r1 =3D r10")
> >  =20
> > The error occurs when instruction #5 (call to printk) is executed.
> > An incorrect address for the format string is passed to printk.
> > Disassembly of the jited program looks as follows:
> >=20
> >    $ bpftool prog dump jited id <some-id>
> >    bpf_prog_ebeed182d92b487f:
> >       0: nopl    (%rax,%rax)
> >       5: nop
> >       7: pushq   %rbp
> >       8: movq    %rsp, %rbp
> >       b: subq    $8, %rsp
> >      12: movl    $553656332, -8(%rbp)
> >      19: movswq  %bp, %rdi            ; <---- Note movswq %bp !
> >      1d: addq    $-8, %rdi
> >      21: movl    $3, %esi
> >      26: cmpq    %rdi, %rsi
> >      29: jbe 0x2b
> >      2b: callq   0xffffffffe11c484c
> >      30: xorl    %eax, %eax
> >      32: leave
> >      33: retq
> >=20
> > Note jit instruction #19 corresponding to BPF instruction #1, which
> > loads truncated and sign-extended value of %rbp's first byte as an
> > address of format string.
> >=20
> > Here is how verifier log looks for (slightly modified) program:
> >=20
> >    func#0 @0
> >    0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >    ; asm volatile ("			\n\
> >    0: (b7) r1 =3D 553656332                ; R1_w=3D553656332
> >    1: (63) *(u32 *)(r10 -8) =3D r1         ; R1_w=3D553656332 R10=3Dfp0=
 fp-8=3D553656332
> >    2: (bf) r1 =3D (s16)r10                 ; R1_w=3Dfp0 R10=3Dfp0
> >    3: (07) r1 +=3D -8                      ; R1_w=3Dfp-8
> >    4: (b7) r2 =3D 3                        ; R2_w=3D3
> >    5: (bd) if r2 <=3D r1 goto pc+0         ; R1_w=3Dfp-8 R2_w=3D3
> >    6: (85) call bpf_trace_printk#6
> >    mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
> >    ...
> >    mark_precise: frame0: falling back to forcing all scalars precise
> >    7: R0=3Dscalar()
> >    7: (b7) r0 =3D 0                        ; R0_w=3D0
> >    8: (95) exit
> >   =20
> >    from 5 to 6: R1_w=3Dfp-8 R2_w=3D3 R10=3Dfp0 fp-8=3D553656332
> >    6: (85) call bpf_trace_printk#6
> >    mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
> >    ...
> >    mark_precise: frame0: falling back to forcing all scalars precise
> >    7: safe
> >=20
> > Note the following line:
> >=20
> >    2: (bf) r1 =3D (s16)r10                 ; R1_w=3Dfp0 R10=3Dfp0
> >=20
> > Verifier incorrectly marked r1 as fp0, hence not noticing the problem
> > with address passed to printk.
>=20
> Thanks, Eduard. Right. I am also able to dump xlated code like
> below:
>=20
>     0: (62) *(u32 *)(r10 -8) =3D 553656332
>     1: (bf) r1 =3D (s16)r10
>     2: (07) r1 +=3D -8
>     3: (b7) r2 =3D 3
>     4: (bd) if r2 <=3D r1 goto pc+0
>     5: (85) call bpf_trace_printk#-138320
>     6: (b7) r0 =3D 0
>     7: (95) exit
>=20
> Something like below can fix the problem,
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 132f25dab931..db72619551b2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13171,6 +13171,7 @@ static int check_alu_op(struct bpf_verifier_env=
=20
> *env, struct bpf_insn *insn)
>                                          if (no_sext && need_id)
>                                                  src_reg->id =3D=20
> ++env->id_gen;
>                                          copy_register_state(dst_reg,=20
> src_reg);
> +                                       dst_reg->type =3D SCALAR_VALUE;
>                                          if (!no_sext)
>                                                  dst_reg->id =3D 0;
>                                          coerce_reg_to_size_sx(dst_reg,=
=20
> insn->off >> 3);
>=20
> After insn 1, we need change r1 type to SCALAR_VALUE. Will add
> the the test to selftest and submit the patch to fix the problem
> today.

Should this be an error?
Like in the same function but slightly below, when u32 moves are
processed:

    /* R1 =3D (u32) R2 */
    if (is_pointer_value(env, insn->src_reg)) {
        verbose(env,
            "R%d partial copy of pointer\n",
            insn->src_reg);
        return -EACCES;
    } else { ...

>=20
> >=20
> > Thanks,
> > Eduard.
> >=20
> > > >=20
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1797=
0c5da80000
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1457=
0c5da80000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10570c5=
da80000
> > > >=20
> [...]


