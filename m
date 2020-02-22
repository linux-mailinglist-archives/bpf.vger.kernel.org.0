Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF0168AEA
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2020 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBVAXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 19:23:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39277 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgBVAXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 19:23:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so1505417pjr.4
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bBY25iQUbzVgktSS3PZnQBwBrockb4rDmUnT5ayY4W0=;
        b=KYe9SL5tP1bdn68kTqujiJm5up+hzdnsaARmh4bdlCpEz5CTWlJmMqbXF23qXS46t/
         /xCG+rxjY57VF7MRAZLLWiXEmkIa+y1LEi2FbKI91U1iOyf8BgOJu+x/b9BrQsdL/cuW
         KaSOFClYDKVbD40o3NLsYQ4NoQmPQVSOdoR78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBY25iQUbzVgktSS3PZnQBwBrockb4rDmUnT5ayY4W0=;
        b=I05FtVXj4XxqQQ/urj2nojFT/orNyjddaegJxtu7rOSUHc5i6u3SJcd1tlBU7V2ORo
         894LhIAB3QcdN50A64i+zdLqRnsvOE/ViaFUcJSTHmD7ue/MuCDgu8fMDZL26WnrCO6C
         PzjiBSVgPi8SXot3sKTfPPGn/zQGsVdPn+cCP1bL1VzMGjhjWDahdcgWpxW/VsZ8xFyh
         zAzeloZcwF6VjL31NfOOrM8qLe2Y9yZZG0LUWW8rWZYpXXVgRWsSGmwH2mdPFeQVJhA4
         1JezOpXOiMGbhj05N7V5xS5M6cLph02mKV4NNDZx923PyoX7hf4mg6KbAW1pZlpvTc/b
         9N3w==
X-Gm-Message-State: APjAAAWd9sGPyiMfwP/jtSd4Z64uHDShkRP+ueSo5uG2wBApUocrl5Fe
        dIGdQLKdee7eDrrV/ZaH4FegZw==
X-Google-Smtp-Source: APXvYqzNBqha2t5b+jrIcavlt5+4Ugc8asp+93Ys4viKGNMi+g6a97cf6h6+OAgEgFu8gPdr+EDcYA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr38040623plb.202.1582330981149;
        Fri, 21 Feb 2020 16:23:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm3493639pgi.48.2020.02.21.16.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:23:00 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:22:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202002211617.28EAC6826@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
 <20200221194149.GA9207@chromium.org>
 <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 21, 2020 at 02:31:18PM -0800, Casey Schaufler wrote:
> On 2/21/2020 11:41 AM, KP Singh wrote:
> > On 21-Feb 11:19, Casey Schaufler wrote:
> >> On 2/20/2020 9:52 AM, KP Singh wrote:
> >>> From: KP Singh <kpsingh@google.com>
> >>> # v3 -> v4
> >>>
> >>>   https://lkml.org/lkml/2020/1/23/515
> >>>
> >>> * Moved away from allocating a separate security_hook_heads and adding a
> >>>   new special case for arch_prepare_bpf_trampoline to using BPF fexit
> >>>   trampolines called from the right place in the LSM hook and toggled by
> >>>   static keys based on the discussion in:
> >>>
> >>>     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com/
> >>>
> >>> * Since the code does not deal with security_hook_heads anymore, it goes
> >>>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
> >> I've finally been able to review the entire patch set.
> >> I can't imagine how it can make sense to add this much
> >> complexity to the LSM infrastructure in support of this
> >> feature. There is macro magic going on that is going to
> >> break, and soon. You are introducing dependencies on BPF
> >> into the infrastructure, and that's unnecessary and most
> >> likely harmful.
> > We will be happy to document each of the macros in detail. Do note a
> > few things here:
> >
> > * There is really nothing magical about them though,
> 
> 
> +#define LSM_HOOK_void(NAME, ...) \
> +	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
> +
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> 
> I haven't seen anything this ... novel ... in a very long time.
> I see why you want to do this, but you're tying the two sets
> of code together unnaturally. When (not if) the two sets diverge
> you're going to be introducing another clever way to deal with
> the special case.

I really like this approach: it actually _simplifies_ the LSM piece in
that there is no need to keep the union and the hook lists in sync any
more: they're defined once now. (There were already 2 lists, and this
collapses the list into 1 place for all 3 users.) It's very visible in
the diffstat too (~300 lines removed):

 include/linux/lsm_hook_names.h | 353 +++++++++++++++++++
 include/linux/lsm_hooks.h      | 622 +--------------------------------
 2 files changed, 359 insertions(+), 616 deletions(-)

Also, there is no need to worry about divergence: the BPF will always
track the exposed LSM. Backward compat is (AIUI) explicitly a
non-feature.

I don't see why anything here is "harmful"?

-- 
Kees Cook
