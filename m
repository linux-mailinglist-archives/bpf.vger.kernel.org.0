Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844A12942AB
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390964AbgJTTC2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 15:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390916AbgJTTC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 15:02:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00872223C;
        Tue, 20 Oct 2020 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603220547;
        bh=f9rqzpsWqyvfdMrJ6nLdc3OCPI/mjFzbqmaW4uOHTms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Psgm/aYki9mqmRXZHESwkbbdn4lecaKazCKnJS3mhK0hCeBmLzygu3dZi1+X91/4o
         iS0x9GowYE07q1/Wp0R7fSQBQoZJHDbwprDuD49gt4CfJimLlG1Skab9dVd6QON7pD
         An0SeaWg9EISkbnj3Tibnymie/5Pw4cQqr0+lhpE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7D8D403C2; Tue, 20 Oct 2020 16:02:22 -0300 (-03)
Date:   Tue, 20 Oct 2020 16:02:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Jiri Slaby <jirislaby@kernel.org>,
        =?iso-8859-1?Q?=C9rico?= Rolim <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
Message-ID: <20201020190222.GB2342001@kernel.org>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <20201020122015.GH2294271@kernel.org>
 <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com>
 <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
 <20201020181458.GA2342001@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201020181458.GA2342001@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Oct 20, 2020 at 03:14:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 20, 2020 at 10:10:19AM -0700, Andrii Nakryiko escreveu:
> > On Tue, Oct 20, 2020 at 10:05 AM Hao Luo <haoluo@google.com> wrote:
> > > Thanks for reporting this and cc'ing me. I forgot to update the error
> > > messages when renaming the flags. I will send a patch to fix the error
> > > message.
>=20
> > > The commit
>=20
> > > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > > Author:     Hao Luo <haoluo@google.com>
> > > AuthorDate: Wed Jul 8 13:44:10 2020 -0700
>=20
> > >      btf_encoder: Teach pahole to store percpu variables in vmlinux B=
TF.
>=20
> > > encodes kernel global variables into BTF so that bpf programs can
> > > directly access them. If there is no need to access kernel global
> > > variables, it's perfectly fine to use '--btf_encode_force' to skip
> > > encoding bad symbols into BTF, or '--skip_encoding_btf_vars' to skip
> > > encoding all global vars all together. I will add these info into the
> > > updated error message.
>=20
> > > Also cc bpf folks for attention of this bug.
>=20
> > I've already fixed the message as part of
> > 2e719cca6672 ("btf_encoder: revamp how per-CPU variables are encoded")
>=20
> > It's currently still in the tmp.libbtf_encoder branch in pahole repo.
>=20
> I'm now running:
>=20
>   $ grep BTF=3Dy ../build/s390x-v5.9.0+/.config
>   CONFIG_DEBUG_INFO_BTF=3Dy
>   $ make -j24 CROSS_COMPILE=3Ds390x-linux-gnu- ARCH=3Ds390 O=3D../build/s=
390x-v5.9.0+/

  $ ls -la /home/acme/git/build/s390x-v5.9.0+/.tmp_vmlinux.btf
  -rwxrwxr-x. 1 acme acme 304592928 Oct 20 15:26 /home/acme/git/build/s390x=
-v5.9.0+/.tmp_vmlinux.btf
  $ file /home/acme/git/build/s390x-v5.9.0+/.tmp_vmlinux.btf
  /home/acme/git/build/s390x-v5.9.0+/.tmp_vmlinux.btf: ELF 64-bit MSB execu=
table, IBM S/390, version 1 (SYSV), statically linked, BuildID[sha1]=3Ded39=
402fdbd7108c1055baaa61cfc6b0e431901d, with debug_info, not stripped
  $ pahole -F btf -C list_head /home/acme/git/build/s390x-v5.9.0+/.tmp_vmli=
nux.btf
  struct list_head {
  	struct list_head *         next;                 /*     0     8 */
  	struct list_head *         prev;                 /*     8     8 */
 =20
  	/* size: 16, cachelines: 1, members: 2 */
  	/* last cacheline: 16 bytes */
  };
  $
  $ readelf -wi /home/acme/git/build/s390x-v5.9.0+/vmlinux | grep -m2 DW_AT=
_producer
      <28>   DW_AT_producer    : (indirect string, offset: 0x51): GNU AS 2.=
34
      <3b>   DW_AT_producer    : (indirect string, offset: 0xeb46): GNU C89=
 9.2.1 20190827 (Red Hat Cross 9.2.1-3) -m64 -mwarn-dynamicstack -mbackchai=
n -msoft-float -march=3Dz196 -mtune=3Dz196 -mpacked-stack -mindirect-branch=
=3Dthunk -mfunction-return=3Dthunk -mindirect-branch-table -mrecord-mcount =
-mnop-mcount -mfentry -mzarch -g -O2 -std=3Dgnu90 -p -fno-strict-aliasing -=
fno-common -fshort-wchar -fPIE -fno-asynchronous-unwind-tables -fno-delete-=
null-pointer-checks -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inli=
ning -fno-stack-protector -fno-var-tracking-assignments -fno-inline-functio=
ns-called-once -falign-functions=3D32 -fno-strict-overflow -fstack-check=3D=
no -fconserve-stack -fno-function-sections -fno-data-sections -fsanitize=3D=
kernel-address -fasan-shadow-offset=3D0x18000000000000 -fsanitize=3Dbounds =
-fsanitize=3Dshift -fsanitize=3Dinteger-divide-by-zero -fsanitize=3Dunreach=
able -fsanitize=3Dsigned-integer-overflow -fsanitize=3Dobject-size -fsaniti=
ze=3Dbool -fsanitize=3Denum -fsanitize-undefined-trap-on-error -fsanitize-c=
overage=3Dtrace-pc -fsanitize-coverage=3Dtrace-cmp --param allow-store-data=
-races=3D0 --param asan-globals=3D1 --param asan-instrumentation-with-call-=
threshold=3D0 --param asan-stack=3D1 --param asan-instrument-allocas=3D1
  $
  $ file /home/acme/git/build/s390x-v5.9.0+/vmlinux
  /home/acme/git/build/s390x-v5.9.0+/vmlinux: ELF 64-bit MSB executable, IB=
M S/390, version 1 (SYSV), statically linked, BuildID[sha1]=3Dfbb252d8dccc1=
1d8e66d6f248d06bcdca4e7db7a, with debug_info, not stripped
  $

But I noticed that 'btfdiff' is showing differences from output
generated from DWARF and the one generated from BTF, the first issue
is:

[acme@five pahole]$ btfdiff /home/acme/git/build/v5.9.0+/vmlinux
<SNIP>
@@ -115549,7 +120436,7 @@ struct irq_router_handler {
=20
 	/* XXX 6 bytes hole, try to pack */
=20
-	int                        (*probe)(struct irq_router * , struct pci_dev =
* , u16 ); /*     8     8 */
+	int                        (*probe)(struct irq_router *, struct pci_dev *=
, u16); /*     8     8 */
=20
 	/* size: 16, cachelines: 1, members: 2 */
 	/* sum members: 10, holes: 1, sum holes: 6 */
[acme@five pahole]$

The BTF output (the one starting with '+' in the diff output) is better, ju=
st
different than it was before, I'll fix the DWARF one to avoid that needless
space for arg lists without names.

The other problem I noticed is a bit more worrying:

@@ -52,13 +52,29 @@ struct file_system_type {
        /* last cacheline: 8 bytes */
 };
 struct qspinlock {
-       union                      ;                     /*     0     4 */
+       union {
+               atomic_t           val;                  /*     0     4 */
+               struct {
+                       u8         locked;               /*     0     1 */
+                       u8         pending;              /*     1     1 */
+               };                                       /*     0     2 */
+               struct {
+                       u16        locked_pending;       /*     0     2 */
+                       u16        tail;                 /*     2     2 */
+               };                                       /*     0     4 */
+       };                                               /*     0     4 */
=20
        /* size: 4, cachelines: 1, members: 1 */
        /* last cacheline: 4 bytes */
 };
 struct qrwlock {
-       union                      ;                     /*     0     4 */
+       union {
+               atomic_t           cnts;                 /*     0     4 */
+               struct {
+                       u8         wlocked;              /*     0     1 */
+                       u8         __lstate[3];          /*     1     3 */
+               };                                       /*     0     4 */
+       };                                               /*     0     4 */
        arch_spinlock_t            wait_lock;            /*     4     4 */
=20
        /* size: 8, cachelines: 1, members: 2 */

But again, its the DWARF code that is wrong :-)

So, for what is being tested here, which is BTF generation, things looks Ok:

i.e. using BTF:

[acme@five perf]$ pahole qspinlock
struct qspinlock {
	union {
		atomic_t           val;                  /*     0     4 */
		struct {
			u8         locked;               /*     0     1 */
			u8         pending;              /*     1     1 */
		};                                       /*     0     2 */
		struct {
			u16        locked_pending;       /*     0     2 */
			u16        tail;                 /*     2     2 */
		};                                       /*     0     4 */
	};                                               /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};
[acme@five perf]$

While using DWARF:

[acme@five perf]$ pahole -F dwarf -C qspinlock
struct qspinlock {
	union                      ;                     /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};
[acme@five perf]$

typedef struct qspinlock {
        union {
                atomic_t val;

                /*
                 * By using the whole 2nd least significant byte for the
                 * pending bit, we can allow better optimization of the lock
                 * acquisition for the pending bit holder.
                 */
#ifdef __LITTLE_ENDIAN
                struct {
                        u8      locked;
                        u8      pending;
                };
                struct {
                        u16     locked_pending;
                        u16     tail;
                };
#else
                struct {
                        u16     tail;
                        u16     locked_pending;
                };
                struct {
                        u8      reserved[2];
                        u8      pending;
                        u8      locked;
                };
#endif
        };
} arch_spinlock_t;

This is just a heads up, will investigate further...

- Arnaldo

=20
> To do the last test I wanted before moving it to master.
