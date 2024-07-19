Return-Path: <bpf+bounces-35117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D4937CC1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D5282340
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36011474CE;
	Fri, 19 Jul 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyw9NRGt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EE1465A1
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415287; cv=none; b=Pd8gKoUXFO1VwCdoBX8urnK3ZCVnSsT7gkgA3eQjwuAJO334m9pJxXfOLbzcqkTUqfqGJdl8eLI46CW6lQ17ImFY9wNDv3dMqwEhmCnRi5Hbz5LvKDpzwPEHgl45NGdxcMEUonvBk3UlB56nTRLCH2wWVyWAuksiZzfmOJuKk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415287; c=relaxed/simple;
	bh=c9t7CFI+yJbnLCwlVCC2nkBftjWRH2hJaa3i7DoFxOQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TXa9IjG7I2gz5qYk+QF4PZGap0Lng9zjO+uElSV9y5bjMe49QqDmQuwfAY2XN4YLik9kQ+EYJ+PIcTfZY92hAqVvq1fEfk1sikKSMa4mFGBss/KMMb0Zgb5FA07xIiHAG2xBlUa0FKo9Wn66LY2HsNBroDkGoAFuZJyuO+LoyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyw9NRGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3343C32782;
	Fri, 19 Jul 2024 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721415285;
	bh=c9t7CFI+yJbnLCwlVCC2nkBftjWRH2hJaa3i7DoFxOQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jyw9NRGt6tae1DU/t22chdCMHfAtcIfgPJxhRbood40gPOr27pyp1xm/LJl6y7W8H
	 XHULr3CYeyimrPXhtKKky8WpB5d2BG8K4pgK0wip6H7c2mYBkSvw70srQbeJJBJ/Or
	 PaEFcLJhZ1D1uuj3AECSnM9dZhffvzdUmrekqfFYqfWpGh697fBr87oZU1sKNIyupy
	 KNsdO8VTrng6Z5mzbQUY/Z0siSaVNAkagkZLfXk8iCvluD6qoaW+xsepMvNkwzc8kB
	 A0tDY/veLx3yJH/3sB1s51b/1kNJnnpntZTK1fkEE0YYr2Aw0FZ4A4kryVSVJdG9Ar
	 xX3K+sL1VWL8A==
Content-Type: multipart/mixed; boundary="===============5205221416414376778=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d928553dd1ba8dddd9d7c274624014dbc38b8cd27dbca9ceb6bc707243868af@mail.kernel.org>
In-Reply-To: <20240719025232.2143638-1-chenridong@huawei.com>
References: <20240719025232.2143638-1-chenridong@huawei.com>
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
From: bot+bpf-ci@kernel.org
To: chenridong@huawei.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Fri, 19 Jul 2024 18:54:45 +0000 (UTC)

--===============5205221416414376778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [-v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872395&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10012618417

Failed jobs:
test_maps-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10012618417/job/27678894884


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5205221416414376778==--

