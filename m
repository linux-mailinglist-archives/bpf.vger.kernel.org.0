Return-Path: <bpf+bounces-55169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A413A7936A
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C423B0C88
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0201922C4;
	Wed,  2 Apr 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr0YY29M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2093137C2A;
	Wed,  2 Apr 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612299; cv=none; b=RnKRNaTh5djXVao8HgeOb66BUJRzTaBqt1/kpHoN2U9PHAYlRxnshVKIX+yMqdNoNAbv3DTq3AQeUo0bHx2gWuqo7NyzoY3M4CUOQVrlJXQNCoYv+pMKDlkQWHjY5DXwNCCt9dHJp8RO2Q0PwzwEM8FkV9emgDNyVlcGSJtb0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612299; c=relaxed/simple;
	bh=HXqeqOATsb2lLDAXPM18S+nzMz70mVg6ZGTGA1YS26k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltjTXVVmn8F/1oGJ2ksmKgC2Qg7BpkHdC5WCkZiLQCwG1Mvrug//4HW71KtmSMB0GD6Vy46Ol0GvoPt0NigHp4oH1xe57nIs2WdZpLrQ7s0Nt3hq3anVO/1nRs8eiIU3UTdPLh6OUe2qer4VLZkjipe12x5fUCySRWBcCqjhrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr0YY29M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC860C4CEDD;
	Wed,  2 Apr 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743612299;
	bh=HXqeqOATsb2lLDAXPM18S+nzMz70mVg6ZGTGA1YS26k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lr0YY29Mq4oyVE8lwZ0BOzfB5oUb/zgtaKUfkqp5U0DCmhSC1r4nh9PLIfmpSefyF
	 Jv6hquMQAZy5I2wwQVsXnOQXmeN0TryfO/8VJ9D/HktEpa7TN+0OMhzbSF9kxPZ9fn
	 0qbk6fBGT4zK+4ZVF68fKyoKpeoK5Dct9PD61JIab0WL1ZgYA7m+CDczGUXwt+xM86
	 O1OWmt/khZkr7G2PhySzNWzaz4+OlQIxsfipQN3k/Bqm0Fql89k8m1IxgZIJ8Zv7m6
	 ORJO97h+FC1o2xxP1292R6RfAJu+DjM2ofx1fJomvSRIMEFqAjP0+iQBy8ce7xr7tw
	 cN5C4TR6FOHzA==
Date: Wed, 2 Apr 2025 09:44:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Justin Iurman <justin.iurman@uliege.be>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Subject: Re: new splat
Message-ID: <20250402094458.006ba2a7@kernel.org>
In-Reply-To: <Z-wYH-gIvMd89-3d@mini-arch>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
	<647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
	<d24ea1cc-4d32-44f9-9051-0c874f73f1c5@uliege.be>
	<Z-wYH-gIvMd89-3d@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 09:45:19 -0700 Stanislav Fomichev wrote:
> > Correct, I came to the same conclusion based on that trace. However, I can't
> > reproduce it with a PREEMPT kernel. It goes through without problem and the
> > output is (as expected), i.e., "lwtunnel_xmit(): recursion limit reached on
> > datapath".  
> 
> For me adding the following to the config did the trick:
> CONFIG_PREEMPT
> CONFIG_DEBUG_PREEMPT

Could you send a patch to set these in kernel/configs/debug.config ?

