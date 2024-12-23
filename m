Return-Path: <bpf+bounces-47551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06919FB430
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695191885B18
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF341C3C1C;
	Mon, 23 Dec 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsuBp7Jp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234771C3BF9;
	Mon, 23 Dec 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979750; cv=none; b=EbroA9p+CBaTJEToBoAag4Xds3AXu1WiS6h+kvCMbYoslKDKQTUIVH2e5eS1jitrlztIubYwqicuD6sodMJ5wZflMU+FSIpqG6Uw7hnDqRPOk/8oIQoUPlZ3ZtlEO3RkMjOV8FPS5TX0XIo2kwrUFod61zSCtvdYknvkzbg4vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979750; c=relaxed/simple;
	bh=JetR2b9iW9/dAMIkQQEiNSWNDaWsmpk7e8dCcReuDCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faPzOsQ/hs2VHMO7Wd7H4KcVSLRn9L4bIiq/Sai7TA0rrOOST4rQsXOXH8uCwvem8lyfTe5RZRspHHKT4yMeBZPCjpAlDrZAzfdNEhBPyfLtXIMtHiPT7YNtFdgjSyoJzMBkLDkP4Ix7QG0sqb/VXfCma7GxaZ0hJXHHB/nSRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsuBp7Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443E6C4CED3;
	Mon, 23 Dec 2024 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979749;
	bh=JetR2b9iW9/dAMIkQQEiNSWNDaWsmpk7e8dCcReuDCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nsuBp7Jp95JVu5IghWs/0NFdayaauzRNg64IzDZRNQ2GdcoxeITW2TBYWux1GsRyi
	 xyLtTsYJZzEsgV5aUX6cNocZrX5d94JGemmPXXCe/ULcN3M0VqJINlG6RIhRy/ER/H
	 NHaUWNtUvh2BJD2bUt+lIofzPDRT6FgPym4eNvqYyQzDRqkRKmS0cpohNiRas+7SPG
	 1BVOHKjmVzaaoLHvUN0eWknZ5GeMY/spoElkKCf/scXdTNKcPrkbBThWxKFYZhn4jg
	 GL1SD4ona13EeUsgsyCEMN6Ra1Wevmxp5/YrYeQR8605u8IoPHbdUcMIQ0DieylA7a
	 J/Dmu80omX+IA==
Date: Mon, 23 Dec 2024 10:49:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, pabeni@redhat.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] netkit: Add add netkit {head,tail}room
 to rt_link.yaml
Message-ID: <20241223104908.7fe5c387@kernel.org>
In-Reply-To: <20241220234658.490686-2-daniel@iogearbox.net>
References: <20241220234658.490686-1-daniel@iogearbox.net>
	<20241220234658.490686-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 00:46:57 +0100 Daniel Borkmann wrote:
> Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

