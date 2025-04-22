Return-Path: <bpf+bounces-56444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC6A9752B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB01B60D7D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029F284B43;
	Tue, 22 Apr 2025 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI2QUaBD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212F191F6D
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349133; cv=none; b=KkGSfOajjLdClNRI+yWs2BwfqRlljClluOZdzE3e6Y35Fx/q2d4Fa92IbywrlQ5yXlOjc7sjYMOS7ckgZWx5xndE0emKzALEVs/x9KHExNuWPvJlJ+GHI+LFuH7c1MlMixYuGryIXt0zZJiZGGsDDwuiGZZXMuvI0o+KXobBmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349133; c=relaxed/simple;
	bh=OGL0H9akpplPD+nHP7FTaOrTAgjt2QZuk6+08TMcics=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQHQn4dEyUOK4lCOLLWeBMRohYSZkcIyOl3pzifVhTlgd5ql3XY4UkE6WkHuH9HYzLFRpStcBmDqyxmF/MZaBiCUGj5MjYWa2PcNNVE00UL+RCGgPtA4wdnrTLC5fC3jHtA7ReWtv+4ZiKj4bzfrZTfPYnzokWxnkYM8lsIFlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI2QUaBD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5191174b3a.2
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745349130; x=1745953930; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGL0H9akpplPD+nHP7FTaOrTAgjt2QZuk6+08TMcics=;
        b=kI2QUaBDRHxrHzI9n2wcJSpP3kjPnBEQ1bshQdp5TZaKh9utLZSHhtzuKppKddtj3t
         dtesLn6jj99PRVzgoBUrzJm+HptqvE6ldL8gFPQWG24Mn7INkhVPtnfnW43WHF35+Gdw
         F4RFoGwhezKEWg1KGpNLV9gnCP76FjC7NAzmkEmIordwFrEixeycvYQgiFC8EargWJz7
         7sF7x29u51qWmLV2MJjBcT3FEUkwkDpfAH47C8rM8xEUljLaav0yEC2kdUFmEkf2bEaR
         JDC/jyW0U8A8Dou2uXhXueum5u4rsnyQnbprUQBsMd0B8wZQ90AV9/YTUki51ck3D4Ku
         7Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745349130; x=1745953930;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGL0H9akpplPD+nHP7FTaOrTAgjt2QZuk6+08TMcics=;
        b=LVvzJyr3Fn8zaNrWdBpmXqQh0c78WCPQ3zxpCo9TwY691ihUtv150T+alLQriMctlC
         mqgkKQEFrhVg/Rb31hII3SeAw1p6lLNxx1KaEst/ncZAJ6gN/iI62xflTUkFnjZyF48p
         NdyWj6R3NkRTvq6ZVjmdA5HMv9JnoLr/MIsuZp3x6joJXYhVopZkeSLj6/wpDKxt1m7r
         AI8i34hWLcykjEQpUWuBiVQnpdWtOyHDqmubx4MnS8RMS+0tqLl5B9EDAvmaY8JZuUqs
         Fr0yXpXixBLgH5Jx4a6GTs+Ryl+gfa4vRPCbG243/cKaI/PYq9me6l3KQcuUqECZqT+/
         Uulw==
X-Gm-Message-State: AOJu0YxwIL0KsKUkfBS2C9uG7Q8ysrokYFiCWA6zFdiaZb/sSTG55QXz
	QrCXRaLaNNbsAINd5ab6ZtA6IMkaiKVVLMq9df1CQ7hpFzh0BQX0
X-Gm-Gg: ASbGncsR0JtyIjLMEUIAkdpCh4fe6w1s7omrlvpZuF1UaFmiupHGsZN8ySYl2uFMv96
	nJcCGf5okUyiJjmNIIxFwYY5m6pLfUu5vOFZOz1YSVQHmv6sy6r/bjlaPzthJNo2tSlP5nnbEkl
	bEb2UF6/l9gykT0pEYrTwR5K1HpIIgDBbRYja3hXWOaHS+x38cAbB4xOIAzO/M8a7FvJ7aajzc3
	KjGO6RjiSGNHt8HVUjCr3I/iXzFePbTu041o1eg25CQEQti9HHPBZhykg2Fdh5cjKa7x0i+A5UZ
	RiD/FaJaWSOLjdFhQSKhXSRRxnXzJPWWdez1QhoKqR46
X-Google-Smtp-Source: AGHT+IEzNENV3SZctjXDKp0+6607z/78bZ0ir1pdTvLBXZLC1OptwJtkmg7lby/iKKH3aYAzGJofJg==
X-Received: by 2002:a05:6a00:4608:b0:730:4c55:4fdf with SMTP id d2e1a72fcca58-73dc14a8851mr23079378b3a.7.1745349130028;
        Tue, 22 Apr 2025 12:12:10 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:9822])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad031sm9250450b3a.139.2025.04.22.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:12:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 13/13] selftests/bpf: Add tests for
 prog streams
In-Reply-To: <20250414161443.1146103-14-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:43 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-14-memxor@gmail.com>
Date: Tue, 22 Apr 2025 12:12:07 -0700
Message-ID: <m2bjsoroxk.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/stream_bpftool.c b/tools/testing/selftests/bpf/progs/stream_bpftool.c
> new file mode 100644
> index 000000000000..438c01a96efc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stream_bpftool.c

This file is almost identical to ./tools/bpf/bpftool/skeleton/stream.bpf.c
except it also adds a function `foo` that exhausts may goto budget,
as far as I can tell. What is the point of adding it?

In general, I don't think we run bpftool tests on the CI,
so it would be good to test stream.bpf.c itself e.g. by
creating a symlink to it in selftests and adding a corresponding
prog_tests/<smth>.c as you do here.

Also, it would be good if some of the tests checked the content read
from the stream. I think existing tests only check the size.

[...]

