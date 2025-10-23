Return-Path: <bpf+bounces-71957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC8C0276E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08003ADEE1
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750F3128A1;
	Thu, 23 Oct 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8w1qSUT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FBD515;
	Thu, 23 Oct 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237201; cv=none; b=ghfPMvyhvCMBd17jyrdaivV7NjDpD9vkEwYEcSh++Ismq7Rq52wvp23lwt60XpsruAjaaX5pVTOmKfXhlfMVjQRdww63tw4nvIG2RyhL0iStf5fARA8C/pjWQz2H8qoTjOLSzKpk82EQlmsxOGXA4+Vo+kMpkpjQGNdKj7VTkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237201; c=relaxed/simple;
	bh=/6tHfvGZqUwcTLO1Eo5xqt/UNzXiyV7MfLFdbBzdmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK/vCw+PChyz8WscSWWafeht7Grg76z6xjKxzPqcuNpNz8oKII9gOJxau3NoN0dFuL/UPFtRe72MUc+YNrfZPnI5n+PxXVbFUG91vuivzMVOGmsiUcUVj5D4FvUKFa4ZXCuPNvYkspj3ykJVMx4MPcSLPO8C6G4iGqrWaAgBiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8w1qSUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01533C4CEE7;
	Thu, 23 Oct 2025 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237201;
	bh=/6tHfvGZqUwcTLO1Eo5xqt/UNzXiyV7MfLFdbBzdmHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8w1qSUTR/FyUhldaR6ZoysNRjirBiAdw5hF6KaHS6f6nt61Q7Tai7fu6R2mW0MYl
	 hZ4dwfgA9pEokgLbjOFU5ZdoTjCRl26D8xY/Bp/EfYX+aGTa5HujE3/9m5ESnzKTF0
	 J1dIXfwAA1C8d8/cA3sKjVNJ5qw0O59jKbCVABW+B7OfnGA7v8+D//ABvX1gESq0Ba
	 0smW/d9WpekOUDet2oJRu1+9mOaADJ6x48kIlkaD+rDkGWhMbTond+C0wzcvfV0F5v
	 Rb3N+XUDLNQSBZigELxpanCpd5xoRH9kNRsSoqeOS2Wgnv43no6wWTXT2ijkoGgRlB
	 d8ZBX+r/X28Tw==
Date: Thu, 23 Oct 2025 09:33:20 -0700
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
Message-ID: <202510230932.25CE49FC8@keescook>
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
 <20251021102600.2838d216@pumpkin>
 <202510211232.77A0F8A@keescook>
 <20251022102624.18d2c6f7@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022102624.18d2c6f7@pumpkin>

On Wed, Oct 22, 2025 at 10:26:24AM +0100, David Laight wrote:
> If you do add a #define, it can generate the size from that of the
> supplied address structure (and error things that are stupidly short).

I have more patches coming that consolidate all the open-coded casting
and size checking into a macro. So far, only a couple places weren't
doing the full checking.

-- 
Kees Cook

