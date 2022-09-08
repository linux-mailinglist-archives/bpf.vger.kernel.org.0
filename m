Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0405B1163
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIHAkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIHAkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:40:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB6371B3
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:40:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 10so12882716iou.2
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=drpZMKJ3oj/6bgJ0jjLNtGb86Stq9SsWCxKtEG2l4H4=;
        b=Gl2ntdmiOLHXO9O4XFB7rolr9J6oAJnokSzPRFjqwQo1vwtLMgwICHfByybYhAf6Oh
         S4hZQJPY33cm32aoKx0WYdWu6I0geIf6m1tR3z5m55ym9sBlJ21SlBTazAgMbQOKugOK
         UZv56UvKkoOer9ChH6GcmtEWD0weBjngYGE7Y0AsFJRV6KqMXCjtewa7ugP/p49btOMO
         8gJjUq+znuNbHiucLbn5JphomImrwqLodPHnk8XL1Moxsf6h9GgngCPGplB6Q06xKsHW
         ORXE1fNLUfhsehLA0sUc/h5AnyJkJpjsCZ+PWESlFwKrCSdHdFXQEAcBj/k9WceAjwaT
         mHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=drpZMKJ3oj/6bgJ0jjLNtGb86Stq9SsWCxKtEG2l4H4=;
        b=p+XNl+WkQ6UHortvFmBCikw1TlDUFweFNHnl+NGD8owfDy9dmXdmA+4oKMibjGX/R0
         M2zTV92kGxoSLGQwBBe7dat5hpYHPOPj1V+jvLSFulv7kjylf2slcbQoiVrxbhuTGoQ7
         D08AJooLWFAhez0DwSN9X++i51U0ys0W8+eOc88gvVsnx0ZrKI8AXTu0HG9+1qkbhS6w
         qx6nxxpEAegJyoqjq3r9SvZxDlOfxqDwvVkIxyEwpRqAPnBfsyLZQnVoBEx5k5W9QXOZ
         Psl4vr/2Ir5nYywfjGEJH130QDJY8ObXJZZv40kK8eWfQ1UF06XxBpQ4C5aCL5pww1CK
         3ZGw==
X-Gm-Message-State: ACgBeo3DWxtgsGms6To3WWjr2XuKHfB6oHSjsiNxOQtA8RANXW4txoF3
        Rrj9pc0chSahxrBCG1lvJoHqP7MLm+Tog/8NPJ0=
X-Google-Smtp-Source: AA6agR541mHChD6LS+Nm/K8ntUo6IqxHWOH5jhPnp6GPlfu5cQ6hshY6Hf6PiZum4+zyo2lCuGsqbiTEqBbX3NlV0jo=
X-Received: by 2002:a05:6638:16cf:b0:34a:263f:966d with SMTP id
 g15-20020a05663816cf00b0034a263f966dmr3362655jat.124.1662597622256; Wed, 07
 Sep 2022 17:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 02:39:46 +0200
Message-ID: <CAP01T75bEtRU4FC9ipqP+uQ_zo8qmOX=TkykzAb2bycN3f=xLg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
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

On Thu, 8 Sept 2022 at 02:27, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Global variables reside in maps accessible using direct_value_addr
> > callbacks, so giving each load instruction's rewrite a unique reg->id
> > disallows us from holding locks which are global.
> >
> > This is not great, so refactor the active_spin_lock into two separate
> > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > enough to allow it for global variables, map lookups, and local kptr
> > registers at the same time.
> >
> > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > lock. But the active_spin_lock_id also needs to be compared to ensure
> > whether bpf_spin_unlock is for the same register.
> >
> > Next, pseudo load instructions are not given a unique reg->id, as they
> > are doing lookup for the same map value (max_entries is never greater
> > than 1).
> >
> > Essentially, we consider that the tuple of (active_spin_lock_ptr,
> > active_spin_lock_id) will always be unique for any kind of argument to
> > bpf_spin_{lock,unlock}.
> >
> > Note that this can be extended in the future to also remember offset
> > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > in the same allocation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  3 ++-
> >  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
> >  2 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 2a9dcefca3b6..00c21ad6f61c 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -348,7 +348,8 @@ struct bpf_verifier_state {
> >       u32 branches;
> >       u32 insn_idx;
> >       u32 curframe;
> > -     u32 active_spin_lock;
> > +     void *active_spin_lock_ptr;
> > +     u32 active_spin_lock_id;
>
> {map, id=0} is indeed enough to distinguish different global locks and
> {map, id} for locks in map values,
> but what 'btf' is for?
> When is the case when reg->map_ptr is not set?
> locks in allocated objects?
> Feels too early to add that in this patch.
>
> Also this patch is heavily influenced by Dave's patch with
> a realization that max_entries==1 simplifies the logic.

You mean this one?
https://lore.kernel.org/bpf/20220830172759.4069786-12-davemarchevsky@fb.com

> I think you gotta give him more credit.
> Maybe as much as his SOB and authorship.
>

Don't mind sharing the credit where due, but for the record:

15/8: pushed my prototype:
https://github.com/kkdwivedi/linux/commits/bpf-list-15-08-22
15/8: patch with roughly the same logic as above, comitted 24 days ago
https://github.com/kkdwivedi/linux/commit/4a152df6a1f6e096616e02c9b4dd54c5d5c902a1
16/8: Our meeting, described the same idea to you.
17/8: Published notes,
https://lore.kernel.org/bpf/CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com
19/8: Described the same thing in detail again in response to Dave's question:
> This ergonomics idea doesn't solve the map-in-map issue, I'm still unsure
> how to statically verify lock in that case. Have you had a chance to think
> about it further?
>
at https://lore.kernel.org/bpf/CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com
30/8: Dave sends patch with this idea:
https://lore.kernel.org/bpf/20220830172759.4069786-11-davemarchevsky@fb.com

What did I miss?
