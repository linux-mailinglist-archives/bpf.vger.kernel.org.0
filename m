Return-Path: <bpf+bounces-49901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6272A201A1
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417951663D9
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BBC1DE3B6;
	Mon, 27 Jan 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNsyhS4C"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962701DDC15
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020226; cv=none; b=rZXxpLbqiKmLnFbKI2kdrpM0HXmzV0Z+VAiVFFJbeYOGnH04ztPbMuHEoBUqZpNAnvDZjyoyW0B2bZ3PiLRDFcC2uTzlrwCvw2mvtyRGD7MHMFRRvKyYnLYCokmuu6OEc8d5f9ucI+2IVF2Uf1fKu3kzxx0SvcewTfiuzBJ39n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020226; c=relaxed/simple;
	bh=/0r5OlQmqh24c4lsTACgtVV4CG1hUY87TU6fOnfI4oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1lx2xZao6ZklUQSdRC4t4Jw1fCqJxzyXrVos/77RAcDymUFDp3B2UlSFkeD/zME1dh6BycV4RdhGBsMnVbeXYxXvw0lvNcK0W5Z6Mgy/DJY6n5NC/X01Dz8wJ3pFF1dytWOXyJcffDSRGQsa5Npk1kvm6oA9oiblYNRC+bvPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNsyhS4C; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5dcd784-8129-47ef-b386-69f8a625a26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738020207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuDUxNIj8dNUJk8IKu3HmkmOLxCYpgxGw7Q2gX3LNGo=;
	b=hNsyhS4CnxyGBVAdk+AffdNXHwj7s085F0gfueCaJVFXmtmAY4CEYLuW6o67hcw4cCNHZr
	KawFl874JFZ6fJeeQN9sHanP8cBWdHcrzhyZfaR1XUU/8H7pVgBrq8mSyWVnHK/C07dy/l
	FDcURGiWKtYisFKUdNXC+7EmKkz4V5E=
Date: Mon, 27 Jan 2025 15:23:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] net: xdp: Disallow attaching device-bound
 programs in generic mode
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250127131344.238147-1-toke@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250127131344.238147-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 5:13 AM, Toke Høiland-Jørgensen wrote:
> Device-bound programs are used to support RX metadata kfuncs. These
> kfuncs are driver-specific and rely on the driver context to read the
> metadata. This means they can't work in generic XDP mode. However, there
> is no check to disallow such programs from being attached in generic
> mode, in which case the metadata kfuncs will be called in an invalid
> context, leading to crashes.
> 
> Fix this by adding a check to disallow attaching device-bound programs
> in generic mode.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


