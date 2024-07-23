Return-Path: <bpf+bounces-35366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F93939981
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD11C21A55
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D213D28A;
	Tue, 23 Jul 2024 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLk/h9ti"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E913C9A3
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714287; cv=none; b=FRy8xpIvMVnQnRRtLqgdOlyYzwff8hac/5oLg+Sd51LE3rMDwqAz9TlVJ6AIgV0ff117ssLeTiD4voRNMNf5B6W0eT0L+7iQ3SsZns0Ewu13zWt8h9PC+fPZhXqfcNTv7kAgFDBWU/v6tSAgRJhzP1ogFTy/4nQ+xmEP7YrZMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714287; c=relaxed/simple;
	bh=ObKQEL5qK8xqnareip21CgWd0mWl6nrzoLn1IEUP29k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=isfNvxiX7Rv1JNIYDEK4YDAuJNmd6jsnJvflbCwYwZyKYk40Yq+6+e/x8JRiiDJl7+ICrc4GSC7ihYZUWg6mrP3rf7EO8FVGpi+L9E5g9DB78VuUhPMHsfb1UsVmV5JxVYRLjTgR9fN934G65WxQ1YxzodwKg5TipF29jMM2160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLk/h9ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D26C4AF0B;
	Tue, 23 Jul 2024 05:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721714287;
	bh=ObKQEL5qK8xqnareip21CgWd0mWl6nrzoLn1IEUP29k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CLk/h9tiweQ+lLOYFhG6BXFDkNENmYJg2Q7fXVOpXfg0o5Bw1OwFV5x4Pc++RPZAV
	 /9J7M8YpQ6NfFQm0DHzZKJ5Hg1j1uJe3lZw4YaaycpEGEVPJeAwbUs4hgVA6a47UAx
	 KHX6eVMBxk+NjRbPPW06nvxsyTB4zu7qTA+tTiizDUHIySII/i3xi1uBUpf/opGhU2
	 2Q02/Y5mLCUA23loo0yiXCjYbi7dvxQ0QfSVmZtLi+KnfRhUE5HnTIvbsSWLL/GegL
	 9IcnzqofNzrzyKgONxBOT0Tb4quzdIO3SW3GGvaIl6RW7Ge8uUQNDZsz5qVbjlZtvV
	 qaTF9NM+WReKw==
Content-Type: multipart/mixed; boundary="===============3596610513294132016=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f64ea58845f96bbda3d8f4217732cc9663df204f55dcfda66ce2dff3f5304f0e@mail.kernel.org>
In-Reply-To: <20240723051455.1589192-1-song@kernel.org>
References: <20240723051455.1589192-1-song@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add a test for mmap-able map in map
From: bot+bpf-ci@kernel.org
To: song@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 05:58:07 +0000 (UTC)

--===============3596610513294132016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next] selftests/bpf: Add a test for mmap-able map in map
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873122&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10053209093

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3596610513294132016==--

