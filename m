Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49867B3C3
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 14:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjAYN7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 08:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjAYN7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 08:59:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9384FCE4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 05:59:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g11so16406710eda.12
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AB3jnNTmqnmOSG/b+f2wAJr3sH03GNVldRg1i5PEtSo=;
        b=gqYkZ2vIBr332j81vGmcv+25h3boWBkN5+ySpkZ0seGifZ8lvbjLrb0Zej6fLszYFV
         3E6lnQeMO/yJj6polwL6Ds0RJZVYSdjfJTAx+JUPlSqTgL/krNA+pczmgSC9cbEXnymH
         qhM+AQ+2UL3hcayEVgZANuIQHL6+1fm3TAbAux2+yS+KXpyOqgmLPfu3s1nin//gazip
         38CSgz9aIMFi0TZ1sVgvmQO1R2eySeT5UQMz4fT7+j87r/PmajOFv3w+wvFPVBR8HRGD
         SNai73zwPsb3sCGGLY41bBO+AgojKFpw0T/izKUDrGBBlIAJ+UOloG9iJm9TTf3242bP
         LAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB3jnNTmqnmOSG/b+f2wAJr3sH03GNVldRg1i5PEtSo=;
        b=Z1lAWO8AXcH4opT+fZpDKaWd2a470HYfz9iOHChykrUvY2fzKDAfJGJy0FpH2yZSCT
         aOUJ7UjDlpJiDUqWayOzt5AF33yOhloz7IHWgC4CZmn7ALBYZa8zZLTe8LasQoMZCOss
         R6SlhFrgS9Qyu91NMrTCAiZEq+T/9URGfcPYDYjJCVOXoHUtEASXZAUqFRe3LfrNwoLz
         CLvz8RvD9JaCl/8ThZauokFQqYZ0aZPs5YUQz3wXeAgaS1gskggSs7vaPPMEOb/nIDD6
         5tKihagL4UrurTOyrp2Begdi8fcbKMX75j2oyCFl/ElhwQ9n7uKVofAg/3BAqNRqQ+A3
         nOOw==
X-Gm-Message-State: AFqh2kp0L1oCXsbPjWUcTRnQz3t7h7D0ZcgoHlyXVMYifeUTN7yFIkr+
        1KSwm75po2FZQQK6dhYtkVA=
X-Google-Smtp-Source: AMrXdXunnd/7ZG4LhxWDn0JS6v6BsRuiKZ9hla01JOih3J7KCTcoj35PQpG88XmeooUvQf0Sk5LgzA==
X-Received: by 2002:a05:6402:4496:b0:49e:ca5:244a with SMTP id er22-20020a056402449600b0049e0ca5244amr36575472edb.1.1674655170332;
        Wed, 25 Jan 2023 05:59:30 -0800 (PST)
Received: from krava ([83.240.62.58])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906308300b0084cd08e5cb5sm2370986ejv.159.2023.01.25.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 05:59:30 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 14:59:27 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, yhs@fb.com,
        ast@kernel.org, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/5] dwarves: support encoding of optimized-out
 parameters, removal of inconsistent static functions
Message-ID: <Y9E1v4bWSKDEQvQa@krava>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <Y8/1vY5vaPcerfYw@krava>
 <d37a3596-4274-7ac6-615f-3e71393cc5d0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37a3596-4274-7ac6-615f-3e71393cc5d0@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 04:11:56PM +0000, Alan Maguire wrote:
> On 24/01/2023 15:14, Jiri Olsa wrote:
> > On Tue, Jan 24, 2023 at 01:45:26PM +0000, Alan Maguire wrote:
> >> At optimization level -O2 or higher in gcc, static functions may be
> >> optimized such that they have suffixes like .isra.0, .constprop.0 etc.
> >> These represent
> >>
> >> - constant propagation (.constprop.0);
> >> - interprocedural scalar replacement of aggregates, removal of
> >>   unused parameters and replacement of parameters passed by
> >>   reference by parameters passed by value (.isra.0)
> >>
> >> See [1] for details.
> >>
> >> Currently BTF encoding does not handle such optimized functions
> >> that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
> >> This is safer because such suffixes can often indicate parameters have
> >> been optimized out.  This series addresses this by matching a
> >> function to a suffixed version ("foo" matching "foo.isra.0") while
> >> ensuring that the function signature does not contain optimized-out
> >> parameters.  Note that if the function is found ("foo") it will
> >> be preferred, only falling back to "foo.isra.0" if lookup of the
> >> function fails.  Addition to BTF is skipped if the function has
> >> optimized-out parameters, since the expected function signature
> >> will not match. BTF encoding does not include the "."-suffix to
> >> be consistent with DWARF. In addition, the kernel currently does
> >> not allow a "." suffix in a BTF function name.
> >>
> >> A problem with this approach however is that BTF carries out the
> >> encoding process in parallel across multiple CUs, and sometimes
> >> a function has optimized-out parameters in one CU but not others;
> >> we see this for NF_HOOK.constprop.0 for example.  So in order to
> >> determine if the function has optimized-out parameters in any
> >> CU, its addition is not carried out until we have processed all
> >> CUs and are about to merge BTF.  At this point we know if any
> >> such optimizations have occurred.  Patches 1-4 handle the
> >> optimized-out parameter identification and matching "."-suffixed
> >> functions with the original function to facilitate BTF
> >> encoding.
> >>
> >> Patch 5 addresses a related problem - it is entirely possible
> >> for a static function of the same name to exist in different
> >> CUs with different function signatures.  Because BTF does not
> >> currently encode any information that would help disambiguate
> >> which BTF function specification matches which static function
> >> (in the case of multiple different function signatures), it is
> >> best to eliminate such functions from BTF for now.  The same
> >> mechanism that is used to compare static "."-suffixed functions
> >> is re-used for the static function comparison.  A superficial
> >> comparison of number of parameters/parameter names is done to
> >> see if such representations are consistent, and if inconsistent
> >> prototypes are observed, the function is flagged for exclusion
> >> from BTF.
> > 
> > should we remove all instances of static functions with same name?
> > 
> > Yonghong suggested in the other thread, that user will assume that
> > the function he's attached to is the one he expects, while he will
> > be attached to any (first) match we get from kallsyms_lookup_name
> >
> 
> The problem is that many static functions that have consistent
> prototypes are encountered multiple times when processing CUs,
> even though some have only one System.map/kallsyms entry. I tweaked patch 5 
> to count how many times a function was encountered when compiling the
> tree of static functions. It turns out of the 25872 functions, 22608 
> are found once, leaving 3264 that are found multiple times. This would
> be a lot of functions to leave out I think, especially since many
> don't actually have multiple kallsyms entries to deal with and
> the prototype is consistent.

ok, I checked and it seems like this is the case for inlined functions,
not sure what we can do here

all the instances having same prototype might be enough for now

jirka

> 
> BTW there's a bug in patch 5 that can cause a segmentation fault,
> apologies about this. I don't want to send a v2 yet as folks
> haven't had a chance to look at it properly but the fix is below.
> Thanks!
> 
> Alan
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index ee0b032..e89c1a8 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -786,7 +786,7 @@ static int function__compare(const void *a, const void *b)
>         return strcmp(function__name(fa), function__name(fb));
>  }
>  
> -#define BTF_ENCODER_MAX_PARAMETERS     10
> +#define BTF_ENCODER_MAX_PARAMETERS     12
>  
>  struct btf_encoder_state {
>         struct btf_encoder *encoder;
> @@ -869,7 +869,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *en
>                         }
>                         parameter_names__get(&fn->proto, BTF_ENCODER_MAX_PARAMET
>                                              parameter_names);
> -                       for (i = 0; i < ofn->proto.nr_parms; i++) {
> +                       for (i = 0; i < ofn->proto.nr_parms && i < BTF_ENCODER_M
>                                 if (!state->parameter_names[i]) {
>                                         if (!parameter_names[i])
>                                                 continue;
> 
> > thanks,
> > jirka
> > 
> >>
> >> When these methods are combined - the additive encoding of
> >> "."-suffixed functions and the subtractive elimination of
> >> functions with inconsistent parameters - we see a small overall
> >> increase in the number of functions in vmlinux BTF, from
> >> 49538 to 50083.  It turns out that the inconsistent prototype
> >> checking will actually eliminate some of the suffix matches
> >> also, for cases where the DWARF representation of a function
> >> differs across CUs, but not via the abstract origin late DWARF
> >> references showing optimized-out parameters that we check
> >> for in patch 1.
> >>
> >> [1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> >>
> >> Alan Maguire (5):
> >>   dwarves: help dwarf loader spot functions with optimized-out
> >>     parameters
> >>   btf_encoder: refactor function addition into dedicated
> >>     btf_encoder__add_func
> >>   btf_encoder: child encoders should have a reference to parent encoder
> >>   btf_encoder: represent "."-suffixed optimized functions (".isra.0") in
> >>     BTF
> >>   btf_encoder: skip BTF encoding of static functions with inconsistent
> >>     prototypes
> >>
> >>  btf_encoder.c  | 357 +++++++++++++++++++++++++++++++++++++++++++++++++--------
> >>  btf_encoder.h  |   2 +-
> >>  dwarf_loader.c |  76 +++++++++++-
> >>  dwarves.h      |   5 +-
> >>  pahole.c       |   7 +-
> >>  5 files changed, 390 insertions(+), 57 deletions(-)
> >>
> >> -- 
> >> 1.8.3.1
> >>
