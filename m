Return-Path: <bpf+bounces-11392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B157B87C4
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EC1BB281ACB
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6811D54B;
	Wed,  4 Oct 2023 18:08:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D71D523;
	Wed,  4 Oct 2023 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE1C433C9;
	Wed,  4 Oct 2023 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696442932;
	bh=7KinbA8DNblA+Km2f8glGeQw5rEldbniDtB58mio/Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHzpZAiVZd7ZFkiW/MGVBek96RFTIJjcohB0e/YOf0qtsOfUMAWU2MGGzR58wiowk
	 D/P/URX2DhFNOVR9vJ/iYgXQQu+nnZ5LcLPjq6DjmC5SGUzxYiaHXdCc5gSw1Ymo4S
	 usX+ofMOub/zY945XGGYVRJBlqabJwqtchOEsNd+6vjIXbgMUhT/H/VTfV29ZP1zYn
	 7t3V1E3MqfJZe+cr64wLZXz+p5xjo/GJfotavtLabkH2PDWZF3sC02RK5Qfd6RcDrF
	 eo0r5avug/98hGKx9/kkETVhBcDLVQZFFIQdQ3mIL7Q0qfasJBbkh90UaCgQI+7fwV
	 RlRsShJqz9k3w==
Date: Wed, 4 Oct 2023 11:08:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
 <haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
 <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 "Alexander Lobakin" <alexandr.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
 <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Message-ID: <20231004110850.5501cd52@kernel.org>
In-Reply-To: <8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
	<20230927075124.23941-10-larysa.zaremba@intel.com>
	<20231003053519.74ae8938@kernel.org>
	<8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 15:09:39 +0200 Alexander Lobakin wrote:
> > Sorry for a random chime-in but was there any discussion about 
> > the validity of VLAN stripping as an offload?
> > 
> > I always thought this is a legacy "Windows" thing which allowed
> > Windows drivers to operate on VLAN-tagged networks even before
> > the OS itself understood VLANs...  Do people actually care about
> > having it enabled?  
> 
> On MIPS routers, I actually have some perf gains from having it enabled.
> So they do, I'd say. Mediatek even has DSA tag stripping. Both save you
> some skb->data push-pulls, csum corrections when CHECKSUM_COMPLETE, skb
> unsharing in some cases, reduce L3/L4 headers cacheline spanning etc.

No unsharing - you can still strip it in the driver.
Do you really think that for XDP kfunc call will be cheaper?

