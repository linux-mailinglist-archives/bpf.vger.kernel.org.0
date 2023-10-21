Return-Path: <bpf+bounces-12886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82737D1A3D
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E71282700
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C247EE;
	Sat, 21 Oct 2023 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBk2oWNT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE37654;
	Sat, 21 Oct 2023 01:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52523C433C7;
	Sat, 21 Oct 2023 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697850740;
	bh=yJX+apBBAClOtV/YFyWwV9foliocgjFk8Kr+7KOGcoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBk2oWNTPfdzVnfnbTq+6jz9Kdwh6KSlxPERZFfw0CBJ6zhdmEM1xcGHOeYlaQyhM
	 cb67dbjcUImbQ2urfcHA7JvSgZTo2v4hMT9YosgOwaBpZnm+xuaZZqP2T2xuBG+22Y
	 DDJCtqaoKj80PT64eALhP2raLt4V67/7cJuX2dyDDt56jM+1Nlr5rcPDd+YfBkwkVw
	 4Rh1KDYQERV9R392r4rF8A68kp2uKi9bAMbNw+bDswOvOgwpw8jRBioLxsUW/8qDOF
	 Ew2veD/8ytw+2OhuMULRKJmJPON7/WEZyvi2MQTUw/N5prj0dsikxwH1D2NEck3YT4
	 H/3GsActT6Fpw==
Date: Fri, 20 Oct 2023 18:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 01/11] xsk: Support tx_metadata_len
Message-ID: <20231020181218.05ea35af@kernel.org>
In-Reply-To: <20231019174944.3376335-2-sdf@google.com>
References: <20231019174944.3376335-1-sdf@google.com>
	<20231019174944.3376335-2-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 10:49:34 -0700 Stanislav Fomichev wrote:
> - 4-byte aligned

But there is an 8B field in it. Won't this trap on some funky
architecture of yore?

