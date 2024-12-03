Return-Path: <bpf+bounces-45989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D69E1185
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 03:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5211F2834BF
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943F15E5B8;
	Tue,  3 Dec 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsC3Lkl7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAE7FBAC
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194442; cv=none; b=WKSazZ/hXJL4vBdW0k9XhBDdkhaNsnb68HW2ACiKtCm5i0czFlWGdKcDF9sNbANVHuhQmUpceivDFTijhq44jKzAAvEOgf3TP3ohHjGt93e6OQVXCrp1KuRPCDgMJanPNSKgjY8/C7N0oy3iTHkh53GV15J+v8z+AVDZwjDtUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194442; c=relaxed/simple;
	bh=7+088LmEzFxdXvMtqyWgWPra5+0ki1mOSZZcbtGkb5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqnQIJWtStRhxJ8hIv+apo69rs5kxd+GhAZHXGH8PdmiEUJ5tfYPTL2vTg4MlyP46DgPAEmHIeI/5ttQS1w5CH0ndKJVkurZJksjv9M9EDxflyjxo/cjTdEBlSBAF9/E+ZdvNI0DxAkwyGwqxZdNriCtL7AXi2ylCUlJUCD9Lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsC3Lkl7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a766b475so45993205e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 18:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733194439; x=1733799239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5WWi6XEg1FP321Mlpxq1wWThEpYkbL2sGAinAF5Zd4=;
        b=SsC3Lkl7Fqf+y0I0LK4e9IlWgT+yvpNsRkEJQXFkqneJEtRw7JfGzbGpt5eYw32cTw
         BLh92T7B4ofQwjuB/3NyYLoaJr+fmzPlHAX3UqvZi3oV9e7qQfQWmKgdzRPgbxoR5vit
         q9U0yoP0LXbbOqsGGNKdFFNsT02Q+b8nlienT3bV8NbMEr5WDWUx5LqOrvuyTU1YXad7
         RVClXO6YDOpCr9MSmZkZ6of2yRn2m4gMrdHrcu7DmRt7QIJfTHNV3V0xgSUD2i7edH/M
         HzIJOuthSlIOz+EGtSm6E4eeYdx6+IxOa0aiOnnLn+2bAJPy5MsGYnyAeuhjUP81Tg0C
         z9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733194439; x=1733799239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5WWi6XEg1FP321Mlpxq1wWThEpYkbL2sGAinAF5Zd4=;
        b=cndwhInQmfVLEre5eU1+O4n8WEwL/z+eR4inbktvwljisJU5JJ4CK65+bcSM49pq9S
         9Q9IuwWKRRCe5TdmjpAVII9IUJPfMLzPXbgM7bjznsBDWeL2qrAu/sg7P8fjZm4uWjC5
         /bmFwRtRKjS2HsPLEOjFV635k1qM3SJ5QV3+307M0jAoqF4onJRfF83Re2RsHqUPpnXd
         S5XTQf8DuKO2NfCRx6HG8znpQ1nuveJlI/CSIqYAXgTFsI7W7GJcWyiDjGTZYub7oTF2
         o+sV6lj1Bz/iEp1LIl1BnGq71epdrA97D3tM5jwYZqK5IjzGlhvcCBAN8AXKbnzeL7A9
         fJmg==
X-Gm-Message-State: AOJu0YxyTPx4w2phsO4iqGj9IA/ST4yDfmxkQYuX7wzI+N7Yl0JpZoU8
	Qk/5fdgwgaj2Z5BMp6DG8vnMOCfS3VO5NApVeaC1Jg2g7WlNw0rYq0PWTcBgjZGgUo6LpNDMirE
	aP2pcIX+s0VoNIe4jgl44w577stgkfw==
X-Gm-Gg: ASbGncu5+0suvZ9LUQ5WDdEZyhRgJR7DGnWDWQPyz26LbZAQjUBr3HP/J1v2qCo3Qat
	6nqSspRMsHGWh+C3119Y01WTtSdFCNC2W6AvJDQxHotLJgVs=
X-Google-Smtp-Source: AGHT+IF7TOYDykG0wmLCHVpiMUSn7E9fAiQiKDd4p9U7Y0USlG2gPmqSNAC8qpE/xcm1k6ovBQFv/vOAK63K5L6Cd7g=
X-Received: by 2002:a5d:598c:0:b0:385:df6d:6fc7 with SMTP id
 ffacd0b85a97d-385fd3eb619mr690665f8f.25.1733194439497; Mon, 02 Dec 2024
 18:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203002235.3776418-1-memxor@gmail.com>
In-Reply-To: <20241203002235.3776418-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 18:53:48 -0800
Message-ID: <CAADnVQ+2QmiuNGoqsz2QiyVk+5yOo+8WposD6RMQLKNaGnc=9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Zero index arg error string for dynptr
 and iter
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:22=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Andrii spotted that process_dynptr_func's rejection of incorrect
> argument register type will print an error string where argument numbers
> are not zero-indexed, unlike elsewhere in the verifier.  Fix this by
> subtracting 1 from regno. The same scenario exists for iterator
> messages. Fix selftest error strings that match on the exact argument
> number while we're at it to ensure clean bisection.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20241127212026.3580542-1-memxor@gmail.com
> ---
>  kernel/bpf/verifier.c                         | 12 +++++-----
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 22 +++++++++----------
>  .../selftests/bpf/progs/iters_state_safety.c  | 14 ++++++------
>  .../selftests/bpf/progs/iters_testmod_seq.c   |  4 ++--
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
>  .../selftests/bpf/progs/verifier_bits_iter.c  |  4 ++--
>  6 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c4ebb326785..32c016d305af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8071,7 +8071,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
>         if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DY=
NPTR) {
>                 verbose(env,
>                         "arg#%d expected pointer to stack or const struct=
 bpf_dynptr\n",
> -                       regno);
> +                       regno - 1);

I took it into bpf tree.
Otherwise some messages in bpf tree will be without -1 and one with.

