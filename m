Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6E4E38A7
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 07:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiCVGAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiCVGAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 02:00:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D2A180
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 22:58:38 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b7so11768336ilm.12
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmfYTrIYda2Vg9s0Kt3PP002QA49jxP4tpqQTaTFoeI=;
        b=ZLjoq8va5qBSsaRoWcvACdFLyo6PvfewtlPuN/nLPVU9efRKvvUX3fBbIhTGvVBpVU
         1rXGrikhMYF8pa95aesncp3IYwMEqaLS4nzVSrbbloPQQgLyZWYHCPVTDRmiYTaGfCtO
         mR+OSbbbJ0EzHru1TmHJH3Iv7mta9aYkxy7u9FkiD0UfVZBOvJo3lkfn7b9OQay0RqNx
         3v2H/EjeL94f03bGxSkpb6CxTkH9zsfVEM5bSRKE6ErukkhNqPjya0TbGQEHcppXKZiq
         FFSXgCz4KgEcXv/LhDdDQfajTo4kSwPgcSy7Qhb6TiCsZKp0AiH0Nu8nbgC6LbmMQ/CE
         W5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmfYTrIYda2Vg9s0Kt3PP002QA49jxP4tpqQTaTFoeI=;
        b=d0kvAwBo3eWqQs5YxpJCCykwC4vQ9vd8RkN3Gb/ppveGv07Dk6pqCBY9vnR7V91oyd
         qxbdxSUD7Df4c1QlSrwAS+6vQWBM43fazzmrEfhmtC6RPkxMCli7V+8Ys2oNP1PLM5Aw
         ORahWrm87Lt5vfKc92V6WiTEHCZa7gVTR1w8am/tiKmFXRf/cF4kmDwBU353wlRXWvLT
         XzzdFN5LN8MQeW+xNaa+VCahc99BSiqK5u+ovIxOn9elzWFAmBz9ICOU8MFBxgvX6q+3
         bDTOxdYl9MrnwBJ5n4zSa10yFsIGyooGFoaafws3bE4zjtOxy7qpUwdzxL1IGqETr2t8
         m7og==
X-Gm-Message-State: AOAM530GRd2b3Sqit4gEsp6VUDhfVtTY6qPOjTQCRZyFfq+3bxsC29mA
        VMC+V6ZfWkVbcjHhiiY9IU3Au0n2kt4ccMQUm+D8hljD
X-Google-Smtp-Source: ABdhPJwg3h2qXhXMVpTRkMW60lB5Rd/7w7LbJSYtgbGjIUaa5uXrme6H3Fobl7KHzixqaF/gbWWKfBtCXeeeysZSo0s=
X-Received: by 2002:a05:6e02:1a82:b0:2c8:1ce0:6f64 with SMTP id
 k2-20020a056e021a8200b002c81ce06f64mr5275143ilv.239.1647928717691; Mon, 21
 Mar 2022 22:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-7-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-7-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 22:58:26 -0700
Message-ID: <CAEf4BzbMKspdkz2N39+uO-pqQjBRXHGP5+Y6WfNAnUksPpos4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/13] bpf: Prevent escaping of kptr loaded
 from maps
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> While we can guarantee that even for unreferenced kptr, the object
> pointer points to being freed etc. can be handled by the verifier's
> exception handling (normal load patching to PROBE_MEM loads), we still
> cannot allow the user to pass these pointers to BPF helpers and kfunc,
> because the same exception handling won't be done for accesses inside
> the kernel. The same is true if a referenced pointer is loaded using
> normal load instruction. Since the reference is not guaranteed to be
> held while the pointer is used, it must be marked as untrusted.
>
> Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
> all registers loading unreferenced and referenced kptr from BPF maps,
> and ensure they can never escape the BPF program and into the kernel by
> way of calling stable/unstable helpers.
>
> In check_ptr_to_btf_access, the !type_may_be_null check to reject type
> flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
> MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
> two are checked inside the function and rejected using a proper error
> message, but we still want to allow dereference of untrusted case.
>
> Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
> walked, so that this flag is never dropped once it has been set on a
> PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
> direction).
>
> In convert_ctx_accesses, extend the switch case to consider untrusted
> PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
> conversion for BPF_LDX.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   | 10 +++++++++-
>  kernel/bpf/verifier.c | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 8 deletions(-)
>

[...]

> -       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> -               goto bad_type;
> +       if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
> +               if (reg->type != PTR_TO_BTF_ID &&
> +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL))
> +                       goto bad_type;
> +       } else { /* only unreferenced case accepts untrusted pointers */
> +               if (reg->type != PTR_TO_BTF_ID &&
> +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL) &&
> +                   reg->type != (PTR_TO_BTF_ID | PTR_UNTRUSTED) &&
> +                   reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_UNTRUSTED))

use base_type(), Luke! ;)

> +                       goto bad_type;
> +       }
>
>         if (!btf_is_kernel(reg->btf)) {
>                 verbose(env, "R%d must point to kernel BTF\n", regno);

[...]
