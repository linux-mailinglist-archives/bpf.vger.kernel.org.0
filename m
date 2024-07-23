Return-Path: <bpf+bounces-35343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFBA9398CB
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39521B21CE7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282113B59A;
	Tue, 23 Jul 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmrfw7Su"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11C2F2A
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721707391; cv=none; b=F0l98uV949Q82SOCTi1gwFEP/3NpU239FZgD1zWw7kNxbWV5+jYjtlHoLRTCQoiMmHTreMFxDq0cwTnth9xEV/NabDJaTzblbQFpyUrBh2aJlgOkgne6hHvtCMewr3tocHB30T25IVVL5wJFXS2cd07WL2ojOyF80jVNSWvMsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721707391; c=relaxed/simple;
	bh=cXd/gYNgBBzK8Q2jbd71VObSUJCQZb9Dl84MPvmkQF0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=nTWHvKNCp4yrTRgma0ME0TkArODmVrEuIjQd9/JbEU3mQon4icDMVqrs2HSamBwBIXH95qPHpZzOceR1pmkygToz0BX8tLwzRfONW06DR3yBRQ0xpIL99WawOLi5FYSemcThEvBqfSaKeX6WV7Ba/wi9sJJNoGGztxdMY+T85qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmrfw7Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD539C4AF0C;
	Tue, 23 Jul 2024 04:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721707390;
	bh=cXd/gYNgBBzK8Q2jbd71VObSUJCQZb9Dl84MPvmkQF0=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=Tmrfw7SuX8wPAuGtbpsHkprHDjT7WLO8UqNUKGfGoD0eFHZGjFkF/ZRF26FZnPqFH
	 iV/it4/Dyl8e23gYLiweUs3Kp+bAs/O7vauqqmhhcbQyOfjwmvmeVYcGI6vsGU3BSn
	 GIC1RHex99BaySa9yUKFfA3v9wPPJjfKiVxYzsOnJSHVBA2OcospQKYBYDEGHjbZIx
	 6D+CwKhpGKd4L2qA28apJCZBmf+mZ9taIqsvLblJA4QpznCiCJed8rg7ve6he8EJe4
	 usR7WXQyVAC58S6juBU47NwgWaCpAjrJcu7+uZ4U5Ya2hFitGbOIDsofeAK8DkuFXv
	 ZtjyattpZcVUw==
Content-Type: multipart/mixed; boundary="===============7612941560685554164=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c53df6088ab469f00c288446e966d6363514f1be38412cb3d6c9e23c312d89c6@mail.kernel.org>
In-Reply-To: <K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=@pm.me>
References: <K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19HRx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=@pm.me>
Subject: Re: [PATCH bpf-next] selftests/bpf: don't include .d files on make clean
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 04:03:10 +0000 (UTC)

--===============7612941560685554164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next] selftests/bpf: don't include .d files on make clean
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873111&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10052097292

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============7612941560685554164==--

