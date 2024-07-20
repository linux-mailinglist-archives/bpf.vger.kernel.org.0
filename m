Return-Path: <bpf+bounces-35143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A92937ECE
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 05:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86900282340
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB78F5D;
	Sat, 20 Jul 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNc57IYu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0D1C3D
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721445337; cv=none; b=iL55mZBtSvjpEakUSTJDTRmRTtDWlzR5LogaMROmuMb/oOW7wHiiwOe7OxUJByK44MLBnGcZx0dfDQNx9ZGawTzjEotuISPSHggHsVEM6NaO/klyWt4tSdUg7vQMHDDx4PEOS7NbM+dbLH2HQsCrWJUv0nXhm1I//TIgZ02AC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721445337; c=relaxed/simple;
	bh=vckH2JHAGIPcc343q9aNB8aq/WxjPWRJDFSjxHe7hec=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eThqpUX03imdMGilgnBg4Es6H6QK7MwntUSQjepGfrje6AkQBxtoGB6SkORGpp0mmveYBZTBoRpnXmsVf5rjJpyQ8RpwqbCShpcCgZBQeQ4a0uzQN69oPbUxSdOf/QVum4sYJnduiFVNlGvveKUGAh4bl2cAaB3yXeD3M70xNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNc57IYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536C0C32782;
	Sat, 20 Jul 2024 03:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721445336;
	bh=vckH2JHAGIPcc343q9aNB8aq/WxjPWRJDFSjxHe7hec=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uNc57IYumGok9PQSWpW1nVDH2EipVFjLdMvr13C2TMu4cpFXHpOGNVCUp6KvVHRmY
	 NgQrmWGEPXk+oomRAlHtSrfhdbJ/94HR9akaqOKt3kH39hxxubDZVjJ4wS3yh6lyp8
	 4skhJHVls0jP638468pF44oNM4ymWAVv54dgkfhcTHl/EMKxKWbjYUy/Fu8oGA9JSI
	 dk1m3J/iJBz8aTTFcfzY7tqEaCKcUVWKgtpPYkMuQzNcjvIUaUYgnPslp5hFP7GSeO
	 PjaZ1ty2uKCBaCZFmIoDPFHOvytDP4yxKLBJuMLAfKXkB5kOkYLyDeaaUzIh+xTlOg
	 SnqMY5/Vx2CGA==
Content-Type: multipart/mixed; boundary="===============2168120588725121851=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12d4ce060b1c06d015bdc4581a8d92e26f1b5b9042552d2b1de722cb25767e42@mail.kernel.org>
In-Reply-To: <20240719025232.2143638-1-chenridong@huawei.com>
References: <20240719025232.2143638-1-chenridong@huawei.com>
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
From: bot+bpf-ci@kernel.org
To: chenridong@huawei.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 03:15:36 +0000 (UTC)

--===============2168120588725121851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [-v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872395&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10017036663

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============2168120588725121851==--

