Return-Path: <bpf+bounces-20854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B3844647
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD711286DBA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570312CD9F;
	Wed, 31 Jan 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVBclNzV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE277EF1B
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722669; cv=none; b=f5j8ZLwMlpSP6Ye9hIu3qNOkLdNvo21tnarNdEmoIPQGK1mjLO0phmtGjaO9kgB8Jtnnh2ow1aVfjdthTO2nbRwv+rQ2tYSfC2TS9vVZqF+I9NX3D/hqGnviEtkzAMbF5H6/L3TixoMEBjNgV0WO5x7ACaGn3rNThMbEB13iLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722669; c=relaxed/simple;
	bh=RYEYfF/kNUNG8tT8xLR+X5WF1joFS+AIfwYExm0dVBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po0C/OkiyLaPqup2zGWWh5QCZ/uMRd+d02svyHH20QDFxgVsQ0xm0z3R0EA38lV87sBC+gQoqHP8Q75p3DoaTHoBTeO7HTmgij3D4OPt+ot66f3/YbIRZVlrLIYrCITWX8v/OHuYuNqyJ+Re75qh+axpuSFPeDFLbAXSnboGsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVBclNzV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so54760a12.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706722667; x=1707327467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsKMi1zswz8SUUCrdFNkfKt3wrCameeMQq05g5cXPa0=;
        b=AVBclNzVVllNoud159f/O7G7zdpYIK5AfbpENCa+m8nypbuoGyG9976bCJMvMHzzix
         pbl/iTPwffvR+G+qsjFgnCi9cS2qNJdZOsphfU6Bq5WWcp99pscYwXVk++6V2p0ecYbx
         Suv2e8/Yy1g3pgvzpL4sKkpwlzfN1v2BQ6hI8IdgkU3j8xYA5ZQg8WQUUeDGjvBSSbqh
         OqdNyCEt0gHU4aJE90dgzeo9FWMFY981fVj0L4508pp330GoyGJngMi1Rm0W98SRXKL9
         1qRneRclWOzcoWSarARrUQuiOonl7l8Wir9Py4MWKkoFsonD5ga8GJnPY/MofzJ7FAfy
         +gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722667; x=1707327467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsKMi1zswz8SUUCrdFNkfKt3wrCameeMQq05g5cXPa0=;
        b=Th2LhvB/tsc2Jc3hqelwc5Q57ni7RIxsyWpbuvgEt1fSN4iNtgJ6fhsguMZO+4ZbvH
         jItqVPl9GoVkvGo/RLr45boV0MvIFkUq8FxVNXuRFawyHzfYrq3GyIbwiEkHaIz5S7g4
         PCsfcAkYF+EgCA1v639Py0RC/vHbCTfHZ1dh3hHhnoQwgqu+T3s9i0//cG6ZuWSEpsF7
         zyK0t5gQ9ocMi0DbR43HHP40n/hrKVzPClby/GhpE1hu/lymIXXWjyVi0yPW7MjZef2c
         MSHkbZuc9EQEynzoLT9GItg+Vavl8IFhqwQF23OWCx1kI6JHBZ5thHdmX09ggWn5lhyo
         NbRw==
X-Gm-Message-State: AOJu0YwM1t1pvlD9Z4hx4DFgheI6rryuaaoTVYEoZCMPAMT/DYe1JVyd
	zsLwOtrYm6gbTxxsFCKSB9agMS7LIk62WMHj7zJvBFafuZb6w8fjkuBc3VOMkfE6jVI5uy4gi+7
	lVa/H/pFeotn4k8cBs5nKSMYG5eY=
X-Google-Smtp-Source: AGHT+IEOQ9hLAlIGiFPk43ooNiChXDx6PFNttujU7LerUV1t57DPFDGU40eBCp3xW3bxvbQZwOQxrKoRN7JHe1sTO7E=
X-Received: by 2002:a05:6a20:5d89:b0:19c:9a25:bdea with SMTP id
 km9-20020a056a205d8900b0019c9a25bdeamr1885643pzb.59.1706722666754; Wed, 31
 Jan 2024 09:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130193649.3753476-1-andrii@kernel.org> <20240130193649.3753476-3-andrii@kernel.org>
 <aa043e86-586d-45dd-83c0-f47b271c2634@linux.dev> <CAEf4Bza1eKtnRmaUfCo_-zkKTz-ZzcoTSLg6dhOQK9N-G97X_A@mail.gmail.com>
 <c8c6f297-9153-4fbf-8fe2-2df6047ea66f@linux.dev>
In-Reply-To: <c8c6f297-9153-4fbf-8fe2-2df6047ea66f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jan 2024 09:37:34 -0800
Message-ID: <CAEf4BzZqwJTkaOTcgDLSCFEPa5AkNhqHVHSBUu7bxqFSZ5nbhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to
 libbpf_set_memlock_rlim API
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:23=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/31/24 9:09 AM, Andrii Nakryiko wrote:
> > On Tue, Jan 30, 2024 at 9:16=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> >>> LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, s=
o
> >>> add it to make this API callable from libbpf's shared library version=
.
> >>>
> >>> Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel need=
s it for BPF")
> >> Maybe we should the following commit as Fixes?
> >>
> >>     ab9a5a05dc48 libbpf: fix up few libbpf.map problems
> >>
> > The one I referenced introduced the problem, the ab9a5a05dc48 one
> > fixed some problems, but not all of them (for
> > libbpf_set_memlock_rlim). So it feels like pointing to the originating
> > commit is better?
>
> Maybe we can put two Fixes here? Just having e542f2c4cd16 is a little
> confusing since libbpf_set_memlock_rlim is not in libbpf.map with
> e542f2c4cd16.

I don't mind, but I'll hold off on sending v2 just for this, maybe
someone can add it while applying.

>
> >
> >> Other than the above, LGTM.
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>> ---
> >>>    tools/lib/bpf/bpf.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >>> index 1441f642c563..f866e98b2436 100644
> >>> --- a/tools/lib/bpf/bpf.h
> >>> +++ b/tools/lib/bpf/bpf.h
> >>> @@ -35,7 +35,7 @@
> >>>    extern "C" {
> >>>    #endif
> >>>
> >>> -int libbpf_set_memlock_rlim(size_t memlock_bytes);
> >>> +LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
> >>>
> >>>    struct bpf_map_create_opts {
> >>>        size_t sz; /* size of this struct for forward/backward compati=
bility */

