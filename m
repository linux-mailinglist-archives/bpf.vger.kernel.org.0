Return-Path: <bpf+bounces-35260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A69393EE
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA694281EC6
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257716EB75;
	Mon, 22 Jul 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0Yu7imr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC389171094
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674711; cv=none; b=GXzCueDXDllwJprpSCKyPpZ5Mz4Gbb8gHLc5wIeI6HrTkqqessIDqrnhbUtu/07oQseAaz0Dohttt9tlr785gZ+Nr6sqXLx0nuEB1HO6OvbILBNwVLFi/xjKNklNRPYNF68etF5K+//v/NsF9z6fhEkJEEHx41qCp+AXsc45/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674711; c=relaxed/simple;
	bh=KC1XjHsC6Vkg67tZkFSDWCWTMgpLgBIamzKqVetbM08=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=t99d6Qo53pfqbzPYfyY27FQyC5IUiwCaq8HKePjXKE8ciZAJcslev9R2Wakp0xtDWj4Yy/X5yMdCvckZsRmJuM0U9iAoE89ZDNtolNO6n74JDJzorTyUtDep24ndh5WXi1Zs6oyo6+MezdbifQ2hwJEcqD4F/EEsHP49HKAE5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0Yu7imr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D2C116B1;
	Mon, 22 Jul 2024 18:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721674710;
	bh=KC1XjHsC6Vkg67tZkFSDWCWTMgpLgBIamzKqVetbM08=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=k0Yu7imrCe9+IgYIIYbJOT4ElkA+rpicWhuCTU6QP+Lex5Naf7qVdC9SiAkho6WRe
	 4enjY1xXxjjD8p84ucC2vm9JHmUMckJuNBn9DvlqNt9tM1EZSNiqB5Gyc/hVshmnxn
	 Q//ajgX2CgViOfj0Ur3s6fRMlrVE+pQFsksyN+A+lvRizB8BPPo2gl/OsffSxt99aj
	 9QWgfw+otAOxrelbDWqh7tqhbm/lFArSmHUDAfz8blYOD5Z/U9Pf/obMFfXl1bKWao
	 MBvgzqVMntWygpqisTakmOayAxg61erlCNhGl4ISzw0Bq79U861wLHL9mkgWaGKs5Q
	 +Rl5fDnwHLh6w==
Content-Type: multipart/mixed; boundary="===============9043036107087481681=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26e7aadcfff41184da6f0709925fec1f2ade5b06c6bb85c408f2f8e3d292c98e@mail.kernel.org>
In-Reply-To: <20240722183049.2254692-1-martin.lau@linux.dev>
References: <20240722183049.2254692-1-martin.lau@linux.dev>
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: Retire the unsupported_ops usage in struct_ops
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 18:58:30 +0000 (UTC)

--===============9043036107087481681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [v2,bpf-next,0/3] bpf: Retire the unsupported_ops usage in struct_ops
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873037&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10046511396

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============9043036107087481681==--

