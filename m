Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889EF156021
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 21:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGUrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 15:47:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55419 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUrM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 15:47:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1407294pjz.5
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0v3uDXLgqVNhC3YrUcWtEWnXkSIuRMKALfkKptkZUbk=;
        b=qWL/SxDX6RocFT/nmWnUeOJZF89t8TQniQDe0GVKXfzocgVHYVdKU/56q13F2gNmFw
         kJUBOwAI+MXnaXRs7jo7BXX6yxw3PgLmE0GM/nefA+HPzk492p+q59vBfB506ZsDiq2m
         hAmNsxdSVVfDVVvf/nBsLUAkR9dDEI3YwhPgb19rG0F965p8fjBQzeN+uah09z4ge70b
         M6GuM1Q2rvn9ee1z3W/6nC+IaJ/AGIT4QZlfc9TL4uDq7AX8JxidMgFmjuiNkaFLzQBx
         i0lVswfMqKy98s4dHS+fKUOpVz/fwZyKXTDvGTQui1ogPF4Uv4dK7/4Vs2YtOGrwtOoQ
         qTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0v3uDXLgqVNhC3YrUcWtEWnXkSIuRMKALfkKptkZUbk=;
        b=VqfoKIOy5oXoDpEfvC+DkU7HuTKiIDykn1glXuvmZnSx5gzy3HC7iS5GIXSAxDsH3E
         QcLN7DcHGsO4WMKjVpuSpL0z8v+1/rhp2jfW55xc6qGhevD0CFQU/3MMrlOGT3N0UebL
         RdKUhcBXqXJW8qrjH+CGMdfGp0xYvjhS9IwX/jq3G/jA6onRMgTo+RjzlKbAAQi8lggD
         TZsoQZsEMy1GOIyaMk89+SsJoQ5Ltj3fsFc4GR0p0iPfkxKOT6zVrpAW7q7RzA7q6JlB
         9k+VBoGpkwLcIMJ7+iMdx12WfiQBTW6nEgXPkxGmZTmdjhfNefu1iK98j9fe2xwDUQ+J
         X4/Q==
X-Gm-Message-State: APjAAAUw9rdD/BFPtCwwUnLn0al7IJeJEcvwIZmYVldq4ZqzCJKmiYrR
        5MWKr236qcUrf9grqraMS3iB1vC2
X-Google-Smtp-Source: APXvYqz0D0sqJ0/K2o2d05Blbayj6lV1zAUzbHg+OZT16NsRLTTIfE5OHfJZcV7gYK+iNxTuLBaz4g==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr5810748pjb.125.1581108430261;
        Fri, 07 Feb 2020 12:47:10 -0800 (PST)
Received: from localhost (host-243-209.pubnet.pdx.edu. [131.252.243.209])
        by smtp.gmail.com with ESMTPSA id c26sm4041178pfj.8.2020.02.07.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:47:09 -0800 (PST)
Date:   Fri, 07 Feb 2020 12:47:08 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e3dccccc0a92_7e1b2b0e9aae25bcec@john-XPS-13-9370.notmuch>
In-Reply-To: <25e53344-8551-944e-18c7-ae4a260e80f8@fb.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
 <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
 <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
 <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
 <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
 <fe3e8178-c069-4299-10df-8c983388c48c@fb.com>
 <5e3a30f3a9221_3b4f2ab2596925b8e3@john-XPS-13-9370.notmuch>
 <25e53344-8551-944e-18c7-ae4a260e80f8@fb.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 2/4/20 7:05 PM, John Fastabend wrote:
> > Yonghong Song wrote:
> >>
> >>
> >> On 2/4/20 11:55 AM, John Fastabend wrote:
> >>> Alexei Starovoitov wrote:
> >>>> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
> >>>>>
> >>>>> Also don't mind to build pseudo instruction here for signed extension
> >>>>> but its not clear to me why we are getting different instruction
> >>>>> selections? Its not clear to me why sext is being chosen in your case?
> > 
> > [...]
> > 
> >>>> zext is there both cases and it will be optimized with your llvm patch.
> >>>> So please send it. Don't delay :)
> >>>
> >>> LLVM patch here, https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D73985&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VnK0SKxGnw_yzWjaO-cZFrmlZB9p86L4me-mWE_vDto&s=jwDJuAEdJ23HVcvIILvkfxvTNSe_cgHQFn_MpXssfXc&e=
> >>>
> >>> With updated LLVM I can pass selftests with above fix and additional patch
> >>> below to get tighter bounds on 32bit registers. So going forward I think
> >>> we need to review and assuming it looks good commit above llvm patch and
> >>> then go forward with this series.
> >>[...]
> >> With the above patch, there is still one more issue in test_seg6_loop.o,
> >> which is related to llvm code generation, w.r.t. our strange 32bit
> >> packet begin and packet end.
> >>
> >> The following patch is generated:
> >>
> >> 2: (61) r1 = *(u32 *)(r6 +76)
> >> 3: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
> >> R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> >> ; cursor = (void *)(long)skb->data;
> >> 3: (bc) w8 = w1
> >> 4: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
> >> R6_w=ctx(id=0,off=0,imm=0)
> >> R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> >> ; if ((void *)ipver + sizeof(*ipver) > data_end)
> >> 4: (bf) r3 = r8
> >>
> >> In the above r1 is packet pointer and after the assignment, it becomes a
> >> scalar and will lead later verification failure.
> >>
> >> Without the patch, we generates:
> >> 1: R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> >> ; data_end = (void *)(long)skb->data_end;
> >> 1: (61) r1 = *(u32 *)(r6 +80)
> >> 2: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> >> ; cursor = (void *)(long)skb->data;
> >> 2: (61) r8 = *(u32 *)(r6 +76)
> >> 3: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> >> R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> >> ; if ((void *)ipver + sizeof(*ipver) > data_end)
> >> 3: (bf) r2 = r8
> >> 4: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0)
> >> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> >> 4: (07) r2 += 1
> >> 5: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=1,r=0,imm=0)
> >> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> >>
> >> r2 keeps as a packet pointer, so we don't have issues later.
> >>
> >> Not sure how we could fix this in llvm as llvm does not really have idea
> >> the above w1 in w8 = w1 is a packet pointer.
> >>
> > 
> > OK thanks for analysis. I have this on my stack as well but need to
> > check its correct still,
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 320e2df..3072dba7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2804,8 +2804,11 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
> >                  reg->umax_value = mask;
> >          }
> >          reg->smin_value = reg->umin_value;
> > -       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
> > +       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value) {
> >                  reg->smax_value = reg->umax_value;
> > +       } else {
> > +               reg->umax_value = reg->smax_value;
> > +       }
> >   }
> > 
> > this helps but still hitting above issue with the packet pointer as
> > you pointed out. I'll sort out how we can fix this. Somewhat related
> 
> I just fixed llvm to allow itself doing a better job for zext code gen.
> https://reviews.llvm.org/D74101
> This should solve the above issue.

Great applied this but still have one more issue to resolve.

> 
> > we have a similar issue we hit fairly consistently I've been meaning
> > to sort out where the cmp happens on a different register then is
> > used in the call, for example something like this pseudocode
> > 
> >     r8 = r2
> >     if r8 > blah goto +label
> >     r1 = dest_ptr
> >     r1 += r2
> >     r2 = size
> >     r3 = ptr
> >     call #some_call
> > 
> > and the verifier aborts because r8 was verified instead of r2. The
> > working plan was to walk back in the def-use chain and sort it out
> > but tbd.
> 
> I have another llvm patch (not merged yet)
>    https://reviews.llvm.org/D72787
> to undo some llvm optimization so we do not have the above code.
> But the resulted byte code needs some kernel verifier change. The 
> following is my previous attempt and you commented on.
> 
> https://lore.kernel.org/bpf/20200123191815.1364298-1-yhs@fb.com/T/#m8e3dee022801542ddf15b8e406dc05185f959b4f
> 
> I think this is better than making verifier more complex to do 
> backtracking. What do you think?
> 

In general I think its nice if llvm can continue to optimize as it
wants and we can verify it. I was hoping to try this next week and
see how it falls out after getting the above resolved. If it gets
too ugly sure we can fall back to removing the optimization.
