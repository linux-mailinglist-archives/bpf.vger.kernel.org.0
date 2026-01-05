Return-Path: <bpf+bounces-77849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF3CF4BCB
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575EE3066D45
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475B347BA9;
	Mon,  5 Jan 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayzv1Gkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD5346FBC
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629780; cv=none; b=PpbrD26Od6kYc/iZRH+I5U+A3d0W+Qq+R5RYyR3s4JdmWBRUv41O+mU+Ldz9kKCFSeeFQc+yfN5AyWBrBYGmfIZDEdSKjf1pud7yCAh6VR7sBONBxkwKEreNDZoQ3YXxNApVtgZ+gVR+LZngVUfT7N12YZVS1aijFahUXREvPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629780; c=relaxed/simple;
	bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDstM7x12MPVyPfHgPwJ54J+7cO6Z/sW2ltCyvW5x86w8hKnFNytRvQ2LI24tDbWFQcgYCX2RAFXEv9qu+WlVvt8nG7ucwjCbTTiUr8qsG2eqGPa3yNqAVeArrxbQnhZeV+zi3uetQlCI/TsNJ0HrjDy2mZYE97JANfvnSpJl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayzv1Gkz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so22751f8f.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629777; x=1768234577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
        b=Ayzv1Gkzgv8qiuwgV4detegm0uhyRyOQQG3S1ylZuywG5CHrNIocYC18Sjl9YrsYnB
         0/zplZpddcHF18xU5TfwWX76rrOetP5V/9zcJloerjYutjLiv354+GXu1qW+0A9mYS4S
         jLKa/b+g4C//SI8va05PnhWUQupsqxZBjaRzYpsvo1X4RBsKKP9rOb8Q3IuBu/Hf9ZSd
         Y/IW2yS6EJorer+HS2CtpZhfQtdkpRCgx2hbapqNvAZDOanyzoL6gqIaoXqRIOkFneLg
         3WfrJGgZTUTEqBnuDAUscMpghu9ZvQ9zILsnwIfOSM0un9GeUfIodtUHIeHM4Tk1IEEe
         pGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629777; x=1768234577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
        b=OPYlsXTYoMH8lEAN69N74CzYHhg8bs1UlXQnsz2YK56jL6n813UJOckbIdfLCKfsGN
         Zr74EP53ekTtJ8J8xO4aktqN0foyt0K1eb/mn+pw/IsQU7Y7bjGDgZuYYklhmI/ssY7s
         P6CynWT4gpg9scRIwy4pAfwPJs124UecS5xO4lsIrotAe9pq6qZqywY9pIAKxeMHTArm
         Ubg5OZSH2JsAQ7SgneY7x4lYqsV0I08h7/7ZPVRIWgjMjqEZzZQm7B982h+d897/j5ap
         7DWFxubVLRLqp+cK1Xx49DI2iuiwNYIbi9b8r0sQ1z1i02eqZEZz4WTETG2hxB70lec4
         Mn0Q==
X-Gm-Message-State: AOJu0YwxGw7KDWOpq8NJFXz6vdkdkEGUFtgLeo3P/Wpt2bBwq/GD/xSI
	qePBqG+0sOn3bRgKW5GuDWrUnPakDRyWzfrBQZ53w7A3Osq1EftNygSa+dnwtJJNcB4bs/1mwT9
	KGOmBIzAjZNZERMEnN2K0bu1AxBWnBo4=
X-Gm-Gg: AY/fxX7YthPvgj192FDYnCMkr8yQhbPf43UUXqMJYdVifBO3gVuI5+Em4UB8iY2tqPw
	khqoaRPyjPsEDGqu0tGe2mMlCHbaEcwNupmtEQH99pUEWV8JckQXF5XgrJJdb1q71dWkGg4i3yJ
	3f/c0NtAmGXKB19vE//TvBm02jAPksOi1hcn1rx4DXnkNUG7mvZBXMagDBoo4iK0C6bVBJ+Kede
	OTAXqZbKGmnQf+q3Lf31SFQZXZnFzxkXPU4N/nl/HEvvJsgbttNwbHBaGMp1KZ3a3TLO3M6dnBC
	l7x6ebk5VMbAfpB/mzfX7nht8PPk
X-Google-Smtp-Source: AGHT+IESHgflPXvOIachn8Weu/Gj1rT+55EATQkV3//kOCtswflw/4k0GsKSLk6uxqw29XlNeXlkKp2z/dgKR9Squ1U=
X-Received: by 2002:a5d:5f55:0:b0:431:abb:942f with SMTP id
 ffacd0b85a97d-432bc9f60c8mr395235f8f.54.1767629776203; Mon, 05 Jan 2026
 08:16:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com> <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
In-Reply-To: <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 08:16:05 -0800
X-Gm-Features: AQt7F2oB28_RiadtNKU61c30UF9BbaZnytAxnF0RGG3ahLw-g3EBYxabF3xNxQg
Message-ID: <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:56=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 11/26/25 23:17, Sami Tolvanen wrote:
> > Hi folks,
> >
> > While running BPF self-tests with CONFIG_CFI (Control Flow
> > Integrity) enabled, I ran into a couple of failures in
> > bpf_obj_free_fields() caused by type mismatches between the
> > btf_dtor_kfunc_t function pointer type and the registered
> > destructor functions.
> >
> > It looks like we can't change the argument type for these
> > functions to match btf_dtor_kfunc_t because the verifier doesn't
> > like void pointer arguments for functions used in BPF programs,
> > so this series fixes the issue by adding stubs with correct types
> > to use as destructors for each instance of this I found in the
> > kernel tree.
> >
> > The last patch changes btf_check_dtor_kfuncs() to enforce the
> > function type when CFI is enabled, so we don't end up registering
> > destructors that panic the kernel.
>
> Hi,
>
> this seems to have slipped through the cracks so I'm bumping the thread.
> It would be nice if we could merge this.

It did. Please rebase, resend.

