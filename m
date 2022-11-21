Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB240631886
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 03:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKUCKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 21:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKUCKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 21:10:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044D13F8C
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 18:10:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso806946pjq.5
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 18:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XTl8qKqAL0gVpF00nlbM37+9N/9YVE12xzP+d24o9c=;
        b=eB5NduyjQeePSyRxtl9VYswyRXls9VWohYX5cJgtirGkMoLBSWEAak++79CxPpRRn2
         B6F5D9Jc+aaK+aTS93qt4I43tGlnEhVXzxT2cBUyUHiuPKAA97m/ReqHanJFluHGzhxn
         LIIyE+scEdepE+vIPcZr2d/bJ7QDXOM115EqZPKPX6JM2AwSYJXjX3KSG3ZfagAXopm0
         EG4MdHds//+5rmnMZQ2mJCFJ5KgxrSZVi/5BF15RcfP9IH3KXjAEDI1whNGEzlDzDG/i
         JuTo7u5bKiUvJCPbSS+E8cqHBci0V5m9XeXaG8tZfRkI9PVTZn7hd3tspBH1RetsS4C3
         h4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5XTl8qKqAL0gVpF00nlbM37+9N/9YVE12xzP+d24o9c=;
        b=yej3fYdc5AOvLdIH4rATfcrMje7HLdLe9azp7zwn+B4OqXOIWbPvfX853MIa6JLMx/
         BJ4gWoXfJfwJp+B/F1kRfjjQYZsTy1Xc7/+2TsFkXM//pjTtm+4aWYGOg3pD8iI8NcUW
         HHPZd7kkSk2l1ECwXd+VslbJwgvdnSO9TVk1QP6mMuR5d6AIR4BQwfsef6ed+uhrVZ21
         X2Ao+BhawR3ENcIxUAir/mxRO8UjqP5cUrGuzXNzzxfd05gqDCieHkmjlRBpnT9Mu0gF
         Pq4HKcByuNh8wgRQO1zFJRsZJrU980ER6wrk7DrSl6Jtvtqr8KGSt9Z4hXOhu/yXGdLD
         6OSg==
X-Gm-Message-State: ANoB5plMY2Qx7zOsGk4t++DKzIJG2OYq10OijnUb0MCGzQ9sQ+5ut0qY
        JqBaoSVjdmX7QRC2v0jZAiVrYJyynYU=
X-Google-Smtp-Source: AA0mqf7us+YdHZZL5K8zo6Hl50JpGbAFdTHlsHVIHEiS2F7g7WqL487+WHcWRKku7nM40ocaQVaiQQ==
X-Received: by 2002:a17:90b:4a48:b0:213:a9e6:dadf with SMTP id lb8-20020a17090b4a4800b00213a9e6dadfmr18252520pjb.108.1668996651030;
        Sun, 20 Nov 2022 18:10:51 -0800 (PST)
Received: from localhost ([2605:59c8:6f:2810:c718:d1c3:f0ca:73e])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b0056c0d129edfsm7313440pfq.121.2022.11.20.18.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 18:10:50 -0800 (PST)
Date:   Sun, 20 Nov 2022 18:10:48 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <637ade2851bc6_99c62086@john.notmuch>
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
References: <20221120195421.3112414-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Currenty, a non-tracing bpf program typically has a single 'context' argument
> with predefined uapi struct type. Following these uapi struct, user is able
> to access other fields defined in uapi header. Inside the kernel, the
> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
> in short) which can access more information than what uapi header provides.
> To access other info not in uapi header, people typically do two things:
>   (1). extend uapi to access more fields rooted from 'context'.
>   (2). use bpf_probe_read_kernl() helper to read particular field based on
>     kctx.
> Using (1) needs uapi change and using (2) makes code more complex since
> direct memory access is not allowed.
> 
> There are already a few instances trying to access more information from
> kctx:
>   . trying to access some fields from perf_event kctx ([1]).
>   . trying to access some fields from xdp kctx ([2]).
> 
> This patch set tried to allow direct memory access for kctx fields
> by introducing bpf_cast_to_kern_ctx() kfunc.
> 
> Martin mentioned a use case like type casting below:
>   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
> basically a 'unsigned char *" casted to 'struct skb_shared_info *'. This patch
> set tries to support such a use case as well with bpf_rdonly_cast().
> 
> For the patch series, Patch 1 added support for a kfunc available to all
> prog types. Patch 2 added bpf_cast_to_kern_ctx() kfunc. Patch 3 added
> bpf_rdonly_cast() kfunc. Patch 4 added a few positive and negative tests.
> 
>   [1] https://lore.kernel.org/bpf/ad15b398-9069-4a0e-48cb-4bb651ec3088@meta.com/
>   [2] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@gmail.com/
> 
> Changelog:
>   v3 -> v4:
>     - remove unnecessary bpf_ctx_convert.t error checking
>     - add and use meta.ret_btf_id instead of meta.arg_constant.value for
>       bpf_cast_to_kern_ctx().
>     - add PTR_TRUSTED to the return PTR_TO_BTF_ID type for bpf_cast_to_kern_ctx().
>   v2 -> v3:
>     - rebase on top of bpf-next (for merging conflicts)
>     - add the selftest to s390x deny list
>   rfcv1 -> v2:
>     - break original one kfunc into two.
>     - add missing error checks and error logs.
>     - adapt to the new conventions in
>       https://lore.kernel.org/all/20221118015614.2013203-1-memxor@gmail.com/
>       for example, with __ign and __k suffix.
>     - added support in fixup_kfunc_call() to replace kfunc calls with a single mov.
> 
> Yonghong Song (4):
>   bpf: Add support for kfunc set with common btf_ids
>   bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
>   bpf: Add a kfunc for generic type cast
>   bpf: Add type cast unit tests

Thanks Yonghong! Ack for the series for me, but looks like Alexei is
quick.

From myside this allows us to pull in the dev info and from that get
netns so fixes a gap we had to split into a kprobe + xdp.

If we can get a pointer to the recv queue then with a few reads we
get the hash, vlan, etc. (see timestapm thread)

And then last bit is if we can get a ptr to the net ns list, plus
the rcu patch we can build the net ns iterator directly in BPF
which seems stronger than an iterator IMO because we can kick it
off on events anywhere in the kernel. Or based on event kick of
some specific iterator e.g. walk net_devs in netns X with SR-IOV
interfaces). Ideally we would also wire it up to timers so we
can call it every N seconds without any user space intervention.
Eventually, its nice if the user space can crash, restart, and
so on without impacting the logic in kernel.

Thanks again.
