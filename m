Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46EF6A08C6
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 13:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjBWMnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 07:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjBWMnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 07:43:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB054A22
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 04:42:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z5so10713847ljc.8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 04:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ios/NjoZ5yynLXPIP6elKI2rdAJNcj7bzGMBaqct1zI=;
        b=KLlD6UHSPvv5RtYeFNpRcHEfy6ncn+wdLsM8xqSCAU8erZxQ8s91h0wsfvfB+i6A0C
         izSfas8lvsfW5pBnyWZ5W7PQ6hulSNi6I50nH2+Kw/OmJ6Vu2gADIhMjTebrio8jrCYk
         XrdjuDvxjIL+NciM+jeqV1jvdfgf+kgBN/aAaBqFd0fCbBYtMVaco7ueV5vY9teHjK84
         o9gw71r7edNDVaTYQAzB43ml86tdPB1+f3eMGzU5Nb47Xd21GWQihm7yTLsriPg9qRho
         TU8njDuKQymYdbsQNz4wbjqmbUh7AfTGcKXXKD/rLbiQU3raItNqpz97BobwfNwQfV1M
         oV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ios/NjoZ5yynLXPIP6elKI2rdAJNcj7bzGMBaqct1zI=;
        b=1pMKaH1NROmGnIABH6whxAW1jiaXsVYPKyCSZ4oMw+bUAeStyuihqiMya8z+Tg17je
         6y2TsOMg5q7KoQ86WOuFCWO9VnCvF7rkV2oWGpsuhATc9+kU/QxAlspc8QWuxeRQ+gQu
         mIFEwIdv7+k9/LXvmsRtmGx4l5L1DmMamrjf+76/lk7m7940KByMOJ8RHWeLgbkxEyze
         3ChlL6LUX/IlRFplaEN7dhg5xzLl4fWSVrqsMgNmgdSDNL2UdQ6+O/PDD63yyRRsSLUN
         4SbuP/BSifaQlCxrXGeNa9sqEZAxmFKPRCbu6edy5z8IHT/ucARRn9raIpf2LZ2FbvB6
         e7Zg==
X-Gm-Message-State: AO0yUKVcR4vmxl33diXMgs2ZS74Z3pdtZ5O7wYKleY56Vd5rzwDpmusp
        euojokF5S7If1A7OPmLVBZA=
X-Google-Smtp-Source: AK7set/WgvtP1Yh+j98BrkoKChpFEUbiR3lqnAfHSxnvWfukNGDGhAfDkzDTHn2oRYJ+LtY7NjE3uQ==
X-Received: by 2002:a2e:5c01:0:b0:295:94f4:c22c with SMTP id q1-20020a2e5c01000000b0029594f4c22cmr2805231ljb.49.1677156162464;
        Thu, 23 Feb 2023 04:42:42 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g15-20020a05651c044f00b002935009a49dsm1178533ljg.115.2023.02.23.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:42:41 -0800 (PST)
Message-ID: <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Date:   Thu, 23 Feb 2023 14:42:40 +0200
In-Reply-To: <Y/czygarUnMnDF9m@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
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

On Thu, 2023-02-23 at 09:37 +0000, Matt Bobrowski wrote:
[...]
> LMK whether you need any more information.
>=20
> /M

Hi Matt,

Unfortunately I can't reproduce the issue.
Here are the versions of the tools/repos that I use:

- kernel (tried both):
  - https://github.com/torvalds/linux.git
    a5c95ca18a98 ("Merge tag 'drm-next-2023-02-23' of git://anongit.freedes=
ktop.org/drm/drm")
  - https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
    830b3c68c1fb ("Linux 6.1")
- config (tried both):
  - one obtained using your instructions
  - my small debug config for executing BPF tests ([1])
- LLVM:
  https://github.com/llvm/llvm-project.git
  bc85cf168743 ("[TextAPI] Add support for TBDv5 Files to nm & tapi-diff")
- pahole:
  git@github.com:acmel/dwarves.git
  ef68019 ("pahole: Update man page for options also")
- libbpf-bootstrap (just followed your instructions):
  https://github.com/libbpf/libbpf-bootstrap
  db4f7ad ("cmake: Fix btf header missing in legacy kernel env.")
- gcc (from my distro):
  gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
- cat /etc/os-release=20
  NAME=3D"Linux Mint"
  VERSION=3D"21.1 (Vera)"
  ID=3Dlinuxmint
  ID_LIKE=3D"ubuntu debian"
  PRETTY_NAME=3D"Linux Mint 21.1"
  VERSION_ID=3D"21.1"
  VERSION_CODENAME=3Dvera
  UBUNTU_CODENAME=3Djammy

Could you please copy-paste output of the `fentry` application, I'd
like to see the log output of the libbpf while it processes
relocations, e.g. here is what it prints for me:

    # /home/eddy/work/libbpf-bootstrap/examples/c/fentry
    libbpf: loading object 'fentry_bpf' from buffer
    libbpf: elf: section(3) lsm.s/bprm_committed_creds, size 136, link 0, f=
lags 6, type=3D1
    libbpf: sec 'lsm.s/bprm_committed_creds': found program 'dbg' at insn o=
ffset 0 (0 bytes), code size 17 insns (136 bytes)
    libbpf: elf: section(4) license, size 13, link 0, flags 3, type=3D1
    libbpf: license of fentry_bpf is Dual BSD/GPL
    libbpf: elf: section(5) .BTF, size 5114, link 0, flags 0, type=3D1
    libbpf: elf: section(7) .BTF.ext, size 188, link 0, flags 0, type=3D1
    libbpf: elf: section(10) .symtab, size 96, link 1, flags 0, type=3D2
    libbpf: looking for externs among 4 symbols...
    libbpf: collected 0 externs total
    libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
    libbpf: sec 'lsm.s/bprm_committed_creds': found 1 CO-RE relocations
    libbpf: CO-RE relocating [6] struct linux_binprm: found target candidat=
e [7241] struct linux_binprm in [vmlinux]
    libbpf: prog 'dbg': relo #0: <byte_off> [6] struct linux_binprm.file (0=
:11 @ offset 64)
    libbpf: prog 'dbg': relo #0: matching candidate #0 <byte_off> [7241] st=
ruct linux_binprm.file (0:11 @ offset 64)
    libbpf: prog 'dbg': relo #0: patched insn #10 (LDX/ST/STX) off 64 -> 64
    Successfully started! Please run `sudo cat /sys/kernel/debug/tracing/tr=
ace_pipe` to see output of the BPF programs.

Also, could you please compile `veristat` tool as below:

    cd ${kernel}/tools/testing/selftests/bpf
    make -j16 veristat

And post the output of the following command (from within QEMU):

    ./veristat -l7 -v ${path-to-libbpf-bootstrap-within-vm}/examples/c/.out=
put/fentry.bpf.o

It should produce the verification log as an output.

The reason I'm asking is that your verification log looks kinda strange:

>    ; bpf_ima_file_hash(bprm->file, buf, 64);
>    13: (b7) r3 =3D 64                      ; R3_w=3D64
>    14: (85) call bpf_ima_file_hash#193
>    cannot access ptr member next with moff 0 in struct llist_node with of=
f 0 size 1
>    R1 is of type file but file is expected
>    processed 15 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0

I don't understand why it mentions `struct llist_node` here and don't
have such messages in my log ([2]).

Thanks,
Eduard

[1] My config for BPF testing
    https://gist.github.com/eddyz87/aca79692d7bf57cfdd01b283b4304fd8
[2] Veristat verification log
    https://gist.github.com/eddyz87/49b211740bf99c426a37a3555b4542a3
   =20
