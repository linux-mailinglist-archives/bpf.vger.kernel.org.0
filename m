Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47171360CA
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgAITLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 14:11:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33628 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbgAITLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 14:11:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so8668775wrq.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VCnERlNOb8YhgeYQ/pqHHRSiRgRe3Wo0NvX3JaaKcS8=;
        b=DhUG7DVSwPgwTWwTuQqa+9ac/15/zkq8KDq1LyXt9P2r/hB4jgPF/wdkpAwwitW1w/
         Yw1ncdxhj1h1xmR3bnTVGYgx9vqeZ9TOp8Q5YfaeApe9I12PJZzgFMURzpY+OPgI15a4
         Fexvw8F5wcZmKpTYiVdv+PZVy/+Kym+/wM6Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VCnERlNOb8YhgeYQ/pqHHRSiRgRe3Wo0NvX3JaaKcS8=;
        b=P1gHR0VI2e4KbycznwreSanelGCgEN2tUqJLxSJtHxaL2pGReNbRcalP0SNyq6lbRq
         DjsqHIDDUiG+LuEjSy0UHcKqOWas2MUzWH9Swdtf0LJ5N0mfjHYwNiSgIAeHq0RlzcJf
         Flqq9eFtg35liCWPHyxBaq4fLSqn16NkN+nga7fs1ImEY/r2RFNM6x2uzZlHInmOeVZG
         EdedTUs31HMnrMznmpqfJBYL6nFe6ZYmesT4iLsBEltdukuf2hQVxiIT8BjkBcpeJxV3
         Gubf5cjc0OUESQRh3tk//87O9PQGaL6FCV260zBKHdJIPQMAbnJOl2Og6lQyz3yJJU3u
         5pHA==
X-Gm-Message-State: APjAAAU2KRpNcemYsD65Ld4kdQJJN7/gsaWpW6GMWjx0gSqSZUePCadw
        KqEWEdJ6l+9EPQ86WrjCRNgSqA==
X-Google-Smtp-Source: APXvYqxxWo37fIJf5Xfz49p7PCsn9MSEishKBdsp6/eF79xvuIAU/pnDyQmSV2/kSQfLuhQi+KsjjQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr11962302wrp.71.1578597092527;
        Thu, 09 Jan 2020 11:11:32 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3689862wmc.47.2020.01.09.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:11:31 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 9 Jan 2020 20:11:48 +0100
To:     James Morris <jmorris@namei.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200109191148.GA1894@chromium.org>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10-Jan 05:11, James Morris wrote:
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
> 
> 
> > Again, not arguing for or against, but wondering if people fully understand
> > the implications.  If it ends up being useful, people will build access
> > control systems with it, and it directly exposes a lot of kernel internals to
> > userspace.  There was a lot of concern originally about the LSM hook interface
> > becoming a stable ABI and/or about it being misused.  Exposing that interface
> > along with every kernel data structure exposed through it to userspace seems
> > like a major leap.
> 
> Agreed this is a leap, although I'm not sure I'd characterize it as 
> exposure to userspace -- it allows dynamic extension of the LSM API from 
> userland, but the code is executed in the kernel.
> 
> KP: One thing I'd like to understand better is the attack surface 
> introduced by this.  IIUC, the BTF fields are read only, so the eBPF code 
> should not be able to modify any LSM parameters, correct?
> 

That's correct, the verifier does not allow writes to BTF types:

from kernel/bpf/verifier.c:

        case PTR_TO_BTF_ID:
	if (type == BPF_WRITE) {
	        verbose(env, "Writes through BTF pointers are not allowed\n");
		return -EINVAL;
	}

We can also add additional checks on top of those added by the
verifier using the verifier_ops that each BPF program type can define. 

- KP

> 
> >  Even if the mainline kernel doesn't worry about any kind
> > of stable interface guarantees for it, the distros might be forced to provide
> > some kABI guarantees for it to appease ISVs and users...
> 
> How is this handled currently for other eBPF use-cases?
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 
