Return-Path: <bpf+bounces-46532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA7D9EB8EF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFC7283345
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD386342;
	Tue, 10 Dec 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTc8Qlsd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E338633C;
	Tue, 10 Dec 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853713; cv=none; b=N+xzIc2qiBJRZwIFTT1/UjumhKrNCaqQzbxXejFYbsEzWxww2gy4xslnXEFjV+83cxHROrXskD2XKy8y1aCrnRz+yB9y8a7I7WEEJqHq01cWHzajT04+asyL8DJCWZDNkZkxAtxmh9Q7RukRQiJjs4TBY0w9YzXUhr7lCDi+img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853713; c=relaxed/simple;
	bh=rsTGxL0HBNmGxWBc2VDCHNPEl3HaF5w17PiOUuj5rUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDirsiqEkuBpiM7nPdMbn5/bQh1bs/fGb4r9WoMaOxtz6VpAHHwgFEThCql+Jos15rrPmQCXPtifln0ZsDYe4v8FUvEmzxmiMMWi4Pig1K7FaMWpyeb7jxTDMP+8B1xXIxUAwKUQylb+xUTp1dLrthXZNxqSqebXaDsRTixopV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTc8Qlsd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e406a547so24842095e9.3;
        Tue, 10 Dec 2024 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853710; x=1734458510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBlvItGA4s+sxQEx1hGblMxAfdPEGezlVzN9Y20RcFI=;
        b=jTc8Qlsd5BvAZtDnpHpvaRDMa8PazbIbOKxPZGYc+o85Cb/wAQZ/XdUZlVhK1AqI7z
         rfk6ey3voEopJ8oCrIm+ABPBxS/J780ln2G9Lctij2S7lunnFmgwSQiQv6w5APqeYxfH
         Dh1KbYB4Yw0d0U2OfD71KEEgyBIqhymu/8SnYRcF7tjqLsbnDx2Lvht0ouLzTuZvaWb2
         OGENhY2l6kHqTNas/9JafTY0G9EsMMmbtxUgZgqvKUbMlgJ3xbLuLL2TPu1w+TtnlJaL
         WbLKzxirQa1FIswrPxMXepXUang7XSxDSnBVDBjyAxUash4UmwoPs3FYtOugk4RQRbfx
         +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853710; x=1734458510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBlvItGA4s+sxQEx1hGblMxAfdPEGezlVzN9Y20RcFI=;
        b=GLRd6bRpiRz4+AY6r7rS90UmxQ+LiKw5wNHZNxVI7saKBNPVJODUCUBs+5a9zBWs+M
         5k3hw70pxVzJze7anOEZ1ssM3QGbU2FQVhKrDtLewCp8uVuVjj4Z2oSr2mWug3inZVyA
         cc3DX8ya4VyPMHrE7i9jJwPbocW7MXTYpwiezZDsNzKgDLhUnBEQ8aWcBcF8HcUW3giH
         qsE8ho89uCXk1IuTYCeLC6M6KJZ9qfS9QzvLzcBMyN8dDRo0WZFmZmnEd1q2fV93y5LU
         fVO3YZ3fIoxQms4pZGLF0iYlXiQo9Js7larQc99++Q6KItE6sR+/uQzxjXud/CpMsDJF
         IqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF0OElDrUog9aIil1n/9IGePbtUxqOIDrylt8nvH+p5B+Ye078TzMoLClLXuoYXnlg7VA=@vger.kernel.org, AJvYcCVXLA2kpzUbClPAKLTlz98G20ZPgT91tNPxkhdGsU/F50zqSnxvMXN+hkOlh5j7u747zgakvLCV@vger.kernel.org, AJvYcCW3XyptrON7JeairzYphSW9uhTyKiRcfpNfVj/nJ4tnbenKbtoL0m+fKUjSthurddyzrYZ+DkBC7yBB/g==@vger.kernel.org, AJvYcCWRQvbeFfbdB6ADtOCM0+lY4GvU9Rrg8ILHuPtl9JNmMEjO8Ad1fSC5aA8N+zuZiWCHpmqu1d12NFRXQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqjSKzWkdaDo3gC4elMuqimt9Yorp+6VQjlJJEVoXJzh5bWDI
	P94arYjMpu0x3psnwjXHSBp01iuZeUSdVDLlCOJM4Fd57Z7E1rstvmki1BekeAZov0K+6PAHlsy
	PUtWYdBUWbQUZ69aWmr1BHzn9x5U=
X-Gm-Gg: ASbGncuhqWuhuDrs+d+gFqZBYCzCgIOD6Te25CU3Aiabs5y3zDC4Pwqv3USYgHwfjAy
	RPmj9EAInXbL8JsNd7i1qYW/jKM1+i6fOHo4HbxXGRyyOIXh/YdM=
X-Google-Smtp-Source: AGHT+IHhGuEaEWR7fFfHE+4MIKBVmJs6l0dKJ8v3/9GLrqsDK8ii+HMxWZdSOJjxHGu+I796y6DFOO/fpzSIzAcl93Y=
X-Received: by 2002:a05:600c:458c:b0:434:edcf:7464 with SMTP id
 5b1f17b1804b1-434fffc0b2bmr54752515e9.30.1733853709387; Tue, 10 Dec 2024
 10:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210040404.10606-1-alibuda@linux.alibaba.com> <20241210040404.10606-6-alibuda@linux.alibaba.com>
In-Reply-To: <20241210040404.10606-6-alibuda@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 10:01:38 -0800
Message-ID: <CAADnVQJisbHFpS2==pw4aOAmKsbo6m6EDvOBntF_ATMrbp0G=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] bpf/selftests: add simple selftest for bpf_smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, Eric Dumazet <edumazet@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, guwen@linux.alibaba.com, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Network Development <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:04=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> +SEC("struct_ops/bpf_smc_set_tcp_option_cond")
> +int BPF_PROG(bpf_smc_set_tcp_option_cond, const struct tcp_sock *tp, str=
uct inet_request_sock *ireq)
> +{
> +       return 0;
> +}
> +
> +SEC("struct_ops/bpf_smc_set_tcp_option")
> +int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
> +{
> +       return 1;
> +}
> +
> +SEC(".struct_ops.link")
> +struct smc_ops  sample_smc_ops =3D {
> +       .name                   =3D "sample",
> +       .set_option             =3D (void *) bpf_smc_set_tcp_option,
> +       .set_option_cond        =3D (void *) bpf_smc_set_tcp_option_cond,
> +};

These stubs don't inspire confidence that smc_ops api
will be sufficient.
Please implement a real bpf prog that demonstrates the actual use case.

See how bpf_cubic was done. On the day one it was implemented
as a parity to builtin cubic cong control.
And over years we didn't need to touch tcp_congestion_ops.
To be fair that api was already solid due to in-kernel cc modules,
but bpf comes with its own limitations, so it wasn't a guarantee
that tcp_congestion_ops would be enough.
Here you're proposing a brand new smc_ops api while bpf progs
are nothing but stubs. That's not sufficient to prove that api
is viable long term.

In terms of look and feel the smc_ops look ok.
The change from v1 to v2 was a good step.

pw-bot: cr

