Return-Path: <bpf+bounces-56467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9BA97B5D
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4393177ABB
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5D21C178;
	Tue, 22 Apr 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVyWpmh4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51C2153F1;
	Tue, 22 Apr 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365896; cv=none; b=NAA7ub8QFEKYpOoPgTlSxWUJWKMVWK3C5zY+84AgTi2tAH3qdXurPcMDGV1iSepAyW4joKhxo6C/FH9QcYiNkmywAHIM4djlEUY1zlRPgmcW+NTnXCBir7/BOZ1zBDjuVburS/ZM/1f3LDqKlNPahsg1bOnljlA0HK78/+BxLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365896; c=relaxed/simple;
	bh=47mgIUPEmnqKXz/PLYEKltr862V6myQcvKqgl3Z+nec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8fab/4X7OeZz9e04VyBcon6iCe+3oPFgUt4F9mQKw2gYKTyjOtjnJxiElgdBMf3ATRmQ7D4UkQwv+ytD9IL59qedisbvfETEvZqp1w5lDIQP0V36tn+vr+uuoaTTZd8u4af5RUia9i+2lBAjDo79V7aWSQaQCF4cwLrG+lxX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVyWpmh4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so988465966b.2;
        Tue, 22 Apr 2025 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365893; x=1745970693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg+s/Iw6X8yaE3B8JJTx72qYDKDFUZrmT+dSRqA4IeI=;
        b=IVyWpmh4oY+omzLnN6uua68mpqe2ZUt07xsU/K8/Owj0p5/Hf6brhgpjUAZra5aZ5L
         9iIQbCuRzYeEeNVmffb6sMZ5IEJBmIuI8YDlMU3hX61APcXYww4UD+ybBib8BPbsEKPr
         g4/4kfbOoPuqppBYzvqiktIwh3C8uomDfdZpQjRTYLGzevJBH8/J3DGx/zaSqijXhR70
         DQo2R4ycNqnYKwMYt6CjLtsfNMPta4JrxNK2LzjEIqP77XRHxvIYp/TRiScHSrXiZ1YW
         YYjvnGeOasxX7yrkZKZ6tErN26fTazGeczchIQyHkiXEmRCV/T1FbWUyladWvG8EENho
         JPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365893; x=1745970693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg+s/Iw6X8yaE3B8JJTx72qYDKDFUZrmT+dSRqA4IeI=;
        b=plIcFFwf8XRJFOcwNq+LcaqWGMsS7ICRK38wYETsYwgnRVJ6Y7abFys4Q3bK7Jm2m7
         J6PDXq5DPsvWkQRGntofzXLlnfryfvDHLWYCQZcUmDYUIiJeg1ApwvNJyetKpi1snsPa
         F4hUepBV/AIARHcEk9VWyT+vdRp615o/qokfq2rKz4QH7VEKoU1zA+XoHVmcRitFOd6o
         i1KNt4L2Pp8RYBYKTMrZO2HAXIqvBuRZRPh1Jz9GFb0puyyP/wv1lSQxT/ao2RGDAGQF
         ArfU2BxdqeMYufpAgLKIJ5zbvkiH0s8+J4sZaX6E4t8ytRbJ1r1o5CdZP96YOijy+0Io
         ajYA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAqO7zzGelZ5IImywc+VouGNxnzvTgFLj6VX9MSkXQapPpPnRfSONHb2WqxEAr9T7s6k=@vger.kernel.org, AJvYcCXTT8bku5EVjyMW0jiSVKZrDLImQVuEUdgZTTso5HmC7xaLRpNQHYKYcVdDRIpcqUChp/TsFv140SDryLxQ@vger.kernel.org, AJvYcCXnS36W6trgEELN/Hk9C0cfwIHDtXzwQoOqIen+4p5LJBTtL7xyuYwNd80WvxzqwAC9iiK2wCjk0bUhlPLnkRlNLYk1@vger.kernel.org
X-Gm-Message-State: AOJu0YywwnhLpQKNesefotGNPbeoX+8yrRT45/dBErYKRG2SVGMVdhKv
	atAVC85ZnHg7qnpJw6/SmW4HmQj0M7RMhuB7twIrHkS5McAUHQHXkRi7JaxXSBztGExIYey9b9Y
	kVlJQSQq0Sakw1g9Y40GeTMT9xjk=
X-Gm-Gg: ASbGnctzqZ2oQRr1YZNnN+/nW0Pn5On+ucqR8EoyZ7ecz2OepgqzDNoCcj1vO4Tf3yA
	rn82b24djxThHnk4lcPtxGoXm4INLerVtTr+9twcxXz7QWq4Cf3L1PiS9KSnH43c+Vevv0IHsRL
	FNgcYTULtFCXozHU++HuoNe3RFIH77GYQJ+650ENrUgMAJDkMA
X-Google-Smtp-Source: AGHT+IHyAxULzTdEALIdLh/47hFrO5HqVTo+nyAjApTOHGeMs7oYrbiYnzS/P2SIpTRme5S1tLtozFtUcAGPdo9/uqE=
X-Received: by 2002:a17:907:da3:b0:ac7:cfcc:690d with SMTP id
 a640c23a62f3a-acb74db7dd9mr1571295566b.40.1745365892975; Tue, 22 Apr 2025
 16:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-9-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:51:19 -0700
X-Gm-Features: ATxdqUGZOr4xpWeNMWzNKVtyrAwgvT_FIS8Dc_B9jZszIO0y398gDWRx3eXT9Hk
Message-ID: <CAEf4BzbBykRTQJxNLYN5zXzdK+xMMzNT9LCRp3+N7R2=+xbLZw@mail.gmail.com>
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to add special mapping for for user space trampoline

for for

> with following functions:
>
>   uprobe_trampoline_get - find or add uprobe_trampoline
>   uprobe_trampoline_put - remove or destroy uprobe_trampoline
>
> The user space trampoline is exported as arch specific user space special
> mapping through tramp_mapping, which is initialized in following changes
> with new uprobe syscall.
>
> The uprobe trampoline needs to be callable/reachable from the probed addr=
ess,
> so while searching for available address we use is_reachable_by_call func=
tion
> to decide if the uprobe trampoline is callable from the probe address.
>
> All uprobe_trampoline objects are stored in uprobes_state object and are
> cleaned up when the process mm_struct goes down. Adding new arch hooks
> for that, because this change is x86_64 specific.
>
> Locking is provided by callers in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 131 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   6 ++
>  kernel/events/uprobes.c   |  10 +++
>  kernel/fork.c             |   1 +
>  4 files changed, 148 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

