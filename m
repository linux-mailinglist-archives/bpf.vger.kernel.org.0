Return-Path: <bpf+bounces-34928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B6D933270
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 21:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0417AB216A3
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8B3B29D;
	Tue, 16 Jul 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXojsQVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2C4687
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159403; cv=none; b=c1nCgzhXgtUtbWyYqCLFCqssk7I6vrLjWom4JETUqYZ10gLzsbpdB6/47GmDuIIK2URr5TiPnRCgSitvaKAbBMRXCwJDlz9SabrlYnTaGG20CBvHBtM+bQmhb8Sq+xnMcyQ1ekzYruJ8QWp2HhipHGW6emKi5fnT9mpC1Qja87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159403; c=relaxed/simple;
	bh=nXdlj0bQiin9AHXoyvPxdatFtop8PBDZuD+F6jT5rfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbIiwXIZFcgO0yuMsQN43gp+SnqdoEAaUYoaaHFdC6aWRRA0Rh81aVAKm50BkURv+CYR+qUQusg598kJtsbvIAQ1ciXuhvRjRUxMeqmps4RiZIJD7x/PI1oS0yhhNk/mpqtLYJr7uS/lM4i1lEyaKYmlMlMj+sWU9jmUqFpw6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXojsQVm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b0ebd1ef9so3926693b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721159402; x=1721764202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zablLdaMN3Mov7IjTsK2hgTZVMGKngsF2sm/DVi9vqU=;
        b=EXojsQVmATBQ/F8zL1UeAQssUbukv3iCk9Cw2XKkhFLrW0vFSA208/X1+MbuVI2mTR
         ag9mTCbFtCUEaFd8DfVnVwUJ6uxziP3Wxcqc1S3Bt7KAi1tuqTmmudpdwfuPgRw96Hr9
         mIk2a92A2j5PT6vP7e3UDVyyY7r+Z/SiSoDrq9Ff0GCqNdl9+z1SPQmNVXQ5IvZE97XP
         UfJ/9vxPwJMT95bhnE/atFk8QvJTPcmWav2wB9aGl5sosTQaSkrqOy6gH/z98zS9mwYE
         4ogDzIWXFmpqe7faDSoyOWedkVCoZBZKBKkMG2LTfeny/Jsr4UvTLoCA4nyxHfEAzLwU
         vEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159402; x=1721764202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zablLdaMN3Mov7IjTsK2hgTZVMGKngsF2sm/DVi9vqU=;
        b=s8+gSriiU0Q3GRQ2d0RMKBxSE6CkMWjDnHUsJY7gquzScQNj806pF9N0jZUQ4Wbjlv
         34O96wSafwKao8pI6zPEWJnobYYAtv9cW3EsUJkASwwN1Yc0H6nxnek0kylyFi9jiDG7
         BlVZWOAQvhCfWXohYxgScK0MC7sW1HBfyjBBmPjxOvarexkG5gyVO4CZ6CLexSVrCIVl
         WF00R7jQhvkcMmuyNGaFPvQ5C0Mo7vJZMp0YDD+IGlebm3kSpzfGKGayARL4rtV3Ij7M
         6OLDkFPzG1GECheMQgJhB4pqLEzY86+M8fx+x8VAWsfeSGmSkC4QtHdVtiu/6QExAi/V
         /IWw==
X-Forwarded-Encrypted: i=1; AJvYcCWQtV3m7b7R6n/gpE+7BtYpt8jYwJ98Y9JX27k3lY+yPUvpkpz6qH8N24r/ZrgN7QBfT6AeQ3oLQRabKeomT2w3QZpq
X-Gm-Message-State: AOJu0YwE5Ei+Am+ojO3BpJbSjPwPYDgw4RVxnMA2R+V/4cq3GeKX3m5y
	OexxyzkfOu7l1fpCAipXeHAZ3PeP1l1P1+JX4M+c5t0ac+/s1bhc
X-Google-Smtp-Source: AGHT+IFllfavHnAR5ZMxuTlFuOA0ECSqe6KNMATPtVnSopHLFdH2smbAHhhxTAkFFhHoKb44vwJ7+w==
X-Received: by 2002:a05:6a00:1813:b0:706:6bf8:bd2 with SMTP id d2e1a72fcca58-70c2e9bad36mr4620403b3a.21.1721159401650;
        Tue, 16 Jul 2024 12:50:01 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9ded7sm6743359b3a.7.2024.07.16.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:50:01 -0700 (PDT)
Message-ID: <593057cafca45b6c11a7aed7b459a2b0677d4f0d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fail verification for sign-extension
 of packet data/data_end/data_meta
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, 
 syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
Date: Tue, 16 Jul 2024 12:49:56 -0700
In-Reply-To: <20240715201828.3235796-1-yonghong.song@linux.dev>
References: <20240715201828.3235796-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 13:18 -0700, Yonghong Song wrote:
> syzbot reported a kernel crash due to
>   commit 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses").
> The reason is due to sign-extension of 32-bit load for
> packet data/data_end/data_meta uapi field.
>=20
> The original code looks like:
>         r2 =3D *(s32 *)(r1 + 76) /* load __sk_buff->data */
>         r3 =3D *(u32 *)(r1 + 80) /* load __sk_buff->data_end */
>         r0 =3D r2
>         r0 +=3D 8
>         if r3 > r0 goto +1
>         ...
> Note that __sk_buff->data load has 32-bit sign extension.

[...]

> To fix this issue for case
>   r2 =3D *(s32 *)(r1 + 76) /* load __sk_buff->data */
> this patch added additional checking in is_valid_access() callback
> function for packet data/data_end/data_meta access. If those accesses
> are with sign-extenstion, the verification will fail.
>=20
>   [1] https://lore.kernel.org/bpf/000000000000c90eee061d236d37@google.com=
/
>=20
> Reported-by: syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com
> Fixes: 1f1e864b6555 ("bpf: Handle sign-extenstin ctx member accesses")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

I looked through all context types and seems like only two types
identified in this patch use u32 values to obtain pointers:
- struct xdp_md       fields: data, data_end, data_meta
- struct __sk_buff    fields: data, data_end, data_meta

Double checked all locations where access to the above fields is
verified, every location is covered by is_ldsx check.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

