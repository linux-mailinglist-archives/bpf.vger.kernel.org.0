Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA466A1D50
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBXOOx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 09:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBXOOu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 09:14:50 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292A134
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 06:14:47 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z42so6584543ljq.13
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 06:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uW3HyxliT/eyqrHhVGv7I+rmwKZAq8Tq2CNVmj9BUc=;
        b=q7+P7okn8wwXQC+nUmB+4Qo1Goy+mf4NpQzNpU9KVCMGKScyrkA+zE66wiP/hdqlMP
         kgF5icchS3QgHedkroWTslPDOfwXWMGAldENg67u9wYKvNUTbhIbTL3/LvTQ2qeMiO/1
         lypp2k7gjJseaeFLWX1wBc4CJwyktuiwh3mtPtF0Sk64ExhV6RHnTMOtYjDwp+qGKoiz
         Aae4IIskMzoQUQy3tmzp/7w+IxszS92Wg3vTQrgmJsygy77/uvVIxGRdjvpPchOqt1Do
         hyMxJX7LGgMh3fZG6BZ1ptg+2IaEJz4Y8W8ev+sZMn1NGHJeQZ0RJZxMON10S6zPdsOs
         oeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uW3HyxliT/eyqrHhVGv7I+rmwKZAq8Tq2CNVmj9BUc=;
        b=Srr1yptpHKmUGO1Q+DQ0QOCm70avfAZAqtv0O1tHKD5BSJ5c94ZhQKlJ27z+vSu+9Z
         4IX2WuJMvACW7gsQlVaYv1S+4AA97K11qr3Ip9WsLD7zrSCGvBrYD9WLbKHxqohmujj6
         THBoxJiWBN8orHdE/QomAiXL/rOQxHfDN6D9E4CdLiuddbpRH3p/X0GOnmiC8ksMvkmF
         KGAPLLKSzg8g1hBzZcaWlgmrwvldSMWzSbJVlEl4Cth8foxJgi0mo3REucVmnqZp4wHP
         hqBKHPW0yFqO0a4oDYpgPk+bIz4hcmPCbadcTPbmzzpRvzmDx2YOYGzRcf+RLUuMSvnL
         hoVw==
X-Gm-Message-State: AO0yUKXHibUTOYDydYxf4Gp34WcNXZRrAqFmjy9nVc/N867sBDu4YQ3t
        vMwDnNOuAWDhrn+gjDlvTnU=
X-Google-Smtp-Source: AK7set+kRJdD2sNB1Pa8ZC5xVHItAHtUd3pG/PAhTBvD5mHGFs9v4yX+qpJI1nTdO6QJMun3q6dzhw==
X-Received: by 2002:a05:651c:1a27:b0:295:a2a6:672 with SMTP id by39-20020a05651c1a2700b00295a2a60672mr2553994ljb.10.1677248085741;
        Fri, 24 Feb 2023 06:14:45 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05651c0ba100b00293534d9760sm1571096ljb.127.2023.02.24.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:14:45 -0800 (PST)
Message-ID: <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Date:   Fri, 24 Feb 2023 16:14:44 +0200
In-Reply-To: <Y/hLsgSO3B+2g9iF@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
         <Y/hLsgSO3B+2g9iF@google.com>
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

On Fri, 2023-02-24 at 05:31 +0000, Matt Bobrowski wrote:
[...]
> >=20
> > Could you please copy-paste output of the `fentry` application, I'd
> > like to see the log output of the libbpf while it processes
> > relocations, e.g. here is what it prints for me:
> >=20
> >     # /home/eddy/work/libbpf-bootstrap/examples/c/fentry
> >     libbpf: loading object 'fentry_bpf' from buffer
> >     libbpf: elf: section(3) lsm.s/bprm_committed_creds, size 136, link =
0, flags 6, type=3D1
> >     libbpf: sec 'lsm.s/bprm_committed_creds': found program 'dbg' at in=
sn offset 0 (0 bytes), code size 17 insns (136 bytes)
> >     libbpf: elf: section(4) license, size 13, link 0, flags 3, type=3D1
> >     libbpf: license of fentry_bpf is Dual BSD/GPL
> >     libbpf: elf: section(5) .BTF, size 5114, link 0, flags 0, type=3D1
> >     libbpf: elf: section(7) .BTF.ext, size 188, link 0, flags 0, type=
=3D1
> >     libbpf: elf: section(10) .symtab, size 96, link 1, flags 0, type=3D=
2
> >     libbpf: looking for externs among 4 symbols...
> >     libbpf: collected 0 externs total
> >     libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> >     libbpf: sec 'lsm.s/bprm_committed_creds': found 1 CO-RE relocations
> >     libbpf: CO-RE relocating [6] struct linux_binprm: found target cand=
idate [7241] struct linux_binprm in [vmlinux]
> >     libbpf: prog 'dbg': relo #0: <byte_off> [6] struct linux_binprm.fil=
e (0:11 @ offset 64)
> >     libbpf: prog 'dbg': relo #0: matching candidate #0 <byte_off> [7241=
] struct linux_binprm.file (0:11 @ offset 64)
> >     libbpf: prog 'dbg': relo #0: patched insn #10 (LDX/ST/STX) off 64 -=
> 64
> >     Successfully started! Please run `sudo cat /sys/kernel/debug/tracin=
g/trace_pipe` to see output of the BPF programs.
>=20
> Sure, here it is:
>=20
> # ./fentry
> libbpf: loading object 'fentry_bpf' from buffer
> libbpf: elf: section(3) lsm.s/bprm_committed_creds, size 136, link 0, fla=
gs 6, type=3D1
> libbpf: sec 'lsm.s/bprm_committed_creds': found program 'dbg' at insn off=
set 0 (0 bytes), code size 17 insns (136 bytes)
> libbpf: elf: section(4) license, size 13, link 0, flags 3, type=3D1
> libbpf: license of fentry_bpf is Dual BSD/GPL
> libbpf: elf: section(5) .BTF, size 5149, link 0, flags 0, type=3D1
> libbpf: elf: section(7) .BTF.ext, size 188, link 0, flags 0, type=3D1
> libbpf: elf: section(10) .symtab, size 96, link 1, flags 0, type=3D2
> libbpf: looking for externs among 4 symbols...
> libbpf: collected 0 externs total
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: sec 'lsm.s/bprm_committed_creds': found 1 CO-RE relocations
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[3971] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[9214] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[36310] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[36973] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[122219] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[151720] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[163602] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[175117] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[176645] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[179130] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[189263] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[237046] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[240978] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[264207] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[268773] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[276058] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[295158] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[306160] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[347067] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[349932] struct linux_binprm in [vmlinux]
> libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate =
[380629] struct linux_binprm in [vmlinux]
> libbpf: prog 'dbg': relo #0: <byte_off> [6] struct linux_binprm.file (0:1=
1 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #0 <byte_off> [3971] stru=
ct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #1 <byte_off> [9214] stru=
ct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #2 <byte_off> [36310] str=
uct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #3 <byte_off> [36973] str=
uct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #4 <byte_off> [122219] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #5 <byte_off> [151720] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #6 <byte_off> [163602] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #7 <byte_off> [175117] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #8 <byte_off> [176645] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #9 <byte_off> [179130] st=
ruct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #10 <byte_off> [189263] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #11 <byte_off> [237046] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #12 <byte_off> [240978] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #13 <byte_off> [264207] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #14 <byte_off> [268773] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #15 <byte_off> [276058] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #16 <byte_off> [295158] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #17 <byte_off> [306160] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #18 <byte_off> [347067] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #19 <byte_off> [349932] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: matching candidate #20 <byte_off> [380629] s=
truct linux_binprm.file (0:11 @ offset 64)
> libbpf: prog 'dbg': relo #0: patched insn #10 (LDX/ST/STX) off 64 -> 64
> libbpf: prog 'dbg': BPF program load failed: Permission denied
> libbpf: prog 'dbg': -- BEGIN PROG LOAD LOG --
> reg type unsupported for arg#0 function dbg#5
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> 0: (79) r1 =3D *(u64 *)(r1 +0)
> func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 176645 type STRUCT 'l=
inux_binprm'
> 1: R1_w=3Dtrusted_ptr_linux_binprm(off=3D0,imm=3D0)
> 1: (b7) r2 =3D 0                        ; R2_w=3D0
> ; char buf[64] =3D {0};
> 2: (7b) *(u64 *)(r10 -8) =3D r2         ; R2_w=3D0 R10=3Dfp0 fp-8_w=3D000=
00000
> 3: (7b) *(u64 *)(r10 -16) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-16_w=3D00=
000000
> 4: (7b) *(u64 *)(r10 -24) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-24_w=3D00=
000000
> 5: (7b) *(u64 *)(r10 -32) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-32_w=3D00=
000000
> 6: (7b) *(u64 *)(r10 -40) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-40_w=3D00=
000000
> 7: (7b) *(u64 *)(r10 -48) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-48_w=3D00=
000000
> 8: (7b) *(u64 *)(r10 -56) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-56_w=3D00=
000000
> 9: (7b) *(u64 *)(r10 -64) =3D r2        ; R2_w=3D0 R10=3Dfp0 fp-64_w=3D00=
000000
> ; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 10: (79) r1 =3D *(u64 *)(r1 +64)        ; R1_w=3Dptr_file(off=3D0,imm=3D0=
)
> 11: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
> ;=20
> 12: (07) r2 +=3D -64                    ; R2_w=3Dfp-64
> ; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 13: (b7) r3 =3D 64                      ; R3_w=3D64
> 14: (85) call bpf_ima_file_hash#193
> cannot access ptr member next with moff 0 in struct llist_node with off 0=
 size 1
> R1 is of type file but file is expected
> processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 p=
eak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'dbg': failed to load: -13
> libbpf: failed to load object 'fentry_bpf'
> libbpf: failed to load BPF skeleton 'fentry_bpf': -13
> Failed to open BPF skeleton
>=20
> It looks like there are a lot more relocations attempted by libbpf,
> but I suspect that's a result of their being multiple definitions of
> that same struct within the running kernel's BTF?

This shouldn't really be the case, as pahole de-duplicates BTF
definitions when BTF is added to vmlinux.

One scenario I can think of is when `linux_binprm` data structure
comes from multiple modules but not from `vmlinux` itself.=20
However, the log would be a bit different in such case:

    libbpf: CO-RE relocating [107] struct bpf_testmod_struct_arg_2: found t=
arget candidate [90383] struct bpf_testmod_struct_arg_2 in [bpf_testmod]
    libbpf: CO-RE relocating [107] struct bpf_testmod_struct_arg_2: found t=
arget candidate [90353] struct bpf_testmod_struct_arg_2 in [bpf_testmod1]

Note `in [bpf_testmod]` and `in [bpf_testmod1]` which are my test modules.
In your log it says `in [vmlinux]`.

Which suggests that there are multiple _conflicting_ definitions of
`linux_binprm` in your `vmlinux` and these definitions could not be
de-duplicated. Could you please run the following command inside QEMU and
share the output?

    bpftool btf dump file /sys/kernel/btf/vmlinux | grep "'linux_binprm'" -=
A 30
   =20
Or outside the VM:

    bpftool btf dump file {kernel}/vmlinux | grep "'linux_binprm'" -A 30

Also, could you please share full `.config`?
Do you use any non-standard compilation flags?

>=20
> > Also, could you please compile `veristat` tool as below:
> >=20
> >     cd ${kernel}/tools/testing/selftests/bpf
> >     make -j16 veristat
> >=20
> > And post the output of the following command (from within QEMU):
> >=20
> >     ./veristat -l7 -v ${path-to-libbpf-bootstrap-within-vm}/examples/c/=
.output/fentry.bpf.o
> >=20
> > It should produce the verification log as an output.
> >=20
> > The reason I'm asking is that your verification log looks kinda strange=
:
> >=20
> > >    ; bpf_ima_file_hash(bprm->file, buf, 64);
> > >    13: (b7) r3 =3D 64                      ; R3_w=3D64
> > >    14: (85) call bpf_ima_file_hash#193
> > >    cannot access ptr member next with moff 0 in struct llist_node wit=
h off 0 size 1
> > >    R1 is of type file but file is expected
> > >    processed 15 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >=20
> > I don't understand why it mentions `struct llist_node` here and don't
> > have such messages in my log ([2]).
>=20
> Yes, I also found this strange and couldn't find a valid explanation
> for it either. Looking at the BPF verifier code in the kernel, we hit
> this case when performing the struct member walk in btf_struct_walk().

To be honest, it looks like something is off with BTF ids and `llist_node`
gets randomly picked, but that's a speculation w/o hard evidence.

Thanks,
Eduard
