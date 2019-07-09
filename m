Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933D363AA3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfGISOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 14:14:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34562 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfGISOP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 14:14:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so16766060qkt.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2019 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFMj9O7A4lS0sfbLVnlnBxmVS5gfbpYRwuVDf2uZTLM=;
        b=LnoNqvR3F2OB/v3omT6BtVV4ow9WC6uLE4VBZ8Jad2teKBKWGVwat1NsOqL61YHSg9
         7ozdWH+J6W1ylIUz6F8B1FyHSKgtcIPSvK1JPPXJtHOw6MskGAvQl3bnGWxMhu403R/a
         +akhawO+Hvimc1UJr5OgY2eSbl+RBy7nXXjRJIhqJ0i0LfZICr0CTUpBtyztqoaLDQVd
         ZwS31VPii3530Wh40gasLp7yB7QwndvgtXT2HkFTKDDOq2Q7Hnqc3d+6HQI+76qgW6Nk
         un7lrd5qJk22P7YbLuEh9D3vzZ4lR029pvy0MRpS8JVJtumeKCMwuYnxEhDjcXgo6RBI
         7i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFMj9O7A4lS0sfbLVnlnBxmVS5gfbpYRwuVDf2uZTLM=;
        b=nmZ88bcUC/hdjoqKpkl5IOXcJf0KIeGFtTTPowvPm7/ti2outhzltwFGnVQO6mOp12
         cUBLfzQiqQ++M7nifeudygyLr2Y/BjSuPewk4tMHjNn9V28fQbG7knF1xWi1DuNvanZ3
         q2GnhZ78Fy2v1zvNOKPc8sC53bhctPOa/0RFAyMipKCJrmLIEovzQV7PiLkGQlFVbzYm
         VURynVTcy5XoPwhzyCpyFQyEO3y0vXzy78cIIqG0C8Xw4Xfugns5o6eckWvBeg+8oSK7
         nXF/T15PAv3wrXoTKf5v6XBlptabKyMHwxdzoe6gp/M+tFrsDpDz9vMDUjM5fNFPdu6a
         0Srg==
X-Gm-Message-State: APjAAAWUFLjuwxP2CwMGVHRclHRPvrTmUSa+x1LmVqTxTMz5iSz6r8s8
        lvC9AENsD8p+z2opeYS2CRBBhU+m4kqY2WiRhWE=
X-Google-Smtp-Source: APXvYqzOcuz4Mw+1in5aMolTxqhUNQLIZ6IYFwKF7qwXpW1hFQ0g/Fb2ELiCzi1N0J4zOWrBke2enJ7kx+yf6RxbWrA=
X-Received: by 2002:a37:bf42:: with SMTP id p63mr20359920qkf.437.1562696054023;
 Tue, 09 Jul 2019 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
 <20190701184025.25731-1-iii@linux.ibm.com> <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
 <59B1630A-537D-43A1-B75C-87BE80709F93@linux.ibm.com>
In-Reply-To: <59B1630A-537D-43A1-B75C-87BE80709F93@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Jul 2019 11:14:03 -0700
Message-ID: <CAEf4BzZEs24=Cp8CdQiXtGXCcMtW430ER7wDHND7YA7OVfz3XA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 8, 2019 at 8:01 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> > Am 05.07.2019 um 16:22 schrieb Daniel Borkmann <daniel@iogearbox.net>:
> >
> > On 07/01/2019 08:40 PM, Ilya Leoshkevich wrote:
> >> Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.=
com>:
> >>> Do we still need clang | llc pipeline with new clang? Could the same
> >>> be achieved with single clang invocation? That would solve the proble=
m
> >>> of not detecting pipeline failures.
> >>
> >> I=E2=80=99ve experimented with this a little, and found that new clang=
:
> >>
> >> - Does not understand -march, but -target is sufficient.
> >> - Understands -mcpu.
> >> - Understands -Xclang -target-feature -Xclang +foo as a replacement fo=
r
> >>  -mattr=3Dfoo.
> >>
> >> However, there are two issues with that:
> >>
> >> - Don=E2=80=99t older clangs need to be supported? For example, right =
now alu32
> >>  progs are built conditionally.
> >
> > We usually require latest clang to be able to test most recent features=
 like
> > BTF such that it helps to catch potential bugs in either of the project=
s
> > before release.
> >
> >> - It does not seem to be possible to build test_xdp.o without -target
> >>  bpf.
> >
> > For everything non-tracing, it does not make sense to invoke clang w/o
> > the -target bpf flag, see also Documentation/bpf/bpf_devel_QA.rst +573
> > for more explanation, so this needs to be present for building test_xdp=
.o.
>
> I'm referring to the test introduced in [1]. test_xdp.o might not be an
> ideal target, but even if it's replaced with a more suitable one, the
> llc invocation would still be required. So I could redo the patch as
> follows:
>
> - Replace test_xdp.o with get_cgroup_id_kern.o, use an intermediate .bc
>   file.
> - Use clang without llc for all other eBPF programs.
> - Split out Kbuild include and order-only prerequisites.
>
> What do you think?

How about just forcing llc to fail as well like this:

(clang <whatever> || echo "clain failed") | llc <whatever>

While not pretty, it will get us what we need with very clear
messaging as well. E.g.:

progs/test_btf_newkv.c:21:37: error: expected identifier
PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
                                    ^
progs/test_btf_newkv.c:21:1: warning: type specifier missing, defaults
to 'int' [-Wimplicit-int]
PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
^
1 warning and 1 error generated.
llc: error: llc: <stdin>:1:1: error: expected top-level entity
clang failed
^

>
> [1] https://lore.kernel.org/netdev/1541593725-27703-1-git-send-email-quen=
tin.monnet@netronome.com/
>
> Best regards,
> Ilya
