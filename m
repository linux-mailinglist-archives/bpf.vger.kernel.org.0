Return-Path: <bpf+bounces-11703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7637BD9E6
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F38E1C208C7
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB718657;
	Mon,  9 Oct 2023 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ohEJz6V+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C1156C3
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:32:15 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B6A6;
	Mon,  9 Oct 2023 04:32:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E87A21852;
	Mon,  9 Oct 2023 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1696851132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lka4EhQ+PfckDimMyJ1s4IhaS8Im02gJVVZ6wo5LMIk=;
	b=ohEJz6V+g30/NaeQMOF8hsf0044n/jh1BxBTtpU7Fm9FUvageIHKf3XnaX0oFrIE1WHZ6n
	hnhSxS2AUOyAkk+43irRWKoUa7cgLBcAKFQ0tN5rEj5+3ePmbORXjrdA1rK23a6zwHoq0y
	y6EIyzQQVcSxVhc3yPAhuPyOsc2kiHo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F56813586;
	Mon,  9 Oct 2023 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hf6ZCrzkI2X2JAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Mon, 09 Oct 2023 11:32:12 +0000
Date: Mon, 9 Oct 2023 13:32:10 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, sinquersw@gmail.com, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1
 hierarchy
Message-ID: <5ne2cximagrsq7nzghbsmimrskz77drkj4ax2ktyawquvu2r77@dl4tujtwlnec>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7o6bfjie3zsxyai"
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--i7o6bfjie3zsxyai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sat, Oct 07, 2023 at 02:02:58PM +0000, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> Two new helpers are added for cgroup1 hierarchy:
>=20
> - task_cgroup1_id_within_hierarchy
>   Retrieves the associated cgroup ID of a task within a specific cgroup1
>   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
> - task_ancestor_cgroup1_id_within_hierarchy
>   Retrieves the associated ancestor cgroup ID of a task whithin a
>   specific cgroup1 hierarchy. The specific ancestor level is determined by
>   its ancestor level.
>=20
> These helper functions have been added to facilitate the tracing of tasks
> within a particular container or cgroup in BPF programs. It's important to
> note that these helpers are designed specifically for cgroup1.

Are this helpers need for any 3rd party task?

I *think* operating on `current` would be simpler wrt assumptions needed
for object presense.


> +u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierar=
chy_id)
> +{
> +	struct cgroup_root *root;
> +	struct cgroup *cgrp;
> +	u64 cgid =3D 0;
> +
> +	spin_lock_irq(&css_set_lock);
> +	list_for_each_entry(root, &cgroup_roots, root_list) {

This should be for_each_root() macro for better uniform style.


Michal


--i7o6bfjie3zsxyai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZSPkuAAKCRAGvrMr/1gc
jiaLAQDLIMQRWiecB+Ck5QDepM9NUvFYoHrb/9DgT9PCoAyrKwEAwGtrADKfGJZf
NEpLCZAgt/CY7rCJW9ZKTcTsL1o3agA=
=fDRJ
-----END PGP SIGNATURE-----

--i7o6bfjie3zsxyai--

