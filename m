Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B014E055
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2020 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA3R7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 12:59:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54394 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3R7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 12:59:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so1663368pjb.4
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmEDrQkhnAb/NjhxlHXZCMsjLDgB21xFA1QfABuJTAc=;
        b=h7WlZwHTFlnKkHfjI50IdIScOVhT5HHaqsF+smsFUb8iTjQatyi91VcWjM0soGvNto
         F5cNdOt1hpkbE7WXS5hvj3F8gWA1goTTPvXKNfyO/vQUcHFzwc1/50dsOb5QciK83E6k
         hji3LlzGH5fq76B2tAR1LIYwme7oM0JeaTZPHNHeJrTJ+Wcqx5aAlPuJQbGw9hJbuQo6
         9r6D5cSDvzE3yCN6ytj+htLDdIs5Z7HZbllPEK4qApdonhKgPjW+RuU6Bx0pTaWZVENM
         6Z18FyYvRay2ezo0iATTGIsYswTPhPjISZfaBKk8uqmKgCz362/qIvl5GTgS3euNzjYc
         58uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmEDrQkhnAb/NjhxlHXZCMsjLDgB21xFA1QfABuJTAc=;
        b=uaXsegQCWrzENr0PEW91XlsVbZs3QGd6dkAO4xtw65KHdakML41Syr6dRlHLO72Smb
         V4uDwHoWnDXK7IbP2HuMjM3s0uuGNmXF9y46qpPoFNoevIrC8pYIC7QFUGeSf+WnScl7
         iYm8mAacvfIUrc/adk1x4eHMRVsmSncwSZkoDhQ+v8/fPD2R9uvUncK7wJL/tFO6DyBz
         74hAVyk+cogTXTs6EjK1aSxZ+TIhfjBGZTHVZfyE6Nom+IRsF0GpBPUyfxdoe1zj+dZB
         hZ5lL+qCzGZYmvDVBIoMQkSNqaeS6+0ux4IBf1lYg13Lwaha2a1D3zgaFFfeGK/GNbGt
         lX1Q==
X-Gm-Message-State: APjAAAWDUBBzuWLyC4ZEz4IUkWZyBT+pV8sGNjHWTh1E7VglLZtwiuIF
        Qha2AWQhKa3XT4yAGJEwjm8=
X-Google-Smtp-Source: APXvYqwfqmlEA7zH0teogFiSrp0qLdKuuK6SAdAuNJzr6JvwXd2NtOTk83VMeeN2NHAZeqePdcJr3A==
X-Received: by 2002:a17:90a:c691:: with SMTP id n17mr7299613pjt.41.1580407178574;
        Thu, 30 Jan 2020 09:59:38 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::2:f7d])
        by smtp.gmail.com with ESMTPSA id t8sm7190663pjy.20.2020.01.30.09.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 09:59:37 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:59:36 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Message-ID: <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 30, 2020 at 09:38:07AM -0800, John Fastabend wrote:
> Alexei Starovoitov wrote:
> > On Wed, Jan 29, 2020 at 02:52:10PM -0800, John Fastabend wrote:
> > > Daniel Borkmann wrote:
> > > > On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> > > > > On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > > >>>
> > > > >>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> > > > >>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > > > >>
> > > > >> Applied, thanks!
> > > > > 
> > > > > Daniel,
> > > > > did you run the selftests before applying?
> > > > > This patch breaks two.
> > > > > We have to find a different fix.
> > > > > 
> > > > > ./test_progs -t get_stack
> > > > > 68: (85) call bpf_get_stack#67
> > > > >   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> > > > > R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> > > > > 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> > > > > 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> > > > > R2 unbounded memory access, make sure to bounds check any array access
> > > > > into a map
> > > > 
> > > > Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> > > > tree since this needs to be addressed. Sorry for the trouble.
> > > 
> > > Thanks I'm looking into it now. Not sure how I missed it on
> > > selftests either older branch or I missed the test somehow. I've
> > > updated toolchain and kernel now so shouldn't happen again.
> > 
> > Looks like smax_value was nuked by <<32 >>32 shifts.
> > 53: (bf) r8 = r0   // R0=inv(id=0,smax_value=800)
> > 54: (67) r8 <<= 32  // R8->smax_value = S64_MAX; in adjust_scalar_min_max_vals()
> > 55: (c7) r8 s>>= 32
> > ; if (usize < 0)
> > 56: (c5) if r8 s< 0x0 goto pc+28
> > // and here "less than zero check" doesn't help anymore.
> > 
> > Not sure how to fix it yet, but the code pattern used in
> > progs/test_get_stack_rawtp.c
> > is real. Plenty of bpf progs rely on this.
> 
> OK I see what happened I have some patches on my llvm tree and forgot to
> pop them off before running selftests :/ These <<=32 s>>=32 pattern pops up
> in a few places for us and causes verifier trouble whenever it is hit.
> 
> I think I have a fix for this in llvm, if that is OK. And we can make
> the BPF_RSH and BPF_LSH verifier bounds tighter if we also define the
> architecture expectation on the jit side. For example x86 jit code here,
> 
> 146:   shl    $0x20,%rdi
> 14a:   shr    $0x20,%rdi
> 
> the shr will clear the most significant bit so we can say something about
> the min sign value. I'll generate a couple patches today and send them
> out to discuss. Probably easier to explain with code and examples.

How about we detect this pattern on the verifier side and replace with
pseudo insn that will do 32-bit sign extend. Most archs have special
cpu instruction to do this much more efficiently than two shifts.
If JIT doesn't implement that pseudo yet the verifier can convert
it back to two shifts.
Then during verification it will process pseudo_sign_extend op easily.
So the idea:
1. pattern match sequence of two shifts in a pass similar to
   replace_map_fd_with_map_ptr() before main do_check()
2. pseudo_sign_extend gets process in do_check() doing the right thing
   with bpf_reg_state.
3. JIT this pseudo insn or convert back

Long term we can upgrade this pseudo insn into uapi and let llvm emit it.
