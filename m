Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F75A71EC
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiH3Xhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiH3Xhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:37:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF7A985AC
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:36:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lx1so25154614ejb.12
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tIchzgyANM6oGuAKOSt1Qwl828aR6BTz2lPYyeaHDdk=;
        b=k77IwLCXAaJ3tc62d/0vn1k7T30gecuW9omfPu1CcxxxtIzagt6/DrHdLMIZv5HrdG
         hzcbyOfDCg5ettpXSuNsLLLxUrZvCaB+7/0LdhKttkvcMV9wzxsb5+cCTqS4ot6hberS
         FmKIrEjDl9AZZ/7nEGUv54O1eWrB13fhu4mcyDCjvSpZYTtWFHVvrHAhRDr1oXVJyCOD
         Wzscxw1FDy3Juk2DHLxluMf/9ZThrMnb+gMKqMG40265LKfinmV2/S72V5daW9h38PWl
         KOHjRe64fOr2v7EmWB9+FEIKtc1+Zq9+/dC2MwTKn+EupuN0hluAJbEUEfLUbaKhmGhF
         x90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tIchzgyANM6oGuAKOSt1Qwl828aR6BTz2lPYyeaHDdk=;
        b=X6et10KW/7XiXB3TmhkUWcLLp7kVWKr9wA467zIUW2Jpq0E6tYwRM6oeYTEHwhdYqt
         +51Fn4PVqhJSnTq1Vg/vsKADJZxj1YHWfLzJAo2Q1me+29TeaVN/E0Ll1MfsKJxooiFr
         6DH8ntJA5UtZHUN+Y5a7+OWL6mWxXf3GJCGFJ9GFkEwB/58+3WDBQrc8U7D+bEz2kHP8
         U1Stw7D82/h/l4pREv+yb3I+/nBFOzQ+RAqrFjIgI5j25q85Ry1GYJELlY/H6OUMNDBt
         ofrPIxfJYA2kOj/ukD2dOIWXHwKYUd0q0R+XbAaYl1LHCX1+nvKYGNs8GbjNCstLJ32d
         TTXw==
X-Gm-Message-State: ACgBeo2g4RWGOQxIhHeyNAxfemhztx+d5cYUwsmXmVcBhxF8ziYWn1lm
        tteemnum0MGUk/K/3j5KXfPkdJhoiNNgdSG36jQ=
X-Google-Smtp-Source: AA6agR5e7yZowP2zp5ljclNL6Wh1N7vCmu4qzjzcW1y6fZCf/mm89YPMtB0ZV58u2oSbxPpT+7QQmd8BSNtvD33Iboo=
X-Received: by 2002:a17:907:3f15:b0:741:7ab9:1c5a with SMTP id
 hq21-20020a1709073f1500b007417ab91c5amr8858155ejc.369.1661902569344; Tue, 30
 Aug 2022 16:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
 <20220824044117.137658-3-shmulik.ladkani@gmail.com> <CAEf4BzZKts8NckT7L-FWBRWJxAgkHEZoR=wjaKBxYpTD_jjyAg@mail.gmail.com>
 <20220830230257.67468080@blondie> <20220830231349.46c49c50@blondie>
In-Reply-To: <20220830231349.46c49c50@blondie>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 30 Aug 2022 16:35:58 -0700
Message-ID: <CAJnrk1Y6DKScdNhkPm8QLFRnkdmUGF4Ao9dqPDtwSfV+CP-xEg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
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

On Tue, Aug 30, 2022 at 1:13 PM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> On Tue, 30 Aug 2022 23:02:57 +0300
> Shmulik Ladkani <shmulik@metanetworks.com> wrote:
>
> > On Thu, 25 Aug 2022 11:20:31 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > > + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)
> > >
> > > why can't we rely on dynptr's len instead of specifying extra one
> > > here? dynptr is a range of memory, so just specify that you take that
> > > entire range?
> > >
> > > And then we'll have (or partially already have) generic dynptr helpers
> > > to adjust internal dynptr offset and len.
> >
> > Alright.
> >
> > For my usecase I need to use *part* of the tunnel options that were
> > previously stored as a dynptr.
> >
> > Therefore I need to introduce a new bpf helper that adjusts the dynptr.
> >
> > How about this suggestion (sketch, not yet tried):
> >
> > // adjusts the dynptr to point to *len* bytes starting from the
> > // specified *offset*
> >
> > BPF_CALL_3(bpf_dynptr_slice, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> > {
> >       int err;
> >         u32 size;
> >
> >       if (!ptr->data)
> >               return -EINVAL;
> >
> >       err = bpf_dynptr_check_off_len(ptr, offset, len);
> >       if (err)
> >               return err;
> >
> >       ptr->offset += offset;
> >       size = bpf_dynptr_get_size(ptr) - len;
> >       ptr->size = (ptr->size & ~(u32)DYNPTR_SIZE_MASK) | size;
> >       return 0;
> > }
> >
>
> Correction, meant:
>         ptr->offset += offset;
>         ptr->size = (ptr->size & ~(u32)DYNPTR_SIZE_MASK) | len;
>

I have a patchset for dynptr convenience helpers that I plan to tidy
up and push out later this week or mid-next week. it includes
"bpf_dynptr_advance()" and "bpf_dynptr_trim()", which will let you
adjust the dynptr ("_advance()" advances the offset, "_trim()" trims
the size)
