Return-Path: <bpf+bounces-31901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CD90491B
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 04:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6981F2443C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C58DF62;
	Wed, 12 Jun 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Dbs5Rh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486BB663;
	Wed, 12 Jun 2024 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159919; cv=none; b=SKmYkVSMGU7HlkpUVY+qOqlxJDiAbxfxxVO7iVWf/JCyDsugtWbq6cvQ2b6reb46PAdnexAkzIkIRVM5kNxGNV73clZ+DsxkKPkV5RlslBqdiS0JMqOxtebYkL9fUyay7ZYv51jcj5tvooQU6VeNBOPVimc/x+0zG8iabXkaPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159919; c=relaxed/simple;
	bh=vmyR4QR4O0qDRG2Tdpec3h1CFmxBVl5p9LVA9RJcQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0V/WzMQJ/N49U3gvxRE/Z4gftEc2DfoyXagDaugPnTaRn9s3zCf1KVDKFZDD5oGe2VocZLly9hB4vc6ICdfFzOiVPUQ6Pdoz+1YnuqH/Y11XU5OuFbwBPNxW7YUQaZB0N48wAmEGcAfC6xNd2RmVI9zJTjoX2NB0Z0DZL3/JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Dbs5Rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C9C2BD10;
	Wed, 12 Jun 2024 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159919;
	bh=vmyR4QR4O0qDRG2Tdpec3h1CFmxBVl5p9LVA9RJcQdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4Dbs5RhFMxmCf4wPg98NTH3+/I9L9tA8L1Dd26Ree+az3alISPp++DLwEbTkooeH
	 7mpqTsp9L/TwFgkAjzxpaT0/Kk5w8gOnfgtgtRZrgfj5Wlx9NUmcIhNSlVmo0dTFMF
	 dORbD3frvAt4dw59LOqQwFNcU84Dvn+HPYmyx85C34rQWHw1Gl/zaoUdVXXZSos7is
	 FsrbDHVYi2UP7BDpb3xsrZRI9MXvDIIr/vK1VbICxBgo3ltEOvpfAWLxJ9GU2Q1OWd
	 L3lLtlPtaxHjWkW35y1KupSpchPvTxCOLmHTCmQXklypyRGgJ5lIrdueFfSSrUpnQo
	 7MMRvmyt2cQxw==
Date: Tue, 11 Jun 2024 19:38:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <20240611193837.4ffb2401@kernel.org>
In-Reply-To: <20240610153716.31493-1-larysa.zaremba@intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 17:37:12 +0200 Larysa Zaremba wrote:
> Fix the problems that are triggered by tx_timeout and ice_xdp() calls,
> including both pool and program operations.

Is there really no way for ice to fix the locking? :(
The busy loops and trylocks() are not great, and seem like duct tape.

