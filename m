Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F007573CA1
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGMSkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiGMSkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:40:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5F25EA8;
        Wed, 13 Jul 2022 11:40:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so21372906ejc.13;
        Wed, 13 Jul 2022 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UYxEBVQxJBWXUllpTKJe/GcN31hCKwDkmAS5fh8H2o=;
        b=DPu1lD/yH7EsJnyAR9LOPy1YHC/+Pd0xB1pEqWnDc8dmGeoB70ysFHFjJTINXPciiH
         6rCma/gbO9ohDqIhyWU0T29Bdom4ceT8H//ghVXRMMOOxgwbE6PpYZS9PAB2SENHAakV
         LZCJdzZDv9ihwO8QXWFUofllWzw3jXWgGeycCDVnIETJhzOyUQIeRNXId2DWNRKWwqPS
         5+tb2u09bk707WLmrpxAIUX9Tai9fqqhh76tua1vTND+bmHYZq31PWICs0ZM2JOvcmMF
         d7r+3dDM6/oEObMAs1Ux8MIoRbwDnJSxrp6pUodg3dg7yag69wUNnvTvxLn+p3l/YAyg
         4JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UYxEBVQxJBWXUllpTKJe/GcN31hCKwDkmAS5fh8H2o=;
        b=0w5QAY/o7WGF1WqG2x9eLr9kyXszhSHKuRYsXre+9+p71XekydhxsjkpQBNX02v5v/
         kBTyGi7jEuuVHQJdcQ2gQ667cH7x23ltFP6SQmX5SQXQLt18DZ7NHurZUW0hvsl3YLVX
         mvHlPnE97sfUvBiz4fpWj0HLN7q50QJktAfv36K2gxWwD95NT1FhlDUO11ce3jNziZ8b
         LOpY/4VwLVW9pNxH9+i1kLoVbQzKrIY/oXG/gabRckaVBys6lDwX2NvsP6U8sCEhIGM/
         BPJOlEWXhZwEgsPbTUibip8GIYQMZBGeXD8ud6mnkprAzVf+2P15AYTS3G23PbRfvzc3
         bRKg==
X-Gm-Message-State: AJIora/ecIx9dGfWAC3Irf9hMIccRT4n/x5t4thLizV5Q+dDHh3pLY/E
        5wFZKUQBTsydtV+2NzXpfezbCqUG8diBrZyIAu8mMD/TgNU=
X-Google-Smtp-Source: AGRyM1szH2mTzg24+N4xASjFTF0FOaOGFnT5yRqp0yDII1+gT5tNAqY9HASAnnC6RoxP97A41Mh8DEL58ncQea44ipg=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr4676294ejc.745.1657737613168; Wed, 13
 Jul 2022 11:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220711211317.GA1143610@laptop> <YsyZY/tFm3hi5srl@krava>
In-Reply-To: <YsyZY/tFm3hi5srl@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 11:40:01 -0700
Message-ID: <CAEf4BzYGjNaqL4h8=4Jw7O_xxMfy=TbUg94VO6RZT5wOtV+_wQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix vsnprintf return value check
To:     Jiri Olsa <olsajiri@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Fedor Tokarev <ftokarev@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 2:45 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 11:13:17PM +0200, Fedor Tokarev wrote:
> > vsnprintf returns the number of characters which would have been written if
> > enough space had been available, excluding the terminating null byte. Thus,
> > the return value of 'len_left' means that the last character has been
> > dropped.
>
> should we have test for this in progs/test_snprintf.c ?

It might be too annoying to set up such test, and given the fix is
pretty trivial IMO it's ok without extra test. But cc Alan for ack.
Alan, please take a look as well.

>
> jirka
>
> >
> > Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eb12d4f705cc..a9c1c98017d4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> >       if (len < 0) {
> >               ssnprintf->len_left = 0;
> >               ssnprintf->len = len;
> > -     } else if (len > ssnprintf->len_left) {
> > +     } else if (len >= ssnprintf->len_left) {
> >               /* no space, drive on to get length we would have written */
> >               ssnprintf->len_left = 0;
> >               ssnprintf->len += len;
> > --
> > 2.25.1
> >
