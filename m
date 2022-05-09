Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2E5205F6
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiEIUjm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 16:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEIUjl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 16:39:41 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C21C906
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 13:35:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r1so401872ybo.7
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QuunDNM/4InCFok5yPhCgzjjvLeU3O++C2lQC+oKLI=;
        b=PeiIqBovEVt7OtPo6TRAhUv/6YLpC83XW2njGuj912JXI4+PA+g7LFLTkDR+Vh4DW4
         wPmxJlDM9GjTl9BEo5tDeukIEQ1eAxfsDbpZ1ag1KwAg5Sr7T5hRYRXXN9AIDlYvogfp
         Av6ULcblJiiJ4oD/gR0mRzh7BKyx/ssU8m7bnADkl0QRbdU37Pxa1JKVQkrNudhUvDuK
         d9wH35ib5aNzLs1RyLr02FAmynext+Z5FZJxeoswSYPbHzCedlEhzaD2Nbw5bNYmy0Zx
         iv54epkc4unkAYsBXS4eMzA1ue5tS1GPbELMiwVru2fQoucjCNPWqMafZbf5zdXCIrf9
         BUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QuunDNM/4InCFok5yPhCgzjjvLeU3O++C2lQC+oKLI=;
        b=Uu3QnJvQXP8c74E13jt3gsxMr8jZMAXr5XpTBkt6I5K7dy5RphXbjmS0CT/z5wLJh1
         EYFrpOyjsvyjVb8fPSJ3ifPa7MkLdDcc2ggFamI3Mk9QnE23N9vMA/pJZ4e4lcsogND9
         tVxLpnrW6ybOfqlsYHOFmkfjVE7CIFcOOsBAQdqC59i5A9Ho5QJjtW/QtK6S7UJ5uRYU
         KUa0DI6BCaRg0f3GMSVjLnEa67KT+38zIRvqqJSRZwn/RtyEsw0UKsHuSeELb5s0vk0/
         sJhHu8n5R0YMaBJGpIxq5YgJOQWfx6e/QqlfheKhT+VWuS7s2J1/NIOuAZ1hGUAC0h67
         n03A==
X-Gm-Message-State: AOAM530ZXZmG39SduHKJzpIhAkVdHVEP80eK8a2pdOAd2SeBHB3TcD9z
        YyOoonuUKWIAaKTf3GXH84KYlhYN5my5hT5nwqQ=
X-Google-Smtp-Source: ABdhPJwrxLagIu/BeKzDmyaK4b5WOoeRbpHSPkDFPjne6wmiZnepTWckH+o8BGUYLGDrhufGzhsdVgZiDfKcYe+qNZY=
X-Received: by 2002:a25:5f4f:0:b0:645:da4e:648c with SMTP id
 h15-20020a255f4f000000b00645da4e648cmr15058754ybm.523.1652128544757; Mon, 09
 May 2022 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-4-joannelkoong@gmail.com> <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
 <CAJnrk1YsJATpAc5X83FOD=t7ijrTTBFrxN6HphBJJO2Hnhghsw@mail.gmail.com> <CAEf4Bzb5bLe+WZgXt2a0qN369DwDOs9PQX5SMS-=Hnf_g1CcqQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5bLe+WZgXt2a0qN369DwDOs9PQX5SMS-=Hnf_g1CcqQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 13:35:33 -0700
Message-ID: <CAJnrk1aCVLJnr4i3LNA9F6oBAYpXoNhv-wcZMu1zONyUSgZLgw@mail.gmail.com>
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

On Mon, May 9, 2022 at 1:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 9, 2022 at 12:44 PM Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> > On Fri, May 6, 2022 at 4:41 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com>=
 wrote:
> > > >
> > > > Currently, our only way of writing dynamically-sized data into a ri=
ng
> > > > buffer is through bpf_ringbuf_output but this incurs an extra memcp=
y
> > > > cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> > > > memcpy, but it can only safely support reservation sizes that are
> > > > statically known since the verifier cannot guarantee that the bpf
> > > > program won=E2=80=99t access memory outside the reserved space.
> > > >
> > > > The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> > > > reservations without the extra memcpy.
> > > >
> > > > There are 3 new APIs:
> > > >
> > > > long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags,=
 struct bpf_dynptr *ptr);
> > > > void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> > > > void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
> > > >
> > > > These closely follow the functionalities of the original ringbuf AP=
Is.
> > > > For example, all ringbuffer dynptrs that have been reserved must be
> > > > either submitted or discarded before the program exits.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > >
> > > Looks great! Modulo those four underscores, they are super confusing.=
..
> > >
> > > >  include/linux/bpf.h            | 10 ++++-
> > > >  include/uapi/linux/bpf.h       | 35 +++++++++++++++++
> > > >  kernel/bpf/helpers.c           |  6 +++
> > > >  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++=
++++
> > > >  kernel/bpf/verifier.c          | 18 +++++++--
> > > >  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
> > > >  6 files changed, 171 insertions(+), 4 deletions(-)
> > > >
> > [...]
> > > >
> > >
> > > [...]
> > >
> > > > + *
> > > > + * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 fla=
gs)
> > > > + *     Description
> > > > + *             Discard reserved ring buffer sample through the dyn=
ptr
> > > > + *             interface. This is a no-op if the dynptr is invalid=
/null.
> > > > + *
> > > > + *             For more information on *flags*, please see
> > > > + *             'bpf_ringbuf_discard'.
> > > > + *     Return
> > > > + *             Nothing. Always succeeds.
> > > >   */
> > >
> > > let's also add bpf_dynptr_is_null() (or bpf_dynptr_is_valid(), not
> > > sure which one is more appropriate, probably just null one), so we ca=
n
> > > check in code whether some reservation was successful without knowing
> > > bpf_ringbuf_reserve_dynptr()'s return value
> > I'm planning to add bpf_dynptr_is_null() in the 3rd dynptr patchset
> > (convenience helpers). Do you prefer that this be part of this
> > patchset instead? If so, do you think this should be part of the 2nd
> > patch (aka the one where we set up the infra for dynptrs + implement
> > malloc-type dynptrs) or this ringbuf patch or its own patch?
>
> No problem adding it in a follow up patch.
>
> BTW, is it still in the plan to be able to create bpf_dynptr() from
> map_value, global variables, etc? I.e., it's a LOCAL dynptr except
> memory is not on STACK.
>
> Something like
>
> int k =3D 123;
> struct my_val *v;
> struct bpf_dynptr p;
>
> v =3D bpf_map_lookup_elem(&my_map, &k);
> if (!v) return 0;
>
> bpf_dynptr_from_mem(&v->my_data, &p);
>
> /* p points inside my_map's value */
>
> ?
The plan is to still support some types of local dynptrs (eg dynptr to
ctx skbuf / xdp data). If it would be useful to also have this for
map_value, we can add this as well (the RCU protects against the map
value being freed out from under the dynptr, I believe).
>
>
> > >
> > >
> > [...]
> > > [...]
