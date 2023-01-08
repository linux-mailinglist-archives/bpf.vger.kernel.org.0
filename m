Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0966187C
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjAHTUz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 14:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjAHTUv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 14:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061E6476
        for <bpf@vger.kernel.org>; Sun,  8 Jan 2023 11:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673205603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGWOldglTZNuYLIRTUhiHDe8Itvv2F7MA7RR2Udh84E=;
        b=AxMqI9v4qLa+TNKccnKTW0NMIreKzM24l44hC1yGSBe7I0tt3u0AHZVSyHf664/5OjYDrf
        pCRBZEdEWD3u9VMxefAmsAbETc5pkihcF7bgYGFPN00iSqD1jYQ9B3Vf05W3D23iYikRb8
        3YSzgmztT1fBzIjEhuB7jp2neAGtTBo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-FgPDdZdRO9aIQ38zWWrjpQ-1; Sun, 08 Jan 2023 14:19:54 -0500
X-MC-Unique: FgPDdZdRO9aIQ38zWWrjpQ-1
Received: by mail-ua1-f70.google.com with SMTP id a5-20020ab00805000000b0052816f498d8so3296757uaf.1
        for <bpf@vger.kernel.org>; Sun, 08 Jan 2023 11:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGWOldglTZNuYLIRTUhiHDe8Itvv2F7MA7RR2Udh84E=;
        b=2Wamw+a30skOQDx465KjFKo6xhFfIcEklTXjK2GLTVivkq/mnuAoqqgfQvq1PeWDAE
         HXOqedlo/dDhwBf3UPeafWKmH5x++KJTvansPiLZ1fBeJGBjF23YlU4pWN8DnMtinGXS
         ej804WiXosaK3ZDtlNP7Bq1/Nu471B4Xcq2V/dCDivnhgtuyUe9fhDCmbskOLKZrsd/O
         OlE/slyel0c6WmMPKMPM8XEwOJptIEmBAtq18/M9UJjZnBHSRYFsNk1Zv9EyppswuO13
         HlGMIj1ywgl8CDFIWhKgrpD1pb2ombcgHfQnxCj6ugNMH0ZSur3JpxG8D8bt2g3vFVHg
         CxCg==
X-Gm-Message-State: AFqh2krwx1/wqsCxHmpQ/CjUPnEkH/fvwEJ/7lg0VqSqxR8Lj9Q1WzgJ
        prCLMC9Be9pNskPFd4sO3l13Lva2EEIloxY7LDuU5dMJYMlAk5OBtpdO9CIImSyCaRxFDE/TGGx
        uNK9fL+SRPn+z0p69fsG4rZTdGcDG
X-Received: by 2002:a1f:add4:0:b0:3d5:42a2:5e01 with SMTP id w203-20020a1fadd4000000b003d542a25e01mr5820271vke.17.1673205592822;
        Sun, 08 Jan 2023 11:19:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvrE0KA+L2UWzyCz8oDv1qyJUvHwkro33C4K3lgEK9XL1Gh3ge6pVg1XYnyBegKhG1mGQ4M7rJKXAAiqBb/Mqo=
X-Received: by 2002:a1f:add4:0:b0:3d5:42a2:5e01 with SMTP id
 w203-20020a1fadd4000000b003d542a25e01mr5820264vke.17.1673205592530; Sun, 08
 Jan 2023 11:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20230108021450.120791-1-yakoyoku@gmail.com> <CAOgh=Fzc3_bCLCKE+6KVzyMbBUOcQ_s9ef6Rw33amD5+yu-_WA@mail.gmail.com>
In-Reply-To: <CAOgh=Fzc3_bCLCKE+6KVzyMbBUOcQ_s9ef6Rw33amD5+yu-_WA@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 8 Jan 2023 19:19:36 +0000
Message-ID: <CAOgh=FxxXQ0UV_3PEGS-_575WNfR2SpKp+i78HtSVX4XO4eC0A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 8 Jan 2023 at 15:18, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Sun, 8 Jan 2023 at 02:15, Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
> >
> > Version 1.24 of pahole has the capability to exclude compilation units
> > (CUs) of specific languages. Rust, as of writing, is not currently
> > supported by pahole and if it's used with a build that has BTF debugging
> > enabled it results in malformed kernel and module binaries (see
> > Rust-for-Linux/linux#735). So it's better for pahole to exclude Rust
> > CUs until support for it arrives.
> >
> > Reviewed-by: Eric Curtin <ecurtin@redhat.com>
> > Tested-by: Eric Curtin <ecurtin@redhat.com>
> > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > Tested-by: Neal Gompa <neal@gompa.dev>
> > Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > ---
> > V1 -> V2: Removed dependency on auto.conf
> >
> >  init/Kconfig              | 2 +-
> >  lib/Kconfig.debug         | 9 +++++++++
> >  scripts/Makefile.modfinal | 4 ++++
> >  scripts/link-vmlinux.sh   | 4 ++++
> >  4 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 694f7c160c9c..360aef8d7292 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1913,7 +1913,7 @@ config RUST
> >         depends on !MODVERSIONS
> >         depends on !GCC_PLUGINS
> >         depends on !RANDSTRUCT
> > -       depends on !DEBUG_INFO_BTF
> > +       depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> >         select CONSTRUCTORS
> >         help
> >           Enables Rust support in the kernel.
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index ea4c903c9868..d473d491e709 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
> >           btf_decl_tag) or not. Currently only clang compiler implements
> >           these attributes, so make the config depend on CC_IS_CLANG.
> >
> > +config PAHOLE_HAS_LANG_EXCLUDE
> > +       def_bool PAHOLE_VERSION >= 124
> > +       help
> > +         Support for the --lang_exclude flag which makes pahole exclude
> > +         compilation units from the supplied language. Used in Kbuild to
> > +         omit Rust CUs which are not supported in version 1.24 of pahole,
> > +         otherwise it would emit malformed kernel and module binaries when
> > +         using DEBUG_INFO_BTF_MODULES.
> > +
> >  config DEBUG_INFO_BTF_MODULES
> >         def_bool y
> >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 25bedd83644b..a880f2d6918f 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -30,6 +30,10 @@ quiet_cmd_cc_o_c = CC [M]  $@
> >
> >  ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
> >
> > +ifdef CONFIG_RUST
> > +PAHOLE_FLAGS += --lang_exclude=rust
> > +endif
> > +
> >  quiet_cmd_ld_ko_o = LD [M]  $@
> >        cmd_ld_ko_o +=                                                   \
> >         $(LD) -r $(KBUILD_LDFLAGS)                                      \
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 918470d768e9..69eb0bea89bf 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -122,6 +122,10 @@ gen_btf()
> >                 return 1
> >         fi
> >
> > +       if is_enabled CONFIG_RUST; then
> > +               PAHOLE_FLAGS="${PAHOLE_FLAGS} --lang_exclude=rust"
> > +       fi
>
> If it was me, I would do things more like v1 of the patch (instead
> just checking pahole version), because this is the only flag set in
> scripts/Makefile.modfinal, which is a little confusing and
> inconsistent. It's ok to set --lang_exclude=rust in all cases, as long
> as pahole_ver is recent enough.
>
> +if [ "${pahole_ver}" -ge "124" ]; then
> +       # see PAHOLE_HAS_LANG_EXCLUDE
> +       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +fi
>
> But I'm not too opinionated either on this so...
>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
>
> can be reapplied. I'm gonna test this again to see if it works in a
> Fedora Asahi rpm build.

After testing I probably have to retract my Reviewed-by tag,
apologies, bpf and all that did not work with this patch when I built
in the fedora way, but, the good news is when I alter v1 of the patch
to just check pahole version like so (instead of the is_enabled
check):

+if [ "${pahole_ver}" -ge "124" ]; then
+        # see PAHOLE_HAS_LANG_EXCLUDE
+        extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
+fi

it worked just fine, and that should satisfy the testbot and all the
other ways we build too. Could we change to that @Martin Rodriguez
Reboredo ?

>
>
> > +
> >         vmlinux_link ${1}
> >
> >         info "BTF" ${2}
> > --
> > 2.39.0
> >

