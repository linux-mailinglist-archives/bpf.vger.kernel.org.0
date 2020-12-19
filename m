Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2C2DF00E
	for <lists+bpf@lfdr.de>; Sat, 19 Dec 2020 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgLSOiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Dec 2020 09:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLSOiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Dec 2020 09:38:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDEC0617B0
        for <bpf@vger.kernel.org>; Sat, 19 Dec 2020 06:37:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e25so6289380wme.0
        for <bpf@vger.kernel.org>; Sat, 19 Dec 2020 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WojhHSw0geLo9B8ITuq+V0a6D1sWyfvULBiB6yju3B8=;
        b=zNTZW7akcYOKLjF2xIPO/8aAouPauzd/RoXoJe0NhFfrW9WM2YwoAl0oYq1iHJ+7J3
         /Br9D8EZtcUbKeaJqAhK5Fdsp0Y25yu1bDIjs+V9zL7s/sx9sV+LRVKNqMAlMZFVpsE+
         5ZLgXlublEcGigD4xFXBwmotbhIRcfmOZX/w/4MZZZI3ugrlQ+ZbK8jjx+6FLFooF6D8
         xp7Sa83iXPbBQjwIlxA3ePmVp0T5jnjHhkbhz3y+EwUQGU6nxiFgZvEhLSELQLBDXJJ7
         t1qwHp8BjISb7q0WSul9uOLxXT7SWpnC4KOb/aLVCdC6IxDPtIjccXMp12/qHDx1E9uW
         0bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WojhHSw0geLo9B8ITuq+V0a6D1sWyfvULBiB6yju3B8=;
        b=ZkbXinxKaCrBwgHK98kXcEJmuNAWbmHZJdFwGtcu1whrN4UKIGS3toUR9rvXknwgVH
         Se5nJA8kXYuJkQe2VKUzvel3s2g48UvWImZf1KXdzRnwABP2YTTFyiEsn/h9sVn0q0U9
         o1GiHQwiUFt+8UMd7yshzAkvgirRlI9zmdaxvCiXbrY4/XB3TRrQJijEiOFIlCVJmzBY
         LPemVgFw1psULjlap2jEHkSW/xoUgVAsdiX/aE+LpbLiZ+Cw09BjCAnTCK+vRedv3Z+h
         KknFkaZ7AHWqSFKKJQ6BDQ3YvSE4I146s1Hu3KcUf2qQR4dTkMWMy+ni94Jur+EOeu32
         UBEQ==
X-Gm-Message-State: AOAM53121fJxskwCBUKvDgyZz/t1tPcVo5t27S4Zv0iGsHQ1fV/tqcpz
        nFlmKIelbqSJ5QJMHsyDgqAJDQ==
X-Google-Smtp-Source: ABdhPJz7R/8QtPaga9133ZXg3J+9drCeEabW3Dwjgf8yxEta0DldOfgBnRLhcEY0lg7krNsGzQyl3Q==
X-Received: by 2002:a1c:e3c4:: with SMTP id a187mr8460800wmh.58.1608388655509;
        Sat, 19 Dec 2020 06:37:35 -0800 (PST)
Received: from localhost (bba133967.alshamil.net.ae. [217.165.112.109])
        by smtp.gmail.com with ESMTPSA id q1sm17649117wrj.8.2020.12.19.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:37:34 -0800 (PST)
Date:   Sat, 19 Dec 2020 18:37:26 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Support pointer to struct in global
 func args
Message-ID: <20201219143726.f5ra5ji2lbq7sipf@amnesia>
References: <cover.1607973529.git.me@ubique.spb.ru>
 <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
 <CAEf4BzY3RaxvPcmQkTYsDa8MB+v6XpWuftdZEkFfgVVKgeLPbQ@mail.gmail.com>
 <20201217061307.e4m7ezbc73ga7lke@amnesia>
 <CAEf4BzZ-6ocyCASKt8r-q=GY2WY4u_bs+ybb2F5Q7ph+sfxDBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-6ocyCASKt8r-q=GY2WY4u_bs+ybb2F5Q7ph+sfxDBw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 18, 2020 at 11:52:20AM -0800, Andrii Nakryiko wrote:

> >
> >
> > >
> > > > +               const struct bpf_reg_state saved_reg = *reg;
> > >
> > > this saving and restoring of the original state due to
> > > mark_ptr_not_null_reg() is a bit ugly. Maybe it's better to refactor
> > > mark_ptr_not_null_reg to just return a new register type on success or
> > > 0 (NOT_INIT) on failure? Then you won't have to do this.
> >
> > It is not enough just to convert register's type - e.g. we also
> > want to change map_ptr to map->inner_map_meta for a case of
> > PTR_TO_MAP_VALUE_OR_NULL and inner_map_meta because it may be
> > used in check_helper_mem_access() -> check_map_access().
> 
> 
> Yep, missed that part in patch #1. But thinking about this more, I'm
> now missing the point of saving and restoring the register state. A
> comment would be welcome here, if it's really needed. I.e., if
> mark_ptr_not_null_reg fails, it doesn't change the state of the
> register. If check_helper_mem_access fails and changes the sate, then
> you have a similar problem few lines below anyway. So what's the case
> when check_helper_mem_access() succeeds and changes register state,
> but you still need to restore the register?

This saving is required because btf_check_func_arg_match()
happens in a callee context and we don't want to modify the
register state as it may be possible that the register will be
used later in the callee.

If any of the checks fail - the verifier mustn't accept a
program. If both of the checks succeed - we want to keep the
register state as it was before the call.


> > > > +}
> > > > +
> > > >  /* Implementation details:
> > > >   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
> > > >   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> > > > @@ -11435,6 +11458,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
> > > >                                 mark_reg_known_zero(env, regs, i);
> > > >                         else if (regs[i].type == SCALAR_VALUE)
> > > >                                 mark_reg_unknown(env, regs, i);
> > > > +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> > > > +                               const u32 mem_size = regs[i].mem_size;
> > > > +
> > > > +                               mark_reg_known_zero(env, regs, i);
> > > > +                               regs[i].mem_size = mem_size;
> > > > +                               regs[i].id = i;
> > >
> > > I don't think we need to set id, we don't use that for PTR_TO_MEM registers.
> >
> > If we don't set id then in check_cond_jump_id() ->
> > mark_ptr_or_null_regs() -> mark_ptr_or_null_reg() we don't
> > transform register type either to SCALAR(NULL case) or
> > PTR_TO_MEM(value case):
> > ...
> > if (reg_type_may_be_null(reg->type) && reg->id == id &&
> > ...
> >
> > The end result is that the verifier mem access checks fail for a
> > PTR_TO_MEM_OR_NULL register.
> 
> Hm... I see now. I was looking at check_helper_call() and handling of
> RET_PTR_TO_ALLOC_MEM_OR_NULL return result for bpf_ringbuf_reserve().
> It didn't seem to set id at all and yet works just fine. But now I see
> extra
> 
> if (reg_type_may_be_null(regs[BPF_REG_0].type))
>     regs[BPF_REG_0].id = ++env->id_gen;
> 
> after the big if/else if block there, so it makes sense. Thanks.
> 
> 
> regs[i].id = i; might not be wrong, but is unconventional, so let's
> stick with `++env->id_gen`?
> 

Agreed.


-- 

Dmitrii Banshchikov
