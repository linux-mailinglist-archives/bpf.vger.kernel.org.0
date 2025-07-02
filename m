Return-Path: <bpf+bounces-62096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00240AF133B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5DD3A802B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BA2609D0;
	Wed,  2 Jul 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C9bRSqZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60709255E4E
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454326; cv=none; b=TMP9iyf6yhhpTj0ZZP0Ws9BqIcT8xiDjpeN8/3ZR9V+8y5p9HnPvKtY85LRP4/pBumD5S3OaMDlUPkk7/9peQXbuFVOVRdOSsZOE3UiMcqCKiORiXvQvlCUZlkFpscnwpBrGm6nnghG4EOz4DdMxpckaa/5iL3sYLW70Ffg5ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454326; c=relaxed/simple;
	bh=agRYeoOwRt8h0k2J+LL4XYo1Frd7ebnhO4GcAjaSxP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SS5nPAoQ7sftH76P09yIIXSYp1zkOt4L687+edHyc6yNjQbe50wAiBPObCh/sJx1oHE+6/joPpIxEgKFcjtt7vkBvB9GE0Jfk8cf9XJvn2FVFLl0vFyGfamAhYrdVKlfw2Mp/ZyQgjxZuXW1tE+ZsFz+3DhMJ4nxRbTAeNF/TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C9bRSqZw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso7187362a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751454323; x=1752059123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2C4+Yvp6OyfPa23VlNkCKp6gnO+5rj24D3Gx6EnEvI=;
        b=C9bRSqZwljEYUbnwY5j+wUl1A5Qm4Pt2y9UC/Vuwnt8+gegO5xZiPPeYUwCg9PIOoF
         k6ECa/aDPswz3kE6RaV9xRp12fBCLJltweP/El/9Yvb1cwFnFOq9YysLBWq4051059Bp
         1sK3yQPHtah1MkeGufT43ykTH4ZKejAvzZsIgpUsbJwgvxO1GDWgJjl2FEJBZTIiLVi1
         Qwk5n65WqXjcxkHCl64OgGLACGKQmyztIWfCAmUXMrR3S8XbBQi45y/Z4J0hFoMBasEi
         vGn+Rq6nQB+g4w0vbNTFqjMXbNWSywcdWXh/LwVoiyFlg6ZLoROvoBe1l4Xtu4tXFD0Y
         ks/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751454323; x=1752059123;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2C4+Yvp6OyfPa23VlNkCKp6gnO+5rj24D3Gx6EnEvI=;
        b=ZMpXbVm0Dq/cnuERvdSADn4j7HrwMYqT3DVzSVXmZrzUsXXp9ONIrE96E2VkZQbk1t
         jmxKHYltyOV7xhIH3fy64rNUINiUPmlrnx28sa0n2S4TVK7Y8NyAHYBCPI2ot91Ek51b
         DOZHU1HLYGO+/fjwEdbFKryyC6ZmZvYqYgvQh39JsWlEmjdKQAjoFB5wuPKjLYzqpNW/
         qKerM9+2J3QLZJG0A8oEy1V+RDEdN/48XcoqT+ccPDtcZK7LBLKWFX4XRiOl6WAU7kDW
         mP0oW4fQmtNtwKlolYFLwu1Ef/G/qS4/mGmIXvp6+axf1BD5xdxSPZTgOhMVbo0RwBTK
         +1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVXrJ+xaoEA4sV55tY0QdLjgVRo/chve4jCWvtD7BGO9MvHgJ8pfIEReuu5AH/mqLcB6WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysplIW6Y2mjW+ZPqrno8Z8jPrrl0s2fnlbYKDus4ND/4GpEBBa
	xJF0nQjLWQPjWXsPgCPvrvzf8Eeaj6RdyK8yG8jTaZ5VeE3P3OeJesWLXImPWYF2zTM=
X-Gm-Gg: ASbGncsXIG9uIuIXHGIGW+FzKkCWp45FMBynlkqlw8qrB8HRBQ2fMQ3o9XLgQUPw4O4
	3qakWPeamwKVreKjaWWeGlfb1vkgzc8haFzJQhG70B+BA2QqBvL6kbyTD7419Tkvt1E6WzCUtr9
	KBxvgUZ4pjVcmSHR2vRYAbwfktOlDDHJliBV1hu8cRmLUtU+VQu4Qf7MVr98QKpOvNKthb25niR
	o2fbheOjuTQMt14aGBnSIaMiXlBYEwTbFMfEhuMVtx0rSCQao+g3HIjxWb0dvUBntKJ+fqFcZuZ
	ffAP9SxL9rnFLwwXFH/EN+QymE40xZUkIovHy9MCH09Wr8iiQLTXxUA=
X-Google-Smtp-Source: AGHT+IEq88zmgjpOc6byeXLCyqhGjreTvPH4otpjeBh/Fsctu9Dyd3D9+xoyG1tTQ2bMYn0uypOR8Q==
X-Received: by 2002:a17:907:1c0e:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae3c2d4e7famr229869666b.33.1751454322620;
        Wed, 02 Jul 2025 04:05:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cbesm1059139466b.166.2025.07.02.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:05:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com
Subject: Re: [Patch bpf-next v4 0/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:57 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 13:05:20 +0200
Message-ID: <87qzyyn98v.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> This patchset improves skmsg ingress redirection performance by a)
> sophisticated batching with kworker; b) skmsg allocation caching with
> kmem cache.
>
> As a result, our patches significantly outperforms the vanilla kernel
> in terms of throughput for almost all packet sizes. The percentage
> improvement in throughput ranges from 3.13% to 160.92%, with smaller
> packets showing the highest improvements.
>
> For latency, it induces slightly higher latency across most packet sizes
> compared to the vanilla, which is also expected since this is a natural
> side effect of batching.
>
> Here are the detailed benchmarks:
>
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k=
    | 32k    | 64k    | 128k   | 256k   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Vanilla     | 0.17=C2=B10.02 | 0.36=C2=B10.01 | 0.72=C2=B10.02 | 1.37=
=C2=B10.05 | 2.60=C2=B10.12 | 8.24=C2=B10.44 | 22.38=C2=B12.02 | 25.49=C2=
=B11.28 | 43.07=C2=B11.36 | 66.87=C2=B14.14 | 73.70=C2=B17.15 |
> | Patched     | 0.41=C2=B10.01 | 0.82=C2=B10.02 | 1.62=C2=B10.05 | 3.33=
=C2=B10.01 | 6.45=C2=B10.02 | 21.50=C2=B10.08 | 46.22=C2=B10.31 | 50.20=C2=
=B11.12 | 45.39=C2=B11.29 | 68.96=C2=B11.12 | 78.35=C2=B11.49 |
> | Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%  =
 | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%   =
   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
>
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Latency     | 64        | 128       | 256       | 512       | 1k       =
 | 4k        | 16k       | 32k       | 63k       |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Vanilla     | 5.80=C2=B14.02 | 5.83=C2=B13.61 | 5.86=C2=B14.10 | 5.91=
=C2=B14.19 | 5.98=C2=B14.14 | 6.61=C2=B14.47 | 8.60=C2=B12.59 | 10.96=C2=B1=
5.50| 15.02=C2=B16.78|
> | Patched     | 6.18=C2=B13.03 | 6.23=C2=B14.38 | 6.25=C2=B14.44 | 6.13=
=C2=B14.35 | 6.32=C2=B14.23 | 6.94=C2=B14.61 | 8.90=C2=B15.49 | 11.12=C2=B1=
6.10| 14.88=C2=B16.55|
> | Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%    =
 | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+

Plots for easier review. Courtesy of Gemini.

https://gist.githubusercontent.com/jsitnicki/f255aab05d050a56ab743247475426=
a1/raw/715011c50396ef01c9b5397a19f07d380d56cd25/sk_msg-redir-ingress-throug=
hput.png
https://gist.githubusercontent.com/jsitnicki/f255aab05d050a56ab743247475426=
a1/raw/715011c50396ef01c9b5397a19f07d380d56cd25/sk_msg-redir-ingress-latenc=
y.png

