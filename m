Return-Path: <bpf+bounces-45493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1219D6765
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 04:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB21B21782
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 03:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD3770ED;
	Sat, 23 Nov 2024 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY0y3Mmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D49F7E0E8
	for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732332605; cv=none; b=hkrlKPYK0iBtb4GtDMpKJuomCjrX3ftasfs+7+T/mwwLn5rpKzUJ2KR7sKeqTMW6G3Nst6cBE+AA/cr/4wxx1ZMo14QWt/id5xRmqRq0iDyYjcUwjtrdqNdTuspCxYNbAAIAeyHUjTlzRHZItr735kCbUHqV/ljZOgI9WCKP5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732332605; c=relaxed/simple;
	bh=gLCySCqmitIZOkgYvthNxXzgPnx6jw9DNtPHQ0ejU00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6iglsWgvhspmDCXJ8WI6Os/DZUqyE1JjxT9AF1zwofQ/0ZKZgpu+tu3Jl0nbv2RC9SpaLNmmCj3U10aVfbT2KRNcile/nqNAMXckyxbaQRO4FB+c0RhXUFDY2/mbz06Bwv2tCrDV6U2W/1ahIvQCbkioUUYXcGxuck6IHuLv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY0y3Mmk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d86a3085so24807455e9.2
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 19:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732332602; x=1732937402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI4J0t3RribSXpGRviLIwfUdVhZrWbx0PD/wh2BE1AA=;
        b=mY0y3Mmk8SNMBaPg48iApfgdDGEmRtX50oR/+a6TX6sfGGvoo3H1dxGiJ6GGUqH+SV
         5w5J0XJxX4CL/vHLvuvTKvWEksZrQvM/GZuCWcydDXqjupskN1DVd4ZSVxnyFfk7gM8N
         RyrjnzOV+/fJX++cKItXuChAfhfHVIfq4R5o1iaDkbY6hGx7d3gXGEZ698SFPcaN4QWQ
         bBbApp2P7k2rZxUK4UHS4AUlwdw4dV0ZFWoYEqN5IEow2w0lefv8mD7sGTQlUwRqQcW+
         9Ed9EUY6uUpSUDWV18ZZj+LNUKuQINMyf0pSsAvrCfUlp+S6lhSdpHZy2u10uSPA2Pep
         KXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732332602; x=1732937402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI4J0t3RribSXpGRviLIwfUdVhZrWbx0PD/wh2BE1AA=;
        b=jdUKyZjo+vpp6/Pf9BLBDC8jz43trzHQxGeHww5TuJZsh+et7C2ZzXSIwMZLGLy3Zv
         0AvwbjakPHpFhNHCIgcmuYq9NMvNRFiWPzFZO9kISsZcjqilxuO9i6dE5R0ROzLrnB/c
         AxwSo4c1MXnt8KojSvVp6jxdFq601HohP3EayqhTqDQew4s7tfjLARgf0rEobqP0aHy8
         buVaew4DBZMDf8K6wrLA9ka4SwtpoF7VeFOmp21DagSNz+gUOkUIOkm2FGyx9onyXA4K
         Ug/lo1smwPFmuSDjJbrXcrtrqEqkcGo8WBu+/23UhKhgsmzG3Tdfuu8z7Ef3pmMh1llN
         el+Q==
X-Gm-Message-State: AOJu0Ywk0xpTlbd+OcCiytSOxG+7n8LFxRW4KVSM1yRn49rwRXVI+/Jm
	X3Fu2G6eqjiDHA9yedNSXhe6D3mpTYqc+rIH5tVjTZY/lZdnl53PZHZY46C476bC4mSO7kYtyt/
	PxI4E5DVrOWDYLmO2a+Qb8JJm5kg=
X-Gm-Gg: ASbGncvpJnHtFn3NfcUJBlpuSnWy660oLwYC2FhmNa4oFD6ERjN2lYGXUexm2kHzBv8
	i+cQgdzohrE1C8Jks5TJK6ZP+RpWYOw==
X-Google-Smtp-Source: AGHT+IEzFiaQEFo8nrMqSRTeUrwCBVmHtmnSmp1vz7oFbny7L6uq1EAg4YZu08swTI/CBgfbgzhhe0wMaNHqk0i48I4=
X-Received: by 2002:a05:6000:186b:b0:382:49bb:a5c8 with SMTP id
 ffacd0b85a97d-38260b864b9mr3627751f8f.32.1732332602176; Fri, 22 Nov 2024
 19:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com> <CAADnVQJPhkNbq0nHANJ5W03-dQ3t7ZPeh3gk+WJbtXFOL=GwUA@mail.gmail.com>
 <31bf6193-2154-443e-4811-9f71a4fab7cf@huaweicloud.com>
In-Reply-To: <31bf6193-2154-443e-4811-9f71a4fab7cf@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Nov 2024 19:29:50 -0800
Message-ID: <CAADnVQK2pxtLHWs_1tL9CzXN3FimmOvB=nEagj-YaWDyu2R6jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 5:20=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Alexei,
>
> On 11/20/2024 9:16 AM, Alexei Starovoitov wrote:
> > On Sun, Nov 17, 2024 at 4:56=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >>
> >> +enum {
> >> +       LPM_TRIE_MA_IM =3D 0,
> >> +       LPM_TRIE_MA_LEAF,
> >> +       LPM_TRIE_MA_CNT,
> >> +};
> >> +
> >>  struct lpm_trie {
> >>         struct bpf_map                  map;
> >>         struct lpm_trie_node __rcu      *root;
> >> +       struct bpf_mem_alloc            ma[LPM_TRIE_MA_CNT];
> >> +       struct bpf_mem_alloc            *im_ma;
> >> +       struct bpf_mem_alloc            *leaf_ma;
> > We cannot use bpf_ma-s liberally like that.
> > Freelists are not huge, but we shouldn't be adding new bpf_ma
> > in every map and every use case.
> >
> > bpf_mem_cache_is_mergeable() in the previous patch also
> > leaks implementation details.
> >
> > Can you use bpf_global_ma for all nodes?
>
> Will try. However, there are mainly two differences between
> bpf_global_ma and map specific bpf_mem_alloc. The first one is the
> memory accounting problem. All memories allocated from bpf_global_ma
> will be accounted to the root memory cgroup instead of the current
> memory cgroup (due to the return value of get_memcg()). I think we could
> fix this partially by returning NULL instead of root_mem_cgroup when
> c->objcg is NULL. However, even with the fix, the memory account is
> still inaccurate, because these pre-allocated objects may be used by
> other maps instead of the map which triggers the pre-allocation.

That's a valid point.
Though we ignore this issue in bpf_obj_new and other places
if we can account into memgcg correctly we should do it.

> The
> second one is the freeing of freed objects  when destroying the map. For
> a map specific bpf_mem_alloc, most of these freed objects could be freed
> immediately back to slub, However, it is not true for the bpf_global_ma,
> because we could not tell whether the object belongs to a to-be-freed
> map or not. And also we can not drain the bpf_global_ma just like we do
> for bpf_mem_alloc.

I don't think it's a big issue here. Optimizing delays in the free path
is imo too soon. The extra complexity is not worth it.

Let's do one bpf_ma for lpm of size LPM_TRIE_MA_LEAF.
Inner nodes may be wasting memory and it's ok.
The whole LPM trie is not efficient anyway.
Micro-optiming at bpf_ma level is a small improvement compared
to rewriting the whole LPM map as a more performance and memory
efficient algorithm.

