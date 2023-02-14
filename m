Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5569682D
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBNPgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBNPgY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 10:36:24 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19D4231
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 07:36:23 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-16e353ce458so1938382fac.9
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m1D2RWhLhHxsdFzivabikU8ZEQlDesftIUFBoVoaEws=;
        b=KaSeq2tWYKYTua21H7tKdDViD7rR4+2NfwLa6dZGIC1lyN1Xu2d7hpnDPXgOm/83Gf
         JQB7JFIKbb4qX7R4Fi33GZY7id/B9WOoTX5f5JvKXB4gN9lt+kC/Jj7jFtz0gQahVUuH
         2UM09EKRkFzdDZnLMovvJboyFIoghvIp+l/DAiL3h8cBC/duErxySMvoU7aNd5JyAn7w
         d9uovJPirwdy8IcqcN+0hhQn816XPX4tmpUiphWiekU1GxsKjYkhSr15d09uLHdtwcYW
         resel0YqqhUYgJ1fKyt9CCHXJYF8Bs4OHuOyd1ssfLUNfZIfPvlYcR09gCAYrQQGibMB
         xkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1D2RWhLhHxsdFzivabikU8ZEQlDesftIUFBoVoaEws=;
        b=M0FV/WIdS4K/Rz8WfdKJU49Ta8k+wjcQ/PbUfR+us+hPR2rKiGID4mc8odbRE6V1EY
         Fnx9Cz6Q51tM62swGUfbGf69tVv7N/CixTcYTpJgVTNiajJXAw2Wr4OnD6p6VQoR/UOu
         Ebn2Uk22S2N2RGSG8ewZXBwe+gQb8RfwjnZSC9LzHxmrNE05NnuJ8tiAW4ww0Yv7HyPa
         iI0+v4efABRJrxZLFN8vBemgOozK4f66SWAaeO4YXAXK/THE+C7amwHyZnXFHOOA6wmJ
         bSZPQW+hcwi7JsC6WvCbMrsiSlsQvVvyTdn/5oxzqc5ww9DEGWsHDGAKyvxRSO4NjMzK
         smhw==
X-Gm-Message-State: AO0yUKX5lj9LqUAIeHR+sTwQ8pWVqAGWuv7NzgEPegP2IUI8blo7wSRz
        6oXragWg3XB9YE/vmnDRqHczA5I8/bqLk+y+ybwirC7B
X-Google-Smtp-Source: AK7set/QXywFK2CgflsnTo1Mkt4Mi+/aZpDU+kj66GQyOF37Y2xnTMjQIiQKdBC6pmiOdUWkBq1z1JN19bkISIZ+Fq8=
X-Received: by 2002:a05:6871:29b:b0:16e:143e:86bf with SMTP id
 i27-20020a056871029b00b0016e143e86bfmr518753oae.197.1676388982644; Tue, 14
 Feb 2023 07:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20230212035236.1436532-1-hengqi.chen@gmail.com>
 <20230212035236.1436532-2-hengqi.chen@gmail.com> <07edfd3b-9895-f711-47a7-a805a4e92691@loongson.cn>
In-Reply-To: <07edfd3b-9895-f711-47a7-a805a4e92691@loongson.cn>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Date:   Tue, 14 Feb 2023 23:36:11 +0800
Message-ID: <CAEyhmHRJgX-20QE4AxGHgLKsvvbjdTY0didrrX7XPoS3Rc6e5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: BPF: Treat function address as 64-bit value
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
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

Hi Tiezhu,

On Mon, Feb 13, 2023 at 11:02 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Hi Hengqi,
>
> On 02/12/2023 11:52 AM, Hengqi Chen wrote:
> > Let's always use 4 instructions for function address in JIT.
> > So that the instruction sequences don't change between the first
> > pass and the extra pass for function calls.
> >
> > Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index c4b1947ebf76..2d952110be72 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -446,6 +446,27 @@ static int add_exception_handler(const struct bpf_insn *insn,
> >       return 0;
> >  }
> >
> > +static inline void emit_addr_move(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 addr)
> > +{
> > +     u64 imm_11_0, imm_31_12, imm_51_32, imm_63_52;
> > +
> > +     /* lu12iw rd, imm_31_12 */
> > +     imm_31_12 = (addr >> 12) & 0xfffff;
> > +     emit_insn(ctx, lu12iw, rd, imm_31_12);
> > +
> > +     /* ori rd, rd, imm_11_0 */
> > +     imm_11_0 = addr & 0xfff;
> > +     emit_insn(ctx, ori, rd, rd, imm_11_0);
> > +
> > +     /* lu32id rd, imm_51_32 */
> > +     imm_51_32 = (addr >> 32) & 0xfffff;
> > +     emit_insn(ctx, lu32id, rd, imm_51_32);
> > +
> > +     /* lu52id rd, rd, imm_63_52 */
> > +     imm_63_52 = (addr >> 52) & 0xfff;
> > +     emit_insn(ctx, lu52id, rd, rd, imm_63_52);
> > +}
> > +
> >  static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
> >  {
> >       u8 tm = -1;
> > @@ -841,7 +862,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
> >               if (ret < 0)
> >                       return ret;
> >
> > -             move_imm(ctx, t1, func_addr, is32);
> > +             emit_addr_move(ctx, t1, func_addr);
> >               emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
> >               move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> >               break;
> >
>
> The code itself looks good to me.
>
> Could you please give more detailed info in the commit message?
> For example, description of problem, steps to reproduce, ...
> I think the descriptions in the cover letter are useful, it is
> better to record them in the commit message.
>
> Additionally, emit_addr_move() is similar with move_imm(), it is
> better to define emit_addr_move() before move_imm() in bpf_jit.h.
>
> Thanks,
> Tiezhu
>

I've addressed your comments and send a v2 for review.
The second patch is dropped, as it is incomplete.

Cheers,
---
Hengqi
