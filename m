Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADFE308A3C
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhA2Qbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 11:31:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43504 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhA2Qb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 11:31:28 -0500
Received: from zn.tnic (p200300ec2f0c9a00bc6c1bcbdaab9684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:bc6c:1bcb:daab:9684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5929D1EC01B7;
        Fri, 29 Jan 2021 17:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611937847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=37ypfY0hcyBwq6ff9BIdbEdz5BSxq7t0VPLakd3OmOU=;
        b=J+YLSW9EWKGY6If2T9zKyjHGgY6x4bYBPaNCW9sNx/PtVhqqhiGAfvxNOSNuRcFYqdcK10
        HuXbSkVfhEn6EvOkb5GfGAkJ5uuQD34uOlfsZSEYuMtE0wqUcZpzrDldn223q7LVeN34Sx
        RUOmrLP+mvIAAb/hqyJqZf8kdNsctoI=
Date:   Fri, 29 Jan 2021 17:30:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210129163048.GD27841@zn.tnic>
References: <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129151034.iba4eaa2fuxsipqa@treble>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 09:10:34AM -0600, Josh Poimboeuf wrote:
> Maybe eventually.  But the enablement (actually enabling CET/CFI/etc)
> happens in the arch code anyway, right?  So it could be a per-arch
> decision.

Right.

Ok, for this one, what about

Cc: <stable@vger.kernel.org>

?

What are "some configurations of GCC"? If it can be reproduced with
what's released out there, maybe that should go in now, even for 5.11?

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
