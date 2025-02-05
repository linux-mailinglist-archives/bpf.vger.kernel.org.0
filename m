Return-Path: <bpf+bounces-50509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF9BA28B1C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5470B3A4008
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4DBA42;
	Wed,  5 Feb 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="X+FZNHJX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E18C11
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760303; cv=none; b=rGp+q/HSpMQcHWMJ/vtjbkWJdDdxA3JhsAFUrh50q3DMLePso1KhIiNaXBaetAxcWV57wVi04mk7KWsPoig7qkAYffpYEiFbbhEbSrVPBZ/PbSBLSzne3iuL1qVP+q9xb2E4zasZ1K97EA8hXA2oy7CnMU3vi8RsyLZkgCHaX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760303; c=relaxed/simple;
	bh=X5n8mp1avloatsVJEz6ZjXiX0AtUxoGENvxl2NvT00o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iHgAi21Uy7xCxCBfYMsuuhlYIctp8PkjjZicJZWxNghoSZgmiqd8LUlLXJc3QAfnCV8AqT5v/v8jSlv6G1qXTkpwGzHN0jdyHCA6Iu07fx6NPfQsz0j446tMiJwkw+gFZTy6AZoMyps2wmlxivsIhhAGyfB21yJW/h16zuzEOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=X+FZNHJX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9c97af32eso2396409a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1738760299; x=1739365099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zf0MpoNwU6fIExZpB5EZYJraU6cCWlfm7qvqt7lrs4E=;
        b=X+FZNHJXkR0S6gTf28bgdD4HJA3kXuiVXAzmRkGGgjIn8T/TziJmdpmpV+A3VEKS8+
         AbWBK5SJA/JLlmXZ6XNpFyH7nJaslKeBSbLBMBa1c8SY7/r8Icr5qTZG0kJMzM8y+Qrp
         3IX+G2mZhf5UZvJ5wrTs1ONX0lhBe28aaDLoOu8Pu0fByzghyfFK/j2eKKw1BU0rJ7Yq
         wLk3wkXITqhic48xmyxRxXrcB+e2w2zLPKtuN1YCqpB080rQhn0s4d5clSN2Jyc4bf1B
         zyH/aw2ZuOO52btxihO7mezetbmV/G+DwQulZPoOlWkpY23rUz46geLrdXASkaw6zNWY
         3d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738760299; x=1739365099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zf0MpoNwU6fIExZpB5EZYJraU6cCWlfm7qvqt7lrs4E=;
        b=VY6OME+icIhb8wowhCJ71fj8Z7H9tso4PjetbDyCpTqJfi2Bxjsxlit3O3Cr0NvjbH
         MRA5dFqAP1+8cZ9pxPOBlbTcq6IoM28LXSCbXdiipjnCVhs3TZ7XT0BNIykYga8nm1ld
         kmVuyr+3NrMi5m97Q++42slasPSozr41X4mIpiAo+FzlmUGi71w1TqcfgiFeNQzNfCth
         hyddcjXyckuQWjGh2e5/BdkLoypvxil22wLFob/Q5Byv52cA51ylbL+lKKSQe7fzMlCe
         6tCuHizhH9P4ooIJSAR/42sOePZm8oio3UqIfSgdZ9KSOzFnsvD2GsWR1W529PXyiTvS
         s0CA==
X-Gm-Message-State: AOJu0YyOXKe7SjRd1kEmvvbEWlkYZSDVoM3Yip1A126mdlOgGOCNYEJR
	kMHM6Gd/ejCbdkr5JwTjc1V75VqIu0XBSGC25L6/0a5cUfDMS0ruFHtV6dtQE+G1PA+xVauB/nX
	9nSh6KuUYIDiwwzYmf52SdFUsTxnCwsztuTINE7C83ZrL1X6wSPg=
X-Gm-Gg: ASbGncuGz/qNjEeSY/cMITOGhN0WUa/t/0kjFrNgYj87kGJrFcI5jRNTJQJik/ljm2j
	5lUsRyzM0JI9v3KTmV41WX9jlI4TgoK46hm56tay8N96NrcAm4IPCDpENvSWPy9o207Va0P0lJa
	BA/fGuQx4WzW0cSiWzRlYgymlDmBT9YtQ=
X-Google-Smtp-Source: AGHT+IFK4IMdT33IfGitl5dXsl9qmp+iAwVKevMndk8x1kmRImXD+OET+gN/Q7D8ab7Anrko5VQZz46BxoMqGV8X5Uc=
X-Received: by 2002:a17:90b:2e52:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-2f9e079b051mr3642857a91.21.1738760299228; Wed, 05 Feb 2025
 04:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Wed, 5 Feb 2025 13:58:08 +0100
X-Gm-Features: AWEUYZm5ypcMLXf74V8a7zGcZyuQaIBYFEXYa3IIx9q3bYDtSOBj_xB4y61oAZ4
Message-ID: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
Subject: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: bpf@vger.kernel.org
Cc: Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We are in a situation where we're frequently updating a
BPF_MAP_TYPE_HASH_OF_MAPS with new data for a given key via
bpf_map_update_elem(). During profiling, we've noticed that
bpf_map_update_elem() on such maps is _very_ expensive. In our tests,
the average time is ~9ms per call, with spikes to ~45ms per call:

Function Name:   bpf_map_update_elem
Number of calls:  1213
Total time:            11s 880ms 994=C2=B5s
Maximum:            45ms 431=C2=B5s
Top Quartile:        11ms 660=C2=B5s
Average:              9ms 794=C2=B5s
Median:                9ms 218=C2=B5s
Bottom Quartile:   7ms 363=C2=B5s
Minimum:             23=C2=B5s

The cause of this poor performance is the wait for the RCU grace
period when map_update_elem() is called: after the update has
completed without errors, it calls maybe_wait_bpf_programs() which in
turn calls synchronize_rcu() for BPF_MAP_TYPE_HASH_OF_MAPS (and
BPF_MAP_TYPE_ARRAY_OF_MAPS).

As I understand from the commit that introduced this [1], the RCU GP
wait was added to ensure that user space could be guaranteed that
after the update, no BPF programs are still looking at the old value
of the map [2]. When this commit was introduced, the RCU GP wait also
covered a potential UAF when updating the outer map while a BPF
program was still looking at the old inner map. That UAF was (much)
later addressed by a different patchset [3] and the discussion in that
patchset [4] mentions that maybe_wait_bpf_programs() is not needed
anymore with the UAF fixes:

> So, you're correct, maybe_wait_bpf_programs() is not sufficient any more,
> but we cannot delete it, since it addresses user space assumptions
> on what bpf progs see when the inner map is replaced.

Given this, while it's not possible to remove the wait entirely
without breaking user space, I was wondering if it would be
possible/acceptable to add a way to opt-out of this behavior for
programs like ours that don't care about this. One way to do so could
be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
something like BPF_F_INNER_MAP_NO_SYNC. There are already map-specific
flags in there (for example, BPF_F_NO_COMMON_LRU or
BPF_F_STACK_BUILD_ID), so it would fit with that pattern;
maybe_wait_bpf_programs() could then check the map flags and only
perform the wait if the flag is not set (which is the default).

In our case, we don't care if running BPF programs are still working
with the old map, but for the thousands of bpf_map_update_elem() calls
we're doing in certain situations, we're spending _seconds_ waiting on
the RCU GP, so adding something like this would greatly improve the
latency in our scenarios.

If this sounds like something that would be acceptable, I'd be happy
to make the change and send a patch, of course. Any thoughts on this
are appreciated!

[1] commit 1ae80cf31938 ("bpf: wait for running BPF programs when
updating map-in-map")
[2] https://lore.kernel.org/lkml/20181111221706.032923266@linuxfoundation.o=
rg/
[3] https://lore.kernel.org/bpf/20231113123324.3914612-1-houtao@huaweicloud=
.com/
[4] https://lore.kernel.org/bpf/CAADnVQK=3DtJRhQY1zfLK2n7_tPA5+vN8+KqWmSLqj=
ubUuh6UFAw@mail.gmail.com/

Cheers,
Ritesh

