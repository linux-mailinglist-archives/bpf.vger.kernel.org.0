Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0857A5CD
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiGSRwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiGSRwI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:52:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6EB558CB;
        Tue, 19 Jul 2022 10:52:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so7216766edd.9;
        Tue, 19 Jul 2022 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YTpiaB6PMXo4jWAVbVLhgHIuKspbeQjTrg1R1Mmeyw=;
        b=Mc/gq8UXvCmdzHHHtgJEpbnKacMt2vUKrrS5u8mhACTcWR/qWqoMkCRWg2cSLmYs6O
         uysqOAfr4fBrshukoGkKzpY5H9zguRihPLCYRVvBNg2pld2/y/3rXT32r/bKb2keS+JH
         6Jlov4KQNWtSg6fG8eGwan2Xp7Xg7LvWqjFF8ngJMzOyIz0NYIDgerGBCa8VCaDSOzZg
         KfR+9CBxdRTdap3VdMmBHl7Ol2bFSFSYqTzRB6t0WZQ83RQwLP2Atp5YZNBDl0gDS0h/
         G1/7Ovj4zOdtRwSnDqRvwNz3ByvKc53e/e17MZrh2UfzHLL8mkEqxBny6zePCI6O3DBT
         wzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YTpiaB6PMXo4jWAVbVLhgHIuKspbeQjTrg1R1Mmeyw=;
        b=HpAqfdaz1Tj8QkxGYP8K3RPJPkIKPmwxlzjNgBMvZWZO9B26Cj3LDhGLkT7gpXALjl
         5G2wVNjWfNrqoB1ruooTuXIsKIg/Gz9h4AurQc6g6mWcg5gXbrnwMHpUWmnwwkg8MJ4P
         WLUufBWiUtZdecF+AHoWyL/J9w0wt2JbfH1MJKfYMlasl9WqimsN6repcyT9q9yTfAnH
         dJ9kU1pnIIB41Mw85ZcBNadrSQl2eNiinMUviIaiOmhsKJL13RwOVAuo0B9HB9efQ8Xk
         Q+jAg8+rdqQmwqF2+B4Vgg4MGMcGkNbyG2MVQouS2pS//bMlzacg7YLk8eOT6bIbWcyU
         AUkw==
X-Gm-Message-State: AJIora9i0MDsmaZjaoKxrGOv8H2KODYGJNsB6g9/BMs7MLTstWG2CxCv
        I+JwmacH7414xX4PUMMGzqNkNDckpmyl6K6w4PE=
X-Google-Smtp-Source: AGRyM1uzIXKaiFYz0mz7dVXIk2tsx1cpHwsu8w22nhgaI7DxpYV9RXvrg2E8SzL65gsSgmscOte/SFEhJRQqjkv8gU0=
X-Received: by 2002:aa7:d053:0:b0:43a:a164:2c3 with SMTP id
 n19-20020aa7d053000000b0043aa16402c3mr45316119edo.333.1658253126330; Tue, 19
 Jul 2022 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ+/dAA195d99ak@kili> <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Jul 2022 10:51:55 -0700
Message-ID: <CAADnVQLS=asNdrmdK-jgW4AZmJih00OTvXZg_RA55wLY=bHMZg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Jul 19, 2022 at 12:53:01PM +0300, Dan Carpenter wrote:
> > The return from strcmp() is inverted so the it returns true instead
> > of false and vise versa.
> >
> > Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Spotted during review.  *cmp() functions should always have a comparison
> > to zero.
> >       if (strcmp(a, b) < 0) {  <-- means a < b
> >       if (strcmp(a, b) >= 0) { <-- means a >= b
> >       if (strcmp(a, b) != 0) { <-- means a != b
> > etc.
> >
> >  tools/lib/bpf/libbpf_internal.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 9cd7829cbe41..008485296a29 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
> >       size_t str_len = strlen(str);
> >       size_t sfx_len = strlen(sfx);
> >
> > -     if (sfx_len <= str_len)
> > -             return strcmp(str + str_len - sfx_len, sfx);
> > -     return false;
> > +     if (sfx_len > str_len)
> > +             return false;
> > +     return strcmp(str + str_len - sfx_len, sfx) == 0;
> Please tag the subject with "bpf" next time.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Alan,

If it was so broken how did it work earlier?
Do we have a test for this?
