Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13B43CFE7
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbhJ0Rla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbhJ0Rla (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 13:41:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D58C061570;
        Wed, 27 Oct 2021 10:39:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f161500c684d7dcfa146303.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:c684:d7dc:fa14:6303])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 057F11EC05D4;
        Wed, 27 Oct 2021 19:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635356343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1r3dQEs8J5vGBunNQMyOmRt+PDKKK7DSCsZM8a0G5Iw=;
        b=YIniIRfaS/BOUq4GWF3KoY9dQRoI+iP8XYs933TIK9uFf4imCklj99XyXQIXzzk3yviXFv
        z5UPeCFXVLlLGUZnJ40wTHa5iBOwJQxqpW6nwS83g1BFWNiCMVKVIzAd+zhKSEUI4PY/RE
        I04MTKRErAlqdl0WCC812SM38j27isc=
Date:   Wed, 27 Oct 2021 19:38:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 10/16] x86/alternative: Implement .retpoline_sites
 support
Message-ID: <YXmOs2oSp+6Dpi4R@zn.tnic>
References: <20211026120132.613201817@infradead.org>
 <20211026120310.232495794@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120310.232495794@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:42PM +0200, Peter Zijlstra wrote:
> +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> +{
> +	retpoline_thunk_t *target;
> +	int reg, i = 0;
> +
> +	target = addr + insn->length + insn->immediate.value;
> +	reg = target - __x86_indirect_thunk_array;
> +
> +	if (WARN_ON_ONCE(reg & ~0xf))
> +		return -1;
> +
> +	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
> +	BUG_ON(reg == 4);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +		return -1;

I wanna say this should be the first thing being checked on function
entry but I get the feeling you'll be looking at other X86_FEATURE bits
in future patches... /me goes into the future...

yap, you do. Lemme look at the whole thing first then.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
