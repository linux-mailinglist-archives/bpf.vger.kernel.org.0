Return-Path: <bpf+bounces-35183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8789383D8
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B00C281135
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 07:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD08C0B;
	Sun, 21 Jul 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+VTz0TV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79517FD
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548439; cv=none; b=ll9L7PTPCBRhJCXmQRvpc9DtCZYFzrGrAayIswJUhvJgrta02LgS9uZM9OBPBlLkheGGJW0+9XU1KwHD0gIaT+i/wJSWDN+FgtFBDUSjp2GwcAq849Y5nGpHCV6wCMT0J9JnUabZt5RDNRZF51CnMMr43JdJyREySY+ngEPRVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548439; c=relaxed/simple;
	bh=idv3Q4WjXbMNuSpjB/B5fTVTH3kzLjx8T3FsOU8dd9o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=qDJ6uRodhqnmCWlXUk06YWO1CK7IU2iZViraYj/VzYolEGMWv5BDdBBH1nc4WRMjuAMXZK3IQbL7o7gb6vsd+DblTKP0vqLsv+pSw+LVdie3UDxstX+qgPkyYbg4UtZLs+rmnaO2vImRSBa5DCAhD9UKTnKlRJD/1C8T14QQVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+VTz0TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ECCC116B1;
	Sun, 21 Jul 2024 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721548439;
	bh=idv3Q4WjXbMNuSpjB/B5fTVTH3kzLjx8T3FsOU8dd9o=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=L+VTz0TVYiuVWVC8pk2KhOH2PjtgtGe5E+xf7r1YoXC8cXWQyeLXLdqnfKznk4f+4
	 XM0RtQQ8SFJUTFFD4/BvF1IoAJ5jJPzsqgiD3RYpA6suiv59Vzl5qGq1pSVmTLdFR3
	 6RO0NvAfOK2GfABMr32lQG2PNJLjpLAu5eG7xZDeSh4rG3axcAIP4MfPpLn+gxvlyp
	 dCVeHtPvV6kdBSKeK0oRXbDpDTHRtMPMwA9vsib4xO9adT2Ls6x0Q3HcOW/6/1A/te
	 rpG7sggK7PUolJVVVvMy1v3E+wGWJLiNqAqvgs1Vm/CVIA+Xe19NaBjVRcjyQ/in1H
	 tqN8v7JOXHQ+g==
Content-Type: multipart/mixed; boundary="===============5195140005980910768=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f12ddfa4f1cdafb4a02440a4847403a3a21865077ec957627cb67362db196c7b@mail.kernel.org>
In-Reply-To: <20240721072951.2234428-1-tony.ambardar@gmail.com>
References: <20240721072951.2234428-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v1] tools/runqslower: Fix LDFLAGS and add LDLIBS support
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sun, 21 Jul 2024 07:53:59 +0000 (UTC)

--===============5195140005980910768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v1] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872741&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10026613145

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5195140005980910768==--

