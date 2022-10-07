Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA445F7D9F
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGTIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGTIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 15:08:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AFAD258E
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 12:08:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kg6so13238881ejc.9
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVR14eyhmAVGnf/LRVsDBvXrJRetZuM7P1gFzeochfs=;
        b=nVWYbDv9DeS4jI1g2MnavTpnpNFAArJKjmZ/W/4HA5PRTddW2GSUm9ROCRRxv1Id9e
         ElEPOLiMYB2X4AavvnoJSoAygCJxhHhDlpacx1K4+EaiaVG11Q3eTh0+lQZ/Lc7u5SNQ
         kJ5odyjoQks+/uUDiHrkZi6ii+dGF2E4vPu7TAcSwqHTh0YxyUT4SCqwBeOSlupn+HrE
         MfFr4XM41qqET8Y6t3YoIT5UoPStcYv2Z8yllf8PEYW9jilU6TP/7xquU6nBlctqtAmj
         Rh5eM17Bi9b6yNzDbjOqCrdmn3SPRZ63L+gPIwvRUMz5qqR9HneKqeMPuDJcVudl8wmj
         4/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVR14eyhmAVGnf/LRVsDBvXrJRetZuM7P1gFzeochfs=;
        b=yky5qUTIKBqh9It/3Sde0XwR6xb7k6xgKJQcJLSlbP+JKcrFLMttj3/tK+Lp5ok+Fe
         9hKu/E2QmMNekoa6rPR0uPmlXTf1ek4rHTuRaUzPtaDhsOoo0pI2PWJgIopyMPOglM1q
         uNj0IPiwMwfRjIYMYG9B69rZVpVeBEqky445Pxk+CX4m9Vt01YXnsmX82ma8nsVq0EzI
         P+fHUQXicIJf8Zq+mY/5jLR0ofWGW36J1ukwUDAXbTuER68S+RNcviiXEAIgi12ZngAB
         oouCY4cD57pYDBKaQPdBGJG+KPHO0eOuaHZjmjX16PGfqMLyDY3PUAF2ChCXgkx5c2D2
         AP0g==
X-Gm-Message-State: ACrzQf2zsZha9MMr1ce2HdDJCAllm+I7vBHJIMUnSMolqxSilN6I/ina
        j2kmrOFhmFGYwTQu37+/vntAxE7PPVvzvWLe2lM=
X-Google-Smtp-Source: AMsMyM4bc+AwwCLdXmP+tmXMeOMY9JLAC6MuSF0mcKeoDbZcwPoymd/COyrw8S+M4qURlx65f5snCQVoNRjprihNC4I=
X-Received: by 2002:a17:907:72c4:b0:78a:ea03:a9d8 with SMTP id
 du4-20020a17090772c400b0078aea03a9d8mr5231784ejc.327.1665169727394; Fri, 07
 Oct 2022 12:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221005141309.31758-1-fw@strlen.de> <20221005141309.31758-7-fw@strlen.de>
 <20221006025209.rx4xnwdduqypja4b@macbook-pro-4.dhcp.thefacebook.com> <20221007114543.GA4296@breakpoint.cc>
In-Reply-To: <20221007114543.GA4296@breakpoint.cc>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Oct 2022 12:08:36 -0700
Message-ID: <CAADnVQLSwX4gCK62KT_qEuPwagn4B9SMOBrLBcLh+2PFxypxqw@mail.gmail.com>
Subject: Re: [RFC v2 6/9] netfilter: add bpf base hook program generator
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 7, 2022 at 4:45 AM Florian Westphal <fw@strlen.de> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > +   if (!emit(p, BPF_STX_MEM(BPF_H, BPF_REG_6, BPF_REG_8,
> > > +                            offsetof(struct nf_hook_state, hook_index))))
> > > +           return false;
> > > +   /* arg2: struct nf_hook_state * */
> > > +   if (!emit(p, BPF_MOV64_REG(BPF_REG_2, BPF_REG_6)))
> > > +           return false;
> > > +   /* arg3: original hook return value: (NUM << NF_VERDICT_QBITS | NF_QUEUE) */
> > > +   if (!emit(p, BPF_MOV32_REG(BPF_REG_3, BPF_REG_0)))
> > > +           return false;
> > > +   if (!emit(p, BPF_EMIT_CALL(nf_queue)))
> > > +           return false;
> >
> > here and other CALL work by accident on x84-64.
> > You need to wrap them with BPF_CALL_ and point BPF_EMIT_CALL to that wrapper.
>
> Do you mean this? :
>
> BPF_CALL_3(nf_queue_bpf, struct sk_buff *, skb, struct nf_hook_state *,
>            state, unsigned int, verdict)
> {
>      return nf_queue(skb, state, verdict);
> }

yep.

>
> -       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow)))
> +       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow_bpf)))
>
> ?
>
> If yes, I don't see how this will work for the case where I only have an
> address, i.e.:
>
> if (!emit(p, BPF_EMIT_CALL(h->hook))) ....
>
> (Also, the address might be in a kernel module)
>
> > On x86-64 it will be a nop.
> > On x86-32 it will do quite a bit of work.
>
> If this only a problem for 32bit arches, I could also make this
> 'depends on CONFIG_64BIT'.

If that's acceptable, sure.

> But perhaps I am on the wrong track, I see existing code doing:
>         *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);

Yes, because we do:
                /* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
                 * and other inlining handlers are currently limited to 64 bit
                 * only.
                 */
                if (prog->jit_requested && BITS_PER_LONG == 64 &&


I think you already gate this feature with jit_requested?
Otherwise it's going to be slow in the interpreter.

> (kernel/bpf/hashtab.c).
>
> > > +   prog = bpf_prog_select_runtime(prog, &err);
> > > +   if (err) {
> > > +           bpf_prog_free(prog);
> > > +           return NULL;
> > > +   }
> >
> > Would be good to do bpf_prog_alloc_id() so it can be seen in
> > bpftool prog show.
>
> Thanks a lot for the hint:
>
> 39: unspec  tag 0000000000000000
> xlated 416B  jited 221B  memlock 4096B

Probably should do bpf_prog_calc_tag() too.
And please give it some meaningful name.

> bpftool prog  dump xlated id 39
>    0: (bf) r6 = r1
>    1: (79) r7 = *(u64 *)(r1 +8)
>    2: (b4) w8 = 0
>    3: (85) call ipv6_defrag#526144928
>    4: (55) if r0 != 0x1 goto pc+24
>    5: (bf) r1 = r6
>    6: (04) w8 += 1
>    7: (85) call ipv6_conntrack_in#526206096
>    [..]

Nice.
bpftool prog profile
should work too.
