Return-Path: <bpf+bounces-17830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97E813243
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E262824E6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AA5788F;
	Thu, 14 Dec 2023 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmBuY5sq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49912A
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:55:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c25973988so82832875e9.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562153; x=1703166953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ/H4h0v+ndVBNeMUZT5UjADC7Q0+Uq0HQxvs6V9X4c=;
        b=OmBuY5sqvDLfiEVsQADMtHGqBt9geZQvLyVFjwciYh/NOXorywKrtBOOtxF38hdNgG
         EyNrq9cc2DRru/qhJd96SjvvEtIR42iScmAWsuc0ay0maE5dzSLzfLjcxFBi33w70PaL
         STvbj9tdjq7qRrv5sxkGrHY9PenLtYbcszV7DsUg4tOrqjScWUiktk42L8RQYbunekIi
         c6IbMuhwSGVogR6ZrikY+HKsCs81c17tYTGpCkPTbXlj+pamHBN6h1TzXxmMBsfh1bqs
         TcECAPbixaYhztomjQ9Fi+6hUU8AggyssRKI2/y/idOv1SmH9CzKbzITW0oH+dh8fhAy
         Otjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562153; x=1703166953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ/H4h0v+ndVBNeMUZT5UjADC7Q0+Uq0HQxvs6V9X4c=;
        b=jGT8IxCxA05vjTG8cI+BI9tm0BPjDhJ4ADSF9fwaCdwUqkVc+av03UE5ysu84YeBpa
         pBMWtCErKad2dOY5/T5V408carQm6LRzg/z+57gl+pRnDizoBIU7+ERvPq6N1Qj07iqD
         WVMqHWtVIDNkwNxwcRUSatb5eddIQNQ6JhTVfk7xgkFg4I2xYNNoamug/rzXa7hVSikK
         q8uYCW+xUuRzolHc+/6HMttbKv4g8ghczn+px+s8rtusN2BpcyNhwMjNwceGlI/0ZhX+
         KuOHjqdAPrt5e+mEszaCq7lqzBWEvepf4a8xo+pWEF4EeCPy0PnvwotdrmDd2zlf4/0/
         QM5w==
X-Gm-Message-State: AOJu0YwrBwZCYybkvKuc74lh9kSVWXIYACwlLaHvnj6VwiNPOLXvm1nh
	FMXrXNJBpaP9n5/KgK9gaKmaaqam1GHM2oL2ezc=
X-Google-Smtp-Source: AGHT+IEjQ7rTuWGyrLdeLqd6km/y26E8OzFMqmm7ZpupApqfDHQn5d+S0m2SK0hZwqizSrKVo5b+OzLIkQPtRfJbBms=
X-Received: by 2002:a7b:ce0a:0:b0:40c:2a6c:8c57 with SMTP id
 m10-20020a7bce0a000000b0040c2a6c8c57mr5346526wmc.70.1702562152977; Thu, 14
 Dec 2023 05:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com> <657a9f1ea1ff4_48672208f0@john.notmuch>
 <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com>
In-Reply-To: <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 05:55:41 -0800
Message-ID: <CAADnVQK+C+9BVowRxESJhuH7BM+SWn2u_fTU2wjH0YuA-N9egw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: Hou Tao <houtao@huaweicloud.com>
Cc: John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, xingwei lee <xrivendell7@gmail.com>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:31=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 12/14/2023 2:22 PM, John Fastabend wrote:
> > Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> >> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> >> callbacks.
> >>
> >> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
> >> rcu-read-lock because array->ptrs must still be allocated. For
> >> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only requires
> >> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
> >> rcu_read_lock() during the invocation of htab_map_update_elem().
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/hashtab.c | 6 ++++++
> >>  kernel/bpf/syscall.c | 4 ----
> >>  2 files changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 5b9146fa825f..ec3bdcc6a3cf 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_map =
*map, struct file *map_file,
> >>      if (IS_ERR(ptr))
> >>              return PTR_ERR(ptr);
> >>
> >> +    /* The htab bucket lock is always held during update operations i=
n fd
> >> +     * htab map, and the following rcu_read_lock() is only used to av=
oid
> >> +     * the WARN_ON_ONCE in htab_map_update_elem().
> >> +     */
> >> +    rcu_read_lock();
> >>      ret =3D htab_map_update_elem(map, key, &ptr, map_flags);
> >> +    rcu_read_unlock();
> > Did we consider dropping the WARN_ON_ONCE in htab_map_update_elem()? It
> > looks like there are two ways to get to htab_map_update_elem() either
> > through a syscall and the path here (bpf_fd_htab_map_update_elem) or
> > through a BPF program calling, bpf_update_elem()? In the BPF_CALL
> > case bpf_map_update_elem() already has,
> >
> >    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held())
> >
> > The htab_map_update_elem() has an additional check for
> > rcu_read_lock_trace_held(), but not sure where this is coming from
> > at the moment. Can that be added to the BPF caller side if needed?
> >
> > Did I miss some caller path?
>
> No. But I think the main reason for the extra WARN in
> bpf_map_update_elem() is that bpf_map_update_elem() may be inlined by
> verifier in do_misc_fixups(), so the WARN_ON_ONCE in
> bpf_map_update_elem() will not be invoked ever. For
> rcu_read_lock_trace_held(), I have added the assertion in
> bpf_map_delete_elem() recently in commit 169410eba271 ("bpf: Check
> rcu_read_lock_trace_held() before calling bpf map helpers").

Yep.
We should probably remove WARN_ONs from
bpf_map_update_elem() and others in kernel/bpf/helpers.c
since they are inlined by the verifier with 99% probability
and the WARNs are never called even in DEBUG kernels.
And confusing developers. As this thread shows.

We can replace them with a comment that explains this inlining logic
and where the real WARNs are.

