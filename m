Return-Path: <bpf+bounces-15883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7D7F97E5
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 04:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A38280DE9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40F23CB;
	Mon, 27 Nov 2023 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRix5jOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A28C122
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 19:20:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-333030a6537so92500f8f.1
        for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 19:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055247; x=1701660047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cvaO8a/76V63navWwsFEM1FdiovegOD0QbvgCN6D9M=;
        b=IRix5jOm53SPOEB2gw4hb7bFktaNtz7enWcG88AXOnq3AB71krexUI1jnjeGdUZ3d/
         dOGn1liV4JvMHezVRwO5eT1a0pTCemE+hJqz+KXIwR3AZBgzhDdpUOVSnaZbgjwYLeSY
         ebRm/jDgOCgTTq1yd4GrAn0l2fjogBZuyGlLigJtgyTi7ydhnA+HIsD06hUN0rqkATEC
         3xhc7tgokzYatH6PWWHcuB8XgsR1auuu8IPdP/u26K8vKXxrOFGoTVJMW7tMEU9h/4dQ
         2b3Is0wQ+Qn+q+a/HwM3DHlxdwQgvtGNAIBs7FiF4q/aVWrVnGDs5vyc6juh4jJ1BzSF
         +NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055247; x=1701660047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cvaO8a/76V63navWwsFEM1FdiovegOD0QbvgCN6D9M=;
        b=DGbiJ61YARYYIa1EKGTDOCf9DbYA1AooP24WqqjM3f5yMmAjwuF57XA4M6UIRTOSkO
         v11teL71y1c7qUrXTTmPbrPHTjvMUkpDNlaFln5BHs2YCrVjj8QQXoHFNutLL0VtCVEP
         VDMN/Wg/hH/v0yL3xHVM6KdFFnjIfTAIg7pfgtyXU1LXGqJ3mQdkkDdrX3HPuoxyUv3a
         nwkHOtIke8QUdlfcMgZ0d7eF/eWa6vUmbrR9p7jJ81t2Xidsr2/6qcL9Uoo041trjnqd
         38Vo6LrmjVvuoNgc+Q4kbEMQDeZUSht05ktUVhc5FZrSZ6TfbkFekP6WF+lRlGmhsaA7
         +6WA==
X-Gm-Message-State: AOJu0Yx50IP0rBa9DYbxW10Y8zfhNrRH3CUFVmzfvjyvQqiZ818Fbm1Q
	Pk2ieVRsO90A8fdbTD4oed/WMseU8HJj9TeekGb0M7KyzaM=
X-Google-Smtp-Source: AGHT+IF3+yV5KAxFkA0TEuBnaZFH7bGqWO5nw0MFFfKQ6r9C3h42b4xAzNFYQ5YRRJ6BxPbtI4wq1G42t8+Pc7nNm5w=
X-Received: by 2002:a5d:42c6:0:b0:32f:8248:e00 with SMTP id
 t6-20020a5d42c6000000b0032f82480e00mr6525979wrr.51.1701055246669; Sun, 26 Nov
 2023 19:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124113033.503338-1-houtao@huaweicloud.com>
 <20231124113033.503338-5-houtao@huaweicloud.com> <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
 <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
In-Reply-To: <8609c9fc-5ca6-7884-2444-52a2d2650d74@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Nov 2023 19:20:35 -0800
Message-ID: <CAADnVQJ--ABTNboOPLUVH+Ae2Q5d-ii_4YEPxRGrB9mcP7FopQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 6:47=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
> Before posting v4,  do the following code-snippets match your suggestions=
 ?
>
> resolve_pseudo_ldimm64()
>                         if (env->prog->aux->sleepable)
>                                /* The max number of program is INT_MAX -
> 1, so atomic_t will be enough */
>                                 atomic_inc(&map->sleepable_refcnt);
>
> bpf_map_fd_put_ptr()
>         if (deferred) {
>                 if (atomic_read(&map->sleepable_refcnt))
>                         WRITE_ONCE(map->free_after_tt_rcu_gp, true);
>                 else
>                         WRITE_ONCE(map->free_after_rcu_gp, true);
>         }

Yes. That was an idea and I hope you see that in this form it's
much easier to understand, right?

and regarding your other question:

> Could we replace sleepable_refcnt by
> a bool (e.g, access_in_sleepable), so the check can be simplified further=
 ?

I think you're trying to optimize too soon.
How would that bool access_in_sleepable work?
Something needs to set it and the last sleepable to unset it.
You might need a refcnt to do that.

>
> bpf_map_put()
>                 if (READ_ONCE(map->free_after_tt_rcu_gp))
>                         call_rcu_tasks_trace(&map->rcu,
> bpf_map_free_mult_rcu_gp);
>                 else if (READ_ONCE(map->free_after_rcu_gp))
>                         call_rcu(&map->rcu, bpf_map_free_rcu_gp);
>                 else
>                         bpf_map_free_in_work(map);
>
> And are you OK with using call_rcu()/call_rcu_tasks_trace() instead of
> synchronize_rcu()/synchronize_rcu_mult() ?

Of course. Not sure what you meant by that.
bpf_map_put() cannot call sync_rcu.
Are you asking about doing queue_work first and then sync_rcu* inside?
I think it will not scale compared to call_rcu approach.

