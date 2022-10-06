Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597755F647A
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJFKp1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJFKp0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 06:45:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E1925BE
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 03:45:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2924239wmr.1
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qaAk5/eAqawkJIXoQ25ZN94lDPq5K5ylTqnVPSlNbJE=;
        b=A8vB05TuB9052eeW5LQx9ZKQjhO0Q85P/8OsKh6KyjFP7v+AilsKKeGfayiuKvilBB
         d1ifRGFhFbrmiXixjheJA6PueHVTJUZw76tTCevfBt8al3Vz5OATlnUZAV1tw2rApSIq
         fixjDJd46cfYQ6h4fr+27J4Yo5f+gaI7EXMTyZubNzkWOfXPcj/L2ZT31SLgt75J5PMX
         fXGwL0pv/MAso6VxSTPSkhu6pvZaPH6EJZKXBGTV+vFmbxg4QMc/a5U/hGlol8NdWkwb
         nxAAqQ8nkQuqha4uT/R3F5vvxcsLeag+CNCgdOuB7xsP0t4Kk8Cxe6X15HfF9nYn8/bE
         /pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaAk5/eAqawkJIXoQ25ZN94lDPq5K5ylTqnVPSlNbJE=;
        b=C1rsmULHKXjmFLNWaVXw+XAr0LhUizTxIZiXtfeqEBQ5nDmJHOinq9yPkgF1uOZMJ+
         I8L4g4kDbHAolS7/FvG1i0Ff4czX7lTNMJBsQiMsrVJ/eQ+EWk61ZeL8hMgTqaU6RRWU
         L4cVKKhYy0B7uuSbggSkQ3wXmKW+9inFUqBQ7UwfzBM1RIMzI37de43IjppWKUvuIW2l
         TtdWSRJr88O4S3Ze2LhB6w5TNmNLKbcG6CEdyS/yq4nqzM4mOJZE1ENbXu1gpSs/pkVP
         fGd49Dc3pUDEiwZpEBVVgBTESeodsPrVocWdojJjfl+jm01kqRTveQHZqBqo0yvBnIkN
         5AAg==
X-Gm-Message-State: ACrzQf0Z4E2djutUN4ymjqDGzVNdmuwUxzWoYxcuAyYunvyb8wntarS7
        iFNy1PI580OjiCu+2ZJEul0=
X-Google-Smtp-Source: AMsMyM6sUOEunXI6RvLLaxAaEonP/W85hQ2c6Nqu8CmQuynE/p8ZmmO5qDW0Lhk8R81NlpyeNJsArg==
X-Received: by 2002:a05:600c:34d2:b0:3b4:a617:f3b9 with SMTP id d18-20020a05600c34d200b003b4a617f3b9mr2644847wmq.204.1665053123687;
        Thu, 06 Oct 2022 03:45:23 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i16-20020adff310000000b0022e344a63c7sm12940309wro.92.2022.10.06.03.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:45:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 12:45:21 +0200
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx
 integer values
Message-ID: <Yz6xwcrxsMn5OE69@krava>
References: <20221006042452.2089843-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 09:24:51PM -0700, Andrii Nakryiko wrote:
> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
> 
>   - with over 200 helpers now it's very hard to know what's each helper's ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.
> 
>   - when backporting and cherry-picking only some BPF helpers onto older
>     kernels it's important to be able to skip some enum values for helpers
>     that weren't backported, but preserve absolute integer IDs to keep BPF
>     helper IDs stable so that BPF programs stay portable across upstream
>     and backported kernels.
> 
> While neither problem is insurmountable, they come up frequently enough
> and are annoying enough to warrant improving the situation. And for the
> backporting the problem can easily go unnoticed for a while, especially
> if backport is done with people not very familiar with BPF subsystem overall.
> 
> Anyways, it's easy to fix this by making sure that __BPF_FUNC_MAPPER
> macro provides explicit helper IDs. Unfortunately that would potentially
> break existing users that use UAPI-exposed __BPF_FUNC_MAPPER and are
> expected to pass macro that accepts only symbolic helper identifier
> (e.g., map_lookup_elem for bpf_map_lookup_elem() helper).
> 
> As such, we need to introduce a new macro (___BPF_FUNC_MAPPER) which
> would specify both identifier and integer ID, but in such a way as to
> allow existing __BPF_FUNC_MAPPER be expressed in terms of new
> ___BPF_FUNC_MAPPER macro. And that's what this patch is doing. To avoid
> duplication and allow __BPF_FUNC_MAPPER stay *exactly* the same,
> ___BPF_FUNC_MAPPER accepts arbitrary "context" arguments, which can be
> used to pass any extra macros, arguments, and whatnot. In our case we
> use this to pass original user-provided macro that expects single
> argument and __BPF_FUNC_MAPPER is using it's own three-argument
> __BPF_FUNC_MAPPER_APPLY intermediate macro to impedance-match new and
> old "callback" macros.
> 
> Once we resolve this, we use new ___BPF_FUNC_MAPPER to define enum
> bpf_func_id with explicit values. The other users of __BPF_FUNC_MAPPER
> in kernel (namely in kernel/bpf/disasm.c) are kept exactly the same both
> as demonstration that backwards compat works, but also to avoid
> unnecessary code churn.
> 
> Note that new ___BPF_FUNC_MAPPER() doesn't forcefully insert comma
> between values, as that might not be appropriate in all possible cases
> where ___BPF_FUNC_MAPPER might be used by users. This doesn't reduce
> usability, as it's trivial to insert that comma inside "callback" macro.
> 
> To validate all the manually specified IDs are exactly right, we used
> BTF to compare before and after values:
> 
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > after.txt
>   $ git stash # stach UAPI changes
>   $ make -j90
>   ... re-building kernel without UAPI changes ...
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > before.txt
>   $ diff -u before.txt after.txt
>   --- before.txt  2022-10-05 10:48:18.119195916 -0700
>   +++ after.txt   2022-10-05 10:46:49.446615025 -0700
>   @@ -1,4 +1,4 @@
>   -[14576] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>   +[9560] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>           'BPF_FUNC_unspec' val=0
>           'BPF_FUNC_map_lookup_elem' val=1
>           'BPF_FUNC_map_update_elem' val=2
> 
> As can be seen from diff above, the only thing that changed was resulting BTF
> type ID of ENUM bpf_func_id, not any of the enumerators, their names or integer
> values.
> 
> The only other place that needed fixing was scripts/bpf_doc.py used to generate
> man pages and bpf_helper_defs.h header for libbpf and selftests. That script is
> tightly-coupled to exact shape of ___BPF_FUNC_MAPPER macro definition, so had
> to be trivially adapted.
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Reported-by: Andrea Terzolo <andrea.terzolo@polito.it>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka
