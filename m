Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0195455D745
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiF1JwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbiF1JwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 05:52:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C92D1EA;
        Tue, 28 Jun 2022 02:51:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v9so1250798wrp.7;
        Tue, 28 Jun 2022 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xP6bEJNNszePrAel0wOJ+O8HtTQlu0JudOpo4V27qFg=;
        b=ebpZPwgEjSzA/JYde3JwoNq1T7Vy4zNHa8d6n0r2EQd8meePM4d1Ql2ELQsUSaK3Kv
         o49kptvKj32fyo3HwEg9J/8Mk5iyJv/KY7VzGAvgJfR5s/Z3v2x027Az8U/YXMZcNoYJ
         r1esYkiCd7b9id90AZNQ7N1Mva7LxdA4uKtqB/JnMCpUmm1beBLtJXaOZaU0+yCEZ6sV
         525/RgQwftp3WpG0RbACP4K0egjKviQ1pVErDTQnyplMR7ArLpaAt9HSuKzvYI9NerU7
         PnOyD7ZekpX7dOxy84LVO6XPTRjfILTJrs17WgLaqE5hyItGVfoHQqjNQJRZMo0Cnpgn
         8Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xP6bEJNNszePrAel0wOJ+O8HtTQlu0JudOpo4V27qFg=;
        b=NKrSG0vHRz3Zx03coF4fuwXww63fwXrtzW3hND8N9TP/I+lP5GWcIEN4+xowJOONTT
         P6Tfd8Q6/00wPa5nRZfsX7L9d+OosqYiRE9CP2HkYwCTcyrABnoGMiTVxqY3bLDPR24u
         We+kbqXQtErI7M8Kzo0l7rekwSYztNeiRA4sIqKvcPE97R277w4W73NUNUrNBtZdp5DG
         v90g/4USr4HzndVOt+KkG/b/EB9JQrcZwkz3K4g7QGTw8RSnwTApjHibbLPEB7w2H1QO
         zvdLgOQJf9+JZVnxDbK4xFjdsY2KLzqhj2+uBWG7sy4EgsxHqT55FBY+iOPBICE+edmm
         tw2g==
X-Gm-Message-State: AJIora9MMR4UNeUBl0xeoqGkOnJiiHUuZtg9rAgLeLntwqQIrS35FYzO
        7W0tQ4XHSe1v1aNqMVH9JF8=
X-Google-Smtp-Source: AGRyM1tA8aDg/cOtRD/6R80NqWhtfksixikeKjJ3JzKrM/MoF5gVU+lYTqBmkYyneIAmqEhf3SxfyQ==
X-Received: by 2002:a5d:59a6:0:b0:21b:a234:8314 with SMTP id p6-20020a5d59a6000000b0021ba2348314mr16498849wrr.316.1656409916821;
        Tue, 28 Jun 2022 02:51:56 -0700 (PDT)
Received: from krava (net-109-116-206-47.cust.vodafonedsl.it. [109.116.206.47])
        by smtp.gmail.com with ESMTPSA id t10-20020adfe10a000000b00210320d9fbfsm15678199wrz.18.2022.06.28.02.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:51:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 28 Jun 2022 11:51:52 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YrrPOFzYAGHm0oht@krava>
References: <20220615230306.851750-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615230306.851750-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 15, 2022 at 04:03:06PM -0700, Yonghong Song wrote:
> Add support for enum64. For 64-bit enumerator value,
> previously, the value is truncated into 32bit, e.g.,
> for the following enum in linux uapi bpf.h,
>   enum {
>         BPF_F_INDEX_MASK                = 0xffffffffULL,
>         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>   /* BPF_FUNC_perf_event_output for sk_buff input context. */
>         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>   };
> 
> BPF_F_CTXLEN_MASK will be encoded with 0 with BTF_KIND_ENUM
> after pahole dwarf-to-btf conversion.
> With this patch, the BPF_F_CTXLEN_MASK will be encoded properly
> with BTF_KIND_ENUM64.

yep, tried this on latest vmlinux and got:

[705813] ENUM64 (anon) size=8
        BPF_F_INDEX_MASK val=4294967295
        BPF_F_CURRENT_CPU val=4294967295
        BPF_F_CTXLEN_MASK val=4503595332403200

which is correct

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> This patch is on top of tmp.master since tmp.master has not
> been sync'ed with master branch yet.
> 
> Changelogs:
>   v1 -> v2:
>     - Add flag --skip_encoding_btf_enum64 to disable newly-added functionality.
> 
> Yonghong Song (2):
>   libbpf: Sync with latest libbpf repo
>   btf: Support BTF_KIND_ENUM64
> 
>  btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
>  btf_encoder.h     |  2 +-
>  dwarf_loader.c    | 12 +++++++++
>  dwarves.h         |  4 ++-
>  dwarves_fprintf.c |  6 ++++-
>  lib/bpf           |  2 +-
>  pahole.c          | 10 +++++++-
>  7 files changed, 80 insertions(+), 21 deletions(-)
> 
> -- 
> 2.30.2
> 
