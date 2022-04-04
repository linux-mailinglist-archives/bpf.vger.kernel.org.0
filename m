Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582174F1C96
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiDDV2A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380496AbiDDUU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 16:20:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489F10C8
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 13:18:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b43so14401889ljr.10
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEB+jG57QOiA8nOmC7dH7Q+xKzDdqm5GOBdPSATZZKk=;
        b=OBPClqzX14BgC/M0WKYWKfBpluxXkzDwdQ1YmuzsWZROB9EExq5e3/AiMadDliYltx
         SIZKTmnEkYADhsY5+Sgnlk1CUQcn2aUUalEAVwVLa3OJT5cGUIwS4OZLs31kHLcomll5
         Kt8WO7fvh5lHtS9jkEOHQVsZE061S7pQeBXyYw+lRgF07VaGxh+BUFK94dPwZrZGe4xJ
         ZGXchfCnthJAQy2dc+enxxa/yqUgmVV8DHhtheNGxElORUTLhegjy7Ht5QtFZspn8/Fo
         R4cVaO2vx+bhJKP9e53EqlgkS6GL/tjhGj4QQ1XPLCYILFcKnLGHmuhyggCBHxEEQ6t2
         7uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEB+jG57QOiA8nOmC7dH7Q+xKzDdqm5GOBdPSATZZKk=;
        b=ElCPeGzcjFvpAAe075IXrIiQkkmhxGWxi/lskafx8J8GwUwp2NZRTpcqB+68qJadkc
         BCsONGIU16a8N30e1vJEs5XWNSmxRp2C0rlZRYqMkIZ3VwG3IJZugVOcZFtwYK2pRJG1
         I8mzI/vDjsidLFccNVFduGHcQAFX9WYhb/rCphyeQKU724+zALBjVorXTVyYRcjcHKtr
         1wYnRu/81wuq5BAJvlg5c+H7duNgH+hap8VaFlBiZVZZQ5H6v8glb7qCMQ8Yb/Eab0AC
         Im+ebCN+kJudA8BMFtE4FjgH8qlmfsWp4Hb7jK/mAbHBnY8trn4/dszFoyCv3swDhZZs
         NUWw==
X-Gm-Message-State: AOAM530Ukjc93uOgVBad7pFN396FH+POdpOjJiNNVgJs3J5KjGqehu8n
        YuQvyImq65Dc4dYJdi/KJ9anRosF7q8/uweGj/0=
X-Google-Smtp-Source: ABdhPJz7E0Aq8PlvFSf0ZGlJy4QVs3+YMvnjdJ6zYDtWIny+G/pTyeLxai3wbvG6gj8A+byHzhipVN+yup6ZgDtxZFk=
X-Received: by 2002:a2e:9b05:0:b0:24b:e8:8c7e with SMTP id u5-20020a2e9b05000000b0024b00e88c7emr834442lji.70.1649103507672;
 Mon, 04 Apr 2022 13:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-5-joannekoong@fb.com>
 <87ilrrfw0z.fsf@toke.dk>
In-Reply-To: <87ilrrfw0z.fsf@toke.dk>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 4 Apr 2022 13:18:16 -0700
Message-ID: <CAJnrk1bjH18mZ4HCC9=NKeQopOgqtzCCO5jBk402aZN=ufG-Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 2, 2022 at 6:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Joanne Koong <joannekoong@fb.com> writes:
>
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > This patch adds two helper functions, bpf_dynptr_read and
> > bpf_dynptr_write:
> >
> > long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 of=
fset);
> >
> > long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u3=
2 len);
> >
> > The dynptr passed into these functions must be valid dynptrs that have
> > been initialized.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  6 ++++
> >  include/uapi/linux/bpf.h       | 18 +++++++++++
> >  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 18 +++++++++++
> >  4 files changed, 98 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e0fcff9f2aee..cded9753fb7f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2426,6 +2426,12 @@ enum bpf_dynptr_type {
> >  #define DYNPTR_MAX_SIZE      ((1UL << 28) - 1)
> >  #define DYNPTR_SIZE_MASK     0xFFFFFFF
> >  #define DYNPTR_TYPE_SHIFT    29
> > +#define DYNPTR_RDONLY_BIT    BIT(28)
> > +
> > +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +{
> > +     return ptr->size & DYNPTR_RDONLY_BIT;
> > +}
> >
> >  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynp=
tr_kern *ptr)
> >  {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6a57d8a1b882..16a35e46be90 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5175,6 +5175,22 @@ union bpf_attr {
> >   *           After this operation, *ptr* will be an invalidated dynptr=
.
> >   *   Return
> >   *           Void.
> > + *
> > + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u3=
2 offset)
> > + *   Description
> > + *           Read *len* bytes from *src* into *dst*, starting from *of=
fset*
> > + *           into *dst*.
>
> nit: this should be "starting from *offset* into *src*, no? (same below)
>
Yes, this should be "starting from *offset* into *src*". I will fix
this line in both places. Thanks!
> -Toke
>
