Return-Path: <bpf+bounces-73741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57DC38422
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D065188E389
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD420223DE5;
	Wed,  5 Nov 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC6p5Eyl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0845255F22
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382764; cv=none; b=OgWRxVcwyIw7OaH0vT+dWHnYHRPC/3x68ocET+1MBANZwbX60AZ4cmI+08ILDxTKaetyEMqljlJtbzBLOlCPn8vZgWYV+zYUPs7FkduJigWl+tAXmeWfeLFi8Zw2XtaIuJRWqwjzDwcIb5S6b9zX5iPN8paHh63pHYM3DMnMTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382764; c=relaxed/simple;
	bh=kkDNyCXlipn1onJC4ich9C7JgWc17Nuo8XcxAWXvuiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc+isNc9pYCIJAVrgeCPXmjklZKBBnWL3oiivxbnWETHkx6g+dspCALWgH2Jkt0UCKIJ17hnzRPz1aPKqopYBfnZL8Hj15bcpCoGi6TANSL6YrlTeHKrL/94u1N4h8O/yvvffr3r7RukdKfRGjAImptj00I97SgRIAFcYty/0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC6p5Eyl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso2830335e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382760; x=1762987560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGoN6Q1FGu70kxgsHRXjo5ei8Lx6D1HeRQOhJHTTWhA=;
        b=eC6p5EylkYy/ZW4tzb0rWhTjt6g2gKWz8xUt6PQklcp5gBQO3jXukHiXs4wIJ5636R
         8swaxwTpj9Puxe0HijMP/L1p/k2w1gqVu/CLAVCuh6wJDJuhIns9meg6t8MwpzNqx6ol
         h6+bwAy+WXgfNVncowHZtUhiU9mVBBTP/uhWG/togNphF5Kv6ZYUwahAPDLIqLio+dji
         4DuyE9Fb6rWW+t8WJQ9Vir+jmE6XWxL/1yIByhMLE4VzLamnQOG3Vg4AxtIRKxo96CO1
         /KNutUp/2QLGZ7FLm+Ff9i+EYkiYl1ZgsZG1Wcr0+JPae7kmidRpPjYJ1dUA3wAnH3YC
         jbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382760; x=1762987560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGoN6Q1FGu70kxgsHRXjo5ei8Lx6D1HeRQOhJHTTWhA=;
        b=aKaJU5B+2tl4bso1amwT/VlVc78Zl6mHV8XgbtyXtl78LllPyIHI/JlmskmwtcC6dZ
         9a0uSYk4oorHFyDTgfyLFfAkHd3cJ6EyAO3D/rWalFvL7M8y+0x55jHKRwOa2/TnbhJH
         z3gSeboIOUid9YHYPHswZSdPwwGcxODI80UbvRvvNrA1nmYtYioOcHUHKbids/DWRuBO
         MkXGqiOkq6GAGzSlp6jlp5zqwTIk+Keu+9RxLVkwOuLZvCfOAsbf2LYMTlvMIxJ+qniL
         0TFbshuUn+ArgNUHU4Tr+WHeHzv8kBN6k+2vbCTgyrwn/z0T9GsFySTBwyX6ULITGKud
         MaNw==
X-Forwarded-Encrypted: i=1; AJvYcCUS3rJRYu54MiOBfZMmPAyWilDDoaxuJEGN7Ym0/Xlkii3rA2+lPkdj89LUAE2IA8kkUtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxg2nT2vW2WX/cmL6KJ0/T0nXXfWhv/acQO/X8e8YUK7qoGjPx
	cDYtqRJkXT2Z3TDu3tgZxAFoHbZ15/zjNn1cxO6mjevVET1n/3LKZvSuYe3bMJdJPlFdA1vOyxK
	Y3OLxg8mEloq4FHCIqYQgC7k0ChBxYmY=
X-Gm-Gg: ASbGnculQT2CFiFsyr+VNwSlHm7ZE1i8v0vEelSZAAYc93EL3y0DlKhGaGBoLvQU96w
	6yZerG6pH/QqIVDTwnJNI3qiZ1ifKAqlic6QdL0tj4hsnTP7zZzT/rDtmYnFKSoj3UshnF6lb4p
	fVvg9FQc3zCRHd0UOEGSXz0l3t7+OQqA25gyy+dMp3bZt8dpfVqrdcuK1rXvnFg3e4fr8N40DLK
	n+q308mdZpEZunGa9h4tAaBMHZ8WwQo7RwZbenhliYGtP/ohJU6JrclL60Fm6zeIInUGiIUqTNw
	ufqvBa4IL5xGVlxq+Q==
X-Google-Smtp-Source: AGHT+IGjDwvUOY1Pq7XzI4RZbgF4ynfBtF8HaZiltB+4JMI7wP597W0WnGnQWn4EsO9dJ3ITS0umhzfO5f/LQShhu9Y=
X-Received: by 2002:a05:6000:25c2:b0:429:cc1c:c1f with SMTP id
 ffacd0b85a97d-429e330bb48mr4108376f8f.48.1762382760149; Wed, 05 Nov 2025
 14:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
In-Reply-To: <20251105201415.227144-1-hoyeon.lee@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 14:45:48 -0800
X-Gm-Features: AWmQ_bkCpm1oQayiN7axXx7bpB29hzAn2IfljyRcTIPVqCsMzM4KtipvyswazdA
Message-ID: <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> The netif_receive_skb BPF program used in snprintf_btf test still uses
> a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> available and provides the same functionality.
>
> This commit refactors the test to use the bpf_strncmp helper, removing
> the redundant custom implementation.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tool=
s/testing/selftests/bpf/progs/netif_receive_skb.c
> index 9e067dcbf607..186b8c82b9e6 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -31,19 +31,6 @@ struct {
>         __type(value, char[STRSIZE]);
>  } strdata SEC(".maps");
>
> -static int __strncmp(const void *m1, const void *m2, size_t len)
> -{
> -       const unsigned char *s1 =3D m1;
> -       const unsigned char *s2 =3D m2;
> -       int i, delta =3D 0;
> -
> -       for (i =3D 0; i < len; i++) {
> -               delta =3D s1[i] - s2[i];
> -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> -                       break;
> -       }
> -       return delta;
> -}
>
>  #if __has_builtin(__builtin_btf_type_id)
>  #define        TEST_BTF(_str, _type, _flags, _expected, ...)            =
       \
> @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, si=
ze_t len)
>                                        &_ptr, sizeof(_ptr), _hflags);   \
>                 if (ret)                                                \
>                         break;                                          \
> -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSIZE);=
 \
> +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedval=
); \

Though it's equivalent, the point of the test is to be heavy
for the verifier with open coded __strncmp().

pw-bot: cr

