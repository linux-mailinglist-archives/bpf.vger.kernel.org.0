Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849861360C3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbgAITI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 14:08:27 -0500
Received: from namei.org ([65.99.196.166]:56530 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbgAITI1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 14:08:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 009J7gso000467;
        Thu, 9 Jan 2020 19:07:42 GMT
Date:   Fri, 10 Jan 2020 06:07:42 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@chromium.org>,
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
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF
 (KRSI)
In-Reply-To: <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.2001100558550.31925@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com> <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com> <201912301112.A1A63A4@keescook> <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org> <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov> <alpine.LRH.2.21.2001100437550.21515@namei.org> <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 9 Jan 2020, Stephen Smalley wrote:

> On 1/9/20 1:11 PM, James Morris wrote:
> > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > 
> > > The cover letter subject line and the Kconfig help text refer to it as a
> > > BPF-based "MAC and Audit policy".  It has an enforce config option that
> > > enables the bpf programs to deny access, providing access control. IIRC,
> > > in
> > > the earlier discussion threads, the BPF maintainers suggested that Smack
> > > and
> > > other LSMs could be entirely re-implemented via it in the future, and that
> > > such an implementation would be more optimal.
> > 
> > In this case, the eBPF code is similar to a kernel module, rather than a
> > loadable policy file.  It's a loadable mechanism, rather than a policy, in
> > my view.
> 
> I thought you frowned on dynamically loadable LSMs for both security and
> correctness reasons?

Evaluating the security impact of this is the next step. My understanding 
is that eBPF via BTF is constrained to read only access to hook 
parameters, and that its behavior would be entirely restrictive.

I'd like to understand the security impact more fully, though.  Can the 
eBPF code make arbitrary writes to the kernel, or read anything other than 
the correctly bounded LSM hook parameters?

> And a traditional security module would necessarily fall
> under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
> gateway for proprietary LSMs...

Right, we do not want this to be a GPL bypass.

If these issues can be resolved, this may be a "safe" way to support 
loadable LSM applications.

Again, I'd be interested in knowing how this is is handled in the 
networking stack (keeping in mind that LSM is a much more invasive API, 
and may not be directly comparable).

-- 
James Morris
<jmorris@namei.org>

