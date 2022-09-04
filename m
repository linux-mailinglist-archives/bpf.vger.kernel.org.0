Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A465AC384
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIDJFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDJFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 05:05:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8D42409F
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 02:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F28E3CE0D89
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 09:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402A4C43140
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662282297;
        bh=kfKDkyIqU01AYkJiX6BidqnWA1Al77SJE63rtEC73q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qfavo3H0eYtuE43iUF5ON8dpnAXe2PzN+wRzB9DKkVhnZ5+KP3XaivqXKeUecXhq6
         r8tzM+4y5pgzbVX7VUKr7W21VQ0YuOKBH6/QocmTpw1gVKy2SP3zxhDR+cI4ACrppA
         kuU5JiferoHUJx60Ao4xfZah3NO3QfIVkkNaxuDpZA9961QdXKaCdpx/nXXcnYs09U
         NqUjQcqf3TSabYYc+lxebQZ1jsAUGmuz3/jqh2llzCPj/BiNTjzA+suGU4ObphlhcJ
         MkQ/pBUkWEhd3tGEHP1FT3JRhM4BeXvInWJocQCXoK7LZ6n5UGVLvzUDIEEotD1lpD
         i8yWVvmqciBwg==
Received: by mail-vs1-f44.google.com with SMTP id n125so6199311vsc.5
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 02:04:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2p0mZZMM2kfA7n7NVg4XmQOFLT3BtiovUvQfkmnuiKY+nh8NLB
        6UsvCFVRRRQ8/Owb3HHCIfvjafCBs72XikwPl64=
X-Google-Smtp-Source: AA6agR6am6jCJc6e+LkTa+XZhl7ngd056Z2/EOzAxuBwiXpSx7gfqNbmoIH1kBrtm8PCGUcs347WZe5GQMq9/cDbKgI=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr13238356vsu.43.1662282296178; Sun, 04
 Sep 2022 02:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
 <1661999249-10258-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4yU2tp=DBGCkdSzp-9bAXXDM4+0iqDgOac+fbgQnsx2A@mail.gmail.com> <1a740b5c-041c-85c6-f1d6-bb0b931c0c3e@loongson.cn>
In-Reply-To: <1a740b5c-041c-85c6-f1d6-bb0b931c0c3e@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 4 Sep 2022 17:04:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5vfw+Mv=LbQfa4sPHW91Z+ij3R8+LsHZOAiR+u7pJONw@mail.gmail.com>
Message-ID: <CAAhV-H5vfw+Mv=LbQfa4sPHW91Z+ij3R8+LsHZOAiR+u7pJONw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] LoongArch: Add BPF JIT support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, WANG Xuerui <git@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev, Li Xuefeng <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 3, 2022 at 6:11 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 09/03/2022 04:32 PM, Huacai Chen wrote:
> > On Thu, Sep 1, 2022 at 10:27 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >> BPF programs are normally handled by a BPF interpreter, add BPF JIT
> >> support for LoongArch to allow the kernel to generate native code
> >> when a program is loaded into the kernel, this will significantly
> >> speed-up processing of BPF programs.
>
> [...]
>
> >> +
> >> +static inline int emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> >> +                               enum loongarch_gpr rd, int jmp_offset)
> >> +{
> >> +       /*
> >> +        * A large PC-relative jump offset may overflow the immediate field of
> >> +        * the native conditional branch instruction, triggering a conversion
> >> +        * to use an absolute jump instead, this jump sequence is particularly
> >> +        * nasty. For now, use cond_jmp_offs26() directly to keep it simple.
> >> +        * In the future, maybe we can add support for far branching, the branch
> >> +        * relaxation requires more than two passes to converge, the code seems
> >> +        * too complex to understand, not quite sure whether it is necessary and
> >> +        * worth the extra pain. Anyway, just leave it as it is to enhance code
> >> +        * readability now.
> > Oh, no. I don't think this is a very difficult problem, because the
> > old version has already solved [1]. Please improve your code and send
> > V4.
> > BTW, I have committed V3 with some small modifications in
> > https://github.com/loongson/linux/commits/loongarch-next, please make
> > V4 based on that.
> >
> > [1] https://github.com/loongson/linux/commit/e20b2353f40cd13720996524e1df6d0ca086eeb8#diff-6d2f4f5a862a5dce12f8eb0feeca095825c4ed1c2e7151b0905fb8d03c98922e
> >
> > --------code in the old version--------
> > static inline void emit_cond_jump(struct jit_ctx *ctx, u8 cond, enum
> > loongarch_gpr rj,
> >                                   enum loongarch_gpr rd, int jmp_offset)
> > {
> >         if (is_signed_imm16(jmp_offset))
> >                 cond_jump_offs16(ctx, cond, rj, rd, jmp_offset);
> >         else if (is_signed_imm26(jmp_offset))
> >                 cond_jump_offs26(ctx, cond, rj, rd, jmp_offset);
> >         else
> >                 cond_jump_offs32(ctx, cond, rj, rd, jmp_offset);
> > }
> >
> > static inline void emit_uncond_jump(struct jit_ctx *ctx, int
> > jmp_offset, bool is_exit)
> > {
> >         if (is_signed_imm26(jmp_offset))
> >                 uncond_jump_offs26(ctx, jmp_offset);
> >         else
> >                 uncond_jump_offs32(ctx, jmp_offset, is_exit);
> > }
> > --------end of code--------
> >
> > Huacai
> >
>
> Hi Huacai,
>
> This change is to pass the special test cases:
> "a new type of jump test where the program jumps forwards
> and backwards with increasing offset. It mainly tests JITs where a
> relative jump may generate different JITed code depending on the offset
> size."
>
> They are introduced in commit a7d2e752e520 ("bpf/tests: Add staggered
> JMP and JMP32 tests") after the old internal version you mentioned.
>
> Here, we use the native instructions to enlarge the jump range to 26 bit
> directly rather than 16 bit first, and also take no account of more than
> 26 bit case because there is no native instruction and it needs to emulate.
>
> As the code comment said, this is to enhance code readability now.
I'm not familiar with bpf, Daniel, Ruoyao and Xuerui, what do you
think about it?

Huacai
>
> Thanks,
> Tiezhu
>
