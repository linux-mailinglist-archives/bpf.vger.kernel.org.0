Return-Path: <bpf+bounces-63096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3FB02770
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CAC3A68C1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B32222B7;
	Fri, 11 Jul 2025 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2xBPAyw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756F1B0421;
	Fri, 11 Jul 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275373; cv=none; b=gpCZ1ygfOoqNdP7mU0eqZgcuR6Qu8K/kAU9JII7JL774gkkfjWx4lxJEZ3pa0tuD+DWKHSgCQrEBU/6gGNPBM0quIfNWO0z8hu9MnSW6rsY4XbR2fjeujDlZ0LB1Rw9hfH9qiynzSDuSSI6uPGXpQIdR2y5elGLc3GhcXKEz91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275373; c=relaxed/simple;
	bh=MyqGTVRuUl/qArge7ni4aqgeoQvWo4uPemCKb9pCUVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy30kie9aKztGH5UYgzVMqkduG/N7wKTW7FLWb9LtrhjQM6dWmbprjQR3dtdVH+LVypXLs9YHoKtjUGc/D3hoyEOI7p/l/S80NpdYtmncjRz2AS8ZMvDiUeX9LUX5D39rUmH5MCUvu/8sOGNFLqSXxaySb7uKKK2lLmy2vFj8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2xBPAyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EF9C4CEED;
	Fri, 11 Jul 2025 23:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275372;
	bh=MyqGTVRuUl/qArge7ni4aqgeoQvWo4uPemCKb9pCUVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2xBPAywYjgc9innhbqzfi+r5ZVgMSQ9UUOxXb5tlRXA/00O5QL9rN6lT6SJDeeoR
	 1E3PAFG7MU333BqkvMHuPUyZRp4Vf7bjliLYSFzWMhqcf2AJ6TWcTfcX33Ic0SV73q
	 6HZvxb09JWgTwrzTyrBJNM1gpgunMSHVqo2IRqL3A5ySQ4fafe9FMXfLYyeQLXvCkd
	 OfttfrTmDWWJNKBIujtkR5b6ZK8D4uMWw69p13SIIUbX3hRk3YPaN4kyH2VSxZYaNO
	 0Y2ydLPVJTV/+5TC4QvKrpY1hN6+lNlDfqSZ0l5PQE0O9zO3rBN3PpWZLG2QSyKKjd
	 peoMumZsoJusw==
Date: Fri, 11 Jul 2025 16:09:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Whitchurch via B4 Relay
 <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Cc: vincent.whitchurch@datadoghq.com, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/5] sockmap: Fix reading with splice(2)
Message-ID: <20250711160931.12ec952a@kernel.org>
In-Reply-To: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:47:56 +0200 Vincent Whitchurch via B4 Relay
wrote:
> I noticed that if the verdict callback returns SK_PASS, using splice(2)
> to read from a socket in a sockmap does not work since it never sees the
> data queued on to it.  As far as I can see, this is not a regression but
> just something that has never worked, but it does make sockmap unusable
> if you can't guarantee that the programs using the socket will not use
> splice(2).

On v2 you should you can't replace ops for passively opened
connections. Can that not be addressed instead of adding
an indirect call on the data path?

