Return-Path: <bpf+bounces-65347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A058B210A8
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0659A17ED0B
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E142D4816;
	Mon, 11 Aug 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExP9PM6G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D1296BAF;
	Mon, 11 Aug 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926439; cv=none; b=t3kg4gD+8s4ecBOQrv0slFBH7f2KI5dlU7OW0cWK58i7XRRb4V7KjnrY0OdxNDwBVCJlePViuFtTfI4bDwr/fVhyS5vhZV8u/EtKdPyJQnevSU8GWiUP2lwEBobzSTSALWyTrX9yjcdmBvsI+Wc2LPrSKWaWdPetPqQTFWBQTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926439; c=relaxed/simple;
	bh=eSOlRImoJ/oBZHOPhHvF814nt3A8TimrFqSk62iMgWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sja6aaV5Ipw62QcpyYUdiIqMvrj7/bxtER5P3631OY8W+M26xGLCnnnB2IDpbUsJyWW7CfQd2kcu72gfoR2FE9B/Vr/52zOHe/xQjmyP+NHI6UhKK4K6AOldVxfhsTyTv2eOMZ9ct6HcgOQ/zVPMzuluNl6wSWmB7R+Nog6Qsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExP9PM6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EF4C4CEED;
	Mon, 11 Aug 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926439;
	bh=eSOlRImoJ/oBZHOPhHvF814nt3A8TimrFqSk62iMgWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExP9PM6GyoBntsw8j/7UMxlugkpwGspZqQmchPNhLluIzjqBN1WDBmHIzSmm3ouHr
	 xt7FZdmUQiRUdaIuwyxsvhnDVJ5xnM4d7XLWKY5gHCnTRj/eXYwb/NoHaeTPwRrY7m
	 XGvzNmWq89/m77cqF2k4hsKgq3ihiytBGPWmQ8YVewP5ppZNqUxHU48cGWN+ubIHMa
	 NN6fdRHH4bDpKuPMU4FIvUC4Mt1DcNxzC5yjlSji6B+9dySQdw4AxXnVZARzqAM25q
	 IinlDi2VlASpX1KNBa0AJgcRtnTR1wrOBEN+ERq3Xiv6QNLqRTbXJVo8tc1UATJM1T
	 Edex4OXyt/KbA==
Date: Mon, 11 Aug 2025 08:33:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, Mahanta.Jambigi@ibm.com,
 Sidraya.Jayagond@ibm.com, wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next 2/5] net/smc: fix UAF on smcsk after
 smc_listen_out()
Message-ID: <20250811083356.7911039b@kernel.org>
In-Reply-To: <14ec76a2-e80e-44a8-a775-ebd4668959c4@linux.ibm.com>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
	<20250731084240.86550-3-alibuda@linux.alibaba.com>
	<174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
	<20250811015452.GB19346@j66a10360.sqa.eu95>
	<14ec76a2-e80e-44a8-a775-ebd4668959c4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 11:24:50 +0200 Alexandra Winter wrote:
> > Yes, it should be sent to net. But the problem is that if I don't carry
> > this patch, the BPF CI test will always crash. Maybe I should send a
> > copy to both net and bpf-next? Do you have any suggestions?
> 
> I do not have any experience with bpf-next. But typically patches
> to 'net' are taken after one or two days, if there are no issues.
> I'd assume they are then picked to net-next and bpf-next(?) almost instantly.
> Then you would not need it in your bpf series anymore.

AFAIU the patches which land in net will make it to -next trees after
respective PR with fixes. So


 patch -> 
          net ->
                 [next Thu] Linus ->
                                      [same day] net-next
                                      [at some point] bpf PR ->
                                                                 Linux
                                                                        -> bpf-next

What gets applied to net should be in net-next in a week,
and most -next trees within 2 weeks.

