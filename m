Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBA67EA5D
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjA0QFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 11:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0QFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 11:05:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89219F2D
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 08:04:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k4so9483611eje.1
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUcrP5aYd5EH6hqhkALY1FSsNB+YyKU7LXURoF0PDso=;
        b=VI0s8QKmjhrEt54ECYV3Pu+7xm87/2qIs8rbgzEkv4MRBeAEoTw81SSKbAfCGu4GjV
         bA6LmFMHaZps5YghvC01AM+S2CossPRDqZXqbthpc/aFkq6cNxbWyJixTaITGCiJJPMj
         SYeG+uan7NMAu8jHnkp7cIqLW+uTJfWeLqMcnbyOvZSP699KxhlerS/zqnNZWkdkSYE2
         jwwr57z84Vy9ky1o3WLM/6ZaQ/Bh/TsqBU0CUgbHtUkGOQizS5ttPsfKqp/gnD0zLm68
         +VMXpJ8SsCIo71k+Ovgm9ayrM0ttL6uM45ZF+n7XPmgJ1YuhcdkcwMafLakykQfxBPU4
         XAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUcrP5aYd5EH6hqhkALY1FSsNB+YyKU7LXURoF0PDso=;
        b=euaa9mD+67MDZ/TK6WaJR/mCLk2i+O/6apRBsiB02MyVQ4+SodbwXyFEtPDXn2RCyY
         SVUXkUHSTtWPt1/doONTa81lgvSswmikAysQ+h4TLuEq/ADx2omlmHKWqk21Nf25Bbp9
         7o42CA9f2/8zorUCrKm3ajLe07ks8vas/3c1sppRmEtrvGVxk9Y4LoAhrRmjUG5Jqbq9
         ri2Gc9lVLF0m7dH4urLIU6eEBYJAQ9d3ZlgvdMI41UPwonxNpbHuk6qPU94DHPL6TtpY
         Q6zJjDTyxMCYVl/rkS79MsMqe7mocKNqtbrxiB5IV7xylKNfrw/wZk1pmGnN+pJ4gPPv
         qPWA==
X-Gm-Message-State: AFqh2kpVPxLq7zf3tgs9F4xXdbrIbOEv6rrSB3tddo3u3ueOaThck8mW
        FRZ8wpPaXfPjq2aOvnRImb2b4TGiKXIJUqEsiDI=
X-Google-Smtp-Source: AMrXdXuttGDEFpQfZzK/29KSvg8V53hAzCzHu5xRu2PSXsIEm2SyWAEZadsISfXStofIH537vHzpiea/jE4FdxKg0cE=
X-Received: by 2002:a17:906:7ac2:b0:86e:429b:6a20 with SMTP id
 k2-20020a1709067ac200b0086e429b6a20mr5380429ejo.247.1674835456292; Fri, 27
 Jan 2023 08:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-25-iii@linux.ibm.com>
 <20230126012812.vqg3oktknpnvvssf@macbook-pro-6.dhcp.thefacebook.com> <2dd35469c9df5d6ab81d798467e13eab82b1d254.camel@linux.ibm.com>
In-Reply-To: <2dd35469c9df5d6ab81d798467e13eab82b1d254.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 27 Jan 2023 08:04:05 -0800
Message-ID: <CAADnVQLb_wvXQ+MAdGc_WEpA3RE+N9KAk6fgTC3RVDsCXBuo4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 24/24] s390/bpf: Implement bpf_jit_supports_kfunc_call()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Fri, Jan 27, 2023 at 3:36 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-01-25 at 17:28 -0800, Alexei Starovoitov wrote:
> > On Wed, Jan 25, 2023 at 10:38:17PM +0100, Ilya Leoshkevich wrote:
> > > +
> > > +               /* Sign-extend the kfunc arguments. */
> > > +               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> > > +                       m = bpf_jit_find_kfunc_model(fp, insn);
> > > +                       if (!m)
> > > +                               return -1;
> > > +
> > > +                       for (j = 0; j < m->nr_args; j++) {
> > > +                               if (sign_extend(jit, BPF_REG_1 + j,
> > > +                                               m->arg_size[j],
> > > +                                               m->arg_flags[j]))
> > > +                                       return -1;
> > > +                       }
> > > +               }
> >
> > Is this because s390 doesn't have subregisters?
> > Could you give an example where it's necessary?
> > I'm guessing a bpf prog compiled with alu32 and operates on signed
> > int
> > that is passed into a kfunc that expects 'int' in 64-bit reg?
>
> Precisely. The test added in 13/24 fails without this:
>
> verify_success:PASS:skel 0 nsec
> verify_success:PASS:bpf_object__find_program_by_name 0 nsec
> verify_success:PASS:kfunc_call_test4 0 nsec
> verify_success:FAIL:retval unexpected retval: actual 4294966065 !=
> expected -1234
> #94/10   kfunc_call/kfunc_call_test4:FAIL
>
> Looking at the assembly:
>
> ; long noinline bpf_kfunc_call_test4(signed char a, short b, int c,
> long d)
> 0000000000936a78 <bpf_kfunc_call_test4>:
>   936a78:       c0 04 00 00 00 00       jgnop   936a78
> <bpf_kfunc_call_test4>
> ;       return (long)a + (long)b + (long)c + d;
>   936a7e:       b9 08 00 45             agr     %r4,%r5
>   936a82:       b9 08 00 43             agr     %r4,%r3
>   936a86:       b9 08 00 24             agr     %r2,%r4
>   936a8a:       c0 f4 00 1e 3b 27       jg      cfe0d8
> <__s390_indirect_jump_r14>
>
> As per the s390x ABI, bpf_kfunc_call_test4() has the right to assume
> that a, b and c are sign-extended by the caller, which results in using
> 64-bit additions (agr) without any additional conversions.
>
> On the JITed code side (without this hunk) we have:
>
> ; tmp = bpf_kfunc_call_test4(-3, -30, -200, -1000);
> ;        5:       b4 10 00 00 ff ff ff fd w1 = -3
>    0x3ff7fdcdad4:       llilf   %r2,0xfffffffd
> ;        6:       b4 20 00 00 ff ff ff e2 w2 = -30
>    0x3ff7fdcdada:       llilf   %r3,0xffffffe2
> ;        7:       b4 30 00 00 ff ff ff 38 w3 = -200
>    0x3ff7fdcdae0:       llilf   %r4,0xffffff38
> ;       8:       b7 40 00 00 ff ff fc 18 r4 = -1000
>    0x3ff7fdcdae6:       lgfi    %r5,-1000
>    0x3ff7fdcdaec:       mvc     64(4,%r15),160(%r15)
>    0x3ff7fdcdaf2:       lgrl    %r1,bpf_kfunc_call_test4@GOT
>    0x3ff7fdcdaf8:       brasl   %r14,__s390_indirect_jump_r1
>
> This first 3 llilfs are 32-bit loads, that need to be sign-extended
> to 64 bits.

All makes sense. Please add this explanation to the commit log.
When 2nd arch appears that needs similar sign extension in
the caller we can add this logic to the verifier.

In parallel we're working on new sign extension instructions.
Doing sign extension with shifts in the verifier won't be efficient,
so we need to wait for them.
