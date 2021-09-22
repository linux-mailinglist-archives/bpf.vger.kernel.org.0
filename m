Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E341531A
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhIVV5a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbhIVV53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 17:57:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C91C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:55:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f130so15009481qke.6
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdRTuMVtADVg8vV2SUovluSQ/Czz8g3ujmlllfk4afY=;
        b=KgYCDBTQWyjeXwvOZDlwrfxCQlFzvfax5IXtkdx25p0RwUnDcbXIj4QbOWyjcATvZL
         vcyzTDQKwYYugc6IiIfY6EI2hYonmY0xtZdISNmgZd09h8TBflMlcQMk/I9jLZ4lSGYe
         SLCCcgfQQ+Btipe5V0f+J1pspA4LDTTbQ+GM2dCWDy7PwrtV0Rq3Zj/GEAgjyrAbop6M
         GxTP3NDWINhHEUhcgxAH8E+L4M0aBqfWm0IFa9x1ao/+Of/OTkeucwI9NLgQ340MwDd/
         qCGGu7wYN0TziLVJ3kAC9PsEznGIBjinTp9NuMe6m94WBHwsSTW2JrAz3ufl/qrwu8E6
         Sm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdRTuMVtADVg8vV2SUovluSQ/Czz8g3ujmlllfk4afY=;
        b=htFZq3Dhr92aMgEc7lWkiTJWGsSMWmeK4pbhXaOmYkLOL1LxYshIClgVkdkh74Lc7v
         VRA9PErCTBj2uncMN3nnpjxgd7q1KktSlsFS9lGd5jX4zj1J8D1kFQPgi5gnxz/jsMa/
         ViCegLe7k3q0a15tuL3S12nvR/lAjZVomoOp6Fc9uvODReap63rbH2GCGdbbpi/tyIZ0
         rIv32dm4PE9pJybni1UtBet28U2BPJ5ZFW3jc7lO0aeARVb17vbPhQkSOLfU5uvU0Ybv
         PBtn4VOAP7Y8IqfpIYkiROe+RQDlk1Y7bxqxF1sqjatNSojgMic8ZWuhLtFGqC9QDNUr
         H9Gg==
X-Gm-Message-State: AOAM5307ZGsaHhq5LKYlPSSq+OhDDAwdBOYtWV3VUxKjCofEaifZYSFa
        YgigGxgv30DPUtBRL9TyfbIf9+RIlxQZF6qipP8=
X-Google-Smtp-Source: ABdhPJxEt0hmvqyCcLtu1Zso3RluIoOsDKjfSfXbpHPmmaV+nTXGJfgeQXm0SEEFNIk2UAYjkO+M3SFdVoSGFFs8i4I=
X-Received: by 2002:a25:840d:: with SMTP id u13mr1582083ybk.455.1632347758617;
 Wed, 22 Sep 2021 14:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-8-andrii@kernel.org>
 <c4d6fa1a-182b-8cfa-7a53-374f97af4ecd@fb.com>
In-Reply-To: <c4d6fa1a-182b-8cfa-7a53-374f97af4ecd@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 14:55:47 -0700
Message-ID: <CAEf4BzZsbJBeqwZu8_pH=KQXwOSTyMRq=2K8=cnGSwzv2hPcfQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/9] libbpf: complete SEC() table unification
 for BPF_APROG_SEC/BPF_EAPROG_SEC
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 6:42 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Complete SEC() table refactoring towards unified form by rewriting
> > BPF_APROG_SEC and BPF_EAPROG_SEC definitions with
> > SEC_DEF(SEC_ATTACHABLE_OPT) (for optional expected_attach_type) and
> > SEC_DEF(SEC_ATTACHABLE) (mandatory expected_attach_type), respectively.
> > Drop BPF_APROG_SEC, BPF_EAPROG_SEC, and BPF_PROG_SEC_IMPL macros after
> > that, leaving SEC_DEF() macro as the only one used.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 136 +++++++++++------------------------------
> >  1 file changed, 35 insertions(+), 101 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 734be7dc52a0..56082865ceff 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7959,32 +7959,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
> >       prog->expected_attach_type = type;
> >  }
> >
> > -#define BPF_PROG_SEC_IMPL(string, ptype, eatype, eatype_optional,        \
> > -                       attachable, attach_btf)                           \
> > -     {                                                                   \
> > -             .sec = string,                                              \
> > -             .prog_type = ptype,                                         \
> > -             .expected_attach_type = eatype,                             \
> > -             .cookie = (long) (                                          \
> > -                     (eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
> > -                     (attachable ? SEC_ATTACHABLE : 0) |                 \
> > -                     (attach_btf ? SEC_ATTACH_BTF : 0)                   \
> > -             ),                                                          \
> > -             .preload_fn = libbpf_preload_prog,                          \
> > -     }
> > -
> > -/* Programs that can be attached. */
> > -#define BPF_APROG_SEC(string, ptype, atype) \
> > -     BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
> > -
> > -/* Programs that must specify expected attach type at load time. */
> > -#define BPF_EAPROG_SEC(string, ptype, eatype) \
> > -     BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 1, 0)
> > -
> > -/* Programs that use BTF to identify attach point */
> > -#define BPF_PROG_BTF(string, ptype, eatype) \
> > -     BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
> > -
>
> Similar thoughts about comment usefulness as patch 6.
>

I'll add succinct comments to each SEC_xxx flag, trying to emphasize
what it is about

> >  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                     \
> >       .sec = sec_pfx,                                                     \
> >       .prog_type = BPF_PROG_TYPE_##ptype,                                 \
> > @@ -8003,10 +7977,8 @@ static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
> >
> >  static const struct bpf_sec_def section_defs[] = {
> >       SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > -     BPF_EAPROG_SEC("sk_reuseport/migrate",  BPF_PROG_TYPE_SK_REUSEPORT,
> > -                                             BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
> > -     BPF_EAPROG_SEC("sk_reuseport",          BPF_PROG_TYPE_SK_REUSEPORT,
> > -                                             BPF_SK_REUSEPORT_SELECT),
> > +     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> > +     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
>
> Ah, I see that after this patch the alignment issue from patch 6 is better.
> Nevermind then.
>
> >       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> >       SEC_DEF("uprobe/",              KPROBE, 0, SEC_NONE),
> >       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
>
> [...]
>
> > +     SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
> > +     SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
>
> checkpatch really doesn't like the lack of space after comma here, I agree
> with it.

it was either this, or one extra tab for all other entries making
every line longer still. But I guess I'll just do s/SEC_DEF/SECDEF/
and get that space back :)

But keep in mind, checkpatch.pl is a guide, not a law.

>
> >       SEC_DEF("sk_skb",               SK_SKB, 0, SEC_NONE),
> > -     BPF_APROG_SEC("sk_msg",                 BPF_PROG_TYPE_SK_MSG,
> > -                                             BPF_SK_MSG_VERDICT),
> > -     BPF_APROG_SEC("lirc_mode2",             BPF_PROG_TYPE_LIRC_MODE2,
>
> [...]
>
