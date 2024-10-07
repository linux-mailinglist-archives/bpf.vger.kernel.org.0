Return-Path: <bpf+bounces-41149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A40993521
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AA31F2405F
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86C1DD9AF;
	Mon,  7 Oct 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQBlea/K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994961DD89F;
	Mon,  7 Oct 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322617; cv=none; b=sluaSNgXImTc7+gdfe3Dn1PHIO50p4chHH9Ocpu6LANYgmCUOUQ9ewwCV0ElzdP7SJa+xlxwgY3wwdtMBqc1U3dcbBkYOQNksfN+bQG/zOtUUqk9V1zMtcaWILQUD5AjXund7tdpamGEKsP1m21TuCPEAEW78u34ytLOYCm1d6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322617; c=relaxed/simple;
	bh=VDVpINc5efQO9ZByGX+9ngmID7JbZWO6wKtc6Kj+cEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVXEYUaJcOv/Nd8LFnR53R0DrYfoHrtg+ZTsR27lWvitSUfCFQ7cv4BoOgrr/9Jf+oHH+eiw7XZD8n7z4EADQhUmAeoiVjE/+g4niEPZ7geDOo8rxfj8+YtcGqGkBaHBwPMLdtOmxC4Dtk5SQjI6xaRvgSDDcXLC+liGZglkLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQBlea/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE8C4CEC7;
	Mon,  7 Oct 2024 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728322617;
	bh=VDVpINc5efQO9ZByGX+9ngmID7JbZWO6wKtc6Kj+cEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TQBlea/KuvQAIUYsqAMPQrp+NcdZSYq1A+OZnblF9iXzms9APCj9HaWFrZt+4F+c/
	 nKhD95NNXYPwsLFsj6qm7JGscctgT+6pggOG4njhtpMscuyMf8So2yPQKj0vQU/t0i
	 sTOklSFjMgW7Ud2ctFK6rJgZg3aRKlFY/XIso+sVwzgBIl73jXMKd9CqsWfCO6zQwq
	 KRXcCcquxgtPVCU2q5aDSk1ojsmmT9znKXpZ/yCb9S8CTrsEnSnzWlKG4QmKaOljL6
	 6uE/xpDqXwXBjqyOhRejfdLebIB9d731ciIZ5d7ZBoWTD69x+uhdY4r2y9MzfG8+KV
	 tV/T6o6zNG09g==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a0c8b81b4eso19771715ab.0;
        Mon, 07 Oct 2024 10:36:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2zIA3Sl3RourRz2cXRkLz1wOMwlUgfzcn48oSg8x86Ohh8J02a9QamyeXhb6c5A+6i4gZbAqsm4yNxvVK@vger.kernel.org, AJvYcCUrSiFxPrb/mTwbAU5fbgDQzKd8LbfCsPUyT0f7RdAixcTk7Uc/U1XAteXrwtZpvwXEung=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzfKPpnGRgc/vhspir4/LrGBCL2+QGWEy2zg2CLi6vrA1lgNi
	IbTBsX+YtcGy3bT4YiCQC/czksumToc4ege2MFjMTwhsuxvPVWuADRjeD/j2pcdGupuunEigP5b
	61b24q+fKxFYQohI/G/mtR53qycw=
X-Google-Smtp-Source: AGHT+IGpkBSN4tRML84uJG24cEc1cHjRdvVPClMQv26CjceR4K5YTUVpij3ZJxdtzQiSgzZy+Z0LfFDQdC+1+o23BEw=
X-Received: by 2002:a05:6e02:1a23:b0:3a1:a619:203c with SMTP id
 e9e14a558f8ab-3a375be29bdmr126054715ab.23.1728322616783; Mon, 07 Oct 2024
 10:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007164648.20926-1-richard120310@gmail.com>
In-Reply-To: <20241007164648.20926-1-richard120310@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 7 Oct 2024 10:36:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7DHKZKbw3V5_=mxKNqnyhOWjdHWhGseESbOfS43tje=w@mail.gmail.com>
Message-ID: <CAPhsuW7DHKZKbw3V5_=mxKNqnyhOWjdHWhGseESbOfS43tje=w@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
To: I Hsin Cheng <richard120310@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 9:46=E2=80=AFAM I Hsin Cheng <richard120310@gmail.co=
m> wrote:
>
> Fix integer overflow issue discovered by coverity scan, where
> "bpf_program_fd()" might return a value less than zero. Assignment of
> "prog_fd" to "kern_data" will result in integer overflow in that case.

Has this been a real issue other than coverity scan? If so, we will need
a Fix tag.

Also, some logistics. Please be clear which tree this patch targets,
and tag the patches with "[PATCH bpf]" or "[PATCH bpf-next]".

> Do a pre-check after the program fd is returned, if it's negative we
> should ignore this program and move on, or maybe add some error handling
> mechanism here.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..95fb5e48e79e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8458,6 +8458,9 @@ static void bpf_map_prepare_vdata(const struct bpf_=
map *map)
>                         continue;
>
>                 prog_fd =3D bpf_program__fd(prog);
> +               if (prog_fd < 0)
> +                       continue;
> +

AFAICT, this only happens with non-NULL obj->gen_loader. So we can
achieve the same with something like:

diff --git i/tools/lib/bpf/libbpf.c w/tools/lib/bpf/libbpf.c
index 712b95e8891b..6756199a942f 100644
--- i/tools/lib/bpf/libbpf.c
+++ w/tools/lib/bpf/libbpf.c
@@ -8502,6 +8502,8 @@ static int bpf_object_prepare_struct_ops(struct
bpf_object *obj)
        struct bpf_map *map;
        int i;

+       if (obj->gen_loader)
+               return 0;
        for (i =3D 0; i < obj->nr_maps; i++) {
                map =3D &obj->maps[i];


Thanks,
Song

