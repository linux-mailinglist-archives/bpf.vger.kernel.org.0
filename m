Return-Path: <bpf+bounces-31693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB586901969
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 04:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4680FB214AF
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25579E0;
	Mon, 10 Jun 2024 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOdCc97m"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5F15CE
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717987695; cv=none; b=aXBKKj3fFlQ9+qcWvPaLrBbMFYvwHYdrel40TgpBV7ZfcfAl/Pxfee6W5mI74Lfn150i0wM+J3bxww0Yg/z97hiYkQVIlul/kIHWblz/4+0K3nTxUOf0Uk1yu0RyJgBwF8Utawc5FWFENX9XRRL/OXzi698DiifiUeJzbRFJwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717987695; c=relaxed/simple;
	bh=aJFDJfo2FEpExt4suCvJnBvrqMSVkpU7ev0uSzHWbfw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eoSu8B8P7tNewjKPO0CJKgj0iyjee1WGGqr02uqWYD1jyksLbcJzpnbL0GMhPRLA8/jCYch/JwiIhpgH2v5WAJpCnX+m8tDNYSvUY3UL6m0/cuBJILBpgY5VHOf5Y/7QWIwiD7NztglI6zS/hQQeKcYtWDhEiBk8Ry2lji7Hwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rOdCc97m; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: song@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717987689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nanqSSINRZCJmsqQc5GyD3ZLoQDWHcilFSIm0GvyC7o=;
	b=rOdCc97mavJr31jPQ+wrxVTQygau0r58Qm4IWqlXhgz0xCpFI59c7kwWYS5rMTgevzn/Ia
	oa0n06Ui/Exmenwf1DmfZXEH5/igXD1xwZGJd0+6f+KumHltR+Vpl/CNs9USlnkaX85rpi
	2Fe3f0UhHpLBc1kbIqtT50Uc7csxDM8=
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: chenridong@huawei.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: haoluo@google.com
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sdf@google.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by cgroup_bpf_release
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20240607110313.2230669-1-chenridong@huawei.com>
Date: Sun, 9 Jun 2024 19:47:55 -0700
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
References: <20240607110313.2230669-1-chenridong@huawei.com>
To: Chen Ridong <chenridong@huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Chen!

Was this problem found in the real life? Do you have a LOCKDEP splash availa=
ble?

> On Jun 7, 2024, at 4:09=E2=80=AFAM, Chen Ridong <chenridong@huawei.com> wr=
ote:
>=20
> =EF=BB=BFWe found an AA deadlock problem as shown belowed:
>=20
> cgroup_destroy_wq        TaskB                WatchDog            system_w=
q
>=20
> ...
> css_killed_work_fn:
> P(cgroup_mutex)
> ...
>                                ...
>                                __lockup_detector_reconfigure:
>                                P(cpu_hotplug_lock.read)
>                                ...
>                ...
>                percpu_down_write:
>                P(cpu_hotplug_lock.write)
>                                                ...
>                                                cgroup_bpf_release:
>                                                P(cgroup_mutex)
>                                smp_call_on_cpu:
>                                Wait system_wq
>=20
> cpuset_css_offline:
> P(cpu_hotplug_lock.read)
>=20
> WatchDog is waiting for system_wq, who is waiting for cgroup_mutex, to
> finish the jobs, but the owner of the cgroup_mutex is waiting for
> cpu_hotplug_lock. This problem caused by commit 4bfc0bb2c60e ("bpf:
> decouple the lifetime of cgroup_bpf from cgroup itself")
> puts cgroup_bpf release work into system_wq. As cgroup_bpf is a member of
> cgroup, it is reasonable to put cgroup bpf release work into
> cgroup_destroy_wq, which is only used for cgroup's release work, and the
> preblem is solved.

I need to think more on this, but at first glance the fix looks a bit confus=
ing. cgroup_bpf_release() looks quite innocent, it only takes a cgroup_mutex=
. It=E2=80=99s not obvious why it=E2=80=99s not ok and requires a dedicated w=
ork queue. What exactly is achieved by placing it back on the dedicated cgro=
up destroy queue?

I=E2=80=99m not trying to say your fix won=E2=80=99t work, but it looks like=
 it might cover a more serious problem.=

