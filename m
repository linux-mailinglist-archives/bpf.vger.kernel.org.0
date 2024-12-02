Return-Path: <bpf+bounces-45922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67D9DFD38
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01917281E0C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07911FAC53;
	Mon,  2 Dec 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PQcSwSk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353C1FA249
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131964; cv=none; b=QGfLbB2OJIi6FQJfHi8MhZfpxlM2GeFCCMJ6i+9en84SKp3xg1d7fltLrUmKGBm/8ZBLxhNqKUGx/UgOdgcIAO2Bq6Ey+rjEDPoElbRseEFSYfMRDz+q10krV46f+hU24mWVm7C9WoHgwzApt+UjXRiL4opcXpBcBx5igFx0I6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131964; c=relaxed/simple;
	bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLupfFTRr+VF/8YOT/lPnGzTcGMyZ/Fikr0aqD0zsjIeBnykjJCfFu2Lh6FBHS6pQKkqmQULMIVClAWJk4dJk7v5kSFDz9Ug4jd8IJczoFslWSGR3HWQlhaR9LASKx3P08VqCSz/iH5B0jWEWjSjpplIny7/zTBbUjmLpWK3wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PQcSwSk; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5152377321cso1101391e0c.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733131962; x=1733736762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
        b=1PQcSwSkPieprHzXj4dUgfgm+FBeNnEMd431FzLGC94sK/tntpfFC0QtQop9dsqL76
         NuozOd8zTom3bVdcKVJnfQ8BfU0iqWKgLOF72ILDI+6vYD4oW5khGBtrt51kqcnWQJ0s
         sR+lUhWrKq0gmb/xyvGeZD81z0Jr5HtuPi/Mp2KhAtDYnM940izJZ+gIYhZPxy+WMBBn
         2dwuSw3SbIajHvGWLkHwjqLjozmNYjI3y4Cc+tOzhvOgoVAoGVmwBIuE6HBVUULtkNKg
         wAThX21LYqxEqU4S7jbOFKgmXJZvWtyT2rUEF+e8acTxmNXL8UKVLJX4QRoKuJbbRl0t
         FHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131962; x=1733736762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVXE/ki/KkA9M8CTRd966bqfCz5463/+o3C+QEfkBy4=;
        b=q/7wX3wV1V8WOyVdYe1Avh9b5NLE4JFsroZaCw1nDleFfmnTHxX5G52R0lupXmBsbA
         V+hILq1GRAFuCv9ob/Om/kZW8fMyfkg025uAfsR0U3foW1E6Lh8bl3XlZ5Z/ZhW88cSc
         Kh6pEoJfFfdQ3Nk2/CtUAyR+l6jfwUm8JM1MRQZLCCTiVpfjGv6A8GVrrhmGQ53Z4bpS
         MzHLHyVg9RLZ2XNMKXXJcjZe7f6C4ljE2KU/2nXWyF8gRFxLzWElezQpCSfj//ZZnXbu
         j2ezeBwOxShxy/JX6XoLcRsc0EeBNC0H6NxbyQGYhHO8qVkBh+txmdpyTvLxe8Iowz6F
         IjGg==
X-Forwarded-Encrypted: i=1; AJvYcCWt/0Ncl3LddF36AnmbN+7R+tgAN6G89k1DTh6IsxOcSScqM2M1LyHskNjUlmSQeeQxKJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGSeaTnDwEifCfQG9CgT0jSZLyAetbPj5Ms1NepZ47tPZQE6O
	Hrr+ZhoSpvnbOt5GTOGqJJsT7l2S+3DkkaJvRMyaviwfoKwZEvpKtrX+ZZzfdOsvHnuJ2B7o2nv
	tH5Q9svnAhfHXt4AjoqvyOuFydlN65ubTaLfb
X-Gm-Gg: ASbGncu80kJI5+z2GXRsE3w6iTxAobNeUFD9WpqyTA2uJ7KA3a84ng+O4oQCdLzxjc5
	3WDYfKwPlV9/URZdToopoQREdV89jZUcqjChO3ewW7sMb3e7JPr7ixYpQNYzXmw==
X-Google-Smtp-Source: AGHT+IHHi3bLNsBy5XdABkyWzSukR1vhDWaGMCcr7HDBu5Qx8ILNRUzQmr9hbFxaFxrBqoMQX9U1aslO1xepcR8knNg=
X-Received: by 2002:a05:6122:551:b0:515:4fab:2e53 with SMTP id
 71dfb90a1353d-515569e2820mr23612069e0c.7.1733131961670; Mon, 02 Dec 2024
 01:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201152735.106681-1-syoshida@redhat.com>
In-Reply-To: <20241201152735.106681-1-syoshida@redhat.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 2 Dec 2024 10:32:04 +0100
Message-ID: <CAG_fn=VqUi=sGzz+0PJ9L7QrtOcgcn0ju=30BEGwB=D728wE8A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 4:27=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.com=
> wrote:
>
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().

Hi Shigeru,

Thanks for taking care of this!

Am I understanding right that this bug was reported by your own
syzkaller instance?

Otherwise, if the report originates from syzkaller.appspot.com, could
you please append the bug hash to the Reported-by: tag?

