Return-Path: <bpf+bounces-52530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A279A44556
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDCD1891FF2
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2D17E472;
	Tue, 25 Feb 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU2UVOH4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFE17A597
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499409; cv=none; b=I35Z7zcxZ4F9TKhpIT0lNTgmg2QvYK9a8HkDX7UVEhv7i5XKPq8J5qBQumiyig3O7upJMjJuDI6eGV8zFuWrdbdZlyVhIo+72lzvB1Yi8q/GDAp4EpWkaHdQBfOgR0svshHJzIK/B122dtFG/8BTCZzg5BMkHmJqqqdnTBMNh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499409; c=relaxed/simple;
	bh=Aa9KolgfE4f1k0uP/j0MRnXAFIx3IEA+AKcjyTmH6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEUTZzI7HobLPOmOg6VLg0p3jTDRpOGCc9Z/LWepfFtE7qgtYaRWdotdHYGKyT/TUi8Zl4ebHdQUczkXvq3Vdj3hl/H8+pIiFkIN3Uxa+kl7NUbqk37nCWi7f/HodtMmdKArIw/OcZBYekaZBl73G13CGexv99uokThkCK0J8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU2UVOH4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43948021a45so50746245e9.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740499406; x=1741104206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsMJAEi0Io8i77ZVSEw1qd6meuvTk1/w5k82x44avjo=;
        b=BU2UVOH47ktpYxs2nUTvos5qAiDpCCE2PEdRayW5buhoWale48tGhWyeBZ0FoxlpB6
         xLKYvJfom5MmCfEByLLKseV48wXPiyI+k5LNgqTCjxSQj0heLJ7yKGzQlg01e0iS2Bti
         gDckTYC4LKPieo7A/y09/+yL6eo1r73ukiaAxru/HMrPVJNARA7l3M8LTp5syuOgNdfH
         tK/PXAaqZ9R5x+SRRurOb22ukwWH6mK8JWcv3daW3vVlPs7P5ga98oWUYWVCBMa1q4vM
         F2rXAlgAkcQlr20DzklzQqXRDwElAX3M/R9u0f+vU0GejtRcDwJFhMsK1sdN8+/3hIv7
         UCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499406; x=1741104206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsMJAEi0Io8i77ZVSEw1qd6meuvTk1/w5k82x44avjo=;
        b=hdQbiP3n/T4TfaeV3iroaC34d3LQ2IfMvEApYWh1cdq9IpDrlYGIIxH0Q5C/BUOxiR
         gZPZuqvg+QCPOJwKGOJxWC15lNsMb5BQdE1luYOewCzkNne+9lGiuzjDKZw3pqY96+3s
         Ff4xaplU36/QD1WgWcrlsCEFM/HjxLAEkGq0swG54yOXzH5vGbxzXr5rjvLCNAgl1KJX
         yAPE0EVUKN0uBkwi/0oDG29wk/i9+wp2rkWMDAM+stzED/ydm5XBlwycKipqJULFrF5N
         wNhdjDgDRp8MQhlTJHWvj0iP5BbZHJexC7tMr8qMm7js3xBSa5ZECB5QTlQAtnLrHynZ
         eN7A==
X-Gm-Message-State: AOJu0YzD/Xoey4wGMhxsKkBXlNqQ+4K4EOryQ09czv8tJp5uyEjKgrcR
	U1iYfsRnHGTwc/v3TtXwragYDfK6/WzIxGnIij6BqPWB5tFtWewujupfTbiwas2w+UpmfPYAg4F
	thl+bTFy9VUYnhJfSr0BSnBV9+wk=
X-Gm-Gg: ASbGncsxAgXehRdkFtfs3QDfOiIPfiUVGiJ8tT5MWaenP66XbPMPhb8yUl5KV4O1HT1
	uOcQz0sT9pscXWo4luJGV9CxWbpMdY5YueU4eZi82LtPoVjQXwh953z3U3ysf9B8iDly2pSpJxI
	jnPNIHXMaV8mvoNH3DULIjpx8=
X-Google-Smtp-Source: AGHT+IG/2OGA0sUcmrRAFkYyDWJrNInTj+vZvXJxVdqWfIBEe0nrjkdicFZFf+ukTVTu1FdiKoNXh7GvqpCk35tCX3M=
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f6e95d5famr15965959f8f.21.1740499406144; Tue, 25 Feb 2025
 08:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224153352.64689-1-leon.hwang@linux.dev> <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com> <ebc973a9-2e61-4e3a-89e0-492823ded721@linux.dev>
In-Reply-To: <ebc973a9-2e61-4e3a-89e0-492823ded721@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 08:03:13 -0800
X-Gm-Features: AQ5f1JpJmfL7z_l9CfRJ8GYDshWC4U6wGsUFu8w4dsIQXBL4qWBCgg4vbR6xwq0
Message-ID: <CAADnVQL9wjWW12j+HpMmsmOBjoTZiEub9AWziVYXPOiRq-3Vng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:50=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/2/25 03:41, Alexei Starovoitov wrote:
> > On Mon, Feb 24, 2025 at 7:34=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_pr=
og *prog,
> >>                  */
> >>                 struct bpf_attach_target_info tgt_info =3D {};
> >>
> >> -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, =
btf_id,
> >> +               err =3D bpf_check_attach_target(log, prog, tgt_prog, b=
tf_id,
> >>                                               &tgt_info);
> >
> > I still don't like this uapi addition.
> >
> > It only helps a rare corner case of freplace usage:
> >                 /* If there is no saved target, or the specified target=
 is
> >                  * different from the destination specified at load tim=
e, we
> >                  * need a new trampoline and a check for compatibility
> >                  */
> >
> > If it was useful in more than one case we could consider it,
> > but uapi addition for a single rare use, is imo wrong trade off.
> >
>
> Got it.
>
> I'm planning to implement a restrict version of
> "bpf: make tracing program support multi-link"[0]. With log buffer, it
> will be helpful to report the reason for declining attaching, especially
> to report the tracee info that causes the attachment failure.
>
> [0]
> https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@byted=
ance.com/

This is orthogonal.
"Some future feature may use it" is not an excuse to add code now.
Especially uapi.

