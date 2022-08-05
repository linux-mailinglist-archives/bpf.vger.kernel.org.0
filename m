Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CB58AC75
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiHEOmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiHEOmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 10:42:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3480A6151;
        Fri,  5 Aug 2022 07:42:34 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 997221EC04E4;
        Fri,  5 Aug 2022 16:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659710548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KkCwkA7DjGXzsX/Cj6z7o8QdXSs7RYlnTW9pafNUiVQ=;
        b=JbhthMoEMvcUdbGNovlRlTGwXXNxq9AHlh5mpQPMJ8Av836+IAU1hZ7mRQjNTYKdPUvwnO
        l6Dgc1hN5Em2KU+M/qzS3szBsmhLy3voT9pETQ8rdQUYlpdtdfxHil+q6zUZA4JJWChOna
        1s6lbbzBI9hvQNPLCsu5gV//qAjVrc8=
Date:   Fri, 5 Aug 2022 16:42:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com
Subject: Re: [PATCH] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Message-ID: <Yu0sT6vCofyWiAMI@zn.tnic>
References: <20220804192201.439596-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804192201.439596-1-kim.phillips@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 04, 2022 at 02:22:01PM -0500, Kim Phillips wrote:
> For retbleed=ibpb, force STIBP on machines that have it,

Because?

> and report its SMT vulnerability status accordingly.
> 
> Fixes: 3ebc17006888 ("x86/bugs: Add retbleed=ibpb")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++-
>  arch/x86/kernel/cpu/bugs.c                      | 10 ++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 597ac77b541c..127fa4328360 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5212,10 +5212,12 @@
>  			ibpb	     - mitigate short speculation windows on
>  				       basic block boundaries too. Safe, highest
>  				       perf impact.

You should put some blurb here about STIBP and why it is being enabled,
where present.

> +			ibpb,nosmt   - like ibpb, but will disable SMT when STIBP
> +			               is not available.
>  			unret        - force enable untrained return thunks,
>  				       only effective on AMD f15h-f17h
>  				       based systems.
> -			unret,nosmt  - like unret, will disable SMT when STIBP
> +			unret,nosmt  - like unret, but will disable SMT when STIBP
>  			               is not available.
>  
>  			Selecting 'auto' will choose a mitigation method at run
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index fd5464ff714d..f710c012f1eb 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -152,7 +152,7 @@ void __init check_bugs(void)
>  	/*
>  	 * spectre_v2_user_select_mitigation() relies on the state set by
>  	 * retbleed_select_mitigation(); specifically the STIBP selection is
> -	 * forced for UNRET.
> +	 * forced for UNRET or IBPB.
>  	 */
>  	spectre_v2_user_select_mitigation();
>  	ssb_select_mitigation();
> @@ -1181,7 +1181,8 @@ spectre_v2_user_select_mitigation(void)
>  	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
>  		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
>  
> -	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
> +	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> +	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
>  		if (mode != SPECTRE_V2_USER_STRICT &&
>  		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
>  			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
> @@ -2346,10 +2347,11 @@ static ssize_t srbds_show_state(char *buf)
>  
>  static ssize_t retbleed_show_state(char *buf)
>  {
> -	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
> +	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
> +	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
>  	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> -		    return sprintf(buf, "Vulnerable: untrained return thunk on non-Zen uarch\n");
> +		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");

Well, you can't lump those together.

You can't especially say "Vulnerable" and "IBPB" in one line.

To quote from the BTC paper:

"Software may choose to perform an IBPB command on entry into privileged
code in order to avoid any previous branch prediction information from
subsequently being used. This effectively mitigates all forms of BTC for
scenarios like user-to-supervisor or VM-to-hypervisor attacks."

Especially if we disable SMT only on !STIBP parts:

        if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
            (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
                cpu_smt_disable(false);

If there are AMD parts which have IBPB but DO NOT have STIBP, then you
can say "Vulnerable... IBPB" but then you need to check for !STIBP and
issue that on a separate line.

I'd say...

-- 
Regards/Gruss,
    Boris.
