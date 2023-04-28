Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379E46F0FA5
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjD1AdE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 20:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbjD1AdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 20:33:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459ED4213
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:32:25 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef31924c64so862061cf.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641940; x=1685233940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7SoXN2PUda+4VZtO9zdNDaNbKof60538oDksm02k2A=;
        b=XoFeeaLHgnJw1SqNcI8y6fwwktxTsHH6/QXu+ZFdSo3rtYb7DHQ/PXY6UsRVVprP64
         WGFV5roh8t2sVKPewG6l5qafH9vsahfgaK5ytrvDl/KWA0xhDfthKsEMdZ5JpCdGQuPI
         AKDUwmHcUh7/8oU/Y1N4IdhrCA8q4A12GrokxhA7wVwhvYO2yyICRimhyJ2/kMtBnKIx
         j+l3eQ508r1M0QyRWsrTEDfbDKHkHvi8nVEQEMZEVw6YYgdlu1toWuITX7BLRfBLTRlg
         ReQHhcoFigpvDhtZiubFfhYrjFSclcIr7oy3FfyKvMvUxKWsbKen8HpcQ2W33uPeroXB
         OfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641940; x=1685233940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7SoXN2PUda+4VZtO9zdNDaNbKof60538oDksm02k2A=;
        b=QZnimOnX7ASX39/NFVuN2nYW2NbYFkmnnKXQrcL0FxwhjcDni7FEptsejT/Jqy5RuJ
         1tV5oDHj+VobgmbU2mMwg0ECZsfuSv+XAxkLRHUu77Ht0adEZs9OpVHJ2mSVk7J4STSu
         sOS8LzlV/rbMFO2DJNmj+XwQ+hfQzgJGe5bLRyRXOPahxq9ytdvUr+LIziF/7YHlxC6J
         6izIbfEuXwsRLJW3P9h4DmfCUGkgOnAxy6K8Ow/SB80tG7iRne9FbPHkP01abNBHRTXX
         PB8Db0VIXkZiTFQ+J4YRuPYGe4wQb/cmYuLaFeAxfK3lFI5F4Oy76wbNzJfGwM/d32kR
         J1xA==
X-Gm-Message-State: AC+VfDx6pdEEBDwXCNI1QLkL1OLjrQFkzBbGUJgMxQMKzkkdWhfqgaWb
        mS2p3zYfiW4c4nwpg+n3xhrghQl/PecTcDNr11a+YA==
X-Google-Smtp-Source: ACHHUZ5cYiHKp+LGgdtUEQ6E5l34o+N1+2tWbUt6koxsV6HbEpY/OwcjiD9ClUGoQgF0RO37GZYDKqRH224OiFDqpJc=
X-Received: by 2002:ac8:5e0a:0:b0:3de:1aaa:42f5 with SMTP id
 h10-20020ac85e0a000000b003de1aaa42f5mr49378qtx.15.1682641939781; Thu, 27 Apr
 2023 17:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230427234833.1576130-1-namhyung@kernel.org>
In-Reply-To: <20230427234833.1576130-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:32:08 -0700
Message-ID: <CAP-5=fX3pmozMci+hSSV3Nve6H6RUzusPY2_S7HeEtRJnZH7nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf lock contention: Fix struct rq lock access
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 4:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BPF CO-RE's ignore suffix rule requires three underscores.
> Otherwise it'd fail like below:
>
>   $ sudo perf lock contention -ab
>   libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid argu=
ment
>   libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
>   reg type unsupported for arg#0 function collect_lock_syms#380
>   ; int BPF_PROG(collect_lock_syms)
>   0: (b7) r6 =3D 0                        ; R6_w=3D0
>   1: (b7) r7 =3D 0                        ; R7_w=3D0
>   2: (b7) r9 =3D 1                        ; R9_w=3D1
>   3: <invalid CO-RE relocation>
>   failed to resolve CO-RE relocation <byte_off> [381] struct rq__new.__lo=
ck (0:0 @ offset 0)
>
> Fixes: 0c1228486bef ("perf lock contention: Support pre-5.14 kernels")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 8911e2a077d8..30c193078bdb 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -418,11 +418,11 @@ int contention_end(u64 *ctx)
>
>  extern struct rq runqueues __ksym;
>
> -struct rq__old {
> +struct rq___old {
>         raw_spinlock_t lock;
>  } __attribute__((preserve_access_index));
>
> -struct rq__new {
> +struct rq___new {
>         raw_spinlock_t __lock;
>  } __attribute__((preserve_access_index));
>
> @@ -434,8 +434,8 @@ int BPF_PROG(collect_lock_syms)
>
>         for (int i =3D 0; i < MAX_CPUS; i++) {
>                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
> -               struct rq__new *rq_new =3D (void *)rq;
> -               struct rq__old *rq_old =3D (void *)rq;
> +               struct rq___new *rq_new =3D (void *)rq;
> +               struct rq___old *rq_old =3D (void *)rq;
>
>                 if (rq =3D=3D NULL)
>                         break;
> --
> 2.40.1.495.gc816e09b53d-goog
>
