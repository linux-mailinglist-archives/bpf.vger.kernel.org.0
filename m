Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2725B4B7AD3
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiBOW5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 17:57:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244707AbiBOW5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 17:57:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901EFB3E4C
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 14:56:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c10so641734ljr.9
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 14:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Rudsg4/aOy/jdyhsSWJWFGI4znB4WD+Ii8G12zC9Nc=;
        b=j5qNrOw4KZOloLLjvNpXBoqTEpmgtLMbECmOR+kwE3JSrQQF+wIw2cT/gDWIHXBpuA
         HppNp+B0xUvUQ67WrvvdGxF/xxC7eGNMbWXyYIpofq45B24Ad0a5m7dK6NNnIQtc/Nhv
         gfeSei2B3haqroNBjoJGYAgLNrQWidG0hV8EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Rudsg4/aOy/jdyhsSWJWFGI4znB4WD+Ii8G12zC9Nc=;
        b=TfQAvEZGhIataFz/qU8kSB9cO/GObqU2GAj88Zh9GAd2VKpMQG2oS+r2tq18EvwMfN
         p7kDWTt2BuHdZHYtuYoKEhrSPfnPUa7/lPyzuYU77JpFR90OX9CycMuLeDpNRjHVo2R9
         k1cIsw4iyLuqO3teetl4lZPeUDaMPRWpm9qXUguJmCKPsRGBPQZOjUPyv2SDsr7LDkrb
         gcunttEitOJHuzbogkhvrFkTw2MvPG4tQe4znIEY5L6ggVBElaE0II5rcbYLIFJeKsmj
         ruYReMrTUxQRud+cD1Wwi896CS5By66VZkUw1X8TgwLHgxTO8LcwooOuI2jCitQ4jXLH
         fRpg==
X-Gm-Message-State: AOAM530QyNX6XWBiubmQ9XYNBOiKwN3w8y+zYwu56LCcnv7wN16IMz8S
        U52pmNg1Wg4vxYE2G11qXPESS5VyeIEphqj2Q5EiXA==
X-Google-Smtp-Source: ABdhPJz3BVAV85ar7UFxQnh0GbPZOCxut/t1YPLrE0wZmx4l95hzHY8n9c2AEDOIvFGLYba2do0+uhJaAMN2t/b1n10=
X-Received: by 2002:a2e:9c82:0:b0:23a:eea8:cd0f with SMTP id
 x2-20020a2e9c82000000b0023aeea8cd0fmr51725lji.218.1644965806968; Tue, 15 Feb
 2022 14:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20220209222646.348365-1-mauricio@kinvolk.io> <20220209222646.348365-7-mauricio@kinvolk.io>
 <CAEf4BzYp4bCBYrbXGw75x6WFqM_k6Bhy3D73hR9TR1O8S7gXcQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYp4bCBYrbXGw75x6WFqM_k6Bhy3D73hR9TR1O8S7gXcQ@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Tue, 15 Feb 2022 17:56:36 -0500
Message-ID: <CAHap4ztLNVm81jchDkAe15UybKRCFEJNci-BFFCRQf86iW_pVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/7] bpftool: gen min_core_btf explanation and examples
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 11, 2022 at 7:42 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 9, 2022 at 2:27 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io=
> wrote:
> >
> > From: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> >
> > Add "min_core_btf" feature explanation and one example of how to use it
> > to bpftool-gen man page.
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-gen.rst | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
>
> [...]
>
> > +Now, the "5.4.0-smaller.btf" file may be used by libbpf as an external=
 BTF file
> > +when loading the "one.bpf.o" object into the "5.4.0-example" kernel. N=
ote that
> > +the generated BTF file won't allow other eBPF objects to be loaded, ju=
st the
> > +ones given to min_core_btf.
> > +
> > +::
> > +
> > +  struct bpf_object *obj =3D NULL;
> > +  struct bpf_object_open_opts openopts =3D {};
> > +
> > +  openopts.sz =3D sizeof(struct bpf_object_open_opts);
> > +  openopts.btf_custom_path =3D "./5.4.0-smaller.btf";
> > +
> > +  obj =3D bpf_object__open_file("./one.bpf.o", &openopts);
>
> Can you please use LIBBPF_OPTS() macro in the example, that's how
> users are normally expected to use OPTS-based APIs anyways. Also there
> is no need for "./" when specifying file location. This is a different
> case than running a binary in the shell, where binary is searched in
> PATH. This is never done when opening files.
>
> So all this should be:
>
> LIBBPF_OPTS(bpf_object_open_opts, opts, .btf_custom_path =3D "5.4.0-small=
er.btf");
> struct bpf_object *obj;
>

I suppose you meant DECLARE_LIBBPF_OPTS(...)

> obj =3D bpf_object__open_file("one.bpf.o", &opts);
>
> That's all.
>
>
> > +
> > +  ...
> > --
> > 2.25.1
> >
