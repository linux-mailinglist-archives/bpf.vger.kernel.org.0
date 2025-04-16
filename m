Return-Path: <bpf+bounces-56067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6C7A90E12
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDDD3A87F5
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87723537B;
	Wed, 16 Apr 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNptsbOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0E221DA5;
	Wed, 16 Apr 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840560; cv=none; b=Tr6S7OSW9znjsU4YWOYhR/5MaG0vnPPz/uxFjyC6YhKBEKYZ3kA8ECJbcEZbq9sXHf38BoDw0juvi86m1P95SaYSk2Sk7uaouqRdmZDB4c5QEE8U0j4/pS8lj89puaiG7fMSIC3x4yUWpXqdAxc/gZ0rd4usbpD4uimnTFb0PZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840560; c=relaxed/simple;
	bh=lhcwbKPVRhdT6kYZMbI6MCrEmej6mQZJQIMAK/iLsaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2g3z/Cjkh4BTyxf999RCI55Jsl67cee5TnydrVBcrvWNk/bTIo71ueImvpJ8H+f4Ygw+8dOn3fffIKBJdBYqp00GleEw3ZxanTaynrgqwFbI44/nQkcQWwo9EqPEzgd+6DWF1rO3XELearuQJOzCWGV2FG5ufeVR6NWKE4mI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNptsbOK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399838db7fso160774b3a.0;
        Wed, 16 Apr 2025 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744840556; x=1745445356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvgTWFOB2qqsT2gvW8Ts4LYL+E6VLhdjnWeu9wuM0qo=;
        b=KNptsbOKsYCMGMlV2Yp+fhWpI9vvmHurRB+pV07gE/Iw+CxJjM7dcE8CJD8LJJu0Ci
         9tMWZsFUBacReanciMO8qFepa0bvK81h5t/hpLgZnKT73Rv5TgTwmLcDYSM+6G8PRHZc
         u96z5zGGecgf53XnVT3rG8zCHuZB7X/zDy39RTf+xxpEtEDbdDzGFt/QbQ9hsjIGOLfn
         dU1iUd0pzapdYS5XwoT4bxaR9Vj6pHi1nHV5xJgnszmbpSy/mIx7xAQrecO/VSzqYrmF
         sOTwZUDMq5D2WSKq2cubVI9ovGjRu5oveABC9bOVf5KJOoGxdL4KZKcTVn1XQW7Fyf1E
         qJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840556; x=1745445356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvgTWFOB2qqsT2gvW8Ts4LYL+E6VLhdjnWeu9wuM0qo=;
        b=Yb92iexwJkQwjwxg+UtmFA0UqFwB2qsqsAyG3kIu6GGDXd116C2FUBk7AurK/kQZb5
         3j7xBeslbgvBIWAB8coHaK9uU1NHsUJzzpBY3a0/ZAQOCLHgTaNfe8hJbGrHntDdT7TR
         YDYM/QwcUxJp8d0J0QmiXLzrhsr81J76yY3D/hkj5G2V2xukcd/+yFCLnUgmS11t7gkX
         RDmgD7Wm9EqBaLLZpHuK8aftfdHyoJMvQ7RzBYAI9mpVNIwL+TzsL1lmZ8QNJTSBPMDd
         TW9F35MpLp/faeWAjfNfDvbKqAwQ8kuxfdOOEJKFNIrnT7DrHi7B673d8TgNroJ2GUvJ
         36+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRWoBGilHhFPbFn+7F73L3q4/skgLbSSNAdiX5+YrUHtZe+7W3Eev+KlZycPexrjce0AuWZuHVLfOOqj7Y@vger.kernel.org, AJvYcCVevcOy5NnC+aFvKuxvXoVj2390lW3mk/a17fH6w+nYScUIy+sBhU3AYmuvvY/tb4a+ZQAmeNl/xPRznW4/je0kpAnc@vger.kernel.org, AJvYcCVh6q+SEo7qZNgnzIEc8GU96cDDdIE5xL4O88dCAlRkXccJPs3yjbn0MG/PO5TS9uohHFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wyPfUUUYQhdgamXc+Xu3CUXgzr/ELd15iC16OIyTdLDfhXQM
	nwpR1bKsjgLNJu9o6cTn5XP3U6wCUeHz2Q8NtS98FFH2qoR+aBw9R/WcQiYz8gx35f/3yOnTbir
	WE0LmtVQ9d6Gqh4y+psEaHw0CiM0=
X-Gm-Gg: ASbGncvBT3wmBIiXGa9/TvDf8SvBt2uKqVCjU5D+uHxbElebQLQcklC0wwz5KWX5KpH
	eUihz4QreXEAHpQu1ValI9Q02MB6dcvfAA9bWKvLIuhSeL5akNiAeJGUDtCSl1+GrovZUPZ748K
	LKyuKb0cakMTswC7wMbQA62R4yXetmo5tPSenzgA==
X-Google-Smtp-Source: AGHT+IHvIQixrAQdwsCTdh1GAxix6g9Del+gDgRZCEmjPlvhovZqA/cUFeAPLqBhVqXk0OeKqvy7+iSvRcbZ/ddq5Co=
X-Received: by 2002:a05:6a00:35ca:b0:736:476b:fccc with SMTP id
 d2e1a72fcca58-73cf2a7466bmr675709b3a.8.1744840556239; Wed, 16 Apr 2025
 14:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410070258.276759-1-yangfeng59949@163.com>
In-Reply-To: <20250410070258.276759-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 14:55:43 -0700
X-Gm-Features: ATxdqUEri2B4k1JC2L-7cp9JCUkFXx4Zbp6ziY-0nhDjM4z8AgOOsHlwGfpeeCA
Message-ID: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Remove redundant checks
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 12:03=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Many conditional checks in switch-case are redundant
> with bpf_base_func_proto and should be removed.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> Acked-by: Song Liu <song@kernel.org>
> ---
> Changes in v3:
> - Only modify patch description information.
> - Link to v2: https://lore.kernel.org/all/20250408071151.229329-1-yangfen=
g59949@163.com/
>
> Changes in v2:
> - Only modify patch description information.
> - Link to v1: https://lore.kernel.org/all/20250320032258.116156-1-yangfen=
g59949@163.com/
> ---
>  kernel/trace/bpf_trace.c | 72 ----------------------------------------
>  1 file changed, 72 deletions(-)
>

All this looks good, I checked that those functions indeed are allowed
in bpf_base_func_proto. The only (minor) differences are capabilities,
bpf_base_func_proto() correctly guards some of the helpers with
CAP_BPF and/or CAP_PERFMON checks, while bpf_tracing_func_proto()
doesn't seem to bother (which is either a bug or any tracing prog
implies CAP_BPF and CAP_PERFMON, I'm not sure, didn't check).

But I think we can take it further and remove even more stuff from
bpf_tracing_func_proto and/or add more stuff into bpf_base_func_proto
(perhaps as a few patches in a series, so it's easier to review and
validate).

Basically, except for a few custom implementations that depend on
tracing program type (like get_stack and others like that), if
something is OK to call from a tracing program it should be ok to call
from any program type. And as such it can (should?) be added to
bpf_base_func_proto, IMO.

P.S. I'd name the patch/series as "bpf: streamline allowed helpers
between tracing and base sets" or something like that to make the
purpose clearer

[...]

>         case BPF_FUNC_get_current_uid_gid:
>                 return &bpf_get_current_uid_gid_proto;
>         case BPF_FUNC_get_current_comm:
>                 return &bpf_get_current_comm_proto;

I'm surprised these two are not part of bpf_base_func_proto, tbh...
maybe let's move them there while we are cleaning all this up?

pw-bot: cr

> -       case BPF_FUNC_trace_printk:
> -               return bpf_get_trace_printk_proto();
>         case BPF_FUNC_get_smp_processor_id:
>                 return &bpf_get_smp_processor_id_proto;

this one should be cleaned up as well and
bpf_get_smp_processor_id_proto removed. All BPF programs either
disable CPU preemption or CPU migration, so bpf_base_func_proto's
implementation should work just fine (but please do it as a separate
patch)

> -       case BPF_FUNC_get_numa_node_id:
> -               return &bpf_get_numa_node_id_proto;
>         case BPF_FUNC_perf_event_read:
>                 return &bpf_perf_event_read_proto;

[...]

