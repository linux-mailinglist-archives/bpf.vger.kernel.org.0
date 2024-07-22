Return-Path: <bpf+bounces-35259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6409393D9
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AF1C2172A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2B1EB26;
	Mon, 22 Jul 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg6sj+SG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE116EBF0
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674095; cv=none; b=IUNaiPASftCVF3BWl+5FgVq0oNr+9nqdX0lIdbepgBnil2rojaUF6hu3Hlf8eBybnpvoOPFrdaJGq06Fg8cMJvdUNslaOeKkz7Gl/s0lt90dAhzvLj1+6bXw4yWab827b/cBAzSnzTTfYVuCcCG969uhCbhUjgf8LaQBB2+h6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674095; c=relaxed/simple;
	bh=CuC9m7NjOAbBEy4ezX67ETe8CrZhyudET+W+Dt9gm1c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=mdu1lpKttodR9ZwvWfVj5NmtL1WZQ4JH3729lk7m+GdbAebA8exEzIcF9xv3l3PGHfHesej+ocYTB7VFayglT0QJZn76kY+5bzzPqe7VDDHLtDPqj3u/U6vdecpka32MMsMV/XNf7cD9AFOmTzzQBqL2R66I+p5GgCvs0R81iWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg6sj+SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5BC116B1;
	Mon, 22 Jul 2024 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721674094;
	bh=CuC9m7NjOAbBEy4ezX67ETe8CrZhyudET+W+Dt9gm1c=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=eg6sj+SGKL2+hGj4GJ/v7vOdwFqRgrs2zq3T5KxcbGwgCBC0Dci18NaFBjk5q/z+k
	 MwmvANVekv/ilAgQW3a+z+/d/U9Ghav0YbhZELcHuwuPCHDC3dn1xSjGm4B/9Jz8v1
	 788spayfFjKRlXqUMRU9K7dYS3y7EOWDJyXj3PiV4iv5CZQEMkwV7OC3IQQbuiVW1U
	 LTw3BJuz8E+SOy5dG01PbfzSZ5J37i93yLqJ8gr8nh+j07Tmmd4o46E1KXK0OUV2ta
	 Yd+jsMenHhYBz1Hbk80banYQFlwZcRcFg+ufYtQuGK7jUxYOW09iZNMbTGm3wwDJ4V
	 5y6Hb1X2Fgcgg==
Content-Type: multipart/mixed; boundary="===============8216496742830240649=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <932072c37eae700b9a3823e2f129dc0f65ed8cefd0c2609c8e600efe8ee70473@mail.kernel.org>
In-Reply-To: <20240722182050.38513-1-technoboy85@gmail.com>
References: <20240722182050.38513-1-technoboy85@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 18:48:14 +0000 (UTC)

--===============8216496742830240649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873035&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10046377631

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============8216496742830240649==--

