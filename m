Return-Path: <bpf+bounces-43980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0089BC27B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE3284387
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2495E18EA2;
	Tue,  5 Nov 2024 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmbsisxs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D1CA4E
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769725; cv=none; b=Jq/Y63J+60A46CJouy6cx5lRaPNo0IBW595yOZ/0WkygIr+1DwxOyq56i7L9BJICdYJL4jgF29nCp++mzTMpIlIBmz0Ng3N7vgjPBVUqZmFSyD2mq5Ps2xdpCwE8G5M7c3/gMu2+ts1YpibSxjsFYhBfNrdAE9mYTcmrZskXnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769725; c=relaxed/simple;
	bh=i8XEmGgOmJOJP4DRGo3HkYCXrjvdwRK0ysnCxw3AIF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS+cvg7AiWcCF/vhZAbLYPgbi9QSKRyjqJNKwJ9BljVz/gDjgeO4047OaQHwQ6Ju5XdiOCH9qij231fsJXGnBMQNSor/+WGxaGxRfWyMmVoTlE+T9uzvvSpo+x7aFjDjLWG0EoG5LmDfo1QCsXP+Hu4lTsf73bRP511P9hDyBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmbsisxs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315abed18aso41041885e9.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 17:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730769722; x=1731374522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHvhowk5871ged3xu5pJLtQh2ob25VlEQoGJ4sZ8sBs=;
        b=nmbsisxswr2+u7Vyvw4JZ3uhViWMAgMsjQNeU3chd+AeqCzCHGqZ/p5Zf8YzFffMKq
         YWWNrXMx22GxL5O0BmsntcIpq2qxxV7PNsJg+RUNC/bKV/wvbUwWZunFedOQ0OofuJUG
         ilQm+a8X0q+VYFm+DLdydV+/kKJ+N6NJbq2gVgiPPH8rLvSrv2J9VTJ0r8wEPbpiRlVc
         /UsBUQtN2zq1ZcPqt+9yC9y59c/lNRNTUxQhq/VedX6tCbzzDUMYbywD7cSFzdOBv/bl
         3/c7qCi/UFYeNEd6OTOSHaMsfBuWWPjB3DzEimQAgst0lvk3eN7r6m0UIs7NLPHvx4DC
         QsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769722; x=1731374522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHvhowk5871ged3xu5pJLtQh2ob25VlEQoGJ4sZ8sBs=;
        b=eM0WxI/R07D0oZfCldoyPI/5F12b5h9UBbd+vGsAfiQsUtzk0MOFmYO/UHPi69SFLn
         rWquv3bAUubZ5mS6qg4WVnhNryFYenkQZzlhH5CTiFgv2BZBrhVDPJHMDQCncyO/Ncg0
         4FGbVulRIL09nj7pbofwCTRLVH5XVa8Cw4Z5Iw/IiKYbbuGGWIFZ0wDG2A7Wv9N1FQqt
         T2Dv/p08KpJGnftjNXkrpim5XhFLe96Uah2PTIcTcOswsM/b6vRWrEn03GjfMdIu28KI
         lxX3TGcDJH4FnZY2KxX+rlJU5GpQ09sspcSY9Oq/ie+HfA0WABDTrkAtS6/DcNje3jqG
         sDeg==
X-Gm-Message-State: AOJu0YzVkhWwJw9csnvNrKLTRo7ae+dtJtv6nEanRUY0hK5T4M0RXkHl
	3F97Ept3QCy9AEOzkp13+1JjcKKqT4rNmYUy+6GPwnfHlToNf/hR2QkpNZn+aMt96bKq86OKxO0
	cm0GT8hWdW79D1qQpYgXiHoK42OM=
X-Google-Smtp-Source: AGHT+IFQajNL+EAfJWW+ftbIX9cbI9QKriacJG0zT0luJGsUO4dPw08kqCUM+84rVHZiWj+FXHvVRwv0WEbc9FGeqng=
X-Received: by 2002:a05:600c:3583:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-4328328494dmr109169435e9.28.1730769722121; Mon, 04 Nov 2024
 17:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev> <20241104193505.3242662-1-yonghong.song@linux.dev>
In-Reply-To: <20241104193505.3242662-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 17:21:51 -0800
Message-ID: <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:35=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> The bpf_prog_check_recur() funciton is currently used by trampoline
> and tracing programs (also using trampoline) to check whether a
> particular prog supports recursion checking or not. The default case
> (non-trampoline progs) return true in the current implementation.
>
> Let us make the non-trampoline prog recursion check return false
> instead. It does not impact any existing use cases and allows the
> function to be used outside the trampoline context in the next patch.

Does not impact ?! But it does.
This patch removes recursion check from fentry progs.
This cannot be right.

pw-bot: cr

> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..ad887c68d3e1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -889,9 +889,8 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
>                 return prog->expected_attach_type !=3D BPF_TRACE_ITER;
>         case BPF_PROG_TYPE_STRUCT_OPS:
>         case BPF_PROG_TYPE_LSM:
> -               return false;
>         default:
> -               return true;
> +               return false;
>         }
>  }
>
> --
> 2.43.5
>

