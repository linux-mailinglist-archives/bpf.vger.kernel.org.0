Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A068EFAD
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBHNUk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 08:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHNUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 08:20:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222447439
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 05:20:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so1446769wma.1
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6xkM5KE7ry8f/7r2GCIsn0Ntuy5mG2oxHeqCD/yYqU=;
        b=h7me9x85SDK180QJkZLx8vNk9bfIoQ54EuBgQOgvH0D5XXNfl0/urlwTArG3P46ZC5
         ZRRk/xMrX6pxCIgFEPkAWtwPvRYfyPkZKhtpc3T3WSUDrJXXhpJFhXXyRg/wDbH+ASfA
         a+fE5+vCK7ke8iEOlLLsflLN2Era1XjtuOxzPBp2Y2hNWgQLnfZ7sAI4bu0/iGFAAwn6
         v7gVX71GMerqd9KQ8S0LNdDs+zDniU9+/STAnqU3yRoWv8GJyQElXw92hkN2u9nmlta5
         r2XvC1iROYAV55KmrhYlfC6Xjm9+fTIvnmDpmNKIqVENXlaPqQmb6k/kJuFV8Uci2+bv
         4n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6xkM5KE7ry8f/7r2GCIsn0Ntuy5mG2oxHeqCD/yYqU=;
        b=vT9JjrfVTcJ0OrnJExKzwSod3KXG6CXH5cm2MTu/rr3b6KjFgloBo6ve89SolvNGKY
         fXDqqjWXN6nBuOpYmX0HbklFfaAs31/97GNeAG/OeEXJYd3tuyHyk79Uc1xr8ZDkAXGh
         e8CNBaQF/0O5jJqLS7aJM+EuSGkQca/rHRO3TdD6zH4tPOrt4Qnk/9yiPT1aMeVS1oSa
         w+f+B0OQZiSv/S8ULzWmD9OpOZ31d/voY0PfE1o4W70t6sDmJwOPmOMzzrJ52VU+0MAc
         /unbyl68v8PH93Mved7xp6kUs/bDPg443ALIyJam+g8sgybhLtBbVA7DieP8R86bH5Ik
         YQTg==
X-Gm-Message-State: AO0yUKXeA9TJ55TEYS+mKmSyiOZhPYKyXFKI+kXmEyg+J6Ji+J/IeMke
        3Dkjlsv50nY2z8QMu3E+S38=
X-Google-Smtp-Source: AK7set9ybcssoLQY1z7FuFDQHBjTpJt0jTJq5meL1BHN6NLxrjx1dcMWkeVMkykBHSZRqyRk5sZjHQ==
X-Received: by 2002:a05:600c:9a2:b0:3dd:393c:20b5 with SMTP id w34-20020a05600c09a200b003dd393c20b5mr6425750wmp.35.1675862436984;
        Wed, 08 Feb 2023 05:20:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c48a300b003dc3f195abesm1771059wmp.39.2023.02.08.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:20:36 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 14:20:34 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 0/8] dwarves: support encoding of
 optimized-out parameters, removal of inconsistent static functions
Message-ID: <Y+OhotzeEIdPByi6@krava>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 05:14:54PM +0000, Alan Maguire wrote:

SNIP

> 
> Changes since v2 [2]
> - Arnaldo incorporated some of the suggestions in the v2 thread;
>   these patches are based on those; the relevant changes are
>   noted as committer changes.
> - Patch 1 is unchanged from v2, but the rest of the patches
>   have been updated:
> - Patch 2 separates out the changes to the struct btf_encoder
>   that better support later addition of functions.
> - Patch 3 then is changed insofar as these changes are no
>   longer needed for the function addition refactoring.
> - Patch 4 has a small change; we need to verify that an
>   encoder has actually been added to the encoders list
>   prior to removal
> - Patch 5 changed significantly; when attempting to measure
>   performance the relatively good numbers attained when using
>   delayed function addition were not reproducible.
>   Further analysis revealed that the large number of lookups
>   caused by the presence of the separate function tree was
>   a major cause of performance degradation in the multi
>   threaded case.  So instead of maintaining a separate tree,
>   we use the ELF function list which we already need to look
>   up to match ELF -> DWARF function descriptions to store
>   the function representation.  This has 2 benefits; firstly
>   as mentioned, we already look up the ELF function so no
>   additional lookup is required to save the function.
>   Secondly, the ELF representation is identical for each
>   encoder, so we can index the same function across multiple
>   encoder function arrays - this greatly speeds up the
>   processing of comparing function representations across
>   encoders.  There is still a performance cost in this

awesome.. great we can do it without the extra tree

I wonder we could save some cycles just by memdup-ing the encoder->functions
array for the subsequent encoders, but that's ok for another patch ;-)

thanks,
jirka
