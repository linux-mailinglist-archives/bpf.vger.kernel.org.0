Return-Path: <bpf+bounces-36452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3138948A11
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AF11C22319
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3B166F0C;
	Tue,  6 Aug 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8nAmTv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51508F62
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929125; cv=none; b=VlPEG71zctFsvjjdZZW/v7jK4LUub6t5uqt1gw8j7pagxfTFJohQ0jRxTcYoUd3fh/wjLuOPh4P+1M1IPw+KRPGk5efqYl3Kfq5H5GHpmqKrnIvskvPUABwPsExxz8gz6jqn1QZROgYVh4r9NhjLTU91Z/kT7a5JS/f0QuYdKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929125; c=relaxed/simple;
	bh=fDm1SAY0/a5iDVg635jfB77PQeVgzLx9niX7Amy2CXM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlclFwVR2S4FDQBRgEa8BBeyWr8RfSjmZZQ2KR+tqTpyJEWSA9R+JLBvzeYU43P/jRFJCcz1wHF9ijEPuTRczKY/uxXqLy3eI+4TXirwNa5NHiXwO8EESflpzCC+kFii2les4iRLdIbQEu4Ofz4s1yDCSDHrEen4QSWRgsIVElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8nAmTv/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so5345681fa.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722929122; x=1723533922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P94c6mGKzorUF+nfgyCzH1Jpga/eXuBmLxWmliHBHQM=;
        b=K8nAmTv/ngYwBmUt6QE8h1/d4QjGh3aNdUiSdgQlP9q96cTYYZaKIGM0dKT1S2SRIp
         FvRLO61sDhCA6P5AbwDHY0KO88mt/R82LMzfIJtLV5RRyx0XnTxG9Up8KCjHutQHNTqs
         0ILrZTJerkPOCY6Ugon09Ur2MxLLJcPoVMnSRWf8DWzGlsekeM1U/c309uG2HbswfruB
         IhjaX0pi5O4MuGKvCChuKdMvCaJ9+DhPEs9vbqFO8qy3QLMIFjYs2Vy79kNplSoFXdlG
         OGBCURVjMjvD9ubv+SQezKFVkEQ2uWNYs8FXO+e7thN9BItKREzlBt/pdgBDhKkbZAVf
         kK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722929122; x=1723533922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P94c6mGKzorUF+nfgyCzH1Jpga/eXuBmLxWmliHBHQM=;
        b=fRPIuMSGd9kLqM+zks9Q7Hr5cMktE+xCqoOTlrrOAnQsCKK4IY9v5AkIsgKqy51jjH
         xaN3ZqL+acsRF74a7mA4B/m62I+mzT8cFAT3iyPDhLqmCFiUCpaRp4FXDxmNIm8qKb8y
         eC3ERtgrQyzJztEr1bC8oMNnRmXW2gD/WEm0i73w0ZyzlzCgpyY4oEngdm1o5zQaZUlU
         x8NU8iUwnKGvITdIszTT4iHJjbUtsPeiOBEtBJHNkgpGwziVSmcN9gS/XLY/OwGgIOzu
         Mb/VNNKDQgHdqMFib1Bj+h9QVXsS3Vm+jQM0NeOiUu1ntVcasTrLnfNlnmtj2cKIFCFY
         G5BA==
X-Gm-Message-State: AOJu0YwQHTzEfpRb89Ozf3n7dclQ5yi8tGGwmJK2/fBjxPpF8yD/U/Im
	/o2Vtyjb0cnnlUz4NAQauea8+COWcBWVTQbgbltE0GRM1o70sS4V
X-Google-Smtp-Source: AGHT+IEbvhFha9ul/RLQAa3g++4ONCg+pNe36LNh0nPLIS48lQ5CshFq8TM4j/GoVk/BI8b6nT4jLA==
X-Received: by 2002:a2e:be0d:0:b0:2f1:67de:b536 with SMTP id 38308e7fff4ca-2f167deb6d6mr99532201fa.24.1722929121339;
        Tue, 06 Aug 2024 00:25:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c185sm521555466b.61.2024.08.06.00.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:25:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Aug 2024 09:25:19 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add multi-uprobe benchmarks
Message-ID: <ZrHP31DJAQQjgdQz@krava>
References: <20240806042935.3867862-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806042935.3867862-1-andrii@kernel.org>

On Mon, Aug 05, 2024 at 09:29:35PM -0700, Andrii Nakryiko wrote:
> Add multi-uprobe and multi-uretprobe benchmarks to bench tool.
> Multi- and classic uprobes/uretprobes have different low-level
> triggering code paths, so it's sometimes important to be able to
> benchmark both flavors of uprobes/uretprobes.
> 
> Sample examples from my dev machine below. Single-threaded peformance
> almost doesn't differ, but with more parallel CPUs triggering the same
> uprobe/uretprobe the difference grows. This might be due to [0], but
> given the code is slightly different, there could be other sources of
> slowdown.
> 
> Note, all these numbers will change due to ongoing work to improve
> uprobe/uretprobe scalability (e.g., [1]), but having benchmark like this
> is useful for measurements and debugging nevertheless.
> 
> uprobe-nop            ( 1 cpus):    1.020 ± 0.005M/s  (  1.020M/s/cpu)
> uretprobe-nop         ( 1 cpus):    0.515 ± 0.009M/s  (  0.515M/s/cpu)
> uprobe-multi-nop      ( 1 cpus):    1.036 ± 0.004M/s  (  1.036M/s/cpu)
> uretprobe-multi-nop   ( 1 cpus):    0.512 ± 0.005M/s  (  0.512M/s/cpu)
> 
> uprobe-nop            ( 8 cpus):    3.481 ± 0.030M/s  (  0.435M/s/cpu)
> uretprobe-nop         ( 8 cpus):    2.222 ± 0.008M/s  (  0.278M/s/cpu)
> uprobe-multi-nop      ( 8 cpus):    3.769 ± 0.094M/s  (  0.471M/s/cpu)
> uretprobe-multi-nop   ( 8 cpus):    2.482 ± 0.007M/s  (  0.310M/s/cpu)
> 
> uprobe-nop            (16 cpus):    2.968 ± 0.011M/s  (  0.185M/s/cpu)
> uretprobe-nop         (16 cpus):    1.870 ± 0.002M/s  (  0.117M/s/cpu)
> uprobe-multi-nop      (16 cpus):    3.541 ± 0.037M/s  (  0.221M/s/cpu)
> uretprobe-multi-nop   (16 cpus):    2.123 ± 0.026M/s  (  0.133M/s/cpu)
> 
> uprobe-nop            (32 cpus):    2.524 ± 0.026M/s  (  0.079M/s/cpu)
> uretprobe-nop         (32 cpus):    1.572 ± 0.003M/s  (  0.049M/s/cpu)
> uprobe-multi-nop      (32 cpus):    2.717 ± 0.003M/s  (  0.085M/s/cpu)
> uretprobe-multi-nop   (32 cpus):    1.687 ± 0.007M/s  (  0.053M/s/cpu)

nice, do you have script for this output? 
we could add it to benchs/run_bench_uprobes.sh

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240805202803.1813090-1-andrii@kernel.org/
>   [1] https://lore.kernel.org/linux-trace-kernel/20240731214256.3588718-1-andrii@kernel.org/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           | 12 +++
>  .../selftests/bpf/benchs/bench_trigger.c      | 81 +++++++++++++++----
>  .../selftests/bpf/progs/trigger_bench.c       |  7 ++
>  3 files changed, 85 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 90dc3aca32bd..1bd403a5ef7b 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -520,6 +520,12 @@ extern const struct bench bench_trig_uprobe_push;
>  extern const struct bench bench_trig_uretprobe_push;
>  extern const struct bench bench_trig_uprobe_ret;
>  extern const struct bench bench_trig_uretprobe_ret;
> +extern const struct bench bench_trig_uprobe_multi_nop;
> +extern const struct bench bench_trig_uretprobe_multi_nop;
> +extern const struct bench bench_trig_uprobe_multi_push;
> +extern const struct bench bench_trig_uretprobe_multi_push;
> +extern const struct bench bench_trig_uprobe_multi_ret;
> +extern const struct bench bench_trig_uretprobe_multi_ret;

SNIP

