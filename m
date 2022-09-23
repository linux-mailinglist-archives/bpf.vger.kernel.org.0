Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE275E864C
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIWXYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIWXYE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:24:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE912C68A
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:24:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so2059421edd.11
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=sCQvCLoXTEeRbc4JxoXzAOnUEC5+LcbaCYU33OBaNjw=;
        b=OtI8vaKqhtCdlDm9D+YZhZT8rbHucIHD8a7wUABThGitcOpTnv105PIWOq96KhrGB/
         a0rfrrnEwE2pqHl3eL/X7aWDyIkzTSMPmUjLKFiGECiB56rBQXG7Apq/1juIL4qTIKG6
         YL/9j02Ghs2URCIHJUP4aGxwNGebu6gD1cnRMz7yqZ3R32MmWiiDMicUzZ4JlXogtTuX
         8XDt4XAAxZo2MhtVn6VH67Ve2d0MeCS102FEQ9vh+SjkL+Fktk3EhD4L0cFQupavyoXM
         nFFeCuVpzLkQPLvnJl3CrtNbm0+A/G+Lrlqy4H/r/57ObvnKOhE3RXXJIHKA1QAZwjKM
         PSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sCQvCLoXTEeRbc4JxoXzAOnUEC5+LcbaCYU33OBaNjw=;
        b=gim6JKJHHBk4jpgnyX75dHcUyJGEKM95m9HM13//Ku0UrHfH8mAhNJ99lQZR/BwULF
         zH3eVz6Uidm0cqHtFCKBlMWAmiAVA06Xm50Wqcz4tG9OmlVkkZ4AWKEbTxi69HbtOPGI
         b95qz2uu9ySKd4epcS58ZZLsxh9JOWCMRa23zXQT1iiXCn+I9SUjDy/ekbWEBH53pPxY
         GvSBvd5IeY+qn4a//YP/CIQPAZDt7t8n+xFzXFVuZdtt1vuEIGc8fze3S/TJTwwoq2Xn
         XbPkjJVBXX1LjhZCoP0yWYkNr5vQiVORiZG4Qw8hjb7x9N+52purz26eWVFyZdRC4aBh
         USAQ==
X-Gm-Message-State: ACrzQf2nhS7TnmE0r04r1IlIS3/wCXH3TnqKYDFHSaV+W6nFO1tGxvYK
        JlaW2cDkYilzRiJsEIjaM4+ZmMzDjow3dwdZbF4JlyPTppk=
X-Google-Smtp-Source: AMsMyM7YCsfCFFBhhzJx8QpSjjrE1tHQnBoKvujAjzJINreo2yuFrPLLi/+qBTmZteQPIxR7xRnUPGIzFM+UfY0Aixg=
X-Received: by 2002:a05:6402:b29:b0:456:f2dc:826d with SMTP id
 bo9-20020a0564020b2900b00456f2dc826dmr707909edb.94.1663975442221; Fri, 23 Sep
 2022 16:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220923211837.3044723-1-song@kernel.org> <20220923211837.3044723-2-song@kernel.org>
 <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com> <37C7A6C4-33C6-42EC-8BEC-E6D70AB0774A@fb.com>
In-Reply-To: <37C7A6C4-33C6-42EC-8BEC-E6D70AB0774A@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Sep 2022 16:23:51 -0700
Message-ID: <CAADnVQKxgCgL+09MX3N74rJsdrPRBAM8U2ZPYgZhxzNs54=n+A@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 4:18 PM Song Liu <songliubraving@fb.com> wrote:
>
> + Bj=C3=B6rn T=C3=B6pel
>
> > On Sep 23, 2022, at 3:00 PM, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> wrote:
> >
> > On Fri, Sep 23, 2022 at 2:18 PM Song Liu <song@kernel.org> wrote:
> >>
> >> Allocate bpf_dispatcher with bpf_prog_pack_alloc so that bpf_dispatche=
r
> >> can share pages with bpf programs.
> >>
> >> This also fixes CPA W^X warnning like:
> >>
> >> CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: =
...
> >>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> include/linux/bpf.h     |  1 +
> >> include/linux/filter.h  |  5 +++++
> >> kernel/bpf/core.c       |  9 +++++++--
> >> kernel/bpf/dispatcher.c | 21 ++++++++++++++++++---
> >> 4 files changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index edd43edb27d6..a8d0cfe14372 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -946,6 +946,7 @@ struct bpf_dispatcher {
> >>        struct bpf_dispatcher_prog progs[BPF_DISPATCHER_MAX];
> >>        int num_progs;
> >>        void *image;
> >> +       void *rw_image;
> >>        u32 image_off;
> >>        struct bpf_ksym ksym;
> >> };
> >> diff --git a/include/linux/filter.h b/include/linux/filter.h
> >> index 98e28126c24b..efc42a6e3aed 100644
> >> --- a/include/linux/filter.h
> >> +++ b/include/linux/filter.h
> >> @@ -1023,6 +1023,8 @@ extern long bpf_jit_limit_max;
> >>
> >> typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
> >>
> >> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
> >> +
> >> struct bpf_binary_header *
> >> bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >>                     unsigned int alignment,
> >> @@ -1035,6 +1037,9 @@ void bpf_jit_free(struct bpf_prog *fp);
> >> struct bpf_binary_header *
> >> bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
> >>
> >> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_=
insns);
> >> +void bpf_prog_pack_free(struct bpf_binary_header *hdr);
> >> +
> >> static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog =
*fp)
> >> {
> >>        return list_empty(&fp->aux->ksym.lnode) ||
> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >> index d1be78c28619..711fd293b6de 100644
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >> @@ -825,6 +825,11 @@ struct bpf_prog_pack {
> >>        unsigned long bitmap[];
> >> };
> >>
> >> +void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
> >> +{
> >> +       memset(area, 0, size);
> >> +}
> >> +
> >> #define BPF_PROG_SIZE_TO_NBITS(size)   (round_up(size, BPF_PROG_CHUNK_=
SIZE) / BPF_PROG_CHUNK_SIZE)
> >>
> >> static DEFINE_MUTEX(pack_mutex);
> >> @@ -864,7 +869,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_ji=
t_fill_hole_t bpf_fill_ill_ins
> >>        return pack;
> >> }
> >>
> >> -static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fi=
ll_ill_insns)
> >> +void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_=
insns)
> >> {
> >>        unsigned int nbits =3D BPF_PROG_SIZE_TO_NBITS(size);
> >>        struct bpf_prog_pack *pack;
> >> @@ -905,7 +910,7 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit=
_fill_hole_t bpf_fill_ill_insn
> >>        return ptr;
> >> }
> >>
> >> -static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> >> +void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> >> {
> >>        struct bpf_prog_pack *pack =3D NULL, *tmp;
> >>        unsigned int nbits;
> >> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> >> index 2444bd15cc2d..8a10300854b6 100644
> >> --- a/kernel/bpf/dispatcher.c
> >> +++ b/kernel/bpf/dispatcher.c
> >> @@ -104,7 +104,7 @@ static int bpf_dispatcher_prepare(struct bpf_dispa=
tcher *d, void *image)
> >>
> >> static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_n=
um_progs)
> >> {
> >> -       void *old, *new;
> >> +       void *old, *new, *tmp;
> >>        u32 noff;
> >>        int err;
> >>
> >> @@ -117,8 +117,14 @@ static void bpf_dispatcher_update(struct bpf_disp=
atcher *d, int prev_num_progs)
> >>        }
> >>
> >>        new =3D d->num_progs ? d->image + noff : NULL;
> >> +       tmp =3D d->num_progs ? d->rw_image + noff : NULL;
> >>        if (new) {
> >> -               if (bpf_dispatcher_prepare(d, new))
> >> +               /* Prepare the dispatcher in d->rw_image. Then use
> >> +                * bpf_arch_text_copy to update d->image, which is RO+=
X.
> >> +                */
> >> +               if (bpf_dispatcher_prepare(d, tmp))
> >> +                       return;
> >> +               if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)=
))
> >
> > I don't think we can create a dispatcher with one ip
> > and then copy over into a different location.
> > See emit_bpf_dispatcher() -> emit_cond_near_jump()
> > It's a relative offset jump.
>
> Hmm... Yeah, this makes sense. But somehow vmtest doesn't
> show any issue with this. Is there a better way to test this?

test_xdp*.sh should surely trigger it,
but I'm surprised the regular test_run doesn't trigger it.
We call bpf_prog_run_xdp() there.
We've added
        if (repeat > 1)
                bpf_prog_change_xdp(NULL, prog);

there to reduce test_progs time. Maybe it reduced test coverage too much.
