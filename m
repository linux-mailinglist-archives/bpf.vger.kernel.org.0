Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DD4C8084
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCABuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCABuc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:50:32 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE15B880;
        Mon, 28 Feb 2022 17:49:44 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 195so16988033iou.0;
        Mon, 28 Feb 2022 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKJn0pfzeo+R2i4pyNe0iUGsKGD7jcEKU3AQW9M1M30=;
        b=h7Q4JZSlzXH3pZP5XmHQZ++eP6ObyZ2SalgJdiLIlOvLtH/6FrJyPEgiC25prxUeLP
         lFRI6QMPL1+VkIcBAep4Mvv736w7UzzJpucHluc9fnYGDIyjDm/gJBTiUGLXC8ZmJXeJ
         ujgj3UChxD8h4P/3fIcLE406OrcGIdD9Rabo8cs1AjasAoNv0Ue1C87Wf9HSIgQDhywz
         bGITmpmbvQ6CDpvetUEprrRyLGPWUAH1B6sLQftSUTCba38J7qcWR1s57CHiitLedLBR
         N9qLecuKJiX6SgvkuYj7Dn2URjZBxfrGYAGKoNzr3F8ZpiaWmPdH5w0P/TV3byy2Z4Q6
         zR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKJn0pfzeo+R2i4pyNe0iUGsKGD7jcEKU3AQW9M1M30=;
        b=uR/hPnzuprv5hBP36hACLfCvspto+qzuAettZ7h8Pc6wRvxgF2ojCo8WaYViaSK2wo
         dh6xQMZwiSsG7WFr56PNqhTCq62p/1jeewyVFUh+BnoFtj7FANKWeKuqJywy/U0AVZGW
         yC+UanYJrQsgUus5YJT/jya0jZ+bHMFbLPLTcxp54KgYXxknvFFxGZRjF+6VUzH+C96Z
         p1IOXP8hSvgHNpoEJgjMfuU+OsfjbOcMzZgF06jlVALTlCt1zcT/LHrsHwKMRBv7ZU2F
         EOJVFkVTNQVpnQr1KZEV16gIFom68A6Z+uhJtyjR7Iq7seHuubmFBTDvgGeWPCPiHj+P
         1Gvw==
X-Gm-Message-State: AOAM531uMyXi/wt/wEwm0Omg52b2B9tLkKYT4n7u68MECmxb92+7qKOk
        9Gf6ZQZcdCpwOanEICP7fRQduSMNXbyJBsWJOio=
X-Google-Smtp-Source: ABdhPJyU/Ki1eGodgHHAJAa78gROyJmvIGMAyXiIpnNZCAaM1I/fl/hUSIYUB4HwuoVORotDg1GOCWcFW0EjAepd84I=
X-Received: by 2002:a05:6638:1035:b0:306:e5bd:36da with SMTP id
 n21-20020a056638103500b00306e5bd36damr19958576jan.145.1646099383423; Mon, 28
 Feb 2022 17:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20220224155238.714682-1-jolsa@kernel.org> <20220224155238.714682-3-jolsa@kernel.org>
In-Reply-To: <20220224155238.714682-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Feb 2022 17:49:32 -0800
Message-ID: <CAEf4BzbqbHDzGJJu8Zp1QPa-bxT_usespzs=rEj2UX0A-k0gPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Thu, Feb 24, 2022 at 7:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_map__set_priv/bpf_map__priv are deprecated
> and will be eventually removed.
>
> Using hashmap to replace that functionality.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-loader.c | 66 ++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index b9d4278895ec..4f6173756a9d 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -27,6 +27,7 @@
>  #include "llvm-utils.h"
>  #include "c++/clang-c.h"
>  #include "hashmap.h"
> +#include "asm/bug.h"
>
>  #include <internal/xyarray.h>
>
> @@ -57,6 +58,7 @@ struct bpf_perf_object {
>
>  static LIST_HEAD(bpf_objects_list);
>  static struct hashmap *bpf_program_hash;
> +static struct hashmap *bpf_map_hash;
>
>  static struct bpf_perf_object *
>  bpf_perf_object__next(struct bpf_perf_object *prev)
> @@ -204,6 +206,8 @@ static void bpf_program_hash_free(void)
>         bpf_program_hash = NULL;
>  }
>
> +static void bpf_map_hash_free(void);
> +
>  void bpf__clear(void)
>  {
>         struct bpf_perf_object *perf_obj, *tmp;
> @@ -214,6 +218,7 @@ void bpf__clear(void)
>         }
>
>         bpf_program_hash_free();
> +       bpf_map_hash_free();
>  }
>
>  static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
> @@ -976,7 +981,7 @@ bpf_map_priv__purge(struct bpf_map_priv *priv)
>  }
>
>  static void
> -bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
> +bpf_map_priv__clear(const struct bpf_map *map __maybe_unused,
>                     void *_priv)
>  {
>         struct bpf_map_priv *priv = _priv;
> @@ -985,6 +990,53 @@ bpf_map_priv__clear(struct bpf_map *map __maybe_unused,
>         free(priv);
>  }
>
> +static void *map_priv(const struct bpf_map *map)
> +{
> +       void *priv;
> +
> +       if (IS_ERR_OR_NULL(bpf_map_hash))
> +               return NULL;
> +       if (!hashmap__find(bpf_map_hash, map, &priv))
> +               return NULL;
> +       return priv;
> +}
> +
> +static void bpf_map_hash_free(void)
> +{
> +       struct hashmap_entry *cur;
> +       size_t bkt;
> +
> +       if (IS_ERR_OR_NULL(bpf_map_hash))
> +               return;
> +
> +       hashmap__for_each_entry(bpf_map_hash, cur, bkt)
> +               bpf_map_priv__clear(cur->key, cur->value);
> +
> +       hashmap__free(bpf_map_hash);
> +       bpf_map_hash = NULL;
> +}
> +
> +static int map_set_priv(struct bpf_map *map, void *priv)
> +{
> +       void *old_priv;
> +
> +       if (WARN_ON_ONCE(IS_ERR(bpf_map_hash)))
> +               return PTR_ERR(bpf_program_hash);
> +

you didn't warn for this in the previous patch. I have no preference,
just pointing out assymetry.

> +       if (!bpf_map_hash) {
> +               bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> +               if (IS_ERR(bpf_map_hash))
> +                       return PTR_ERR(bpf_map_hash);
> +       }
> +
> +       old_priv = map_priv(map);
> +       if (old_priv) {
> +               bpf_map_priv__clear(map, old_priv);
> +               return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
> +       }
> +       return hashmap__add(bpf_map_hash, map, priv);
> +}
> +

[...]
