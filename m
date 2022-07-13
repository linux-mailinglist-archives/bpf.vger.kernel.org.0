Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD9573DCB
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiGMU0c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMU0b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:26:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66226286E1
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:26:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dn9so21841682ejc.7
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFUOn4wr/24sl9jkv4STkRkyogGm46ATFF5esA58W1o=;
        b=f03pA/ylIynto6euuZjb7gJYrMzjJxgAbJd9t9LCuTjReAKiW04vIUv8sFwxUjOGJC
         rXeo+m1FS+Xi3lYYedeRfwYk33rixpipLUjyQGZyQdMJ82bTTzfoDhuAzdZGkjeDP0Cn
         VeC70AzVT+J9jtKoeMHJ6o787kem0VCcIt0YDjbyXUzaONVAazqNd5Duo/HbKtpZKS1B
         Ac03LKXYKc6VS+vLEjT86h/WVcf4mWZ2SJ8zvUKsHym3kkG4BLHjpGPujojcLai1fAMp
         Vw1tOv4OtEAoa1Gix6yBgVpx/fjVNv0z72wS6A1G6y7ck5Q0JenpBiIKgWtLgYd2I2Vj
         Gl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFUOn4wr/24sl9jkv4STkRkyogGm46ATFF5esA58W1o=;
        b=Mw/fjSO2qx6nvjUSl3DdOodmM4p4eVA54j8IuORufk+G5WCRUXNCVUPsjtEfoXvGBZ
         V5Aen2Hvhl8HVPUZcxdL6HdeUiyqNS6qNUElik+W7syNvvvfi7Qun/cyi3vloC2JB8JI
         Yuhllp5pUd6852hTz5z56mropSwop433wBL8DCoio1T/sLPQOAnqjEqHpB2wVP5GXdpM
         0ydBFrZqm5Wdov5HY7unditHPHI0iLr4Jtzir4oacG01hOwCx0lYd8cdj804vKwTQnm7
         2jVcqoBKEdQZBmvTaHjqA4y186uGSEY/kuep2w++qNhPQ0X7+pnnNdmBHnCE52jn5Kef
         rcow==
X-Gm-Message-State: AJIora8r2wNJqFIKz67+If1oh5c7bjd28LrPvjEJ74v88GDSvvNPPtA5
        EoVFof/6HEsZyhh3tt3o/ixlSQU3MKhYLFbEXP6JMuYDNHE=
X-Google-Smtp-Source: AGRyM1v2Ap7SWZQrvrzLAwB21eVX1sfDug/yZHwZ95dh7Q/Yh9eqnk33liq8i2n9JfMexHoyOtM9GB6bRvPQkiFHtYw=
X-Received: by 2002:a17:906:5a6c:b0:72b:561a:3458 with SMTP id
 my44-20020a1709065a6c00b0072b561a3458mr5253191ejc.114.1657743987917; Wed, 13
 Jul 2022 13:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-2-andrii@kernel.org>
 <Ys7xxbyYWhrqsQka@google.com> <CAEf4BzYUVD2F9Hrn4SgYHcjX=UA5G=57Uw9+uH9P6oJ3X0xbdQ@mail.gmail.com>
 <CAKH8qBtGNyk1HXNjNjw9owCsRSTutOyBDsmGrwSXu7wE2PspQQ@mail.gmail.com>
In-Reply-To: <CAKH8qBtGNyk1HXNjNjw9owCsRSTutOyBDsmGrwSXu7wE2PspQQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 13:26:16 -0700
Message-ID: <CAEf4BzY5r9HsXAuAKT2Mu2dgNd9830DNQqD4ZKmP-yCH_uTXjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs
 and use it for USDT
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 11:57 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:08 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 9:24 AM <sdf@google.com> wrote:
> > >
> > > On 07/12, Andrii Nakryiko wrote:
> > > > Libbpf supports single virtual __kconfig extern currently:
> > > > LINUX_KERNEL_VERSION.
> > > > LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
> > > > customly filled out by libbpf.
> > >
> > > > This patch generalizes this approach to support more such virtual
> > > > __kconfig externs. One such extern added in this patch is
> > > > LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
> > > > usdt.bpf.h instead of using CO-RE-based enum detection approach for
> > > > detecting bpf_get_attach_cookie() BPF helper. This allows to remove
> > > > otherwise not needed CO-RE dependency and keeps user-space and BPF-side
> > > > parts of libbpf's USDT support strictly in sync in terms of their
> > > > feature detection.
> > >
> > > > We'll use similar approach for syscall wrapper detection for
> > > > BPF_KSYSCALL() BPF-side macro in follow up patch.
> > >
> > > > Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
> > > > and LINUX_ for virtual libbpf-backed externs. In the future we might
> > > > extend the set of prefixes that are supported. This can be done without
> > > > any breaking changes, as currently any __kconfig extern with
> > > > unrecognized name is rejected.
> > >
> > > > For LINUX_xxx externs we support the normal "weak rule": if libbpf
> > > > doesn't recognize given LINUX_xxx extern but such extern is marked as
> > > > __weak, it is not rejected and defaults to zero.  This follows
> > > > CONFIG_xxx handling logic and will allow BPF applications to
> > > > opportunistically use newer libbpf virtual externs without breaking on
> > > > older libbpf versions unnecessarily.
> > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >   tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
> > > >   tools/lib/bpf/usdt.bpf.h | 16 ++--------
> > > >   2 files changed, 52 insertions(+), 33 deletions(-)
> > >

[...]

> > >
> > > > -/* don't rely on user's BPF code to have latest definition of
> > > > bpf_func_id */
> > > > -enum bpf_func_id___usdt {
> > > > -     BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> > > > -};
> > > > +extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
> > >
> > > Could _Bool be a problem when used by c++? I remember that we can have
> > > sizeof(bool) != sizeof(_Bool) when compiling with g++. If we were to
> > > use 'int' instead I'm assuming we'll loose all the niceties of
> > > KCFG_BOOL?
> > >
> > > Or shouldn't be a problem since it's not part of C/C++ api boundary?
> >
> > I actually don't know if C++ supports "_Bool", but in C, "bool" is an
> > alias to _Bool. _Bool is *the type* of the boolean. The benefit of
> > _Bool is that it doesn't require including stdbool.h, while "bool"
> > itself needs extra header. So I try not to use bool in libbpf BPF API
> > headers just to avoid extra header dependencies.
> >
> > But it shouldn't matter as this is BPF-side code, so it has to be
> > compiled in C mode by Clang/GCC, so _Bool should always be there.
>
> The program is fine, but these _Bool's can now leak into generated
> skeletons, right?
> And skeletons might be included into c++ and I'm not sure what happens
> with _Bool over there.
>
> My naive attempt to use it gives me the following:
>
> $ cat tst.cc
> int main(int argc, char *argv[])
> {
>     _Bool have_args = argc > 1;
>     if (have_args)
>         return 1;
>     else
>         return 0;
> }
> $ clang++ tst.cc
> tst.cc:3:5: error: unknown type name '_Bool'
>     _Bool have_args = argc > 1;
>     ^
> 1 error generated.

Check test_cpp.cpp, it includes test_core_extern.skel.h, which has
bool externs in it. In generated code those bools are emitted as _Bool
(because that's what gets emitted to BTF by Clang). It seems to be
working fine with g++ already, and I just confirmed that clang++ also
works. So not sure what's different (perhaps stdbool.h included
somewhere "fixes" this for C++), but I don't it's the problem.

>
> > As for the size it seems like it's not even specified by the standard
> > that sizeof(bool/_Bool) is 1, though it is in practice. I only
> > remember some very-very-very old versions of Microsoft's Visual C++
> > having sizeof(bool) == 4, but then they changed that anyways to
> > sizeof(bool) == 1 (it was many-many years ago, so it might be an
> > incomplete story).
> >
> > But either way it doesn't matter, because libbpf will support any
> > size: 1, 2, 4, 8 and will just set 1 for true, 0 for false, with
> > correct zero extension to match variable size.
> >
> > As for bool vs int, no real difference, but it is true/false
> > conceptually, so seems cleaner to use bool. But using int will work
> > just fine here as well (you still get 0 or 1 for both, effectively).
>
> Yeah, so my question is more like: rather than trying to figure out if
> _Bool is safe, might it be easier to stick to ints?
>

I don't mind, but seems like it should be fine. It's not the first
bool used in skeleton, so if it didn't work, we'd be already suffering
and fixing it with some other means.

>
> > > >   static __always_inline
> > > >   int __bpf_usdt_spec_id(struct pt_regs *ctx)
> > > >   {
> > > > -     if (!BPF_USDT_HAS_BPF_COOKIE) {
> > > > +     if (!LINUX_HAS_BPF_COOKIE) {
> > > >               long ip = PT_REGS_IP(ctx);
> > > >               int *spec_id_ptr;
> > >
> > > > --
> > > > 2.30.2
> > >
