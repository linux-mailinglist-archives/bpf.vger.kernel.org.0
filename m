Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23FD52056B
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbiEITsp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiEITso (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:48:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F392D9EF4
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 12:44:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w187so26873493ybe.2
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zcXM3TjuUtOj4GCOwvh2CNZQLLNcr9SIqJ1uCHyGnzQ=;
        b=ZRCsY60m3O1DoCxAyiYTT/OhPCKGKipeuM7ep/URmLBcGdFEOBgvHBhtnOWsnA0lM8
         eCBuWoY50eJdA7a2jIlN6KjpNTAagCRL7pEOdJ3DgMkRwNJvnIBsePnIlCcmtlf1TYPg
         L5Ck36TxjlSxxAYPjQVs86dgKcCRB7NRBA7QzVPs2V2Jq8NwnBeAzAdKkORadh5K2QQc
         3EqUyeAwUntw1GEeDgm0cyOIAmbSZA8JdVh6livCO1TWyIR9iNaGSrrLEuFEwNWEQovI
         JGVB6LzkZ7Xn4PuVYXI1tzFzfBwVy8+P7mOEzlti6NtnBV9q1osUDPZ8pkiUs8sLtTkv
         3S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zcXM3TjuUtOj4GCOwvh2CNZQLLNcr9SIqJ1uCHyGnzQ=;
        b=IaGXVlqcdBoyDjyVNyJbcctx6LzxgkSURG27jRMwzf5o+vwxmLDiyrU1XGzJziwVeP
         F5kz1JZ/VMNlISQ4BxOnBPmKL/z8u6DgDO3XT1gzYiUCsRc8Jl1IILTZecew/BkjFviL
         HnN9rdEyh9BH+gaiDCjHfvpZoi9u9Zey9mo7bBzZftjp1jfvryVg3BTBb1ZqY8wIhFzp
         R4B63Y7SVl3yn6Pgc3DZ5h2G2SeivLRnmHNDhVyWpdwFlk4l9qZyeDO6wlKimSeOkG9X
         AlLy8qBXLZoIy/QN7OlQSbbLMixPj4DkjsV1MxBjS9+2eUYKKuqDvYFGgDX6CbjDE6Yf
         bk7Q==
X-Gm-Message-State: AOAM530dvOpDVdgGZutqat/rs/IWx5AOfsyJ/1PC2gEvpovryaXztTLf
        T03QkHaF9IET8/y4CQSUe4jCy5vhVsUPWjnWZn4aNfvL
X-Google-Smtp-Source: ABdhPJyQSBSumA6Wuio9X/fDU4xXui32sv+wGxEdv1KzXNVzqAmIbScZIi0SFdh8KXZvV6Sqjn8p2kZUOT1EL6n29gk=
X-Received: by 2002:a05:6902:13c2:b0:641:b6d:a151 with SMTP id
 y2-20020a05690213c200b006410b6da151mr14556563ybu.348.1652125489423; Mon, 09
 May 2022 12:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-4-joannelkoong@gmail.com> <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 12:44:38 -0700
Message-ID: <CAJnrk1YsJATpAc5X83FOD=t7ijrTTBFrxN6HphBJJO2Hnhghsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Dynptr support for ring buffers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 6, 2022 at 4:41 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> > Currently, our only way of writing dynamically-sized data into a ring
> > buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> > cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> > memcpy, but it can only safely support reservation sizes that are
> > statically known since the verifier cannot guarantee that the bpf
> > program won=E2=80=99t access memory outside the reserved space.
> >
> > The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> > reservations without the extra memcpy.
> >
> > There are 3 new APIs:
> >
> > long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, str=
uct bpf_dynptr *ptr);
> > void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> > void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
> >
> > These closely follow the functionalities of the original ringbuf APIs.
> > For example, all ringbuffer dynptrs that have been reserved must be
> > either submitted or discarded before the program exits.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> Looks great! Modulo those four underscores, they are super confusing...
>
> >  include/linux/bpf.h            | 10 ++++-
> >  include/uapi/linux/bpf.h       | 35 +++++++++++++++++
> >  kernel/bpf/helpers.c           |  6 +++
> >  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c          | 18 +++++++--
> >  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
> >  6 files changed, 171 insertions(+), 4 deletions(-)
> >
[...]
> >
>
> [...]
>
> > + *
> > + * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
> > + *     Description
> > + *             Discard reserved ring buffer sample through the dynptr
> > + *             interface. This is a no-op if the dynptr is invalid/nul=
l.
> > + *
> > + *             For more information on *flags*, please see
> > + *             'bpf_ringbuf_discard'.
> > + *     Return
> > + *             Nothing. Always succeeds.
> >   */
>
> let's also add bpf_dynptr_is_null() (or bpf_dynptr_is_valid(), not
> sure which one is more appropriate, probably just null one), so we can
> check in code whether some reservation was successful without knowing
> bpf_ringbuf_reserve_dynptr()'s return value
I'm planning to add bpf_dynptr_is_null() in the 3rd dynptr patchset
(convenience helpers). Do you prefer that this be part of this
patchset instead? If so, do you think this should be part of the 2nd
patch (aka the one where we set up the infra for dynptrs + implement
malloc-type dynptrs) or this ringbuf patch or its own patch?
>
>
[...]
> [...]
