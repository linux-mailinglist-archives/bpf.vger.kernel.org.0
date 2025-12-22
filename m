Return-Path: <bpf+bounces-77299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6288CD6EAA
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F9353001198
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77B3346B2;
	Mon, 22 Dec 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTy9cDCd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F2337BB2
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430208; cv=none; b=ryWzBPseU6LIWYEBn8z53EI4VlnjaMTMpFcVCuAX0MFuPh7e4Trun52IRfp7qxe9WhzocNZyyqRnrG1c3Q4N6IwZG8pIcFhmb7VFUk8CKQVwjV902STVq9vD1FyDJn80KhAlzV24Lz8shDuBJD7AUDpRO2VASESXXr3p08DdN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430208; c=relaxed/simple;
	bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4/ZkbDdsVfECVi8N3MNNajlYL9+9kTh3LmI7kHzNPqdlRuc2dWiyPbYyGY/FhuZkrTtzDftRjORF/uevD6qC4PFvDPQ1+Mtl12Kqek0NHPiQgQ7GV07zVYKopOSIfQ0ZjNJ6dN7irm7Y9jS4gsQQ1se+PrKZ42sDZjQLcAneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTy9cDCd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so37362575e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766430203; x=1767035003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
        b=BTy9cDCdvf51kpeSqoGJwYEC8CWFYvzSPBJudifiBvVKyQSSmluEAufJ8KhtgjiAdj
         BFymS8vUybLogUG+9uH+p217nog7uY/cNMMdJEEEM8TwXtuSWBK6mUxKg58+3EUJnSUX
         XGWTsDru0K0AFZMtphVk4kmiHACAGYqSrOTeR6Rpoa/MCKZD7ch921RuocB+R/mnXhS+
         NTQJfiXcucAFvofJPFb2Gx997hONLJpDeRkJ4rVaolgXWA/ir2jjv7Sne0LvIlIBIDJl
         JzQDmffQJWvfm329wt3TZ74sY8nD6KLqVYhELrfjW7YawmWMPnJygNOvTYZp5hVLNkOu
         jQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766430203; x=1767035003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iAYN54MFAPkrX8EkYZmeAcc5q9qX8LUMd9BPp1et24=;
        b=vKxmF7Sc9nljxGUdhQWHrSobRPuqvk2uRh3UU0ajItUMvht37C9HqbHUIGGiASjk9T
         5QeJlUMn1aaGq+zC79kUEETnyDpdPbHosNcHvAEEfIi/QH6gO6Esb0DRn6nxl7sq59Ll
         cYP2sw05ftr+904N+eBLLx5q3dVH9m404jzyeIk63XHWmUUUVdIXumjlLu8fJFPB2dnP
         GNlyQUwM5vfKiOnP7XdDA0Qewk9J+K5WPVAVz0MAfzrRwkvyY5vvprC7sWZkF6dFy6dm
         2HUxp3eZxkMmZ05DBv4itnKGfiOK6ptgGyPFkMTjk+9mOWkEHKjGd6oPw1paDa7MOr3+
         pYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuJyt0Vj9mN8kYRQMdx9dJQsoO0afGGAzuq5NiJ/o8VbUdshDRp7oq4JAbwMCbk2DWZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYMS1Vx0I8EgP+3+xVVXOo3avpyEmL2To5ccmE7P+/+mbeH7r
	lY1y4gSBDvk0S/wt0HsuUbRVZVvGESMG4i/SPywx0ToxPTokUg6fz3EiOXD0Un/d1SrNdUNOOyg
	VEWxSJ1h4j3e3AF/tM5NcgfcDqzSwbiw=
X-Gm-Gg: AY/fxX5URM6NXe+MU/9OPCqauRxOmBELuSgt90WhZwqm4ixlvasxuVnSxAtikp9+teQ
	2oNMiJPs+rP7o0pgX5kcim2ivCg86/mGVBC5S0FEeoNF6W1bJPoSAXThd6Q5zkcOgb+0/XA5Rpl
	j1Tu2FQX+dv7zS3G6Apz3GZdbzHFbAi5WArR/T2CiTgOs02WjaiYTZX+8OZdP5Sp8QVeS0ZA/xz
	Te7qfmSwg5GcAFthzN+eBVrfZ3TvNzRYKQP5JqFMHya0qC3avAd0oZ9eLM2NINq1H0J8daD
X-Google-Smtp-Source: AGHT+IGWlY6loBjKIYUvY3sJxh9hmOkZNaQ/5Aegdl04SOShtYfzVNtf9kjzV+lII5u7h4TAq4J4/Sz11mXDupmoLmY=
X-Received: by 2002:a05:6000:2302:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4324e5060b7mr12235818f8f.40.1766430202652; Mon, 22 Dec 2025
 11:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com> <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
In-Reply-To: <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Dec 2025 09:03:11 -1000
X-Gm-Features: AQt7F2owleetMFpC7ourxjF6EltaOtWsOJeESKt-MP00dpYF_8Rf9fLNrsVdOBo
Message-ID: <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> >
> > Hold on. I'm missing how libbpf will sanitize things for older kernels?
>
> The sanitization we can get from layout info is for handling a kernel bui=
lt with
> newer kernel/module BTF. The userspace tooling (libbpf and others) does n=
ot fully
> understand it due to the presence of new kinds. In such a case layout dat=
a gives us
> info to parse it by providing info on kind layout, and libbpf can sanitiz=
e it
> to be usable for some cases (where the type graph is not fatally compromi=
sed
> by the lack of a kind). This will always be somewhat limited, but it
> does provide more usability than we have today.

I'm even more confused now. libbpf will sanitize BTF for the sake of
user space? That's not something it ever did. libbpf sanitizes BTF
only to
be loaded in the older kernel where the original BTF was
generated for a newer one. There is no reason to mangle BTF right until
the point of loading. Presence of a kind layout helps user space tooling
to print it, but that's not sanitization. The tools will just skip over.

