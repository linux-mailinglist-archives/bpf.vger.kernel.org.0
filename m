Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD995205EE
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiEIUgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiEIUgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 16:36:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45C6278
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 13:28:40 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e3so16569047ios.6
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SX9AuhQkVC/ZP2I/0RrKc4kHGWoQjM4T88nk74eutGI=;
        b=hIfIPchtBiOKRryA5ETccxxtl6+uIkhZmPpmRa/C8jmaNgTpDg0FxajEVJwO+umVBr
         I+QYjSwnUiL4MUyUFs+qXG1gxyRI8cdMWUCnGELhKD8FvmvXeVcg9SqP27NDd/ToPvw+
         ZzZXYN+MWGWTXp98H5AzOxMlMdpmeW7RuIiVLLKAa05nRm0I7iFq/hwz/l/h95D28jbN
         u84JGTb0U9e1vnUDt8KX6qB0Lb+uJhPPJf6Em7zXslgyGncB3bW/z6Cu6L6R72BY63Il
         0KouHtGmoehR3aRUauZntHV3NRO8tHGNBU56rcQndDbqjr88AnKybyNkFsItuYeDLUSd
         QhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SX9AuhQkVC/ZP2I/0RrKc4kHGWoQjM4T88nk74eutGI=;
        b=KAr0vBjK0fXC2g2McTPwy1h200fN+2DpcfdiCiLOsV7Dkm+Zw9QCKOqdb9Xacui39k
         Q2E/ULgzMG15TnsCoJY/9rJwCRmyc1JUTfTw6xDGs7gxe47BKyVzLPTXylQxzFkkpJdk
         IjHsLSfuVh5NyhumzdbPP7lWMvW2qmJX1YT5OJL1xdQaJCTMli22z1enxKqccfh1yIWD
         9YQL4FRli3EqyONG0XsuaLFNKVGMxkafh0GsH3mZKDtKnhFx8KHFg4NfJJO+ZkbsybAr
         HgCAl/W6IXantADpaFJULk40aTRyD8JWHpMJkWt4yPTimj1UOCesj90/g7bqAMT8BpCc
         y5gw==
X-Gm-Message-State: AOAM532EZ+akzqGOP54Oan4LxMsgVJ3Z8zNKlLIO3L6wI+MVTy3buG9l
        ZUGDsjJjrKaMH7TW1f25mTmmSrmslPhfAwj3T7w=
X-Google-Smtp-Source: ABdhPJz4xN5yB+hOO/0vOV4ynl0NaKxDlqBbaNfpF95bkdzRtXbRGLk72evjC7qEnAzpn5NbNoGizDOAUmVVVC98bFQ=
X-Received: by 2002:a02:5d47:0:b0:32b:4387:51c8 with SMTP id
 w68-20020a025d47000000b0032b438751c8mr8231750jaa.103.1652128120285; Mon, 09
 May 2022 13:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-4-joannelkoong@gmail.com> <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
 <CAJnrk1YsJATpAc5X83FOD=t7ijrTTBFrxN6HphBJJO2Hnhghsw@mail.gmail.com>
In-Reply-To: <CAJnrk1YsJATpAc5X83FOD=t7ijrTTBFrxN6HphBJJO2Hnhghsw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 13:28:29 -0700
Message-ID: <CAEf4Bzb5bLe+WZgXt2a0qN369DwDOs9PQX5SMS-=Hnf_g1CcqQ@mail.gmail.com>
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

On Mon, May 9, 2022 at 12:44 PM Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> On Fri, May 6, 2022 at 4:41 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> w=
rote:
> > >
> > > Currently, our only way of writing dynamically-sized data into a ring
> > > buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> > > cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> > > memcpy, but it can only safely support reservation sizes that are
> > > statically known since the verifier cannot guarantee that the bpf
> > > program won=E2=80=99t access memory outside the reserved space.
> > >
> > > The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> > > reservations without the extra memcpy.
> > >
> > > There are 3 new APIs:
> > >
> > > long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, s=
truct bpf_dynptr *ptr);
> > > void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> > > void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
> > >
> > > These closely follow the functionalities of the original ringbuf APIs=
.
> > > For example, all ringbuffer dynptrs that have been reserved must be
> > > either submitted or discarded before the program exits.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> >
> > Looks great! Modulo those four underscores, they are super confusing...
> >
> > >  include/linux/bpf.h            | 10 ++++-
> > >  include/uapi/linux/bpf.h       | 35 +++++++++++++++++
> > >  kernel/bpf/helpers.c           |  6 +++
> > >  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++=
++
> > >  kernel/bpf/verifier.c          | 18 +++++++--
> > >  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
> > >  6 files changed, 171 insertions(+), 4 deletions(-)
> > >
> [...]
> > >
> >
> > [...]
> >
> > > + *
> > > + * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags=
)
> > > + *     Description
> > > + *             Discard reserved ring buffer sample through the dynpt=
r
> > > + *             interface. This is a no-op if the dynptr is invalid/n=
ull.
> > > + *
> > > + *             For more information on *flags*, please see
> > > + *             'bpf_ringbuf_discard'.
> > > + *     Return
> > > + *             Nothing. Always succeeds.
> > >   */
> >
> > let's also add bpf_dynptr_is_null() (or bpf_dynptr_is_valid(), not
> > sure which one is more appropriate, probably just null one), so we can
> > check in code whether some reservation was successful without knowing
> > bpf_ringbuf_reserve_dynptr()'s return value
> I'm planning to add bpf_dynptr_is_null() in the 3rd dynptr patchset
> (convenience helpers). Do you prefer that this be part of this
> patchset instead? If so, do you think this should be part of the 2nd
> patch (aka the one where we set up the infra for dynptrs + implement
> malloc-type dynptrs) or this ringbuf patch or its own patch?

No problem adding it in a follow up patch.

BTW, is it still in the plan to be able to create bpf_dynptr() from
map_value, global variables, etc? I.e., it's a LOCAL dynptr except
memory is not on STACK.

Something like

int k =3D 123;
struct my_val *v;
struct bpf_dynptr p;

v =3D bpf_map_lookup_elem(&my_map, &k);
if (!v) return 0;

bpf_dynptr_from_mem(&v->my_data, &p);

/* p points inside my_map's value */

?


> >
> >
> [...]
> > [...]
