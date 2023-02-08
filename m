Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81968F1C4
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBHPQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 10:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBHPQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 10:16:00 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E13755F;
        Wed,  8 Feb 2023 07:15:54 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id g8so20992427qtq.13;
        Wed, 08 Feb 2023 07:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcJLQCCe3yJED6vbPd8upyFSXYvLwaouZO6wzGHTQ9I=;
        b=PzotW+x+/qKJqcAwk0B5rNj3qTenCHcU22LTAWmAlYDinnKCnCQW4NRi2mmkzPSu1s
         VSJyazMmRkz37FxCFTgP7O953mkZ5LoV2CjVxaU4Y66Euy0DhHX1lg8ywGPO79PC4M77
         o8ryPqT07Gt7iZrFDOEGXiTs7V76wsLGqzvBrZTBBIaFcTTf5enOljNTRHg6JQL8QWNl
         LuBH981CG/nvVuvHHevejPd2Am5+dUwJI5rrRZ36ImfGbiFh+7+WmLOzaGfGDvfwWbzy
         xP2Kzk+l7ZLSfFhC7A8esX7QmHaVzriscunTjnFM54r6vGyLDDN0d/QrZ93/9jKxdyGE
         fm1Q==
X-Gm-Message-State: AO0yUKWt8d8IbhqykHC+2DR62fqybLcUjcXAdxT6rlYYpaBxoMKXlPjX
        dKLPdAwKUhW0QV5+tOlngN4=
X-Google-Smtp-Source: AK7set8KmrFfGjjd0rstfTtiq1xaqf7c/sLY8AKiSUZFeqohqafEmiDQ2rk2BPuusx5AHjljx/wSJg==
X-Received: by 2002:ac8:5f4e:0:b0:3b0:b9a4:a20f with SMTP id y14-20020ac85f4e000000b003b0b9a4a20fmr14386596qta.4.1675869352973;
        Wed, 08 Feb 2023 07:15:52 -0800 (PST)
Received: from maniforge.lan ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bj5-20020a05620a190500b00733ab1b8045sm6061264qkb.106.2023.02.08.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:15:52 -0800 (PST)
Date:   Wed, 8 Feb 2023 09:15:56 -0600
From:   David Vernet <void@manifault.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Update design QA to be consistent
 with kfunc lifecycle docs
Message-ID: <Y+O8rJ3TGwl6FnVK@maniforge.lan>
References: <20230208135731.268638-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208135731.268638-1-toke@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:30PM +0100, Toke Høiland-Jørgensen wrote:
> Cong pointed out that there are some inconsistencies between the BPF design
> QA and the lifecycle expectations documentation we added for kfuncs. Let's
> update the QA file to be consistent with the kfunc docs, and add references
> where it makes sense. Also document that modules may export kfuncs now.
> 
> v2:
> - Fix repeated word (s/defined defined/defined/)
> 
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks for fixing this. LGTM modulo one small grammar nit.

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/bpf_design_QA.rst | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index cec2371173d7..4d3135187e0c 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -208,6 +208,10 @@ data structures and compile with kernel internal headers. Both of these
>  kernel internals are subject to change and can break with newer kernels
>  such that the program needs to be adapted accordingly.
>  
> +New BPF functionality is generally added through the use of kfuncs instead of
> +new helpers. Kfuncs are not considered part of the stable API, but has their own

s/but has/and have

> +lifecycle expectations as described in :ref:`BPF_kfunc_lifecycle_expectations`.
> +
>  Q: Are tracepoints part of the stable ABI?
>  ------------------------------------------
>  A: NO. Tracepoints are tied to internal implementation details hence they are
> @@ -236,8 +240,8 @@ A: NO. Classic BPF programs are converted into extend BPF instructions.
>  
>  Q: Can BPF call arbitrary kernel functions?
>  -------------------------------------------
> -A: NO. BPF programs can only call a set of helper functions which
> -is defined for every program type.
> +A: NO. BPF programs can only call specific functions exposed as BPF helpers or
> +kfuncs. The set of available functions is defined for every program type.
>  
>  Q: Can BPF overwrite arbitrary kernel memory?
>  ---------------------------------------------
> @@ -263,7 +267,12 @@ Q: New functionality via kernel modules?
>  Q: Can BPF functionality such as new program or map types, new
>  helpers, etc be added out of kernel module code?
>  
> -A: NO.
> +A: Yes, through kfuncs and kptrs
> +
> +The core BPF functionality such as program types, maps and helpers cannot be
> +added to by modules. However, modules can expose functionality to BPF programs
> +by exporting kfuncs (which may return pointers to module-internal data
> +structures as kptrs).
>  
>  Q: Directly calling kernel function is an ABI?
>  ----------------------------------------------
> @@ -278,7 +287,8 @@ kernel functions have already been used by other kernel tcp
>  cc (congestion-control) implementations.  If any of these kernel
>  functions has changed, both the in-tree and out-of-tree kernel tcp cc
>  implementations have to be changed.  The same goes for the bpf
> -programs and they have to be adjusted accordingly.
> +programs and they have to be adjusted accordingly. See
> +:ref:`BPF_kfunc_lifecycle_expectations` for details.
>  
>  Q: Attaching to arbitrary kernel functions is an ABI?
>  -----------------------------------------------------
> @@ -340,6 +350,7 @@ compatibility for these features?
>  
>  A: NO.
>  
> -Unlike map value types, there are no stability guarantees for this case. The
> -whole API to work with allocated objects and any support for special fields
> -inside them is unstable (since it is exposed through kfuncs).
> +Unlike map value types, the API to work with allocated objects and any support
> +for special fields inside them is exposed through kfuncs, and thus has the same
> +lifecycle expectations as the kfuncs themselves. See
> +:ref:`BPF_kfunc_lifecycle_expectations` for details.
> -- 
> 2.39.1
> 
