Return-Path: <bpf+bounces-73081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0EC22923
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 23:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CF61A2872C
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95F533BBA1;
	Thu, 30 Oct 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUuXGCYc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C526D4CD
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863722; cv=none; b=eLyZBdo5ebCXqLDKtA3accwZfcWltbwDxmwtNYsiXmfF5ZjvJPY2WthUoUzmUmEac/Jrr+/URduySciruES0MAyw24vfCirWCFFn8zcVSZyBN39CAJV4lfULHTfaeVQR3KC0+SGa9oFKCM0ZYoK1nttmI8nEyewvQ0Ep1cfpY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863722; c=relaxed/simple;
	bh=zLn/caSgsK1UHkcN+BLUKD1qS2XUazFMSmih5z8SILk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEZiash+mYte/z+shbJIrQuawIUuMtYZAa+2Ev0XUD+drbVqa7wOOLF83gy/8Mu7x1v4LoH+BD0CJizrT2QJqwimWgo4ialXhrIPrShG5v16ykr8NvnlRyA/DnUJ/NpvMfqkqiq7WkQFDOKbpOq5HeVZtixu0b/zvk8vSK40EJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUuXGCYc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4298b49f103so645015f8f.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761863719; x=1762468519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2Kd7J+q6FDvOoPfI5A3gvP81dJS9CMda+auiDLSkyg=;
        b=BUuXGCYcE4eBqyC9jkeW7vWdpEl9d4X0rRBSWG8d6oUYV0QT1ScRn41N/JIUGiobp2
         BxV0x5nAuCpAomUGVE3hH5NprtqynDmsW7ZinbzrzZshdTppA3TPaNKJYzX+1a8Edc7O
         ZkutwTMy3xbC0EqiG34M4bQS8aFiKcfilAUzIRqAzGytcjKW2CUAeuJktbp7LL1xGUZG
         zf/7ZxF5OG6ApDD3B05NWecdi1KmQYJRvmQ6z3v1u755Jc14wWL6GfgjMXO7IEfcwvWY
         nSdI2KvDtrUITXpUDNGsKJ+QUo1DzmB1747a3cTq5mKLKznqAkPBpFxywEkxSF6300Oy
         /bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863719; x=1762468519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2Kd7J+q6FDvOoPfI5A3gvP81dJS9CMda+auiDLSkyg=;
        b=rLn67473WXVWb/2B9Ubuiv322hLV6n6FeO78lJcOGBQdeBKgz4yu4fGtq8DGMsWVVm
         z1bw12TLJSSmoviHEh99OejuPeKEqC4Prl6Y6lVNWpeQyO9hDcyPyzmik1m8ab6+qwig
         Ms58HnnoRhQDkllLONnyfY0j75t1QlN4M2nC8JlilBGIReeYU5ktNhhc8GC4EF+i9idR
         1ztzX5idcTO2b16kMjOhCAbghe2eRR0W0sTjizj/RNKbGl0Tpfw2RCim/51FznjUfVhf
         kiA0P98xit/TaXkA03tWpQdwd8O8ctYEmz5rfFkR9Axywoi1XKOHw1flUuE9gWMzW0oZ
         RX6w==
X-Gm-Message-State: AOJu0YzZTViZJJngi0SO2fpFzYKBZSyouAAghgLCz8e0tym6qbVqx/Nx
	0dcB7npX7/TAJv83IJrrwV3JgVHEjkszbR0vjEBYnaBhp8/kooobiXUFRVte6Ho7V2Mq9n/7W8o
	WVcCeFAvH90f76zS9Oxp0ixvtZchZ9/8=
X-Gm-Gg: ASbGncua5AfevYAOY3Vg8d6Jp16LcevPDvVPOCt9QCwP/SmnmA7jo6lmMKNM4jOUIPf
	ATIY9uFGcebyKJWg0++CP4Tb13o8iFnLT3OKh+a9X7toi0wesjjzxtg0eZD8M4eHOKe1kQMZnIP
	M9s49rk1DzIM0zXSSnVoGlW498wYSv0w47vVvBa2aTec1dqsQ2F1PP5Jkmc60VYwqpDNSmroH1M
	7zunK5DaLS1+N1L34Lk/1muxYRQSpZWB420GS7ExAhpUeUORgePPmy+ZOHQRMG5GdepNVGGWkSw
	m7RBiomxNdd1VS3ZbN3VCh6tSkrr
X-Google-Smtp-Source: AGHT+IHZCU0gTn2L+Kp3B9B3JGAYVk5CsdKbo+O31NvkyuOempOCQnQ6EAdMvfyCUL7LeYh5rvujR6k1Uu36Xz1gFFI=
X-Received: by 2002:a5d:588b:0:b0:429:a81a:a77b with SMTP id
 ffacd0b85a97d-429bd69d876mr969395f8f.31.1761863718764; Thu, 30 Oct 2025
 15:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030152451.62778-1-leon.hwang@linux.dev> <20251030152451.62778-4-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-4-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:35:07 -0700
X-Gm-Features: AWmQ_blKfB4pxXMdDnXXUorw9Ocz1_SHHY4LgAN_jPLmqmk4HBIDWWtoYD5-r84
Message-ID: <CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Free special fields when update
 local storage maps with BPF_F_LOCK
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When updating local storage maps with BPF_F_LOCK on the fast path, the
> special fields were not freed after being replaced. This could cause
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Similarly, on the other path, the old sdata's special fields were never
> freed when BPF_F_LOCK was specified, causing the same issue.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value_locked()' to properly release the old fields.
>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/bpf_local_storage.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index b931fbceb54da..9f447530f9564 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(o=
ld_sdata))) {
>                         copy_map_value_locked(&smap->map, old_sdata->data=
,
>                                               value, false);
> +                       bpf_obj_free_fields(smap->map.record, old_sdata->=
data);
>                         return old_sdata;
>                 }
>         }
> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>                                       false);
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }

Even with rqspinlock I feel this is a can of worms and
recursion issues.

I think it's better to disallow special fields and BPF_F_LOCK combination.
We already do that for uptr:
        if ((map_flags & BPF_F_LOCK) &&
btf_record_has_field(map->record, BPF_UPTR))
                return -EOPNOTSUPP;

let's do it for all special types.
So patches 2 and 3 will change to -EOPNOTSUPP.

pw-bot: cr

