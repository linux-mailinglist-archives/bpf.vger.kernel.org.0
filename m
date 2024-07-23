Return-Path: <bpf+bounces-35379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CA939BC7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F111F21F8C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD1814A4E9;
	Tue, 23 Jul 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay50z0n7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5413C9A3
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719966; cv=none; b=cyzoRrjTaZfTFw77DLxWZij2KsLHMyGQ6J6+Jaopc7FvTBmXhqKc+FvzlTzRSU8IWrHWWyNM6jpQJFYaHhf7OBMMhOiPvjg8Z0mzlhL1RSxVGaljuHINQQaeD5aU8rrNJEZqNrSxAwzA9uKHj8lLlAZbSW8bJZYj2cVwtdMYMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719966; c=relaxed/simple;
	bh=NRYl9URDQKf6imnc9iv3JxE/rtAhbWP1StU6wMqbroU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kkVHcF4QNAgpyntk5ce6umydmdiQ7vR9ja7vHIX2c1li7QoeykW/xM7Gdtd1tZNoz4wvmkjVm2RjNTL8Yyl4WSy25vRDKSGw8OjrHZM3jRgIHP9fujq7F+mWiGrJF3/SwjWMgtQhoTVJMzaxpDBsdExLw54h50SwnGUuSQ08RpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay50z0n7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1709C4AF09;
	Tue, 23 Jul 2024 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721719965;
	bh=NRYl9URDQKf6imnc9iv3JxE/rtAhbWP1StU6wMqbroU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ay50z0n7ImoMrqfeucdTUNW/EHd1a4dHkSMNEjw8p5vDpFQU4wEFx0lHczQjgUi7Q
	 xQIIeZLOHguvKuRP6gec5NZe1aF9gAsBqUlSFRYkwEXUpi3bgieGjCtNHhUPSHGaGP
	 qUDY2KJMtUGb83dCAzrMHLInj+4SfMIFm+J72NFoewY3YUa0p1C3zNP8p820eD115o
	 Ym/rewOjiiFH3IsBMAs9cWDP8VQE+yJVpV8k2C17TwqxXGCNQOhc5vEkRw9/ylCpI2
	 CXqJ2I0Es/QcyyU/drVIUlvF9t8YvA/dbGoM84+IQp4E1nA92idbVf4her//5TF3an
	 HBCa7nAFRM89w==
Content-Type: multipart/mixed; boundary="===============1312929107027033210=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62eaa7577cbcefb15532c19428669602f281276d0744e028f2057eec80c0405a@mail.kernel.org>
In-Reply-To: <20240723071031.3389423-1-asavkov@redhat.com>
References: <20240723071031.3389423-1-asavkov@redhat.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
From: bot+bpf-ci@kernel.org
To: asavkov@redhat.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 07:32:45 +0000 (UTC)

--===============1312929107027033210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v3] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873153&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10054486016

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============1312929107027033210==--

