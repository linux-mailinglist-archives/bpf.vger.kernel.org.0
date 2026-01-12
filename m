Return-Path: <bpf+bounces-78601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87567D14545
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 462923159FE0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461236CDFA;
	Mon, 12 Jan 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="sdbnGh+o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD72DA755
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237973; cv=none; b=uwYQwATcFJZcqXATJDzKHFb1Xgrgi+VfGd3d1/rCaZV60xVaSKpvM4RuukbFIjZQXSfo2qnyEIke6CkL7qkn8XwNwVGlrAHG1JJ5AnoUOUoP4zMbZVcFTP4+RenKtu+3h9KdjKmNhFGpsxGAnXKdEkwDnqx2ugloJyMvfr9KohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237973; c=relaxed/simple;
	bh=zsqwsg3IcSN9fZzEB7cosl7nTk62MTfWBTOZOYUR0yM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=syWP7/TnxdzeLX9TrNqTlzsyfb1xItZLOfd6ZnmNn4jyAF7pxKmXJCPX4FsXL7F2BQErVdc5oFtHXGYVa/C6HB99Zi1RaQG5KOB7EXx3T13Gl1xwGWqt7/Qo5JkSJIEeU6GZBLOXdj7EM+zLsoPzwqQdWrjyCj2mVrP2jNtmjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=sdbnGh+o; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-888310b91c5so43163346d6.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768237970; x=1768842770; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqxbB6rfK3K32hpZeliEBtr/SIU1flU8yI2S6Aujj7s=;
        b=sdbnGh+oEGg4+L5D3E0J5AMoFBjq8VWIKq/rWu2dvyFL2FE9LkadaZR/agHsDeZLjb
         1rbCTY2qcEnMZaz8Vv5XZCznwU0v7JLxaAa6Ycfw71NHbolyLRzcR6Y3JNLsW9FBSbQp
         A28FKJ3XP/oXyNOyvG+EEbpVIV4NF53+UaHL086Vgn5jHndVLSSLIdg2fwwyWxypJhLZ
         oz5mT4hxiKV2XsnHDJfCEoj9bLQFxGlSNp4VPWI9VYBIYkyk5Bfe7HY+nScsx1ts89hv
         SnFQnN2MAXZ0YSitaZbK35D48M804Eh7NsJifcm39Ugf38any3AWjGsBxr7D+dybu5Ub
         SKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237970; x=1768842770;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqxbB6rfK3K32hpZeliEBtr/SIU1flU8yI2S6Aujj7s=;
        b=pmNoCfXnAJ2Fso/aLvMHqI1T/Qy5BhgKRJzs12mM78/ayZCLuQFRwsyaVGVVWi7M0b
         vXIGG2Vs6Q1AloAJCqFc6B6fK++3L7sxaAQTEA4QjRRXSxLKFS3gKWuEfgqwJ3tXjMJx
         NDkC6ByA5XpTMBZFB0aX9bEb7DnUYz9fInNrcIS47mIjPP6pOlUxNmA9+E+HeT9++kI8
         1mf55d+W8MKPqkEkO3C0jtIn3kqZGQHyoalShmSN71dpew/fmxGFZepvKXIL/jRiAqjy
         VZApF+XmqlzTbQcNR00gMyz+26sMzaOZjO5sNUOzWeZh8Ny9ippz4TeLP3xoG/KvrDuN
         VHzw==
X-Forwarded-Encrypted: i=1; AJvYcCUGroqvOteyoONxR9crp25GGDRsYK4EglwGCgw7TxigbSlaC3Dijy+rrfCwQJ3yx1O94cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOpRUEKil87MqzhOleuVJp9VF13lHNARpIld//GJHofrERI6l
	gvnz9Z/TcNUCIeTJtF05s8r9pgXlnM6G445gMN4yCSDPqj+y4oN4kYznkMJXpt7Wry8=
X-Gm-Gg: AY/fxX4Ly3p/8XHvFqrXmKiGYDYiudkLAREJsBSgpkLM15RZaPAVrXMcDIksqgwg+6Z
	bqktAg3voJRwS9IQyQrT2KvL4lwyc61rZBSqYMmz3zRd9eWjwU9FWeH2ffMaJ0vXwVig1RWq4Hf
	FprX1v/Z4EJ88P9zRRCR25bPpQixwcTtNmAytAVUJ3NkcnBiyAwxG8yANSDMQa3R7BzIJicBCEs
	HroBfazJDyxEXe83j/+NE6nF4BMYN85q75nJZdNCMHobOWfvMmDZ+Xl+IpYxhOqXscFs8WY0FaK
	4g1gxP4FJGDA9G/7rZDqT7Uhn5q3I53gGZxjmBT+Ijbt5m1vz/jP4aCrbgi42OCIFmzLYTfzh56
	RoI2xUVGkali1um18cl8WVZ7Q0qw63GDAu8ML3kuhQ509HGeN2EekfA8B1j9kymJH1rGNloEFU+
	QsZS4aP4m6LMKY/f81OhESBw==
X-Google-Smtp-Source: AGHT+IHo0M67ZyPzGd+HK/Odbr+TyIGA2gTBb1xZI7gfObwC6YaBgvRUoWssVqb+F8xOLKv5VcfVGw==
X-Received: by 2002:a0c:fe05:0:b0:888:4930:7987 with SMTP id 6a1803df08f44-8926622bfd4mr1408366d6.34.1768237970368;
        Mon, 12 Jan 2026 09:12:50 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077236f33sm142543106d6.32.2026.01.12.09.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Jan 2026 12:12:48 -0500
Message-Id: <DFMS1OCR2VM0.30PBICO8ECI9O@etsalapatis.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: insn array: return EACCES for
 incorrect map access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
 <20260111153047.8388-3-a.s.protopopov@gmail.com>
In-Reply-To: <20260111153047.8388-3-a.s.protopopov@gmail.com>

On Sun Jan 11, 2026 at 10:30 AM EST, Anton Protopopov wrote:
> The insn_array_map_direct_value_addr() function currently returns
> -EINVAL when the offset within the map is invalid. Change this to
> return -EACCES, so that it is consistent with similar boundary access
> checks in the verifier.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  kernel/bpf/bpf_insn_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 37b43102953e..c0286f25ca3c 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -123,7 +123,7 @@ static int insn_array_map_direct_value_addr(const str=
uct bpf_map *map, u64 *imm,
> =20
>  	if ((off % sizeof(long)) !=3D 0 ||
>  	    (off / sizeof(long)) >=3D map->max_entries)
> -		return -EINVAL;
> +		return -EACCES;

-EACCES is reasonable but the other .direct_valud_addr() methods use
-EINVAL (array) and -ERANGE (arena). If we're going for consistency
can we change them all to the same error code?

> =20
>  	/* from BPF's point of view, this map is a jump table */
>  	*imm =3D (unsigned long)insn_array->ips;


