Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1148F0B1
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 20:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiANTzv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 14:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANTzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 14:55:50 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA506C061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 11:55:50 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f24so7782898ioc.0
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 11:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROeJSARPxZKxiDsg+jM8W2dbr106C9bJ4TF+eYFWRcA=;
        b=bwiiPIUZhgMw30aHLSqA+fPsAZ0qTY1I1cEr2Kh0H4oYVbbaaT81Xr8zOTf9ylcKoE
         oVzSCIlzFdobpvOQc116M6ZMfp7Rn9TnOoKDEG47I/blOsOLiTgOqgiubRJM40PGc3k2
         9P2q1OX69K8F36Wextz6z2/Qhp44u0tkzjW9njDLsYvk3xwx3TUv+romnAeh4JVfNmBG
         hFXYX20X4Bv0pH/VlAU4NshqAaUO3cEVkMAF72C12qSaqtbm9J7g6w5EGM33cpIaNoWV
         02IWDFxHgC0Ddglt4i9PTQlCAUtV76sCwvgZ7tdnEpH8j2kaMBq6fw1DCR/aopDWThQy
         M9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROeJSARPxZKxiDsg+jM8W2dbr106C9bJ4TF+eYFWRcA=;
        b=W511vFkMzK05+oanT1R7I+dfy/NMVFXy2UGrIjv1xpM4mfHdklJh67t0KaBZz0Lk3j
         W2aVmZ8sl0Hz1obZRsB9fz76gRJnyvhciV1UgYMqgFPLysy7Jha72QWr65sp1QIEPBkP
         zcgK9tO4dSNxweZDEoc1fzavYvPpo9o0WDE5sls/c0H80hvkEsQGvWOcAZnywJko9/36
         mpXWRSbFbAEIInEU6H9u0eh4pvQW0b7RpsLppFpIqhMHUc65pQtbS+eQBY1LSEWLXFJI
         vzzyABkuxKAG1emc9eMbzpFj+KfCDARJ9DoglIYgYaaHHXluUy0excQwKINOpspW4fki
         HksA==
X-Gm-Message-State: AOAM5304UNXCnv+rt13jmVH0Wbh6G0k6U9S0LVqKqsofS5yguUtBNaw3
        PKrA1Bu4hUgyn/+zxOwk8mxgwit6EDsDjbOJ8mw=
X-Google-Smtp-Source: ABdhPJza4PUo9hYo0f/IPbJc2vzbtKbOhe7WHp9e+dWaqjnFQzL2MLqLjZegqHgCw0a5/Qb6LuRFSsapO4maELHzGNw=
X-Received: by 2002:a05:6638:410a:: with SMTP id ay10mr5071821jab.237.1642190149906;
 Fri, 14 Jan 2022 11:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20220114193713.461349-1-kuifeng@fb.com>
In-Reply-To: <20220114193713.461349-1-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 11:55:38 -0800
Message-ID: <CAEf4BzZuGYQNqc3eZHF3TTCCNvDf_02UWO5558YxjJ1hJMwAKQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve btf__add_btf() with an
 additional hashmap for strings.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 11:38 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> V2 fixes a crash issue of using an uninitialized hashmap.

generally version history is kept at the bottom of commit (or cover
letter for patch set)

>
> Add a hashmap to map the string offsets from a source btf to the
> string offsets from a target btf to reduce overheads.
>
> btf__add_btf() calls btf__add_str() to add strings from a source to a
> target btf.  It causes many string comparisons, and it is a major
> hotspot when adding a big btf.  btf__add_str() uses strcmp() to check
> if a hash entry is the right one.  The extra hashmap here compares
> offsets of strings, that are much cheaper.  It remembers the results
> of btf__add_str() for later uses to reduce the cost.
>
> We are parallelizing BTF encoding for pahole by creating separated btf
> instances for worker threads.  These per-thread btf instances will be
> added to the btf instance of the main thread by calling btf__add_str()
> to deduplicate and write out.  With this patch and -j4, the running
> time of pahole drops to about 6.0s from 6.6s.
>
> The following lines are the summary of 'perf stat' w/o the change.
>
>        6.668126396 seconds time elapsed
>
>       13.451054000 seconds user
>        0.715520000 seconds sys
>
> The following lines are the summary w/ the change.
>
>        5.986973919 seconds time elapsed
>
>       12.939903000 seconds user
>        0.724152000 seconds sys
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Looks good, nice 10% improvement for a pretty simple change. Please
fix a few nits and it should be good (if CI is green).

>  tools/lib/bpf/btf.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9aa19c89f758..8b96418000cc 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1620,20 +1620,38 @@ static int btf_commit_type(struct btf *btf, int data_sz)
>  struct btf_pipe {
>         const struct btf *src;
>         struct btf *dst;
> +       struct hashmap *str_off_map; /* map string offsets from src to dst */
>  };
>
>  static int btf_rewrite_str(__u32 *str_off, void *ctx)
>  {
>         struct btf_pipe *p = ctx;
> +       void *mapped_off;
>         int off;
> +       int err;

nit: generally we combine such simple variables in one line:

  int off, err;

no big deal, but just FYI

>
>         if (!*str_off) /* nothing to do for empty strings */
>                 return 0;
>
> +       if (p->str_off_map &&
> +           hashmap__find(p->str_off_map, (void *)(long)*str_off, &mapped_off)) {

offtopic, I regret the decision to use `void *` as the type for
key/value in hashmap. I think `long` would be better overall. If you
get a chance, maybe you can help convert this in a separate patch set
(I think perf might have copy/pasted hashmap so we'd need to update
there too).

> +               *str_off = (__u32)(long)mapped_off;
> +               return 0;
> +       }
> +
>         off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
>         if (off < 0)
>                 return off;
>
> +       /* Remember string mapping from src to dst.  It avoids
> +        * performing expensive string comparisons.
> +        */
> +       if (p->str_off_map) {
> +               err = hashmap__append(p->str_off_map, (void *)(long)*str_off, (void *)(long)off);
> +               if (err)
> +                       return err;
> +       }
> +
>         *str_off = off;
>         return 0;
>  }
> @@ -1680,6 +1698,9 @@ static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
>         return 0;
>  }
>
> +static size_t btf_dedup_identity_hash_fn(const void *key, void *ctx);
> +static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx);
> +
>  int j(struct btf *btf, const struct btf *src_btf)
>  {
>         struct btf_pipe p = { .src = src_btf, .dst = btf };
> @@ -1713,6 +1734,11 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>         if (!off)
>                 return libbpf_err(-ENOMEM);
>
> +       /* Map the string offsets from src_btf to the offsets from btf to improve performance */
> +       p.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
> +       if (p.str_off_map == NULL)
> +               return libbpf_err(-ENOMEM);
> +
>         /* bulk copy types data for all types from src_btf */
>         memcpy(t, src_btf->types_data, data_sz);
>
> @@ -1754,6 +1780,8 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>         btf->hdr->str_off += data_sz;
>         btf->nr_types += cnt;
>
> +       hashmap__free(p.str_off_map);
> +
>         /* return type ID of the first added BTF type */
>         return btf->start_id + btf->nr_types - cnt;
>  err_out:
> @@ -1767,6 +1795,9 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>          * wasn't modified, so doesn't need restoring, see big comment above */
>         btf->hdr->str_len = old_strs_len;
>
> +       if (p.str_off_map)
> +               hashmap__free(p.str_off_map);

you are guaranteed to have non-NULL p.str_off_map, so drop the check.
But even if not, hashmap__free() handles NULL perfectly fine by
design.

> +
>         return libbpf_err(err);
>  }
>
> --
> 2.30.2
>
