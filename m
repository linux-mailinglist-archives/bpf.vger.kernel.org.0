Return-Path: <bpf+bounces-20022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07BD83722F
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6B81C28F21
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D691F164;
	Mon, 22 Jan 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df+qovfC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1A1EEFB
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950107; cv=none; b=eEikefTMAjeZ+MZHTjnmAeT/ME+U2xoul6POFtdxnjCVy0cY2s1/fi2dO1fR5eXdzhXDyuwL+rFzNOD1bVF1hWSoxog2VFT0ZM6XQfJUbqyYjowYlvC6nPGBJVsoxtnxN3k698ru1TujAjUoFH3wKqR1nzJ1C8h/zznN62FduBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950107; c=relaxed/simple;
	bh=Hp3cOFwgBQ9bp/ds7K8MsJ/3uW3zZGClZASpGon4lms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TYVXUJA+gNxHKpzVzAx8hLwU7MSUaJUdwhQsFZnp2COthpOp6jB3sYh4B3F3LfKRjVizKgWJzZvnqs1T176Xk7grxKpLN/LXL1mgbz4jIWx0j9SZInHwWn1SaBQGsufF0l4Cbb7HIj6ioWwyfUHVqOYwWTLzg3h5V3CsFan39a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df+qovfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A6C433C7;
	Mon, 22 Jan 2024 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705950107;
	bh=Hp3cOFwgBQ9bp/ds7K8MsJ/3uW3zZGClZASpGon4lms=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Df+qovfCtOHWeFg9Yk0mc1D/oX5dT9cGB6nd99EbVYqdjqJhYr6DEdVR8OruGoZH2
	 /Or081R4wMSYEsp8nlLhU3d/D8Gij6BE2U1R0C6cklUPkv4fKYjJuRa3Jyrcl+DeZn
	 xSkrItUHJc88ItTepS5CKHNz0ZGHfvTiL4EHBuQOEGnmTAaWdAqEdKNay9A+quPXDN
	 28qEJqfX+ZxSW0saCRcO5GxhXSgkRgifjvRvja0nKi5beLrkNB1rnHF6gVfpqvK5gR
	 SUjLqYp1WitS4uTBLDpqJUOMzM/iLffoxjd3RdCtW12gvWCSyvs3A0glhVnKf2wxlS
	 Am+UbCzQVPE2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD0A8CE114A; Mon, 22 Jan 2024 11:01:46 -0800 (PST)
Date: Mon, 22 Jan 2024 11:01:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Instruction-level BPF memory model
Message-ID: <b8f03fa3-1ecc-4a46-bb36-947959411739@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I am proposing a discussion of the BPF instruction-level memory model.
This is a follow-on to discussions at IETF and LPC, and would add progress
towards standardization and hopefully also tooling.

							Thanx, Paul

