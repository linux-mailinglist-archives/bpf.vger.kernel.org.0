Return-Path: <bpf+bounces-73463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC8DC32333
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DF7460FEF
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2E338585;
	Tue,  4 Nov 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVd3Vahi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8181EEA5F;
	Tue,  4 Nov 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275584; cv=none; b=bmV04884gE4eVCvFra28dLMNaghdDD1UXre3HchlvYQ3auorcPeSlZL9Jmi+NUJKX7cMal+m7RDubuvtit7dfi02jJlw2/uUKzedNbf/1dS4bdAuMiwhv7oxfL2e0lir15EsCkcwkKXCrB9HjZLlu75lSA4qFZw3x9pmuZ+tSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275584; c=relaxed/simple;
	bh=liDKhL8I6Oh+iBAaj5hJnFAk7TegfbjxHh776vLYF3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhHSlqV7DUBGbkaCRN1mw0afym/3FJibeifE9B8zOiYdaSQ2PAzcCegRfgVeIMNCXg8D0MMSBZthsPkuInho0jf3m35F6K/K3alItb7zgenl1wxBElN/5ddZm7hRdRsTwn/tUhOYTpOFFWlaQMucLD1xO3h6tqKp0Y5a8Vxmm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVd3Vahi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E77C4CEF7;
	Tue,  4 Nov 2025 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762275583;
	bh=liDKhL8I6Oh+iBAaj5hJnFAk7TegfbjxHh776vLYF3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVd3VahiNwMK1NszwWQfb4OSkjpKwVnVYF/rMCVAWMykzPVt9ntRJj20ljsQDZXRr
	 tIy62PerUc4evsGl+FB28FYMr07Ln0fFkG3is/3/1aijeDVSqvyW25qDOoeb52TOm3
	 81EGhVMY9/iYFvS4vpkUJWu6KG6kv10cD42TQVQPqcj7KZp12yZHsvcJ234FAGIva+
	 pW5nUmsuCemKjbn3L6wTfrZA6CgNeY8R8w7O1VDEvZ6aLDqAzKYMWuNgXKp/j6smGH
	 clvfjk5sPw3vIbt9draoWPaF17qVGq1KZ2179ZWB2TsoGMX6ZUOifeSZrkKf/ZWcIN
	 frLhHGvR4UWbw==
Date: Tue, 4 Nov 2025 08:59:43 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/8] net: Add struct sockaddr_unsized for
 sockaddr of unknown length
Message-ID: <202511040858.9084011BB@keescook>
References: <20251104002608.do.383-kees@kernel.org>
 <20251104002617.2752303-1-kees@kernel.org>
 <20251104091536.29d543f2@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104091536.29d543f2@pumpkin>

On Tue, Nov 04, 2025 at 09:15:36AM +0000, David Laight wrote:
> On Mon,  3 Nov 2025 16:26:09 -0800
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
> > struct sockaddr_unsized {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };
> 
> I'm not sure having that example helps.
> At a quick glance it might be thought of as part of the change.
> That particular example also has all sorts of issues, so any such
> change would have to be very different.

That's fine, we can drop the example and the sentence introducing it. If
a v6 is desired, let me know.

-- 
Kees Cook

