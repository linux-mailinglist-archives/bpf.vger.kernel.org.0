Return-Path: <bpf+bounces-14628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38337E7269
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683BF28112F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0C36B14;
	Thu,  9 Nov 2023 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mykxmoAg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B436B05
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:38:23 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40183C14
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:38:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5099184f8a3so600807e87.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699558701; x=1700163501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyimjD17d2JkpQpXgd24A/FPE66EJMpKX4O8hA18qzA=;
        b=mykxmoAg3tI0PbIbRNEt0CSVF9Xyl9Lpe7Tc/veg8AQhhfnOJNaSXSCLTHVVnW+Evn
         dGyJHfMM81QqoKJPJfKfJW5X6xw31XK3K/E7wCf5u5HeJPrYSau2xksHLUXVlqDP8k28
         t879NT/Br8uojM4Zq2f7HYUnpdyqFDMMFpQzihkCuuVEYPHCZB4yIDTjRbW22zns6M/6
         Vn7p38pG3Xt/usv5k9WTVfEVqlmMOPfrb+rqQMx+iVnl9Pt3EBxC+J2GQYudY4hIt+iM
         a/cYw8ZOIIA7PhorNfEZLd+td1QW+j97/oj/AbBRkvQUGXohgU9YMa8PueCFQDieQbR3
         TjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699558701; x=1700163501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyimjD17d2JkpQpXgd24A/FPE66EJMpKX4O8hA18qzA=;
        b=iuS39Pq3rvMy9hOTici1YN92tY64OvIcY4qcYpswnAGoQ7WsyddwDTsFqJ1CZ+O4P/
         +EoFPVhxro7R6r9hGCGIYso/4S3FQFrA8hAgIiX/FaPcOjX+JzVYEYYfzxDTAsdLthrv
         lbFuokn9dA63pmVismMvBOFOPpiMujte/Pg5vkgDVCAF3Ggsjca/QF0yXu05c+fEVJ9E
         vI9WLgnX1yEQqwSrnT8eDn4Y1il1uYbwkxmafVrehMP8tinh+8esFR27LTHsJ9eX64P9
         UleGxKkf+WHYXiVRCfLjWKNjGZ+6RwsMfHbM9DIp0P9ueWnEqG7YM61Yf/g23MSB4Q8P
         X7xg==
X-Gm-Message-State: AOJu0YxBxFT9ZdxrMt+MKB0JroWGM6qvI7q6g/dfxPh878iwGDFoActC
	q/kBe/FIgKVyT53f+F0aP3/BF7jzgqVwg6nL5Fo=
X-Google-Smtp-Source: AGHT+IHt2JQR5K4gayDC4yqXpIdxDHLKLDCEgi1UXkocuZXO00MvFt2BgELLdvhFkUZs99UAA1es6XMVNdGIKwMKZqI=
X-Received: by 2002:a05:6512:2190:b0:508:136d:ab0c with SMTP id
 b16-20020a056512219000b00508136dab0cmr2348602lft.30.1699558700675; Thu, 09
 Nov 2023 11:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
In-Reply-To: <20231108054611.19531-1-shung-hsi.yu@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 11:38:09 -0800
Message-ID: <CAADnVQLRjj7nQg02BAzToDOZvtk6P9f5UN010Nyb2negcPzoWQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v0 0/7] Unifying signed and unsigned min/max tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 9:46=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> This patchset is a proof of concept for previously discussed concept[1]
> of unifying smin/smax with umin/uax for both the 32-bit and 64-bit
> range[2] within bpf_reg_state. This will allow the verifier to track
> both signed and unsiged ranges using just two u32 (for 32-bit range) or
> u64 (for 64-bit range), instead four as we currently do.
>
> The size reduction we gain from this probably isn't very significant.
> The main benefit is in lowering of code _complexity_. The verifier
> currently employs 5 value tracking mechanisms, two for 64-bit range, two
> for 32-bit range, and one tnum that tracks individual bits. Exchanging
> knowledge between all the bound tracking mechanisms requires a
> (theoretical) 20-way synchronization[3]; with signed and unsigned
> unification the verifier will only need 3 value tracking mechanism,
> cutting this down to a 6-way synchronization.
>
> The unification is possible from a theoretical standpoint[4] and there
> exists implementation[5]. The challenge lies in implementing it inside
> the verifier and making sure it fits well with all the logic we have in
> place.
>
> To lower the difficulty, the unified min/max tracking is implemented in
> isolation, and have it correctness checked using model checking. The
> model checking code can be found in this patchset as well, but is not
> meant to be merged since a better method already exists[6].
>
> So far I've managed to implement add/sub/mul operations for unified
> min/max tracking, the next steps are:
> - implement operation that can be used gain knowledge from conditional
>   jump, e.g wrange32_intersect, wrange32_diff
> - implement wrange32_from_min_max and wrange32_to_min_max so we can
>   check whether this PoC works using current selftests
> - implement operations for wrange64, the 64-bit counterpart of wrange32
> - come up with how to exchange knowledge between wrange64 and wrange32
>   (this is likely the most difficult part)
> - think about how to integrate this work in a manageable manner

Thanks for taking a stab at it.
The biggest question is how to integrate it without breaking anything.
I suspect you might need to implement all alu and branch logic
just to be able to run the tests.
It's difficult to see a path for partial/incremental addition.
The concern is that at the end this approach might hit an issue
which will make it infeasible.
So it's a big bet. Might be nice correctness and memory saving or nothing.
Certainly exciting, but proceed with caution.

