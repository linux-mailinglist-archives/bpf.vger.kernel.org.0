Return-Path: <bpf+bounces-50741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6CA2BA0F
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 05:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25FE7A2B5D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74648231CB0;
	Fri,  7 Feb 2025 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WWadQTTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A20231C9F
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901560; cv=none; b=KV/SHz66dyhMfSyHgpyjMJhb6bAkN6N2tDxmCU+v9cQR/19UcfhkQbARSyEom2jUeEBsAZUhMNn17Re+Gn3owYVrzzqFdKIUB1VyC5Et3VssZzKocHF02glFxAg7KFfyPhfrcXZ4ObjI46PizwUlm78c2DPnbfBdof2ZHvcSi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901560; c=relaxed/simple;
	bh=ljH7Na1CjKFmZ9WKQeQ3cW1kEi3W80vBZcOQYMb3Cug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gghoKRqoGB6SQxkzT6mP/54oVVMWO3D1pPJ5piRLsQeH+v0HNWUJHX2d63xvvixaNfI03856zDCbDk1L0b1sM5sQ+jTgodgZPwTv5SJVDjshm9fkvIPDKbtA6OFQrRGaKL6PzXeOCu4yOeT6wsk4KX2PZKBjOJ3sk6YIFJV5iJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WWadQTTu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab78e6edb48so14214566b.2
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738901556; x=1739506356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfKeNd5YsT4IdLY3wC4IJkumtp1al9zTd0Fhjp7u0qk=;
        b=WWadQTTuWKonMg+YWigynolMhGVCClf0b8wXsAavP85s6hzYphW+UPRcyhU1QFLUgq
         2StENoPcal6yBlLhv8brdcj2ek2esQM68qizNaRQYoh4eeGgF4MULInBx4mTbLJgy4lG
         R9pVQkIqSzvvvHjocTH2fhsyNKyldq1FwI9vwIZHqZPnPpaHDDMATfPa6lgMr+jkqC8r
         OkYpr7ia0zXExGujWOV9J+OwE32TF+Op8hLZfxV8fV+sqAzoOqdOkGuN0JWrQN2/1oVD
         Luj4HP2PxwcUDoEUDeqUBihNUjtAa3k5uamvuNSwv59UW29nE/jWgU7qPbR8JvTXQvIJ
         3FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738901556; x=1739506356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfKeNd5YsT4IdLY3wC4IJkumtp1al9zTd0Fhjp7u0qk=;
        b=T5KS4yrl0xf7FRfiaY6LVoymY71xyj/D4borvIAZtRlj9qkKBc2JPePQAa965sbf7O
         DvmaKwmT/rE0dh6GraNDvMqWmg8l6vjwU2NG3ISVv+F7fl9BjvoGZSRpaTGqPD5ft+B2
         xIMQt0eT8vH8vn9hJCmQj2gJccWN+G5bSsFV2OI5DEW7VrI09nbQegHHhoEcPkFlqwjE
         8/PKd8l+Vq1+dCMle33u7uhouzuCJfKBuUXJBtTWJVvCw9Z59Hnt7F4vllscIuWsy9jn
         wAqjhlR+wG+swLP7PAJMmh4mK3f25W5TJKoMj85xtVmNgVkdcjrYz9UYRFX8jdFZ8zHK
         30YA==
X-Gm-Message-State: AOJu0Yy7/Kxpxo3bvbwLwvBddTk5JQ3ZGwPrRN4IU2H9qEOfWgU8IpWN
	yBQQ5NY5DB9ew0QYCPlDzZk5kNOjY1N/iAZBCczIJiGhWOWiGashYF5H3okLcqH61cj9wFuue8e
	SamL7q8zpPUwjNPuQVEdkWFUuF0+p+BVTx22U8w==
X-Gm-Gg: ASbGncsnx6MWY20SVMf2b+XDhhw6Lne7WaeqpTmpD3o4cALZz4U4TKG5yZEB9SPl9dS
	BY6ndzqaH2zhPyCHceal4Hf3Fzz1e5lp4gBM6q7H48yG0B/zGb+TYl8Ra6XVs9MDZMpBVBvD3Gd
	qiXJQoGtQMZ+hRiuo=
X-Google-Smtp-Source: AGHT+IF+Dr5Nq2mH34Odbm2J6M0KJZHkh2UhWnVHf00IT85KBVmDwpzVa2YALsjOafjhhAQObIf2PDcukGPveI5Ezxg=
X-Received: by 2002:a05:6402:208a:b0:5dc:5a51:cbfa with SMTP id
 4fb4d7f45d1cf-5de44fe949emr4939486a12.6.1738901556568; Thu, 06 Feb 2025
 20:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6OYbS4WqQnmzi2z@debian.debian> <5f6610a1-3cd0-764e-0f49-91af1004ea50@huaweicloud.com>
 <CAO3-PbrGR-U0+TxgeUUZHSwvNw2Dx=o6_EYf60ND7BLiLA-xWQ@mail.gmail.com>
In-Reply-To: <CAO3-PbrGR-U0+TxgeUUZHSwvNw2Dx=o6_EYf60ND7BLiLA-xWQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 6 Feb 2025 22:12:25 -0600
X-Gm-Features: AWEUYZkk5n3m-qzxQp53kd6ix3x2ANE2POQRC5vHVyak4SJ0fxlTXB7Q5H7kjkk
Message-ID: <CAO3-PbqOFMMzcy9VBLaTtvihnuCJ2u38RMPnYNPckjF8BzdDkQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: skip non existing key in generic_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Brian Vazquez <brianvv@google.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:20=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote:
>
> On Thu, Feb 6, 2025 at 12:40=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > Yes, the retry logic doesn't change the previous key. Thanks for the
> > clarifying.
> > > And by "skipping to the next key", it's simply
> > >
> > >   if (err =3D=3D -ENOENT)
> > >        goto next_key;
> > >
> > > Note the "next_key" label was not in the current codebase. It is only
> > > in my posted patch. I don't think this would break lpm_trie unless I
> > > missed something.
> >
> > I was trying to say that the proposed patch may break the lookup_batch
> > operation for lpm_trie, and let me explain step by step:
> >
> > For LPM trie map:
> > (1) ->map_get_next_key(map, prev_key, key) returns a valid key
> >
> > (2) bpf_map_copy_value() return -ENOMENT
> > It means the key must be deleted concurrently.
> >
>
> I see what you mean now, thanks for the detailed explanation!
>
> So for lpm_trie, if an element is deleted between get_next_key and
> copy_value, then retry would still proceed to its next tree node. But
> with or without retry, I think we cannot prevent the key from cycling
> back to the beginning: an element can be deleted after copy_value, so
> the key becomes invalid. After swap with prev_key and call
> bpf_get_next_key, it cycles back to the leftmost. Similar can happen
> if during retry the prev_key also gets invalidated. IIUC the rcu
> locking in lookup really cannot prevent the tree structure from
> changes.
>
> On the other hand, bpf_map_get_next_key manual already specifies "If a
> key is not found, the operation returns zero and sets the next_key
> pointer to the key of the first element.". IMHO it probably makes more
> sense that, regardless of normal or batch lookup, it is ultimately the
> user's responsibility to properly synchronize, or deduplicate what is
> returned from the kernel. I intend to keep the "skip to next" to save
> the unnecessary complexity here, unless there are strong objections
> that I should not.

Thought about this again. It is interesting that hashmap batch lookup
actually guarantees no duplicate in output today. If we want to
achieve the same for lpm_trie, it should have its own batch lookup
routine, which could properly lock the trie against mutation. For the
generic batch, it is still better to be simple. Let me put this in the
V2 patchset for discussion.

best
Yan

>
> > (3) goto next_key
> > It swaps the prev_key and key
> >
> > (4) ->map_get_next_key(map, prev_key, key) again
> > prev_key points to a non-existing key, for LPM trie it will treat just
> > like prev_key=3DNULL case, the returned key will be duplicated.
> >

