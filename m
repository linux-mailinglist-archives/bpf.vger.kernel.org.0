Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302A5E86E8
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 03:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIXBD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 21:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIXBD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 21:03:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC96127CA6
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 18:03:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hy2so3825013ejc.8
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 18:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dCtm8IdvVALoeew/EVGoojABgYAzkiTMQrXJVACB+9U=;
        b=hWbX9er7oYDWotSkxWK95O/7D4JXuBwj8o9xCK2acd8pS/2Medm1ALj3zMjQXZ4qB0
         BKcAsX2ou19qLRUHrNePtz2XE7JiVbIbF9qxIz7ztkCMU905k5hyeZqrzNINhJj46KhB
         O9c43AL19u1No71tN085TfFZDJErjSkbS1FxHgVWRn2x5cDnJCipxf15vpJZHKK3f6TQ
         GbXzTx37jUJHAUwbIF5BwpkTs+wgOp0wwIvF2+0iJl7yAK2pC3MQ7TmIrJvLkUytj7MP
         vD56qI9cCPt2O8wXvP4MR6GSdacMYBEeabySYJyzqU9YEWR5WS8iPg8PznTcmg4Tuehy
         0IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dCtm8IdvVALoeew/EVGoojABgYAzkiTMQrXJVACB+9U=;
        b=WT/c8o5bIpDfcr6rdNFS9MkXzmCI+9dFAdDc6OT18XKvnvBPeOakSOuGqKnGIGGGEq
         HahYmGLuR73F5krF1W7ax+NX7QM3LXjShpYIeP+cSkHY0BrOdmsZvXvLI30HDMSRjrQ9
         eExDNNSw2UxKSOKeMg/VjA5PZR+le5Spd1ogs+a5eBmh4IOTnWBOAjGkemNKlsTXtQ0P
         34D5s3UNgSyLwtdTniUmePjPOE55kp5Jt384p91P+c0Qj1iOZ6v6oE9SQbP6kIXc0VNF
         Khu1M5GPykCQcgJ57XRJUPeUxHJMYzI1U/wzCj8VKD8MiIWAfDq9Aqx9/8azYpa2yqSs
         AsRg==
X-Gm-Message-State: ACrzQf2JYdpOe9Z1seLx11RMMqrYCQLjodjFt8cN+wu/ZlBnjNUjb3uA
        H9IIetfMzoRQZzAAPuER+dhqLLW9lYOHKMXRo8A=
X-Google-Smtp-Source: AMsMyM4NBsWRykBeMIgI0Iy+iKvqJS3KzyD4D2ZkFvkekAdSlxvJ8bdfW9Y8/WLzD4qcJT2a06aZeXPSR5syQfieEOU=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr9463111ejc.676.1663981433630; Fri, 23
 Sep 2022 18:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220923211837.3044723-1-song@kernel.org> <20220923211837.3044723-2-song@kernel.org>
 <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com>
 <37C7A6C4-33C6-42EC-8BEC-E6D70AB0774A@fb.com> <CAADnVQKxgCgL+09MX3N74rJsdrPRBAM8U2ZPYgZhxzNs54=n+A@mail.gmail.com>
 <C324732A-58BE-4E2D-9C81-A3F8696FB150@fb.com>
In-Reply-To: <C324732A-58BE-4E2D-9C81-A3F8696FB150@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Sep 2022 18:03:42 -0700
Message-ID: <CAADnVQL2u=oWtaeq9HJKwsFmAJjfPoWhQQKsvS12e5yTDj4eAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
To:     Song Liu <songliubraving@fb.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kernel Team <Kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 5:51 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Sep 23, 2022, at 4:23 PM, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> wrote:
> >
> > On Fri, Sep 23, 2022 at 4:18 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >> + Bj=C3=B6rn T=C3=B6pel
> >>
> >>> On Sep 23, 2022, at 3:00 PM, Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
> >>>
> >>> On Fri, Sep 23, 2022 at 2:18 PM Song Liu <song@kernel.org> wrote:
> >>>>
> >>>> Allocate bpf_dispatcher with bpf_prog_pack_alloc so that bpf_dispatc=
her
> >>>> can share pages with bpf programs.
> >>>>
> >>>> This also fixes CPA W^X warnning like:
> >>>>
> >>>> CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range=
: ...
> >>>>
> >>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>> ---
> >>>> include/linux/bpf.h     |  1 +
> >>>> include/linux/filter.h  |  5 +++++
> >>>> kernel/bpf/core.c       |  9 +++++++--
> >>>> kernel/bpf/dispatcher.c | 21 ++++++++++++++++++---
> >>>> 4 files changed, 31 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>> index edd43edb27d6..a8d0cfe14372 100644
> >>>> --- a/include/linux/bpf.h
> >>>> +++ b/include/linux/bpf.h
> >>>> @@ -946,6 +946,7 @@ struct bpf_dispatcher {
> >>>>       struct bpf_dispatcher_prog progs[BPF_DISPATCHER_MAX];
> >>>>       int num_progs;
> >>>>       void *image;
> >>>> +       void *rw_image;
> >>>>       u32 image_off;
> >>>>       struct bpf_ksym ksym;
> >>>> };
> >>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
> >>>> index 98e28126c24b..efc42a6e3aed 100644
> >>>> --- a/include/linux/filter.h
> >>>> +++ b/include/linux/filter.h
> >>>> @@ -1023,6 +1023,8 @@ extern long bpf_jit_limit_max;
> >>>>
> >>>> typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
> >>>>
> >>>> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
> >>>> +
> >>>> struct bpf_binary_header *
> >>>> bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >>>>                    unsigned int alignment,
> >>>> @@ -1035,6 +1037,9 @@ void bpf_jit_free(struct bpf_prog *fp);
> >>>> struct bpf_binary_header *
> >>>> bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
> >>>>
> >>>> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_il=
l_insns);
> >>>> +void bpf_prog_pack_free(struct bpf_binary_header *hdr);
> >>>> +
> >>>> static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_pro=
g *fp)
> >>>> {
> >>>>       return list_empty(&fp->aux->ksym.lnode) ||
> >>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >>>> index d1be78c28619..711fd293b6de 100644
> >>>> --- a/kernel/bpf/core.c
> >>>> +++ b/kernel/bpf/core.c
> >>>> @@ -825,6 +825,11 @@ struct bpf_prog_pack {
> >>>>       unsigned long bitmap[];
> >>>> };
> >>>>
> >>>> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
> >>>> +{
> >>>> +       memset(area, 0, size);
> >>>> +}
> >>>> +
> >>>> #define BPF_PROG_SIZE_TO_NBITS(size)   (round_up(size, BPF_PROG_CHUN=
K_SIZE) / BPF_PROG_CHUNK_SIZE)
> >>>>
> >>>> static DEFINE_MUTEX(pack_mutex);
> >>>> @@ -864,7 +869,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_=
jit_fill_hole_t bpf_fill_ill_ins
> >>>>       return pack;
> >>>> }
> >>>>
> >>>> -static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_=
fill_ill_insns)
> >>>> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_il=
l_insns)
> >>>> {
> >>>>       unsigned int nbits =3D BPF_PROG_SIZE_TO_NBITS(size);
> >>>>       struct bpf_prog_pack *pack;
> >>>> @@ -905,7 +910,7 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_j=
it_fill_hole_t bpf_fill_ill_insn
> >>>>       return ptr;
> >>>> }
> >>>>
> >>>> -static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> >>>> +void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> >>>> {
> >>>>       struct bpf_prog_pack *pack =3D NULL, *tmp;
> >>>>       unsigned int nbits;
> >>>> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> >>>> index 2444bd15cc2d..8a10300854b6 100644
> >>>> --- a/kernel/bpf/dispatcher.c
> >>>> +++ b/kernel/bpf/dispatcher.c
> >>>> @@ -104,7 +104,7 @@ static int bpf_dispatcher_prepare(struct bpf_dis=
patcher *d, void *image)
> >>>>
> >>>> static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev=
_num_progs)
> >>>> {
> >>>> -       void *old, *new;
> >>>> +       void *old, *new, *tmp;
> >>>>       u32 noff;
> >>>>       int err;
> >>>>
> >>>> @@ -117,8 +117,14 @@ static void bpf_dispatcher_update(struct bpf_di=
spatcher *d, int prev_num_progs)
> >>>>       }
> >>>>
> >>>>       new =3D d->num_progs ? d->image + noff : NULL;
> >>>> +       tmp =3D d->num_progs ? d->rw_image + noff : NULL;
> >>>>       if (new) {
> >>>> -               if (bpf_dispatcher_prepare(d, new))
> >>>> +               /* Prepare the dispatcher in d->rw_image. Then use
> >>>> +                * bpf_arch_text_copy to update d->image, which is R=
O+X.
> >>>> +                */
> >>>> +               if (bpf_dispatcher_prepare(d, tmp))
> >>>> +                       return;
> >>>> +               if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / =
2)))
> >>>
> >>> I don't think we can create a dispatcher with one ip
> >>> and then copy over into a different location.
> >>> See emit_bpf_dispatcher() -> emit_cond_near_jump()
> >>> It's a relative offset jump.
> >>
> >> Hmm... Yeah, this makes sense. But somehow vmtest doesn't
> >> show any issue with this. Is there a better way to test this?
> >
> > test_xdp*.sh should surely trigger it,
>
> text_xdp*.sh seem to give same result w/ and w/o the set (on top
> of bpf-next). For example, ./test_xdp_redirect.sh works just fine.
> (And I think it shouldn't.)
>
>
> > but I'm surprised the regular test_run doesn't trigger it.
> > We call bpf_prog_run_xdp() there.
> > We've added
> >        if (repeat > 1)
> >                bpf_prog_change_xdp(NULL, prog);
>
> I removed this from test_run.c, but that didn't change vmtest.

Something is broken. That relative jump isn't being triggered.
