Return-Path: <bpf+bounces-39179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D196FE0C
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AEF1C214D5
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BF15AAD3;
	Fri,  6 Sep 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa26X25e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDF158D96
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662159; cv=none; b=eZKOZYEyXyV/zTNB4UxuxQz1c1goGJgfiUyebbpomJUfXs1Qd4wg+JpeAC6pcnZr0ocyTKuVQxZjErpRDoSQ393SzLq0m8vUGq/PrTJP6zfbRDrqkF1aDQXe5lA+2FDEjsh5c61MC8Jw13IdoOumpwNiIS9vjIgaYJdKtjNH+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662159; c=relaxed/simple;
	bh=CWS16iPX9yJdtHOGflq4YsmxlCvwubRt6NLn4BRjYzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7/Ud5dyjb5ZKASoWZpxN6YIntQeSIphTK/wIBU+XtmmXYnxdcQr+jQKCQ4NKc5MfcvQhjOheSyNE0xlUpBR9vl4CiHRj6nfjmL3PQYswe03KiI1kaO4ccRs0vNar8VUp6letiGlJ/FVSLqQfkizFsRorQakBcAU684I5hPmHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa26X25e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso26146265e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725662156; x=1726266956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlrEFfoC7bnS4it+rvIseyYMKBX1n9X/CB6UuDoAflQ=;
        b=Fa26X25eEz6LPH4pFkeUduu/gbTrLHK7YP4GSlJK9wWV5wU2OECbW2bmYFc36Vu+iK
         BT49lbldsxPLt0iXD5gKeJ7oee+wojeclAndmDLfxbI4KnA5Vnx10WFI1qGcwksbNn7W
         dI1ZjK6xAPAebLebBhavUoXBCLEd8F6Hak/fDj9h3PVHX6atJFEmOikncgqGfZO1vBs7
         G2V7SODrp9th8BZRoFOz4cxgp91BX6heGvWyW150BEW1nByEKsh2LfJs3nmENf6frGul
         qG8l/xAgVfxFHYW3jfrLcceiVamRy/SMwzd2Fp6aKYiyT5JPVDY/4Ie0LXhR8kuh1nd4
         suUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662156; x=1726266956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlrEFfoC7bnS4it+rvIseyYMKBX1n9X/CB6UuDoAflQ=;
        b=YCiggDVk72dz3bg+b+E0lqUF65RgjhZ6zsEMxWk7bCpHstNGkqoiaKY/4uMCMSx62d
         oIp67kF0TJRtkttIKUP+rNfsZ2UiHErR1WSScuTqrYCGFhJZJUa9pQFd+r0KLqjN80M9
         qCtZExCB3GVeZ3eBv4tBdw5QzC2mfiKM8WYQSeXjuv5dONnVCe+HQtQYo+gNv0TADp/N
         GN4B6EdrzmWvHRYLcgYfod198WDiMR7R5bjw2J923dUqdl83gwFXUltcMcfnXRW9zvFl
         Wp8u8sPiC6biWcpLDnd00rXILSxkFy2Jr6CGLxqZeEg+Yn2LiXSyPazyEqJvKeANi57J
         Q5wQ==
X-Gm-Message-State: AOJu0YyxFma+2NTDjXP7YmNDuZg3fs4FKuPQeB/ApsFFRbR7azPjuOO8
	GG435YL2bRsWSfjNJ60X6BEzSqzDA8HAHEtOXlFYIIn/7hAVW4FEkJfjdwgC7pzKRJGQDrNy4Ib
	pM8JjN/OcqbjNeTnuhzoCf7Ga5P8=
X-Google-Smtp-Source: AGHT+IEE1Cvx1mg50kCBvSgc9Sb50NcsHfZTVhH+k4hfBhYrCKZom+POUdAgzhN6VCB5FbND1y9jmtj3s0UOQOo8AWw=
X-Received: by 2002:adf:cc91:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-3789243fb15mr474039f8f.39.1725662155338; Fri, 06 Sep 2024
 15:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-5-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-5-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 15:35:43 -0700
Message-ID: <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
> -               return -EINVAL;
> -
> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len))=
)) {
> +               *mtu_len =3D 0;
>                 return -EINVAL;
> +       }
>
>         dev =3D __dev_via_ifindex(dev, ifindex);
> -       if (unlikely(!dev))
> +       if (unlikely(!dev)) {
> +               *mtu_len =3D 0;
>                 return -ENODEV;
> +       }

I don't understand this mtu_len clearing.

My earlier comment was that mtu is in&out argument.
The program has to set it to something. It cannot be uninit.
So zeroing it on error looks very odd.

In that sense the patch 3 looks wrong. Instead of:

@@ -6346,7 +6346,9 @@ static const struct bpf_func_proto
bpf_skb_check_mtu_proto =3D {
        .ret_type       =3D RET_INTEGER,
        .arg1_type      =3D ARG_PTR_TO_CTX,
        .arg2_type      =3D ARG_ANYTHING,
-       .arg3_type      =3D ARG_PTR_TO_INT,
+       .arg3_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
+                         MEM_UNINIT | MEM_ALIGNED,
+       .arg3_size      =3D sizeof(u32),

MEM_UNINIT should be removed, because
bpf_xdp_check_mtu, bpf_skb_check_mtu will read it.

If there is a program out there that calls this helper without
initializing mtu_len it will be rejected after we fix it,
but I think that's a good thing.
Passing random mtu_len and let helper do:

skb_len =3D *mtu_len ? *mtu_len + dev->hard_header_len : skb->len;

is just bad.


pw-bot: cr

