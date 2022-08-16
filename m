Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554559559B
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiHPIv7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiHPIvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:51:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE1F619B;
        Mon, 15 Aug 2022 23:56:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy5so17228961ejc.3;
        Mon, 15 Aug 2022 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=pyTZytG+72+2/FZ5A1dNsnzW13neVvkCe+2kVkYrp8Q=;
        b=AV3ifGSEj5rwDb3AbGDo+NVEIw1WNeHbNMtVSKR9X9ruPzZ1XfEv0oy7KrPKo0RQn/
         H64hT1+5BCeY7aa8v2Ydr11tm4uXivRuo/riY/K5DG8E5GzfPm+1VoChYqdCG2my64d7
         mc48Axjwqcq/1AkhvPx3ZdYEEJDtRUvvp69/c4dnUkbldDO8A9I96i2O/C+vd5BOwgu2
         YxTRxBM61+3MOPgE7Epi8XNbGRLilLC6hQqk94BVhDbZ53qiN1sCok933/BAo/vprrr1
         +FEn0et+6PpudVZBRFIBREcrDjIJdlEZjF9BwIW6S9PlVER95rtLqlx1GVeIHRgWrQWY
         6nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=pyTZytG+72+2/FZ5A1dNsnzW13neVvkCe+2kVkYrp8Q=;
        b=QFrFsiNsp+6gLzZMdP7gpRjm/XoRnh7z/sQIsoya/jQASdiY9XzU6JoamF8lqoxEMx
         sDcsWy2N59z8WFEtN/ODN4e1YN39bldpqnpHbwWQPiQLTz6FMtJK0Yqz8rXRoy0Zh79U
         bLYdgt8urcWqtbjX+tstgFZ/THSk1ZZ4xawGsf/bJlsy7L0P27EYE47tlNX0YJ925tXP
         GRWqizyXmWnOLty2xneJ5cOVXYHCZSCEL2VSF6EvwdT5CAUdWM6TC4HiSFwLDwEms9wQ
         6SDIXPfI6dKHORs6VI0HdpxVJLiTX7glcx9SUgnH4IVli1O+Wg4d2hUBVErPSGjs7U30
         b6Wg==
X-Gm-Message-State: ACgBeo1kgdzgBed4v0ZdHCHnKKP1DkXPdqFezlzauf7fytc/oBzHSEcP
        r7LMTs99WZR1jK9p0adMEOI=
X-Google-Smtp-Source: AA6agR6ZArVqpiETQpMGqtMCRP5KS4v0UE+Nj3hnOVE5nDn7IH2UZNQB7n3kCmxpBJDVtFc2Dii5Vg==
X-Received: by 2002:a17:907:60c7:b0:731:148b:c515 with SMTP id hv7-20020a17090760c700b00731148bc515mr12509099ejc.724.1660632997158;
        Mon, 15 Aug 2022 23:56:37 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h26-20020a17090619da00b00734bfab4d59sm4985944ejd.170.2022.08.15.23.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 23:56:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 08:56:33 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yvs/oey1NUlkI30d@krava>
References: <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
 <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 05:48:44PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 08:35:53AM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > > It's hiding a fake function from ftrace, since it's not a function
> > > > and ftrace infra shouldn't show it tracing logs.
> > > > In other words it's a _notrace_ function with nop5.
> > >
> > > Then make it a notrace function with a nop5 in it. That isn't hard.
> > 
> > That's exactly what we're trying to do.
> 
> All the while claiming ftrace is broken while it is not.
> 
> > Jiri's patch is one way to achieve that.
> 
> Fairly horrible way.
> 
> > What is your suggestion?
> 
> Mailed it already.
> 
> > Move it from C to asm ?
> 
> Would be much better than proposed IMO.

nice, that would be independent of the compiler atributes
and config checking..  will check on this one ;-)

thanks,
jirka

> 
> > Make it naked function with explicit inline asm?
> 
> Can be made to work but is iffy because the compiler can do horrible
> things with placing the asm().
