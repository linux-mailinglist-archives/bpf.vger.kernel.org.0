Return-Path: <bpf+bounces-41143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8E99346E
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D1B22F01
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886E1DC1A7;
	Mon,  7 Oct 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq/js/em"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F71D9691;
	Mon,  7 Oct 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320730; cv=none; b=Iu/LfFqC0/vsgOUTOIkNTGqa+kJx9K2wshyviFP6bniQYjoJicOpms1xkTLdipIxuwvptsxy6rxPv0zijqoNCi26AjkhNvjrbNayXsBqnld4ZN9A7lBw/vP6/funSAqyVjZPi7R6B5BYNC34J2Mjkoae8SaYod900KdzT7anWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320730; c=relaxed/simple;
	bh=W9t+CJDGdQjY/tdFRvwaw/Flp6uBpy53jglHZub+DdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly2S/SHigNRif/+C7998MtTTZsWBN/LlK4M6dd0oDn4rdgmJ20aMagz5HbAiKmgh3qH6S2oK3hz+Yn9taSQysa6V6snd65XOGOXEMhykR25Wa00NW8sMh/wtJO/G+O9lAdw4T/WL+WF66WYlpGlU5JWE3Q8UWtz7zXLOuw7e8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq/js/em; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so42736085ad.2;
        Mon, 07 Oct 2024 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728320728; x=1728925528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJvSdXqaEFcuQy3Y9WUyVakw1biqWpzJyfw0T7fy12I=;
        b=Sq/js/emHHu9F5h4rrkJSwHNhOaXBxJQOvA0rQzl16cE5JzNyk1G+a2qxI7WDkj1Xj
         yaSraUmesylChCt2stoJ51+JuymRh64/rOqdch+qBP1HPsPQ4xB+sanib6luMwSlGbYD
         e6j5jghdT44q+YTtaeCxQzuhAh90UPpAMwcv7m3eiT2cqoa6GTg4GLxelL23YkDyGX+6
         qWdFBy7vHpeUGgKZx+JYJ6zdblfOr6VTbESjWP5/hPaPtgGNYRqXo1NATHu8zsy8mRqa
         Ek68A2uesx/CXIc5kr9TsSSMMNujNhu07+BkMjfZryDCOe5ZVYgUIDbX7H722x4PF357
         4wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320728; x=1728925528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJvSdXqaEFcuQy3Y9WUyVakw1biqWpzJyfw0T7fy12I=;
        b=CZp+EEpVf+0Gxr4cxoFhiawMwtu3vzz+QTqk7FOJ10nGw1iXJCScFVS8En/+lJaiQT
         2JuifRqZfFzKB1iYaU0SD++rkUAtW1K0ja92t8V9ZHjocO2YuIn7+NOrbrDw77fpCVuZ
         UTeQfDDuJZAFdXEdiLyXK6dhNcrL7m9SKcVPl7BKcwls+EM1wqnQ2h7RNGhDFXq5B5P8
         XHPzyKFYeVe0MciXj9QgK9p8TulGjRfW0akxRWUAp1pG5U7wFdbloccNyGp4U7vlLZjs
         0NcoVQRH8tM2+RceK6ggFQ3i94+NVhwe9iweWvlaxetyYCH6Buh1+CLnXt2VclGDbCeE
         0s3w==
X-Forwarded-Encrypted: i=1; AJvYcCUpDeCnG3QSJtklTlEVdaIaNawNOJVsSu6+KNhjlX6dZkQv8B/gWCbfnnYjmrN1lWPNqFjQEfnSMq25mweQ@vger.kernel.org, AJvYcCVEmxWEpw7yydClAWP2EWQqQtugF2FKIeKCpFQjE+F6+M/bxl7E9zjyqKMQ7snt2YOahac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVRnJVInpw9/mKt5uu66WZENhQ4hGbracQ1PqYnXllm2CDdB5
	Jc1c3BPfPGEBQrpDKAk1ERbwG8s5iWfUuYttkSM9eQeWcpadOtojVINc/4Fsiw67ZP2UuHbsana
	EjTA9Y9qmfDOpn6qkVf/9oeJbPuk=
X-Google-Smtp-Source: AGHT+IFuIzzkQ+aYhNsqrwuq62kan4xtPQvwQfRQIyymgXebs0Fas5ZkvAOPaRjozaVR8s+SIeciuEovhswzVCTQFMQ=
X-Received: by 2002:a17:90a:6984:b0:2e0:a4ce:108c with SMTP id
 98e67ed59e1d1-2e1e63c1750mr12218257a91.40.1728320727891; Mon, 07 Oct 2024
 10:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001225207.2215639-1-andrii@kernel.org> <20241001225207.2215639-2-andrii@kernel.org>
In-Reply-To: <20241001225207.2215639-2-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 10:05:15 -0700
Message-ID: <CAEf4BzaUUgtYiCQOhKps-UY=_8ANyoWbkpHqFqc2co9Jthfzew@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 1/5] mm: introduce mmap_lock_speculation_{start|end}
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org, 
	vbabka@suse.cz, linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	surenb@google.com, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mingo@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Liam, sorry, seems like I forgot to add you to the entire patch
set on initial submission.

On Tue, Oct 1, 2024 at 3:52=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> From: Suren Baghdasaryan <surenb@google.com>
>
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google.c=
om
> ---
>  include/linux/mm_types.h  |  3 ++
>  include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
>  kernel/fork.c             |  3 --
>  3 files changed, 63 insertions(+), 15 deletions(-)
>

Are memory-management folks OK with these changes? It would be nice to
get some acks, if so, and I'd include it into respin, fixing minor
things in uprobe patches. Thank you!

Note, while this is initially needed for uprobe functionality, having
an ability to quickly change whether mm_struct changed inbetween some
speculative querying is generally useful functionality, and I believe
it would help eliminating mmap_lock usage from /proc/PID/maps code.
Which is a great outcome for everyone, as that mmap_lock can be quite
disruptive in production workloads.

So please don't see it as some irrelevant uprobe-related requirement,
the applicability of this is much wider.

[...]

