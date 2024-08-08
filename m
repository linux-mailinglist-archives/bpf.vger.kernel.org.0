Return-Path: <bpf+bounces-36695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0094C394
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4B31C215EA
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA61917C8;
	Thu,  8 Aug 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxJ2zapG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD35190489
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137770; cv=none; b=Yg+LWgVsehE5fogXVCWf+nH1sQD7FbfQn/FTtfBRD/fYrtTodMLMGeq1zKtm9Q4jk9Vh5X77/Q7wZ4s3p6Wx2/bM2gz6J4g0aevKPJNK6g81DSkhTBGjvlrzPYt3GBLBTiSXL+ZsPjJa+Qhst+SR+XkM8euQ1/yFA949b64EZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137770; c=relaxed/simple;
	bh=6MUvh+2GpXKXQyyfW8XqEeiTwI3JUG3jKUKLxb7crUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJMSsJdt2GPifx/BJ1ttbMCtA49Fc3VZt/ci3yYbA06YIVzgKfvbeI4C8dGATs2//y8If8IxOjfuVDOsVxcRJFGh5aWix+5DjYUrYzQ7YHeBIueQhUbW4z3KQ6jf/drW5FYdr6H4EfcX9FORyNxcj0+ObqZ2z0w+V9ty4HiceQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxJ2zapG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723137767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jdTVRq/ML5O9MM/Zy15y5zkZSHABz60MdmEFuSzK3g=;
	b=SxJ2zapGIgx1jOLyqZekAW4WHWIJ5GNVHG1fKkUeybo11yyV/FPGAhRLQN623yHDeIUIn8
	t66YVQe6YpHbjntJs7MusgeK1SRbH1JIQhtpKW6wD3Z0V5k/UDG5EPu9QlvjWpyZnOjuFZ
	qYbdIotL5wkblzgSXNsDka4ENR9JZgE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-YjDNyp7HPwuCSTV5IkOuOQ-1; Thu, 08 Aug 2024 13:22:45 -0400
X-MC-Unique: YjDNyp7HPwuCSTV5IkOuOQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3687faecea0so520412f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 10:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137764; x=1723742564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jdTVRq/ML5O9MM/Zy15y5zkZSHABz60MdmEFuSzK3g=;
        b=eBixKK7QQh0CKdHcS/QM7U5kepLDmGpA/QHnaYDnt5m1Izs8UCtJcfWu/WUM0ZeUDs
         pVzhU8qLFB3qUumi3ehuIeTvOBwAR8101io4ZNfVaVCCAElLS39GkgFS18QK4vAShoFq
         arNR17bhBoP7JY1f/UpFwbw97WC/7EfU2A3k2DuaIqVITduV/ut5zoxzC8deisos1Zv1
         2mKtfmPYY+0Q6QEDqRY41asJDG0VwOVP5f28N3KyI3r+UcrQxa/HMI9UV19+Wa/FLl3R
         Y+rPEpcla9o4/XNjzE54gUfXv8eRb6awVyQCIp7QwkcVxrQThWG+aM1m9pQlm98kQy7N
         n8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXtNxZ2sYy4URWZZQHMBefEeZgcADOjufUwfVlUCGoW2s5pHTuLZJmIPCZvTszfDn7a9wFZE90tUI8MAqQgPmODqOFG
X-Gm-Message-State: AOJu0YyMnQqE/L/C2ar27neMoSJ+qSBjeu11fpM5duQhAqGC15IJYrMb
	p7N60web35DiDheA0yWnc+zFSLRmYqIyubm3YTvgHg85Fpqaweiis1gd39GJM9O3xcAt1nBRhTd
	IEhtUvlbLplsZMc0byDoVSsn5DZyOCMVCZzHKjE4SHyN/1S13Cw==
X-Received: by 2002:a5d:4534:0:b0:366:e89c:342b with SMTP id ffacd0b85a97d-36d2757d4bfmr1810232f8f.52.1723137764135;
        Thu, 08 Aug 2024 10:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqdtChQBZpN1JH7puu+XlXH02XOmQ5DJetV/Nf/lePk3KFQrsqH/VR0g9ltlQzH8bHk2zFcA==
X-Received: by 2002:a5d:4534:0:b0:366:e89c:342b with SMTP id ffacd0b85a97d-36d2757d4bfmr1810211f8f.52.1723137763564;
        Thu, 08 Aug 2024 10:22:43 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716c684sm2560176f8f.28.2024.08.08.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:22:42 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:22:39 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ZrT-3-1lRPzCCFhT@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gWopvvUjnRev2ziB"
Content-Disposition: inline
In-Reply-To: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>


--gWopvvUjnRev2ziB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Thu, 8 Aug 2024 06:54:06 +0200
>=20
> >> Hi Alexander,
> >>
> >> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>> cpumap has its own BH context based on kthread. It has a sane batch
> >>> size of 8 frames per one cycle.
> >>> GRO can be used on its own, adjust cpumap calls to the
> >>> upper stack to use GRO API instead of netif_receive_skb_list() which
> >>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>> It is most beneficial when a NIC which frame come from is XDP
> >>> generic metadata-enabled, but in plenty of tests GRO performs better
> >>> than listed receiving even given that it has to calculate full frame
> >>> checksums on CPU.
> >>> As GRO passes the skbs to the upper stack in the batches of
> >>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>> device where the frame comes from, it is enough to disable GRO
> >>> netdev feature on it to completely restore the original behaviour:
> >>> untouched frames will be being bulked and passed to the upper stack
> >>> by 8, as it was with netif_receive_skb_list().
> >>>
> >>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>> ---
> >>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>
> >>
> >> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >> cpumap is still missing this.
>=20
> The only concern for having GRO in cpumap without metadata from the NIC
> descriptor was that when the checksum status is missing, GRO calculates
> the checksum on CPU, which is not really fast.
> But I remember sometimes GRO was faster despite that.
>=20
> >>
> >> I have a production use case for this now. We want to do some intellig=
ent
> >> RX steering and I think GRO would help over list-ified receive in some=
 cases.
> >> We would prefer steer in HW (and thus get existing GRO support) but no=
t all
> >> our NICs support it. So we need a software fallback.
> >>
> >> Are you still interested in merging the cpumap + GRO patches?
>=20
> For sure I can revive this part. I was planning to get back to this
> branch and pick patches which were not related to XDP hints and send
> them separately.
>=20
> >=20
> > Hi Daniel and Alex,
> >=20
> > Recently I worked on a PoC to add GRO support to cpumap codebase:
> > - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016=
da5a2dd9ac302deaf38b3e
> >   Here I added GRO support to cpumap through gro-cells.
> > - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa7240=
1c7414c9a8a0775ef41a55
> >   Here I added GRO support to cpumap trough napi-threaded APIs (with a =
some
> >   changes to them).
>=20
> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> overkill, that's why I separated GRO structure from &napi_struct.

if we consider the NAPI-threaded implementation, we have the same architect=
ure
we have in current cpumap codebase, a thread for each cpumap entry, the only
different is we can rely on GRO APIs.

Regards,
Lorenzo

>=20
> Let me maybe find some free time, I would then test all 3 solutions
> (mine, gro_cells, threaded NAPI) and pick/send the best?
>=20
> >=20
> > Please note I have not run any performance tests so far, just verified =
it does
> > not crash (I was planning to resume this work soon). Please let me know=
 if it
> > works for you.
> >=20
> > Regards,
> > Lorenzo
> >=20
> >>
> >> Thanks,
> >> Daniel
>=20
> Thanks,
> Olek
>=20

--gWopvvUjnRev2ziB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrT+3AAKCRA6cBh0uS2t
rNmOAQCJ9AZ6VVqlHeY+Ep7EQlMd0ybYpws3TIoQ8xaHVmjHyAD9HFXaElQMwHQ4
DACmDzL52jcn/Xv3bji9aj2oL+3shwg=
=3Ltv
-----END PGP SIGNATURE-----

--gWopvvUjnRev2ziB--


