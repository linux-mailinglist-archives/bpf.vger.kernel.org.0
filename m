Return-Path: <bpf+bounces-45686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C909DA1C6
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D4283A3B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212213C816;
	Wed, 27 Nov 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO5J/YuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382628E8
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685993; cv=none; b=JoBJCCTx/YHTOO4H1HEQH3DzhadvLFXwoBmdlcLUc0CUUzXKX+apB/wMzjwmrvp/NqUYZHh0lMD94MC4eCPoSsbp7AAxwt5qKv5ERkfU8AohA2oq6ckUrLpRKUwsiJLGIBZRk/Dlcy83st60ki0ziYOtd0osZVt7j8NC/leG5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685993; c=relaxed/simple;
	bh=v4SAuf0v5iW4pJ9Pemw5PDUSsRlF7expy58J+P2gvqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKcIdFWh9exK3YulASXETI7b/Idgn3zJ1iKtD7DhkHzpGnwUD3nTnGaZ2Su7Mg6JD/VVTE4EChKlYWOmazo1bYMZe1MA1XDSLrA/8Uc3twovJunmJ1UCpf8lPsnKvTrTjO0eAodRqE/D2sbHHqxK+GVd3CtnzitmNHx8rM19Q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO5J/YuQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so2103475e9.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 21:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732685990; x=1733290790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4SAuf0v5iW4pJ9Pemw5PDUSsRlF7expy58J+P2gvqU=;
        b=QO5J/YuQE+A6tLNNbvwmCLfsJdbaUZmHFyYogVWbt1QAaft55ghsvwSoEHS35pFQeY
         T+5Fefd0TEOJG8qCvB4jmyRmcRwIPYGLK+2s+t8/+EJ8AXSJXPLWxAygmNccsbL8kHmd
         WEqmLP5V47CCq8h3KCqLfRqi8qMjYsKhxkKclUevfQ51GepSoJMs1ow3eGr26/2ByKGn
         4JBAFMiYX4sv9/6FHT4E3IWJrlsi5qu+03mGJIIOWYvJjNbguMRSnee2dHFFLxOUcywg
         glFOgsJ6XxaN6wi3Ygb326ikeDGHSv4kKBdr7R7wEXw6XxRk4tOhyIcuJN3L+lvbMqqz
         V5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732685990; x=1733290790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4SAuf0v5iW4pJ9Pemw5PDUSsRlF7expy58J+P2gvqU=;
        b=u4T8UbMACNHOGTlb6hceCezaCZr3q8aXEgbRw/xwJut6yPgf4d+exbCELWFOY+xGK4
         P8nQYOoolm06UDz1Q6mvTIJdc2JFLdBynKdraPdaNdNjlN/yNgHdb7AU1WlVznqvTyxA
         x7ekeEiGdOuklSS1qNbnLYDSF0ctg92mrNtDawke7T/nvImFao88TaS0iB80epjUCQxl
         toiKhjXXzeFLpbuNt++FQVdtQq4qlCEe4gFwusoXVzuOuCP4o35Xi9Q9LlR87Iy6vKdC
         jlp765s7tCctr33VQHkjdPbLxKBzzw/qBXM6arhjiaTkU40/67a5l2asWrgj1q0s9HJO
         gc7w==
X-Gm-Message-State: AOJu0Ywcsy3RmdQ7SDdsGQHkEExgXFBWNnHU4UiY5jtkXFuxvor4pAWO
	0qf63IAvSng3b6Hgk1ISsohZ3jgypH01rkZ9FwLfMb8EKG7aYFY8Od19qTlfPEUWXeNJcb0kLc2
	NDNTrsE7JThKOfrl6Hb/gIMfw1Lo=
X-Gm-Gg: ASbGncs0RG1Rcp0KhkU1pl1AFdadwzCryLGaFFYPvSFjvy5BpFtfK8pJO0HCxWjIpoV
	9eRHZ7RjosMkNuGY/5cY7T7YaR7NVdbvJSTLO1yYYPnk+0wc=
X-Google-Smtp-Source: AGHT+IH3XKKA59nRYGqux4sTmOUzFe6U9cQWlK46iKDqie9QcHZVEsKOvoSSjqBsHwrauBwKQkeGEGF58WGSW/ztRAs=
X-Received: by 2002:a05:600c:1551:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-434a9ddef1amr12253015e9.2.1732685990016; Tue, 26 Nov 2024
 21:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127004641.1118269-1-houtao@huaweicloud.com> <20241127004641.1118269-10-houtao@huaweicloud.com>
In-Reply-To: <20241127004641.1118269-10-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 21:39:38 -0800
Message-ID: <CAADnVQKdgyaC2C6cWxjhrQrrkxGeNYfg1t6mZDEjXfq_4j4-zg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 9/9] selftests/bpf: Add more test cases for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 4:34=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> +
> +/* Use the fixed prefixlen (32) and save integers in LPM trie. The itera=
tion of
> + * LPM trie will return these integers in big-endian order, therefore, c=
onvert
> + * these integers to big-endian before update. After each iteration, del=
ete the
> + * found key (the smallest integer) and expect the next iteration will r=
eturn
> + * the second smallest number.
> + */

bpf ci doesn't run test_maps on s390. So I hope you're correct.

