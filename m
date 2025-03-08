Return-Path: <bpf+bounces-53653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22883A57E27
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857B71891436
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19E1EFF90;
	Sat,  8 Mar 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iT0YstV2"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F8113B2BB
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465879; cv=none; b=ZM1nq5v6IRZhR5DRIAftYWyyRLMp6AUnRLdpJ8uLxw3TiHXIlHX+ByHGdws1C3ujROZqY5kMzPhHdAv1huL+uEDEUX4QIdyTyFg7hmHDOUZxswg8hfxn/jIpharZMTyevWvMSOWMlKXQFWMA7FHG95tdIjhoCMEAWHCQn+mZZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465879; c=relaxed/simple;
	bh=CYjdoL9LawWV1i0KpkHJXbLMik6uaBCwZLXZbV6XHQY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=G2oipoggerv6AH692EnXUbapd0RcCrh4xSrVHO2UYQZj5bTSzjK3QEKpT9CbWwvEv7oZqrf5fJZF9sLxERORtoYO/OAE+ycPL5eDA1q9QpV0cVUnrzft8qtJop9jZoaachYfm74i3wmNXbBquwt0ggzvZk3zc+0NTDTE2oYL10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iT0YstV2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741465870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MU9LDS1jMJITDXd/kcvT+fO9k3Lol54aQBrAyqHWhw8=;
	b=iT0YstV2XCjs5VKyHgo4s2K0PUIBdm6UEKAsYRZkQEZYU5Dfe7JVJ4nURzgYFmJnd8aI6r
	ogGjGpBSgZHP8FWfeZwTQVNfIgL52IUF1DEUs0L0gSesnTVrR3t7kay5yis8RivZ/ih+lT
	/4pIJjGvbNfg4A3kM88Ts+mrcpA8zJs=
Date: Sat, 08 Mar 2025 20:31:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <3d9e83827f5aa0db2b29e0fd868eadb5f94629f0@linux.dev>
TLS-Required: No
Subject: Re: [CentOS-devel] make dist-all-rpms fails with
 test_progs-no_alu32-extras Error
To: "Costa Shulyupin" <costa.shul@redhat.com>, devel@lists.centos.org,
 "Jerome Marchand" <jmarchan@redhat.com>
Cc: "Donald Zickus" <dzickus@redhat.com>, "kernel-info"
 <kernel-info@redhat.com>, bpf@vger.kernel.org, shetze@redhat.com,
 ngompa13@gmail.com
In-Reply-To: <CADDUTFzAse2p5M4iEGbVK6YVGQzfUcVYQ8qBfR-d=drQZae7-g@mail.gmail.com>
References: <CAC_sYhPsnjXiUjw+8dXJLdQaZ8tHWVogf0SV+YusiUooazzQDQ@mail.gmail.com>
 <CAK18DXa6oPYfd9oZxRsE+3wM0yGWkmdRraLNMvZM22A4bDge8A@mail.gmail.com>
 <CADDUTFzAse2p5M4iEGbVK6YVGQzfUcVYQ8qBfR-d=drQZae7-g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 3/8/25 6:34 AM, Costa Shulyupin wrote:
> On Wed, 5 Mar 2025 at 00:11, Donald Zickus <dzickus@redhat.com> wrote:
>>
>> Hi,
>>
>> If anyone wants to chew on a kernel build problem on the centos mailin=
g list.  There are multiple replies to the thread with no success.
>>
>> Cheers,
>> Don
>>
>> ---------- Forwarded message ---------
>> From: Sebastian Hetze <shetze@redhat.com>
>> Date: Sat, Mar 1, 2025 at 6:50=E2=80=AFAM
>> Subject: [CentOS-devel] make dist-all-rpms fails with test_progs-no_al=
u32-extras Error
>> To: <devel@lists.centos.org>
>>
>>
>> Hi *
>>
>> I recently tried to compile a custom centos-stream-9 automotive SIG ke=
rnel and failed.
>>
>> Now I see the very same problem is present in the mainline centos-stre=
am-9 kernel.
>>
>> When I clone the sources from https://gitlab.com/redhat/centos-stream/=
src/kernel/centos-stream-9 on a freshly installed centos-stream-9 host, t=
he make dist-all-rpms target fails with
>>
>> make[3]: rsync: Argument list too long
>> make[3]: *** [Makefile:768: test_progs-no_alu32-extras] Error 127
>>
>>
>> This is certainly not a problem with rsync and the ulimits are definit=
ely sufficient to deal with this ~2000 char argument list.
>>
>> So what is going on here?
>> This rsync call appears to come from the tools/testing/selftests/bpf/M=
akefile.
>> The problem persists if I BUILDOPTS=3D"-selftests" and I understand bp=
f to be a SKIP_TARGET by default, anyway.
>>
>>
>> Does anyone have a hint? What is missing or what am I missing?
>
> I=E2=80=99ve bisected the issue and identified that it was introduced b=
y commit
> selftests/bpf: Use auto-dependencies for test objects
>
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/co=
mmit/a7ff7bd4cdad76f4f1c37ee7c918e201dbb7ce6e
>

Hi everyone.

I tried to reproduce the error using a centos9-stream docker image [1]
(I know it might be not exactly right), following steps from the
original thread [2].

This command:

    make -j$(nproc) DISTLOCALVERSION=3D_at BUILDOPTS=3D"-selftests" dist-=
all-rpms

completed successfully on tag kernel-5.14.0-571.el9 [3].

Shortly after auto-dependencies change was merged, a few problems with
out-of-tree builds were discovered and fixed. The symptom was also an
rsync command failure. See relevant thread on bpf mailing list [4].

I noticed that the fixes are not merged into centos9-stream tree. I
think it's worth trying to test the build with the fixes applied [5].

It's just a guess though, as I wasn't able to reproduce the failure.

[1] https://hub.docker.com/r/dokken/centos-stream-9
[2] https://lists.centos.org/hyperkitty/list/devel@lists.centos.org/threa=
d/N4JBZWVP2OTQXWQ52E73SBRHE6GA6XPB/
[3] https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/=
commit/15b5887ebd883f74aaa63ab124bc0f75770eb6b1
[4] https://lore.kernel.org/bpf/877cbfwqre.fsf@all.your.base.are.belong.t=
o.us
[5] https://lore.kernel.org/bpf/20240916195919.1872371-1-ihor.solodrai@pm=
.me/

