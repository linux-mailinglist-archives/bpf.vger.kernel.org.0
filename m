Return-Path: <bpf+bounces-34010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE192953C
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DA71F2141C
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4272376A;
	Sat,  6 Jul 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ciFeOX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BF35894;
	Sat,  6 Jul 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720300488; cv=none; b=J/mbjxTqI+NTO+I6i9jaUXZco8pfl1tKKcMLTQLhOvPnuEJ5M3kW//ZARLg71eu4WuPM0j2KgFtg+zE3l+GyzBqKwtt17KhM7qgDZpcWGv4kadsVtC+zF/pYuWgfIGdNY9Cr4lUXe6mUHe77+eUew903+OPc9n41kdNzP+TmMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720300488; c=relaxed/simple;
	bh=T68LY3ZK46oXESRr8snD0mb+a2ISCm04HVtKuzEHA24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+k3v7O6N8SI0rvRusAwPMNeBdharbtcfvGjfw69U42AT3O9g9WP2MrxgyMg5CkefXdNlWDrWhJ1g+OiEL0GKzWShpnIjWuI1O9FKtVxHyVM3xihHOa6A8x98qo72FAKJBy7B4+rHJQz9ttaJc0g1aFXhfwIyQ4NlCQ2OYifltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ciFeOX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso19262235e9.3;
        Sat, 06 Jul 2024 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720300485; x=1720905285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POhmUp8E3oBUvy6f+jxt/YmJGCNhAADS/KV7ScH1GbE=;
        b=V8ciFeOXxuuQ22mvXgLXET0Z1/1xmxUegfBjTNodVqoy/hR7L5V/YzQRd5UAfrdJcr
         mXzkOZqOoh8dA7ySAyFD2Qkpr/RFnGJ2nfz28swO7yQfM/+h6cOk6sIHKPb5tC9QEPfm
         SOZC667dDtziI8Np2Olg4xo4g5NZJNFEFdIPnjbwfrEGWnpgo9oqpLAK0eunbYkBl4f/
         PyJORkYNEbWiVc11KHm35fJznD89++f4B/I9SFMhhi9JRStHwvQLc6EV1oTQXT0y5S7F
         tvmmEx6Z1g34PwbvXiA2dkQ4EYM91muMLLbMq0NHUGRQykrKjdS3KiJWV0iw1W6MiLev
         akDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720300485; x=1720905285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POhmUp8E3oBUvy6f+jxt/YmJGCNhAADS/KV7ScH1GbE=;
        b=PhWD8CLFltX/ZJGIjtmePy01IWPhI+Lz4apTOyf0n6WXMXXPoVAmSEJiSq5bfrPs6v
         OOV2K0BMQNEujEoppWi+a4M3dOm/2wbbda66wzKJbXafqHffxpZYJpwUsvdxD/A6/4tM
         C8OAzN45a10lP+GjUyGBCsODh2154pgwy/V0a7psU0k+0ni8OKp+g8Wq7hGcHgqaO5XV
         2EwHxmk4fAT1v9JyJ+c5E4F+tcuT+irXbCWonoX7yxesDKjEMPh4qh2mVaCw+JaPf4vf
         DiLDA7gWduFXJOrZXDCVhwawpLBJPy9sh7m8JNt3PR9vkbYGZctjxeaY7iHuvfSTeON6
         1lgw==
X-Forwarded-Encrypted: i=1; AJvYcCXeKMcRkM4sDt/KQW/QdCDQGikoVA6YyvIP7rQvE+fg3Y7frFIiF5WSlCcV/dR4u7lQ+aZsTwFkPjWOC+dPU1CR+Zke4066F1Fj/P0tnAdph2luLdpbIeTxyxJcEQqb7XT2
X-Gm-Message-State: AOJu0YxMirTawAttFks8XpAl8uF8f6ME6ybJ2SQJ31KkKV4oSHf4RdBb
	Jbwxwn0sDOAujZC6ifLCPWvzHGq8/Srn4qOLfofLOrivewN6HzQz0YwcKtUPoCRXlkEmTPMSpcz
	Z3T94EVdf4adEIJ6272XAlpbl3To=
X-Google-Smtp-Source: AGHT+IEVJ73qKlhG/DYFfTj6BY1mZJeohC33cV3lh5LjvYGiCJc3iPXLZIsukT4Bjefa4Aiu8wVes1KMdMnQ+XUz+zE=
X-Received: by 2002:a05:600c:5394:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-4266320259fmr6752265e9.15.1720300485218; Sat, 06 Jul 2024
 14:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706051244.216737-3-thorsten.blum@toblux.com>
In-Reply-To: <20240706051244.216737-3-thorsten.blum@toblux.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Jul 2024 14:14:34 -0700
Message-ID: <CAADnVQLr7gpyCH5dRC56RO=zd8f9rL2ib4KKL3mVp+iPOs=rKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use max() instead of max_t()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 10:14=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
>
> Use max() instead of max_t(). The types are already compatible and don't
> need to be cast to u32 using max_t().
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 976cb258a0ed..f0a4f5c06b10 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -779,7 +779,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>
>         nbuckets =3D roundup_pow_of_two(num_possible_cpus());
>         /* Use at least 2 buckets, select_bucket() is undefined behavior =
with 1 bucket */
> -       nbuckets =3D max_t(u32, 2, nbuckets);
> +       nbuckets =3D max(2, nbuckets);

max_t is cleaner imo and u32 serves as documentation.
pw-bot: cr

