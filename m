Return-Path: <bpf+bounces-35340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081B939874
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0C61F22207
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145613B599;
	Tue, 23 Jul 2024 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ7XFwIC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF113A241
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703340; cv=none; b=hLICeM5CUNcjJ7ReOcjBOJjY+KkVE8G1n5vkLmV9QIqdA3QdnBsFCtQrDs+rSYa+XfM/gP30fh8dK1yQ+TMCaM+cejwu8xnCJBNryno5vjRDr2T9VgEDY4TT+8lDfHj4tGyVcEj1qW69shsfP+G10jyjZa3Iy06Nys2x+dB2ZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703340; c=relaxed/simple;
	bh=FstG08uGimcip0oo5RrEcQgHhZ7wdsR8KbJtfm4dBAY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=DyoZ5pg8o6H2126puiDvhZMVeu+AnTHKWZR9vwjxEmZuuEXgDohdiH2NaId4Nv9O/Z+CzSayAGntETAJ0J/gNAwY9TUrON8vk/+GE6Sn0VtcehSWmNihqOYDmv9ssLkEqoTW/0ty8OUQR9zjPanrIiPyidClr2/T0jDQkz3+pAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ7XFwIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642ADC116B1;
	Tue, 23 Jul 2024 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721703340;
	bh=FstG08uGimcip0oo5RrEcQgHhZ7wdsR8KbJtfm4dBAY=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=VJ7XFwICVB81CUfXXhgLCRZ4WNNBlSBG7lAN3F2ecBLAJgc0OfFJodLMp0tYpBrWx
	 fv+0dQK33vZMylP4RzIMzDC68zoDFhQqq6O2/lEB8yl8Hqleo0Z3mQG+/i4d2yjj4D
	 brwPVcGob9XKaz32RyvOA6FcaViF6wDAmIDMAtxke4wU7YdvZ+hWuYRwAP7gD5tclX
	 DAVUyt0wyyhQT9aK9BnXV2nSf3r08rX+r6mR1klnhXf1nHjxLDFdCEo12gEXRHOcQ4
	 nOvtuaOs3Eje0p1rj3447kSOw4xYXLMGl7HNJaGGQcn3i7gPcLGq17jGFuSkzWRPgh
	 icQMgJShYk4gQ==
Content-Type: multipart/mixed; boundary="===============6237845755855572637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58cc567e453ef4f0d0f28aee61015f2d0559f99c81c3b707c8ddc7102697c0dc@mail.kernel.org>
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next 0/4] use network helpers, part 10
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:55:40 +0000 (UTC)

--===============6237845755855572637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,0/4] use network helpers, part 10
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872683&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051538319

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============6237845755855572637==--

