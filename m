Return-Path: <bpf+bounces-34939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2D933530
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D4F1C220CB
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3F1878;
	Wed, 17 Jul 2024 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YhFzIJa9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01EEC5
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721180975; cv=none; b=FgypR8JhDQ64GDuIx8qzmnxOBqQSgjjOTwWSm7avHV3vd5wRvLbwOGQ7Q9vIt2vKZrRgZ5eEFBDJRwR4+TERnH2irfV+H0f9uX2EnJ1sdO+tu72vbrph67wMnua4TsViCQUAJEYbxP5DyT/ZtBmicBH08UMSNutA2JiygqU2suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721180975; c=relaxed/simple;
	bh=C9kHaF8BJFggbOsxgqRYgKhYb+mAGNQWTapbW5j45cw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu0dZKyTO12jC6yizoY1a2tGhhu5EOZppzrHkW3bjtutkdwFC/h+yS1QU7InCMQ7spfeaa4lZvMzBy0UKO5u8cSWLp3Dzk3IbCSWtDg8xbIMhYVtlKUlm4Jci0yKilJxI/IElQfh896iMPxEyveMj6jwmqF/FgNcA4wbkqH/ZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YhFzIJa9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721180964; x=1721440164;
	bh=veoMrPJVHQtRoozU58bU6EhrDBUZPg8oaWg3fNMkYCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YhFzIJa9Y+aUiAaT0pzhe9aM9sj3GzfokyxCUOpBDW7okLZKEVFlGoyxq65HlSZCv
	 ZNyOwoQgiLFxq6CauRLz5leWY0/059Bn1+GLzb7jtwCCN07wbRE66nNDivPK1Dqs7o
	 UkdGkMwBIjjR04FwWKKHthfXROf6sYZepJY4SVWMUF2c5Kf+olxi5HA7DMIaLvc8BS
	 AzJQixp8wIZwgHeLLPprYv+Y905wh8uP3s+NDwifmke6TF5Bm2/fnlDakglRchA8ni
	 irORtU7fXYjyy+L1ZNUQJEWUjx1rqpusBW9GCBbPFZ7rZKbYVm4PLSPm7vBBQHVEMx
	 AiQznUAQ1lBdA==
Date: Wed, 17 Jul 2024 01:49:20 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <6lm_HGbPUpe3NJnW9UZo26d9QUQvsCdcHbSrKKvbbH86eSmEkdSNfhB1svs-bcsLoyjm5Pod8MQU7-rtGUG6BFhfAkPLgUstbkZZ5J5nI-I=@pm.me>
In-Reply-To: <d52ab2026b37ac9e19a3181f7b81da1e1afb9365.camel@gmail.com>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me> <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com> <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com> <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com> <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me> <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com> <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com> <erDl1cz7tCQTTy5Z2SJzdqYmOTcoUjvgaU4m6Nq2ZlbMvUQxP0xnS2y90zhgQUQm6ygMN9dZdnXiiQrRkaia4WsX9E2wULrvngXmeTTggNU=@pm.me> <d52ab2026b37ac9e19a3181f7b81da1e1afb9365.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4ec438510f89b01ea6c738e5ba34f32a3336b3cc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 16th, 2024 at 5:57 PM, Eduard Zingerman <eddyz87@gmail.com=
> wrote:
=20
> I don't like .test.d dependency on all .bpf.o files (the v3 change)
> as it does not encode the dependency we have:
> test_progs depends on core_reloc.bpf.o at runtime.

I talked to Eduard off-list, and in his view this is the most
appropriate way to leave a catch-all dependency:

    $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_BPF_OBJS)

As opposed to original:

    $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:=09=09=09\
                      ...
   =09=09          $(TRUNNER_BPF_OBJS)=09=09=09=09\
                      ...

Or v3:

    $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:=09=09\
                            ...
                                $(TRUNNER_BPF_OBJS)=09=09=09\
                            ...

