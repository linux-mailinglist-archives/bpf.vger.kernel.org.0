Return-Path: <bpf+bounces-39211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EDD970AEB
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7295E281E61
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 01:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E69DDC7;
	Mon,  9 Sep 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSCOyM5y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD25A932;
	Mon,  9 Sep 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844278; cv=none; b=j8PgtpAXSk0HaFlQFJxt15q0gDtPcfxzqs2AzIPxE14jnCEtF4fzF7WKniDYufEPz/WQcSQ5E8dtUM6AKL9lTUa7QzHji8rnYYHMHLj2cvzujExlQ6xLD/GoIAcZWGYDjBUt/rD7GMJmWr12l1nQHnNd5+uliPTOtwvjHi9kBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844278; c=relaxed/simple;
	bh=k8p2baZgQ5AKYcGF1mTzj6v6PsnSu2BAQLo08iDdm5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYloXFYHHjHXL4uOJXDediIeWbaOfGjDyF9JlDNEyNnJuz3egw8Da+mv45dlhdNRnhHYMkoLWdV7xuH+DTxn8nKs2dHxRXsMi7p8XC0jWRlhgXBPFTHV0jiQODFGJ4oxAMHp5WC5zUbGaQ3aSdtp5gsC8zcgfyszNfJzUQajaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSCOyM5y; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2920687a91.3;
        Sun, 08 Sep 2024 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725844276; x=1726449076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODeiZaLKYg6ZviC8NyAbx2CBkhYZM5ti5OKHmAZKgOY=;
        b=KSCOyM5ybfeoH5uVAwbEyNVqHTv6mj4XsCA352FvVcCTO8GnZ37t8fjAJ/V2xyXdHU
         Af30WIO2Z3PTZohi/NSOaMKcyrdt2ut23SsxE0g3lQoagTICLqYbnb1wwHMkl0IqB88f
         3k28iisgTD6uIuDpfjl3akznry4WwRh2PThuwsW9M7Y5zKVGa0dCCm6hhO4seG8NfGBS
         WEJmgxl4vCzVSmjrKf+tRrg84A/Q4B2tqnF7ks/5iV191fSnmH683NnaNMTVrbAvuqp+
         l8DJRbSTo+yYgZW+uzyhm8/nQ4yPx9mK6jc0nIU3QdyZ1nogLA6fsgO3HJX9BE3N9owI
         EbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725844276; x=1726449076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODeiZaLKYg6ZviC8NyAbx2CBkhYZM5ti5OKHmAZKgOY=;
        b=DgRAG8YIREU5laRipJPe+tPMsddQzq2x7zMPb2erqi9zepOoykziEG6WBUGbBdEJ10
         GHP4YMvOmi0gjV/6i2F+c5/oYnD1Hh8L/RJxO90md/cM66jYjtIkhBDh5AbV8RGFfEAF
         cEzQhrBfTj1Pgnpu5Jm+tqhP/bg/K9QuFVo205yETRc3LPlb3BO1d2wIaK8lXdJwA/i7
         ESKjMseWIpiHZeFBdqIMTH6t60JLWHeC6sug+MppCLMSbib9YudbhxF3yiVddtojTWYR
         Zfxc2WzV60Q2VwPiJ8ZAl4c9cA/k35RciTkzp2wk7CXGXn2UjrKXdZvJd/qFEIPXMLQr
         487w==
X-Forwarded-Encrypted: i=1; AJvYcCUU9bW1J/DUDmuFLr3r4KGvqgi8JpFeXA7LUJnl2NWaqHwG9da9gEIkZDJ+d3oVMp0WHjc=@vger.kernel.org, AJvYcCWobBNbdqyrJAbnBBBme4PD9jIlMAA2MKfZ2MGOCUEMm4m2Dxj10yjirr2pJE2EZpHfZa9ptxSYYXhB6NwY@vger.kernel.org
X-Gm-Message-State: AOJu0YwSp20RxoCID9/bMVEvaTWMMPRs2Ajxk9+JcA1pycVouPSAbloJ
	/zClVyP9cN7IUPSfUSaW3QlXfgqEJ9dKroF+SsqMn14BxpmZxNi+iIOSkjZT79pS8NBZqfue+lG
	PWFBh2WkkkMTQBXjgueFZ76y05w4VHQ==
X-Google-Smtp-Source: AGHT+IFKWxLQ1WT3gnv2oZYmXtcbQwFg1hwesywzl6zJX5noiX6W/DcY1AVUz0Tx+K4q0xUB+Lbj2VEwqNYyfMWKvrM=
X-Received: by 2002:a17:90b:1c0a:b0:2da:d766:1925 with SMTP id
 98e67ed59e1d1-2dad7661a42mr8779619a91.37.1725844275880; Sun, 08 Sep 2024
 18:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903174603.3554182-9-andrii@kernel.org> <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
In-Reply-To: <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 8 Sep 2024 18:11:04 -0700
Message-ID: <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com>
Subject: Re: [tip: perf/core] uprobes: switch to RCU Tasks Trace flavor for
 better performance
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-tip-commits@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:03=E2=80=AFAM tip-bot2 for Andrii Nakryiko
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the perf/core branch of tip:
>
> Commit-ID:     c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> Gitweb:        https://git.kernel.org/tip/c4d4569c41f9cda745cfd1d8089ea3d=
3526bafe5
> Author:        Andrii Nakryiko <andrii@kernel.org>
> AuthorDate:    Tue, 03 Sep 2024 10:46:03 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00
>

Hm... This commit landed in perf/core, but is gone now (the rest of
patches is still there). Any idea what happened?

> uprobes: switch to RCU Tasks Trace flavor for better performance
>
> This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> is optimized for more lightweight and quick readers (at the expense of
> slower writers, which for uprobes is a fine tradeof) and has better
> performance and scalability with number of CPUs.
>
> Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> implementation vs RCU Tasks Trace implementation.
>

[...]

