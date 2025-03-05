Return-Path: <bpf+bounces-53269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4675A4F396
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7503AB3B8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA99143736;
	Wed,  5 Mar 2025 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YclVKH64"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107711185;
	Wed,  5 Mar 2025 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137964; cv=none; b=nD/Z5ovw/QSEJWPmwFIUtanaKMIAhNskDsWNHTfcQ0ZPQHyaJ0af8ReBlG/m17GzWuNPhRy3E89kHEAons6NSa8wHytL2A9tYH3U98zKVrN7y6sj7rGD+BAA1Te4uOgZjiFSu+TqXvMRMgjMNl7HrvRzrZy45IN/iG/UUylM10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137964; c=relaxed/simple;
	bh=cyJfAdufLg+9eRiT4JlIUas7NAJvFa6ffHqtZWHg7YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MYECoyPB53apsWESHPHIxL7hC9gvIGBdpWktWBX1cV7ABOmzZoIQyDXb5c/7mmJ03pW6ZhmkWeZTGGSJ07aM/ryd5w721T5FopPHepXFoZiLttr65T7Q4p50tAalf+at/VykQDUTakoJzhemUgJ32pzly7Oo2xlXYO+ye2O2/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YclVKH64; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B7C2210EAF9;
	Tue,  4 Mar 2025 17:25:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B7C2210EAF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741137962;
	bh=0ktGKWEegiCPPqEj0r+J7PeMMxQp947aXt6g4Uv8qdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YclVKH64wUlKUqvg/dvVsp7eoUdk2XoxcQSAqiGFYiKKhCKSJspMclpOKHfi4yvDp
	 Gt32X2m0icsmL2gZ/WYmE3tauj5IuLUn1Hx2PjEEYR93VYDqX33QlXfXR6luf1d9Tb
	 8/5JFavccisPbFuyWc9w/4CDHOWAngzYfGMeEh+o=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter
 to LSM/bpf test programs
In-Reply-To: <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
 <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
Date: Tue, 04 Mar 2025 17:25:50 -0800
Message-ID: <877c54jmjl.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> The security_bpf LSM hook now contains a boolean parameter specifying
>> whether an invocation of the bpf syscall originated from within the
>> kernel. Here, we update the function signature of relevant test
>> programs to include that new parameter.
>>
>> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
>> ---
>>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>>  7 files changed, 11 insertions(+), 10 deletions(-)
>
> I see that Song requested that the changes in this patch be split out
> back in the v3 revision, will that cause git bisect issues if patch
> 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> ensures that the selftests will still run properly?
>

So there isn't any type checking in the bpf program's function
arguments against the LSM hook definitions, so it shouldn't cause any
build issues. To the best of my knowledge, the new is_kernel boolean
flag will end up living in r3. None of the current tests reference
that parameter, so if we bisected and ended up on the previous commit,
the bpf test programs would in a worst-case scenario simply clobber that
register, which shouldn't effect any test outcomes unless a test program
was somehow dependent on an uninitialized value in a scratch register.=20

-blaise

> --=20
> paul-moore.com

