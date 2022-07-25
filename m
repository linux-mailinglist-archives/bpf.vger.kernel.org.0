Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27A5806FC
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiGYVzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYVzk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 17:55:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4B2BFE
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 14:55:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ez10so22810981ejc.13
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+o/+Vj53hZvgVBuOzUWGq8calnbNySyeqpjsAIAXTGg=;
        b=CG6UTHK0jAxnsRFUUbuTyy6rO10Rp1hrUmbsDbmciZEN2ibB/GlDbEH6+SZyna84/E
         0JtWrMuMR92kzqdpHApXKFS7Fxp7lW8vxKnPfZuZKF/M5h4Zm3hDqt6IGjS4WGDP5i5F
         Dc/oNPK7WEHu5j/Et51VeycWTk07gY+6dzwBUvh9lDEAMqyI8/TVVd1IxENUpxEDsRbw
         8q9HhNrcbu4jiiBHAC98jsHcdsQGqZtUhrZkZ45zs0f9Ts2IKsaasPBN/hxO8If3DLUy
         zmyu0nCJo/8JOWhGeply4D9OMXhlNhfNQYye0BnKTXTjBsAdGqlfqybiMWIu7DKIVzUG
         poAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+o/+Vj53hZvgVBuOzUWGq8calnbNySyeqpjsAIAXTGg=;
        b=tR3HYpdZASItD67Fao3+oRQrvVSRDvMIaFUh+vQuQ3XQaI0myn3k6U57uQFf0BkqLS
         jVxdUAW/Fa4i5KYp1d3SvIWr509fc5ZGkA1sbGWNWCOVlaR8Nker/1elEX2Ob5ma0UYD
         3mbIIf6ztaZp+cTVuw4a/04opMQ7qAUdDmRikVTyhC7ABXSDCnU5FLIWmPQoEjahTWWF
         nr7V9p+ZP0wXlxACR/dvxmz0TOGaqxBy8uzqN+WqWoN/523OfQHiLbgFgs3urW3R2Lx/
         CBSrQFF+wC2d4mUtEUx/dW7PCHqbsQIU47vubWHM4WvhG/1JFiqJs/hni5pu0ebin+Kc
         uhAg==
X-Gm-Message-State: AJIora/9zIynh3LoqjOOsgVXRyyUUtBrNig73cmpGLQuYIcxIRbjJ1ao
        EjuBbU6uREcsx8ahjFS/9YPFFb+05Q0G9RXYYug=
X-Google-Smtp-Source: AGRyM1tw0ljpAedeHOFl7s2B11LMVNCOk/GVGu93rN1NiRD7Sn0kKXk5vM0dKux3HkqlXVphdWgdV2iUtkdz3UVLByo=
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id
 oz11-20020a1709077d8b00b0072f2306329amr11204268ejc.369.1658786138337; Mon, 25
 Jul 2022 14:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220722220105.2065466-1-joannelkoong@gmail.com> <20220725201658.t55raspwmj2eguek@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220725201658.t55raspwmj2eguek@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 25 Jul 2022 14:55:27 -0700
Message-ID: <CAJnrk1ac5GzwCL_ZSGcX9nPqokJG63K2khjKbgW5maYm66mLPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Fix bpf_xdp_pointer return pointer
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Mon, Jul 25, 2022 at 1:17 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jul 22, 2022 at 03:01:05PM -0700, Joanne Koong wrote:
> > For the case where offset + len == size, bpf_xdp_pointer should return a
> > valid pointer to the addr because that access is permitted. We should
> > only return NULL in the case where offset + len exceeds size.
> >
> > Fixes: 3f364222d032 ("net: xdp: introduce bpf_xdp_pointer utility routine")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  net/core/filter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 289614887ed5..4307a75eeb4c 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3918,7 +3918,7 @@ static void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
> >               offset -= frag_size;
> >       }
> >  out:
> > -     return offset + len < size ? addr + offset : NULL;
> > +     return offset + len <= size ? addr + offset : NULL;
> This fix should be for the bpf tree.
Ah I see. To confirm my understanding, fixes should always go to the
bpf tree (unless it's fixing a patch that only resides in the bpf-next
tree), correct?
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
