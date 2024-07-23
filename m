Return-Path: <bpf+bounces-35334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD5939845
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1859D1C21A2E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA326ACB;
	Tue, 23 Jul 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXcLCMwB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D01DA22
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701922; cv=none; b=HEseokDP319llz6CYLFExS2JWuLPYrzxl+ZSOoZRJvfVwHniAD+Txfk4qBZc/snPmilJXuXs7YmKDlU5MtoyX1QlOpUCZUV8/nUBwOWecHJC1ZC+BgAaaD/ZvK8OfKKf3YFSQfPp5fABilIQj6b58Kj7xsDuKeiSmqlmBVl7Et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701922; c=relaxed/simple;
	bh=vvMmuIvAuczLPaklYCA/7SN71yDcIqcK+5yARaOf4ig=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=jjMiE0FH2+UVZIeElXtS9lWnQUO+pxOA9Gmb0AjrWJsPitO6si4gk/B/4VGDI3CsZLHQiRdmMm4zs9pMFwrQIEkpENT56iSTm4WldtsSaUSJh5qwDp1PH/sF1i2sRKovMTcELkmVMM0XVXPu+LeKih8IeS7uEQs1IJTH9LNxJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXcLCMwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD7C116B1;
	Tue, 23 Jul 2024 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721701921;
	bh=vvMmuIvAuczLPaklYCA/7SN71yDcIqcK+5yARaOf4ig=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=eXcLCMwBGL4viWMJNxBrtP09vdeNyFWFvfoJXxP03YPwXw8V2W4kJKR0CD+6uKta5
	 2JBqzVlpDUXI6AvcakfYokRjFK9RJch1h5kYjoqazdalpuSjZwhsXHpmMyHUyuDoio
	 2uPkHi/5+FRHvNTK+zl0CPlYz7aoBc91wpc+TizhUgHn9H3fPFvtr5D0j7jFhx+Ehw
	 gqFPhBt7EHGKdEFIMAXZiu6QRYIx99N/8Mz6/8fvLzOyPu4UYqTjS347scpHEXWvcg
	 0Gv//SdpUHIdyYkxVSHSkTGjxl+0yLPWMqPWG2sFcdNn0LadvRRP9Iiur/YoGRUrfj
	 3W/PKKeOaqT5w==
Content-Type: multipart/mixed; boundary="===============2857778823700408674=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef1ba66c2bf98cd10dee2aa2244c3eabf60f27a794e86756a9f5b182c19ad5cf@mail.kernel.org>
In-Reply-To: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
References: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix error linking uprobe_multi on mips
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:32:01 +0000 (UTC)

--===============2857778823700408674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2,2/2] selftests/bpf: Fix error linking uprobe_multi on mips
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873092&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051521603

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============2857778823700408674==--

