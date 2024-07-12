Return-Path: <bpf+bounces-34685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E993013E
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12B5284D84
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D233B1BC;
	Fri, 12 Jul 2024 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix/kxwiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36588F6A
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815424; cv=none; b=WOFtQCfuJLHhfPoVbt5TyUynlm1RbeZucmdAs0InG4AisuE9NvDbh7/7UK50yB4C6ijQxHF7pkRDadnmdtxbCu/RzOvrzMzzRq4tZBNg5E+MRUDcSu2/V+I+fZXPQhN6IeG7myj9udjPPLG1Pj+7w95A3UMXK3ZC/+dP5IYQiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815424; c=relaxed/simple;
	bh=Aa6wRI+6d4C9Pb1YjK8kUTiRS4JQO0+krNno1qMRAcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLH+FIMWzAER8tK4jKuMLMwTmEJnItrvfszAlPF+deW5NhhZw7CkON7r53NnjksNTmmuxb3kCmZHSTdeAM8BI9sbxRk44oLbbVJFjXGWBgKB/IZsnRILooTURNF0lGv6/mlm0xbVjws6fm5XZxQ4v60e5C4AzT8DY8tuxLo83WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix/kxwiv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36798e62aeeso1437008f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815421; x=1721420221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U76r2qw3g47LR73MukkyBgQim89CEgHZBB3YU06a3g=;
        b=ix/kxwiv4Au3zZEvgLINbXY8UevACaKQKpCR2ydSUA42GobI4Nqweqx1PQXu9E3xK6
         ywBqz47cYChkzrQzxFwH9kIG+iG+lsFgHFw3yCXxnX3Z/WKLNkhPa0sHQKHN3HcnE92p
         N+64fbIhADF1FV5lAqqcxXhcIAncX4oulUm8sEJH1fvJv/g7LhAdBf6A3PHIpgbYj+rn
         y02WN5KyuOvzNXmOy+RFVjzhUWN88zIySUZvPZElTHKJcfu1PLrynSPyrAWyIF6L9Voy
         kCoxHMmzpnI41kesSIdayY3Fjx/upHwjSnyqBjxMUzqwipV2IZ2gRfzLwQBCbFe8fLvV
         5BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815421; x=1721420221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U76r2qw3g47LR73MukkyBgQim89CEgHZBB3YU06a3g=;
        b=svek5bxScoJgThqs5djCLrSXmeQyH5cMLmrDra92YoJ72Me/56kKWnwnvEDKMY+G0p
         167r+DpDfYxGvN/i1Pi09L/u6vkH6TlQ/hc32N6nadgJnzCcDVaoqoxc4AAH64/M2AGe
         d9CmLX4nAOdOKj0ZCC3MKGMYE0+MB0DTpiP5yvRCWQPMkcXjJ3c4FgK7Es2j0+D2LO3k
         xVY5HNXPd2fRb1UVSr852PGddAkI2j2yy9ydTJ8nGE5saUJ53uaYqK2NoDtPYU4/Jrti
         T8E3gubpRxhxHpPEKauTa0zlk9XwQ3V1iVpA6/7spB3jI1W7ZSJh4PJGI0zhbTi8CTtz
         Xo1w==
X-Gm-Message-State: AOJu0YwVFZzX10qQ8ije6PB+No1n9ThK8RUrkPQjUXcUqzbTlRy0GmyG
	YTNM579ACS/tBO7sQ8am3ZmrUd2uT+LUK6bJji5rrqUbmPcf88JC3QH39iwNy8+MRddGiWNFciN
	rls2K4QyQZzMKqNgaPOtFrtAnxqnzaqKuECY=
X-Google-Smtp-Source: AGHT+IFcbMbSM8SJsVTN/UdidERijE+8FKwsY5NWnI+gm18RNGEwRitp5I/bf8vBAg6Zk2xAzrvK62n6r3VtRdtBTMo=
X-Received: by 2002:a5d:598a:0:b0:35f:1cc9:1d1d with SMTP id
 ffacd0b85a97d-367cea963f6mr10706671f8f.38.1720815420810; Fri, 12 Jul 2024
 13:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711164204.1657880-1-yonghong.song@linux.dev> <20240711164209.1658101-1-yonghong.song@linux.dev>
In-Reply-To: <20240711164209.1658101-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 13:16:49 -0700
Message-ID: <CAADnVQKnWJM7mGqpHn4wy25+VJuh9KGGK9tf75qgC2Zk8+ojBA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:42=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> It is clear that the main overhead is the push/pop r9 for
> three calls.
>
> Five runs of the benchmarks:
>
> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> no-private-stack:    0.662 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/s)
> private-stack:       0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s)
> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> no-private-stack:    0.684 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> private-stack:       0.676 =C2=B1 0.008M/s (drops 0.000 =C2=B1 0.000M/s)
> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> no-private-stack:    0.673 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s)
> private-stack:       0.683 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> no-private-stack:    0.680 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s)
> private-stack:       0.626 =C2=B1 0.050M/s (drops 0.000 =C2=B1 0.000M/s)
> [root@arch-fb-vm1 bpf]# ./benchs/run_bench_private_stack.sh
> no-private-stack:    0.686 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
> private-stack:       0.683 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
>
> The performance is very similar between private-stack and no-private-stac=
k.

I'm not so sure.
What is the "perf report" before/after?
Are you sure that bench spends enough time inside the program itself?
By the look of it it seems that most of the time will be in hashmap
and syscall overhead.

You need that batch's one that uses for loop and attached to a helper.
See commit 7df4e597ea2c ("selftests/bpf: add batched, mostly in-kernel
BPF triggering benchmarks")

I think the next version doesn't need RFC tag. patch 1 lgtm.

