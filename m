Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF46E2B2A
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDNUgD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 16:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDNUgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 16:36:03 -0400
X-Greylist: delayed 687 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 13:35:58 PDT
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88C05B93;
        Fri, 14 Apr 2023 13:35:58 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 33EKNkHR004465;
        Fri, 14 Apr 2023 15:23:46 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 33EKNjAJ004464;
        Fri, 14 Apr 2023 15:23:45 -0500
Date:   Fri, 14 Apr 2023 15:23:45 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Message-ID: <20230414202345.GA3971@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com> <6436eea2.170a0220.97ead.52a8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6436eea2.170a0220.97ead.52a8@mx.google.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 14 Apr 2023 15:23:46 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 10:47:13AM -0700, Kees Cook wrote:

Hi, I hope the week is ending well for everyone.

> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > On Wed, Apr 12, 2023 at 12:33???AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
> > > are meant to allow highly-granular LSM-based control over the usage of BPF
> > > subsytem. Specifically, to control the creation of BPF maps and BTF data
> > > objects, which are fundamental building blocks of any modern BPF application.
> > >
> > > These new hooks are able to override default kernel-side CAP_BPF-based (and
> > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> > > implement LSM policies that could granularly enforce more restrictions on
> > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
> > > cases.
> > 
> > One of the hallmarks of the LSM has always been that it is
> > non-authoritative: it cannot unilaterally grant access, it can only
> > restrict what would have been otherwise permitted on a traditional
> > Linux system.  Put another way, a LSM should not undermine the Linux
> > discretionary access controls, e.g. capabilities.
> > 
> > If there is a problem with the eBPF capability-based access controls,
> > that problem needs to be addressed in how the core eBPF code
> > implements its capability checks, not by modifying the LSM mechanism
> > to bypass these checks.

> I think semantics matter here. I wouldn't view this as _bypassing_
> capability enforcement: it's just more fine-grained access control.
> 
> For example, in many places we have things like:
> 
> 	if (!some_check(...) && !capable(...))
> 		return -EPERM;
> 
> I would expect this is a similar logic. An operation can succeed if the
> access control requirement is met. The mismatch we have through-out the
> kernel is that capability checks aren't strictly done by LSM hooks. And
> this series conceptually, I think, doesn't violate that -- it's changing
> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
> yet here).
> 
> The reason CAP_BPF was created was because there was nothing else that
> would be fine-grained enough at the time.

This was one of the issues, among others, that the TSEM LSM we are
working to upstream, was designed to address and may be an avenue
forward.

TSEM, being narratival rather than deontologically based, provides a
framework for security permissions that are based on a
characterization of the event itself.  So the permissions are as
variable as the contents of whatever BPF related information is passed
to the bpf* LSM hooks [1].

Currently, the tsem_bpf_* hooks are generically modeled.  We would
certainly entertain any discussion or suggestions as to what elements
of the structures passed to the hooks would be useful with respect
to establishing security policies useful and appropriate to the BPF
community.

We don't want to get in the middle of the restrictive
vs. authoritative debate, but it would seem that the jury is
conclusively in on that issue and LSM hooks are not going to be
allowed to dismiss, or modify, any other security controls.

Hopefully the BPF ABI isn't tied to CAP_BPF as that would seem to make
it problematic to make controls more granular.

> Kees Cook

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

[1]: Plus developers don't need to write security policies, you test
your application in order to get the desired controls for a workload.
