Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9931493231
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 02:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiASBPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 20:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 20:15:49 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EBC061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 17:15:49 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id b1so830601ilj.2
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2etAGx0Ji6rss9DCS/dBqVeifZ9d6iHa87JNkucOpQY=;
        b=dIW+ahGBQRHcFXgLoZwYtWTmxj99GkfDkRkqNE0v/VBndOA05pUXGym4UbxU7kaWfN
         k0VCUmWKt+yjLy0H9FjF9nRZcaGkumzb/QfUIOFxHXT5foB5uCOFbae9KuGq8bWl1/15
         wZbMugzX33/gL+LB1z35qqnfLnThtPKrHzU1Ss16UnagtZkvuLhdvOTds6YwUfdNDeMr
         +lFFnvlS/3miLyaP7NGVGUBKSoX8n0GitXllBNzpbD++QYCbC9w339DS/cJ5I+wIJDBJ
         uQ4LJdmrTUH6pmOgacijoKBCe6DjRn+5v8sCyz/nooMKNoVqNSLu4ZY4GRoyLs++uhS5
         P/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2etAGx0Ji6rss9DCS/dBqVeifZ9d6iHa87JNkucOpQY=;
        b=G14Zw+kTrv4xdujMiwgL8Pa2nLJJ4oaqM0Beq9uWksfyU6hzOasMMbrM+dL/l+Hwt5
         VvfHOXecLU8ybFHJxiFxGlkPfbC0COfk+BoDD45UXhszpqlBY/AfzFMS2ql01sJX3VSO
         W5bqpbRsv/RUOXZ6BqaLcHVFVRK279OmvMyMOtP+6x7VQQLcz5X8TRFMjgM8ZJzEWHoy
         yE7VD7nJ0FWktIkRnm+QTbD4u+F6cYZGdt+5ofqfg2WfE/6eJO5f5zyz4e1erVQFlEQQ
         Qau+gU15+FF1Z3ALG9pdLh6yn4mIIRagszE4pWU15ZlcKJ1cY1qkZ2NCLYVJF+vV2VKp
         RDYA==
X-Gm-Message-State: AOAM53081H4rvD3xRrwdtFXha0iOlKZfTy+avr/oBZhIjLUaPPbMzIE9
        1p9pxgtKJZO6GExFu9KxdO+0PAESwo92FrCuAFHhHhu/
X-Google-Smtp-Source: ABdhPJzc2oSisFgNhkXMzni4NlEZu5MFeVlBTk7kNyixo1yuF4dZwc5yX5ToNlUvwSkcnGTo/NISyMIjAfEsZ31UNaA=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr15772494ilh.239.1642554948419;
 Tue, 18 Jan 2022 17:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20220118232053.2113139-1-kuifeng@fb.com> <20220118232053.2113139-2-kuifeng@fb.com>
In-Reply-To: <20220118232053.2113139-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Jan 2022 17:15:37 -0800
Message-ID: <CAEf4BzZi5G41-kpfcLf=Z5O_C1ELQnvw=4X9Kaxcq97uH8=Mjw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: Improve btf__add_btf() with an
 additional hashmap for strings.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 3:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
> V3 removes an unnecssary check against str_off_map, and merges the
> declarations of two variables into one line.
>
> [v2] https://lore.kernel.org/bpf/20220114193713.461349-1-kuifeng@fb.com/
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/lib/bpf/btf.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>

[...]

> @@ -1680,6 +1697,9 @@ static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
>         return 0;
>  }
>
> +static size_t btf_dedup_identity_hash_fn(const void *key, void *ctx);
> +static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx);
> +
>  int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  {
>         struct btf_pipe p = { .src = src_btf, .dst = btf };
> @@ -1713,6 +1733,11 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>         if (!off)
>                 return libbpf_err(-ENOMEM);
>
> +       /* Map the string offsets from src_btf to the offsets from btf to improve performance */
> +       p.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
> +       if (p.str_off_map == NULL)

Sorry, I didn't catch this the first time. hashmap__new() returns
ERR_PTR() on error (it's an internal API so we use ERR_PTR() for
pointer-returning APIs), so you need to check for
IS_ERR(p.str_off_map) instead.

> +               return libbpf_err(-ENOMEM);
> +
>         /* bulk copy types data for all types from src_btf */
>         memcpy(t, src_btf->types_data, data_sz);
>
> @@ -1754,6 +1779,8 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>         btf->hdr->str_off += data_sz;
>         btf->nr_types += cnt;
>
> +       hashmap__free(p.str_off_map);
> +
>         /* return type ID of the first added BTF type */
>         return btf->start_id + btf->nr_types - cnt;
>  err_out:
> @@ -1767,6 +1794,8 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>          * wasn't modified, so doesn't need restoring, see big comment above */
>         btf->hdr->str_len = old_strs_len;
>
> +       hashmap__free(p.str_off_map);
> +
>         return libbpf_err(err);
>  }
>
> --
> 2.30.2
>
