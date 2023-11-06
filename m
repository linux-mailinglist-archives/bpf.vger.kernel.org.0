Return-Path: <bpf+bounces-14338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F47E3171
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 00:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEBB1C20A0E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274E2FE16;
	Mon,  6 Nov 2023 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNdBel3d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C572FE06;
	Mon,  6 Nov 2023 23:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E9C433C8;
	Mon,  6 Nov 2023 23:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699313480;
	bh=JF45N7SvDGNe1/DnJ6JDzkSciGkbttJ81sShj/TaZxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rNdBel3d9S4mNMTr7FjimvVKJIgCIBjiPdJW7EjojE5/PU22ldre5RwEqjnUjgOBy
	 8K4sI9HEgk2ASe67yaqIBu7m6SXFs8+V5CH9ZaScv2dMUZEDRFy4LTzxecOozPstdb
	 ZBFsp49OJWnf5u/ReoqKiPpgIpt2jmCCk2/UqDJ8kbeOoY+qhuwuXTFoqjb06nwQHW
	 R/l6Zbn/falsH49pEIh+Cd7Ar6Pq1Y3yZyc7eRoTid7BgHhk//DAyfX0yhZ0k3N5PB
	 J/xrTWjsKCsv+bqexoDybDDft7XZpUz8IL90wDCcYzZ3onQHX7M49bXZcxMLL4p2U5
	 cJObovkMEs4bA==
Date: Mon, 6 Nov 2023 15:31:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v5 00/13] xsk: TX metadata
Message-ID: <20231106153118.4efb5b93@kernel.org>
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
References: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Nov 2023 15:58:24 -0700 Stanislav Fomichev wrote:
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5/stmmac ones for the
> example on how to consume the metadata on the device side.
> 
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload

Acked-by: Jakub Kicinski <kuba@kernel.org>

