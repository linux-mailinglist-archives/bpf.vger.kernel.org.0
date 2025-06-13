Return-Path: <bpf+bounces-60561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB2AD8037
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 03:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5427A37B3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2A1DDC00;
	Fri, 13 Jun 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkxk6dB+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCF1420DD;
	Fri, 13 Jun 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777705; cv=none; b=U/Ha37XdVIOnK5eY8r8EOhRgzsClXWTuwQIPLa0UhTWX2HqCKTQhOK7xGEkquxLmLCbPcZPsn3NCuDe8LWK72OA08HzKLkWk1ZE2DBMfk7gjtr6Z9V1pfcNXwrrTnJoR/I3NPr33wT1oR4MT0AD8OpLbY0UKBJZo6UhBN0WIKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777705; c=relaxed/simple;
	bh=CkV7K9JkoZIX1EFm22k3RUVUrhM4a86eMgsQGHb5Sq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPWnznb6HeueDMyqB+ZXTrIqwQJCqJsNh5XJ1e47SXj/IRWXJ887/k7op0FhKI101rf7rxATYmQewAH2FakwyGS74d0sY0Z8OyzS6B+0ohGCxL/uvM9xF3yYi9JorCz0sc9auNJqJMTaUQWiKJOVW2q+jb/RaL+8BzAaMHR5KyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkxk6dB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0637AC4CEEA;
	Fri, 13 Jun 2025 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749777705;
	bh=CkV7K9JkoZIX1EFm22k3RUVUrhM4a86eMgsQGHb5Sq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkxk6dB+kugt2d9edQ/jopnXbnc2+S8g1W/kk6Xj40u5oVCDdK2Ac+7WHs3i+Ve7q
	 UuO6fsjybG3L9lyaHQqYQCkQQzutMrsElQN5uPcqKbx8kRxP5jB0kE3Fr7GMSNisqF
	 AAU2YkbkGz8bgusMc32CgIpMtekatIgwW6YwoGBynF4mqhzv3PlQJ8G4xEppMr+r3N
	 IQBPUMP0XPjLM9IE4UknlL7N0GirnB1Z2t92soRx0HmgP/dPHwZipUxU/UzF65VDA4
	 BW0E74mnrKNGez1eU0emtxVYIN6CylOphGMPvZ2dmxocKgV4RWGdXDpisMmfz1QHEp
	 tRGR37QgESr2g==
Date: Thu, 12 Jun 2025 18:21:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, stephen@networkplumber.org,
 kys@microsoft.com, paulros@microsoft.com, olaf@aepfle.de,
 vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v7] net: mana: Add handler for hardware
 servicing events
Message-ID: <20250612182143.16f857a9@kernel.org>
In-Reply-To: <1749580942-17671-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1749580942-17671-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:42:22 -0700 Haiyang Zhang wrote:
> v6:
> Not acquiring module refcnt as suggested by Paolo Abeni.

TBH I'm not 100% sure this is correct.
If the service worker operations end up unbinding the driver from
the device holding the device ref may not prevent the module from
being unloaded.

Could you try to trigger that condition? Make that msleep() in the work
even longer and try to remove the module while the work is sleeping
there?

