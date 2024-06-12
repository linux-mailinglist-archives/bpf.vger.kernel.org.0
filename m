Return-Path: <bpf+bounces-31979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5321905D6F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E51F22809
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A278526C;
	Wed, 12 Jun 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlF6deoA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949B4315D;
	Wed, 12 Jun 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226577; cv=none; b=QxlVB06q7XksvluHV/x6CpHsIbJkxFUWA/778xEYiXxggu0QJu8600smtH/+K9ozxN9NRz7rFT8Xn9+1nZXXrSkwlT5HX5JudJ/2baHdAgXCCgZ1lGpecUKXE8j0gTgJpOC40jmLgo6+j33jrU4Pf2ogglAtR4ORdVQZ4skcXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226577; c=relaxed/simple;
	bh=p/mXOYAvIuYsfLPdV+2dCK5EknA6B/HSfkaHVfEQato=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muwwGA8FEtadBYVxW2VrRWI7vK7mzJIsN+lroo823BAFKA8S/mP2Gu+taFT8Kie1Bm4ZV+FEqVDvg788CjsAneIEHPK6havDBhpyAJz2+2A51CQxyCETetCRbF8rCNOwRP9S8B5v8m+xqe3mkj3XDVyZTXB+N5I0bv1xJOAZ4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlF6deoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B25C116B1;
	Wed, 12 Jun 2024 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718226576;
	bh=p/mXOYAvIuYsfLPdV+2dCK5EknA6B/HSfkaHVfEQato=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlF6deoALi2EBQ2PTzXnxcW3NEVc0zVQd6HRY4xR0lmS9aEe8hLk2Ts1HsmpkWiU5
	 2QFRDPyjhEIsalGkDUptUPth0v0OAvQzUHgJ99JOUk43vxydLlE41GbbNm4skSYcrL
	 cjx59AuIscyowaGkOG9fFfR8jdc+axYmC2qXLpfOqPj0aUBj32b6SyTpuP/rjzoYgR
	 J3W3ba3cpScjDHqBVKeNdYx0jPkX7iFlhbQFOXJaokA7bLqjzyMqnE1vKpkRy4RXhB
	 v/ZO5W/iA0H8239PHoU6jp2gn0zIkIYuKG7zHrOA2qJZ3Nje6po+zF0BIhic4FG577
	 oWuNO3YPD1ifQ==
Date: Wed, 12 Jun 2024 14:09:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <20240612140935.54981c49@kernel.org>
In-Reply-To: <ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
	<20240611193837.4ffb2401@kernel.org>
	<ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 08:56:38 +0200 Larysa Zaremba wrote:
> On Tue, Jun 11, 2024 at 07:38:37PM -0700, Jakub Kicinski wrote:
> > On Mon, 10 Jun 2024 17:37:12 +0200 Larysa Zaremba wrote:  
> > > Fix the problems that are triggered by tx_timeout and ice_xdp() calls,
> > > including both pool and program operations.  
> > 
> > Is there really no way for ice to fix the locking? :(
> > The busy loops and trylocks() are not great, and seem like duct tape.
> 
> The locking mechanisms I use here do not look pretty, but if I am not missing 
> anything, the synchronization they provide must be robust.

Robust as in they may be correct here, but you lose lockdep and all
other infra normal mutex would give you.

> A prettier way of protecting the same critical sections would be replacing 
> ICE_CFG_BUSY around ice_vsi_rebuild() with rtnl_lock(), this would eliminate 
> locking code from .ndo_bpf() altogether, ice_rebuild_pending() logic will have 
> to stay.
> 
> At some point I have decided to avoid using rtnl_lock(), if I do not have to. I 
> think this is a goal worth pursuing?

Is the reset for failure recovery, rather than reconfiguration? 
If so netif_device_detach() is generally the best way of avoiding
getting called (I think I mentioned it to someone @intal recently).

