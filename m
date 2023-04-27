Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915A6F0642
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbjD0M6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbjD0M6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:58:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0B186
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:58:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2fbb99cb297so7730012f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682600291; x=1685192291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJgX8X5BKrpRcxuOkGH8vLs69xgZdASxab8C38BjWDU=;
        b=H7vhAmcLPkBwsp/GR/sKjkJjX4roZ8yvLP9Tcwh/vKj4wSQ4/Opvq6CtU2K05IgQFU
         qyGNfZfQQJA3yCD/5jbXjvjZMYf1xik8pJMBC1mxCtoMx/LwG9Zxhjkz2kfsWWD4e+yV
         8Vlo771xpNx7+cmQ2v3DrlerZMvpXp/uu/PDpf8N4crs3DUbGI3CFRj1tOBHh+bK/TAA
         Apt1n3kH47sVijQhLGQdTnbKU9/yH1z7CgwRUEAgCgyTdpAC4tY5Noh0KQOXuh9ynErr
         NF/tggPVnRXaaY+AIUvlonhwZDIfo7H5+EYOHFcgT0ul554e7JgeDkb3q1PXm1+HB6Wq
         iezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682600291; x=1685192291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJgX8X5BKrpRcxuOkGH8vLs69xgZdASxab8C38BjWDU=;
        b=eAdxG0S/VKGANOpmpDh5/N6IeqDwpriwBzN8t1grrzdLWXPee2j2u/9XrsmP9bwd2e
         erLi+yAU/E2hMDdPmj+yJCeyX+MbBwtN+UCJbV48ieyL/kBltVGpoUPjhVViVRGwBWW3
         u63eue5a7Dya9acfLXZrdzHzsgD9ELuHIydAqh4gFom+Ylg0EKBTFbtaKOGlGJ4r+jwG
         lD0u85NNWKOpR+l9J1+T9uXv+kIjElKi2//baKwYvyvyJTfo5+R5XxGVKWfCRUOWsxAm
         PzpRCGgyeCrb+eSZBEtFF+lCFSFQyHtJ46hFyUeHAaNno1gwctMEGbwS8nUcuFKPQ0Ap
         HPNg==
X-Gm-Message-State: AC+VfDwsWBjLN4i85mzSc90eG1F/8SwFbdr3XU2SVRAj9ZO0lAmRLeSf
        gg7jJn8G0eC6zI4/LzexUxA=
X-Google-Smtp-Source: ACHHUZ6YxBZHA+4kNeeaM6sT350U3Fjk4ZMLrk+bRXk2o5wJph+SHu6finfVBnnZaZOx00L+Izz/9w==
X-Received: by 2002:adf:dfc4:0:b0:2fb:a3e:7cb0 with SMTP id q4-20020adfdfc4000000b002fb0a3e7cb0mr1439730wrn.10.1682600291199;
        Thu, 27 Apr 2023 05:58:11 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b002fa6929eb83sm18439489wrv.21.2023.04.27.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:58:10 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 14:58:08 +0200
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
Subject: Re: [RFC/PATCH bpf-next 02/20] bpf: Add cookies support for
 uprobe_multi link
Message-ID: <ZEpxYPzNux0CaOZk@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-3-jolsa@kernel.org>
 <CAEf4Bzb5H6caJ24HWhRnOmqOU9nbqruDp1MP0pcStqd8OyvhJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb5H6caJ24HWhRnOmqOU9nbqruDp1MP0pcStqd8OyvhJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:13:20PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify cookies array for uprobe_multi link.
> >
> > The cookies array share indexes and length with other uprobe_multi
> > arrays (paths/offsets/ref_ctr_offsets).
> >
> > The cookies[i] value defines cookie for i-the uprobe and will be
> > returned by bpf_get_attach_cookie helper when called from ebpf
> > program hooked to that specific uprobe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h |  1 +
> >  kernel/bpf/syscall.c     |  2 +-
> >  kernel/trace/bpf_trace.c | 46 +++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 45 insertions(+), 4 deletions(-)
> >
> 
> LGTM, one nit below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> >  static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
> > @@ -2964,6 +2982,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> >         struct bpf_uprobe_multi_link *link = uprobe->link;
> >         struct bpf_uprobe_multi_run_ctx run_ctx = {
> >                 .entry_ip = entry_ip,
> > +               .uprobe = uprobe,
> >         };
> >         struct bpf_run_ctx *old_run_ctx;
> >         int err;
> > @@ -3005,6 +3024,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
> >         return uprobe_prog_run(uprobe, func, regs);
> >  }
> >
> > +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> > +{
> > +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> > +
> > +       if (WARN_ON_ONCE(!ctx))
> > +               return 0;
> 
> do we need this check?... seems redundant, tbh

it might be too much.. so this helper is called based on the:

  prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI

so it's just screaming if there's some mismatch with the flag.. but if there is,
we probably would not get to this point or there wil be some pointer != NULL anyway,
yea, I'll remove it

there's similar one for kprobe_multi, I guess it can go as well

thanks,
jirka

> 
> > +       run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
> > +       return run_ctx->uprobe->cookie;
> > +}
> > +
> 
> [...]
