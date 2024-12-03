Return-Path: <bpf+bounces-45983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB88B9E10DE
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A8BB22AF7
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB052F9E;
	Tue,  3 Dec 2024 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNL+H6ry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685D2A8D0
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190179; cv=none; b=QlVh/T8XG6LKppPNrZbv+vJ8DB+gJtAWuFtXkwYiS8z3EubqVBVB2tSGpu5HFnvDxJbGvYBFbRcAxd/V9mBIMhEKJPDNdpFWnKKffFDoD3cdh3lRVmb4LJuTYn1m0wYSAW0fZkrcXZ/pdHq5XTH96G77q/SCoMFV1BaOP6ENHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190179; c=relaxed/simple;
	bh=DopL8/kj7EhScsxDoIypoMZHiT/AHqWAuShNP1nhNHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZxQkADVnwNJz78ensxjbdclsw0rjHlnXuK/xrj4MOhOD3HREsUEqfsj4aIbMhbEIe5Og+5sgie7XshhIEjgRcSzR5jdXwLn02kuksGTUOyH7+V4B76i+FS2HP7kVaLlcE9HReQ8ZjuA69WHcgbdElTr9rL6aBl9nFQ5VG7glcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNL+H6ry; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a736518eso61744315e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 17:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733190176; x=1733794976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DopL8/kj7EhScsxDoIypoMZHiT/AHqWAuShNP1nhNHI=;
        b=lNL+H6ryXwf/9KtUG1RKAntGHfMmilOr/PIPrpuy2/OFjgUfnQx1UgWtIMXKB/Rip2
         PLCd8Lu5yL5oZrZ5ymA5oztKYlm6Yb5u2BC4iJyX+Mosa/jmjN57VpXDGAmF4Qzf5iSD
         4iBIkGg435uEVxu+5Qj32AB9Y1irQgzFa4E09Z8bHyDZmLc5HitO9ZriAP4LOwFuSNAW
         rrrks3Tbu0fJqcuJ0cmEGfNWtIG3b1t2CrXbjuNsloK9bAjVuMkiU+N9T+fKwoIhqnpi
         TnvEXfVZH8yBuvwv+cf4Fw8v8ZuAiWEqtCdYHHbIKAkCiwSMtduRAYUA2qhEZsoctqPM
         y03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733190176; x=1733794976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DopL8/kj7EhScsxDoIypoMZHiT/AHqWAuShNP1nhNHI=;
        b=lRkylGBtowh6kY+SBiQeqzTJaQj3KT97pHQAPBRT3iNvSKfPeumts0cpG2sfTDO7eJ
         nUMopIuFyJbswwlv4wi2VPSmNvDLTwJCsPtABsqQ5b/Ss0QcaKx/ifF/HX/8OFM6fJ5N
         pk9jZPIs7qpWValI3ggpbhdQ1zZ0gK0ZGUW0f81BZR91f7fQFmBVQRg/yqoBixc6JUn4
         +57HAV38QZvDYwWUtyVSVNnrxMkWx6cWr2W+UyJnN+tZhhQrEBAxdLf+KCLw96bmx40B
         WjmKY1CIaOi3gS5VmJKa4YZBeIwy6N6uSJ0MctXN6c0u1VX7GMdY3fQdgDBydKc1XqX5
         bBkA==
X-Forwarded-Encrypted: i=1; AJvYcCVKxrmsunbPOFq/468Bd8yOmL3g3U1QkvOxJbZ9KstcDS8MPiMAS8k6JOUMCePsuVTC2zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDdW6qlK/6B10cD/YKULPidGj6D+OY/pnQ+esAX1F9mej1dA8
	EZ1U+911ulgFfCyRXQFb9UwvGXG27DM/oeegeqqAGLUBqOtCuu+95Q044DVOSj/RRh9G5SCe3+a
	9+F5rHDBNWYDQFVcSwReXwOdGF7s=
X-Gm-Gg: ASbGncsUEJVHZUOK3eFRRNlltyQMbYBKxYPTHyUIQmZ+QmUVhwpVGNSZ3lpEqkv3fDW
	NwKBTjyRUri9Jh7nwFY0Fw0xLkwtPcQTXHMeoq8NbUpHoT9I=
X-Google-Smtp-Source: AGHT+IFP+XAtN9OmV1H/EuoM+0KC050p4D89Y1q/qLh4YPAEnUOzw7WavM8+W4TkLFH91xbmU6vDDiwyftw+HQ28Cwk=
X-Received: by 2002:a05:600c:1c93:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-434d09d092fmr5744555e9.16.1733190176059; Mon, 02 Dec 2024
 17:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
In-Reply-To: <87frnai67q.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 17:42:45 -0800
Message-ID: <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 4:18=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Hou Tao <houtao@huaweicloud.com> writes:
>
> > From: Hou Tao <houtao1@huawei.com>
> >
> > After switching from kmalloc() to the bpf memory allocator, there will =
be
> > no blocking operation during the update of LPM trie. Therefore, change
> > trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
> > atomic context, even on RT kernels.
> >
> > The max value of prefixlen is 2048. Therefore, update or deletion
> > operations will find the target after at most 2048 comparisons.
> > Constructing a test case which updates an element after 2048 comparison=
s
> > under a 8 CPU VM, and the average time and the maximal time for such
> > update operation is about 210us and 900us.
>
> That is... quite a long time? I'm not sure we have any guidance on what
> the maximum acceptable time is (perhaps the RT folks can weigh in
> here?), but stalling for almost a millisecond seems long.
>
> Especially doing this unconditionally seems a bit risky; this means that
> even a networking program using the lpm map in the data path can stall
> the system for that long, even if it would have been perfectly happy to
> be preempted.

I don't share this concern.
2048 comparisons is an extreme case.
I'm sure there are a million other ways to stall bpf prog for that long.

> So one option here could be to make it conditional? As in, have a map
> flag (on creation) that switches to raw_spinlock usage, and reject using
> the map from atomic context if that flag is not set?

No. Let's not complicate the LPM map unnecessarily.
I'd rather see it's being rewritten into faster and more efficient
algorithm.

