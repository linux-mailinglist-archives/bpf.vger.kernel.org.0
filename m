Return-Path: <bpf+bounces-67892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5AFB502DF
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EABB1729CC
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446A345756;
	Tue,  9 Sep 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTh9naqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE325C804;
	Tue,  9 Sep 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436097; cv=none; b=X1PNzk8nbiW8jSleysrRZCXnDkKyPAfvzhR6Ja5DCMFHigva69SuSknCm5JGqsOTPu9XLUpAKXZVtz/VaqA5lQTfNtwY+HPJSNfOwiP4phhFpeflTitbxZbFO8/+twju1cPT260o3l/Uugvf1qw9JmUQpq/g5fSjVS0e/ypYfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436097; c=relaxed/simple;
	bh=eP2395iR6LTD6P+j2qY08RMQFUvP67xEBnbmJBWy2jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4I6TskYSiP5/AKrKtG0lLGICxexgtMuQVwUCTuchu+SUxu2bNTbo6ToMFr530JTIoyZjlG+/Zbtnb7rT59iXbG5VshU+3koMORXVC5L5eGP7TMLr9WfdGXpXCxT47CFOBGIj6CmxH1sN363LWKUxSti2gTprVA3JU/sW2O5mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTh9naqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B364C4CEFD;
	Tue,  9 Sep 2025 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757436096;
	bh=eP2395iR6LTD6P+j2qY08RMQFUvP67xEBnbmJBWy2jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RTh9naqWzL4iGW5Uq08ATjVx5pwBoPinLaZ0KbuqGfmCj6R6e/hWybgZkOzV7jxjb
	 1J4ndu/tYSGtED3gTgC9p6S9YsuzCFJc0bqyIPehqNFl3KBQ0n6a4nwfTc31FARdEu
	 slTxgdtlnc7/nTGmqLv+FascAlOdtXe0hJtsDFEzzhtjK/Z76KY2UYQ2F7tycYzZbR
	 2GIvySU+mq6ra04U4Vyf8tjyWoKQRtnZ8FRBHMtUe+IgnJOtt7/Rp5va49cXM0xKdS
	 xqLHAyRqkPEZmT+s7fsIOZSLb4FsglHwWIYU7JeYqxBYLSk2BiGe5Wh9oNxBQwXtzM
	 Z9ac94xMKKe2g==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-81076e81aabso443278785a.3;
        Tue, 09 Sep 2025 09:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGaE9PczkhxdipMxLmsKkExVYEOLhM5GggvZIX7ySlI7vW5MnIZkeA5RG+KJjZp+jj6tg=@vger.kernel.org, AJvYcCWNyHCgYD1ZVXB0W6htNxAtE2MiXzFxSpimNwpJBxjOjNCP3PB80QruOmB4QD9d+JpDdxJHZdFpO9Cq5b1e@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw69zBo3HuIH4hq7Jdg3aXOuvOjUJnvs9gaNkJ7pFWadQotwWh
	42SC2WnUQHFS4SkF4Ki0er4K5SjKQ+OFBqe9bYNv62bObpLiHDgu2EGiFHH197jGiONku3m3nbV
	+4NM7HRebtHoqLDnsq+Nb5rUEZvmThOY=
X-Google-Smtp-Source: AGHT+IEPk1Sca+QS/rz3tJPN7UIct+ex7GHpVpHsC9fji/b7lzWK3y1jtqwo18E6haiC557hhrBolqGwIiO2BPwVeoM=
X-Received: by 2002:a05:620a:1724:b0:80a:865b:41c6 with SMTP id
 af79cd13be357-813c2f05abbmr1314952685a.71.1757436095442; Tue, 09 Sep 2025
 09:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905134625.26531-1-contact@arnaud-lcm.com> <20250905134833.26791-1-contact@arnaud-lcm.com>
In-Reply-To: <20250905134833.26791-1-contact@arnaud-lcm.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 Sep 2025 12:41:22 -0400
X-Gmail-Original-Message-ID: <CAPhsuW7Kmi9Q0z=RgLjzr2=0t+4OLQ31o=H5ET5xhnQnykKCYQ@mail.gmail.com>
X-Gm-Features: Ac12FXzhjKUbTs2ag-PVulOGrpcOSb2PRJw42nqdB2yq565tdTID_mMq9HszNNE
Message-ID: <CAPhsuW7Kmi9Q0z=RgLjzr2=0t+4OLQ31o=H5ET5xhnQnykKCYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/3] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Arnaud lecomte <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:48=E2=80=AFAM Arnaud lecomte <contact@arnaud-lcm.c=
om> wrote:
>
> From: Arnaud Lecomte <contact@arnaud-lcm.com>
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid(=
)
> when copying stack trace data. The issue occurs when the perf trace
>  contains more stack entries than the stack map bucket can hold,
>  leading to an out-of-bounds write in the bucket's data array.
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc9b724fbb41cf2538b7b
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommoda=
te skip > 0")
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Song Liu <song@kernel.org>

With one nitpick below.

[...]
> @@ -390,15 +391,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_even=
t_data_kern *, ctx,
>                 return -EFAULT;
>
>         nr_kernel =3D count_kernel_ip(trace);
> +       elem_size =3D stack_map_data_size(map);
> +       __u64 nr =3D trace->nr; /* save original */

nit: I think all variable declarations should go to the beginning of
the {} block.
I am surprised ./scripts/checkpatch.pl doesn't complain this.

>
>         if (kernel) {
> -               __u64 nr =3D trace->nr;
> -
[...]

