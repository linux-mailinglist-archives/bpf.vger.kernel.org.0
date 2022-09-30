Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0189C5F027C
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 03:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiI3B6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 21:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiI3B6a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 21:58:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE9115BCC
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 18:58:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so7644817pjs.1
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=MvNXRXUZ7IX7BGZHHz4pEROAaYRqJO0IDeGG8JAV2JQ=;
        b=jtgKkl5NPww4gtw04ef1pl3sXdYC8GFGDm7FjZvp6hEeuneZkMZsCedqEeV8sge5fr
         pE7PQe7NnzCvuZKU1fTIWX+N7t8gzexpc5PLOjcaYu8PTbI8MtC0uYpNRMOPf6Jo2R1D
         ewWrsGRTLeVa8zUtTRpM3TzDsyGQSXUPxM9n4ihi09trB8VwCsAJiIfOXsSWsLaC+anD
         rrE6TtNT2/sMPhdBoVRHec1/cgKJaX1mWQaZFklRS/tM1qsMLgD6JkcYO1IbeCYuSsJj
         I+Wlw9WH8kU9RFcoJPAjNzV4WI0RBrRwFjqzptmwmanX0LoQNuoHWUiTw7rhNjtblsXK
         MRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=MvNXRXUZ7IX7BGZHHz4pEROAaYRqJO0IDeGG8JAV2JQ=;
        b=vbN8bLfhEMgGylKnxRxADMVnxd/Bf7SUNmpnCQlkor1vxK4sojrVmbGdElcZVaFafZ
         d5q93hIBq3+dwL6FVPIJJKKgareuJa0GnaNtn8l/pMmYW75ucWKWmNVhEXbP/w9+pLVN
         Bq54A3Fri2nq2DBUiZT63jwMqsfyHjxdaxFrEB0HyxQ6A8Ox78/WRPQcYCvOstp3YM5L
         uu7O23r0jUlixjz5hoNmvC/42t/cUgJ9m6Z6g/y6TuOV7Ty1HEICOc1Cd0abFgYpxPwJ
         nRn3uhNs5Ejcy8ISCq0tK30KC/3yhdksQlHJBmcwFq78WsIH+w43cqqK9vEYkce9fzMI
         /jEQ==
X-Gm-Message-State: ACrzQf3Bn7MJcminV96W/1qATbkwVQZpQVdlfQoc2SQmTQvtVjJT3Mjv
        wPEL+7HLj7FwHZgMCWd1YBI=
X-Google-Smtp-Source: AMsMyM7HDpF+mXfG1qzFEiur8p45oqy0VEejL+l54/YI4FMVPtpH9+LbCwQ6MyzaYbbl8olOTx+J6g==
X-Received: by 2002:a17:902:7107:b0:17a:46a:b0bc with SMTP id a7-20020a170902710700b0017a046ab0bcmr6547946pll.172.1664503109193;
        Thu, 29 Sep 2022 18:58:29 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id y67-20020a623246000000b00545f5046372sm353070pfy.208.2022.09.29.18.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 18:58:28 -0700 (PDT)
Date:   Thu, 29 Sep 2022 18:58:26 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, bpf@vger.kernel.org, i.pear@outlook.com,
        trivial@kernel.org
Message-ID: <63364d429366a_233df2084f@john.notmuch>
In-Reply-To: <SY4P282MB10844F5E962746CC0C628DE39D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
References: <CAEf4BzYbmi-NQ8qQuMmCWCG=0V2z4SuKogb4y-WrUKkL1iw7-w@mail.gmail.com>
 <SY4P282MB10844F5E962746CC0C628DE39D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .BTF
 section
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Tianyi Liu wrote:
> > -----Original Messages-----
> > From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Date: Tuesday, September 27, 2022 at 12:37
> > To: Tianyi Liu <i.pear@outlook.com>
> > Cc: andrii@kernel.org <andrii@kernel.org>, bpf@vger.kernel.org <bpf@v=
ger.kernel.org>, trivial@kernel.org <trivial@kernel.org>
> > Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .B=
TF section
> > On Sun, Sep 25, 2022 at 10:54 PM Tianyi Liu <i.pear@outlook.com> wrot=
e:
> > >
> > > Fresh users usually forget to turn on BTF generating flags compilin=
g
> > > kernels, and will receive a confusing error "No such file or direct=
ory"
> > > (from return value ENOENT) with command "bpftool btf dump file vmli=
nux".
> > >
> > > Hope this can help them find the mistake.
> > >
> > > Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> > > ---
> > >  tools/lib/bpf/btf.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 2d14f1a52..9fbae1f3d 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -990,6 +990,8 @@ static struct btf *btf_parse_elf(const char *pa=
th, struct btf *base_btf,
> > >         err =3D 0;
> > >
> > >         if (!btf_data) {
> > > +               pr_warn("Failed to get section %s from ELF %s, chec=
k CONFIG_DEBUG_INFO_BTF if compiling kernel\n",
> > > +                       BTF_ELF_SEC, path);
> > =

> > This is going to be very confusing for any user trying to load BTF
> > from some other ELF file. If we want to add such helpful suggestion
> > (and even then it's a bit of a hit and miss, as not every passed in
> > file is supposed to be vmlinux kernel image), it should be done in
> > bpftool proper.
> > =

> > >                 err =3D -ENOENT;
> > >                 goto done;
> > >         }
> > > --
> > > 2.37.3
> > >
> =

> Hi Andrii :
> I agree with you, I will try to implement it in bpftool.
> =

> But there=E2=80=99s another problem here, in btf_parse_elf() from tools=
/lib/bpf/btf.c:
> If the path does not exist, open() assigns ENOENT to errno, and btf_par=
se_elf()
> returns -ENOENT. Besides, if .BTF section can not be found in the ELF f=
ile,
> btf_parse_elf() also returns -ENOENT, the same as above. So we can't de=
termine
> which kind of error it is from the outside.

Just do a stat() on the file to see if it exists on error and then
give more verbose warning? We did something similar in our loader
code for tooling fwiw. =


> =

> Could we change the err code in the second case to make it clearer, Suc=
h as
> changing ENOENT to EPROTO / adding a new error code? Or we can just war=
n
> that .BTF section does not exist.

I don't think its needed.

> =

> Thanks.
> =



