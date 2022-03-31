Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E984EE273
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiCaUPk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 16:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCaUPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 16:15:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DA19320A
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 13:13:51 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e22so802810ioe.11
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VE4GngeW771I1DFtBN/VgkJzTkRAMjXiHwVZSBj3NC0=;
        b=LbP665W2/KQLyXKsUKHTagJan0fMMl7R2tHJcZ8rRafWRnsK5XNN+5dwoKEIqWCpST
         QehkfugzjdS2HimcvDAlyRxW0nX+UZsc+oD0xiv5S8EXVzNakZM1HbDIHtg2zhfGfjxQ
         aHyV3VZ1vL91+2HxV65BFX1n2YYMXrYEzdLiz782ONPbNtBBAmxerdUTvTacvvH8MSqf
         uC4VNEFD7AcrJFoF5UpnWHDOLRLzvPyX5BmKMT1Q5IhK4xqSuuffWgT3pL+PYvPK1rfu
         CHRF+0QPKYtMEkCtX9IY2+wVZ47uaUkeHfwk735zmFZdTxzw+inH3bANKjcnP7yNYLtI
         n5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VE4GngeW771I1DFtBN/VgkJzTkRAMjXiHwVZSBj3NC0=;
        b=zwWvfZUBEqY6p8to2DsuB5bqjjAJqaKKxwvzfD3CE9q2fqWWM2WzWonEYy14j/wVCd
         wi4PP0ywdfOltYgYmx04Sr7RqQiLuBMt7D/K9DaotAVANbrwzFnAwRkFNBE9It2pPA2Z
         OkdqFH2KYcZ4lWvAZ18c+DZD34U4+aOVb7P7nPfshOGalEIrx6nXKivOtmTSRnMefQY6
         Ezq5nzprM3S68rustNdsQ/55d/syK+GEbTfWJ1xjzCmu5gAWET7AFScW8KuV88EXsxxh
         /VVNxWoxBU1qbyyOJJjnPX8LOcyECsDn9pvIWWaiYfZZ3+wwDn4bdkkNUZX6QQmoFHak
         +SYw==
X-Gm-Message-State: AOAM530k+qrvkWRt+u1Cdikk+FKYv4XUXOGYOsgJQylM+9dxwob5UoJL
        JDS4yZmSM0d3SjmpLoScXJttM2h710KLJ9jUKrA=
X-Google-Smtp-Source: ABdhPJwiU+h6xAnUU4y/3ZhO0ph1wfQs850Eq7pB8e1zcSZgzX2SdVtaYwxKmOTrIgFVwAyz0CL2bURRSXJ2lflCzGE=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr3882211jav.93.1648757630738; Thu, 31
 Mar 2022 13:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <CAADnVQLkYb6NiEq=bkP_AC4pj8OFC1achC8m9UdEhwWp4ahrFw@mail.gmail.com>
In-Reply-To: <CAADnVQLkYb6NiEq=bkP_AC4pj8OFC1achC8m9UdEhwWp4ahrFw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 13:13:39 -0700
Message-ID: <CAEf4Bza9_L=biSu_G_ux9vgn05LVTLVdfpfi3P_XH421SeH_4g@mail.gmail.com>
Subject: Re: program local storage. Was: [PATCH bpf-next 1/7] libbpf: add
 BPF-side of USDT support
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
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

On Thu, Mar 31, 2022 at 11:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 24, 2022 at 10:30 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > +
> > +struct __bpf_usdt_arg_spec {
> > +       __u64 val_off;
> > +       enum __bpf_usdt_arg_type arg_type;
> > +       short reg_off;
> > +       bool arg_signed;
> > +       char arg_bitshift;
> > +};
> > +
> > +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> > +#define BPF_USDT_MAX_ARG_CNT 12
> > +struct __bpf_usdt_spec {
> > +       struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> > +       __u64 usdt_cookie;
> > +       short arg_cnt;
> > +};
> > +
> > +__weak struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> > +       __type(key, int);
> > +       __type(value, struct __bpf_usdt_spec);
> > +} __bpf_usdt_specs SEC(".maps");
> > +
> > +__weak struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> > +       __type(key, long);
> > +       __type(value, struct __bpf_usdt_spec);
> > +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> ...
>
> > +
> > +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> > + * Returns 0 on success; negative error, otherwise.
> > + * On error *res is guaranteed to be set to zero.
> > + */
> > +__hidden __weak
> > +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> > +{
> > +       struct __bpf_usdt_spec *spec;
> > +       struct __bpf_usdt_arg_spec *arg_spec;
> > +       unsigned long val;
> > +       int err, spec_id;
> > +
> > +       *res = 0;
> > +
> > +       spec_id = __bpf_usdt_spec_id(ctx);
> > +       if (spec_id < 0)
> > +               return -ESRCH;
> > +
> > +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > +       if (!spec)
> > +               return -ESRCH;
> > +
> > +       if (arg >= spec->arg_cnt)
> > +               return -ENOENT;
> > +
> > +       arg_spec = &spec->args[arg];
> > +       switch (arg_spec->arg_type) {
>
> Without bpf_cookie in the kernel each arg access is two lookups.
> With bpf_cookie it's a single lookup in an array that is fast.
> Multiply that cost by number of args.
> Not a huge cost, but we can do better long term.
>
> How about annotating bpf_cookie with PTR_TO_BTF_ID at prog load time.
> So that bpf_get_attach_cookie() returns PTR_TO_BTF_ID instead of long.
> This way bpf_get_attach_cookie() can return
> "struct __bpf_usdt_spec *".
>
> At attach time libbpf will provide populated 'struct __bpf_usdt_spec'
> to the kernel and the kernel will copy the struct's data
> in the bpf_link.
> At detach time that memory is freed.
>
> Advantages:
> - saves an array lookup at runtime
> - no need to provide size for __bpf_usdt_specs map.
>   That map is no longer needed.
>   users don't need to worry about maxing out BPF_USDT_MAX_SPEC_CNT.
> - libbpf doesn't need to populate __bpf_usdt_specs map
>   libbpf doesn't need to allocate spec_id-s.
>   libbpf will keep struct __bpf_usdt_spec per uprobe and
>   pass it to the kernel at attach time to store in bpf_link.
>
> "cookie as ptr_to_btf_id" is a generic mechanism to provide a
> blob of data to the bpf prog instead of a single "long".
> That blob can be read/write too.
> It can be used as per-program + per-attach point scratch area.
> Similar to task/inode local storage...
> That would be (prog, attach_point) local storage.
>
> Thoughts?

Well, I'm not concerned about ARRAY lookup, as it is inlined and very
fast. Sizing maps is hard and annoying, true, but I think we should
eventually just have resizable or dynamically-sized BPF maps, which
will be useful in a lot of other contexts.

We've had a discussion about a cookie that's bigger than 8 bytes with
Daniel. I argued for simplicity and I still like it. If you think we
should add blobs per attachment, it's fine, but let's keep it separate
from the BPF cookie.

As for the PTR_TO_BTF_ID, I'm a bit confused, as kernel doesn't know
__bpf_usdt_spec type, it's not part of vmlinux BTF, so you are
proposing to have PTR_TO_BTF_ID that points to user-provided type? I'm
not sure I see how exactly that will work from the verifier's
standpoint, tbh. At least I don't see how verifier can allow more than
just giving direct memory access to a memory buffer. But then each
uprobe attachment can have differently-sized blob, so statically
verifying that during program load time is impossible.

In any case, I don't think we should wait for any extra kernel
functionality to add USDT support. If we have some of those and they
bring noticeable benefits, we can opportunistically use them, if the
kernel is recent enough.
