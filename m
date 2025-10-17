Return-Path: <bpf+bounces-71241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4857BEB377
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2BD335EE5D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07F3314BC;
	Fri, 17 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRl2jWvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564832ABF3
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725661; cv=none; b=L4zAVv1YnwEVs5/hJthGdqbMa3zw+I0csgnCHsXpKiODDopp4Q9iNHWKB8yUt7wkAd6p83rv5YWYyo/nqK6VWWWTGEpfeTYSaJWjM9f26MNGEHnlWKchwtT4jzDAg8B+Ve2Ke1OsqCHEDqCgO4xd7+Xof8/Ke0RThdQDsrn2Mn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725661; c=relaxed/simple;
	bh=apyeGrhT2B4cjSomRBMirnJK1iCiphU7E8kwZ4eFRPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ2hDTPF/R6UUQZj76Vwnks5G3Wr1PKOyA40uFEE2yKhRl7T4xx+ypCEClAVoOhoF+qz8378cXk3n83HdPeka7tCEgZI42u0uHLzx+bcxxUUeX/ipVSpoHCN5yXLqW1crRB4g966O7zN6skq1zooC2SolX+IaOR3WcxdpTBw57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRl2jWvR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12807d97so2060529f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725658; x=1761330458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=lRl2jWvRw+n/iLhCD3xpKuP83ZE3tpzetVsSBAj0bBXyQezXVf3unacJZRJ0WQnmSA
         XgpciaMSHuvupkgV+rXJiKWyQRYNUOppzy/wKOKooClafXZxfeLhbNKLjhZT0ihWp+tI
         ueZBdU4waox/w5i9wVV9+rm77LqtZLquUy3vhUcO0+MfGWX9Cm406yvju6wtKW2S9RHm
         WWvSK1GmecZ1eTnrKTSCpGfCbrmHM1hejSylO2gZ/x7Ec02RYt1lh4nJViYKmVKuGsrg
         amGoHeV9E8508I62WGhJCwSOvmIWbK4HCynxoEVJ14RP4/HzaOAqt4uQOj5ZNXdiWCOr
         7p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725658; x=1761330458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=NzJI2q1Zf5xqF7MRAdxaZTduuQMG4J0szWWOoJ3Xz3k6s5/iT6KTxdfbzc7Eq2BuEo
         u4Ce64YGfTj55FJbP0SAm8B7QUdz3xToVTy/m1riov02F0JFZc/KHMlCTsj1Rn3d8ODq
         qDF7xNOnilbPJuIRM/ol5rYiCM5ayaAdqlOZuc9/sfhohOiVE47GzI0aJx7hLMhnTnEr
         tuiWqzTLACmiL+NWvv1jmbaWfKm5Br2ef0ODuW/j6VE9VfgbTvZQ9eQirr0pvueSGYya
         mthKwXG949E4yfAQn5c07gHbp8wqhut0PzjUUrfrTXZMhLJDeY+YlDNJPeuMIAk4VJnN
         /wlw==
X-Forwarded-Encrypted: i=1; AJvYcCWkvORWTSGhHdRO/Fl2ygfbgTAl11n5uMgjNLTszEGw2mcERKy1sTs2WNy+pViaPwSQdpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4LAA5ZLVqCOBFvLjUvmatBBpmHNdTgqZ5YQkKh47KvzEYJTw
	hVj+3VNaXXZ6repScuNXdd8Mw4OAVBpsh5dKVbsIGs0Fs7DTJfw5tYlxRs9Wv4gyJwjP8mE12i1
	4VVcN0UCydoN6MALQj8cYJ/+Nd1I7aXY=
X-Gm-Gg: ASbGncs4DLoGljuiCkIEFPxw0RuPIUhFzMP3ifIkQQAWdVB6hDIqdfj5jD4wq7g2JIy
	PjyjqsIVSS4TYpVUfvt0oOZ22xjSYJS4YoTVJF5ooDE5WHRkAiZoW22LWMboaWTSKx8CpefDOZO
	Z/tOHS/XJK8jy1WScOndXQeI8KAPkRDcitDOt+6OPVKRnmRm8SbOPzyZOq9mkePdBxuaZ9Hoe1m
	k/MtjVu8nvOj36b6RUQ1vv0hmUpkVggfIr8Cx/g2Rt2KJKOF2oQazoe7rKIyTFdYNAGVJ7Hhcr2
	z0Pf7jdyXWjdOUHaQi4cf7znYnCD
X-Google-Smtp-Source: AGHT+IHrzD3MV8piW/3R5bZbNm50DZwa+/IsxY+cp8lTiOj949EZXhc7lXjq+S0IuHDeamFjuoLV5tVj/VL0xY2uTU4=
X-Received: by 2002:a05:6000:2387:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-42704d6d12fmr3503910f8f.23.1760725658228; Fri, 17 Oct 2025
 11:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 11:27:26 -0700
X-Gm-Features: AS18NWCyoIqaofAQbkOXYwS9xLsYBlc0BUliOKOZEhJe6-LQzeQc4XxtZWuyB4E
Message-ID: <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:45=E2=80=AFAM Bastien Curutchet (eBPF Foundation=
)
<bastien.curutchet@bootlin.com> wrote:
>
> Hi all,
>
> Now that the merge window is over, here's a respin of the previous
> iteration rebased on the latest bpf-next_base. The bug triggering the
> XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF failure when CONFIG_DEBUG_VM is
> enabled hasn't been fixed yet so I've moved the test to the flaky
> table.
>
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
>
> Some tests are flaky so they can't be integrated in the CI as they are.
> I think that fixing their flakyness would require a significant amount of
> work. So, as first step, I've excluded them from the list of tests
> migrated to the CI (cf PATCH 14). If these tests get fixed at some
> point, integrating them into the CI will be straightforward.
>
> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs.
> PATCH 2 to 7 fix small issues in the current test
> PATCH 8 to 13 handle all errors to release resources instead of calling
> exit() when any error occurs.
> PATCH 14 isolates some flaky tests
> PATCH 15 integrate the non-flaky tests to the test_progs framework

Looks good, but why does it take so long to run?

time ./test_progs -t xsk
Summary: 2/66 PASSED, 0 SKIPPED, 0 FAILED

real    0m29.031s
user    0m4.414s
sys     0m20.893s

That's a big addition to overall test_progs time.
Could you reduce it to a couple seconds?

