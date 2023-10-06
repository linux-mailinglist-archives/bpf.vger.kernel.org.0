Return-Path: <bpf+bounces-11539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B07BBA02
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1251C209D1
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF02629B;
	Fri,  6 Oct 2023 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enOPmrhQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAD23778;
	Fri,  6 Oct 2023 14:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D6EC433C7;
	Fri,  6 Oct 2023 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696601537;
	bh=Zdd7DNTlVeoT74N6zv6LNwFKPiqOlfIZkXfohcQuj+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=enOPmrhQ9Tbhdq7mBSBhbAbqydrYWwmaoB5Xr6lHhV3WmtpKknKzHrj3PdA1tJUKR
	 0nehUWr4us3av0jhUGE3w3GRqlZyZZ/fqlfeI5OfQ6YQWawKGtl8abSBZyOElLDv66
	 N5dq7gOuMRUOP2ODpjjcL4w+mMovWtKxHWsEBJU/5TVzeHo/IIQQ2BzDDgMkIcZWSy
	 KpFLK4RLMkDKb1LdNZNLHdcILtmgN6yF7wn9fNZGPd8OMcnvGwG5wqUHl5vnczTmtK
	 jCE1Udjbn0XXTO1LQ1QnksbykEGbCKSyz6PlNRlFDHT8EOHsdndzaa7PUHA9Tz/scD
	 QkVbvV+QRmD6w==
Date: Fri, 6 Oct 2023 07:12:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com,
 martin.lau@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from
 return code
Message-ID: <20231006071215.4a28b348@kernel.org>
In-Reply-To: <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
References: <20230919145951.352548-1-victor@mojatatu.com>
	<beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
	<CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
	<97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
	<CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
	<1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
	<CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
	<cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
	<CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
	<96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
	<CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
	<2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
	<20231006063233.74345d36@kernel.org>
	<686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
> > Which will no longer work with the "pack multiple values into
> > the reason" scheme of subsys-specific values :( =20
>=20
> Too bad, do you happen to know why it won't work?=20

I'm just guessing but the reason is enum skb_drop_reason
and the values of subsystem specific reasons won't be part
of that enum.

> Given they went into the
> length of extending this for subsystems, they presumably would also like =
to
> benefit from above. :/
>=20
> > What I'm saying is that there is a trade-off here between providing
> > as much info as possible vs basic user getting intelligible data.. =20
>=20
> Makes sense. I think we can drop that aspect for the subsys specific error
> codes. Fwiw, TCP has 22 drop codes in the core section alone, so this sho=
uld
> be fine if you think it's better. The rest of the patch shown should still
> apply the same way. I can tweak it to use the core section for codes, and
> then it can be successively extended if that looks good to you - unless y=
ou
> are saying from above, that just one error code is better and then going =
via
> detailed stats for specific errors is preferred.

No, no, multiple reasons are perfectly fine. The non-technical
advantage of mac80211 error codes being separate is that there
are no git conflicts when we add new ones. TC codes can just=20
be added to the main enum like TCP =F0=9F=A4=B7=EF=B8=8F

