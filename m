Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649C4C8708
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiCAIuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 03:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCAIuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 03:50:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A588B19;
        Tue,  1 Mar 2022 00:49:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qa43so3429954ejc.12;
        Tue, 01 Mar 2022 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/dTKsTlJoAMJumsyrRxzfnundSrBfGjpNewNTBVE3g=;
        b=UMR5D8LUETMDJIRm8LH106mmH+mPx7oRETLdReqff2ow5K6V3No1KKJHvqjtWi68mz
         aYuj6PeKrjXbnJC9a0BR+h59jpxBvOEqcc2nbl4i4wwF6iHXmKKb1dhEMf2gsY1iyjas
         lBXyrlR7nedt3/hoWWMdr2u36GD0Dk68MOsFnBIkUH6kttfbgAfshM+R6QvoC4ppGap8
         AfpMEqGLLEzeuAHWx6U0GT6RUzAwuyLRikXRsL8bPj4KaepvK+tQINt2FNYk1t8VBaM1
         XOC7dFVU/qmOAmiEa3+nkBkG6ZfYfhXdVccHONcfE0/J/H7nQRhQ3c1B1XA5D7RFPHxx
         by3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/dTKsTlJoAMJumsyrRxzfnundSrBfGjpNewNTBVE3g=;
        b=syEs/4UZHLS/prm3UTsxfO5wWp2gLMq8Gry4ryoZTsJSg4IqiojK2XsBusvolDNn1k
         r5DqnJeUkDb7hx3JX4Kj7VayDHFWnwe0ZLE2wyEl2dWpPBnNggFUoEr1k1MQILYWHJqG
         SD/UyYd3bCg1esCZQXfHjD8Brj4/w+JxCrpPG/BDDEfdNK2nuRWDZDYtAqscQ253Kxnx
         cGlGVqMhdYzc0rT5w+NzgyqCinuQRCpIqiwf22sHjbVV0Z9+G4t9jnOtSBBSh6BkPKSQ
         Ki0wv2YmsH6VdRoCTSrKzIOvVMQBW0Bop+6Cq4xWrtyK4Mz58HzTncWumCzfnB24nbMp
         bYoA==
X-Gm-Message-State: AOAM5309lh8bPYBiRbqT45Ewo6el45/Ns/s2Pjf6zWNWkxJs7uG/Rj9m
        2CdFzOi9FGy0HrQjXWTALoyqswk+pDc=
X-Google-Smtp-Source: ABdhPJyXLNhWPTlwkeTX6XCnWOx9AIDBadd18VKP0VguKj0cTsw+Y69kQfzopwYg4QuMIq0zU+NoYQ==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr18525916ejj.275.1646124573342;
        Tue, 01 Mar 2022 00:49:33 -0800 (PST)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id qb30-20020a1709077e9e00b006d6f8c77695sm184392ejc.101.2022.03.01.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:49:32 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:49:30 +0100
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
Subject: Re: [PATCH 2/2] perf tools: Remove bpf_map__set_priv/bpf_map__priv
 usage
Message-ID: <Yh3eGjZj7aY1kuIY@krava>
References: <20220224155238.714682-1-jolsa@kernel.org>
 <20220224155238.714682-3-jolsa@kernel.org>
 <CAEf4BzbqbHDzGJJu8Zp1QPa-bxT_usespzs=rEj2UX0A-k0gPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbqbHDzGJJu8Zp1QPa-bxT_usespzs=rEj2UX0A-k0gPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 05:49:32PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 24, 2022 at 7:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Both bpf_map__set_priv/bpf_map__priv are deprecated
> > and will be eventually removed.
> >
> > Using hashmap to replace that functionality.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/bpf-loader.c | 66 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > index b9d4278895ec..4f6173756a9d 100644
> > --- a/tools/perf/util/bpf-loader.c
> > +++ b/tools/perf/util/bpf-loader.c
> > @@ -27,6 +27,7 @@
> >  #include "llvm-utils.h"
> >  #include "c++/clang-c.h"
> >  #include "hashmap.h"
> > +#include "asm/bug.h"
> >
> >  #include <internal/xyarray.h>
> >
> > @@ -57,6 +58,7 @@ struct bpf_perf_object {
> >
> >  static LIST_HEAD(bpf_objects_list);
> >  static struct hashmap *bpf_program_hash;
> > +static struct hashmap *bpf_map_hash;
> >
> >  static struct bpf_perf_object *
> >  bpf_perf_object__next(struct bpf_perf_object *prev)
> > @@ -204,6 +206,8 @@ static void bpf_program_hash_free(void)
> >         bpf_program_hash = NULL;
> >  }
> >
> > +static void bpf_map_hash_free(void);
> > +
> >  void bpf__clear(void)
> >  {
> >         struct bpf_perf_object *perf_obj, *tmp;
> > @@ -214,6 +218,7 @@ void bpf__clear(void)
> >         }
> >
> >         bpf_program_hash_free();
> > +       bpf_map_hash_free();
> >  }
> >
> >  static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
> > @@ -976,7 +981,7 @@ bpf_map_priv__purge(struct bpf_map_priv *priv)
> >  }
> >
> >  static void
> > -bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
> > +bpf_map_priv__clear(const struct bpf_map *map __maybe_unused,
> >                     void *_priv)
> >  {
> >         struct bpf_map_priv *priv = _priv;
> > @@ -985,6 +990,53 @@ bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
> >         free(priv);
> >  }
> >
> > +static void *map_priv(const struct bpf_map *map)
> > +{
> > +       void *priv;
> > +
> > +       if (IS_ERR_OR_NULL(bpf_map_hash))
> > +               return NULL;
> > +       if (!hashmap__find(bpf_map_hash, map, &priv))
> > +               return NULL;
> > +       return priv;
> > +}
> > +
> > +static void bpf_map_hash_free(void)
> > +{
> > +       struct hashmap_entry *cur;
> > +       size_t bkt;
> > +
> > +       if (IS_ERR_OR_NULL(bpf_map_hash))
> > +               return;
> > +
> > +       hashmap__for_each_entry(bpf_map_hash, cur, bkt)
> > +               bpf_map_priv__clear(cur->key, cur->value);
> > +
> > +       hashmap__free(bpf_map_hash);
> > +       bpf_map_hash = NULL;
> > +}
> > +
> > +static int map_set_priv(struct bpf_map *map, void *priv)
> > +{
> > +       void *old_priv;
> > +
> > +       if (WARN_ON_ONCE(IS_ERR(bpf_map_hash)))
> > +               return PTR_ERR(bpf_program_hash);
> > +
> 
> you didn't warn for this in the previous patch. I have no preference,
> just pointing out assymetry.

there's already message from the caller when program_set_priv fails,
so I don't think we need another one

jirka

> 
> > +       if (!bpf_map_hash) {
> > +               bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> > +               if (IS_ERR(bpf_map_hash))
> > +                       return PTR_ERR(bpf_map_hash);
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
