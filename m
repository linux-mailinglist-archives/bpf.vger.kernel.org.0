Return-Path: <bpf+bounces-45841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A79DBC5A
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E1163B14
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAE1C1ADB;
	Thu, 28 Nov 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTiLmCC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9262CAB;
	Thu, 28 Nov 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732820727; cv=none; b=R59iTxXAegltICiH9VwzdW4GJRCyzqvYOdF4mMq0eIzDfhd+PEokVMD9pzarJacEPZv3kN8H8kVTDx4RHuokK2n1i7D2hNvYl+dNWyJagTAJaxw9gqOl6JT+VvQx82DXB7UQ+38AsyoJnS0Q/jml4mW+yh+ndTLO9Ecbush4EX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732820727; c=relaxed/simple;
	bh=TGz/gRp6g/hAX+W8VpDqafS+O5d3xzNQzd0Hcui57FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly6Rc7lrriFIzH/fxMnR6l3v2CTKBBs4ET2ITTW1NnRSddBuOLmWo5qdfXYLdfXy9fHHRkgdqfGVBtfwlcu30UqxzXlIjiJYd1dBZPWUgZPVldrsCSFK/LO53m2SJ0TAcimjxKX03piekDSz2usbmDn+3/rwpwn47oZnlRHs/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTiLmCC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a099ba95so10304355e9.0;
        Thu, 28 Nov 2024 11:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732820723; x=1733425523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x030wcXN3XejZGrsIlbUm8x1eM2wwwHskSKWwVcxZj0=;
        b=hLTiLmCCP0H1gVVcLbJy3njRed63kGceF7fdo7VOyQadv/nOozBW/L12oa7dS33dua
         itpC58wHzZMcPX4dz7qtVrmn/8vpZVeeHOPK0DVWlKm+bWQk0ew4Kk9XEFu+sX+uPBF1
         M11wztaUqVN2lS2Lwv8+TQNjIbdqKPOiiL4Jmx9hkfb0KxqzBSmToQ+OqU+AbsKJ6cgj
         opkc2GW5GGKsKic+qpzGvgeBEFfa6ElZFv682Q839FO2tMSInpg0ulik+ipRbZJSTE8C
         f0Zo1PQ4ODPvkc7vvQZuBMd4aolN7l0FoXt4qh6MHGF5YBxrrMHzmtvoCQDw/bhfM1Zh
         TWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732820723; x=1733425523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x030wcXN3XejZGrsIlbUm8x1eM2wwwHskSKWwVcxZj0=;
        b=UY4yWCIUk4SDnYmZ1Qc2GTl52DGKrTa3L+IvXuO442WArFN++6Dz7CB2HCn052jWQp
         UVQ/fGkOyyoaBa7uIqMJzMPuidP9MQHSr1EjSFBB7Us7hD21UNuK/epGFjZh+whn0NF4
         Iph5rkG8EmUAuvK2Jd1VL86w7y9q/BA1EW+TBAvd0YK40WRTRprPQ6JEK1TMlLxNj4Bs
         oXNMomLk1DhlYqVIkY6Y/uR+rONWP3bqhj22M1sm1n3eXsSN9tnhkZ4EfwLStSbft/aB
         mXTDz4kUin5lUdv25mwyjhBcpickGxKBylgaNBVSHzcOTAWFFtWIyLSoTkk4KODVqUz2
         FZWA==
X-Forwarded-Encrypted: i=1; AJvYcCUmzDxfo0G+f4m5a1qubxBzYungsvbTwUFTkKzFHR6H/QYPBTc5YHyTuH6zWriGAqIveYw=@vger.kernel.org, AJvYcCVn6beULSkbe9EH5mVkdPKhzIc82OeushOMOpMO/srNCzCtEUFS/MAjhQhvE9SNivWeYFu+nU9LTqOPe6gOn4BQaLVI@vger.kernel.org, AJvYcCW4oImqA33TvprS6vyO4JIOBgNlplN/0VSgQhKZfSLoLJQ+ptBZ1viFWT/Pi0iirP11n9mIM3F6X0CD2k1i@vger.kernel.org
X-Gm-Message-State: AOJu0Yyar2wBeNMjx0dLTs0+4KxVmkxlRi1jvgdEu+3AfnL6eY9nIbiv
	/Od0WpZ5oj4HkAgIUIVUWlXQb2jqzGXb0m91vLACrbD5IKPQ2Wt/dd8WsTz3c7NpG/YoPyBBdla
	uLqHlWkZPy2WP2UTmygw3anQ2Ikw=
X-Gm-Gg: ASbGnctKrOvr+d/UN6Csdwop0VVhX7cj8+NS/B0XRG7ZD293E6gVUjbkxDTP+oixR26
	aLgK1QbAo5D5c6xdG0FPk6UJshnPCkA==
X-Google-Smtp-Source: AGHT+IH3fCX0e0rFd+HZh7RVQbxnXMzu7+VAlZVC6COpEQrXCJNtNJZ/3frl9kz/JjCu3qKF3LVnN61Q6eq9MFXzQ04=
X-Received: by 2002:a05:600c:4f85:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-434a9df22c0mr88230425e9.30.1732820723418; Thu, 28 Nov 2024
 11:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127140958.1828012-1-elver@google.com> <20241127140958.1828012-2-elver@google.com>
 <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com> <Z0i4DFnqRxTPOUfJ@elver.google.com>
In-Reply-To: <Z0i4DFnqRxTPOUfJ@elver.google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Nov 2024 11:05:12 -0800
Message-ID: <CAADnVQK0y_moywsFDsHLPsNZXnZQVJig7dN7J9khVv2gNq414g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 10:36=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> On Thu, Nov 28, 2024 at 10:22AM -0800, Alexei Starovoitov wrote:
> [..]
> > Moving bpf_base_func_proto() all the way to the top was incorrect,
> > but here we can move it just above this bpf_token_capable() check
> > and remove extra indent like:
> >
> > func_proto =3D bpf_base_func_proto();
> > if (func_proto)
> >    return func_proto;
> > if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
> >    return NULL;
> > switch (func_id) {
> > case BPF_FUNC_probe_write_user:
> >
> > that will align it with the style of bpf_base_func_proto().
> >
> > pw-bot: cr
>
> Ack, let me change that.
>
> Below is preview of v4 for this bit.

lgtm

