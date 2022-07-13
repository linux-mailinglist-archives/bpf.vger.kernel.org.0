Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF505573EA5
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGMVOu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGMVOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:14:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0B32DAA
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 14:14:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so5823824pjm.2
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1k5D0mzBiep4vh9eUptvdPGu2xOXJjsJbDHey55O21g=;
        b=blbcKLiqz1+6woD7JU8XNushFLUVTvXd1Km/RzCWKvdRifbsb5mWqVSP/KKgNpa3bJ
         iopz4VjQY5MF47/7sPNZamse0Qtom6/1RADIENmsoCIVzQFjqCKvcaGT248cXojU1kL7
         AcgQ75WqTb8peVMBlfGSq9po8UM2EJR+jwnZ0huxDnBKIkN9o/jOcOhouR37Z285Jgqz
         IFVWuzbBYHkRLREmKneHRWU3vORpZwkjktg4Z3xEN7Jz61XJmXcKDg85TlHI6M68v/FM
         3hKnQJdp4W2QIVb21ayAYQOXDvkUzndoh6pxaBikgZQ4nBDRFrIN5dUXQtGh7PkpHV1/
         nkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1k5D0mzBiep4vh9eUptvdPGu2xOXJjsJbDHey55O21g=;
        b=mmafdf3lBy2k7z7zwJ9w6lFiuSAykQrFzHGbeJuB1c3me3B2N8+f3J43yA+gjBJ9yg
         zP1T1NgopgnmRzPS6cCA6p2uRXt6eHSFea4WK5DqcXEQ/6d8fj4hcxcjV6GAJe/6oU0Y
         E19TqyM9HjXVMNgL1913qA4LeZ6T7XzYVc8YwpORwrduY1+9N45MR/qAVBRNSJRUWonB
         4xN3ttCEulaaICbiwO2yZuYGb4qQJgYNYZdaRvONRihv7EgQjP3W+nVdFtFfEhl1bR9F
         ARuVlbTTuypcnzopoWEsqZR0n7VOM7NLvMc2gz9RDQopLKxN/xijKG84gIc3KdMKZ2RF
         bMFw==
X-Gm-Message-State: AJIora9pFkISGXp14dg4Xjd9oNfidv4MKvPEvG7CVWQH6h6nJghFvaQr
        yaX8MDe4n+ZSsmaXFKSyD6m2+CYA15Qp2f+VrcUrDnOgigP3jAH/
X-Google-Smtp-Source: AGRyM1vw6HQHe3wuRSdfogrieT5arDpqc9F6+rBGxI3cEwELPJZpWbEtA+CLw0MsNCYdDakeuB37o0uYw9NjUR1mcK8=
X-Received: by 2002:a17:90b:4b4d:b0:1ef:bff5:de4f with SMTP id
 mi13-20020a17090b4b4d00b001efbff5de4fmr12204442pjb.120.1657746887910; Wed, 13
 Jul 2022 14:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-2-andrii@kernel.org>
 <Ys7xxbyYWhrqsQka@google.com> <CAEf4BzYUVD2F9Hrn4SgYHcjX=UA5G=57Uw9+uH9P6oJ3X0xbdQ@mail.gmail.com>
 <CAKH8qBtGNyk1HXNjNjw9owCsRSTutOyBDsmGrwSXu7wE2PspQQ@mail.gmail.com> <CAEf4BzY5r9HsXAuAKT2Mu2dgNd9830DNQqD4ZKmP-yCH_uTXjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY5r9HsXAuAKT2Mu2dgNd9830DNQqD4ZKmP-yCH_uTXjQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 14:14:36 -0700
Message-ID: <CAKH8qBuntdR6GE=F2v_jxTn5Am02_279Hi1P+0wTOBgmaEGeKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs
 and use it for USDT
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 1:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:57 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 11:08 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 9:24 AM <sdf@google.com> wrote:
> > > >
> > > > On 07/12, Andrii Nakryiko wrote:
> > > > > Libbpf supports single virtual __kconfig extern currently:
> > > > > LINUX_KERNEL_VERSION.
> > > > > LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
> > > > > customly filled out by libbpf.
> > > >
> > > > > This patch generalizes this approach to support more such virtual
> > > > > __kconfig externs. One such extern added in this patch is
> > > > > LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
> > > > > usdt.bpf.h instead of using CO-RE-based enum detection approach for
> > > > > detecting bpf_get_attach_cookie() BPF helper. This allows to remove
> > > > > otherwise not needed CO-RE dependency and keeps user-space and BPF-side
> > > > > parts of libbpf's USDT support strictly in sync in terms of their
> > > > > feature detection.
> > > >
> > > > > We'll use similar approach for syscall wrapper detection for
> > > > > BPF_KSYSCALL() BPF-side macro in follow up patch.
> > > >
> > > > > Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
> > > > > and LINUX_ for virtual libbpf-backed externs. In the future we might
> > > > > extend the set of prefixes that are supported. This can be done without
> > > > > any breaking changes, as currently any __kconfig extern with
> > > > > unrecognized name is rejected.
> > > >
> > > > > For LINUX_xxx externs we support the normal "weak rule": if libbpf
> > > > > doesn't recognize given LINUX_xxx extern but such extern is marked as
> > > > > __weak, it is not rejected and defaults to zero.  This follows
> > > > > CONFIG_xxx handling logic and will allow BPF applications to
> > > > > opportunistically use newer libbpf virtual externs without breaking on
> > > > > older libbpf versions unnecessarily.
> > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >   tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
> > > > >   tools/lib/bpf/usdt.bpf.h | 16 ++--------
> > > > >   2 files changed, 52 insertions(+), 33 deletions(-)
> > > >
>
> [...]
>
> > > >
> > > > > -/* don't rely on user's BPF code to have latest definition of
> > > > > bpf_func_id */
> > > > > -enum bpf_func_id___usdt {
> > > > > -     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > > > > -};
> > > > > +extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
> > > >
> > > > Could _Bool be a problem when used by c++? I remember that we can have
> > > > sizeof(bool) != sizeof(_Bool) when compiling with g++. If we were to
> > > > use 'int' instead I'm assuming we'll loose all the niceties of
> > > > KCFG_BOOL?
> > > >
> > > > Or shouldn't be a problem since it's not part of C/C++ api boundary?
> > >
> > > I actually don't know if C++ supports "_Bool", but in C, "bool" is an
> > > alias to _Bool. _Bool is *the type* of the boolean. The benefit of
> > > _Bool is that it doesn't require including stdbool.h, while "bool"
> > > itself needs extra header. So I try not to use bool in libbpf BPF API
> > > headers just to avoid extra header dependencies.
> > >
> > > But it shouldn't matter as this is BPF-side code, so it has to be
> > > compiled in C mode by Clang/GCC, so _Bool should always be there.
> >
> > The program is fine, but these _Bool's can now leak into generated
> > skeletons, right?
> > And skeletons might be included into c++ and I'm not sure what happens
> > with _Bool over there.
> >
> > My naive attempt to use it gives me the following:
> >
> > $ cat tst.cc
> > int main(int argc, char *argv[])
> > {
> >     _Bool have_args = argc > 1;
> >     if (have_args)
> >         return 1;
> >     else
> >         return 0;
> > }
> > $ clang++ tst.cc
> > tst.cc:3:5: error: unknown type name '_Bool'
> >     _Bool have_args = argc > 1;
> >     ^
> > 1 error generated.
>
> Check test_cpp.cpp, it includes test_core_extern.skel.h, which has
> bool externs in it. In generated code those bools are emitted as _Bool
> (because that's what gets emitted to BTF by Clang). It seems to be
> working fine with g++ already, and I just confirmed that clang++ also
> works. So not sure what's different (perhaps stdbool.h included
> somewhere "fixes" this for C++), but I don't it's the problem.

Oh, didn't know we already export them. Looks like we do include
stdbool.h eventually and it does:
#define _Bool bool

In this case, yeah, ignore me, I was thinking that it's the first
_Bool being "exported".
