Return-Path: <bpf+bounces-49550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704AAA19BC8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 01:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D49B3A8798
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B2AD31;
	Thu, 23 Jan 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aagVpeE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12B8BF8;
	Thu, 23 Jan 2025 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592190; cv=none; b=V/fgnXiW0r+rMK6ImbPI7YLNHFgT0bo7OVRgNBWQ8FyNdc3C/JiJCYjb5YxP+YKoYwM06WWt62f0qKm862JyC9y4jfzF5IuZ+6ryULE7CBuYZPRlzmY1+3cxjN8tWxRlZ0xpF8OcrGol7ZjuWpphmpr6CvESC1XteEjA540V3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592190; c=relaxed/simple;
	bh=b8zm+y8kEriQePfvD56B0nHNYKUjbIeQf5ZwlufSFMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esSPZxoJZ0gK0+p40dar/JDX/bf8ErXflo5ERySTNQCtGBezEWYfDH8hmepHzI2lOwL/llEz6GpJeFti1U894kWAIn2nR6EDJWQxP+HDD/BzXd4e4CEFiaL20D2VfzseSJ8IExyG5AYViEI46Sd7A308q9vF2Sm8VT1bqpz/mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aagVpeE9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43622267b2eso3338785e9.0;
        Wed, 22 Jan 2025 16:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737592187; x=1738196987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqMq3rk8LAv4NWlF/rIgW8PmsqPjzvs+YfG3tHjJzJs=;
        b=aagVpeE9qCwuNAnfPf6+sTennYvuJe4gebx6akxIZiHuKthsPqqOQb6L1bN/9YcPI8
         k32OUF7mqzcy74ACs2CzJRrEWreXSVR9M/xS6X1WXO0cM6XDXm2QyJQ7EsjIQISbbz+l
         r5JUF0jXIontspB9ZIjveRY9Ws0QKScPE6c0GRW5cQYJjqafsLLnSZwSlaFuDEFr7B7W
         u1OzJ0DhO+nKNXBQGEr9NbVXv2cjx6vaHcrWW9GjR2Etq4ZVz2Yxlw+qtkRzXM4boFz8
         aGAyFr806nKqkF86UM4sbbu5+W89wK6PrrnSs8ECY8AYL3qXbq8t44nVwQ24xt9Elj/W
         plyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737592187; x=1738196987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqMq3rk8LAv4NWlF/rIgW8PmsqPjzvs+YfG3tHjJzJs=;
        b=HHlL5MV7Pks23LsQVqlhgOrd+WIJKQIuWzkQNfUC9yRGutBUcNulrXoaTs7R6HZmVt
         02ZTfD2Wib2Jl1WN9Bw8BZ8dyKscEIk5NmwMGiHUroPSLXlasPnSYAr4OUre7zmzh4C5
         6KRK1LgjhONQY8rb3SChHgjqb3j9FlJd9r3iCEUuNFUY7na0hMJepLPRkUCVzSW2K9Vw
         m7xWzFDxAs9C1P7GOtqNVVq/lolB0s7+pmhpFi+t+HUJuKlmq/o9nCoFU5uLTziq1Mkt
         7Khjp29ZnMfphJYMSYpKBOHZlTJy0WQzuNVEYd38FSufaw/911ELxrWtydpCGPnC+7IG
         pZnA==
X-Forwarded-Encrypted: i=1; AJvYcCVnKUrELV/Zy6hYQSxWgKc/XGO+bZ+feXUkzP4RzWRZOyiSWwUDT7j+qh5je5lB8zlagh/aiUkM@vger.kernel.org, AJvYcCWTqC75BheNiFojWqt4ZzHilaTnF79jw2k/UvlJ1oQE4EOfGNdFgAXIC8h17nd+RvYgZEkLXpqcSbQWBjzj@vger.kernel.org, AJvYcCXmnovLytBpeBQowRjMacibXJANVirda9fGO4aEIDMCoMwkglSIJ6ZhpGKrxlTeqvTjmGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mX4xubBlnYaZVscYOmk9vSFKjwo6k+arvWWXQ+xHyb7VmZjv
	TaX6Fx2xBtjwWjFfssH57akfftpOjQXIzPU4beD9VOqHDueh9gxdbFAXLEgPgswIaljd2atzmWE
	XPsXc5WZt30p5XR/Hp03dkRDIB3I=
X-Gm-Gg: ASbGncs7ZzWb0eQ3JSskWxxTycLejEhk4CRA58NEsjl8ZlfogfBMsVLLG7Kd+gYoO/U
	Dtuf6FRblYKcBoje3UD63eZHubX4VaWai/KHRNlnj+qJwaxo6H2OHZIab7Kx727rJubu3r2fFMU
	8Kbi3ZPls=
X-Google-Smtp-Source: AGHT+IHYNodHiGpmK3Vs244K1buAYV1GG2229vuGCmhgyK/AWasRZCkcsisNbbVT1Inqobj9CnwDXeWUUNPnXX7pNlM=
X-Received: by 2002:a05:6000:1ace:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-38bf5678239mr19993264f8f.7.1737592186688; Wed, 22 Jan 2025
 16:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737433945.git.dxu@dxuuu.xyz> <2050196010b1bf1efa357cfddebd15a152582bb4.1737433945.git.dxu@dxuuu.xyz>
In-Reply-To: <2050196010b1bf1efa357cfddebd15a152582bb4.1737433945.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jan 2025 16:29:35 -0800
X-Gm-Features: AWEUYZmMcOAe0ZW4uSlBfaznTC1C-BAguyt6dp3FH8nHUI1jGRRe4CBZ8Jr4LV4
Message-ID: <CAADnVQJcJz9stNyjck4AukQ_T=DJcFszp_cH0r_spju_Oxd5ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: map: Thread null elision metadata to map_gen_lookup
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:35=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add an extra parameter to map_gen_lookup callback so that if the lookup
> is known to be inbounds, the bounds check can be omitted.
>
> The next commit will take advantage of this new information.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/arraymap.c | 11 ++++++++---
>  kernel/bpf/hashtab.c  | 14 ++++++++++----
>  kernel/bpf/verifier.c |  2 +-
>  net/xdp/xskmap.c      |  4 +++-
>  5 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index feda0ce90f5a..da8b420095c9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -117,7 +117,7 @@ struct bpf_map_ops {
>          * may manipulate it, exists.
>          */
>         void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_=
defer);
> -       int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_=
buf);
> +       int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_=
buf, bool inbounds);

The next time around we'd need another bool and more churn.
Let's use 'enum map_gen_flags flags' right away.

Also don't you want to pass an actual const_map_key
since its already known?
And the whole array_map_gen_lookup will become
single ld_imm64 insn.

