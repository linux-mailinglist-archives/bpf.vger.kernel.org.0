Return-Path: <bpf+bounces-62507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26DAFB6D0
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2567A85A9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FBB2E1C64;
	Mon,  7 Jul 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgEhkYsg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CD2E2659
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900699; cv=none; b=UfXrw7L3zTrGFR8+D4H8UKgQ5bGMsj0Gvk5iTpuToTTEMpEa9WVYd6h6WZD21+bhnWBh+ZU5YAAPRv5zvjy+yKjbXutStwI9tfI2aIhUga4OYKQZTqH8ut9UHGR9j3+unu6r7kvRO9RX1mhRM4BllpNku9uTtoTOtZwOaKQ5XvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900699; c=relaxed/simple;
	bh=mQwc/lVDcBDY+IXDzFiUJ72w7wGJTY7mxGg/skhtJfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAhj7dUGAVhhA+hhep5YwXEc1vmbP/BL8DBImz/PjvgNIUgg1pfulANfivVB9TPxxx1EURFmp8niFb87XLMZi0bkO0ywZsm1cIiz1aHjiUzwhG9FtL74iozZscnRw1iSIUict4PmVsIPsbM5XIpEmKR56SAtmJfjqbfdWfmTv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgEhkYsg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so16628645e9.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751900695; x=1752505495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhBQoZtO0Q3xjjl3ANLX1ZrgxCTjJ6SKmXRUxUeX2lY=;
        b=HgEhkYsgsoOXCfi0fJDXOdN+zrFplakgGlEHPvVhNGE9n2zbTnfElzerdOHEn/WoRD
         SHfSgdIMtA/1HOE7UswQMYLUKc/43CYurov5GIFBiCzx+lF6W1MleJ3qrxR7hk5wJCfF
         oL2aEFApEffrXRJH7sUvhj13Vi+CiHPm2LLhr1WnA3qHdyUH+NGFzsHvePV/Uek1Sgxg
         6JI4QfWQdoYTJisRWp0fvqgWuNZTBgBIAReZ9NPdXBT0qK/HJjlPb5DO1aC8Mmm/6pfh
         VN/Rj+oYyKLtcA45/WDZc6tNkDD0MK3T2yUymhFOG0/GLY6Y8gtcHZjKZfAveXzahDg/
         hMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900695; x=1752505495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhBQoZtO0Q3xjjl3ANLX1ZrgxCTjJ6SKmXRUxUeX2lY=;
        b=hr1uPVU9fDIhmudBh6vy5QLW1TFPk06M3fvWAaO+/84fwCLYIKm6P+mzF4o/JXQdbu
         wLd1Vy3d3C/qjokpUhcie+sVcYffTg8MO0HMH5YHEYkBqO2n5APg22FAfO1X1rOhBGeM
         wnQqvhnWjxUduhQMnlPFFlQbRtS2SQ1t+4fRD34AueRQp62QpVRRC/EkuyMvNRAzlfl4
         5+Rm5rLOQu4BdokKWD+kVgZcBemXkP9hQiKM2YeNkw/ZWWPpiMx8zDXgV5PlEIpqURsP
         UXTHI0/54rfYICViaQ8CA4wEUYnX1htMco5z8ieP0JLcAn2WBsvngiyOiDnnbPen4XWn
         LmvA==
X-Gm-Message-State: AOJu0YxfeizS+/02yl/5AI8KJYi4/3cWya797Jjep8YIc1vtSHK8A/Av
	PlsE3DNEpPjOrGhyznucbHvkzGHK29cIi8n0+WERIiRBwdWioIFWSV8nAldS/i1yTtsYN8iMz78
	oOQJIjsOX1Lc3sQihdpUO/GKnf7RNLOg=
X-Gm-Gg: ASbGnctQldz1IVEhKq/IAEsPZdAD5HWmlLkX6VoT55LyHgAarZoVXryiAjMYqaY4/oY
	pAHAPLGPr7Q/9CEnnpyB3yHtw5xMMWC4C13WqV191Inx3YfF7J33NfCjsxpRzm6OAlQj0B9roO9
	3l+TiZroa2Qv3nDq9AiIpOmP/Isn2lJQsKMp0oD8rCpO+ls/ZegW16R6RTnsw=
X-Google-Smtp-Source: AGHT+IFJeDNZkSKP+5qG19j5ZQiU+fjy3kgFFJ2tyPWlxQegTKvBYyntBD5nMNTyO4o4o3ZuoBnoJFI0/zrttimjbuc=
X-Received: by 2002:a05:600c:8b08:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-454b4e747e7mr135486635e9.10.1751900694857; Mon, 07 Jul 2025
 08:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702003351.197234-1-emil@etsalapatis.com> <20250702003351.197234-2-emil@etsalapatis.com>
In-Reply-To: <20250702003351.197234-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 08:04:43 -0700
X-Gm-Features: Ac12FXxDZ4E8ZpXKumSkobNT81mRvh-GQjxSrlL-av0qekvyRP2oAovaFxlB9Lo
Message-ID: <CAADnVQL86eLmsM1nw4bK7XappyvEovN7C3YR4nO4jB4S1cRS2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 5:34=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add a new BPF arena kfunc for reserving a range of arena virtual
> addresses without backing them with pages. This prevents the range from
> being populated using bpf_arena_alloc_pages().
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/arena.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 0d56cea71602..18db8b826836 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -550,6 +550,34 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt)
>         }
>  }
>
> +/*
> + * Reserve an arena virtual address range without populating it. This ca=
ll stops
> + * bpf_arena_alloc_pages from adding pages to this range.
> + */
> +static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 =
page_cnt)
> +{
> +       long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
> +       long pgoff;
> +       int ret;
> +
> +       if (uaddr & ~PAGE_MASK)
> +               return 0;
> +
> +       pgoff =3D compute_pgoff(arena, uaddr);
> +       if (pgoff + page_cnt > page_cnt_max)
> +               return -EINVAL;
> +
> +       guard(mutex)(&arena->lock);
> +
> +       /* Cannot guard already allocated pages. */
> +       ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
> +       if (ret)
> +               return -EALREADY;

Overall looks good, but this error code gives me a pause.
We never used it in a bpf subsystem.
We typically return EBUSY in such cases.
Unless there is a strong reason to use this new error code
my preference is to stick to old code.


--
pw-bot: cr

