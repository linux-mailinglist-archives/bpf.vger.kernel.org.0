Return-Path: <bpf+bounces-7496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAB7782C0
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9C1C20DF2
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0EF23BF7;
	Thu, 10 Aug 2023 21:33:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8B20F92;
	Thu, 10 Aug 2023 21:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB1C433C7;
	Thu, 10 Aug 2023 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691703194;
	bh=JBEQ5T1F14iE3Zlr18krO6C0aeBqKMC+YkVjR6hTAKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HGR22EXasfk4ZbhpXoPYbEO2wCbWe3SbL1ihE1nb0nktAFimGi9WQTos5Wjf2Mumu
	 PKx/gjQb3wpGOeaY91jJf7iRvIqWDtq3jxUO0ypEp85peIKyq7vBCMyXkrRjuHWOY/
	 Id+UdzGGyAqoK4MsProUIQp+naFaj7oVWdnQsoemNeW11od0ZM63VAfsAIhJz8vhFm
	 AHE2KBpOi5/hnyrx/1hht8I4eE0C3VpSnCkKrYpMQlcGA6kluEHcW16I0kN9tvgmTZ
	 kqYJYg7CSxcyXu6NRlOJrk6XU09q3Pw1m5att8fZGRoUc4UQhpQDSUpqCxDb29Lv8M
	 m0rJ7YnFboBXQ==
Date: Thu, 10 Aug 2023 14:33:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-08-09
Message-ID: <20230810143313.016929c5@kernel.org>
In-Reply-To: <b3d4972e-2a08-d627-db2f-64dfd4e96bde@linux.dev>
References: <20230810055123.109578-1-martin.lau@linux.dev>
	<20230810141926.49f4c281@kernel.org>
	<b3d4972e-2a08-d627-db2f-64dfd4e96bde@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 14:26:01 -0700 Martin KaFai Lau wrote:
> On 8/10/23 2:19 PM, Jakub Kicinski wrote:
> > On Wed,  9 Aug 2023 22:51:23 -0700 Martin KaFai Lau wrote:  
> >>        bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.  
> > 
> > This one looks like solid bpf material TBH, any reason it's here?  
> 
> There is an earlier bpf_dynptr_check_off_len() call which should have caught 
> that already, so ERR_PTR case should not happen.
> https://lore.kernel.org/bpf/e0e8bf3b-70af-3827-2fa3-30f3d48bcf46@linux.dev/

That kind of info needs to be in the commit message :(

