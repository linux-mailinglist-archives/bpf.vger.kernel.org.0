Return-Path: <bpf+bounces-54493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E9A6AFF9
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FADB189FDAC
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE72288C0;
	Thu, 20 Mar 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAzxpqCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E522173C;
	Thu, 20 Mar 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506628; cv=none; b=vGwB5YN5CerywyAHB/eOdYDZj8YY+2q11494/fAbW2z9aZDFvppUwVpDW6GLhAF2fAIgJCZ3GIxl5IBWWrAol2oMcZ7aofknBgwKyypdqWRCM8SfjTFMJcRz/+fC3jJlF5mUTRpoGiSQdg7Xm9Y51GL3k1xwsSvrtjrO4mU5usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506628; c=relaxed/simple;
	bh=XPqhBfGmzZTbYMaMJAwYgvzvlfmm5uzFkjW2qJQZtF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gH1sWp9hjdoY1NC98Cvv93mElWiDpIXhdUtroF0dM1oLRNOmUhxXC6gIj9yXBnGRaKOL/FqarzuBjTjeA8sn+cF3lGegeEivmOmQEJ3aQlIJnDKk/v9zBorVjxSp1PVMfhkixFRAaRbYhqD6dZI5BrliCmDosgwlZfUo4JTO35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAzxpqCa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so24932455ad.1;
        Thu, 20 Mar 2025 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506625; x=1743111425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmb2lTor09Gg4fI4HiNRjvL8W8k7uFC5tOhRZbkcY9A=;
        b=AAzxpqCaLzKOu/AA+ptuK9hH50sasE6E3TOVP0epiotp38nHZaeePR70qS8lRN4y8o
         xEBLW6M3+rYP9+8XA5b00seNDXbQpP/zZAYTPYbizEvackAQogzX10d48Fift7akFDag
         oG3Kj6fhlXiiOojlYZTIDzkQnbQYOeyMcif7oS8pcn4g133I2Y1cqiDizoIQWGaYyI7O
         CLlbQ5ILnUffFs/S4a5z3NB6U0LMXwZ0g4IaGO4Oig75roHDgkqvEorqtanGdXRVdnhG
         YG/Z/m3eto6FdHxjuW3U3S40Rz4B+qPxkMlNN5GGAiVE42Tmnz1zMg86p2mwtsUzl1RG
         MIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506625; x=1743111425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmb2lTor09Gg4fI4HiNRjvL8W8k7uFC5tOhRZbkcY9A=;
        b=p/gdm7MUyF8m6+jgDNLTM60qYvzC1N0a4WXJWee9a8CL1F2tArLCayMTuovx1YF/3o
         qBM+Rg66w47KVbmGrcm6HtMhAgt+XB/uwDnOVW+iiJrHeuIQWoPxvcHjJSxC1Gi42VcJ
         CacuOtl/1g9p4PPmMT/ryNZQa/0S8rCH7eJZK3vgTWazrBBOLNRvtDYR8bdHJJLWdwUs
         hAhGHl0KIo6Fq1yMb3rzPzBgJQHsCw+TCbUQYKvzrg9DevNv+F5vhMW1nw2uyOFpoJNj
         b08jQQw7IuG331beXGCETqytWfMqUS/8YQAtZ5juCt3VFan5EWYM+dzm2VBfJ5rT3nMj
         SZlg==
X-Forwarded-Encrypted: i=1; AJvYcCW4xs5f1QS2o+wW3vYhO2jKlHOKhilbo0lXF1aKQogQPHPt0xe7eWKHh6/9N9RkVDilAxsgzsKjkVvQRzto@vger.kernel.org, AJvYcCXxft7TvTQhZuDPyC3YRdQgauhf9nwmoApJ7Zs93tRKn11Ce7/7okKtV1PjZ4Z22pz+IsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt97Dy47MM1HAPTjHVS1DmNphyZo5DbHf4Yu4AZW0Y/SEPy6o7
	WiJuTehj//v4Ft3fqyfLeJdRTs8zDeO8v0x1nO0MVJr8UJQX14izPYLLNPd3hvRrfepYCdghPHd
	Yzjwi91/nN69JJG3K6GvnM4mlBTk=
X-Gm-Gg: ASbGncu5XJSxF4H0HEQUqDTWhieQj6h3A3/zjhS389eUCkgA/RYsIssrbMl+vs8sVdt
	enuUlpGGriw8hFgNgrkqOUSv+o0uwY0/3kes46vMXG9hgm/f3/9oHClzZfpblmoO4uf3vrbiqPB
	jbzVZ+ASheMCoj3xq4LgZJHbr1fqt8Ux7QnGbjEN+B6A==
X-Google-Smtp-Source: AGHT+IEdQzByC1+w9M5hWLJHRRLVuRqWRxeHzftU0UAxfsK9LqoJUngm5qHU6RoGloA6vYQ8vc4Sbix1TIFFfh5toe0=
X-Received: by 2002:a17:902:f609:b0:220:c34c:5760 with SMTP id
 d9443c01a7336-22780e3b33bmr14238945ad.51.1742506624998; Thu, 20 Mar 2025
 14:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320175951.1265274-1-irogers@google.com>
In-Reply-To: <20250320175951.1265274-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Mar 2025 14:36:52 -0700
X-Gm-Features: AQ5f1Jr7Ti2TRlADtE7cgy9bRZtw9RX4jf8cROY9jqyiEM0dZ67HHO5Ba5LB9UQ
Message-ID: <CAEf4BzYPx-shzhex4CvE=P7bYBudU5GVMK1fNq6Azz=sfBXK3g@mail.gmail.com>
Subject: Re: [PATCH v1] libbpf: Add namespace for errstr making it libbpf_errstr
To: Ian Rogers <irogers@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:00=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> When statically linking symbols can be replaced with those from other
> statically linked libraries depending on the link order and the hoped
> for "multiple definition" error may not appear. To avoid conflicts it
> is good practice to namespace symbols, this change renames errstr to
> libbpf_errstr.
>
> Fixes: 1633a83bf993 ("libbpf: Introduce errstr() for stringifying errno")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> I feel like this patch shouldn't be strictly necessary, it turned out
> for a use-case it was and people who know better than me say the
> linker is working as intended. The conflicting errstr was from:
> https://sourceforge.net/projects/linuxquota/
> The fixes tag may not be strictly necessary.
> ---

sigh, I do like short errstr(). How about we avoid all this churn by
naming the function libbpf_errstr() as you did, but then also
defining:

#define errstr(err) libbpf_errstr(err)

and leaving all existing invocations as is

?

pw-bot: cr

>  tools/lib/bpf/btf.c        |  24 ++--
>  tools/lib/bpf/btf_dump.c   |   2 +-
>  tools/lib/bpf/elf.c        |   2 +-
>  tools/lib/bpf/features.c   |   6 +-
>  tools/lib/bpf/gen_loader.c |   2 +-
>  tools/lib/bpf/libbpf.c     | 228 +++++++++++++++++++------------------
>  tools/lib/bpf/linker.c     |  21 ++--
>  tools/lib/bpf/ringbuf.c    |  21 ++--
>  tools/lib/bpf/str_error.c  |   2 +-
>  tools/lib/bpf/str_error.h  |   4 +-
>  tools/lib/bpf/usdt.c       |  16 +--
>  11 files changed, 168 insertions(+), 160 deletions(-)
>

[...]

