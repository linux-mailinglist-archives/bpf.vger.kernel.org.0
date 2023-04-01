Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47F6D33A6
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDATw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 15:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDATw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 15:52:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8D9750
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 12:52:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so102744672edo.2
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680378743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UoD/JXeEKlQ85Ajtbxt4E1MuyecAYL8vzeb6oIT0nlc=;
        b=K1o3yL4mV8ujgaxDqKbVoI3AIGurTG0OCy6MWe0XTI00T7hK15fH1yKJXVF2W9VMda
         UA1dcnXirNuvk7r454gvOWjL6nTT4ttqCTRXWIvN7XFHPBNcjjBtWu1LHyKGOCt32xhL
         t3jl5gLTCP7eiMVtIP/UW2BPM9WIn+pXJSkAixpfHUlGeK8At4mrq8f1Tf4wpMq+4T6J
         zsO4LfE8PnhrY8c9WrFBeNVOx1Eo3mOnViZ5kXU2O4LmOi5oYXaPigNT6UnYqMceJo5S
         rN5YOVXNQSWpJ0y4M/d69hazA6e1iz7rZhlglGqvnvnXvu7roVp0fJ8N2ugx6W6RME5X
         SYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680378743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoD/JXeEKlQ85Ajtbxt4E1MuyecAYL8vzeb6oIT0nlc=;
        b=XgMkajDAUQL5M2RahDwoTzjowZ8EuPsYkVG0IgW/q6Q6E9wgxHdl4eMXc3Q/chUkpp
         FMpRUyKtsAUmxwIpH9rA1cDCqOCOMrJBJBdr3lAajcumxNxDU+WFmsTif06HUzzFgb88
         15ZOVoL92TGkX9fc+3ETId09slXa/pq1q5XXhuc5Qd2tPJ5Pi/X6AjA8hxNxcE1FvPlB
         /8wuLFRiK+OE5uCVH3BAEjSS9xSigjPeB9Ly+fUjtT1RKChI10twvWIs0UbSPjWrVKJc
         Gl/vMtsZv298QcdyqwgqdGzj+VOTsGUQi9puLawtu/fNqFGSyiTKKmV2wvokHoBPHSyU
         KdZQ==
X-Gm-Message-State: AAQBX9dNX4l8DOG07S9ZqEIiLyVrHU52aQ1jV37Bg5gQmxAc+fkSkv6h
        zjvBt1OhBTgWN1JUlYz7A0RMusKcUtNCFu7B8X6C6Q==
X-Google-Smtp-Source: AKy350Yy2cPBfDd6D++by9bwygGeN80dDew1x9XSJrU2DzLNDskElyTJUNlbFM314Rjtr5pbx51QsQ==
X-Received: by 2002:aa7:d618:0:b0:502:4ba4:76 with SMTP id c24-20020aa7d618000000b005024ba40076mr17257666edr.7.1680378743636;
        Sat, 01 Apr 2023 12:52:23 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i24-20020a508718000000b005024aff3bb5sm2441175edb.80.2023.04.01.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 12:52:22 -0700 (PDT)
Date:   Sat, 1 Apr 2023 19:53:10 +0000
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: optimize hashmap lookups when key_size is
 divisible by 4
Message-ID: <ZCiLplR/MqqF7479@zh-lab-node-5>
References: <20230401101050.358342-1-aspsk@isovalent.com>
 <20230401162003.kkkx7ynlu7a2msn6@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <ZCiFONQVTvRia3nY@zh-lab-node-5>
 <CAADnVQK9n2yhC9GGFCwHbVHQB_0kq5M7TLyoGZq5MQFsw92xyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK9n2yhC9GGFCwHbVHQB_0kq5M7TLyoGZq5MQFsw92xyA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 01, 2023 at 12:35:55PM -0700, Alexei Starovoitov wrote:
> On Sat, Apr 1, 2023 at 12:24 PM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > -static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> > > > +static inline u32 htab_map_hash(const struct bpf_htab *htab, const void *key, u32 key_len)
> > > >  {
> > > > -   return jhash(key, key_len, hashrnd);
> > > > +   if (likely(htab->key_size_u32))
> > > > +           return jhash2(key, htab->key_size_u32, htab->hashrnd);
> > > > +   return jhash(key, key_len, htab->hashrnd);
> > >
> > > Could you measure the speed when &3 and /4 is done in the hot path ?
> > > I would expect the performance to be the same or faster,
> > > since extra load is gone.
> >
> > I don't see any visible difference (I've tested "&3 and /4" and "%4==0 and /4"
> > variants).
> 
> I bet compiler generates the same code for these two variants.
> % is optimized into &.
> / is optimized into >>.

Yes, it does "test $0x3,%dl"

> > Do you still prefer division in favor of using htab->key_size_u32?
> 
> yes, because it's a shift.

ok, thanks, I will send v2 with division
