Return-Path: <bpf+bounces-41658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9C999554
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA290285878
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669661E4938;
	Thu, 10 Oct 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFHZG1QI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F61A2645
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600020; cv=none; b=OUjS5zOt0aAvvUN0jMqAqqqGegn/hIKQt3ECjkkeXJd3HHfQWGeeCZvTX9mzCT1ohrqI/aVa0XcncJTBEe7T8t0mn3DJCfltMF/igCadL7pJTAbrPPabG7Cw41mr0wmf01R4I/3s0d8ZwXFu2zMYicsGS8L/ld8k8+SPtY6q9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600020; c=relaxed/simple;
	bh=V5T5c25IRDWZVpjkvkqlqxC6Dsu3ms6wjSHeTTxiZ78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXoD4z+1dryak//96XtPJ+5MapsWGn+w1jYpLrvlQ5j9ACepyzYlv9QFGNird/j/6Gv6fH267gI8fl+D+Sxfw88S/f80OZK0VKDuEWZI8jov4KB7bI8Us/uM/0c73KUd3+qTLmqU/1NRH5QhXk4BYRKt1ebOsNQy3FVmxieeWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFHZG1QI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e01eff831so1101093b3a.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728600018; x=1729204818; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1LjTgja8ysVmFd57JavX+oAOsyOrsqaUckWVOAjS9g=;
        b=OFHZG1QI4YoLSdJM8smiz4AsNk+dAh+Mv4opBpwC0EYNZYj6QrnQvnJl5VZTWN/qFz
         Ew1Qeyvwssz3JIzF99G/9regoJvwzxu/FXLOwuuYUOrwuS76wNVW2rR7r1HnXKpRcr+h
         phOOfyOUOsufxnd11OZyG8iSCKKg+rNzZktOI0s9xGOeBsmiNYPBifhgX0W3JDkiZvMi
         M5KseUnbsW3AZMGkvFO4UyJlGw/ezIfkO69627uW25V5p9L+tieKehgu0CVhFLHKfMuL
         M7CRQVJ5xkgzvpjB0WRSuOxEwTG2chqjzhucxYUUED0Sa1/UW6LmMrpJ/9CGQx2c0Av/
         AWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600018; x=1729204818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1LjTgja8ysVmFd57JavX+oAOsyOrsqaUckWVOAjS9g=;
        b=vnOoeDPCvVVwhlmGY6ApEhKkOoF5LOjWgz5gYpf4mRuPQFvWMuRVcQTtqJYpZ5gmiI
         UEsPtWALxqsY99eqX7OcSRBEWvhi8ruwMuFNMqwhLHTxqT5cL+pCusBmWnQWl70mvy76
         8YLBb2uBPgFmrKcjfzkZjL2JPqT/lcM08rX+b6lyYwlLydsvEGD5N6Atbxn+p0BiEtjZ
         HOSi5WltgebEHk5xnI/kuQFUyjkRk2AyeXR+HXlbpYnSyDwo6piJQWpVLbct6Y4p7Wcz
         euQFYhzOwaWhoDaWO+JzZRE0l5zpARhQZC9LLVZCEa24pFzqVarK3Cw3DoeBU9F856qI
         Nqfw==
X-Gm-Message-State: AOJu0YyCt2n8UaZIp8KR3tYSnfC9uXiibxeYKLQ/BEEYcmYJyH2rHVCD
	sg0btuXi5RyN4XutErQq8d9/zxzfKmomJudpTFq5HzVRUCmfr5CC
X-Google-Smtp-Source: AGHT+IFuF/CMIhLr/59dP8y6hUAgbOkidmN0kiTxgk3wFt/72QnQ7tixOROh/CIz3v0UWeUCh8jLWA==
X-Received: by 2002:a05:6a00:c89:b0:71e:19a:c48b with SMTP id d2e1a72fcca58-71e3809a1d5mr1074995b3a.22.1728600017819;
        Thu, 10 Oct 2024 15:40:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:b5a8:9248:40d3:6020? ([2620:10d:c090:600::1:770c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba35fsm1525999b3a.168.2024.10.10.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:40:17 -0700 (PDT)
Message-ID: <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop
 back-edges
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 10 Oct 2024 15:40:15 -0700
In-Reply-To: <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
	 <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
	 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
	 <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 15:13 -0700, Andrii Nakryiko wrote:
> On Wed, Oct 9, 2024 at 6:09=E2=80=AFPM Alexei Starovoitov

[...]

> > Something should be done about:
> >           71.25%        [k] __mark_chain_precision
> >           24.81%        [k] bt_sync_linked_regs
> > as well.
> > The algorithm there needs some tweaks.
>=20
> If we were to store bpf_jmp_history_entry for each instruction (and we
> can do that efficiently, memory-wise, I had the patch), and then for
> each instruction we maintained a list of "input" regs/slots and
> corresponding "output" regs/slots as we simulate each instruction
> forward, I think __mark_chain_precision would be much simpler and thus
> faster. We'd basically just walk backwards instruction by instruction,
> check if any of the output regs/slots need to be precise (few bitmasks
> intersection), and if yes, set all input regs/slots as "need
> precision", and just continue forward.
>=20
> I think it's actually a simpler approach and should be faster. Simpler
> because it's easy to tell inputs/outputs while doing forward
> instruction processing. Faster because __mark_chain_precision would
> only do very simple operation without lots of branching and checks.

I think this would bring significant speedup.
Not sure it would completely fix the issue at hand,
as mark_chain_precision() walks like 100 instructions back on each
iteration of the loop, but it might be a step in the right direction.

Do you mind if I refresh your old patches for jump history,
or do you want to work on this yourself?

[...]

