Return-Path: <bpf+bounces-71621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD7BF848B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D354F357671
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C826F443;
	Tue, 21 Oct 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6+4sQMv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D77225761;
	Tue, 21 Oct 2025 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075731; cv=none; b=iIIJZXMla7eOMtUjP9HLMJwt1OJrhu4H2zMmqp2aZSzSCdjlCBL1urnfbnPQahlLq3gaaVqzGs3SA3QGjfSDAvhKdU5S6N1taN0ggd96Y25rHZwm6NtZPHQFaRBkf8McDl3nd5osT0yLaX51PPD8f/ckbxWtZ019a9lFA5YTPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075731; c=relaxed/simple;
	bh=eGVocM0DQBl2qPI9FUGWA58zJ38JkhcoJ7N7a2UjFQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2qeGpEmYU7ioPBByKMTHmmLh/pjCEmGXm2c+OIaHh1s/YFjbmZAKx09G0CbzE5b+ouyRgluwFDMVcb7X8n3G6deBIrBaL9eeXoJ2dyoCxrbRtOQjwlj3H8HUOrndRCuuAWNHqV6LnRtX1+Oym0+VozIMqRjKDdSf3h7JQI1lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6+4sQMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A187C4CEF1;
	Tue, 21 Oct 2025 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075731;
	bh=eGVocM0DQBl2qPI9FUGWA58zJ38JkhcoJ7N7a2UjFQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6+4sQMvhUimGHIK1nPetkCrJVVSOtCes8Qf4GEREJFkNiG4tmp/OGcdPsZKZJ4Gn
	 rj1WUrpqoQkyXZ9eA6Oh2l5n0ABLUprAtIlBlr7O/tWdTMT4t/vRX/QMjeWV+hHtoG
	 zUlsxKRoxbvXaAXUef9xwdTkS9WTiceuCHGssxF8OOzwt1+Mj4dIrheB14lpqzwRMt
	 IKXTkkTw+uBfLG86Bjh99RijkIN1NLuesht+WVNtEw1zlLWBXVmIaOLI81u0XARW/m
	 aiS9LNoKFZvEg6edN0ifyGkPGOnaBpqx1boYxwZiEoOBTNWkOH2GGRue5YwaeBedL2
	 Z7nTXSIHQgbUg==
Date: Tue, 21 Oct 2025 12:42:10 -0700
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <202510211232.77A0F8A@keescook>
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
 <20251021102600.2838d216@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021102600.2838d216@pumpkin>

On Tue, Oct 21, 2025 at 10:26:00AM +0100, David Laight wrote:
> On Mon, 20 Oct 2025 14:26:30 -0700
> Kees Cook <kees@kernel.org> wrote:
> 
> > Add flexible sockaddr structure to support addresses longer than the
> > traditional 14-byte struct sockaddr::sa_data limitation without
> > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > allows the network APIs to pass around a pointer to an object that
> > isn't lying to the compiler about how big it is, but must be accompanied
> > by its actual size as an additional parameter.
> > 
> > It's possible we may way to migrate to including the size with the
> > struct in the future, e.g.:
> > 
> > struct sockaddr_unspec {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };
> 
> One on the historic Unix implementations split the 'sa_family'
> field into two single byte fields - the second one containing the length.
> That might work - although care would be needed not to pass a length
> back to userspace.

I think this is just asking for trouble -- leaving that inline could
be hard to track down places that needed filtering out.

It might be easier to move to a separate struct like I suggest above,
though maybe as:

struct sockaddr_sized {
    u16 sa_data_len;
    struct {
        u16 sa_family;
        u8  sa_data[] __counted_by(sa_data_len);
    } sa_unspec;
};

(So it's easier to cast between implementation-specific sockaddr and the
"sa_unspec" member.)

And then pass that around. But I think that'll require a LOT of
refactoring. But that could happen separately from this change, which is
to just get us back to the existing state of passing around an unknown
sized object but now we're not lying to the compiler about its size.

-- 
Kees Cook

