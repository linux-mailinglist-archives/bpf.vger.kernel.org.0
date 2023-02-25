Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B26A28AD
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 10:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBYJ6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 04:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYJ6T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 04:58:19 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E0B14234
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 01:58:18 -0800 (PST)
Date:   Sat, 25 Feb 2023 09:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1677319096; x=1677578296;
        bh=ZcUzfafIUD84Yt1bjjPxFmZMPZBsD1H1FkR3wRV+c7Q=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=PbwRZJ1TJ7IzTgFXJ6zj3v0u5bb2DdqeEYWuLC/XT3u2UkVHy58t+ceGUBJAR86xv
         VSfp96gw9AnyBfkfRPaLKhVlEL50uYpetXIY4n1SpDQxb+lxU7ddAoPf5zneIXUO3j
         j/h2kO4+3o3YNXClR+qmUh39QAuUkuyXm6SUp+kj81AcBXDB7L/ArFl1YrZ338qDmE
         SQZr9owr+uF2KYTFT93uLEnbpLn0nNc9084aQbrJMVRC+37UxAkRwm8YJxCCrhhMFf
         Z4a6mw3hzsEFnIhiyTFzk3aaU8vpWqcaejs/ilaqXIxIYnLYON9oeTcxEVR8f5I7SF
         ylIst64AiCurQ==
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From:   xxx xxx <grubeli@pm.me>
Subject: LSM progam fails on Android - Kernel 3.15
Message-ID: <jkYD6vHYSygb9epXKMJ27-wbgnyuMJifZh_dkRGFXbZETP71QextxA7BFkJuSFU4R8k9yRvtYWD31Bz225-QOGUFoO1HvpH4rrlFDu2FH0E=@pm.me>
Feedback-ID: 21740350:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------89f594110a4a9cf0d0403b0b7dd6e4f3fe079a08627bbb6d755c147fc87e51bc"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------89f594110a4a9cf0d0403b0b7dd6e4f3fe079a08627bbb6d755c147fc87e51bc
Content-Type: multipart/mixed;boundary=---------------------f8ea5141bd8d3bf3dad69e15bf138ef7

-----------------------f8ea5141bd8d3bf3dad69e15bf138ef7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello all,
I compiled an Android Kernel to enable ebpf and LSM features.
Enabled features:
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_LTO \=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CO=
NFIG_LTO_CLANG \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_CFI_CLANG \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CFI_PERMISSIVE \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CFI_CLANG \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_RANDOMIZE_BASE \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_FTRACE_SYSCALLS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_DEBUG_FS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_ROP_PROTECTION_NONE \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_DEBUG_INFO \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_DEBUG_INFO_BTF \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_BPF \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_BPF_SYSCALL \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_BPF_JIT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_HAVE_BPF_JIT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_HAVE_EBPF_JIT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_BPF_EVENTS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_IKHEADERS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_CGROUP_BPF \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_FTRACE_SYSCALLS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_BPF_LSM \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_TRACEPOINTS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_HAVE_SYSCALL_TRACEPOINTS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_TRACEFS_DISABLE_AUTOMOUNT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_DEBUG_PREEMPT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_PREEMPTIRQ_EVENTS \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_PROVE_LOCKING \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-d CONFIG_LOCKDEP \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_NET_CLS_BPF \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_NET_ACT_BPF \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_NET_SCH_SFQ \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_NET_ACT_POLICE \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_NET_ACT_GACT \
=C2=A0 =C2=A0 =C2=A0 =C2=A0-e CONFIG_DUMMY
It may be more that what's necessary but I was experimenting by adding mor=
e features I was finding on Internet about the topic.

System: Cuttlefish Android Device (crossvm) with kernel 5.15.78 (from http=
s://android.googlesource.com/kernel/manifest -b common-android13-5.15).

Program to test:

SEC("lsm/file_open")
int BPF_PROG(file_open_lsm, struct=C2=A0file *file, int=C2=A0ret)
{
	return=C2=A0ret;
}


cat /sys/kernel/security/lsm

capability,selinux,bpf


Output when running the lsm program:
libbpf: prog 'lsm_file_open_function': failed to attach: Device or resourc=
e busylibbpf: prog 'lsm_file_open_function': failed to auto-attach: -16
Failed to attach BPF skeleton


strace:
...
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D16, info_len=3D88 =3D> 80, i=
nfo=3D0x7fffe2761f70}}, 16) =3D 0mmap(NULL, 4096, PROT_READ|PROT_WRITE, MA=
P_SHARED, 16, 0) =3D 0x7bc0d9511000
mmap(NULL, 1052672, PROT_READ, MAP_SHARED, 16, 0x1000) =3D 0x7bbe4628d000
epoll_ctl(30, EPOLL_CTL_ADD, 16, {EPOLLIN, {u32=3D10, u64=3D10}}) =3D 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info=3D{bpf_fd=3D17, info_len=3D88 =3D> 80, i=
nfo=3D0x7fffe2761f70}}, 16) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 17, 0) =3D 0x7bc0d95100=
00
mmap(NULL, 1052672, PROT_READ, MAP_SHARED, 17, 0x1000) =3D 0x7bbe45f5d000
epoll_ctl(30, EPOLL_CTL_ADD, 17, {EPOLLIN, {u32=3D11, u64=3D11}}) =3D 0
bpf(0x1c /* BPF_??? */, 0x7fffe2761df0, 48) =3D -1 EINVAL (Invalid argumen=
t)
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint=3D{name=3DNULL, prog_fd=3D21}=
}, 16) =3D -1 EBUSY (Device or resource busy)
write(2, "libbpf: prog 'file_open_lsm"..., 81libbpf: prog 'file_open_lsm':=
 failed to attach: Device or resource busy
) =3D 81
write(2, "libbpf: prog 'file_open_lsm"..., 66libbpf: prog 'file_open_lsm':=
 failed to auto-attach: -16
) =3D 66
write(2, "Failed to attach BPF skeleton\n", 30Failed to attach BPF skeleto=
n
) =3D 30



When I remove lsm hooks but keep kprobes and other ones, it works.
Seems like only lsm programs have the issue.


I'm using xmake to compile it for Android, according to samples from here:=
 https://github.com/libbpf/libbpf-bootstrap

libbpf version: 1.0
bpftool version: v7.0.0


Any help is appreciated

Best regards,
-----------------------f8ea5141bd8d3bf3dad69e15bf138ef7--

--------89f594110a4a9cf0d0403b0b7dd6e4f3fe079a08627bbb6d755c147fc87e51bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFAmP526AJEAsNJ9x0xAJnFiEEMHWNSWmkXAcN0CxSCw0n3HTE
AmcAAKUqAP9wP1n8119z0TO2o4iqi1UH8qH/sGaxITKaD/WM9jGoWAEAvPJo
pIkFZcR7rsLWppt3Krgg7mN/K6vlrVRtr9RF8Ak=
=F6Bg
-----END PGP SIGNATURE-----


--------89f594110a4a9cf0d0403b0b7dd6e4f3fe079a08627bbb6d755c147fc87e51bc--

