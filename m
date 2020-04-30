Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62FF1BEEBE
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 05:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3Dx2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 23:53:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3Dx1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 23:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588218805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZufJCVAcrddU2HlFIrpCmkEVQ7zG0wH3RUMx2nRv1lg=;
        b=Eqb7uaa+Dv3nZjVopXwjZ3lfesCok3sHKexg0lott+K7KVE2ELp2xBEwvZZpHQHXGgGRNZ
        ch94tK2U5zl3MXkJqbOZgm+xnqh2KQWiw9mvkUU0/AW0/aYUWUbrhUaJafe3E7ScJOWnM2
        pUo4EWjgFxxxrIgpStio/U//BMVqNn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-40vepxlRNWyw2n7pMye9iA-1; Wed, 29 Apr 2020 23:53:21 -0400
X-MC-Unique: 40vepxlRNWyw2n7pMye9iA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8148A45F;
        Thu, 30 Apr 2020 03:53:19 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7436E6606B;
        Thu, 30 Apr 2020 03:53:17 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:53:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200430035315.tc74v5twfdxv2goh@treble>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
 <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
 <20200430001300.k3pgq2minrowstbs@treble>
 <20200430021052.k47qzm63kpcn32pg@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430021052.k47qzm63kpcn32pg@ast-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 07:10:52PM -0700, Alexei Starovoitov wrote:
> > For example:
> > 
> > #define GOTO    ({ goto *jumptable[insn->code]; })
> > 
> > and then replace all 'goto select_insn' with 'GOTO;'
> > 
> > The problem is that with RETPOLINE=y, the function text size grows from
> > 5k to 7k, because for each of the 160+ retpoline JMPs, GCC (stupidly)
> > reloads the jump table register into a scratch register.
> 
> that would be a tiny change, right?
> I'd rather go with that and gate it with 'ifdef CONFIG_FRAME_POINTER'
> Like:
> #ifndef CONFIG_FRAME_POINTER
> #define CONT     ({ insn++; goto select_insn; })
> #define CONT_JMP ({ insn++; goto select_insn; })
> #else
> #define CONT     ({ insn++; goto *jumptable[insn->code]; })
> #define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
> #endif
> 
> The reason this CONT and CONT_JMP macros are there because a combination
> of different gcc versions together with different cpus make branch predictor
> behave 'unpredictably'.
> 
> I've played with CONT and CONT_JMP either both doing direct goto or
> indirect goto and observed quite different performance characteristics
> from the interpreter.
> What you see right now was the best tune I could get from a set of cpus
> I had to play with and compilers. If I did the same tuning today the outcome
> could have been different.
> So I think it's totally fine to use above code. I think some cpus may actually
> see performance gains with certain versions of gcc.
> The retpoline text increase is unfortunate but when retpoline is on
> other security knobs should be on too. In particular CONFIG_BPF_JIT_ALWAYS_ON
> should be on as well. Which will remove interpreter from .text completely.

This would actually be contingent on RETPOLINE, not FRAME_POINTER.

(FRAME_POINTER was the other issue with the "optimize" attribute, which
we're reverting so it'll no longer be a problem.)

So if you're not concerned about the retpoline text growth, it could be
as simple as:

#define CONT     ({ insn++; goto *jumptable[insn->code]; })
#define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })


Or, if you wanted to avoid the text growth, it could be:

#ifdef CONFIG_RETPOLINE
/*
 * Avoid a 40% increase in function text size by getting GCC to generate a
 * single retpoline jump instead of 160+.
 */
#define CONT	 ({ insn++; goto select_insn; })
#define CONT_JMP ({ insn++; goto select_insn; })

select_insn:
	goto *jumptable[insn->code];

#else /* !CONFIG_RETPOLINE */
#define CONT	 ({ insn++; goto *jumptable[insn->code]; })
#define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
#endif /* CONFIG_RETPOLINE */


But since this is legacy path, I think the first one is much nicer.


Also, JMP_TAIL_CALL has a "goto select_insn", is it ok to convert that
to CONT?

-- 
Josh

