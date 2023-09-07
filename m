Return-Path: <bpf+bounces-9435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055F7979F7
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EE51C20A05
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707113AEB;
	Thu,  7 Sep 2023 17:25:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FF13AE7
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 17:25:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FE10FB;
	Thu,  7 Sep 2023 10:25:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7A341F8B0;
	Thu,  7 Sep 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1694097665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/GWuQ82O0cqDWnLwHLamdkhZxjacO2j0BJIXilWXjc=;
	b=G8pcgQbRkAoNq1GD1BaIXvsUmciVqLKZ3+J18kyYCXaPXMgaX402fFxyOzzZx6Xl6D4t86
	mtFn0VpJdohH5CoNYW+E4K2M7VvAyKbz/BZEUjXCvJVeDURLzRTuxjrsZoohKBdPmwScJY
	5M00egnTaoz2lhQm/wCP5NCYQESf9mY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F6A138F9;
	Thu,  7 Sep 2023 14:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RTgBEwHh+WTSYwAAMHmgww
	(envelope-from <mkoutny@suse.com>); Thu, 07 Sep 2023 14:41:05 +0000
Date: Thu, 7 Sep 2023 16:41:04 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on
 cgroup1
Message-ID: <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpqfbqf66cnxpfb6"
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--lpqfbqf66cnxpfb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yafang.

On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@gmail.com> wrote:
> In our specific use case, we intend to use bpf_current_under_cgroup() to
> audit whether the current task resides within specific containers.

I wonder -- how does this work in practice?

If it's systemd hybrid setup, you can get the information from the
unified hierarchy which represents the container membership.

If it's a setup without the unified hierarchy, you have to pick one
hieararchy as a representation of the membership. Which one will it be?

> Subsequently, we can use this information to create distinct ACLs within
> our LSM BPF programs, enabling us to control specific operations performed
> by these tasks.

If one was serious about container-based ACLs, it'd be best to have a
dedicated and maintained hierarchy for this (I mean a named v1
hiearchy). But your implementation omits this, so this hints to me that
this scenario may already be better covered with querying the unified
hierarchy.

> Considering the widespread use of cgroup1 in container environments,
> coupled with the considerable time it will take to transition to cgroup2,
> implementing this change will significantly enhance the utility of BPF
> in container scenarios.

If a change like this is not accepted, will it make the transition
period shorter? (As written above, the unified hierarchy seems a better
fit for your use case.)

Thanks,
Michal

--lpqfbqf66cnxpfb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPng7wAKCRAGvrMr/1gc
juZAAQCCMKwWVeLjjokOs8ldESgvMuN/3xsmMmJaDv8ZAb2i4wD/VRDN7bDKUdMi
1L4tP03C2+tFBp0Y/7+DtsLxIGHuYQw=
=zosN
-----END PGP SIGNATURE-----

--lpqfbqf66cnxpfb6--

