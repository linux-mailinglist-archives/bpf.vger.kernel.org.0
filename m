Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5A14E006
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2020 18:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3RiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 12:38:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37243 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgA3RiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 12:38:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so2013558pga.4
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NxDWMaX+pym8XAof67x0lgY8uDVuppxOfPoRQYouOtc=;
        b=l4kDFn3H9o5LVNOwlfeBfEo12IAHVbL58t2kWjymd1GSG1zoXbtISLxgZRTFWjquml
         1Xcg9c4NWaPUoz8TG2Zax58+U6vWHzlJzdj+CDH7n0+URo5EhbNRObtwItOxmTmLRR1t
         plGuOHf42RYjHRPKH30ltHiNejVIlvESJ8YKiNatfkX2fW5yBtnsDa7bNgQJviMer0bA
         hY+V22YQcvwcAhjr/YGfBp5pZSOUjgIn9zeg14LSBUXqgnndW7TuMJIrs0CllKTik8Ju
         XHvG2QfcZ6NcTsvMfKgkORrdLvwEVFeTGGiY984l8tbH5RU/IbBqEHRYqNRyaE7ZSiEf
         9NQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NxDWMaX+pym8XAof67x0lgY8uDVuppxOfPoRQYouOtc=;
        b=BNiZ9SvspEhS483qWp8nqbXgzxXoeQEd16zVlLB8tvMucy5fJwBnOSSm6dtw/6n/r/
         +Ms1D4c28UAps80/peMfocOJMPst/DYFiORWXp8rrkZpKvytqRRo6TKQlpzAao0SygGQ
         diTH6NDHkHZtYAuwSIiTA1O7DcdBH3bsL7PVh7Ej9QPP8HJuAAdqd3lCzzyqMEGgGvUd
         GezuAgqbQHc4Q2HTVLfwhs974AmeGLD9JTUIPxgukTsbrxMde2a6dHQTNbZIdLO4pmxq
         8g/i0PbnpQJZS3YZKxmw2pOjTGXuwmV8ZTqDGcAjj9w7OYDNGsjAAVObvBumXJDP+Ja6
         dbvw==
X-Gm-Message-State: APjAAAW9kLX6lzaGc1Oe9KleE7ml5+co9DMpd3u+ed/SlvM/4/AtvR4W
        zlmrnAfQtKEjcjFoMxUQakg=
X-Google-Smtp-Source: APXvYqzTgct+2y31NPtoeiYVZ94KF/i1oPz3pBxWbSgTOK9vO/nFx2dS/jVPlMx1CpheqvsS+P9rDQ==
X-Received: by 2002:a63:c748:: with SMTP id v8mr5757541pgg.143.1580405896747;
        Thu, 30 Jan 2020 09:38:16 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id r3sm7476290pfg.145.2020.01.30.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 09:38:16 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:38:07 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
In-Reply-To: <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
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

Alexei Starovoitov wrote:
> On Wed, Jan 29, 2020 at 02:52:10PM -0800, John Fastabend wrote:
> > Daniel Borkmann wrote:
> > > On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> > > > On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > >>>
> > > >>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> > > >>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > > >>
> > > >> Applied, thanks!
> > > > 
> > > > Daniel,
> > > > did you run the selftests before applying?
> > > > This patch breaks two.
> > > > We have to find a different fix.
> > > > 
> > > > ./test_progs -t get_stack
> > > > 68: (85) call bpf_get_stack#67
> > > >   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> > > > R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> > > > 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> > > > 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> > > > R2 unbounded memory access, make sure to bounds check any array access
> > > > into a map
> > > 
> > > Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> > > tree since this needs to be addressed. Sorry for the trouble.
> > 
> > Thanks I'm looking into it now. Not sure how I missed it on
> > selftests either older branch or I missed the test somehow. I've
> > updated toolchain and kernel now so shouldn't happen again.
> 
> Looks like smax_value was nuked by <<32 >>32 shifts.
> 53: (bf) r8 = r0   // R0=inv(id=0,smax_value=800)
> 54: (67) r8 <<= 32  // R8->smax_value = S64_MAX; in adjust_scalar_min_max_vals()
> 55: (c7) r8 s>>= 32
> ; if (usize < 0)
> 56: (c5) if r8 s< 0x0 goto pc+28
> // and here "less than zero check" doesn't help anymore.
> 
> Not sure how to fix it yet, but the code pattern used in
> progs/test_get_stack_rawtp.c
> is real. Plenty of bpf progs rely on this.

OK I see what happened I have some patches on my llvm tree and forgot to
pop them off before running selftests :/ These <<=32 s>>=32 pattern pops up
in a few places for us and causes verifier trouble whenever it is hit.

I think I have a fix for this in llvm, if that is OK. And we can make
the BPF_RSH and BPF_LSH verifier bounds tighter if we also define the
architecture expectation on the jit side. For example x86 jit code here,

146:   shl    $0x20,%rdi
14a:   shr    $0x20,%rdi

the shr will clear the most significant bit so we can say something about
the min sign value. I'll generate a couple patches today and send them
out to discuss. Probably easier to explain with code and examples.

Thanks,
John
