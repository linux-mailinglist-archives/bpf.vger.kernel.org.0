Return-Path: <bpf+bounces-29220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC98C14B2
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278881F22E2B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDE77119;
	Thu,  9 May 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/tN31LX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3018C2ED
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279102; cv=none; b=AQ5cRi8Wrq1fO8q5YXB1hB1P4STZnyzSeWoxUn4K9lqhYKEI4GHxKxfIT0oI7fiKsPxaoTcK4yPCYjFiRAvXIWWMY5WFiDsJIEBGDiIT6p3CP+ZXxekia9JJRTrLqQM65Gc7R/hn1WQWWy/jMT5u65I6I6UcZo54/jJysznTp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279102; c=relaxed/simple;
	bh=jjmEOrKN1qk2ukqU9j7axOPa2+Ozs/1fUptLxK0qwVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzG8768XAWWbY3RUmXpxWIrmOqo7pcJJfOAa3nI2+dGOVQ0TQv9NawakA7ukCT0pTJi1iYKhoJuCm92f2hPdBwob6br9gT4FNWEiFkvEwAhscIcZsB5c9Bylzoe/CZ4qt5WSqjtFy0nHJ+R/rnCNwWB+FSQ7azuVug5RBJJoqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/tN31LX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db17e8767cso15736461fa.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715279099; x=1715883899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjmEOrKN1qk2ukqU9j7axOPa2+Ozs/1fUptLxK0qwVg=;
        b=Q/tN31LXslpSm/FZb97qJdsaJQAQBoS3TavcqmHgU34QyGbBrQ74dnJMz8dgbKbWxx
         8Jkdl7lKfwoyxgXSmepVAV8xsMB35PDAKlK35DIGX8Tc05ycb/0G/6sNNXprX2eevcj/
         9XbjoeeczhBq6sq6Gs5Qwe8kcrH2VbIGJm5DRUJ02bvPMjzSORkbGA7t+2orinj9x1Cl
         dpZVlYHPNT0+9znU0qYnCj81GRq901i0N7395i6Sy4z97yEa96152X6jhd1r38UMD1wn
         uyPK2ZV7yArLO3WDp3qROXYyyqGnh2yjFtOuQFzhyz6NgD0982PC8ltHF6opiRxWo8by
         dB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279099; x=1715883899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjmEOrKN1qk2ukqU9j7axOPa2+Ozs/1fUptLxK0qwVg=;
        b=PErCxBHkwkxjH4fGUJNKzo7wEiwpLz90cULoDAmL2HJRTmhG3sDE+i1MTBGqDxMb/l
         yEpbEcITrFuPIhlx4yg1Mhy7Yh84bDJxM8N9wfuur29fSO6ZIrMUU84Mv9Ror2CZ98e1
         0Vep98loeItmm4iVW4G6MOG4rJ11jyz2YeiBao3EV2oHTPHWRyVTFQ2JFRpOy5h8/MKj
         QWir/uuW9cdJzEqdossSno34tbYqgbXPFWYjCbV7Zri2k6Rrocu1aYNdYUuMeXWqqxt1
         0+//TpE9/r03RFkSkMzybKCZFrK9G7qHKSyDeRFOK7dE494uYOo2EhJO8uJ1+138584c
         my0g==
X-Gm-Message-State: AOJu0YzxNIyK7pEsmaqYpgFchMdKp4KvTawLVYH0b5y4jeO68OZSNDY+
	4sB9OVLvFp2ErCk23X89DMHoESaJfVTlO7qmpkepbuCtYucbPBUxm+tfJjqSsMX44eE+/l903t+
	UQJgFurytE6LbM9GvpfDalG6hIMY=
X-Google-Smtp-Source: AGHT+IEnHKKIh26TFnwAvUhNQ0jvd+ReMtmistamADZS5QZOx4fBGcw5z/6AsvIjQgnmbZgT/pVp7X/uXFv1vXgKFHQ=
X-Received: by 2002:a2e:99cf:0:b0:2e4:136:2d66 with SMTP id
 38308e7fff4ca-2e5203a4ad7mr1134941fa.48.1715279098556; Thu, 09 May 2024
 11:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509175026.3423614-1-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 May 2024 11:24:46 -0700
Message-ID: <CAADnVQJM8Ut31jyNTiKz=p-08=kbRR2_1wUN+KBhGrwyzeXh1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] selftests/bpf: Retire bpf_tcp_helpers.h
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:50=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The earlier commit 8e6d9ae2e09f ("selftests/bpf: Use bpf_tracing.h instea=
d of bpf_tcp_helpers.h")
> removed the bpf_tcp_helpers.h usages from the non networking tests.
>
> This patch set is a continuation of this effort to retire
> the bpf_tcp_helpers.h from the networking tests (mostly tcp-cc related).
>
> The main usage of the bpf_tcp_helpers.h is the partial kernel
> socket definitions (e.g. sock, tcp_sock). New fields are kept adding
> back to those partial socket definitions while everything is available
> in the vmlinux.h. The recent bpf_cc_cubic.c test tried to extend
> bpf_tcp_helpers.c but eventually used the vmlinux.h instead. To avoid
> this unnecessary detour for new tests and have one consistent way
> of using the kernel sockets, this patch set retires the bpf_tcp_helpers.h
> usages and consolidates the tests to use vmlinux.h instead.

Nice cleanup! Applied.

