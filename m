Return-Path: <bpf+bounces-18029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBD814EA4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51276287191
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6C3FE32;
	Fri, 15 Dec 2023 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU4nYD3M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516644174D;
	Fri, 15 Dec 2023 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A7C433C8;
	Fri, 15 Dec 2023 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702660873;
	bh=SXU2mfq6rwYmOPb6AXFU157c4L90LADGemdGwaM/9fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iU4nYD3M8h0T9nYEikIm0OIEOJarYn+DQfhRTXgBMs82YQWNuYD4KzVfzuLUgPc0c
	 B0sIarMPSq/fLY30vvNmEtbEe2bl4IrHHtnPbbFCHbVHklsfPhqL45uSJzgHtSU+HM
	 aNnAP87d7Q6yoEiiRpLSJ/S+12TY49Yr6LAIlcB4TGFd96S/GvUSFhC9O4/gfN1Y/X
	 GgZWnkuh0HLcR2dMwRs9kUa+q3ok3j7AGS8H8hzqkEYyjfpmSVCuamo49YB+mtmWA3
	 nfsewQCIxqbgC7Pq5V34Ba+fn4yr3bA3WTeMPw0cg8J0sGIj92qhGgJ/gWY6fd4fgC
	 pPtLGpxrJxTcw==
Date: Fri, 15 Dec 2023 09:21:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: do not map packet buffers twice
Message-ID: <20231215092112.3f0fee3d@kernel.org>
In-Reply-To: <ZXyFW0lIGluM8ipj@C02YVCJELVCG.dhcp.broadcom.net>
References: <20231214213138.98095-1-michael.chan@broadcom.com>
	<20231215083759.0702559d@kernel.org>
	<ZXyFW0lIGluM8ipj@C02YVCJELVCG.dhcp.broadcom.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:57:14 -0500 Andy Gospodarek wrote:
> > This patch is all good, but I'm confused by the handling of head.
> > Do you recycle it immediately and hope that the Tx happens before
> > the Rx gets around to using the recycled page again? Am I misreading?  
> 
> Your description is correct, but we use a better strategy that just
> hoping it works out. :)
> 
> The design is that we do not update the rx ring with the producer value
> that was present when the packet was received until after getting the tx
> completion indicating that the packet sent via XDP_TX action has been
> sent.

Ah, I see it, interesting! In that case - next question.. :)

Are the XDP_REDIRECT (target) and XDP_TX going to the same rings?
The locking seems to be missing, and bnxt_tx_int_xdp() does not
seem to be able to handle the optimization you described if
a ring contains a mix of XDP_REDIRECT and XDP_TX.

If I'm reading the assignment in bnxt_alloc_mem() and indexing
right - XDP_REDIRECT and XDP_TX do seem to go to the same rings.

