Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850066605F
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 17:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjAKQZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 Jan 2023 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjAKQZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 11:25:15 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A20373B0;
        Wed, 11 Jan 2023 08:21:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id u9so38206940ejo.0;
        Wed, 11 Jan 2023 08:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DXJPy/Pk1SGO6M8vS+/vVNiY2j49Leord0f9bwih1I=;
        b=AQODSh3jKybMUYZdF7trgotRE7C0tYH54DOA0ZPga9k/yCGKSETsf72zQJ1fEKNIHI
         yW+i4En3XGn2TohvPQ40cB4Yi9T8/kAc7Dvlisj0thlgAkJyBfd8O3cFPF3G7vYNMcrQ
         2g/7v1bAdqg6KxRqVjpmz9otBfGP0m/bOl1dXQpChHSiqlHKF59oYSsLzz1qICbtNSU9
         WeYBUocNv2ESguI8RywNaH0mHlJ4z2TfefDRDfiawR2zvmXL824F5O6XMpFLNrD1TdNv
         lw3ZkGW7J51KRH76YG9FJwhiazWMOKrYSzgPAnNAiPYx9E/HxxWi8H9tMFJsbhF+osTg
         53Hw==
X-Gm-Message-State: AFqh2kpKSa6RrUqNf1orA5wDX5lSmxDiOfhA358LlHEymQkqFLcU6pNh
        Wo4Rx6bVEyM5NBVXtSGNykO7eE9Ht5T0kYVf
X-Google-Smtp-Source: AMrXdXuk+bhhc4tFsTkvQUcsmf5aN5X/AybwvNxXd9OQ4WHhEXGVP+cMakvXsA+ubGZJB3cYNHuJ2w==
X-Received: by 2002:a17:907:73c1:b0:7e8:cf25:4b9c with SMTP id es1-20020a17090773c100b007e8cf254b9cmr57813609ejc.59.1673454113562;
        Wed, 11 Jan 2023 08:21:53 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm6318153ejf.210.2023.01.11.08.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:21:53 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id b4so3544974edf.0;
        Wed, 11 Jan 2023 08:21:52 -0800 (PST)
X-Received: by 2002:a05:6402:1d8f:b0:48c:fc4f:f837 with SMTP id
 dk15-20020a0564021d8f00b0048cfc4ff837mr3605348edb.79.1673454112657; Wed, 11
 Jan 2023 08:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <CAEg-Je-hOFT34_TBD_YwUNsOjdJv_O=VAL7ojXmEqQ6ybOp8Jg@mail.gmail.com>
 <CAOgh=FxuUA_-rcp-p-R-WV6zYhywztNeXOfpuO5rFo=UJ5xVJA@mail.gmail.com>
In-Reply-To: <CAOgh=FxuUA_-rcp-p-R-WV6zYhywztNeXOfpuO5rFo=UJ5xVJA@mail.gmail.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 11 Jan 2023 11:21:16 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-Auc4u5OzJWL7VmFKLn3ASN1DAMFTfFkge4ddwZ7RJmg@mail.gmail.com>
Message-ID: <CAEg-Je-Auc4u5OzJWL7VmFKLn3ASN1DAMFTfFkge4ddwZ7RJmg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 11:16 AM Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Wed, 11 Jan 2023 at 15:34, Neal Gompa <neal@gompa.dev> wrote:
> >
> > On Wed, Jan 11, 2023 at 10:21 AM Martin Rodriguez Reboredo
> > <yakoyoku@gmail.com> wrote:
> > >
> > > Version 1.24 of pahole has the capability to exclude compilation units
> > > (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> > > currently supported by pahole and if it's used with a build that has
> > > BTF debugging enabled it results in malformed kernel and module
> > > binaries [3]. So it's better for pahole to exclude Rust CUs until
> > > support for it arrives.
> > >
> > > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> > > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> > > Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
> > >
> > > Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> > > Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> > > Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > ---
> > > V2 -> V3: Enable pahole option upon comparing with version 1.24
> > > V1 -> V2: Removed dependency on auto.conf
> > >
> > >  init/Kconfig            | 2 +-
> > >  lib/Kconfig.debug       | 9 +++++++++
> > >  scripts/pahole-flags.sh | 4 ++++
> > >  3 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 694f7c160c9c..360aef8d7292 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1913,7 +1913,7 @@ config RUST
> > >         depends on !MODVERSIONS
> > >         depends on !GCC_PLUGINS
> > >         depends on !RANDSTRUCT
> > > -       depends on !DEBUG_INFO_BTF
> > > +       depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> >
> > Does the order matter here? I'd rather it prefer a fixed pahole and
> > disable BTF only if we can't use pahole properly.
>
> The order won't matter.
>

Then it looks good to me!

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
