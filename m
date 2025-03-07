Return-Path: <bpf+bounces-53552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835DA56477
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF07173CCA
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674F20C033;
	Fri,  7 Mar 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TEDkwNJO"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F120C48B;
	Fri,  7 Mar 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341566; cv=none; b=PNucnn6E/39F/TNhU4FgRZfTM7RXVSGtQlHSj76tO+rxYxolIA2cmaJrkwFHuA4AwfHZFEJQv4U5oGMuQcGlNmhJ3be8/j2XHepnWnZ2XhjfGtJtxT8qj3m5E33CRonLpQdMCl2TFEemYvDfHywWCOVGjVALWMcM5hqS02DYHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341566; c=relaxed/simple;
	bh=bfA8hVUxSJvy9YDE+EPsr+c1ObFHqhEoUarM/Yz9DcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmi44dcSuttmpM+Qt1bUTc/BnqWUJk1KHSygKTR2qnPc3QuTK8e9xKRXINPXCKeGySvIkrEdV8U+T5JvkJ+WaNDqmZR9MueOHXc0pYG0K9/Gkkh7znaAZTCBN3HBpGtDFU6StFCiNLw+cs7GtaVp6vePniiOTnaZ3kvFSrmWL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TEDkwNJO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqUU5-0036D2-M7; Fri, 07 Mar 2025 10:59:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=bfA8hVUxSJvy9YDE+EPsr+c1ObFHqhEoUarM/Yz9DcY=; b=TEDkwNJOlyK5AS46+EViIZEzzo
	5cZRYp2AwmoHya56mhGLrGVJiB+YzgQn50Gq3yijrWC8LOe1QtaWjIfhjcj+Cd006V+I/iUqz1x1c
	BX5cZ5JAqMlOQFZLvjPL87iWfI9pafD5LpmtAVD/sSJbSCoi35oYY180XaS9C+HRqzna0JOeC8cTU
	8qT0of9KLIfWn3G4O+o+TDfyAMKK9PCBiGahh4DV2ukodLjYMm+kTC7GRGhfIcLyqRCyD8FM6kSti
	FqYmEF8uBqu3TAGE/HeUCB1iTlpxJSeYY4ZlL4QPbO9wiXAZQu3nDZdSZ0C++Q9I9lLruRLnFM/nu
	dtVMTavA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqUU4-0004ai-O0; Fri, 07 Mar 2025 10:59:12 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqUTo-006f6R-S2; Fri, 07 Mar 2025 10:58:56 +0100
Message-ID: <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
Date: Fri, 7 Mar 2025 10:58:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Signal delivered during connect() may result in a disconnect of an already
> TCP_ESTABLISHED socket. Problem is that such established socket might have
> been placed in a sockmap before the connection was closed. We end up with a
> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
> contract. As manifested by WARN_ON_ONCE.

Note that Luigi is currently working on a (vsock test suit) test[1] for a
related bug, which could be neatly adapted to test this bug as well.

[1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/


