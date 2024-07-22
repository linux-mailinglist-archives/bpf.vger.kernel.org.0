Return-Path: <bpf+bounces-35209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C161D9387B4
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 05:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB02816CB
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530B12B8B;
	Mon, 22 Jul 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLXdL8M0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4216419
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619270; cv=none; b=ZQatp4VXYEgw0aYKa+aErAWDpqlCbQ631fMEE6EiCbVtDbFnvHwkKyj6U5ZMb1uMmzmMhBnlA8pmLBC7PVCZWPQohIrLugFXoWFncL8z6y1jIaEfiltTDIDqv/JDg3JR3hVni4BaaphbLOtHMxy7JPxjcsVsTvQ97coWq/HZ0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619270; c=relaxed/simple;
	bh=6WL0twa8To/rQRFCwhlBiFyLIpbIH9zhuon9BIs9BY0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JYViZOI/BPtLiwf1IQggHCTdP2EMg6a06i16l1FOLfIJ0tIpBVk8oCHxnC9JH+3rrD6a39eG00GIKZ2762kzhql6OozJfAbe2VARaeoaBzHkktOnpBZHDwCaNPUf3As2lXAypnSFEy5XiP/QcPr1YPBkUoM8Slw9M3jHeGoCJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLXdL8M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE50C116B1;
	Mon, 22 Jul 2024 03:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721619269;
	bh=6WL0twa8To/rQRFCwhlBiFyLIpbIH9zhuon9BIs9BY0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QLXdL8M0Bdi/gvkWRCyTUGERNpYzvicoy/DG2Yz5ovmo61Y8UTTkhc7GZje6BNbTN
	 KnveS01LVkMvEKKQ4ilBlPx1U2lOIW4ZFnJtHXnfvKU/DolMm/1hzeWs/K8j3cZAlO
	 2bcZsEyH4fs88/rF61rtBWYCBFq9plPy/H076XnW4eTpLbWRbn0iulGgtk2eFcbgt6
	 9qXZE3VAyzo7d1L27Rt0APbhNaIczCpJJkhV5G6fiX85TB8+Q1LCbkzINNXseciWCb
	 6GEltA78BJSabgmsYZvdvhlUuCDDsT7B1U8nTeUBCXWOf6zN1bXhUlAz8+4eCdkpdq
	 pzof7GOQlv19Q==
Content-Type: multipart/mixed; boundary="===============2888431360538201791=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9df0f1568761d23fabaf45630cb981e9d3a0d0880136194f7d73be5818673f0@mail.kernel.org>
In-Reply-To: <20240722030841.93759-1-dracodingfly@gmail.com>
References: <20240722030841.93759-1-dracodingfly@gmail.com>
Subject: Re: [PATCH bpf v5] bpf: Fixed segment issue when downgrade gso_size
From: bot+bpf-ci@kernel.org
To: dracodingfly@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 03:34:29 +0000 (UTC)

--===============2888431360538201791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf,v5] bpf: Fixed segment issue when downgrade gso_size
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872810&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10034064977

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============2888431360538201791==--

