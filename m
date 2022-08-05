Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68AB58AF3B
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbiHERzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbiHERzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 13:55:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190065FB;
        Fri,  5 Aug 2022 10:55:37 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 718381EC04C2;
        Fri,  5 Aug 2022 19:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659722131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lgHt3P8hxmYNsCsO6oz+2j46ElNujepttLSppVvmEgo=;
        b=LhH4G9E2jS2NJtKOOrZhc5cvM3+7Wrv9VzdHWSsSgwvfMzg2i4SHyA0giKHc4WZ+vu6DWw
        yNR87bw4s/ZIL3vRfcdv9jPSqoamVpaCFtwHf2gWSNe/wr0bUiBy793oG1PF9N/MSAVJGN
        Nu3L3/WqLhVSJ8i5Be/Ek30EdBieORA=
Date:   Fri, 5 Aug 2022 19:55:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com
Subject: Re: [PATCH] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Message-ID: <Yu1Zj5mNZiAWdJgK@zn.tnic>
References: <20220804192201.439596-1-kim.phillips@amd.com>
 <Yu0sT6vCofyWiAMI@zn.tnic>
 <86921fe7-6a6b-2731-b09e-a6e03f38a6b9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86921fe7-6a6b-2731-b09e-a6e03f38a6b9@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 05, 2022 at 12:04:34PM -0500, Kim Phillips wrote:
> On 8/5/22 9:42 AM, Borislav Petkov wrote:
> > On Thu, Aug 04, 2022 at 02:22:01PM -0500, Kim Phillips wrote:
> > > For retbleed=ibpb, force STIBP on machines that have it,
> > 
> > Because?
> 
> See "6.1.2 IBPB On Privileged Mode Entry / SMT Safety":
> 
> https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v7_20220712.pdf
> 
> Did you want me to re-quote the whitepaper, or reference it,
> or paraphrase it, or...?

I would like for our commit messages to be fully standalone and explain
in detail why a change is being done. So that when doing git archeology
months, years from now it is perfectly clear why a change was needed.

This holds especially true for the CPU vuln nightmares.

So please explain the "why" of your change. In your own words.

> "{unret,ibpb} alone does not stop sibling threads influencing the predictions of
> other sibling threads.  For that reason, we use STIBP on processors that support
> it, and mitigate SMT on processors that don't."

Pretty much. I'd even explain each case explicitly:

                        ibpb         - mitigate short speculation windows on
                                       basic block boundaries too. Safe, highest
                                       perf impact. On AMD, it also enables STIBP if
				       present.
                        ibpb,nosmt   - like ibpb, but will disable SMT when STIBP
                                       is not available. This is the alternative for
				       systems which do not have STIBP.

> Those messages only get printed on non-AMD hardware?

See, I got confused by our spaghetti code from hell. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
