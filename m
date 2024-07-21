Return-Path: <bpf+bounces-35195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B6938548
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2EEB20DFB
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C916726E;
	Sun, 21 Jul 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRlat121"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F0BE4A
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575515; cv=none; b=SrEako6MiT6dubQhlNaSNjFlTVbvphzvlwm9z4KOt6ApKciauY/6IGBSdtZIYhAUBgPnwEXhvD45MJNLRW2iVunIutx/SkHr7o2AGsF0WwVczXgwjwCB1lZ4qjNxuidFs4w8flkSjlew/PPR9pMCk428eKKGjLBeX4nWdgPnJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575515; c=relaxed/simple;
	bh=0uE1ts1VTlLRnz549JXQuDaROTw8nvmGTY391JsGa/8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dYaDzz78CUOB59z7IMmgjCvkZmHxDMEg7/O012shVu2M3qnHeZGcFSghQ9nx2r//66MywyEq9IFApnXXFhwMep8GveiTytRLE3PZWx1StpMnkgsaqFCB0SfJe++fpGowLjRfP12S9rxIRSmDagGU7vQRQcxx70pDxS6lSH3OTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRlat121; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9950C116B1;
	Sun, 21 Jul 2024 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721575514;
	bh=0uE1ts1VTlLRnz549JXQuDaROTw8nvmGTY391JsGa/8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PRlat121z5iMJqboy7BYlS18Nf/ZMV4DNONupeGF+CqnNqvwsXTDrekz0VSejY19S
	 hdmT+DuMliCT2hxoiKti1WXJR/m2WSu9FoP9RhOk5ONy347fLFJBkywBoWFIyii2WL
	 CZjo1/AFPyAPhBPtGj+kHqKbnvRwwCQseNNPHRKzkUjD9NHXYrCzkOEBJglVoBCraw
	 IgR8z5RyIvB0giOWHr1jVdKC+jf+QswT6VFB9otCHOVlx9PL9xsO9S5WcIw0YYR4bN
	 zc093eDRTibpff1OfDxcQDOwSyNoyULYy9C0QhyIoBGeywBg0C7sEqiaVkKW6qfwdZ
	 cRYIm308DXSAA==
Content-Type: multipart/mixed; boundary="===============3789227618421739538=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a30681b593c83610e3288a98954dbc9591233cc3cf9505c68ce76c246e3c155@mail.kernel.org>
In-Reply-To: <20240721143353.95980-1-chen.dylane@gmail.com>
References: <20240721143353.95980-1-chen.dylane@gmail.com>
Subject: Re: [v3 PATCH bpf-next 0/4] bpftool: add tcx subcommand in net
From: bot+bpf-ci@kernel.org
To: chen.dylane@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sun, 21 Jul 2024 15:25:14 +0000 (UTC)

--===============3789227618421739538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [v3,bpf-next,0/4] bpftool: add tcx subcommand in net
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872760&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10029201939

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3789227618421739538==--

