Return-Path: <bpf+bounces-65432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206A9B22B10
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A0F426322
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021602ECEA1;
	Tue, 12 Aug 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaaORK5H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF88280CC1;
	Tue, 12 Aug 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009710; cv=none; b=dMtmP5Fc95S+KJno4xSDIhKPMI903SjTkCx7pOJyccheVURRIKjSE3k9/EDw51sdoQ3rIX/Thj/5AekshIvZK5AMXazYIRaLJ5fYuafjim7zxyiNcuSyWfaLgHwkiQkdzE/6aW3GADqM8Wz9NDVTQouaniEvEA/b6jURicnJEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009710; c=relaxed/simple;
	bh=+KtKDLyXQP5bPB/qSoYiCQHDP2u5ti7jWUDke/NNsN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhLZ7+r8+GIQnUbJPBUnWYsGEP74upBeGpTazj3zib9Gv6Sv1RJ0QXfsPBBC0czCv9SOMPNGEDp8V1BD9V4JwngMGGmqGgYWDvx1s6MfRBE2zzPQms62MQnIzhm6Fnr6Wo/7pYE4pTryvsGCdW9Vql6XRBTavitDoSDTtJEQu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaaORK5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19763C4CEF0;
	Tue, 12 Aug 2025 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755009710;
	bh=+KtKDLyXQP5bPB/qSoYiCQHDP2u5ti7jWUDke/NNsN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaaORK5HdAnE3zJjn/AwSZ6JNdhxbFgnL1XtFr7EEaEWamQJr0hDQ6tZOZHjD0aio
	 svwXBdBJyQUoPeY5ItvC0Jlko0GMxvZgJ4Gyeh5gACnl3NK2CCafmY+2AIjFUhvWxi
	 GDNOVDvLmksLtKjUNYGUan6EFC3cgjifEFbczQTM0etHQ3WeQGHpHAC9lwoi4iqQwR
	 eKdMbPG0kB+Ll7m9ZiLfacWG/2TlAiFB16KK/w2rVg9RB911fFq4a93SKi3N4vgb7Z
	 p68q0h3GTDruD1wrCrXjg9p+ldhzQZFiTAot6k9G6FtQtUxCjcWrSkFdjrHe68hsAu
	 OS1SfuzV8b+4g==
Date: Tue, 12 Aug 2025 07:41:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 horms@kernel.org, jdamato@fastly.com, john.fastabend@gmail.com,
 kernel-team@meta.com, pabeni@redhat.com, sdf@fomichev.me,
 vadim.fedorenko@linux.dev, aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next V2 1/9] eth: fbnic: Add support for HDS
 configuration
Message-ID: <20250812074148.736c6ce6@kernel.org>
In-Reply-To: <20250811211338.857992-2-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
	<20250811211338.857992-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 14:13:30 -0700 Mohsin Bashir wrote:
> Add support for configuring the header data split threshold.
> For fbnic, the tcp data split support is enabled all the time.
> 
> Fbnic supports a maximum buffer size of 4KB. However, the reservation
> for the headroom, tailroom, and padding reduce the max header size
> accordingly.

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:2214:24: error: use of undeclared identifier 'FBNIC_HDR_BYTES_MIN'
 2214 |         if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
      |                               ^

You're adding the constant in patch 5 and use it in patch 1.
-- 
pw-bot: cr

