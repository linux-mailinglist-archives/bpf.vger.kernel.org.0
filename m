Return-Path: <bpf+bounces-11272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B527B6918
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 149491C2092E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68831C286;
	Tue,  3 Oct 2023 12:35:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B572DDBE;
	Tue,  3 Oct 2023 12:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2FC433C8;
	Tue,  3 Oct 2023 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696336528;
	bh=KkLfUgocu5F7KXQSvfrqaGnYcZzRw7HrYorKPZvmsys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bH0Pig52T8oRLymG0RJ4ZctqFLc/nxKMDQmTHKn/nBAsNqWPISeavAJ5YAaVilzLU
	 PJ3e9QZU1xMBFKoA8+ql/toVTTKh+ODqQUmxnTCr4goGcjiSASfkwigJAybBki1AoS
	 QPuLw3HVZXN8wBe2WZ7qHgmzAHTgZ5GQ/+64MKT8MoJnZajInQgsKKZuy/GuwnUVYn
	 lLv5KHivK8B2u2tPuJbfcn52HE2DTKGPWRHXb5EOVtBxd8DQ0yQwcKOLRHMNlZKbxx
	 Zq05vH9sZhN4vE8z524HuCH85ZrB+KgNi0BkSoiSBTJV7qTSuyq9OY/6QSGPDy5vJ+
	 E66T5RD7HUwrQ==
Date: Tue, 3 Oct 2023 05:35:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
 <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Alexander
 Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
 xdp-hints@xdp-project.net, netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Message-ID: <20231003053519.74ae8938@kernel.org>
In-Reply-To: <20230927075124.23941-10-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
	<20230927075124.23941-10-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 09:51:09 +0200 Larysa Zaremba wrote:
> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.
> 
> VLAN tag is represented by 2 variables:
> - protocol ID, which is passed to bpf code in BE
> - VLAN TCI, in host byte order

Sorry for a random chime-in but was there any discussion about 
the validity of VLAN stripping as an offload?

I always thought this is a legacy "Windows" thing which allowed
Windows drivers to operate on VLAN-tagged networks even before
the OS itself understood VLANs...  Do people actually care about
having it enabled?

