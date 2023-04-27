Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45046F0688
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbjD0NVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjD0NVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:21:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28593A9D
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:21:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f3df30043so1375873366b.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682601672; x=1685193672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eN2MuMfgOCgsi6hIa5QaDHizpQ6Zb1u5dujhfiXUlyY=;
        b=RH6fBQHrTdX6MmTRZS3Ln3RPB1+x8ERVZhomAwGPECdb+Rm5emY5m1jDmC1rYihf2l
         BF5lmik7yaydI+xY6QldZKntO9A5GVYqJd0SJ9uw+pC6rFuVKHM/T6lIJe4ykavsJdd0
         H4mNcwwoUnCZVW8m94eCooALxnI4xVrVVOTRp4IPlaIKFr83JQ/XhGKPZ1II4ig4TCMW
         Z5xeodjMoW3Yj/p92NSkbY4cS+eaAZhZqXBB7N+h9TByJohtE/NwpXGC5vTgAp7zHqvx
         KN9wQJNj7F4mHCTqO7clQMVaDmRpFnjyh2zm2Gg8kjJ02ne/7EP+bp/UFKx4Chx733Xc
         2PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601672; x=1685193672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN2MuMfgOCgsi6hIa5QaDHizpQ6Zb1u5dujhfiXUlyY=;
        b=DdOAhdIJCMfQBPsnz0n3vRbEvirJQ1fe4jMV/zV2+ISa0YOVa6cp5oTbW97Sm+3oC4
         1OYliRoXlDZVOf3hWeBJtrm6vUGY6dWX2gkHMwnEsgHSfzFSCmYCfnapR0TnaadJHfHJ
         WuNPGODo774tEOgJP299fGnJhDtd08Yf0V5pO97/K3/q9ARtVazsYuwAAZLTV8mP8iqo
         bhzQ16ojTAcXRpE5WSvAXVaYV34e4LNng8w9zZIKQA9iX9TlIuy+dsDlaJtowGFmnCrC
         Vhf95vvS2vrPTsXZAV8i3ueV2htS03sN8GCCcz3Y1VQpPCOQAmbZwryHH47EBZUHhrPZ
         VtgA==
X-Gm-Message-State: AC+VfDzzxhji9njXpgSc7AaQSOBt+TcmHsM7GWUHu9et8AfWvANEF+aY
        HGTGdjMiN7PrY3LbFPu/PQY=
X-Google-Smtp-Source: ACHHUZ6erEK5b66SNI26u5OAkH2Jgr8ZOQPJoMO7g0LORzr3JopGHaWZ4IYl5toSiwuXzgGl3Ifp5w==
X-Received: by 2002:a17:907:c29:b0:92b:6b6d:2daf with SMTP id ga41-20020a1709070c2900b0092b6b6d2dafmr1879222ejc.77.1682601671855;
        Thu, 27 Apr 2023 06:21:11 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id d16-20020a1709063ed000b0094f499257f7sm9685158ejj.151.2023.04.27.06.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:21:11 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 15:21:09 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 08/20] libbpf: Add
 elf_find_patern_func_offset function
Message-ID: <ZEp2xfXGu4kTY7Q3@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-9-jolsa@kernel.org>
 <CAEf4BzYKkPHBqbr1pXjA6jEkvJTpu0bjFHt0Nu0bm4un3DD6mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYKkPHBqbr1pXjA6jEkvJTpu0bjFHt0Nu0bm4un3DD6mQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:24:16PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_find_patern_func_offset function that looks up
> > offsets for symbols specified by pattern argument.
> >
> > The 'pattern' argument allows wildcards (*?' supported).
> >
> > Offsets are returned in allocated array together with its
> > size and needs to be released by the caller.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> 
> Why do we need to expose any elf-related helpers as libbpf public API?
> Just to use them in selftests? If yes, then selftests can use libbpf
> internal helpers just like bpftool due to static linking. In general,
> it of course doesn't make sense for libbpf to provide ELF helpers as
> part of its API.

I use them in bpftrace ;-) I can move the implementation in there,
if we don't want to expose it.. it was just convenient to use libbpf

> 
> Also s/patern/pattern/.

ok

> 
> 
> >  tools/lib/bpf/libbpf.c   | 121 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   |   7 +++
> >  tools/lib/bpf/libbpf.map |   1 +
> >  3 files changed, 129 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0b15609d4573..7eb7035f7b73 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11052,6 +11052,127 @@ elf_find_multi_func_offset(const char *binary_path, int cnt,
> >         return ret;
> >  }
> >
> > +struct match_pattern_data {
> > +       const char *pattern;
> > +       struct elf_func_offset *func_offs;
> > +       size_t func_offs_cnt;
> > +       size_t func_offs_cap;
> > +};
> > +
> > +static int pattern_done(void *_data)
> > +{
> > +       struct match_pattern_data *data = _data;
> > +
> > +       // If we found anything in the first symbol section, do not search others
> > +       // to avoid duplicates.
> 
> C++ comment

ok, will fix

thanks,
jirka
