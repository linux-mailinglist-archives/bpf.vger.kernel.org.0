Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF05E8580
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIWWA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWWA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:00:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85796E742F
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:00:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z13so1865425edb.13
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SVMN31xWdYYzqNIMEzuy2s3vu1WsjlzeRGNzmJrrAf8=;
        b=S5BxsXV6GquUHQyYGlz19v9hsLIsNmzLdDWmX3WgyCZBHrtXxSmoWe7ylHdkEigVQZ
         H94tMW82JudrTIH//bHVDKVyYhAO9B5U0PQnOIK7iJYvhilN6cqYr62E8dbeENXDgWGQ
         RKLOgqRIpHBiH84AfUYazY++sSGW4If6m+JRZDFwG9ri4Uzm9SRxezY5jQ5AgnRT9XFm
         QBEzaqoL+eLyhXh8lkMdYJR/QBUSyKaQLri73Lta/qfHvbtsy6eplIGsu9MIjJYgaf3E
         wnh5De12KFDmTgb9AgI8p2eeGUb5vJYU23CgT+HKp2CxzdTFM75s4Tq0OS6nW8sTRYS5
         YQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SVMN31xWdYYzqNIMEzuy2s3vu1WsjlzeRGNzmJrrAf8=;
        b=T4SQcvzIlXMVr0ydFoG/L9r6hhVBGAFXLITLOYewA5tmJFsx4Rhbc8zODsRI0UkhMG
         HDWrrOQ3in/oV9ugFhmAF2tfi3hOpyMsG/neMFqNjd56gTIdoRcEJG6fm+aE41AqkxcR
         4rrjEZtYaVjDA1M9cQUDU8XUqWXePV3OWT2SK8J1nl0z/gPwI3WhV17isfiBtuUi9+3u
         BNJLqX9/Ukdgv4rWiywkGKx+abHQjdfyotg84KpvGGyPTWJYsmuFOwRt+lwRm2MDGaR4
         OOYe/gHeLMVMlIESYQw/kk2jWbrKQ8KYg9LohmHOdFxPCmGoeJOnTS1GAv2cKXTfYZIA
         fWgw==
X-Gm-Message-State: ACrzQf1Jj2G7/ej/TECuc7UeOWeCfpNhU0pA045keiu8pxF9/VD2xhdt
        6mIrwVY6mvKx5e2Md/7hUSsxoEaSsd6LEUcxAW0=
X-Google-Smtp-Source: AMsMyM5tXTnzbzZXvzc2MRknqKQOcvIBf2TZHrJvND55ufw00CSJpgJTiFnNSj1cbGGDOCxIRF6juNJdHnM2YnOVDZQ=
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id
 bf15-20020a0564021a4f00b0044ef731f7d5mr10500438edb.357.1663970454937; Fri, 23
 Sep 2022 15:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220923211837.3044723-1-song@kernel.org> <20220923211837.3044723-2-song@kernel.org>
In-Reply-To: <20220923211837.3044723-2-song@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Sep 2022 15:00:43 -0700
Message-ID: <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kernel Team <kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 2:18 PM Song Liu <song@kernel.org> wrote:
>
> Allocate bpf_dispatcher with bpf_prog_pack_alloc so that bpf_dispatcher
> can share pages with bpf programs.
>
> This also fixes CPA W^X warnning like:
>
> CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: ...
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/bpf.h     |  1 +
>  include/linux/filter.h  |  5 +++++
>  kernel/bpf/core.c       |  9 +++++++--
>  kernel/bpf/dispatcher.c | 21 ++++++++++++++++++---
>  4 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index edd43edb27d6..a8d0cfe14372 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -946,6 +946,7 @@ struct bpf_dispatcher {
>         struct bpf_dispatcher_prog progs[BPF_DISPATCHER_MAX];
>         int num_progs;
>         void *image;
> +       void *rw_image;
>         u32 image_off;
>         struct bpf_ksym ksym;
>  };
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 98e28126c24b..efc42a6e3aed 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1023,6 +1023,8 @@ extern long bpf_jit_limit_max;
>
>  typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
>
> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
> +
>  struct bpf_binary_header *
>  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>                      unsigned int alignment,
> @@ -1035,6 +1037,9 @@ void bpf_jit_free(struct bpf_prog *fp);
>  struct bpf_binary_header *
>  bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
>
> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
> +void bpf_prog_pack_free(struct bpf_binary_header *hdr);
> +
>  static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
>  {
>         return list_empty(&fp->aux->ksym.lnode) ||
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d1be78c28619..711fd293b6de 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -825,6 +825,11 @@ struct bpf_prog_pack {
>         unsigned long bitmap[];
>  };
>
> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
> +{
> +       memset(area, 0, size);
> +}
> +
>  #define BPF_PROG_SIZE_TO_NBITS(size)   (round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
>
>  static DEFINE_MUTEX(pack_mutex);
> @@ -864,7 +869,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
>         return pack;
>  }
>
> -static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
>  {
>         unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
>         struct bpf_prog_pack *pack;
> @@ -905,7 +910,7 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
>         return ptr;
>  }
>
> -static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> +void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>  {
>         struct bpf_prog_pack *pack = NULL, *tmp;
>         unsigned int nbits;
> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index 2444bd15cc2d..8a10300854b6 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -104,7 +104,7 @@ static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
>
>  static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
>  {
> -       void *old, *new;
> +       void *old, *new, *tmp;
>         u32 noff;
>         int err;
>
> @@ -117,8 +117,14 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
>         }
>
>         new = d->num_progs ? d->image + noff : NULL;
> +       tmp = d->num_progs ? d->rw_image + noff : NULL;
>         if (new) {
> -               if (bpf_dispatcher_prepare(d, new))
> +               /* Prepare the dispatcher in d->rw_image. Then use
> +                * bpf_arch_text_copy to update d->image, which is RO+X.
> +                */
> +               if (bpf_dispatcher_prepare(d, tmp))
> +                       return;
> +               if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)))

I don't think we can create a dispatcher with one ip
and then copy over into a different location.
See emit_bpf_dispatcher() -> emit_cond_near_jump()
It's a relative offset jump.
