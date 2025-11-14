Return-Path: <bpf+bounces-74591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C610FC5F8A0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6435E08F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4AE3002CF;
	Fri, 14 Nov 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVm2oloh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1735898
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160949; cv=none; b=cr8Zs8kUrVTjkTh9+d6l31/5q/KpQT3b7eiL2hUWsuibhIVccED9UmoOwRQEXzS+PPip0MeENnUZ33X8VUGWcKLGoMeavbIvi5XyoA/yXo/B4F4PUEa1RakXbpfzYtTnhcBuL14E63nplcAi9Umc5l47Y1XiWGcQBvRiODzFDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160949; c=relaxed/simple;
	bh=KkACgS12TKUmQelOlNlRMWWlyNN/JBooi4o/xClKnd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9LyFaFufr0HJNEdUx1i87+MzQrUNH9cpbGT3W6MDfjedd5ETvHcSYF8V1WtE/7PgATPOhl2cDNP+/nYu4WiP5BYDuUkG9o0lH27vbMfwlorv6pEX5KY4qnOPXFZJMl5+6l3zjilFIb6X9Yt3JPWqPYwZKuIjcjuhdjv9pkBwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVm2oloh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A28C19424
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160949;
	bh=KkACgS12TKUmQelOlNlRMWWlyNN/JBooi4o/xClKnd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVm2olohgHtMY/5vYMRLpJOo2RG0j0Z6ml0umYEbwNJJ6hHXlMQq7BPVvLHwO+0yi
	 NHSnEEaMMlM2Aonirza4V0HjyURqdBTRTpQUd19qVAUtGPh8uunWT94xj9WPkq3qMc
	 liAJyE/XN8e4n6ledSS/0fd2UCSW+TivxOUfgj1PngWvZ3cTeniUpzh9XXK50aqIud
	 zp3TxWYqXNnDpHVKvvHSPP7k2a+mA3/yAcO4dU4xzB/7CNYuGdZ9GmFypAsDE7voIz
	 HDJ4zA1j0Gc4ZGEuCSkSOYVLFZGtLNJ918WK/eqRBaKLt0ogTzAnNN453oN2fOkOLy
	 GpZcpYtJSmZyw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6014810fso20614737b3.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfoyijsVoKr8AmdruP5UTr30Ua9srHY8rFo+A7/2gBc54D3oYSOsxwiw0eEZl9obGNYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmevWEEZN2Fz2ww3IkqQLtIjkOzt14lUk3yUbgA1aPqG/AMsWc
	ePE8LKQJF5+LUJ0cMCr5jZz6YssmE2h582ogtvXvWfriSLc5mTBoabazHptTPGiY28P1crBjdh/
	TRaHAhws/Zflnr9C6bjSt5AMyHvV2A4Y=
X-Google-Smtp-Source: AGHT+IGzN/eraRTLrVuHY4zV23wzrA+o3xn7kigyI98n2yHnuPN0W2nJDHUxYEMcUAwa925HYsJVNft+f2pGymSG3c8=
X-Received: by 2002:a05:690e:c45:b0:63f:5785:a201 with SMTP id
 956f58d0204a3-641e74e13f6mr3944274d50.15.1763160948169; Fri, 14 Nov 2025
 14:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114222249.30122-1-alan.maguire@oracle.com> <20251114222249.30122-2-alan.maguire@oracle.com>
In-Reply-To: <20251114222249.30122-2-alan.maguire@oracle.com>
From: Song Liu <song@kernel.org>
Date: Fri, 14 Nov 2025 14:55:37 -0800
X-Gmail-Original-Message-ID: <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmc3Gs9GA6A3MIWrovd9fep-WHh6EOgJP-ewuF5fOyaaZbRoec4go-HCso
Message-ID: <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Allow bpftool to build with openssl
 < 3
To: Alan Maguire <alan.maguire@oracle.com>
Cc: qmo@kernel.org, kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 2:23=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> ERR_get_error_all()[1] is a openssl v3 API, so to make code
> compatible with openssl v1 utilize ERR_get_err_line_data
> instead.  Since openssl is already a build requirement for
> the kernel (minimum requirement openssl 1.0.0), this will
> allow bpftool to compile where opensslv3 is not available.
> Signing-related BPF selftests pass with openssl v1.
>
> [1] https://docs.openssl.org/3.4/man3/ERR_get_error/
>
> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/sign.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> index b34f74d210e9..f9b742f4bb10 100644
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
> @@ -28,6 +28,12 @@
>
>  #define OPEN_SSL_ERR_BUF_LEN 256
>
> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
> +#define ERR_get_error_all(file, line, func, data, flags) \
> +       ERR_get_error_line_data(file, line, data, flags)
> +#endif
> +

We have func=3DNULL in display_openssl_errors(). Shall we just use
ERR_get_error_line_data instead?

Thanks,
Song

>  static void display_openssl_errors(int l)
>  {
>         char buf[OPEN_SSL_ERR_BUF_LEN];
> --
> 2.43.5
>

