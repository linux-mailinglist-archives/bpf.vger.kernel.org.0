Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E964DA26B
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbiCOSca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCOSc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:32:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91E56439
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:31:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h63so4252620iof.12
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yocIdl+9AZKNiXDING/5yDB5we7v5gB3vl0NcHrSv4M=;
        b=RfI9qHWP1nUjnOqwvNCEnz3oGeyvbb01ny8N3W/PHX0IJ95npvITnscDLL4JPUX+3g
         gs6LxPlKGCUMjHKd44a7xzgQGZSxdtKgILFFF28GwmLYYF5/cenf9RSoEdTtoggKFKya
         aKdH0kfN6bMV4+BglgM/CiY0slmFBVNqYPAxIMIuH1nmBn7DeGxhBPwmA4J4SBuTAABB
         LH24xfsqRevFP8XYLFrqvFTN34Lw304jRdj5DAF0usY+gx9vVnhzTUEDQy1MinauhRCC
         rxpuNOQondzRsRjHqBcxKfs6cp7WIPcx6pEl+8agL20giimwUC2lZWYgIwcP/y2gXXtC
         d4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yocIdl+9AZKNiXDING/5yDB5we7v5gB3vl0NcHrSv4M=;
        b=om4aN8pi8AOsXSGETyyDu4riVowh/LFmdoZVXXQ7Jk8GrnPtBBwXsRg2i6yhH/PXJU
         jxd0C22o3/zX0OxX9xYSp++hft9H8UW/5NVBg8qjsx1wYTUVUK+HamlxF2wXiZP/xkAk
         vADMVe+ky+XMdyXAL72+hbRtA/bE7efP/daPBQOybx1snnDz9ZucnY8lYNja71LxRuF8
         dSpsqrLcB1SqZLfh25SvctOO8wIinC7vB5yv/fRPgFMmcdFfa/bTSwOlym0e7tAygy1O
         QbhfANmcArOxumTtU5i0toHp9fkys34k4TxxxZeEoixKa+jmW2BHuBsxReK+PM+yx7r6
         vPfw==
X-Gm-Message-State: AOAM530GSsYY5a5JBw92Y++GSoBsrtsC2yfSK44ZsWMkVeYmg0JLGyUD
        QKlwQsnc8WbmLU7alZnbjq2Jt/KD76l38jf/TDneR8Lj9aw=
X-Google-Smtp-Source: ABdhPJxC5nDTuZ6mBwjrJQWZwF2BEBJqm4C5o0wgd+eR3qparPyNGVeTEPARs7uMkxEJvUpidFp/ntGLm0rbTTmJnJw=
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id
 h40-20020a05663833a800b00319cb5cf6d9mr19072807jav.93.1647369076221; Tue, 15
 Mar 2022 11:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <f262f63b36d00d4a77d1166bcaffe7684b6ebbee.1646957399.git.delyank@fb.com>
 <CAEf4BzaVt=+g2gKpMqsNH5JGSvEJnjnDHW7ueFFgcUtBv1z01Q@mail.gmail.com> <2636cbb9d5207841340d7b17d893227c1576c982.camel@fb.com>
In-Reply-To: <2636cbb9d5207841340d7b17d893227c1576c982.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:31:04 -0700
Message-ID: <CAEf4BzZ2SZB185mF8J-kFaWOYkAXG3WiB45q7RZRezbTfm=zdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton functionality
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 4:50 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Fri, 2022-03-11 at 15:40 -0800, Andrii Nakryiko wrote:
> >
> > we shouldn't need or use name for subskeleton (in real life you won't
> > know the name of the final bpf_object)
>
> Let's have this discussion in the bpftool email thread. Happy to remove the name
> in the Makefile and fall back on the filename though.
>

It's fine, keep it, you explained why we need it.

> > >
> > >  $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> > >         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> > > @@ -421,6 +428,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
> > >         $(Q)diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
> > >         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> > >         $(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@
> > > +       $(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h)
> >
> > probably don't need subskel for LSKELS (and it just adds race when we
> > generate both skeleton and light skeleton for the same object file)
>
> We're not generating subskels for LSKELS, that's just confusing diff output.
> This is under the $(TRUNNER_BPF_SKELS_LINKED) outputs.

indeed confusing, never mind then

>
> >
> > can you please add CONFIG_BPF_SYSCALL here as well, to check that
> > externs are properly "merged" and found, even if they overlap between
> > library and app BPF code
>
> Sure.
>
> >
> > libbpf supports .data.my_custom_name and .rodata.my_custom_whatever,
> > let's have a variable to test this also works?
>
> Sure.
>
> >
> > let's move this into progs/test_subskeleton.c instead. It will
> > simulate a bit more complicated scenario, where library expects
> > application to define and provide a map, but the library itself
> > doesn't define it. It should work just fine right now (I think), but
> > just in case let's double check that having only "extern map" in the
> > library works.
>
> This fails to even open in bpftool:
>
> libbpf: map 'map2': unsupported map linkage extern.
> Error: failed to open BPF object file: Operation not supported
>
> If we think this is valuable enough to support, let's tackle it separately after
> the bulk of this functionality is merged?

yep, totally. It's not super critical to support, but seems like a
useful use case for library to be able to access some pre-agreed map
in the final BPF app

>
>
> -- Delyan
