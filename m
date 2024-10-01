Return-Path: <bpf+bounces-40711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30598C655
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 21:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94771B2204E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D41CDA2D;
	Tue,  1 Oct 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXWe8d7h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03F19D894
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812419; cv=none; b=WAhnQqDU8GXRBhkxgfX45QLpNM63qBKs6/vKKCa1xXkESjpeZE+GHDVKzok0ljxwtKRbKgYP7i1tH7wAjLqqmQXcyDf44/myDtwTDuq3EdYIbVJDxWUkvMXJYFuRu0TqxaaoWIGrf7F8Z+UqDHCjbcW/ZwEiHUjGn/im4p2CSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812419; c=relaxed/simple;
	bh=RRreKsIx0UsgL2WsELGVw/VJRQzSUbUYpOEixKVQLxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpanqCIolnxN3DvdcAXw3F2Wwywol5wSSinqgTJ/LRIKNAOwt9VaDdcT+wUkAv5wV9G5maZOvTxuGjya1FpGa+SjWtuhMbShT164Pfc+7ZwQnnbM/ViRCT9DvOuufSK0NeKOxsxq81oyOalq41KsNatuJOrG2FOUEEUvq9UCEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXWe8d7h; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cce5b140bso3842480f8f.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727812416; x=1728417216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRreKsIx0UsgL2WsELGVw/VJRQzSUbUYpOEixKVQLxo=;
        b=kXWe8d7h86t4v5b5pdQyCM7c0SahZZRCvYHSsKs095K+1ndO1gM78hc+6IuhUvz99L
         kZ2lwR1ZvhJYoAxc36Uf34PzRilKcrx5gG3qdG7R2LbDpDPTQDLzkTexXQTBNKGpW9Bd
         60A6BlOpoHb9SH9R4DQiM4aOzCMXmbmqnv3fAm8cGJVyIcygNgOI+ZEKo+T4FBse5/oV
         AJr+goxQA/dd5jTCFE/GlYzCuWeJE3RdsisAPnJOp33pKmEm0ovknuRL2eXrf0H+BMRw
         Yl/EzEID16swDsfQ6YCMYK5HmqtQysSryZ9jJ+9FZ3lkNIqGktxq/WvDZj0wsBSI8fzU
         iTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812416; x=1728417216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRreKsIx0UsgL2WsELGVw/VJRQzSUbUYpOEixKVQLxo=;
        b=O79xyU6q7mRThmHjTlKWgZcpjSkFrhGMMeTIaDNxKv8Tft3LDCn+0OCS5M6+dtQtpW
         6JlBpkvWVsHe3dRbwvJhW+44V7xQzdmHFq2AnaP18Odmwy8wUWvIklM4sIkR1cz9Xp7O
         aR8jk0v39btW1CO2aS+fP6MujqFiGLwSNCPjBu/g7YgkdmFBdFMHWxWMHuufg7o7fUNF
         LJC+pwMZ6wdGc68msciGaZDnrckDpIjRQaQJzBwADY74Fa5pO7tllOYIJxU7puma2tSH
         OU8CjkWYCVcLNQUtalfBYsOmv307amOQSSDuniLY0lcKe4S16eL1QNz3TjAK+V7d/PGH
         P0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUIf/qLUSbgLQn37+9KolnQ5pRrmpChNFbKnyhZLPrKApKhCjxjH249+bE6oKTElZM0MN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2tLnqppU+POhXmuWYqzBLLMAyhtBj9qLnXJvZ0toKvZjjmJn
	GS5btpi8VRKwMPJyE/LlJcWjUj3WnZgzd74Maf/Pq/7GYQz1nFXAdt6hxB0HawB+6AXLK5nVcFw
	th6lJvKVNmK8hKH3XlDxzM9iLvyqHDXJk
X-Google-Smtp-Source: AGHT+IFHrzMiLfafnimWLRAFpZTjsAULULf5N0iS6mSME6HFG6P6gYEHbSIpzYL9LT6gTKqD0gTzbUpbxtFHwYSiMck=
X-Received: by 2002:adf:fb43:0:b0:37c:d2f3:b3b0 with SMTP id
 ffacd0b85a97d-37cfb8cb766mr418801f8f.23.1727812415934; Tue, 01 Oct 2024
 12:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com> <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
In-Reply-To: <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 12:53:24 -0700
Message-ID: <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
Subject: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add jit
 support for private stack
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Another idea...

Currently the prologue looks like:
push rbp
mov rbp, rsp
sub rsp, stack_depth

how about in the main prog we keep the first two insns,
but then set rsp with a single insn to point to the top
of our private stack that should have enough room
for stack_of_main_prog + stacks_of_all_subprogs + extra 8k for kfuncs/helpers.

The prologue of all subprogs will stay as-is with above 3 insns.
The epilogue is the same in main prog and subprogs: leave + ret.

Such stack will look like a typical split stack used in compilers.

The obvious advantage is we don't need to touch r9, do push/pop,
and stack unwind will work just fine.
In the past we discussed something like this, but
then we did all 3 insns in the private stack
and it was problematic due to IRQs.
In this approach the main prog will use up to 512 bytes of
kernel stack, but everything that it calls will be in the private stack,
and since it doesn't migrate there is no per-cpu memory reuse issue.

Thoughts?

