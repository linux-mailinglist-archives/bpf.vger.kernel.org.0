Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1488572908
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGLWJe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiGLWJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 18:09:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCBBD396
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:09:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t1so1007340ejd.12
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiCmr8J3UkIhGJXStMvjQkgTmcxh7o0aH9TQ2csPFTY=;
        b=HRJ1X3f/eRSTBZtbUI5ZKe/cj/BbR3y/C8gxnUiz55q1Ifdw0kAFEeeTPQOs/XBCbb
         dBSedLOdsWnNgfoUwpugU0aT0vBI7csU1VmN7N1K6lpIbtVAhGU5UXw0wZ/cgIiUSIDR
         XUV+9PES2BWSMEOGMwL5d4nJe4eIpAOQt1Vs9Ib08Ffe+tQsSqvwtffYtN0ldM/pFPj5
         NWtIvUiBBbKc6JGVMqFe8DjmLrviArdi72jOWaniTyEeWb5acQ9CF2++wHwgUCZM9nVQ
         p9fZtepHHqK23l9e5mZPCvA4y2yONlm+5SfMVQXHobFbxjehm/IErAtNC8Fb5UByZcNC
         4MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiCmr8J3UkIhGJXStMvjQkgTmcxh7o0aH9TQ2csPFTY=;
        b=bCZD8+1RIPFGrQU3G1iaSP455cUULhr6wJ/otXZv3FcywbBneCYBmnZEBvz9QsGHjO
         N9WlqcagyS9QRkq3ygJ0rvq9nl/FWgQKpAHXpRFEuzthM/3ZyxO3qwh7wNu4LYfuGvOC
         ZnmlAtnhpDygAN9GPHG2guzX6MXOmNCyqna/UuOWX4EzCOAZvfAcXImvDspYzhe80RDr
         jf3Po8hnFcCa4gEi3MrtOA2/KSgnsxscU/hO9H01PUTjQYPbsC6roO83PFesEYVWDmMi
         H5slq92JvNjXc59aYQII14DYc5EmTmDTnhN8vTh8xrsij8yttc/oJ21h4q2nFSshgqhQ
         0Bkg==
X-Gm-Message-State: AJIora9dJaCItrizrUw9U0wye74mhGSpu4OwlepHUrLFICPwEL/Ftdq/
        7rvyGm1yxSFl00p2EqTeMi423cH9Ku+3GwUwrCs=
X-Google-Smtp-Source: AGRyM1s9bGy6+6LxJacXKx4/i1HKyA9aHt1pl7mg5/TcUVhq6wNwDUZNsit7fKGhQ1PH7y6Vi+OnJgD5fsnU8MzrnLM=
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id
 hq7-20020a1709073f0700b0072b54b2f57fmr269996ejc.502.1657663771274; Tue, 12
 Jul 2022 15:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220706002612.4013790-1-song@kernel.org>
In-Reply-To: <20220706002612.4013790-1-song@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 15:09:19 -0700
Message-ID: <CAADnVQ++wJcuKemLaJo9eJrvw_873LtMPidFSvgyHtWjCgG2MQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, x86: fix freeing of not-finalized bpf_prog_pack
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com,
        syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
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

On Tue, Jul 5, 2022 at 5:26 PM Song Liu <song@kernel.org> wrote:
>
> syzbot reported a few issues with bpf_prog_pack [1], [2]. These are
> triggered when the program passed initial JIT in jit_subprogs(), but
> failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> called before bpf_jit_binary_pack_finalize(), and the whole 2MB page is
> freed.
>
> Fix this with a custom bpf_jit_free() for x86_64, which calls
> bpf_jit_binary_pack_finalize() if necessary. Also, with custom
> bpf_jit_free(), bpf_prog_aux->use_bpf_prog_pack is not needed any more,
> remove it.
>
> Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
> [1] https://syzkaller.appspot.com/bug?extid=2f649ec6d2eea1495a8f
> [2] https://syzkaller.appspot.com/bug?extid=87f65c75f4a72db05445
> Reported-by: syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com
> Reported-by: syzbot+87f65c75f4a72db05445@syzkaller.appspotmail.com
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++++
>  include/linux/bpf.h         |  1 -
>  include/linux/filter.h      |  8 ++++++++
>  kernel/bpf/core.c           | 29 ++++++++++++-----------------
>  4 files changed, 45 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c98b8c0ed3b8..c3dca4c97e48 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2492,3 +2492,28 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>                 return ERR_PTR(-EINVAL);
>         return dst;
>  }
> +
> +void bpf_jit_free(struct bpf_prog *prog)
> +{
> +       if (prog->jited) {
> +               struct x64_jit_data *jit_data = prog->aux->jit_data;
> +               struct bpf_binary_header *hdr;
> +
> +               /*
> +                * If we fail the final pass of JIT (from jit_subprogs),
> +                * the program may not be finalized yet. Call finalize here
> +                * before freeing it.
> +                */
> +               if (jit_data) {
> +                       bpf_jit_binary_pack_finalize(prog, jit_data->header,
> +                                                    jit_data->rw_header);
> +                       kvfree(jit_data->addrs);
> +                       kfree(jit_data);
> +               }

It looks like a workaround for missed cleanup on the JIT side.
When bpf_int_jit_compile() fails it is supposed to free jit_data
immediately.

> passed initial JIT in jit_subprogs(), but
> failed final pass of JIT. At this point, bpf_jit_binary_pack_free() is
> called before bpf_jit_binary_pack_finalize()

It feels that bpf_int_jit_compile() should call
bpf_jit_binary_pack_finalize() instead in the path where
it's failing.
I could be missing details on what exactly
"failed final pass of JIT" means.
