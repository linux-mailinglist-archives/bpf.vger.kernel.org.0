Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58B715AD5C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLQ0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 11:26:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54785 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBLQ0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Feb 2020 11:26:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so2995280wmh.4
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2020 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Oq1AdUw8m9+Ejebod5uLNgdGrkCleSq0Jc+gdcY2Xc=;
        b=YpL67d8OFfQLpn88KHHeHpPU9M5tKjVFTcgq5WB9ADXua8Vw9eM8D2prp/DJjWvw5x
         IUn9CPoWMY9ErauDjliaZ0oyal2LyauacKjUhMC9MEyWAKMtuwKlz5y5xltvAr5Xm+4a
         LxQdRjGor2YzOi0pqFDJ9uvpsP70D/2xy3qaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Oq1AdUw8m9+Ejebod5uLNgdGrkCleSq0Jc+gdcY2Xc=;
        b=AfvaVP+bQLuqYDQEB4qYM6x4q2CZ7xxtAgII/Wmr354H8E7gEGD3B+XtEnr7H62qWH
         ElnYOCoOLSjN/QZJe6uuAXGJL5zjWUsKe5k8A2kA0/Ddw/whTJNihyHlMB53UvNTzA3a
         NzBFPT+sfScSulUx+C46f2u9m4n24xG3K2fPe2pULtViHs2j43IAsYu7rQMYm3uMwiig
         8KDGQT/Kqdr/am/dA1Kvf2JKzRx9t/rXTrqccmZOfdJ1ciC8lnwfjEXLd317KV6rjHTc
         RMCOSYmb5IUCXo0RCiT9lJo9Fj4o6Olvh98S1U8X1xjDbON0aU9MeO5X7gCl+w7WgMm7
         Z+4w==
X-Gm-Message-State: APjAAAWIW7heZibnW1joyfaGd/oNoNR5HcF9WmTPvEnsVARtarTHfeB/
        GRk8/wgvifArjWY36q01a0kS4A==
X-Google-Smtp-Source: APXvYqz35eTpzE3tOLY8FLLO74LVWtEJvvI50Wec8849cwajczF2fVsNZaWwaW+IbhiJCYa0NkM9Lg==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr13425209wml.116.1581524775975;
        Wed, 12 Feb 2020 08:26:15 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id s8sm1267535wrt.57.2020.02.12.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:26:15 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 12 Feb 2020 17:26:13 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>, KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200212162613.GB259057@google.com>
References: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
 <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
 <20200212024542.gdsafhvqykucdp4h@ast-mbp>
 <bee0fd08-b9f2-83e4-2882-475b81c74303@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee0fd08-b9f2-83e4-2882-475b81c74303@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12-Feb 07:52, Casey Schaufler wrote:
> On 2/11/2020 6:45 PM, Alexei Starovoitov wrote:
> > On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
> >> Another approach could be to have a special nop inside call_int_hook()
> >> macro which would then get patched to avoid these situations. Somewhat
> >> similar like static keys where it could be defined anywhere in text but
> >> with updating of call_int_hook()'s RC for the verdict.
> 
> Tell me again why you can't register your BPF hooks like all the
> other security modules do? You keep reintroducing BPF as a special
> case, and I don't see why.

I think we tried to answer this in the discussion we had:

 https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#meb1eea982e63be0806f9bba58e91160871803752

BPF should not allocate a wrapper (to be statically regsitered at
init) for each LSM hook and run the programs from within that as this
implies adding overhead across the board for every hook even if
it's never used (i.e. no BPF program is attached to the hook).

We can, with the suggestions discussed here, avoid adding unncessary
overhead for unused hooks. And, as Alexei mentioned, adding overhead
when not really needed is especially bad for LSM hooks like
sock_sendmsg.

The other LSMs do not provide dynamic / mutable hooks, so it makes
sense for them to register the hooks once at load time.

- KP

> > Sounds nice in theory. I couldn't quite picture how that would look
> > in the code, so I hacked:
> > diff --git a/security/security.c b/security/security.c
> > index 565bc9b67276..ce4bc1e5e26c 100644
> > --- a/security/security.c

[...]
