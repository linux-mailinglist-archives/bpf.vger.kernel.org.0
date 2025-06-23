Return-Path: <bpf+bounces-61303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B506AE4B31
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1885A7A885A
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C7299A87;
	Mon, 23 Jun 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbTltIqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38618B0F
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696950; cv=none; b=AZpp1Q6bsgY0zQqkRUBEHra3DUj4nVJeXUMeLXMRPicDIMU/PSKTY3cMsJRrbAqmhWvjDyNvZpSj9HcAxG89j9wHfBt0hYdvGLKONcOYOXsECXOWJSMV7o8ONG3vLSPRJOCwlGYWFPIhHag+V6YMMBhsBGjBX1Kj7w4VZJ5Bips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696950; c=relaxed/simple;
	bh=ZVoXDdNBnO0Dxr/1r8ydQ7TYVe3wAl1pyDMSXYqnV4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYzTlP6VfRtclWTtrb7IoMkCvcJk+rvt8E5YMiz7KyVrL2ShDD1ITo2VvCIaEtXVsKkaW9U29S7tLYWZaR6P8VbDMVude3q+iC3y+m/5R7JgrfHhkokhgEmW+rJtcEpF7nTEUI21OBLxcivyBU8X1ZZpLFoo+mql6G+AZ0U6gPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbTltIqW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453749af004so6801245e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750696947; x=1751301747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbvr/xfNole2Ge14nmOimkF1p88UU4sU59A5mx3YaSU=;
        b=JbTltIqWl/aIiq3q+BczMjydsCRtiDbl02MATZmtnageXkoygvqmYjeRg74aIof+iQ
         Z8y44dqka1LpL4oh3pXjeJpCMCS3CKsjWkUNHLmCHMtnnfr6rX8JGofxlaYBrSx9vLA+
         TIoGyhMRQqdvnFmv8xc2q5qunaWX/hN/rGB6CWdjaR3/G2xpo71PuvgWrJL/Yw+J5czv
         2C5uPUsSdm/92FSmhfErnYJBKGdiG/9vZGiuykiQqIsC5YV7SnTiB7O3K5Z7PZa6l63R
         9krI5byVyzuvr90O+uTXmupxirFeK4+CeTpqMydXNRn2X1U4Dwe7RtKMUSOCIqFyv48s
         duQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696947; x=1751301747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbvr/xfNole2Ge14nmOimkF1p88UU4sU59A5mx3YaSU=;
        b=us9xAXTLjKg24A1r4lRT/rA74uLAWbNrCRdNVU+UtX1EPycGMh4d/CXaVZp8TOgbwN
         SYTVFf/nDjRrO0tKrH1Rdk97C9MGcZ/8Fq0GPvwZtCinZm5uSJ4mLv2W5D9reRlMTH5a
         8fNXWeXJEIH3EJo1TltdakxwMRUTsksnkVy9iP8jHc0bQTm7vL7aRg6MdFp/xQ9Pgi8A
         VNLNeaQkmqvQqxLbAPzno6/7OqNNn0qJW+r9QYLKcQaFBKKQ+xVvU3BbzjSlrjbXKIWr
         Bu6Ubw03uRSazqMm4EXmYk2rhYcTorV02IkNJcXIWnxgyzAHmulEtYN00HnPB3Aih+pr
         yGkw==
X-Gm-Message-State: AOJu0Yyo4G1pb3/FsV6ZVxJ+ac3bwlWfNwmZ6BXrbqiHeM3ms/DjrB2I
	4daHS4iJCZ7tATvWAFADn008kdNe+23F7eMAMStZyVplRHjnXbfeXwcgH7MTFqdgZYSk8BIF9dB
	0E+vSfT6GzcRFmY1uFPLLb7nVX2rHcWk=
X-Gm-Gg: ASbGncvA1yxF2Pl/np57Q3ECYIUIjiVRdJshbJcL/ZV6IEX1+NPmejhyyBQvtFJ94MZ
	KQrxVr9o6NdswQDQAqj5hVF0yxphsbNCWfpg0Zlx3d+pj6qEqGXac3+sUWA2mK7FpSysb4DdYfr
	tsqqtzt7ZkrvBbQxBFYbVcpbo2QH/e+vYJoO6fj83feLl162WlY1E4ZNdkdvRwoiXLIVxoRw==
X-Google-Smtp-Source: AGHT+IEh87ZZdt8ov9E1tuDuO54083FzMb0cf7m+FDKgZ0Cmt9Z0R8q2CsDlMq+ogn9H8vzvPZVnvfODqUi1RaGL160=
X-Received: by 2002:a05:600c:1392:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-453658ba515mr127519035e9.17.1750696946845; Mon, 23 Jun 2025
 09:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750681829.git.vmalik@redhat.com> <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
In-Reply-To: <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Jun 2025 09:42:15 -0700
X-Gm-Features: Ac12FXxbQoq7fucMIvVXcbFU7mW0z3JSDE4-mKDKnGJ8vXr3IeKv8WRGl87gTTo
Message-ID: <CAADnVQKZfUOd62wc9wP7UtnxFfiJE+E_563PHU-n-f5esaOfFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/4] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:48=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> +/* Kfuncs for string operations.

Pls use normal kernel style comments instead of old networking.
That's what we prefer for all new code.

> + *
> + * Since strings are not necessarily %NUL-terminated, we cannot directly=
 call
> + * in-kernel implementations. Instead, we open-code the implementations =
using
> + * __get_kernel_nofault instead of plain dereference to make them safe.
> + */
> +
> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller

Here -1 and 1 return values are probably ok, since they match
traditional strcmp.

> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */

...

> +/**
> + * bpf_strnchr - Find a character in a length limited string
> + * @s__ign: The string to be searched
> + * @count: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and c=
an
> + * be searched for.
> + *
> + * Return:
> + * * >=3D0      - Index of the first occurrence of @c within @s__ign
> + * * %-1      - @c not found in the first @count characters of @s__ign
> + * * %-EFAULT - Cannot read @s__ign
> + * * %-E2BIG  - @s__ign is too large
> + * * %-ERANGE - @s__ign is outside of kernel address space
> + */

but here and in a few other places returning -1 is effectively
returning -EPERM for "not found".
Which is odd.
Maybe let's return -ENOENT instead ?

