Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB243DDBF
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1JcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1JcO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 05:32:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC3C061570;
        Thu, 28 Oct 2021 02:29:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13a700ce852a94ee005c43.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:ce85:2a94:ee00:5c43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8ABA1EC0646;
        Thu, 28 Oct 2021 11:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635413386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5eLak/pJw+sxT0NjHMlx3r7vNd3IpQAg8PUR9uVd+Ec=;
        b=om1Oxc0wUxEhyIJlskJW4axkjQve9kAHjOK7UEFy1TM8GoZwfDsoaQFNI3pFHHeGCbq28c
        VeVvtTduby8BjqsgRCsywofZ7STrZNlqFnnGJPSokr0MdqSy9+GrF8e/N5W6Rb6IGmpoj5
        OocbOzD0CivZKpOfgZVbTSpPFYYcq8w=
Date:   Thu, 28 Oct 2021 11:29:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 11/16] x86/alternative: Handle Jcc
 __x86_indirect_thunk_\reg
Message-ID: <YXpth/x0f5Rj3k+D@zn.tnic>
References: <20211026120132.613201817@infradead.org>
 <20211026120310.296470217@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120310.296470217@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:43PM +0200, Peter Zijlstra wrote:
> +	op = insn->opcode.bytes[0];
> +
> +	/*
> +	 * Convert:
> +	 *
> +	 *   Jcc.d32 __x86_indirect_thunk_\reg
> +	 *
> +	 * into:
> +	 *
> +	 *   Jncc.d8 1f
> +	 *   JMP *%\reg
> +	 *   NOP
> +	 * 1:
> +	 */

Let's explain the second part of the test better:

	/* Jcc opcodes are in the range 0x80-0x8f */

Yeah, you have that range check below but still.

> +	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
> +		cc = insn->opcode.bytes[1] & 0xf;
> +		cc ^= 1; /* invert condition */
> +
> +		bytes[i++] = 0x70 + cc; /* Jcc.d8 */
> +		bytes[i++] = insn->length - 2;

maybe put at the end here: /* 2 == sizeof(Jcc.d8) */

to have it explicit what that 2 means.

But yeah, looks good.

Thx.

> +
> +		op = JMP32_INSN_OPCODE;
> +	}
> +
> +	ret = emit_indirect(op, reg, bytes + i);
> +	if (ret < 0)
> +		return ret;
> +	i += ret;
>  
>  	for (; i < insn->length;)
>  		bytes[i++] = BYTES_NOP1;
> @@ -443,6 +469,10 @@ void __init_or_module noinline apply_ret
>  		case JMP32_INSN_OPCODE:
>  			break;
>  
> +		case 0x0f: /* escape */
> +			if (op2 >= 0x80 && op2 <= 0x8f)
> +				break;
> +			fallthrough;
>  		default:
>  			WARN_ON_ONCE(1);
>  			continue;
> 
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
