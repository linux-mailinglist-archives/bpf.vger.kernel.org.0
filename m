Return-Path: <bpf+bounces-75020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFFFC6C353
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 02:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68B64EE562
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C61EB9E1;
	Wed, 19 Nov 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNsTt+WP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296D2253EC
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514013; cv=none; b=SV1Lp+sMdXMo5U+0axFSh+gxTu+QK0Slk8hjI5FvYJ0bHtGgyl9B3dlMnVOjT7LqI7viO6g9qYUZLLO1Q3TV/TxsiUjn0ovxSI/Pxjya2RjeoNS5FDWVptfG1lZz7eFfZSYc0UZQu/WXTpIiaBGxjUz1inymDxc8wkxyfOyGGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514013; c=relaxed/simple;
	bh=nyNocpByUR3b/CwyKnvf0BiUzAfBGDnj8J4bNztx4m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBLnXzjg9jzA0ZAAJxp1ixIR6Qoz3DUVXIURGoJxhKfI1gsWhEXvlTDq/jqgX/489fCTb8+eZTwXagzvYykL1w4CIHU8660HlG7jTmjgKw32AKmLkjBTf/nr66p/+EWIZf24oMzSpy2nwRyQSY2r8YhuhwAyUuiLYXp67pxRwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNsTt+WP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3915637f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 17:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763514010; x=1764118810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OY9WTVmOOVuWqdg+fgfXG+0iTabreO+6WO5UBcn+ro=;
        b=VNsTt+WPJSmsJ8igXSptOuMTT5AdDrUj/zuy8eDwHePl9AC+ySXA6CMsEO6ojm1pGZ
         bTBdUWZfVYQjsshrWgAq0WEElvxoMShY3vKJGRpQ5PJyaIyV5Hw5degNSRe+HnUo2HX+
         gio4bpDKdTtKzit/cvMwP4zTTP/2Y+4sHZ0cTm1eiihQEj+flgiKh9Con0HSbhUMBzHf
         pGPYKHlfAPTyMZ6VCk2e6exu3b7Ct6BB/oLYWl2mRFD9wq62TxffEiez7Ud+m0hqf1MW
         zV1wJrsz3sAWkjrN7eVJouNSTDA8KsucNOXP1XNxQH/pm3LHnrSQWswHXI4OX+C8x7Xa
         5JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763514010; x=1764118810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OY9WTVmOOVuWqdg+fgfXG+0iTabreO+6WO5UBcn+ro=;
        b=lFsHW7NT62nu38Jl+QyArXykV9Vzf89goR6RHF2z6vRHmKNroibFx8VYHWMtVH/T3F
         RMxQzyTXBdwmh+NGKXBjuK3cw5gOIyUxmzWJxSx6FJYiIkTaW6OEhCAaXq/V401rsv3a
         Ygun/NktFpjfxG5ge0VHiCwWKwOxZ8WPjmVsKsyYjRoE/SGie3kNXcO76E8H4QcduQEW
         Gu3BNIYpqBoncD35Bpo3kTFebtu99arxIlysqvpHl5UP0iyLTDzFA7rsMdxtxV+MX7Yx
         b81lADliWyihyc1RYgihUIjSS51rxxXP9Mjtkcs4JH+O7x1Lm5n2PN87P7F8rd1Inpfl
         hrZA==
X-Forwarded-Encrypted: i=1; AJvYcCW8qbqctBGQMooutKmfL05Fa9uxEXoLWkeoPqUxKuKQLMpgKt8147Hy2YjpOc4oCtpg/rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEnogHXFvx60p+eCruL/hQkZ+nO3+iWL8ZwRqkfafgEd4tq0G
	HmBZ8xjnIAWTYye/eEe3GGPnyR1df64rleVwkaTNr5oZc6QQ257hwjdobwzfEODPiw+CJ43fKi8
	oqSDvFH/ValKwCqT8JIliBnDiEDxjC4Q=
X-Gm-Gg: ASbGncvqT+hbk3Uho4ReZF/rle0A31TCOdULxDTQhf2+zflHdqSnzIUCpufOCIvyB96
	j75EIkTRE/nC9igth6eXHSs+ht2tPnFeonbLL1dDiujM9Ixhs6NrxJI24hK3JBH8PRgvHM7L4WD
	X5nrfBlVanREN/omK60gFrrhBtAeltYViPhC5vW5t1q6PRgdJvoh9Wd9jE9tBbmxltAbDg9E8Ei
	HFG7OQIko5AdqRWN+n7/vpNOgqWp4+ssbWYBYvagBu7sbqx7/5mSrvDqyC0uKRqUCBrjEOlhUDi
	lgkRD59Ri4MgzvDZYn+1oA==
X-Google-Smtp-Source: AGHT+IFDVz7Fb9uGkQyQmluWKdUqIHteBKVCQHsm18F6wXu+OqNK1GPC1YzV6EetTn7g7tGQwNtMuHx6U9oLQSe4zxI=
X-Received: by 2002:a5d:5f47:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42b593847f2mr17058858f8f.47.1763514009964; Tue, 18 Nov 2025
 17:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn> <20251118123639.688444-7-dongml2@chinatelecom.cn>
In-Reply-To: <20251118123639.688444-7-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Nov 2025 16:59:59 -0800
X-Gm-Features: AWmQ_bnxKXPWNefwBIhAKxp_fFSOIAOFUGn2xQfiHye2gUu4LTw_OUbNxrvnfJ0
Message-ID: <CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:37=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
> is needed.
>
> For the bpf poke case, we will check the origin poke type with the
> "origin_flags", and current poke type with "tr->flags". The function
> bpf_trampoline_update_fentry() is introduced to do the job.
>
> The "jmp" mode will only be enabled with CONFIG_DYNAMIC_FTRACE_WITH_JMP
> enabled and BPF_TRAMP_F_SHARE_IPMODIFY is not set. With
> BPF_TRAMP_F_SHARE_IPMODIFY, we need to get the origin call ip from the
> stack, so we can't use the "jmp" mode.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - wrap the write to tr->fops->flags with CONFIG_DYNAMIC_FTRACE_WITH_JMP
> - reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
>   bpf_trampoline_update()

All looks good to me.

Steven,
are you happy with patch 1?
Can you pls Ack?

