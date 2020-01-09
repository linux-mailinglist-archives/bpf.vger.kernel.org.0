Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA813614C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 20:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgAITnJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 14:43:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43585 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgAITnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 14:43:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so8648647wre.10
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jw28hdiJGOkCKx6DV/ZAWWtrssY8Hn/bW9QkvV8cGmI=;
        b=gq6zgGEYKGXFXM2EbpaV389P3IoxQr30Jnhm7/E2wfq734f+k9jU5i9vJZ/c5z4chQ
         pYXGDucfiGxafkwpCKXAQE9nFdGnpwkCYNwTt/AdJztjucF1TrS9VYHOScqW32D6Kw13
         GQWuzD0jelFWxHO2SpYpdOF1JOr2mhNRiWHmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jw28hdiJGOkCKx6DV/ZAWWtrssY8Hn/bW9QkvV8cGmI=;
        b=nejMxG58xQ1WooWwgmt/lliZi5lKBM/vhkAWy1uva/minGF3pJ3hcSmNyC/qWrPrHB
         L4Ov0tATKTu7l+u3mxiyFTMHUhkaRJIeKNgDORois3E7b11HvVaTT9+4BQC25dQLvYhA
         +bFHX5BEb/d3CgxoC7O6XKTF/Wuyzqgtm13HF3YYrXkejKXb1Thi7vkfbEzGoAaPQY1t
         aJm6UHUFjhHaBAtpHFfg6s+n+3DZtMH7pqlsl8Wi3JB+GuOeuGaaeugvh9klx/OQmzV4
         Mdbcj6dRgSDN2TprCczmVc/SbGcdR2AMa/T3iROc1mXJ6oaGtf3dEKEEV/H5p9JTh+A/
         yy4A==
X-Gm-Message-State: APjAAAV9P1IgATNcoFuGbhzvocCU2uiX7Gt4VM+A8NBHdKYEtiCH+oaA
        7aWJcqxTxO6AW2/oeOBhSistZQ==
X-Google-Smtp-Source: APXvYqxFrV0L2j8O/4RTuF6OYfIwcvV94yuOK6Qd6u8NVLbIqTCAF73WthoWgSDFZkahivXdF2VM/g==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr12573335wrq.176.1578598985376;
        Thu, 09 Jan 2020 11:43:05 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id r62sm4071750wma.32.2020.01.09.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:43:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 9 Jan 2020 20:43:02 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200109194302.GA85350@google.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2001100558550.31925@namei.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10-Jan 06:07, James Morris wrote:
> On Thu, 9 Jan 2020, Stephen Smalley wrote:
> 
> > On 1/9/20 1:11 PM, James Morris wrote:
> > > On Wed, 8 Jan 2020, Stephen Smalley wrote:
> > > 
> > > > The cover letter subject line and the Kconfig help text refer to it as a
> > > > BPF-based "MAC and Audit policy".  It has an enforce config option that
> > > > enables the bpf programs to deny access, providing access control. IIRC,
> > > > in
> > > > the earlier discussion threads, the BPF maintainers suggested that Smack
> > > > and
> > > > other LSMs could be entirely re-implemented via it in the future, and that
> > > > such an implementation would be more optimal.
> > > 
> > > In this case, the eBPF code is similar to a kernel module, rather than a
> > > loadable policy file.  It's a loadable mechanism, rather than a policy, in
> > > my view.
> > 
> > I thought you frowned on dynamically loadable LSMs for both security and
> > correctness reasons?

Based on the feedback from the lists we've updated the design for v2.

In v2, LSM hook callbacks are allocated dynamically using BPF
trampolines, appended to a separate security_hook_heads and run
only after the statically allocated hooks.

The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
still remains __lsm_ro_after_init and cannot be modified. We are still
working on v2 (not ready for review yet) but the general idea can be
seen here:

  https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c

> 
> Evaluating the security impact of this is the next step. My understanding 
> is that eBPF via BTF is constrained to read only access to hook 
> parameters, and that its behavior would be entirely restrictive.
> 
> I'd like to understand the security impact more fully, though.  Can the 
> eBPF code make arbitrary writes to the kernel, or read anything other than 
> the correctly bounded LSM hook parameters?
> 

As mentioned, the BPF verifier does not allow writes to BTF types.

> > And a traditional security module would necessarily fall
> > under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
> > gateway for proprietary LSMs...
> 
> Right, we do not want this to be a GPL bypass.

This is not intended to be a GPL bypass and the BPF verifier checks
for license compatibility of the loaded program with GPL.

- KP

> 
> If these issues can be resolved, this may be a "safe" way to support 
> loadable LSM applications.
> 
> Again, I'd be interested in knowing how this is is handled in the 
> networking stack (keeping in mind that LSM is a much more invasive API, 
> and may not be directly comparable).
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 
