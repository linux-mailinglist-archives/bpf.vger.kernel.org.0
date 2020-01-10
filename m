Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A56137547
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgAJRxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 12:53:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34800 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgAJRxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id x17so1130056pln.1;
        Fri, 10 Jan 2020 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CDQhFdn9jkHo+6/IKHK0dztZerzShVqNerNdFNibYI=;
        b=huBJfB29GhBFOE6ibGq9rZro83Y9Ry5BVWo7VwnsQnYFJ4BgczzUmF8H9eGx6jMZ2S
         E7AfCJD4D2kIMp2dTi3SBsXGrju8f7kZHinSSNyqCbc/2hQOefdlR8X+fCeAHtGB6P4N
         zPf64RFjC82FB2fAeTw6K61/viGwGsDCShGaVxiZSIfuFVzH4rm0YSwHdm/9zG3Km+ZX
         0LFaoJDiYy6uRdUiUSi6RyUCn7tB9R9BoY+qvuwa3v1pgAfeaMdAOuRbC/rXJTdSEBBo
         Z0K7m3OF6X0T3n+T5vYsQen7lAih4jZSeI3+6CdNEPvNXEEB+tNg7lm8KUf42GW16loT
         VDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CDQhFdn9jkHo+6/IKHK0dztZerzShVqNerNdFNibYI=;
        b=sDJnwVhzgcJ1idgb9GoTPjwPdZ5LI2ZmtWUMbgnL9rajxW0jjAfoDEyy0GZCcIFLTZ
         zoJGGyYpd0u1CLYNM4pbG9gaPWd4MI8NSUERueZd2MK+ZIs5Ga0a3q04+iiEEuuAzn4E
         sKEEUaZj+IHWH+5peMBIt+EFBT7pnxLQWNp8hx6RMEIQObw2bKTdUNL+moG2fhfj5J+H
         bzzLte1FHutOhfOaK9JBA+pcWuUQsMLdOCOZWhzTF50h5MNFvAArp5zQY4qe5D8RyKRY
         5qFR0W6uCcQRjE5/rIC5z+slbWJlUFqJYNS2OjN449+vdH5SOPucomQHeexFuWG4ysVs
         w1RQ==
X-Gm-Message-State: APjAAAXomNmfpnLjJ+ijZMUuq3KWmH3EXprA2DII+8YU55qL283DSiWW
        9uj850cSw2IEf/jeLKI7xX4=
X-Google-Smtp-Source: APXvYqxSppu3yeNvSqY0JqfiaAqCaesNlytAiUS9HnsE+dbJvdkreE5lle13ppca3R6I/dd3W3n5rA==
X-Received: by 2002:a17:902:343:: with SMTP id 61mr5753565pld.332.1578678788962;
        Fri, 10 Jan 2020 09:53:08 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::2:ba5e])
        by smtp.gmail.com with ESMTPSA id w3sm1423944pgj.48.2020.01.10.09.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:53:08 -0800 (PST)
Date:   Fri, 10 Jan 2020 09:53:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
References: <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110152758.GA260168@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
> On 09-Jan 14:47, Stephen Smalley wrote:
> > On 1/9/20 2:43 PM, KP Singh wrote:
> > > On 10-Jan 06:07, James Morris wrote:
> > > > On Thu, 9 Jan 2020, Stephen Smalley wrote:
> > > > 
> > > > > On 1/9/20 1:11 PM, James Morris wrote:
> > > > > > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > > > > > 
> > > > > > > The cover letter subject line and the Kconfig help text refer to it as a
> > > > > > > BPF-based "MAC and Audit policy".  It has an enforce config option that
> > > > > > > enables the bpf programs to deny access, providing access control. IIRC,
> > > > > > > in
> > > > > > > the earlier discussion threads, the BPF maintainers suggested that Smack
> > > > > > > and
> > > > > > > other LSMs could be entirely re-implemented via it in the future, and that
> > > > > > > such an implementation would be more optimal.
> > > > > > 
> > > > > > In this case, the eBPF code is similar to a kernel module, rather than a
> > > > > > loadable policy file.  It's a loadable mechanism, rather than a policy, in
> > > > > > my view.
> > > > > 
> > > > > I thought you frowned on dynamically loadable LSMs for both security and
> > > > > correctness reasons?
> > > 
> > > Based on the feedback from the lists we've updated the design for v2.
> > > 
> > > In v2, LSM hook callbacks are allocated dynamically using BPF
> > > trampolines, appended to a separate security_hook_heads and run
> > > only after the statically allocated hooks.
> > > 
> > > The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
> > > still remains __lsm_ro_after_init and cannot be modified. We are still
> > > working on v2 (not ready for review yet) but the general idea can be
> > > seen here:
> > > 
> > >    https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
> > > 
> > > > 
> > > > Evaluating the security impact of this is the next step. My understanding
> > > > is that eBPF via BTF is constrained to read only access to hook
> > > > parameters, and that its behavior would be entirely restrictive.
> > > > 
> > > > I'd like to understand the security impact more fully, though.  Can the
> > > > eBPF code make arbitrary writes to the kernel, or read anything other than
> > > > the correctly bounded LSM hook parameters?
> > > > 
> > > 
> > > As mentioned, the BPF verifier does not allow writes to BTF types.
> > > 
> > > > > And a traditional security module would necessarily fall
> > > > > under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
> > > > > gateway for proprietary LSMs...
> > > > 
> > > > Right, we do not want this to be a GPL bypass.
> > > 
> > > This is not intended to be a GPL bypass and the BPF verifier checks
> > > for license compatibility of the loaded program with GPL.
> > 
> > IIUC, it checks that the program is GPL compatible if it uses a function
> > marked GPL-only.  But what specifically is marked GPL-only that is required
> > for eBPF programs using KRSI?
> 
> Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
> specific verification for the v2 of the patch-set which would require
> all BPF-LSM programs to be GPL.

I don't think it's a good idea to enforce license on the program.
The kernel doesn't do it for modules.
For years all of BPF tracing progs were GPL because they have to use
GPL-ed helpers to do anything meaningful.
So for KRSI just make sure that all helpers are GPL-ed as well.
