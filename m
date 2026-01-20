Return-Path: <bpf+bounces-79525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7321DD3BCD9
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9DD302BBBE
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FA243964;
	Tue, 20 Jan 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1GjSEjq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F91B4224
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872607; cv=pass; b=liYTPALFkWIk6ZPGfSlHdeeAvL/iiqFScdNktNBFACBiVHvgMTO7qSTTmeQo0HNzjP5YygKnyFpmmBiaT6efGjIyJNtYsTYwEQaAl4TjXzT0CS/knxIT1E4YLvU66UhVI4QZ7q5a4SF0GuslbUzM5WDVK6zLhqXIQKpLa4pR+O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872607; c=relaxed/simple;
	bh=RBb3eJaWOJbgo8lJUPsMgQdoojz3hZcghHKEBBTfNcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q86QmYFLemrcj4VarOFL6Ts4DiT5+4D32ripBAq5Se72OQho0t5Cv4rmF9OTc9l+sMgzhCm3i1qSzbHQIq+TmQ+Sqr7jv4PS6G+EosFdlCpu29Kc4jrQ/m1fAtZwE6H112XAsbTk0DflUU6ACp80lRUjP3JklvKm+PuypMfJoDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1GjSEjq; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2732129f8f.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:30:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768872604; cv=none;
        d=google.com; s=arc-20240605;
        b=IL9LbNU8dEobAN5f2SP1fx/aKqe2V2PqF+HQ2OiSmRaMC7stgYyTcraAmfNvNvO5Fc
         A+dUw0XLYTEfcvsFMiYC8/qwqIob5VBPNNyYpu65wAfmiP5lpBCkAKvTNIRHixUV7TrP
         If02GdXcXwp/mLjyB2sMqznTYlD3zGz9cUMZNg/63YQamRnF7T4OvoKyJbuf3TH24Dnz
         U31bYlC41uWXEfNshj1EOSe3E0QP2O0Dt5WGz+3cSGgpnbKOL59iwWu6xeGFVAIeXQdF
         Fcbkhi11WKaf3oKNcBszL6t64RHjS1NaksZ+lwExXyoT+/Nu1IJwQAuDu0SkiuTRVBT5
         L/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5YBKnYw/r+7kPSNAmID1I9rPC/bX4Hd31dSG2lmZVFE=;
        fh=uhGNRE8PHT7JgT4x6JMSkuo5cQP04MEBxHF2rb4MD80=;
        b=Rk32x2i1JPluhaMPVjUT9tGYUd8NSEzlfCyOtelo+nGpHJo7BKIAW7jl3PPAk8E4sz
         P0jXJE7ocMHY3t00KJ8Yd28P3d/LxJ49PUz/c/7BHqSHKOwcK+VntmDnjyt9eVdyG3u6
         yeMtN0IT7xfPYrpQ802raPezqEcLk6+VhpAXeRKyzTl86ZDCRl7kkD13FoSKTVh4mQ+B
         /fx4UmlkAFPEzlbbKDOuXRhu6/30qVCZgbQsB82QwmWMh8wLecY5/yDsMobkmAVl+WV7
         2zebcmWi83/JyGfiK4TMWu4z2hsabKKk5G4eT6oEXVY5URzy7aHQKpS2SMQGaZLs1/N9
         JQOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768872604; x=1769477404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YBKnYw/r+7kPSNAmID1I9rPC/bX4Hd31dSG2lmZVFE=;
        b=S1GjSEjq2KZw2fSVH3IObSOibkPw579e2qfg+pHRfoWWO/Iqq1Q8UqDqyDZpEB/WNH
         +QawRtrEY9FZYCF3mnQKEMcbn5NAO3aONSI3brikVYvmV6bBnLWGg1+vUzCILIS5fYhJ
         l0pYFc+iKwJFzIS9LGT4Gh2NxaPlC8dqBll/CggkMkbTJugXMy6CdzDEsSW/I4MYR5OB
         UUA/LShoSss6CiTtCjEtb1wfKLiNhtCCCZM5qV1x4SfYdcdb8F2G+46gMaFVutRds6+B
         jzDZs4k/RcyfanMR9gr40mhkaiA6NerGrApoNCseugls79CzDqwIMChxNxBDGFMDERTZ
         CdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872604; x=1769477404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YBKnYw/r+7kPSNAmID1I9rPC/bX4Hd31dSG2lmZVFE=;
        b=hPa5f6Hto9tczTLHTqiWK0Gc+IzJ7iTorow1IwivoqFN7W5wuMmI3/pzM3Uhp/20NQ
         b0ZnAgNafCckojcwszF+sx9SBw5DRTqQZhtJTcjv66a6Tm4y9OtVlcDDx7+UNDeyJkX3
         7XUfRix2SQndQiRoJgPcx2o4yO1kvUHZEoXjbeG2lens7rcIVVRE6Rpd6wCkU7PXAguO
         OXlsKhG/Xmrh+189lx/YJ2r0M4Hy75Hsr1ILcD3oN2GN604TpUo31ZbeEnKXE12yG8tj
         1TPimzc99q+Pd2ACwvbgQ49HHV1iPXV2ngTJJ6c20lRGDgTX9MLXZiAr/K5X9WYwV54T
         Ht8g==
X-Forwarded-Encrypted: i=1; AJvYcCW3DYrptkQvr4CoKyoQq7Bfmv7Ji05yk8pL991zlKYBmPYF+E/jK0FqvqwfXIRURXfgJsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfO0b7UYto30jHwzgLuIO2aA28reJTgtqqO1eF83Uay77JbdB0
	uFt9/HlOiMfKC6XzGF8lWLcOSOgfz41snv6tSfpxvn0iebY0p2ZIYfJar+P8ZXpC28VJVmi5/5g
	LNkuAS+nIcjo3fNAzttGDL1nVRT/HSmw=
X-Gm-Gg: AZuq6aKL45pqu+RvAg3Akm9mB7sONIFvbxFcnwgla0fxifcS/TA4ytf2RXe4NWgzkmR
	+0FbDqrRZtvWvYu0aZQb+M0MlYrgK8i436vaAJkledEQ8KDMlOAKKh30QOevVTZffRgJm/+pXqX
	mJC3bYR9GLUYViE/7lqUf9y7ZqxtRp9LPRKFvetImAnlDAAdlkUbZRxZGxrGQZ7lO7tgQiScwZ5
	I15CeZxG0AfSIVAyJiE2pwljY3Ks1Ax/x9oeIVGzxCbYHn3KB5C0KSgNQisnKy5hTS1z7vOIaTd
	gSoduWiruq+KQE3+sFv0Y07FIXuE1WS36rDRbkXO7E2t4uOh+7Ik/CpyI4j5yxtZ9J4Bo/5eNnO
	92JuQGbNKLCB5nA==
X-Received: by 2002:a05:6000:2505:b0:432:5b81:49c with SMTP id
 ffacd0b85a97d-43569bd463bmr14236710f8f.55.1768872603908; Mon, 19 Jan 2026
 17:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com> <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
 <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com> <878qdx6yut.fsf@linux.dev>
In-Reply-To: <878qdx6yut.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 17:29:52 -0800
X-Gm-Features: AZwV_QhUdWW44NHALBAw1DQFb2yF_0TM6u4BX-TjaqZPhm_LxDfPI5ujOVMjJso
Message-ID: <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
>
> E.g. in my bpfoom case:
>
> SEC("struct_ops.s/handle_out_of_memory")
> int BPF_PROG(test_out_of_memory, struct oom_control *oc, struct bpf_struc=
t_ops_link *link)
> {
>         struct task_struct *task;
>         struct mem_cgroup *root_memcg =3D oc->memcg;

And you'll annotate oom_control->memcg with BTF_TYPE_SAFE_TRUSTED_OR_NULL ?

>         struct mem_cgroup *memcg, *victim =3D NULL;
>         struct cgroup_subsys_state *css_pos, *css;
>         unsigned long usage, max_usage =3D 0;
>         unsigned long pagecache =3D 0;
>         int ret =3D 0;
>
>         if (root_memcg)
>                 root_memcg =3D bpf_get_mem_cgroup(&root_memcg->css);

similar for mem_cgroup and css types ?
or as BTF_TYPE_SAFE_RCU_OR_NULL ?

>         else
>                 root_memcg =3D bpf_get_root_mem_cgroup();
>
>         if (!root_memcg)
>                 return 0;
>
>         css =3D &root_memcg->css;
>         if (css && css->cgroup =3D=3D link->cgroup)
>                 goto exit;
>
>         bpf_rcu_read_lock();

then this is a bug ? and rcu_read_lock needs to move up?

>         bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESC=
ENDANTS_POST) {
>                 if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr=
_dying_descendants)
>                         continue;
>
>                 memcg =3D bpf_get_mem_cgroup(css_pos);
>                 if (!memcg)
>                         continue;
>
>                 < ... >
>
>                 bpf_put_mem_cgroup(memcg);
>         }
>         bpf_rcu_read_unlock();
>
>         < ... >
>
>         bpf_put_mem_cgroup(victim);
> exit:
>         bpf_put_mem_cgroup(root_memcg);

Fair enough.
Looks like quite a few pieces are still missing for this to work end-to-end=
,
but, sure, let's revert back to acquire semantics.

Matt,
please come with a way to fix a selftest. Introduce test kfunc or something=
.

