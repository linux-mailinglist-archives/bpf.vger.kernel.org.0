Return-Path: <bpf+bounces-16161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051F7FDD8B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BF282349
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4239ADD;
	Wed, 29 Nov 2023 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN7+drk/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205A1DFCC;
	Wed, 29 Nov 2023 16:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB11C433CB;
	Wed, 29 Nov 2023 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276423;
	bh=BoxG9fYj9k/u2YjXSnlTHfg9qRTdNZ/4amWfb+u9PHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DN7+drk/FlL+3YBN6d1fVGiYPOqDpanbRXsDZzQ3xZDIjYj9RevfghJ3jfxhkpHP7
	 4cqzwqL+vBlzDYZ28NXuyeQConHTZO6XK981Lnpvo51yuFmxJoVwR1q6EaEq47rThG
	 hd7JX213AYStf2Me/PnBfdCgz1akyE8hGPG2Bfy71YUWvE7UxI4avCDoLyK9/wEsmu
	 4Sh0aXh3PMM47ZhMzuE61DxL1WzrQ6OQsdFQ/g1pAs97h8eB0LLgao0CDHWYhHOOlu
	 JFvRepDsLXOkQnqULbTOlCV4W7Fg0NUIOYuQZZOpGcUDEY4EKeG8tOEBsmMQfjwuZ7
	 u7ouDTjUVuH2g==
Date: Wed, 29 Nov 2023 08:47:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v6 03/13] tools: ynl: Print xsk-features from
 the sample
Message-ID: <20231129084701.49194275@kernel.org>
In-Reply-To: <20231127190319.1190813-4-sdf@google.com>
References: <20231127190319.1190813-1-sdf@google.com>
	<20231127190319.1190813-4-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:03:09 -0800 Stanislav Fomichev wrote:
> In a similar fashion we do for the other bit masks.
> Fix mask parsing (>= vs >) while we are it.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

