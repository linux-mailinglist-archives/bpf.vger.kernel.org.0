Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591D013B7F6
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 03:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOCsh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 21:48:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39142 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOCsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 21:48:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so5374786pjt.4;
        Tue, 14 Jan 2020 18:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sg5fwXgqypeNGg0cxshxZC3htmfkTgOsTSwPjyO8KRQ=;
        b=jSf0U8Oq1NHwfHbPcxjHWZJDCQiKzMJlXB+44XEvkicd1UEelGtlppjRzgl8aisFta
         zoNAal11qtUewecWoFqR+G1RykswiP/j247XR5CRkKlbvo29vgfVytKJmcVvLBbwn7K+
         NJaEjUoawr6RgKbb1dt9AwhGTwO8ur2rR0F57JS3AwJAill2h/f7MtbYEP8g6Ny13Gi4
         h2pFRz2rXoHjVirsMKzlPS1hDtTIvZhw4TTJDReo9zR4hI7VFIQnsitcm3rDx+lNxWo+
         3Y4ljlWjl1cy9hhqOp/wTv5bQCZp360eAfN0pB6Ee3QgwANxHA2zwn+E8U6Y5Q3RZGVB
         tiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sg5fwXgqypeNGg0cxshxZC3htmfkTgOsTSwPjyO8KRQ=;
        b=TfTCNCk0ACDFuntim3ysvnzGsgbMhQok/4ROxOAPU/2FGLWMHBA9XiJ+k90zcN+ENe
         4cYQvNoZ9ahA4P9xEkCIxV6HsbOCBMRI1rg012I53gGrrHnwbZRbrXxx5TzoR9mWYjpm
         KVAJYvTuAWWaffmcdOy25GK6CAomNVxdSX3DU2Ee+pOzuK69oBbWQgouDJT7V8frBFRZ
         uqpd3lN0HOuHeJ/rMfZR3DE20OFelW9pHQShEJgwanTZyf0bEFH1nCTqF0gkymxXWkh3
         fZvBncLdqgHeGoOTNBLE+XDqYSjZTmTTzVjslu+v7BIaHVvqKD0FlnMyQ0/3EqcfRJmq
         Li8Q==
X-Gm-Message-State: APjAAAW1f71bpB6+1hTX+3g++WA/kkcCOompec+O95hOXCCNqhO/3uqB
        7Bi8E/Laq46UefxoZiRwSd8=
X-Google-Smtp-Source: APXvYqzprJY/PXBVzlf3V6acMBTwUyrkNwszghAXBDVHCbqurohXr5NrtphwnRX50hsSrnYsWGJPsQ==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr32499554pjb.138.1579056516270;
        Tue, 14 Jan 2020 18:48:36 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::cae7])
        by smtp.gmail.com with ESMTPSA id c1sm20049859pfa.51.2020.01.14.18.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 18:48:35 -0800 (PST)
Date:   Tue, 14 Jan 2020 18:48:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
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
Message-ID: <20200115024830.4ogd3mi5jy5hwr2v@ast-mbp.dhcp.thefacebook.com>
References: <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
 <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
 <20200110152758.GA260168@google.com>
 <20200110175304.f3j4mtach4mccqtg@ast-mbp.dhcp.thefacebook.com>
 <554ab109-0c23-aa82-779f-732d10f53d9c@tycho.nsa.gov>
 <49a45583-b4fb-6353-a8d4-6f49287b26eb@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a45583-b4fb-6353-a8d4-6f49287b26eb@tycho.nsa.gov>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 12:42:22PM -0500, Stephen Smalley wrote:
> On 1/14/20 11:54 AM, Stephen Smalley wrote:
> > On 1/10/20 12:53 PM, Alexei Starovoitov wrote:
> > > On Fri, Jan 10, 2020 at 04:27:58PM +0100, KP Singh wrote:
> > > > On 09-Jan 14:47, Stephen Smalley wrote:
> > > > > On 1/9/20 2:43 PM, KP Singh wrote:
> > > > > > On 10-Jan 06:07, James Morris wrote:
> > > > > > > On Thu, 9 Jan 2020, Stephen Smalley wrote:
> > > > > > > 
> > > > > > > > On 1/9/20 1:11 PM, James Morris wrote:
> > > > > > > > > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > > > > > > > > 
> > > > > > > > > > The cover letter subject line and the
> > > > > > > > > > Kconfig help text refer to it as a
> > > > > > > > > > BPF-based "MAC and Audit policy".  It
> > > > > > > > > > has an enforce config option that
> > > > > > > > > > enables the bpf programs to deny access,
> > > > > > > > > > providing access control. IIRC,
> > > > > > > > > > in
> > > > > > > > > > the earlier discussion threads, the BPF
> > > > > > > > > > maintainers suggested that Smack
> > > > > > > > > > and
> > > > > > > > > > other LSMs could be entirely
> > > > > > > > > > re-implemented via it in the future, and
> > > > > > > > > > that
> > > > > > > > > > such an implementation would be more optimal.
> > > > > > > > > 
> > > > > > > > > In this case, the eBPF code is similar to a
> > > > > > > > > kernel module, rather than a
> > > > > > > > > loadable policy file.  It's a loadable
> > > > > > > > > mechanism, rather than a policy, in
> > > > > > > > > my view.
> > > > > > > > 
> > > > > > > > I thought you frowned on dynamically loadable
> > > > > > > > LSMs for both security and
> > > > > > > > correctness reasons?
> > > > > > 
> > > > > > Based on the feedback from the lists we've updated the design for v2.
> > > > > > 
> > > > > > In v2, LSM hook callbacks are allocated dynamically using BPF
> > > > > > trampolines, appended to a separate security_hook_heads and run
> > > > > > only after the statically allocated hooks.
> > > > > > 
> > > > > > The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
> > > > > > still remains __lsm_ro_after_init and cannot be modified. We are still
> > > > > > working on v2 (not ready for review yet) but the general idea can be
> > > > > > seen here:
> > > > > > 
> > > > > >      https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Evaluating the security impact of this is the next
> > > > > > > step. My understanding
> > > > > > > is that eBPF via BTF is constrained to read only access to hook
> > > > > > > parameters, and that its behavior would be entirely restrictive.
> > > > > > > 
> > > > > > > I'd like to understand the security impact more
> > > > > > > fully, though.  Can the
> > > > > > > eBPF code make arbitrary writes to the kernel, or
> > > > > > > read anything other than
> > > > > > > the correctly bounded LSM hook parameters?
> > > > > > > 
> > > > > > 
> > > > > > As mentioned, the BPF verifier does not allow writes to BTF types.
> > > > > > 
> > > > > > > > And a traditional security module would necessarily fall
> > > > > > > > under GPL; is the eBPF code required to be
> > > > > > > > likewise?  If not, KRSI is a
> > > > > > > > gateway for proprietary LSMs...
> > > > > > > 
> > > > > > > Right, we do not want this to be a GPL bypass.
> > > > > > 
> > > > > > This is not intended to be a GPL bypass and the BPF verifier checks
> > > > > > for license compatibility of the loaded program with GPL.
> > > > > 
> > > > > IIUC, it checks that the program is GPL compatible if it
> > > > > uses a function
> > > > > marked GPL-only.  But what specifically is marked GPL-only
> > > > > that is required
> > > > > for eBPF programs using KRSI?
> > > > 
> > > > Good point! If no-one objects, I can add it to the BPF_PROG_TYPE_LSM
> > > > specific verification for the v2 of the patch-set which would require
> > > > all BPF-LSM programs to be GPL.
> > > 
> > > I don't think it's a good idea to enforce license on the program.
> > > The kernel doesn't do it for modules.
> > > For years all of BPF tracing progs were GPL because they have to use
> > > GPL-ed helpers to do anything meaningful.
> > > So for KRSI just make sure that all helpers are GPL-ed as well.
> > 
> > IIUC, the example eBPF code included in this patch series showed a
> > program that used a GPL-only helper for the purpose of reporting event
> > output to userspace. But it could have just as easily omitted the use of
> > that helper and still implemented its own arbitrary access control model
> > on the LSM hooks to which it attached.  It seems like the question is
> > whether the kernel developers are ok with exposing the entire LSM hook
> > interface and all the associated data structures to non-GPLd code,
> > irrespective of what helpers it may or may not use.
> 
> Also, to be clear, while kernel modules aren't necessarily GPL, prior to
> this patch series, all Linux security modules were necessarily GPLd in order
> to use the LSM interface. 

Because they use securityfs_create_file() GPL-ed api, right?
but not because module license is enforced.

> So allowing non-GPL eBPF-based LSMs would be a
> change.

I don't see it this way. seccomp progs technically unlicensed. Yet they can
disallow any syscall. Primitive KRSI progs like
int bpf-prog(void*) { return REJECT; }
would be able to do selectively disable a syscall with an overhead acceptable
in production systems (unlike seccomp). I want this use case to be available to
people. It's a bait, because to do real progs people would need to GPL them.
Key helpers bpf_perf_event_output, bpf_ktime_get_ns, bpf_trace_printk are all
GPL-ed. It may look that most networking helpers are not-GPL, but real life is
different. To debug programs bpf_trace_printk() is necessary. To have
communication with user space bpf_perf_event_output() is necssary. To measure
anything or implement timestamps bpf_ktime_get_ns() is necessary. So today all
meaninful bpf programs are GPL. Those that are not GPL probably exist, but
they're toy programs. Hence I have zero concerns about GPL bypass coming from
tracing, networking, and, in the future, KRSI progs too.
