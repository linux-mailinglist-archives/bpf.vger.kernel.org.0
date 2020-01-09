Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6513601A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbgAISX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 13:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgAISX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 13:23:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1498E2067D;
        Thu,  9 Jan 2020 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578594207;
        bh=dd8EZ98uqK9j/Oi18ACAq5NTaNf++Pvoytvm/sNE+kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6jaL5GY6Q8j7Hix4nuqr0SocWjFn9qv6xxpg7JI2qICGbUi8ugQenpQMkEfSfC/D
         A3B2kTbzWuDV6E/gYyk0YrAUdgUT0fgqFUUu39awk4gAAVsSkpT9W+FkBbkqqYi/k0
         fykNo+rcgdgxZwYRTdjkrs0P3gPVYw2cPDOOCrxw=
Date:   Thu, 9 Jan 2020 19:23:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
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
Message-ID: <20200109182324.GC591973@kroah.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2001100437550.21515@namei.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 10, 2020 at 05:11:38AM +1100, James Morris wrote:
> On Wed, 8 Jan 2020, Stephen Smalley wrote:
> 
> > The cover letter subject line and the Kconfig help text refer to it as a
> > BPF-based "MAC and Audit policy".  It has an enforce config option that
> > enables the bpf programs to deny access, providing access control. IIRC, in
> > the earlier discussion threads, the BPF maintainers suggested that Smack and
> > other LSMs could be entirely re-implemented via it in the future, and that
> > such an implementation would be more optimal.
> 
> In this case, the eBPF code is similar to a kernel module, rather than a 
> loadable policy file.  It's a loadable mechanism, rather than a policy, in 
> my view.
> 
> This would be similar to the difference between iptables rules and 
> loadable eBPF networking code.  I'd be interested to know how the 
> eBPF networking scenarios are handled wrt kernel ABI.

I already know of some people who pre-compile ebpf programs based on a
number of "supported" kernel versions and then load the needed one at
runtime.

Messy, yes, but you are right, ebpf code is much more similiar to a
kernel module than userspace code at the moment.

thanks,

greg k-h
