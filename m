Return-Path: <bpf+bounces-69584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C6B9B0D6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89223166DE7
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED38314A73;
	Wed, 24 Sep 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkhdtqop"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003931DF755
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734912; cv=none; b=Tg0DWBOYBy6JmbK8Laq7gEmUrpd98S4iLclNDvBMFomGB63O0BnrfhAe5WG5/gRc+cNrrwZKWcHbCyQUhnaskJ8X4ihvwvdW+HThKfrsMEa3AlY8k6WmCgM7Egno1cxQ9fcMUfTMCtQXGqGVr2zrdeaXekFkBxLSOoo7U/I4al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734912; c=relaxed/simple;
	bh=C5g/W9vJvxdjSMmBvtYRxE+5BQ8+R+uQ5NcSeKzgAuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrbROeJpxpCr98etMP63gNSrWohEV8r+XdxaU4Nm48JCAmyF0aAPUolLT7pRhFEe6wSzzxZfK/Z+kjuvAQiuq++/ENATGv9WjSf9UKb3TsbMu27OrCF4THtPtNOBu38hOx3D+pd3Vnvtor0BzzCx9FSD3DkWgTLukPT6/M3J6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkhdtqop; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so118394f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734909; x=1759339709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THvcl/CIFi0jynW2vgKyfrOvexvwMbqpu2xgIk8jBLI=;
        b=FkhdtqopPOzArjQeIAg8/AX1aSJ39Eg7rexcwcBTqver2/GdXvSkg4t8OzCua1fwQM
         9cjTTpE8Q6yqEKWTCQOH1i0gsdk/fsKxFi0ZteaU8051zseFspiA9nN4qQNR3lKl/Bmo
         Fi5RI/YeNBVG/RBHg7R+DsZw0Skb+hPCxtKXNj5B7lQUk4ADQgCzJua+Qa9xr+B5/eXS
         H+7PaazEV3iPsP2/GhWmgZxbvzMTKh99lYOu6fmg2QlIIvjmIOM1hgbxBC14g13NHlFz
         Q3eJ75gJeu0ByMc+iM1NV9kCOl1t06NsQyNuv/GoFXHiFraelHaDVJ/El8hSflfg8CKk
         kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734909; x=1759339709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THvcl/CIFi0jynW2vgKyfrOvexvwMbqpu2xgIk8jBLI=;
        b=Vhi4bIsx0fIckFLCUPAyxYF0g5OeY4aKNFoIw7W+EHRR/Vfa7tbEOKyjg0Hi1IyWR+
         8A0DRfgao6pD9OUarQ5FO85B+HY94qKIhiqlsOY2EeMerupnXUsbK8nW2TLj30lZ+Ke2
         zNd36qIkhlcET3RRyjv2LJIYj4hhRRMhRPc84CCcQ1qgSIDBs8zDykCfcj2XrHMIp7kX
         FcFxwol45rkhUSeTBdzDx0dVjIpOZ3VoWAlIYIiBafNfyDiw2wc30qaOWyXQMyjUtqQL
         xriy9dLeNeHJFCKxxqGXKIoWxnF2os2TN+1OArFcPOCBXFzYHhVL5l8hVVghr5aSgkWF
         C1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjAfpEMJpZPmcuPHAflaNpnZ8+Ne7RdpWKhiY73WRKHqX3wgTQyHGS5q1DCyl2osEBRYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2I90t+eA3l1G0xM+LJDGokNIbTsDMtOW9QoGuin7TVECVQHh
	7ftnk4WJlUFmrUXXgxNKvdOOjOzxLBx8TbWxdM0wI5BR5sjDJ3F/Iu7LEFJ00yuOHbwWITsc3Fk
	CaxuSMA5CmWobAHMltr7BuyiNfyW4z4c=
X-Gm-Gg: ASbGncsfGsdNI8/UZcO6YmApDMUQGHIyHIpygg004xVlH4rCO+BZKQko/QcXeFKKgn5
	CsIuAxd0ID+IHkW3Cc8vwxSnflNNKaPZSLBrJ2oW8qhcOAy3kx3OwVqupzN2n8j7EoR1oumEhEo
	qtjpjaJbFZEJk4qHiFttfaJY3L3+fa2PIwMI6EXlKiLRRjinpjwEg96hxYWPrFW/PImrL/nLqn/
	jtIsw==
X-Google-Smtp-Source: AGHT+IF7jn9KpoAUioLZnGYdePIu7rC9MCeY+i5/NopmUIUjWqO4i+RR0QuF3KcUH9oz78W3Jq+JhubR7ujb50tBATc=
X-Received: by 2002:a05:6000:2885:b0:407:4928:ac82 with SMTP id
 ffacd0b85a97d-40e4accc857mr689899f8f.53.1758734908987; Wed, 24 Sep 2025
 10:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com> <20250923174738.1713751-1-listout@listout.xyz>
 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com> <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
In-Reply-To: <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 18:28:17 +0100
X-Gm-Features: AS18NWBoEY-E3tPR942zLsCwxXI9_o8MjMPYwPMmhtZwFLH1IGKDMVGzqIOYJBs
Message-ID: <CAADnVQLjwm=ruZ-4tK1aMtFw-nL5ppwub_a-OpL09xkPQVh4dw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in print_reg_state()
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:41=E2=80=AFPM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das <listout@listout.=
xyz> wrote:
> > >
> > > Syzkaller reported a general protection fault due to a NULL pointer
> > > dereference in print_reg_state() when accessing reg->map_ptr without
> > > checking if it is NULL.
> > >
> ...snip...
> > > -       if (type_is_map_ptr(t)) {
> > > +       if (type_is_map_ptr(t) && reg->map_ptr) {
> >
> > You ignored earlier feedback.
> > Fix the root cause, not the symptom.
> >
> > pw-bot: cr
>
> I'm not sure if I'm headed the write direction but it seems like in
> check_alu_op, we are calling adjust_scalar_min_max_vals when we get an
> BPF_NEG as opcode. Which has a call to __mark_reg_known when opcode is
> BPF_NEG. And __mark_reg_known clears map_ptr with

Looks like we're getting somewhere.
It seems the verifier is not clearing reg->type.
adjust_scalar_min_max_vals() should be called on scalar types only.

