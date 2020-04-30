Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A41BEEFE
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 06:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgD3EYF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 00:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3EYF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 00:24:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F92C035494;
        Wed, 29 Apr 2020 21:24:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so2295711pfa.1;
        Wed, 29 Apr 2020 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KhvM5Pbwqp4GHCCKH1JQ77gi57Z5QMqOiW7fGw8B1mk=;
        b=ougCJz6naTbrpT5mDHZs3oj9O89lX1RVKtVzjutjexVrgQFKbXfrr3g7/aG2ZhQg9P
         8HLm1eP/clniAjyoanFTKE1ucc+f16h2oe2g0bHr8UrhTJlyUX3jkrjITRFef3foN45z
         EeNdIeApf5gtXGvcR2jPNPJgegRYTrCdDbD22zLGTyFL/KnCsJ6Q17GIrESmFl1i5Bpf
         bRB6RRTNfVcAdNdsIN6RO3F/sPmGbfVxlfW3AakD7MXJlA0xNFVk1wvV0OOJbsJLafih
         wzB3xpV0cnyn7HxZ+MwkLk1TT1xw4Y1LUZOI4vxBuliIaCYcs+U2mTkF9HeWw8pkTUmr
         4uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KhvM5Pbwqp4GHCCKH1JQ77gi57Z5QMqOiW7fGw8B1mk=;
        b=LLmZ/6NQlOq+OBundSmZ6wFvMl5IAT6l3rMEP9sVgaLFXlGjnheKFdHVRuYZqJvJkY
         JDUJs+5jyvUcoVZNGgy+UmE1WdlW8o8vjalK6/vOfAKu/R+0GDJeZIBnqGhBPgVuwjaz
         sK4c2h4k5caID7cDCOWkh5f6/6qyBUWC06kI4oQ8cWAXqXymi5HrusALqR0HGh4EHmWq
         u1s/DUGZgeJBlZUKMrYKL71VAdf+BibKWvq+5S+TR/gRGQOk61xhbU98Hy0HqapZxAkL
         bHGOrTXKhd5Oe1VxNbArsRYch0oqE//eF9oJJP3tVfEd0/UO0HLWl0C/vO6nuFXhxZcC
         j18w==
X-Gm-Message-State: AGi0PubkO+1N3oPRqZEHfmBmic2IdcoJpqvPKKP0eKNj/1Oap0+qGof4
        dvGrNXmR00gkzC7D19+AFeQ=
X-Google-Smtp-Source: APiQypKlNI45ZENLkeN/qowZIMetyD/iTF9kI3byHgLbMxnedtufJ3lV/pnskfqTkAx9mA76FUvslg==
X-Received: by 2002:a62:aa04:: with SMTP id e4mr219156pff.317.1588220644254;
        Wed, 29 Apr 2020 21:24:04 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:c108])
        by smtp.gmail.com with ESMTPSA id j23sm614197pjz.13.2020.04.29.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 21:24:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 21:24:00 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200430042400.45vvqx4ocwwogp3j@ast-mbp.dhcp.thefacebook.com>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
 <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
 <20200430001300.k3pgq2minrowstbs@treble>
 <20200430021052.k47qzm63kpcn32pg@ast-mbp.dhcp.thefacebook.com>
 <20200430035315.tc74v5twfdxv2goh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430035315.tc74v5twfdxv2goh@treble>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 10:53:15PM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 29, 2020 at 07:10:52PM -0700, Alexei Starovoitov wrote:
> > > For example:
> > > 
> > > #define GOTO    ({ goto *jumptable[insn->code]; })
> > > 
> > > and then replace all 'goto select_insn' with 'GOTO;'
> > > 
> > > The problem is that with RETPOLINE=y, the function text size grows from
> > > 5k to 7k, because for each of the 160+ retpoline JMPs, GCC (stupidly)
> > > reloads the jump table register into a scratch register.
> > 
> > that would be a tiny change, right?
> > I'd rather go with that and gate it with 'ifdef CONFIG_FRAME_POINTER'
> > Like:
> > #ifndef CONFIG_FRAME_POINTER
> > #define CONT     ({ insn++; goto select_insn; })
> > #define CONT_JMP ({ insn++; goto select_insn; })
> > #else
> > #define CONT     ({ insn++; goto *jumptable[insn->code]; })
> > #define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
> > #endif
> > 
> > The reason this CONT and CONT_JMP macros are there because a combination
> > of different gcc versions together with different cpus make branch predictor
> > behave 'unpredictably'.
> > 
> > I've played with CONT and CONT_JMP either both doing direct goto or
> > indirect goto and observed quite different performance characteristics
> > from the interpreter.
> > What you see right now was the best tune I could get from a set of cpus
> > I had to play with and compilers. If I did the same tuning today the outcome
> > could have been different.
> > So I think it's totally fine to use above code. I think some cpus may actually
> > see performance gains with certain versions of gcc.
> > The retpoline text increase is unfortunate but when retpoline is on
> > other security knobs should be on too. In particular CONFIG_BPF_JIT_ALWAYS_ON
> > should be on as well. Which will remove interpreter from .text completely.
> 
> This would actually be contingent on RETPOLINE, not FRAME_POINTER.
> 
> (FRAME_POINTER was the other issue with the "optimize" attribute, which
> we're reverting so it'll no longer be a problem.)
> 
> So if you're not concerned about the retpoline text growth, it could be
> as simple as:
> 
> #define CONT     ({ insn++; goto *jumptable[insn->code]; })
> #define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
> 
> 
> Or, if you wanted to avoid the text growth, it could be:
> 
> #ifdef CONFIG_RETPOLINE

I'm a bit lost. So objtool is fine with the asm when retpoline is on?
Then pls do:
#if defined(CONFIG_RETPOLINE) || !defined(CONFIG_X86)

since there is no need to mess with other archs.

> /*
>  * Avoid a 40% increase in function text size by getting GCC to generate a
>  * single retpoline jump instead of 160+.
>  */
> #define CONT	 ({ insn++; goto select_insn; })
> #define CONT_JMP ({ insn++; goto select_insn; })
> 
> select_insn:
> 	goto *jumptable[insn->code];
> 
> #else /* !CONFIG_RETPOLINE */
> #define CONT	 ({ insn++; goto *jumptable[insn->code]; })
> #define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
> #endif /* CONFIG_RETPOLINE */
> 
> 
> But since this is legacy path, I think the first one is much nicer.
> 
> 
> Also, JMP_TAIL_CALL has a "goto select_insn", is it ok to convert that
> to CONT?

yep
