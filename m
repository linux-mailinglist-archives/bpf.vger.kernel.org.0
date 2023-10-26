Return-Path: <bpf+bounces-13344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9E7D87DD
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCD1C20F72
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79138FB8;
	Thu, 26 Oct 2023 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1Zu5Il/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941663717D
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 17:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8DDC43397
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698342950;
	bh=Bl2gzQiLurbyQucsAi4gAtaeIh39hZARAQDCkGEhtpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p1Zu5Il/6dHEkTN8BdVz2GSwx0v+TA/jW183YlIQlwnrexYuvwAZUNcxtJMBDOsvU
	 nBbYx/qbTDPxyzAHYkPaKGw8X7flX78uMsQaD5p7nWmiQi2IzxTdQ1DSMvEChLCoWn
	 C3+qoqakcHyM30UD6GmAnz0gLQSMEiZUCzZlqAhJk1Ir/AThVQ7jsk3pjgIg0y664I
	 +VJVHXZTm48qUUnH6C39J6Mw/rygeTjfC8V1cF0nV3DJQNjIiIxBBGjlXcShvBOKmW
	 Oa+Vql2msGWIGzMm2oulWzt0QUxMhEbQ09tDb9cdTrNLIzYCHNiQ36G++qG5SqXi/w
	 EpzGB6UvSj1LQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so1660337e87.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 10:55:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy83vOBIl2GlLdeyhgYBGCzf2gwTEeKE6tXwDR9UeO2+yxK3fVv
	35QSDik71bc2qTPHpzKwiTtn79j+11Nm/3w6ZOs=
X-Google-Smtp-Source: AGHT+IF2zrYl4NpHm0UBn7HxwQT/23mC1BK2DbZ3jYfylna+um+Zs/Vl3ki72DEiMMjvJsBRAknC99QQpQ8cQIbeAh4=
X-Received: by 2002:a05:6512:709:b0:500:ac0b:8d58 with SMTP id
 b9-20020a056512070900b00500ac0b8d58mr94940lfs.18.1698342948247; Thu, 26 Oct
 2023 10:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-4-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 10:55:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>
Message-ID: <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
[...]
>                         __u64 missed;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 path;
> +                       __aligned_u64 offsets;
> +                       __aligned_u64 ref_ctr_offsets;
> +                       __aligned_u64 cookies;
> +                       __u32 path_max; /* in/out: uprobe_multi path size=
 */

I don't think we use path_max for output. Did I miss something?

> +                       __u32 count;    /* in/out: uprobe_multi offsets/r=
ef_ctr_offsets/cookies count */
> +                       __u32 flags;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;

[...]

> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +       info->uprobe_multi.count =3D umulti_link->cnt;
> +       info->uprobe_multi.flags =3D umulti_link->flags;
> +       info->uprobe_multi.pid =3D umulti_link->task ?
> +                                task_pid_nr(umulti_link->task) : (u32) -=
1;

I think we can just use 0 here (instead of (u32)-1)?

> +
> +       if (upath) {

nit: we are only using buf and p in this {}. It is cleaner to define them h=
ere.

> +               if (upath_max > PATH_MAX)
> +                       return -E2BIG;

I don't think we need to fail here. How about we simply do

   upath_max =3D min_ut(u32, upath_max, PATH_MAX);

> +               buf =3D kmalloc(upath_max, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +               p =3D d_path(&umulti_link->path, buf, upath_max);
> +               if (IS_ERR(p)) {
> +                       kfree(buf);
> +                       return -ENOSPC;
> +               }
> +               left =3D copy_to_user(upath, p, buf + upath_max - p);
> +               kfree(buf);
> +               if (left)
> +                       return -EFAULT;
> +       }
> +
> +       if (!uoffsets)
> +               return 0;
> +
> +       if (ucount < umulti_link->cnt)
> +               err =3D -ENOSPC;
> +       else
> +               ucount =3D umulti_link->cnt;
> +
> +       for (i =3D 0; i < ucount; i++) {
> +               if (put_user(umulti_link->uprobes[i].offset, uoffsets + i=
))
> +                       return -EFAULT;
> +               if (uref_ctr_offsets &&
> +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, uref=
_ctr_offsets + i))
> +                       return -EFAULT;
> +               if (ucookies &&
> +                   put_user(umulti_link->uprobes[i].cookie, ucookies + i=
))
> +                       return -EFAULT;

It feels expensive to put_user() 3x in a loop. Maybe we need a new struct
with offset, ref_ctr_offset, and cookie?

Thanks,
Song

> +       }
> +
> +       return err;
> +}
> +

