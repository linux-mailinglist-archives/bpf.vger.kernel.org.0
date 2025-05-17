Return-Path: <bpf+bounces-58439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05263ABA772
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8159E758B
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C587082D;
	Sat, 17 May 2025 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tocTpl6R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D424B1E72;
	Sat, 17 May 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747443883; cv=none; b=VKAt13KOSP+KpbxpyxESQvfv+50P8QHz14HfYuNlOsK58UtkctpFRNiWFNvoR5AiTWwsANXDjtror60WJhqrtQS6vR+NJ/m0/WyUN3WouyXvOnlmin8O7o55f4q3LIKmziQUwVgK88xPIMU52ukNMhmJxhlcn8dp8YCP5UNIg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747443883; c=relaxed/simple;
	bh=jcHht5WS/feibSCEyYSDp6D4++cceJSdS3lvFn8RHw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXEBEYoO/UH8+URiBRNoVBkF1gT+hfiul51XPXhnTgZ2k8Z+44+1M3LB+2YaQXLhqDSQ4s2l4iJkQX/Ii6bx01WwRY2hg6Ho47N9JtgTeSxGmtA4vv4Jv1RU0juSD5b82PJk0RbJL55vrIEo0tf2mnQZb75QVXCjR+KL78netxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tocTpl6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE26C4CEE4;
	Sat, 17 May 2025 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747443882;
	bh=jcHht5WS/feibSCEyYSDp6D4++cceJSdS3lvFn8RHw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tocTpl6RoB4hnphxYtmhsuVcAMzvr9u44nz1b8bpzJoWt6T/RTj5rIBs5xi4n8NqQ
	 HaJY8974i6fTBLqu/hQyTD+GUx5fmkJGd7QjdfvT0anA0500tivmK9EXq5NOmbuDFb
	 qoxQd9R4sFif9HCwimyy/F0dUrW1sFDALjo7Yla/0CeSkNzM6213OkimqmzBpEpqB6
	 z2+sTp+HXVU/y85a49gdKnXMlHmFJTcFopklT0udSjAA5Zqh1FXDtCKcQF8GUEuQxP
	 vazXBbl11cZw01mXhz9X+5WXTET3J78VzNreI9C+5v+GPXACiz9peTGgYR1fzHYl9X
	 vcKNh//UX7e0A==
Date: Fri, 16 May 2025 18:04:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v4] net: mana: Add handler for hardware
 servicing events
Message-ID: <20250516180440.0db7b35a@kernel.org>
In-Reply-To: <1747254637-3537-1-git-send-email-haiyangz@microsoft.com>
References: <1747254637-3537-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 13:30:37 -0700 Haiyang Zhang wrote:
> +		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> +		gc->in_service = true;
> +		mns_wk->pdev = to_pci_dev(gc->dev);
> +		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> +		schedule_work(&mns_wk->serv_work);

I don't see any refcounting in this patch, and the work is not
canceled. What if the device is removed between work being scheduled
and running?

