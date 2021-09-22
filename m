Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4340B415338
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhIVWOO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIVWON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 18:14:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB12C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 15:12:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t4so14974978qkb.9
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noifj6lQwdwW+udA34wjQefyrzH0nt/Vd/kemjXGjdI=;
        b=hwBE5CeM0o4Ln6gUBpj/vMjFzKpTR+NSsvdncbW7xA5aU8bKRptD91mKNXpQEzByIv
         uLGJwEOyJOptfDgPn6HX9xH4+5liwycDC40fEDltIHXPQM9n2bJePjKggPfLOrZ4WbvJ
         YyXKXw3k45up8MRBsf1FlE515GFjkntk3Bj76G8DaHOcoETQkdtseIDas17njMwMeftA
         oqbxtomuTeYxsrYz/f19dva354eiKN6jJGMx+IPfwjm45ZwEx5ouaMSw6q4518wxheSl
         Hji6Ab/0E2ikHMLzNDtEIJYtQdCAGanfXdkIkLZj4ot3nbUE5DoYrDKEjmaD7Q+0sVtk
         xGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noifj6lQwdwW+udA34wjQefyrzH0nt/Vd/kemjXGjdI=;
        b=oSdJtjSg11ahluPC125oggQsuQ3f2mzXbR5eIOu/teSqZno3Mu2TFaOS99uKf0cAlq
         d8G+h5Y1An6YWDcGSs4j+5eZQI2+eX4XBueCFhVf6i2v+8PH8gG/U5aJkMag53qLbdXJ
         Yq8iJcCGWGnyNiZKmbA5Mkz11LgBaW3jNw/pA+5y+QWRXe2UX1xu2svS/aJLMUgPsBOj
         zwKJo1iqJWFJKTFAJu+YE6dnGj/raurXbMpRx5EcxyVH3J7ugwtyeHr9sm5CkjksVdZl
         ai91lJRrY3vESlwwSbumordQ5DcngC/B4t507J1CApP9fZ/CsM7aXL17738WXBcsnehI
         0yxA==
X-Gm-Message-State: AOAM531TqPH8CN81yclifoukmL4nMbA3h/QEmRt4JyuJiFquwa1YzCG9
        vtdG5SmEjfNIY+8wPkuy+8mD1dV1B4wCZ70Q+/I=
X-Google-Smtp-Source: ABdhPJyV2sAM30yp+KSuXbcUJRaH198dbD+Q5h8JXQaAxFoly0NRPGj5k5Qi7lhXowjCN7XGnuohb5rkLofXhvhXzF4=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr1844935ybj.504.1632348762408;
 Wed, 22 Sep 2021 15:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-8-andrii@kernel.org>
 <c4d6fa1a-182b-8cfa-7a53-374f97af4ecd@fb.com> <CAEf4BzZsbJBeqwZu8_pH=KQXwOSTyMRq=2K8=cnGSwzv2hPcfQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZsbJBeqwZu8_pH=KQXwOSTyMRq=2K8=cnGSwzv2hPcfQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 15:12:31 -0700
Message-ID: <CAEf4BzZXdnNWePXevV8UPySquFxnWPZtejdXdfBY-RG79o9YOA@mail.gmail.com>
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

On Wed, Sep 22, 2021 at 2:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 6:42 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > > Complete SEC() table refactoring towards unified form by rewriting
> > > BPF_APROG_SEC and BPF_EAPROG_SEC definitions with
> > > SEC_DEF(SEC_ATTACHABLE_OPT) (for optional expected_attach_type) and
> > > SEC_DEF(SEC_ATTACHABLE) (mandatory expected_attach_type), respectively.
> > > Drop BPF_APROG_SEC, BPF_EAPROG_SEC, and BPF_PROG_SEC_IMPL macros after
> > > that, leaving SEC_DEF() macro as the only one used.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 136 +++++++++++------------------------------
> > >  1 file changed, 35 insertions(+), 101 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 734be7dc52a0..56082865ceff 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -7959,32 +7959,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
> > >       prog->expected_attach_type = type;
> > >  }
> > >
> > > -#define BPF_PROG_SEC_IMPL(string, ptype, eatype, eatype_optional,        \
> > > -                       attachable, attach_btf)                           \
> > > -     {                                                                   \
> > > -             .sec = string,                                              \
> > > -             .prog_type = ptype,                                         \
> > > -             .expected_attach_type = eatype,                             \
> > > -             .cookie = (long) (                                          \
> > > -                     (eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
> > > -                     (attachable ? SEC_ATTACHABLE : 0) |                 \
> > > -                     (attach_btf ? SEC_ATTACH_BTF : 0)                   \
> > > -             ),                                                          \
> > > -             .preload_fn = libbpf_preload_prog,                          \
> > > -     }
> > > -
> > > -/* Programs that can be attached. */
> > > -#define BPF_APROG_SEC(string, ptype, atype) \
> > > -     BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
> > > -
> > > -/* Programs that must specify expected attach type at load time. */
> > > -#define BPF_EAPROG_SEC(string, ptype, eatype) \
> > > -     BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 1, 0)
> > > -
> > > -/* Programs that use BTF to identify attach point */
> > > -#define BPF_PROG_BTF(string, ptype, eatype) \
> > > -     BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
> > > -
> >
> > Similar thoughts about comment usefulness as patch 6.
> >
>
> I'll add succinct comments to each SEC_xxx flag, trying to emphasize
> what it is about
>
> > >  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                     \
> > >       .sec = sec_pfx,                                                     \
> > >       .prog_type = BPF_PROG_TYPE_##ptype,                                 \
> > > @@ -8003,10 +7977,8 @@ static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
> > >
> > >  static const struct bpf_sec_def section_defs[] = {
> > >       SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > > -     BPF_EAPROG_SEC("sk_reuseport/migrate",  BPF_PROG_TYPE_SK_REUSEPORT,
> > > -                                             BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
> > > -     BPF_EAPROG_SEC("sk_reuseport",          BPF_PROG_TYPE_SK_REUSEPORT,
> > > -                                             BPF_SK_REUSEPORT_SELECT),
> > > +     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> > > +     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
> >
> > Ah, I see that after this patch the alignment issue from patch 6 is better.
> > Nevermind then.
> >
> > >       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> > >       SEC_DEF("uprobe/",              KPROBE, 0, SEC_NONE),
> > >       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
> >
> > [...]
> >
> > > +     SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
> > > +     SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
> >
> > checkpatch really doesn't like the lack of space after comma here, I agree
> > with it.
>
> it was either this, or one extra tab for all other entries making
> every line longer still. But I guess I'll just do s/SEC_DEF/SECDEF/
> and get that space back :)
>

Nah, it looks too ugly, like a pile of letters. I'll leave it as is,
checkpatch.pl will have to deal with this ;)

> But keep in mind, checkpatch.pl is a guide, not a law.
>
> >
> > >       SEC_DEF("sk_skb",               SK_SKB, 0, SEC_NONE),
> > > -     BPF_APROG_SEC("sk_msg",                 BPF_PROG_TYPE_SK_MSG,
> > > -                                             BPF_SK_MSG_VERDICT),
> > > -     BPF_APROG_SEC("lirc_mode2",             BPF_PROG_TYPE_LIRC_MODE2,
> >
> > [...]
> >
