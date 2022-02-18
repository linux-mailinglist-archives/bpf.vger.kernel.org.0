Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1614BB4D1
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 10:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiBRJB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 04:01:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiBRJBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 04:01:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5251333;
        Fri, 18 Feb 2022 01:01:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so13320031wra.12;
        Fri, 18 Feb 2022 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/2RVN5M9vXns43fjksLrxbLt9+niN7MDRyGnX4gqEJk=;
        b=Uul2xMXiAiQUcxLLlZVJWfTbrRdmG1GRcv1msFnH5DMOOHaSK1tp54asAGkAPpRgHo
         E5lqIz9jcJuVh/tIHOhcbduvVGBRTP9KgYyFuO7Zyicct4Nk1lknuwWRUu8SgtMrZL8e
         LqW+w25Wn+kUZ7WOT534Zq9Haiw1fRvdPd3ghZgswqP2MSsgVKqQ2ArovCakLUrKvB7W
         1CWqmHJvGIsHe6AYrsV90XUdUimUmbjbp7T41lhVoSSPlYdkkjIvduqvdTRJkSRvp1St
         ezKrnRweNRQWhyNJy1hxyZJz1J5f8XPZvrW5gERur/AtFB97v370oSwL4MWlS/dFZUf/
         Ovrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2RVN5M9vXns43fjksLrxbLt9+niN7MDRyGnX4gqEJk=;
        b=BJAGm010DirZnczjVWrneCB697osUkls0HpXGhQQVjBNjgu0yxWcfzU8bXeDRX+h5h
         lqypcNUKJwr2s92pAq2BULTJKxMuz5xlGVrtNsMmUZ5eeq9p2LJgjHoj7i67FF/HT8iH
         a9ZVfbu93I4qD8RDyDQ/brdk7mM/WM9zNBXy3MgrKdiwSeTYVQEVvmHKxaXf71Ovx0EO
         al0KjrWnYPAulIClvmUj2nu/axX/q1K8Uso+3CgYDgYx+Crh9QLrovdRbGhFOXeauAlW
         tJACrMCbOwG6zW0ZzvpfmAJPUHNHYxy/4jMLvRZslsY7Gt08D1eOv/5r6GFhqlBMwaLG
         agXA==
X-Gm-Message-State: AOAM533UVXfbbELQpEQeuGK0QX1XAzTQ4PkqO1otL3WSAZnd6JxfZECQ
        Sgj/eQap8P3hjhPuGd5oXO4=
X-Google-Smtp-Source: ABdhPJzj+BYZM338XHFtQ5TIAImmc4aJR4kwW0nrC8szNpLJcZB+7lshwPzHCdorZ9yIVprTKi8mmw==
X-Received: by 2002:adf:ebd0:0:b0:1e3:f9b:7b77 with SMTP id v16-20020adfebd0000000b001e30f9b7b77mr4977912wrn.691.1645174897447;
        Fri, 18 Feb 2022 01:01:37 -0800 (PST)
Received: from krava ([2a00:102a:5012:d617:c924:e6ed:1707:a063])
        by smtp.gmail.com with ESMTPSA id q23sm3617224wmj.44.2022.02.18.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:01:37 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:01:34 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/3] perf tools: Remove bpf_map__set_priv/bpf_map__priv
 usage
Message-ID: <Yg9gbqIccM/JHEpu@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-3-jolsa@kernel.org>
 <CAEf4BzYoCioENBuXEb-B7ZK8D0YFzs_j3XFN8NS35PAWY04O+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYoCioENBuXEb-B7ZK8D0YFzs_j3XFN8NS35PAWY04O+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 01:49:39PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Both bpf_map__set_priv/bpf_map__priv are deprecated
> > and will be eventually removed.
> >
> > Using hashmap to replace that functionality.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-loader.c | 62 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 55 insertions(+), 7 deletions(-)
> >
> 
> [...]
> 
> > +static int map_set_priv(struct bpf_map *map, void *priv)
> > +{
> > +       void *old_priv;
> > +
> > +       if (!bpf_map_hash) {
> > +               bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> > +               if (!bpf_map_hash)
> 
> same as in previous patch, on error this is not going to be NULL

yes, will change

jirka

> 
> > +                       return -ENOMEM;
> > +       }
> > +
> > +       old_priv = map_priv(map);
> > +       if (old_priv) {
> > +               bpf_map_priv__clear(map, old_priv);
> > +               return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
> > +       }
> > +       return hashmap__add(bpf_map_hash, map, priv);
> > +}
> > +
> 
> [...]
