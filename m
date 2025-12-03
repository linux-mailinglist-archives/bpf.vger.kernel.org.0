Return-Path: <bpf+bounces-75967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A8C9EFEC
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81937348F53
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A9139579;
	Wed,  3 Dec 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8lREmwu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A7163;
	Wed,  3 Dec 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765093; cv=none; b=WFWy2AXrf0Wz/t4YqvprrHKv9fOxGLScYClHEi84/4bz5di+0hHmq/P3D3Cn+C23aBBiuFw0vHf0jpAhg1gbe+Bqcs2XUIZZNQCUG3FBVPp+xkfWLIowy70+7/CFO9N/VomGn2PfgE5e8KjgedrJ/R/02hINST2IgwDaxHciO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765093; c=relaxed/simple;
	bh=ov2tyNTIvijPsGgQW9o0usNlWj/FRBb3dJlRN9sL45s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZajjCXjBiuy+XJvdfHr8p5JX7JURCWy2Ll808RCSBEH5P0w1sAlJPkhJqGDbwsBgkFHQymq8xp7PaZYzlmqWv+YYAV9EXduRWcE/7IE8NLlGnXg91tEf7litYRJQ+eLrAhHGAeYw+ZqtKXHTrbhR2xXCA7VPU5wV1KHw6T+j+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8lREmwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E51EC4CEFB;
	Wed,  3 Dec 2025 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764765092;
	bh=ov2tyNTIvijPsGgQW9o0usNlWj/FRBb3dJlRN9sL45s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H8lREmwuHNo8o6lNjloLQ6k80pBMdG0UFUey9SH3lRfGT8tjGQqBWQb+/U3E5miCq
	 DZBsSf1pT8wQUhMB3nNhBxbgSNUTC5l4b3qZy48UTAAGN9i6VsST2GhRTT66E1Gqei
	 fEcocMc2lSIfG1dSx9uxHsGfH/Bn6fSwzC/prFa6C8n+jFuidVGIPW5bxqVCQXWG6M
	 KuiGTs9qSQFndTS9oY9mFkxvovJ1Yk9r+B1MANUUCr25jGUhQpQwqSKc1D1xw5fbcJ
	 zMu8r7mPew3K1xKO9XS2mnyzpA1G/jRkJMUVNClKSGBWJMdT86PAI+w1eoofMONhi7
	 mkopBdXFYD7qQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5FB703B1A1B; Wed, 03 Dec 2025 13:31:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Kohei Enju <enjuk@amazon.com>,
 alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kohei.enju@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, shuah@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in
 cpu_map_update_elem()
In-Reply-To: <7b6b9d1a-c160-4198-8a58-0586424b56e5@kernel.org>
References: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
 <20251203104037.40660-1-enjuk@amazon.com>
 <7b6b9d1a-c160-4198-8a58-0586424b56e5@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 03 Dec 2025 13:31:29 +0100
Message-ID: <87jyz39272.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 03/12/2025 11.40, Kohei Enju wrote:
>> On Tue, 2 Dec 2025 17:08:32 -0800, Alexei Starovoitov wrote:
>>=20
>>> On Fri, Nov 28, 2025 at 8:05=E2=80=AFAM Kohei Enju <enjuk@amazon.com> w=
rote:
>>>>
>>>> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
>>>> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
>>>> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>>>>
>>>> However, __cpu_map_entry_alloc() returns NULL on all failures, and
>>>> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
>>>> As a result, user space always receives -ENOMEM regardless of the actu=
al
>>>> underlying error.
>>>>
>>>> Examples of unexpected behavior:
>>>>    - Nonexistent fd  : -ENOMEM (should be -EBADF)
>>>>    - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>>>>    - Bad attach type : -ENOMEM (should be -EINVAL)
>>>>
>>>> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
>>>> and have cpu_map_update_elem() propagate this error.
>>>>
>>>> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eB=
PF program to cpumap")
>>>
>>> The current behavior is what it is. It's not a bug and
>>> this patch is not a fix. It's probably an ok improvement,
>>> but since it changes user visible behavior we have to be careful.
>>=20
>> Oops, got it.
>> When I resend, I'll remove the tag and send to bpf-next, not to bpf.
>>=20
>> Thank you for taking a look.
>>=20
>>>
>>> I'd like Jesper and/or other cpumap experts to confirm that it's ok.
>>>
>>=20
>> Sure, I'd like to wait for reactions from cpumap experts.
>
> Skimmed the code changes[1] and they look good to me :-)

We have one example of a use of the cpumap programs in xdp-tools, and
there we just report the error message to the user. I would guess other
apps would follow the same pattern rather than react to a specific error
code; especially since there's only one error code being used here.

So I agree, this should be OK to change.

-Toke

