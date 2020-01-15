Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3B13C4FC
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOOJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 09:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgAOOJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 09:09:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010802084D;
        Wed, 15 Jan 2020 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579097396;
        bh=FlFqqR3ep0w7X3r1X435q+1q/fXSDP3JlX8xmqhTkLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8shj0k0AugIqzFoz9BP5XRu1xSwT3KvR/6Wza1WB/ufg6Uqfq9HL9FHWbOj1p63I
         /wAlOTMEF4tyPGGfsoIaoqVjqRmrzu/nA455HScTMMcxviXg16UzEF29BFjjtl3+ia
         nh0Jjinc5D1oHzIbs3TV5JX0Cnu+sWwLksCMqISg=
Date:   Wed, 15 Jan 2020 15:09:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200115140953.GB3627564@kroah.com>
References: <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
 <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
 <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
 <49a45583-b4fb-6353-a8d4-6f49287b26eb@tycho.nsa.gov>
 <20200115024830.4ogd3mi5jy5hwr2v@ast-mbp.dhcp.thefacebook.com>
 <38a82df5-7610-efe1-d6cd-76f6f68c6110@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38a82df5-7610-efe1-d6cd-76f6f68c6110@tycho.nsa.gov>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 15, 2020 at 08:59:08AM -0500, Stephen Smalley wrote:
> On 1/14/20 9:48 PM, Alexei Starovoitov wrote:
> > On Tue, Jan 14, 2020 at 12:42:22PM -0500, Stephen Smalley wrote:
> > > On 1/14/20 11:54 AM, Stephen Smalley wrote:
> > > > On 1/10/20 12:53 PM, Alexei Starovoitov wrote:
> > > > > On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
> > > > > > On 09-Jan 14:47, Stephen Smalley wrote:
> > > > > > > On 1/9/20 2:43 PM, KP Singh wrote:
> > > > > > > > On 10-Jan 06:07, James Morris wrote:
> > > > > > > > > On Thu, 9 Jan 2020, Stephen Smalley wrote:
> > > > > > > > > 
> > > > > > > > > > On 1/9/20 1:11 PM, James Morris wrote:
> > > > > > > > > > > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > > > > > > > > > > 
> > > > > > > > > > > > The cover letter subject line and the
> > > > > > > > > > > > Kconfig help text refer to it as a
> > > > > > > > > > > > BPF-based "MAC and Audit policy".  It
> > > > > > > > > > > > has an enforce config option that
> > > > > > > > > > > > enables the bpf programs to deny access,
> > > > > > > > > > > > providing access control. IIRC,
> > > > > > > > > > > > in
> > > > > > > > > > > > the earlier discussion threads, the BPF
> > > > > > > > > > > > maintainers suggested that Smack
> > > > > > > > > > > > and
> > > > > > > > > > > > other LSMs could be entirely
> > > > > > > > > > > > re-implemented via it in the future, and
> > > > > > > > > > > > that
> > > > > > > > > > > > such an implementation would be more optimal.
> > > > > > > > > > > 
> > > > > > > > > > > In this case, the eBPF code is similar to a
> > > > > > > > > > > kernel module, rather than a
> > > > > > > > > > > loadable policy file.  It's a loadable
> > > > > > > > > > > mechanism, rather than a policy, in
> > > > > > > > > > > my view.
> > > > > > > > > > 
> > > > > > > > > > I thought you frowned on dynamically loadable
> > > > > > > > > > LSMs for both security and
> > > > > > > > > > correctness reasons?
> > > > > > > > 
> > > > > > > > Based on the feedback from the lists we've updated the design for v2.
> > > > > > > > 
> > > > > > > > In v2, LSM hook callbacks are allocated dynamically using BPF
> > > > > > > > trampolines, appended to a separate security_hook_heads and run
> > > > > > > > only after the statically allocated hooks.
> > > > > > > > 
> > > > > > > > The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
> > > > > > > > still remains __lsm_ro_after_init and cannot be modified. We are still
> > > > > > > > working on v2 (not ready for review yet) but the general idea can be
> > > > > > > > seen here:
> > > > > > > > 
> > > > > > > >       https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Evaluating the security impact of this is the next
> > > > > > > > > step. My understanding
> > > > > > > > > is that eBPF via BTF is constrained to read only access to hook
> > > > > > > > > parameters, and that its behavior would be entirely restrictive.
> > > > > > > > > 
> > > > > > > > > I'd like to understand the security impact more
> > > > > > > > > fully, though.  Can the
> > > > > > > > > eBPF code make arbitrary writes to the kernel, or
> > > > > > > > > read anything other than
> > > > > > > > > the correctly bounded LSM hook parameters?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > As mentioned, the BPF verifier does not allow writes to BTF types.
> > > > > > > > 
> > > > > > > > > > And a traditional security module would necessarily fall
> > > > > > > > > > under GPL; is the eBPF code required to be
> > > > > > > > > > likewise?  If not, KRSI is a
> > > > > > > > > > gateway for proprietary LSMs...
> > > > > > > > > 
> > > > > > > > > Right, we do not want this to be a GPL bypass.
> > > > > > > > 
> > > > > > > > This is not intended to be a GPL bypass and the BPF verifier checks
> > > > > > > > for license compatibility of the loaded program with GPL.
> > > > > > > 
> > > > > > > IIUC, it checks that the program is GPL compatible if it
> > > > > > > uses a function
> > > > > > > marked GPL-only.  But what specifically is marked GPL-only
> > > > > > > that is required
> > > > > > > for eBPF programs using KRSI?
> > > > > > 
> > > > > > Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
> > > > > > specific verification for the v2 of the patch-set which would require
> > > > > > all BPF-LSM programs to be GPL.
> > > > > 
> > > > > I don't think it's a good idea to enforce license on the program.
> > > > > The kernel doesn't do it for modules.
> > > > > For years all of BPF tracing progs were GPL because they have to use
> > > > > GPL-ed helpers to do anything meaningful.
> > > > > So for KRSI just make sure that all helpers are GPL-ed as well.
> > > > 
> > > > IIUC, the example eBPF code included in this patch series showed a
> > > > program that used a GPL-only helper for the purpose of reporting event
> > > > output to userspace. But it could have just as easily omitted the use of
> > > > that helper and still implemented its own arbitrary access control model
> > > > on the LSM hooks to which it attached.  It seems like the question is
> > > > whether the kernel developers are ok with exposing the entire LSM hook
> > > > interface and all the associated data structures to non-GPLd code,
> > > > irrespective of what helpers it may or may not use.
> > > 
> > > Also, to be clear, while kernel modules aren't necessarily GPL, prior to
> > > this patch series, all Linux security modules were necessarily GPLd in order
> > > to use the LSM interface.
> > 
> > Because they use securityfs_create_file() GPL-ed api, right?
> > but not because module license is enforced.
> 
> No, securityfs was a later addition and is not required by all LSMs either.
> Originally LSMs had to register their hooks via register_security(), which
> was intentionally EXPORT_SYMBOL_GPL() to avoid exposing the LSM interface to
> non-GPLd modules because there were significant concerns with doing so when
> LSM was first merged.  Then in 20510f2f4e2dabb0ff6c13901807627ec9452f98
> ("security: Convert LSM into a static interface"), the ability for loadable
> modules to use register_security() at all was removed, limiting its use to
> built-in modules.  In commit b1d9e6b0646d0e5ee5d9050bd236b6c65d66faef ("LSM:
> Switch to lists of hooks"), register_security() was replaced by
> security_add_hooks(), but this was likewise not exported for use by modules
> and could only be used by built-in code.  The bpf LSM is providing a shim
> that allows eBPF code to attach to these hooks that would otherwise not be
> exposed to non-GPLd code, so if the bpf LSM does not require the eBPF
> programs to also be GPLd, then that is a change from current practice.
> 
> > > So allowing non-GPL eBPF-based LSMs would be a
> > > change.
> > 
> > I don't see it this way. seccomp progs technically unlicensed. Yet they can
> > disallow any syscall. Primitive KRSI progs like
> > int bpf-prog(void*) { return REJECT; }
> > would be able to do selectively disable a syscall with an overhead acceptable
> > in production systems (unlike seccomp). I want this use case to be available to
> > people. It's a bait, because to do real progs people would need to GPL them.
> > Key helpers bpf_perf_event_output, bpf_ktime_get_ns, bpf_trace_printk are all
> > GPL-ed. It may look that most networking helpers are not-GPL, but real life is
> > different. To debug programs bpf_trace_printk() is necessary. To have
> > communication with user space bpf_perf_event_output() is necssary. To measure
> > anything or implement timestamps bpf_ktime_get_ns() is necessary. So today all
> > meaninful bpf programs are GPL. Those that are not GPL probably exist, but
> > they're toy programs. Hence I have zero concerns about GPL bypass coming from
> > tracing, networking, and, in the future, KRSI progs too.
> 
> You have more confidence than I do about that.  I would anticipate
> developers of out-of-tree LSMs latching onto this bpf LSM and using it to
> avoid GPL.  I don't see that any of those helpers are truly needed to
> implement an access control model.

Yeah, I'm with Stephen here, this should be explicitly marked for
GPL-only bpf code to prevent anyone from trying to route around the LSM
apis we have today.  We have enough problem with companies trying to do
that as-is, let's not give them any other ways to abuse our license.

thanks,

greg k-h
