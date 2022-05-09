Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BF520644
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiEIVDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiEIVDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 17:03:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C12B8D27
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 13:59:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h85so16640528iof.12
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c3QtZU83+/JsZrCD2B2hIAtkYg/rEHZr7ucoqHecbEs=;
        b=iqzhfCDy6r4U5w8YK8z4f+mg8IOJEophTKTPg+RRIiqxLhjrPc0+faDcPhATSg1eI3
         5amyZPmGaWvXRYsxh25v1jbDX1DB240QA+qNFuMwgVyoADdhERq7eNJvVWq/hGme0obU
         w7BPBh3MU8ySUU3M83dqmH1eo6/DvgM2ts65nZoy9g0Uq+4u3ksi1HLb0NVYBBJCx19e
         RQOv8DY4Gbkkqekf0+liPL4Zvh/3A/hJt3EG39UKEcwQTiFUeW00rbVvXeGQ3LW68x1Y
         J3pVNFg+T9Cps7Zs7aa0wX1zcDo9MdO8aQr3DlhSrd5uPDeVUWYprfWNnfJvNsW+bnA7
         HtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c3QtZU83+/JsZrCD2B2hIAtkYg/rEHZr7ucoqHecbEs=;
        b=VQVZS7QO1dKamQMPyYro+iYrx8Zj7cdcAwvsZwY0dNogP1JkvzhOgV6oSYvr+WvZ7n
         +62mm5lCfC4L1pCs66XUZ12Ulo7BfhL/xrRzY4GIcT//Rb7w2rypaJ0vo6m7w0nc33Zg
         bn4aOsBiL7OgXpmpNQhKHyAvbjlKQQMBdVqKOhZy/h7Y2qcc0LheuMw/oxRe23HWNU/E
         wXN6K+punscbejrjof6TpezjTO2dwAs7HbpQtBVLN725TGDHEf/aKJms5R0QI1mg6xQb
         Le7FuyOQF8mpwlUne6HXmDsdGAR5IzTjFf9ucpoYfxgDOjIqKwM7lAmEMK35qNstq2LU
         X14w==
X-Gm-Message-State: AOAM531Z4NCkcof23OrnWRcrvph/EQFQrlo8PE8Jfve8fbMcdvhpNVQr
        r7Dg8Qe05EI/MelhhszH4WZTVpRXQd/Ubsic5dIgXb42
X-Google-Smtp-Source: ABdhPJyML93r9RxhW4osIEhtr4yQhVRI35HGXU5BDJqy2AYWZxYKqaO5Ys+GorHf5DdM9SUY+KVExoyY+khk60+xgc4=
X-Received: by 2002:a05:6638:468e:b0:32b:fe5f:d73f with SMTP id
 bq14-20020a056638468e00b0032bfe5fd73fmr3441969jab.234.1652129944276; Mon, 09
 May 2022 13:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-4-joannelkoong@gmail.com> <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
 <CAJnrk1YsJATpAc5X83FOD=t7ijrTTBFrxN6HphBJJO2Hnhghsw@mail.gmail.com>
 <CAEf4Bzb5bLe+WZgXt2a0qN369DwDOs9PQX5SMS-=Hnf_g1CcqQ@mail.gmail.com> <CAJnrk1aCVLJnr4i3LNA9F6oBAYpXoNhv-wcZMu1zONyUSgZLgw@mail.gmail.com>
In-Reply-To: <CAJnrk1aCVLJnr4i3LNA9F6oBAYpXoNhv-wcZMu1zONyUSgZLgw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 13:58:53 -0700
Message-ID: <CAEf4BzYBSSN6cKSOSMXg7iu9Qc10LuQkaauKVhdN39ydwkyenA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Dynptr support for ring buffers
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Mon, May 9, 2022 at 1:35 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, May 9, 2022 at 1:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 9, 2022 at 12:44 PM Joanne Koong <joannelkoong@gmail.com> w=
rote:
> > >
> > > On Fri, May 6, 2022 at 4:41 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
> > > > >
> > > > > Currently, our only way of writing dynamically-sized data into a =
ring
> > > > > buffer is through bpf_ringbuf_output but this incurs an extra mem=
cpy
> > > > > cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> > > > > memcpy, but it can only safely support reservation sizes that are
> > > > > statically known since the verifier cannot guarantee that the bpf
> > > > > program won=E2=80=99t access memory outside the reserved space.
> > > > >
> > > > > The bpf_dynptr abstraction allows for dynamically-sized ring buff=
er
> > > > > reservations without the extra memcpy.
> > > > >
> > > > > There are 3 new APIs:
> > > > >
> > > > > long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flag=
s, struct bpf_dynptr *ptr);
> > > > > void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)=
;
> > > > > void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags=
);
> > > > >
> > > > > These closely follow the functionalities of the original ringbuf =
APIs.
> > > > > For example, all ringbuffer dynptrs that have been reserved must =
be
> > > > > either submitted or discarded before the program exits.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > >
> > > > Looks great! Modulo those four underscores, they are super confusin=
g...
> > > >
> > > > >  include/linux/bpf.h            | 10 ++++-
> > > > >  include/uapi/linux/bpf.h       | 35 +++++++++++++++++
> > > > >  kernel/bpf/helpers.c           |  6 +++
> > > > >  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++=
++++++
> > > > >  kernel/bpf/verifier.c          | 18 +++++++--
> > > > >  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
> > > > >  6 files changed, 171 insertions(+), 4 deletions(-)
> > > > >
> > > [...]
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > + *
> > > > > + * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 f=
lags)
> > > > > + *     Description
> > > > > + *             Discard reserved ring buffer sample through the d=
ynptr
> > > > > + *             interface. This is a no-op if the dynptr is inval=
id/null.
> > > > > + *
> > > > > + *             For more information on *flags*, please see
> > > > > + *             'bpf_ringbuf_discard'.
> > > > > + *     Return
> > > > > + *             Nothing. Always succeeds.
> > > > >   */
> > > >
> > > > let's also add bpf_dynptr_is_null() (or bpf_dynptr_is_valid(), not
> > > > sure which one is more appropriate, probably just null one), so we =
can
> > > > check in code whether some reservation was successful without knowi=
ng
> > > > bpf_ringbuf_reserve_dynptr()'s return value
> > > I'm planning to add bpf_dynptr_is_null() in the 3rd dynptr patchset
> > > (convenience helpers). Do you prefer that this be part of this
> > > patchset instead? If so, do you think this should be part of the 2nd
> > > patch (aka the one where we set up the infra for dynptrs + implement
> > > malloc-type dynptrs) or this ringbuf patch or its own patch?
> >
> > No problem adding it in a follow up patch.
> >
> > BTW, is it still in the plan to be able to create bpf_dynptr() from
> > map_value, global variables, etc? I.e., it's a LOCAL dynptr except
> > memory is not on STACK.
> >
> > Something like
> >
> > int k =3D 123;
> > struct my_val *v;
> > struct bpf_dynptr p;
> >
> > v =3D bpf_map_lookup_elem(&my_map, &k);
> > if (!v) return 0;
> >
> > bpf_dynptr_from_mem(&v->my_data, &p);
> >
> > /* p points inside my_map's value */
> >
> > ?
> The plan is to still support some types of local dynptrs (eg dynptr to
> ctx skbuf / xdp data). If it would be useful to also have this for
> map_value, we can add this as well (the RCU protects against the map
> value being freed out from under the dynptr, I believe).

Yep, I think it's useful and should be pretty straightforward (there
are no self-referential issues as with PTR_TO_STACK).

> >
> >
> > > >
> > > >
> > > [...]
> > > > [...]
