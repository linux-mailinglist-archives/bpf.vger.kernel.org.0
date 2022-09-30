Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C95F15C3
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiI3WHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiI3WGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:06:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B51710DF
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:06:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a26so11721972ejc.4
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atl/zR+VcOyEuHgkvzi7DfOCc/Z94A4Hke0ISLMFgU8=;
        b=Z5ebLlffU/JwxNyEUPabFOsRrX3o6sX5fhB6t9VVBI6yk0s/7uFL8+EifEJa0YIcFV
         SzwbId+84f1z9ofdwp4LAkgDVEpkcei6K4Es+BDUE1KjdgEUmeeXYx+jMWtDcsCK7DCj
         NDcCIC61MAGGzXHZ6SnJHeD+AqjSRRx6TVajz8xovQbTLKNgyA4UTuNxLB7HrC7ypaVM
         ERhviY9W3sQksXGfA4VXmLyeUE691MKw2Mf8pu0OxW67ysHnj2yAQXErbsXhnWNQtHA8
         8abzAei/JKqETmeOrslnC4XZa+va6kZIFtb3+I31HHM4P040La1ndlDH4RCeAD7yda5/
         MzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atl/zR+VcOyEuHgkvzi7DfOCc/Z94A4Hke0ISLMFgU8=;
        b=otX8Vj2suWnXzIO4eFvr1CmGs95hTwwWxbfDrfO/vJRSWVAzcMOGmsHnbBq8DWN9qY
         urWYtkINW24UaqX+QrZKPqy7ts7RDkN2IF8/y9MK+XxLrabJBwnwteekQfHo+HAZ3LKd
         nuKbknz6Br8Ngp0D7BjJxLj4ZXS8v91GDTwYe4Hy3Ic7h/NbRPv+wIgKxTgPA14Ft2DV
         BCQFiSx9K9y3kJmK1adwLw/l5i9FJw18Nt68bdG1STUzV7M5Xtf2VF/crA4eYC1hIdoe
         C9p+k9USdPXTfUTNMcLZfX/tEM7hesH00EiBXPxMWgnaUtPhDQTRAo/9DBZTGstdQWZ+
         HiTQ==
X-Gm-Message-State: ACrzQf0KETIo3nKZjRCwsxDmU9x6D0HWr7DtHCfo4RwCEvsWBNsdNBJ3
        tqy+Dz5LUUZGuC95NVQivNcD/bEjd/L7Hs5bBuA=
X-Google-Smtp-Source: AMsMyM7hvjic80+39FRimJZzW7Tzqc+Aw6bGcgZXcFqgSNtBjv+VivA9E/HYwSEuSVk2ngVjBNnECYEBA7VQLQEHZX0=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr7976106ejc.176.1664575586714; Fri, 30
 Sep 2022 15:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYbmi-NQ8qQuMmCWCG=0V2z4SuKogb4y-WrUKkL1iw7-w@mail.gmail.com>
 <SY4P282MB10844F5E962746CC0C628DE39D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
 <63364d429366a_233df2084f@john.notmuch>
In-Reply-To: <63364d429366a_233df2084f@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:06:14 -0700
Message-ID: <CAEf4BzbtSDP6se-_BDrZ6hPzfE9BOPxkujWRUDd4OcSv+v62BQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .BTF section
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Tianyi Liu <i.pear@outlook.com>, andrii@kernel.org,
        bpf@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 29, 2022 at 6:58 PM John Fastabend <john.fastabend@gmail.com> w=
rote:
>
> Tianyi Liu wrote:
> > > -----Original Messages-----
> > > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Date: Tuesday, September 27, 2022 at 12:37
> > > To: Tianyi Liu <i.pear@outlook.com>
> > > Cc: andrii@kernel.org <andrii@kernel.org>, bpf@vger.kernel.org <bpf@v=
ger.kernel.org>, trivial@kernel.org <trivial@kernel.org>
> > > Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .B=
TF section
> > > On Sun, Sep 25, 2022 at 10:54 PM Tianyi Liu <i.pear@outlook.com> wrot=
e:
> > > >
> > > > Fresh users usually forget to turn on BTF generating flags compilin=
g
> > > > kernels, and will receive a confusing error "No such file or direct=
ory"
> > > > (from return value ENOENT) with command "bpftool btf dump file vmli=
nux".
> > > >
> > > > Hope this can help them find the mistake.
> > > >
> > > > Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index 2d14f1a52..9fbae1f3d 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -990,6 +990,8 @@ static struct btf *btf_parse_elf(const char *pa=
th, struct btf *base_btf,
> > > >         err =3D 0;
> > > >
> > > >         if (!btf_data) {
> > > > +               pr_warn("Failed to get section %s from ELF %s, chec=
k CONFIG_DEBUG_INFO_BTF if compiling kernel\n",
> > > > +                       BTF_ELF_SEC, path);
> > >
> > > This is going to be very confusing for any user trying to load BTF
> > > from some other ELF file. If we want to add such helpful suggestion
> > > (and even then it's a bit of a hit and miss, as not every passed in
> > > file is supposed to be vmlinux kernel image), it should be done in
> > > bpftool proper.
> > >
> > > >                 err =3D -ENOENT;
> > > >                 goto done;
> > > >         }
> > > > --
> > > > 2.37.3
> > > >
> >
> > Hi Andrii :
> > I agree with you, I will try to implement it in bpftool.
> >
> > But there=E2=80=99s another problem here, in btf_parse_elf() from tools=
/lib/bpf/btf.c:
> > If the path does not exist, open() assigns ENOENT to errno, and btf_par=
se_elf()
> > returns -ENOENT. Besides, if .BTF section can not be found in the ELF f=
ile,
> > btf_parse_elf() also returns -ENOENT, the same as above. So we can't de=
termine
> > which kind of error it is from the outside.
>
> Just do a stat() on the file to see if it exists on error and then
> give more verbose warning? We did something similar in our loader
> code for tooling fwiw.
>
> >
> > Could we change the err code in the second case to make it clearer, Suc=
h as
> > changing ENOENT to EPROTO / adding a new error code? Or we can just war=
n
> > that .BTF section does not exist.
>
> I don't think its needed.

Agree. I don't think we should modify libbpf for this, best to add
extra check in bpftool.

>
> >
> > Thanks.
> >
>
>
