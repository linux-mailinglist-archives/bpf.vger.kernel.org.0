Return-Path: <bpf+bounces-35647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F0093C3D7
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3672837E3
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37919CCF3;
	Thu, 25 Jul 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQWUa/mZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C36FC2;
	Thu, 25 Jul 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916961; cv=none; b=Tdfc7YttwfHb3hAc2ucRci9zJFECekeI9mosgaTOGhCjxPmxl51haFtMhf2ksehxM0L1uFibRLFCuPF/YmcwMIej8MvkrPHhdMDY+dPjZm4+dv25eDX0Ma0WBp02SifWR4pPfa9NbAfa8APwqYhlLeMcx8Pa8C0DB6OP68W+EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916961; c=relaxed/simple;
	bh=xvIY85d7vnC67zKQU6SechK6RxQS1+pP5TUUdnofndA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7dF20yGbx5FNPbx9OElY8iTWvi7HSlMZ5orjEI4wjRAWrGAgT5XgodzH+2xIkCFKninet0Ug2qpV7mYkJEzAySLEd5dTiYOO/Vo1Ep9rGzEPcXDcPiYW9aQcFqVWJ9Gs1l12mXbN4LQ24k/IkR58XDLI6s3zO1NuF0frx7VV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQWUa/mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D60BC116B1;
	Thu, 25 Jul 2024 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721916961;
	bh=xvIY85d7vnC67zKQU6SechK6RxQS1+pP5TUUdnofndA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQWUa/mZcWQ90ydWYNjIhnOKMebRC+15ANMAykSNnjU4fDR8dePwmbgHt8Q8xGEgm
	 2X9gYlDxl6TcFJ+mE7yRGagGWAzRrwzrFkMMIKyGvosYAJvCvmd30lFwn1ivIbCU57
	 /Mof30HF9P3DU+0rvOBkjLgf2tAWG2EWZukzOiO5ctlvmy2f2DUna725MqQoSkTmcQ
	 QQK3FfRaY1Qc/YBrRI0B+SQQ5aX7SCoysugEaGZTnEHX/aPlyMgcjUm/hv/Caw1If6
	 cDGq4p/cqzcyK9/EL3ykenI4pCwOporXllDUBGcUBaCmzlHR4rn3yxNpUUSUvompju
	 BrZBKzEb1zkxw==
Date: Thu, 25 Jul 2024 07:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, chantra@meta.com
Subject: Re: pull-request: bpf 2024-07-25
Message-ID: <20240725071600.2b9c0f62@kernel.org>
In-Reply-To: <ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
References: <20240725114312.32197-1-daniel@iogearbox.net>
	<20240725063054.0f82cff5@kernel.org>
	<ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:13:00 +0200 Daniel Borkmann wrote:
> On 7/25/24 3:30 PM, Jakub Kicinski wrote:
> > On Thu, 25 Jul 2024 13:43:12 +0200 Daniel Borkmann wrote:  
> >> Hi David, hi Jakub, hi Paolo, hi Eric,  
> > 
> > While I have you, is this a known in BPF CI problem?
> > 
> >   ar: libLLVM.so.19.0: cannot open shared object file: No such file or directory
> > 
> > Looks like our BPF CI builds are failing since 8pm PST yesterday.  
> 
> Looks like you may be one step ahead.. BPF CI runs tests with LLVM17 + LLVM18
> at this point, so we haven't seen that issue yet. Maybe Manu has?

FWIW we got a PR on the list last night which was based on fairly
recent version of Linus's tree. I dropped it from the test queue,
but I suspect once we FF this will come back.

