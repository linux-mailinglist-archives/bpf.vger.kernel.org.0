Return-Path: <bpf+bounces-12864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5B7D172F
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 22:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1222826A0
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3492031A;
	Fri, 20 Oct 2023 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LYbLYInx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C1DA50
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 20:40:40 +0000 (UTC)
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD0D65
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697834438; bh=0tyHuoq7ukxabsiZKHTzk2ePpLaOW35wAKtGeJ1D824=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LYbLYInxF/o0MPHkGv1XjPVSL6Ui05EQ5Nwh1GaP94AYAOEXLaPRllhSgAXAoMMEqHw+BCG6KMup/THnQ8N1+IwEUr3m3DUzz+QqA+bGiSWwIEXg6I6RQxjPJ/t91zbxKPnngacXlpjfqIcPfcwU+hqKHQKbK0F6DYiVpC1ULVQDnccL0yu548+SjAksdqHvAohK/ph/zT1HOwpoVt5WNljLf5XwPbdCM+qmGtxuqBSToV9ofFkhtrijLBhdPvyuwVBG8Dws3Eb61Xp53lBz2PS3Lsd3HpbMO5n/xI4yQ/1X3yaYT5061SOTmgwvNuYAw1gE2joJTIYLho9eltPY2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697834438; bh=2QRPDRfbcEjwhcYstA2So2kUc1ZPy6LvYss2S9XGReH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uTF6wU2wJ4HYCMXgafXHyh2CM5Y0PC99ZceHK+4avVtm45YNHS585HCH8d3fGaWi9VVX3vFOuuAT3aaUOmAGnB9ug/d2wXiyDqdwZzivwO6+bnJyQFfiW21gBkViBkU/SPF/C3W6S1aHnJY++REsyIc4fqdv3QU7hhN+zN44HXNjx85oC9rRrTTDXUP58tGr5+H/l7P6/IuB43diLRmBluZHWhgbuJWQc/jBFOcA/MNEv26vXslMnGc8jQZV4SloD9k4M8RkXzUflMf5T1klDJk6vwRfPqoZC3FZYEQyJm69ERuYK2DJY6QCxXKqGP+IUpoojWJORocnM6wFU+Ygnw==
X-YMail-OSG: F5xAfWcVM1n_Si1_eT.TI_20zjDsPsrvPVF6m4HdERdpJYxaxO_N8u2o4yncx.7
 zdwWtixCjxsD4rbBcwHCFeF249lC27Aj_HKPbWW6E_0B19VJYNDbMBziOH3fFFzKDCbOfyARrNXG
 tzYSw0uY8QV4ZYmwUsVVgGAAebMTKI2x9XLlHAv9VXLJzlYGmzioDfRcqcnUDpn.t6JlzGFtjqAK
 mpVFYkgrIfQAj2HNO_BIYC1U0C3ZKXwZGwRhii4il0gr2LF9k_xcAQ7LOnGNMktLxbSmPILXZ9oL
 4bLNOLdCJMNdF_spzCp0eSeN59dJUTFVKtHQh5b3JVvYj_p9rCGSVPZtXGR73qzUgHIQEGSHukhU
 o.TfkXjV8V94BCNF04ODgt1pTakMsFcyl.vIYTbq7wVeqXHQcbxxNu.UPf.DqlWU.7ynCA5jbPCX
 N5nRglHLaJnenNmx0btulZoIuQ3IetA.DnJOPdBI6fgzF4Zhj0PePlTZpKnN6mxMscfxOBvGLYUZ
 MyoPGU1WrlDUwCyaipgvvy053579HwtS7e1gPSYWFbP.3zpbcdB1kw5qAK.H1CgxA_sHGdqZhbcH
 11oMuZvAeH3IfG2F6Rd9DyvXmg8QNnNNw8OchSpWb09LfA6Hkkp.axLtXmRgqCXGwzgsE_CAehAh
 43To51.dGPmTKM1uGDzNse1hlKcwXxttMoSF.crS53C8sU1sOKsATyosVCHnPuztxYxcb8GJ.hsD
 Wv3wLOWnSI.7MIQ5qacsyN3q03KNvbaBFA0my9Uwn.ICD3VVfyBp0KuUz11fcJtZxTolhV3lG.pt
 xJ0yF3SbT1yt1ZrKy8j.ETGe_r9yd20o7JIo6KLsaLCw1SuIQPVgMIiwElBtD9XunbGAsWEyZEUo
 rWqwZLrg2sNQRY2LwDDMAe9s6HAil9YHwlSJPV4ItE2GrABvb8YJx2QMiphXzaPFvbpqdrlZVhoq
 1DERoGgtNiK7gcAUMr9QMjQRpiVPkZoas4341JS4GNI00.7HxPdNHY2aS.ZABRdfi.k2HKPq.j9b
 GWHQjn.LDFFYoRBD_CgtDe0IuC6PVtcL4Mj3rjkdGFm2Jcx05guvW6ocOl3_3am0YQ52JlVoh7o3
 ia8MsvWCe5UVrKg1F7iVYj3rVTMQHsw9N6SpL23t7025JU40hYfXp_PPhAJvt3iT89x6Z_NNvrhe
 wRlUya4icvv_NVdFs4t1qdnCq0Q.zUc5qMq09qMXRcE.pFITBb1HlMKCcn1BRKbRnocHp0XiadiA
 v0NPbhRSUgLeEO6zhoK4HP4A.znuJ1t7pIcS.mN.c2FgiwuCy.pJzQzv4pG9GKS0bPWp6FawBLFx
 Jr0cDlJisgtfJpr670SyIVctiOsu4MFaJ69Ihlf1lvBpaWsQn8reqe7b1apofA9m9DA8oHRVDsYz
 lidtpYU1ik0YpyVOBBJnJXAlgu2fWdn5or8ToM6DURqhlWwEbagEJNwi5fR4HmHGLAGm7qWiFMBd
 W9Svms.HVRGfBqIUUjckpfgGu9gBsGkabzEt2LWOAgfWwfsDr46TgUtdiu8rSmcq9xrIisG8Ot8W
 Bk1Pu_SOvDRguO_ThOde5uzGGLEAKQVxsQO.ZuoYbK2qegBM59ljrnifqRfI8WYBa0xh1BPyg4_C
 a9FKHF1zs7Yu7fjYKSlCowzmg4nKadpQG_WsMJjwluBojgR_Dyyrl1H2uC2xDm2cGC6ampXdGiuE
 vxLNfyTdeeNxiKejxoBcgGNcf3HPfd3DYa513txQPSO.ikfRmrg4nEz.WLRbpzs8y_gE.XiaW_01
 z3YE_QuGeZiAYDJ98P6YvRoMut.EZ3aqeOyMhk7z8F0bH.syuit9t3Z0Wi_cNHqGArUeLOlpS1vR
 svU2R7hIfXBvGN5barbzwWGh6dOFdy817ZNpk3uEiuHZaE1TbLe7D7IvxxRfltRxFAJbAEPRVEii
 xP06_K13CTCkEPZxkLz4oIhEPXNX5Y9lPq5vOyHB09W6reYgBJ9AcxVPtp4mAH4rIsgD4Nw.SOHa
 EB.2UztYzAqPpQzKyd4kkMNecrxk6qIRuccWpz_J4DGYqP.ozbnaBO3AWHvCnFuQfxiSEMOwCoGr
 Lea5UQ8jvgCUoqQMOyZQNsHCFaXAgJ0NYM2gYAEw1CxC3vzHveBj4PnXsa2LnuSlS1nibbbIDowH
 8ddgD.s8K9BrMew0929EiRzvgDcKqLZBYYizCS.kYXN8NkQAMe3bNtabomWDq_fCjVtgH8o_uclU
 zy6BaUXJKReFmgFTVAGCEXg.3wxKfZoMoxZkjZwrm.t4PwMD7p974idEJ5rSZngMgGl8lPY7GiN5
 qx6u23kGGmIeUyFlq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 26126cbb-5042-43f6-aed0-e14ada6998b7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 20:40:38 +0000
Received: by hermes--production-ne1-68668bc7f7-pg4xv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4e6d5428ea504def3051c6bffc80b3a;
          Fri, 20 Oct 2023 20:40:36 +0000 (UTC)
Message-ID: <a47971c0-f692-4f48-92a0-4f15c73d05e7@schaufler-ca.com>
Date: Fri, 20 Oct 2023 13:40:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
 bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <1b9f0e3f-0ff3-5b2d-19fa-dfa83afab8a6@schaufler-ca.com>
 <36776914-189b-3f51-9b56-b4273a625005@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <36776914-189b-3f51-9b56-b4273a625005@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/4/2023 3:40 AM, Tetsuo Handa wrote:
> On 2023/10/02 0:19, Casey Schaufler wrote:
>>> I'm fine if security_loadable_hook_heads() (and related code) cannot be
>>> disabled by the kernel configuration.
>> CONFIG_SECURITY ensures that you will be unhappy.
> I don't care about Linux distributors who chose CONFIG_SECURITY=n in their
> kernel configurations. What I'm saying is that security_loadable_hook_heads
> (and related code) do not depend on some build-time configuration. Also, I
> don't care about Linux distributors who patch their kernel source code in
> order to remove security_loadable_hook_heads (and related code) before
> building their kernels.
>
> But if a kernel is targeted for specific environment where out-of-tree LKMs
> (e.g. storage driver, filesystems) are not required, the person/organization
> who builds that kernel can protect that kernel from out-of-tree LKMs
> (including LKM-based LSMs) by enforcing module signing functionality.
>
> Also if a kernel is ultimately targeted for specific environment where LKM
> support is not required, the person/organization who builds that kernel can
> protect that kernel from out-of-tree LKMs (including LKM-based LSMs) by
> disabling loadable module functionality.
>
> Linux distributors that I want to run LSMs are generally trying to support
> as much users/environments as possible. The combination of enabling loadable
> module functionality and not enforcing module signing functionality is a good
> balance for that purpose.
>
>> Even setting that aside, it's the developer's job to sell the code to
>> the communities involved. I could rant at certain distros for not including
>> Smack, but until such time as I've made doing that attractive it really
>> doesn't make any sense to do so. You don't think I've spent years on stacking
>> because I want to run Android containers on Ubuntu, do you?
> Which one ("the LSM community" or "the Linux distributors") do you mean by
> "the communities involved" ?

There's a reason I used the plural "communities" instead of the singular
"community". In the case of loadable LSMs we're talking about *at least*
the LSM developers, Linux distributors, networking developers, the performance
crowd, all those people wound up in secure/trusted boot, API and real-time.

> For out-of-tree LKMs (e.g. storage driver, filesystems) that can be loaded as
> a loadable kernel module, the provider/developer can directly sell the code to
> end users (i.e. they can sell without being accepted by the upstream Linux
> community and being enabled by the Linux distributors' kernel configurations).
>
> But for out-of-tree LSMs that cannot be loaded as a loadable kernel module,
> the provider/developer currently cannot directly sell the code to end users.
>
> You said
>
>   This makes it sound like LSMs are always developed for corporate use.
>   While that is generally true, we should acknowledge that the "sponsor"
>   of an LSM could be a corporation/government, a foundation or a hobbyist.
>   A large, comprehensive LSM from a billion dollar corporation in support
>   of a specific product should require more commitment than a small, targeted
>   LSM of general interest from joe@schlobotnit.org. I trust that we would
>   have the wisdom to make such a distinction, but I don't think we want to
>   scare off developers by making it sound like an LSM is something that only
>   a corporation can provide a support plan for.
>
> at https://lkml.kernel.org/r/847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com .
>
> But "it's the developer's job to sell the code to the communities involved" is
> too hard for alone developer who can write a code and provide support for that code
> but cannot afford doing activities for selling that code (e.g. limited involvement
> with communities).
>
> Your "it's the developer's job" comment sounds like "LSMs are always developed by
> those corporation/government who has much involvement with communities" which
> scares off developers who can't afford doing activities for selling that code.

Sorry, but you've chosen the wrong person to present that argument to.
Smack was developed without any corporate, government or foundation support.
I wrote it in a theater green room  during rehearsals for a production of
"Madmoiselle Modiste". It has, from time to time, received corporate support,
but is currently completely self funded. Yes, it's hard. Yes, the commitment
could well scare off many developers. If you want easy, create websites.

>
>>>> On a less happy note, you haven't addressed security blobs in any way. You
>>>> need to provide a mechanism to allow an LSM to share security blobs with
>>>> builtin LSMs and other loadable LSMs.
>>> Not all LKM-based LSMs need to use security blobs.
>> If you only want to support "minor" LSMs, those that don't use shared blobs,
>> the loadable list implementation will suit you just fine. And because you won't
>> be using any of the LSM infrastructure that needs the LSM ID, that won't be
>> an issue.
> Minor LSMs can work without using shared blobs managed by the LSM infrastructure.
> AKARI/CaitSith are LKM-based LSMs that do not need to use shared blobs managed by
> the LSM infrastructure. TOMOYO does not need an LSM ID value, but you are trying
> to make an LSM ID mandatory for using the LSM infrastructure.
>
>> You can make something that will work. Whether you can sell it upstream will
>> depend on any number of factors. But working code is always a great start.
> Selling a code to the upstream is not sufficient for allowing end users to use
> that code.
>
> For https://bugzilla.redhat.com/show_bug.cgi?id=542986 case, the reason that Red Hat
> does not enable Smack/TOMOYO/AppArmor is "Smack/TOMOYO/AppArmor are not attractive".

And YAMA is enabled because it *is* attractive to RedHat's support based business
model. Even if we did have loadable LSM support I doubt RedHat would even consider
enabling it. Their model is based on selling support.

> After all, requiring any LSMs to be built-in is an unreasonable barrier compared to
> other LKMs (e.g. storage driver, filesystems).
>

