Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFEB690266
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 09:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBIIpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 03:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBIIpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 03:45:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4B59E65
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 00:45:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3315776wmp.3
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 00:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tPoEIk1ql0tVpqUiwJNAyh0Z4A1Fg9mE9rd0Q0dF48=;
        b=qWGVbdO3wbVlDUAz7Q+Ga3UQ4m4kI+7kS4RZtiCl9BfqHIGblLtbTdpZnw+hK20oV5
         KlaOallhU5jr57aHzFnqv/9HrxVBCUaJeRPNUw/tqGz7Wul5sGE5bU6OfUONNJC1IeLv
         YVsUdPyMLVskOg8b9R/HqmvIqVtRoEJgfXTuZBOnE3iC0iquIiW3o4G0eqZ8zg9uSroj
         hJZJeAtMhUWj2NL4WT/jVWTkf44LO8BbY3s0vYTC0PZEFWkXTCUPFLj6Yn4Z0Pbs3Ya/
         /pIWks9XVLzOuaByn6V5StzqF8CyCYhMY/C1DkRl6VX2vEWhuoSl99QOY1A1cyrkLTk2
         xu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tPoEIk1ql0tVpqUiwJNAyh0Z4A1Fg9mE9rd0Q0dF48=;
        b=G8tuZrWXSDba7h/W9VzYHK6kLG1yw6/sUL+GFpvTpVvEfyLd8wWPbjhhsItKUpkn+U
         MdzKtAp7FNbPt/bGOwnHfLsn+GMe4JZVd1GYAd+Dt16Ifdy2jQ4GcaSOsQ1/K/zcJE8o
         EggjY8zIkpoePBV1exuT00glfVxAGfdJ2ZA4JmMsEszYnzt34JvUElhFBGaTplv4rK53
         sHDNPLAKlmvxQK8dYlpsRDdoC6gt/Jjx98zXO9MzJKRp89fdOGgzoyKaIQc/sMVI9tUR
         fbUPn7VYQPfeiUgapS/u96fS9wDu8DD2/KWMbnpvcyFsHXbjiueLJjtQtS/5HsyVlmXg
         Bgfg==
X-Gm-Message-State: AO0yUKUIVZlvEU3i6/0ieuRdpjmsT+0cLyouMR1loF7dB7xnH5q+qQtY
        6hWXghlGWzKPyjfQXLHABJE=
X-Google-Smtp-Source: AK7set9vA8V5wLoX3I91yYFmI+Uwq/7jn40LuEzEcHrnCFLKl+Ec6LghBqg1L/QclMlMfHHqqdAFog==
X-Received: by 2002:a05:600c:1817:b0:3df:e54a:4ac5 with SMTP id n23-20020a05600c181700b003dfe54a4ac5mr9311809wmp.27.1675932328533;
        Thu, 09 Feb 2023 00:45:28 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003db03725e86sm1315005wmo.8.2023.02.09.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:45:28 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 09:45:25 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv3 bpf-next 1/9] selftests/bpf: Move kfunc exports to
 bpf_testmod/bpf_testmod_kfunc.h
Message-ID: <Y+SypX3Ox1kD0Ew+@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-2-jolsa@kernel.org>
 <Y+JgEIwzW7+UkCj9@maniforge.lan>
 <CAEf4BzbQdpgkBjqK2eO53ZkLb5Zy0n3oVj9en10kO8JH2ANYHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbQdpgkBjqK2eO53ZkLb5Zy0n3oVj9en10kO8JH2ANYHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 04:20:13PM -0800, Andrii Nakryiko wrote:

SNIP

> > > diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
> > > index 7653df1bc787..823901c1b839 100644
> > > --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> > > +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> > > @@ -2,6 +2,7 @@
> > >  #include <vmlinux.h>
> > >  #include <bpf/bpf_tracing.h>
> > >  #include <bpf/bpf_helpers.h>
> > > +#include "bpf_testmod/bpf_testmod_kfunc.h"
> >
> > Feel free to ignore if you disagree, but here and elsewhere, should we
> > do this:
> >
> > #include <bpf_testmod/bpf_testmod_kfunc.h>
> >
> > rather than using #include "bpf_testmod/bpf_testmod_kfunc.h". Doesn't
> > matter much, but IMO it's just slightly more readable to use the <> to
> > show that we're relying on -I rather than expecting
> > bpf_testmod/bpf_testmod_kfunc.h to be found at a path relative to the
> > progs. #include "bpf_misc.h" makes more sense because it really is
> > located in the progs/ directory.
> 
> We do <> for headers that are expected to be installed in the system
> (even if we cheat with -I sometimes). But in this case it's a local
> header, so using "" makes more sense to me. But shouldn't it be
> "../bpf_testmod/bpf_testmod_kfunc.h"?

I think we have -I<..selftests/bpf> so it works.. but right, we want
to show it's local header, so "../bpf_testmod/bpf_testmod_kfunc.h"
makes sense to me

jirka
