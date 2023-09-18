Return-Path: <bpf+bounces-10282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35B7A4BA1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B91C20B4E
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E71D68C;
	Mon, 18 Sep 2023 15:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939215494;
	Mon, 18 Sep 2023 15:19:23 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A507CEF;
	Mon, 18 Sep 2023 08:18:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so5816957a12.1;
        Mon, 18 Sep 2023 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050284; x=1695655084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V45netL1NGQ7XyjhZIpxU+9T2j+ziW+oY/JOWFEaOCk=;
        b=Gmw8pjcKvHX83HvGAGBWdp1Ml8FwoeCaAaShpqOTzfdMG56s2G4knKIVCmrtRQG8HC
         ciFrgH13nsX8Bgu5fyj77F+KKrmpOoRwmt1UbTZycUIaY9RT7MwzqrZAIUWd3DOkY+6w
         Ej7oGB6fkXg4LCOCHdU4HGyXrjC5dCpUUw9ZVnQay3cPg++VTJIFSIg0+ZYjy8gu6TMU
         jHbiRJRV1EgjlMIMDHnqgwoloLOQt/j9v0WnrZc98sPaWyLL5sWdKfdpQldUXheGZBHv
         s/rl4qHw54nniC59fbTw3rdIUxIVeJ2qXGB2/qJYw6VSAhes2Uq4a+BPBYPw0qF+yA2J
         70qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050284; x=1695655084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V45netL1NGQ7XyjhZIpxU+9T2j+ziW+oY/JOWFEaOCk=;
        b=FAFgsKhnFNzHB8NYeELaLS7xXZiqZ4c2c1VMwz6HTDY0mbx5VSrp5rqHsT+0le3yRT
         gDniIhcjARtp3CBcEZIUgSrtXuLN75A4oUgQTmtCjCZ/gobpYCuqJHZzqZpp9n/l9ulV
         qlBE+m4Tq7H/x2+eVMqB7zoLcPn3EkAR2hMEnSec40KacnABeQhKCfAYLTPkm7IfkVY4
         P0uZwec9KdMMyv17wezqw3/ClWmxCz0VEmmBOEiTzDKbdApMJWzeR6y0xAfXrTshG+fv
         71Ux0x1YtMjwIwF06+5ychKtXr11S0Ulvs1anjCAo4gKHlCPjv1BzsY6XkJOoltxHbIO
         cuTQ==
X-Gm-Message-State: AOJu0Yy0+/qgbJo7tlnad2zGZ1Z06iEDCV15uy8V8bq2dFvBVydoYF94
	iZrZIPI6Z1zS5yx1D+TLRXe3QJ8EJxFkULh+pObv1d6o2vw=
X-Google-Smtp-Source: AGHT+IHJPqiUBDCAN6e8oiN6hpe4Tg87Zi2OAC7Omvea/tIF4wg9W2icdmob5IZMdgHVXsUIEm4b8smuem5FgxZP5YE=
X-Received: by 2002:adf:e40c:0:b0:319:8c35:378 with SMTP id
 g12-20020adfe40c000000b003198c350378mr7304198wrm.44.1695047060643; Mon, 18
 Sep 2023 07:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
 <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
 <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com>
 <CAADnVQLn1dtBNyywZO38WyWtUyomKJDdMefpkj3mkR=+fOh+tg@mail.gmail.com> <CAP01T75C3qHe3OuXcbFqDjLtb+M8UixVYxHA-Gf=c6xrNQvVAA@mail.gmail.com>
In-Reply-To: <CAP01T75C3qHe3OuXcbFqDjLtb+M8UixVYxHA-Gf=c6xrNQvVAA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 16:23:44 +0200
Message-ID: <CAP01T77KpyhUByzBmz+g12GgB7SEm0qr4BGJMrkFw5DXC+_Vdw@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: multipart/mixed; boundary="000000000000edd0010605a2e5f9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000edd0010605a2e5f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Sept 2023 at 16:15, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
>
> On Mon, 18 Sept 2023 at 15:56, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 6:54=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > > > > >
> > > > > > The following pull-request contains BPF updates for your *net-n=
ext* tree.
> > > > > >
> > > > > > We've added 73 non-merge commits during the last 9 day(s) which=
 contain
> > > > > > a total of 79 files changed, 5275 insertions(+), 600 deletions(=
-).
> > > > > >
> > > > > > The main changes are:
> > > > > >
> > > > > > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> > > > > >
> > > > > > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kum=
ar Kartikeya Dwivedi.
> > > > > >
> > > > > > 3) next_thread cleanups, from Oleg Nesterov.
> > > > > >
> > > > > > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> > > > > >
> > > > > > 5) Add support for __percpu pointers in bpf progs, from Yonghon=
g Song.
> > > > > >
> > > > > > 6) Fix bpf tailcall interaction with bpf trampoline, from Leon =
Hwang.
> > > > > >
> > > > > > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to i=
mprove refill probabablity, from Hou Tao.
> > > > > >
> > > > > > Please consider pulling these changes from:
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t
> > > > > >
> > > > >
> > > > > This might have been raised already, but bpf on x86 now depends o=
n
> > > > > CONFIG_UNWINDER_ORC ?
> > > > >
> > > > > $ grep CONFIG_UNWINDER_ORC .config
> > > > > # CONFIG_UNWINDER_ORC is not set
> > > > >
> > > > > $ make ...
> > > > > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' =
in
> > > > > 'struct unwind_state'
> > > > >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > > > > (u64)state.sp, (u64)state.bp))
> > > > >                                                                  =
~~~~~ ^
> > > > > 1 error generated.
> > > >
> > > > Kumar,
> > > > can probably explain better,
> > > > but no the bpf as whole doesn't depend.
> > > > One feature needs either ORC or frame unwinder.
> > > > It won't work with unwinder_guess.
> > > > The build error is a separate issue.
> > > > It hasn't been reported before.
> > >
> > > In my builds, I do have CONFIG_UNWINDER_FRAME_POINTER=3Dy
> > >
> > > $ grep UNWIND .config
> > > # CONFIG_UNWINDER_ORC is not set
> > > CONFIG_UNWINDER_FRAME_POINTER=3Dy
> > >
> > >
> > > I note state.sp is only available to CONFIG_UNWINDER_ORC
> > >
> > > arch/x86/include/asm/unwind.h
> > >
> > > #if defined(CONFIG_UNWINDER_ORC)
> > >     bool signal, full_regs;
> > >     unsigned long sp, bp, ip;
> > >     struct pt_regs *regs, *prev_regs;
> > > #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
> > >    bool got_irq;
> > >    unsigned long *bp, *orig_sp, ip;   // this is orig_sp , not sp.
> >
> > Right. Our replies crossed.
> > Please ignore this PR. We need to fix this first.
>
> Hello,
> This is my bad. I totally missed it since I initially wrote this patch
> and never looked at it again.
> I suggest that I send a fix to disable this feature with
> CONFIG_UNWINDER_FRAME_POINTER=3Dy, while I work on reenabling it again
> for it with a follow up.

Hi, I've attached a fix that should disable it for now. I'll work on a
follow up to reenable it for this config option.
Really sorry about this, I'll try to be more careful going forward.

--000000000000edd0010605a2e5f9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bpf-Disable-exceptions-when-CONFIG_UNWINDER_FRAME_PO.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-Disable-exceptions-when-CONFIG_UNWINDER_FRAME_PO.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmoz52zi0>
X-Attachment-Id: f_lmoz52zi0

RnJvbSBlOTUyNDBlZGUwY2JlM2FhMzViYmIxMmJmN2ViMzllOTNjN2M2ZTYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAxOCBTZXAgMjAyMyAxNjowNzoyNyArMDIwMApTdWJqZWN0OiBbUEFU
Q0hdIGJwZjogRGlzYWJsZSBleGNlcHRpb25zIHdoZW4gQ09ORklHX1VOV0lOREVSX0ZSQU1FX1BP
SU5URVI9eQoKVGhlIGJ1aWxkIHdpdGggQ09ORklHX1VOV0lOREVSX0ZSQU1FX1BPSU5URVI9eSBp
cyBicm9rZW4gZm9yCmN1cnJlbnQgZXhjZXB0aW9ucyBmZWF0dXJlIGFzIGl0IGFzc3VtZXMgT1JD
IHVud2luZGVyIHNwZWNpZmljIGZpZWxkcyBpbgp0aGUgdW53aW5kX3N0YXRlLiBEaXNhYmxlIGV4
Y2VwdGlvbnMgd2hlbiBmcmFtZV9wb2ludGVyIHVud2luZGVyIGlzCmVuYWJsZWQgZm9yIG5vdy4K
CkZpeGVzOiBmZDVkMjdiNzAxODggKCJhcmNoL3g4NjogSW1wbGVtZW50IGFyY2hfYnBmX3N0YWNr
X3dhbGsiKQpSZXBvcnRlZC1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgpT
aWduZWQtb2ZmLWJ5OiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSA8bWVteG9yQGdtYWlsLmNvbT4K
LS0tCiBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMgfCA5ICsrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMgYi9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMKaW5k
ZXggODQwMDVmMjExNGUwLi44YzEwZDlhYmMyMzkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L25ldC9i
cGZfaml0X2NvbXAuYworKysgYi9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMKQEAgLTMwMDMs
MTYgKzMwMDMsMTUgQEAgdm9pZCBicGZfaml0X2ZyZWUoc3RydWN0IGJwZl9wcm9nICpwcm9nKQog
Ym9vbCBicGZfaml0X3N1cHBvcnRzX2V4Y2VwdGlvbnModm9pZCkKIHsKIAkvKiBXZSB1bndpbmQg
dGhyb3VnaCBib3RoIGtlcm5lbCBmcmFtZXMgKHN0YXJ0aW5nIGZyb20gd2l0aGluIGJwZl90aHJv
dwotCSAqIGNhbGwpIGFuZCBCUEYgZnJhbWVzLiBUaGVyZWZvcmUgd2UgcmVxdWlyZSBvbmUgb2Yg
T1JDIG9yIEZQIHVud2luZGVyCi0JICogdG8gYmUgZW5hYmxlZCB0byB3YWxrIGtlcm5lbCBmcmFt
ZXMgYW5kIHJlYWNoIEJQRiBmcmFtZXMgaW4gdGhlIHN0YWNrCi0JICogdHJhY2UuCisJICogY2Fs
bCkgYW5kIEJQRiBmcmFtZXMuIFRoZXJlZm9yZSB3ZSByZXF1aXJlIE9SQyB1bndpbmRlciB0byBi
ZSBlbmFibGVkCisJICogdG8gd2FsayBrZXJuZWwgZnJhbWVzIGFuZCByZWFjaCBCUEYgZnJhbWVz
IGluIHRoZSBzdGFjayB0cmFjZS4KIAkgKi8KLQlyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfVU5X
SU5ERVJfT1JDKSB8fCBJU19FTkFCTEVEKENPTkZJR19VTldJTkRFUl9GUkFNRV9QT0lOVEVSKTsK
KwlyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfVU5XSU5ERVJfT1JDKTsKIH0KIAogdm9pZCBhcmNo
X2JwZl9zdGFja193YWxrKGJvb2wgKCpjb25zdW1lX2ZuKSh2b2lkICpjb29raWUsIHU2NCBpcCwg
dTY0IHNwLCB1NjQgYnApLCB2b2lkICpjb29raWUpCiB7Ci0jaWYgZGVmaW5lZChDT05GSUdfVU5X
SU5ERVJfT1JDKSB8fCBkZWZpbmVkKENPTkZJR19VTldJTkRFUl9GUkFNRV9QT0lOVEVSKQorI2lm
IGRlZmluZWQoQ09ORklHX1VOV0lOREVSX09SQykKIAlzdHJ1Y3QgdW53aW5kX3N0YXRlIHN0YXRl
OwogCXVuc2lnbmVkIGxvbmcgYWRkcjsKIAotLSAKMi40MS4wCgo=
--000000000000edd0010605a2e5f9--

