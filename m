Return-Path: <bpf+bounces-21041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC4846E84
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B71282218
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017D113D4E4;
	Fri,  2 Feb 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPIMzNqs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPIMzNqs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABF7D3FD;
	Fri,  2 Feb 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871608; cv=none; b=uovaAo9BFsgPPSEPBXUZtO6MRIxU1aC1zuVXCF1DFRpzA+0K4I5onK4djj+SnGkhF7rdAJYlYTofgxYC5zFvY00il6EILBbh6cK/S4reRgaXCyzCPt1Jo+sSswYE3e1CwLtLjPIerFe453g1gA/FgU5qYSKkFr68eVBZLuHIvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871608; c=relaxed/simple;
	bh=1J23AqGmkaUeA46ekT+PNdzzWKimIUQMttmnToQg6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs1cmgdtzFzI72DKCjS+nIEFpflyPS4/c1A+2+A/oy6x5AhhQseJ4ahLP5GFAL5r1W1uXy9y5bn/kVM9Ncau5/OsJ7QB8r+QogKFKXPvLM1U6X4ETQY/JUEu5KGKS9uJMfgpSyfVionnxn/4be6FMmTMIHB2gOUJpT8jOocHWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPIMzNqs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPIMzNqs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9308E1F745;
	Fri,  2 Feb 2024 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706871604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1J23AqGmkaUeA46ekT+PNdzzWKimIUQMttmnToQg6Jo=;
	b=KPIMzNqsrtTVT9Akj7NVZ7qdQWv3GIWzc0C7h17MLej9JI6OveIunt6kuE/Z+t5TTE8012
	XaEaRrkS2G0QjquGrMig7I3/2uZqkBQrVqmyEZiSS+1dv49pgxNs/dOHoXLOqLGMgd+XWG
	p00czaocOFmgGms+GGjTzP1X/R0evSo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706871604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1J23AqGmkaUeA46ekT+PNdzzWKimIUQMttmnToQg6Jo=;
	b=KPIMzNqsrtTVT9Akj7NVZ7qdQWv3GIWzc0C7h17MLej9JI6OveIunt6kuE/Z+t5TTE8012
	XaEaRrkS2G0QjquGrMig7I3/2uZqkBQrVqmyEZiSS+1dv49pgxNs/dOHoXLOqLGMgd+XWG
	p00czaocOFmgGms+GGjTzP1X/R0evSo=
Date: Fri, 2 Feb 2024 12:00:03 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, cake@lists.bufferbloat.net, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>, Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: Re: [PATCH v4 0/4] net/sched: Load modules via alias
Message-ID: <buiepqadcof3cz6c7dporffaffe4ueqjqg3utapvglxukho36x@oxnkxq4afdtk>
References: <20240123135242.11430-1-mkoutny@suse.com>
 <CAM0EoMkA1Hp61mp2n06P8aMdnteJZD5tvJPDOuAKi_PNrb+T9A@mail.gmail.com>
 <mdosj4utmgvuaezdceoyde2d2q44amozbpdvzo3clljqaxh5ap@x5i22jkftljg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufj6mtxpebjbl2n4"
Content-Disposition: inline
In-Reply-To: <mdosj4utmgvuaezdceoyde2d2q44amozbpdvzo3clljqaxh5ap@x5i22jkftljg>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.84
X-Spamd-Result: default: False [-2.84 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 R_RATELIMIT(0.00)[to_ip_from(RLpoxqx1j9hfwga7qi6hxbzrpn)];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.bufferbloat.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com,mojatatu.com];
	 BAYES_HAM(-1.44)[91.22%];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


--ufj6mtxpebjbl2n4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 02:19:11PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> On Wed, Jan 24, 2024 at 07:17:27AM -0500, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
>...
> > and i didnt see him say anything).
>=20
> Me neither. I may amend the patches more if I missed anything.

FTR, v5 is at [1], changes are summed in cover letter's end.

Thanks,
Michal

[1] https://lore.kernel.org/r/20240201130943.19536-1-mkoutny@suse.com/

--ufj6mtxpebjbl2n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbzLMQAKCRAGvrMr/1gc
jt2QAQC7isul4PJyDsArmi2U77OYvcXSrHPrhZJ2uQY2LdTp8wEA+h/xTN5uDbYP
R7MLvmOLa/RI4r3yv83cTkz8ylK+bA8=
=RjAk
-----END PGP SIGNATURE-----

--ufj6mtxpebjbl2n4--

