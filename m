Return-Path: <bpf+bounces-6458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4D769D0F
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D91A1C20C44
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D219BDC;
	Mon, 31 Jul 2023 16:43:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447619BB2;
	Mon, 31 Jul 2023 16:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7515FC433C7;
	Mon, 31 Jul 2023 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690821804;
	bh=ZFs/BvicYu7gy4mLmfp20c2N/r8/MPwILXQgAwW+MKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMHJ+meOYIn4z+hIkvHykH/WKCpJD69jhaMx0WAV5oDypdLxra9UEvoCC1GyQF9wb
	 EJsQQqkUB+R+HujYW5LMTO9GoXGfXoh4fNPKw4PoCfO37v+BrpSDbT4M/DmzTP+nkb
	 Zkp28fej6+ucZWzMVIw6QJS8JF/YCic7sQo1HXN5yX3qiLThsYTTuFXXOUvqXHRwjf
	 QA+o4r7sIvG+14miuO9/yJnok2kIutdIxw+9iP1bYsMgapeezKz+G31ucorkAiqROX
	 t+7UCP4YbYVcWsK1T25ZzlZzAlGGILEHJzTtWd2ukKsysLXekk9ifeYBvoQR+scBsw
	 uyVouN5Tz9HkQ==
Date: Mon, 31 Jul 2023 09:43:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Willem de Bruijn
 <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net, Network
 Development <netdev@vger.kernel.org>, Simon Horman
 <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <20230731094322.0edd5c6b@kernel.org>
In-Reply-To: <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
	<20230728173923.1318596-13-larysa.zaremba@intel.com>
	<20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
	<64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
	<CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
	<64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jul 2023 09:13:02 -0400 Willem de Bruijn wrote:
> > > This levels business is an unfortunate side effect of
> > > CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, what
> > > does the boolean actually mean? With these levels, at least that is
> > > well defined: the first N checksum fields.  
> >
> > If I understand this correctly this is intel specific feature that
> > other NICs don't have. skb layer also doesn't have such concept.
> > The driver should say CHECKSUM_UNNECESSARY when it's sure
> > or don't pretend that it checks the checksum and just say NONE.  
> 
> I did not know how much this was used, but quick grep for non constant
> csum_level shows devices from at least six vendors.

I thought it was a legacy thing from early VxLAN days.
We used to leave outer UDP csum as 0 before LCO, and therefore couldn't
convert outer to COMPLETE, so inner could not be offloaded/validated.
Should not be all that relevant today.

