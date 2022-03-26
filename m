Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377354E802A
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 10:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiCZJKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Mar 2022 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCZJKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 05:10:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4D13F9F
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 02:09:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h1so11636205edj.1
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eyjrDx/l0AZfvR49FShSHR555RvbzofR0ZsQN/fcyiE=;
        b=AFI8pCzKBRrahdqXaq2AtmEbITT34RxBcK4XDikTkeseearlCSFf2dbKRHeG8UCkUo
         DsMNHEzZw+C1PxuhedFBR6gQR4CzqK9gTinhmkJIsbFKWAvEVl0ty2rCK13izzm8Y8A9
         rllNKaAYPocF3fpzFX4ceVErDjfj/uBT7qPaooEiU3RZGkd7OJkaBfeA47UJDp+xxfC6
         REIUDUJL/u57Aq72MZhP4VaxDMNmHIW33+D1EdJfkruJj78qMvEPw0/I+aSnKqHyUWft
         6qQVlJPUksmHBHCmG9ELOVigbsIroUI5llmjVtW9BNy57YBTEDL8nSnyaTYn45IBlANf
         dmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eyjrDx/l0AZfvR49FShSHR555RvbzofR0ZsQN/fcyiE=;
        b=HPXJysqKqpvdBP82u0GlEqjNOlAI9j9XuBn0uBD5e38E4fdmOlZX7+CFqmSYkJskHN
         vTbN1qWCFD63zLC2zDBTC5/dnh3/CcLavcmTsXEzitcBjjyikAMnXoFNyT4e9BmMYLgi
         gHZ/ltMlWrlnjrNCxovJMSztsueqJXrL/+aSCJtXZBrbTIT5r4sflWZPj4/kRYattk7y
         POT9+6wQTPBVRgE2IroneWLN1WXxFBH5irodYcf1OnL5A0pog7Skq3WBbvofl9nOCtmK
         x8ksAAySYGW2dVLTtzlLBNnwXvuVCFO8udZGiOdnfu/4w+qJSDVrThqq9FwEJQUFq4l8
         sCgg==
X-Gm-Message-State: AOAM533oBKQOhMLncBPFzWP1vCkTUjOW1zh5nubtjRLvpFDFqEzK6vO5
        NjIpIsDJePAVznI889+tGmfg/TKgaPwt5g==
X-Google-Smtp-Source: ABdhPJy0TJ/gaHa0peijoMK5nHOJpKuRWAkPTz7xxrE0jCmSVB/lK55i2czmnY5/XD63txkwNLO6eQ==
X-Received: by 2002:a05:6402:51d2:b0:419:7d2e:9d0 with SMTP id r18-20020a05640251d200b004197d2e09d0mr3353882edd.82.1648285748984;
        Sat, 26 Mar 2022 02:09:08 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id a102-20020a509eef000000b0041614c8f79asm3822986edf.88.2022.03.26.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 02:09:08 -0700 (PDT)
Date:   Sat, 26 Mar 2022 10:08:34 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
Message-ID: <20220326090834.f7ukfgjyfhk6sbws@erthalion.local>
References: <20220309163112.24141-1-9erthalion6@gmail.com>
 <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sat, Mar 26, 2022 at 01:38:36AM +0000, Quentin Monnet wrote:
> 2022-03-09 17:31 UTC+0100 ~ Dmitrii Dolgov <9erthalion6@gmail.com>
> > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > BPF perf links") introduced the concept of user specified bpf_cookie,
> > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > bpftool as well, so there is no need to meddle with the target BPF
> > program itself.
> >
> > [...]
> >
> > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > index 7c384d10e95f..bb6c969a114a 100644
> > --- a/tools/bpf/bpftool/pids.c
> > +++ b/tools/bpf/bpftool/pids.c
> > @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> >  	ref->pid = e->pid;
> >  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
> >  	refs->ref_cnt = 1;
> > +	refs->has_bpf_cookie = e->has_bpf_cookie;
> > +	refs->bpf_cookie = e->bpf_cookie;
> >
> >  	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
> >  	if (err)
> > @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
> >  		if (refs->ref_cnt == 0)
> >  			break;
> >
> > +		if (refs->has_bpf_cookie)
> > +			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
> > +
>
> Thinking again about this patch, shouldn't the JSON output for the
> cookie(s) be an array if we expect to have several cookies for
> multi-attach links in the future?

Interesting point. My impression is that this could be done together
with the other changes about making multi-attach links possible (I
didn't miss anything, it's not yet implemented, right?). On the other
hand I'm planning to prepare few more patches in similar direction -- so
if everyone agrees it has to be extended to an array now, I can tackle
this as well.
