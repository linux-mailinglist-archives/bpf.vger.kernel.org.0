Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04D135FFF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbgAISMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 13:12:53 -0500
Received: from namei.org ([65.99.196.166]:56486 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730353AbgAISMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 13:12:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 009IBcbB024844;
        Thu, 9 Jan 2020 18:11:38 GMT
Date:   Fri, 10 Jan 2020 05:11:38 +1100 (AEDT)
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
In-Reply-To: <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.2001100437550.21515@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com> <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com> <201912301112.A1A63A4@keescook> <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org> <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 8 Jan 2020, Stephen Smalley wrote:

> The cover letter subject line and the Kconfig help text refer to it as a
> BPF-based "MAC and Audit policy".  It has an enforce config option that
> enables the bpf programs to deny access, providing access control. IIRC, in
> the earlier discussion threads, the BPF maintainers suggested that Smack and
> other LSMs could be entirely re-implemented via it in the future, and that
> such an implementation would be more optimal.

In this case, the eBPF code is similar to a kernel module, rather than a 
loadable policy file.  It's a loadable mechanism, rather than a policy, in 
my view.

This would be similar to the difference between iptables rules and 
loadable eBPF networking code.  I'd be interested to know how the 
eBPF networking scenarios are handled wrt kernel ABI.


> Again, not arguing for or against, but wondering if people fully understand
> the implications.  If it ends up being useful, people will build access
> control systems with it, and it directly exposes a lot of kernel internals to
> userspace.  There was a lot of concern originally about the LSM hook interface
> becoming a stable ABI and/or about it being misused.  Exposing that interface
> along with every kernel data structure exposed through it to userspace seems
> like a major leap.

Agreed this is a leap, although I'm not sure I'd characterize it as 
exposure to userspace -- it allows dynamic extension of the LSM API from 
userland, but the code is executed in the kernel.

KP: One thing I'd like to understand better is the attack surface 
introduced by this.  IIUC, the BTF fields are read only, so the eBPF code 
should not be able to modify any LSM parameters, correct?


>  Even if the mainline kernel doesn't worry about any kind
> of stable interface guarantees for it, the distros might be forced to provide
> some kABI guarantees for it to appease ISVs and users...

How is this handled currently for other eBPF use-cases?

-- 
James Morris
<jmorris@namei.org>

