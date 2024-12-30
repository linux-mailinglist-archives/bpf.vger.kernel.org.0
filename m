Return-Path: <bpf+bounces-47717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C59FEB9C
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F31B3A1FAA
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9E19D093;
	Mon, 30 Dec 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBg1jkxn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CB18784A;
	Mon, 30 Dec 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735600551; cv=none; b=n1TaFUWzdcODX24kBnTEzzHzRvzIvM7DgBjDPY2ui5vbmrxkj4MmE9kZigQaduwuDrPjl17R/3Mem3uYV992h9AI9YnT3O52kvGzBPdEzD0/ChwKYaElPNd20bJMozk6dbiMwTmxM+9ax5Gf3SA6LPg9PZFYdURWwCBVPtgzpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735600551; c=relaxed/simple;
	bh=CQlByxdvJ16bZBF763isNVAKzq84Fz2fcK2RuTkpTmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4un0GNQYdT5Hssfy6YoscmNkribckckhZEu9vSrfbqxqQNmyOaZDMJG+2yBTM/8WLh3cr9jgczKtXXL/DL1NZ/4ZSzs9GUT29JRro/YpcHqbEG/uI5uPptuKYaM295wYI3US02cN9N1WDlJqYD/JpPrg6lLRfdns7/9meYF4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBg1jkxn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso65240055e9.0;
        Mon, 30 Dec 2024 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735600548; x=1736205348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v9HjCzt/OkoQsccdwlrfrtyCMddarfB9K+j5Dh/GYg=;
        b=LBg1jkxnaa5UuEyB5dgxS8iWlCNYd6r1oIQwcPMLcvtYdDuOJGj01hDWxkZ1od1kO2
         BnMuJphlkPNEIwSBRQCDH0DGzjmSSkMrMUhctZANygtsKrUqPUmZEkBJbsXBQzJbvvfB
         mEa2bKmA63Xwd7eXNryhApGDOE9L8Xt4VXyidd8KwkSDZF2X/uwHB7myWdElYvioXRrp
         dlUDiyVkOfsgV2Bog0iNjFU3OuPTUsblUzE3UjOOMubg4cOa8OHmGOcdIoHIwYvGm9XS
         KUwA9nycXan9ZjfnHGWCnie8zA0DM/iUKssI9X4Nrs6Fa0R/Gm/Op8k2b6nQq5N0nNoR
         Vjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735600548; x=1736205348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4v9HjCzt/OkoQsccdwlrfrtyCMddarfB9K+j5Dh/GYg=;
        b=mzjN/GhfpZi5dD5+x9ChrXTtiNnO0PLeDAJRRBr+Y9zdIgeJgHVE67pOb0QW7d1WA1
         LdqSCIGVvNyXBkD2w8kXJk7bsIdzQ+Ljzjh/5M5wrS4EuilT5GAZWYVAA7KDQPXXabyu
         PJmtSoniXR+XS9a3Sxaug1/WqN03AO48FjT9ZkTQsbzB1OENL9sHaUBYYY6w+8ViciY6
         K+1dHw9fqVJBamjLNn6JUI5rfE56cT5ttYEhBqh7FyOGTgvxZ1GF5+EbdxLNRI3Erq/C
         CoZLP+d0eJkAMsWTbB9OBzvNKjEUt234tz4S40mq3RxHNzES0Y8y88QSIcYLeR+htGBa
         iczg==
X-Forwarded-Encrypted: i=1; AJvYcCUhdfKzaYMEIm6I72JBxdDsQWiEQY6O6sqCnLlNK91xGF1spsj/sJfeFF8zelYlwTK6WsGVH0to0ByKrlw1@vger.kernel.org, AJvYcCVryO61CbXzNo0InLZcQh1w1OZhmbMfPMg9F5C7QrfCIBpPJktPAQy03OR0NRycMh7MtTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx445XTH4qgdz+BZy7aZeBBd44QhUrCQ/WRnvKkDaxpFh91jwAw
	8xCrWw4jQJAgUGrESGbqOfvSXoCNdcGHcmWvtK/KlliXkj7jk8HiZ354SIqr/gLi/QPOJHji7Dp
	Mc8pecQbxOoJE7R+e1xJ7om9ng3E=
X-Gm-Gg: ASbGnctCiJoDt/Sv8xxEz1vMkmy8SHCItI/oJQTSXijjkFeU4v6kHuz1Kk/aPdA7Y0B
	q2sHuKoCXwMq48HX1tIhHtIDi8T47vuNF5kexjPdSWizErPZ4ixvnQ8BbJSbr0mqniUnWKg==
X-Google-Smtp-Source: AGHT+IEcDAfmBPb7soWy71DmGhKhJZXIhy04vWhld159a+q6ruus1FIOWDMSdW656HIBElX0SBrSfjOV46C0rQRaxfI=
X-Received: by 2002:a05:600c:138d:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-43668643173mr332910175e9.12.1735600547638; Mon, 30 Dec 2024
 15:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <505ee6e414ee701c9ea899220154d1ec3a1f647f.1735595687.git.dxu@dxuuu.xyz>
In-Reply-To: <505ee6e414ee701c9ea899220154d1ec3a1f647f.1735595687.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 15:15:36 -0800
Message-ID: <CAADnVQLxotSL66rxfJpO0Khh1X4uFeytR7axLGVmkg1HL2FnNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: uapi: Document front truncation in bpf_d_path()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 1:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> bpf_d_path() will truncate the resolved path from the front if the
> provided buffer is too small. This is somewhat non-intuitive but makes
> sense when you think about it. So document it.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/uapi/linux/bpf.h       | 4 ++++
>  tools/include/uapi/linux/bpf.h | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b336371..91218c5fd207 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4845,6 +4845,10 @@ union bpf_attr {
>   *             including the trailing NUL character. On error, a negativ=
e
>   *             value.
>   *
> + *             If *buf* is too small, the resolved path is truncated fro=
m
> + *             the front and -ENAMETOOLONG is returned. The buffer is va=
lid
> + *             in this case.
> + *

I think this is overkill to add to uapi header.
Above is an implementation detail.
Highly unlikely at this point, but it may change.
While the above description in the uapi file may prompt unnecessary
concerns if/when implementation changes.
So let's leave it as-is.

