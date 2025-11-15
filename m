Return-Path: <bpf+bounces-74647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D21C60252
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 10:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96A94E1CA0
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC7270557;
	Sat, 15 Nov 2025 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMNlSxw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3E1FF7C7
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763198542; cv=none; b=IUYrPe+UbSCRL7azT+ZIhXQrqCfS5Vz9V9lo9EpW59x3SHXK6ZpVR0S4o/1JImucRk0yfLLosxp6EX8PbMCLmqWThZLDx/ZoJgI39aFzuo5DxzUlAKZtP0DS9kZQ2auJ0IYAqh6re/IkJjN5zzMYiYMA4sXqoNsNmhyhykX4rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763198542; c=relaxed/simple;
	bh=ZopBRUBDtUkqYTkpgvQ7TOwO1vK6FIewYCv2Xt+kM2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbOXE/zQmBhNPulEf2fzLMNLdafW05dKi6Oa0qNkj2oyEpgTPU9eMXHafZViWTyB0+ZngmFsvSufgY2AkFBY4uyGP3qUjIWySUWi7b1pFV1FsMveM7C7t6BCr54OwTEDS3WZ+l79LyABaNdDzC4QiSI30YyLpYzkzVR1L9jmla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMNlSxw/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so4247856a12.1
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763198540; x=1763803340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOJdP9L2pHnl7uGHMsUrnKY+ud+RS0UyXLzA39xotew=;
        b=IMNlSxw//jWIdCwCWU9LpZ/jNstSwcIAxkRqCJMRH6HsqE9yz4QCalBGznqOfeZKus
         DF/fNpegfoDWIfT6ob53+cRpbpiLw5sIAiNtQJuBYaGbfcZwUyq8+h/UjsFqv4NDYTi1
         YZ24zW4Vg0PQfIYpH0LBMszM1q0sr9+ea22Fmj+l2RwFSgYcYbC0KeulrTGvDriIdeja
         PwZSUA8B7i3E+tX1Hj8F0vwTP5QcK0h3J98SSdEUxjBwrEukxKgnrwtCFV25iqkVmT6T
         m3JXrurYaiQ5SUHdwd9j2be//JM5lB4XJoTgoy5DwIzbvqmWK2xYXzTELH0rYbpEaOLQ
         G9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763198540; x=1763803340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOJdP9L2pHnl7uGHMsUrnKY+ud+RS0UyXLzA39xotew=;
        b=rU//2bL2vhIcYjXAZeKpl2AcXKz68FMsxKy0rd9Sj+zuql7a+xMCLUyhPt+k5VT3us
         ap4382Njgrm6P52nJfut4pS49M6GehwwxPtXAV7zFmD40TMOvtknlrVEDh4sU2HHzuKh
         Zj2bHB3yc+YwK9wIw6ISQqsbxlgyAeeobGgWC4bn9EnfRb50B8ucSRxkf7a70+TjZS0N
         FAWAmrJ9PUJ1acIVL7y+lXJJpCnyT3vm3GONUWg6CRZfukzw66NN5NBlFNVFfeADE+bq
         ldoHM6BV9RHRqO+zuFcvKUw8h5fpIFF5exrDwQ/JuROyQ5EOWrxpkoXNMerevlqDje72
         G69w==
X-Gm-Message-State: AOJu0YybqCyqXVSbuBKtma0sp+yH+NKGKbcQoIsR4b5xrgBJ9Gxh+u+/
	/Vjpos7/YlW9E3Unbb8UbO02rDTTQhcXRfZNq48ISyOMbRhfzS0aG7/Zc9osJFMkT9SXrxhIWnl
	4A5Ep38ig/kib+c5Ag+ex0du0MliRIw==
X-Gm-Gg: ASbGncsEx4+2kM0aqOvWm7KCIwo8tuL/euIysQrpw+SH5pjkVHWm05uiy3gSJ+uVDqJ
	c1LCiLxJkLJsSxsiBBBcFB4XsBcWKLnjRQrTWuPXZwdgLTl3zIWcOgrhedOtDMtPzR3q1OSSv1Z
	8LxBnzQ3bNI/LAmbK5Nnwnm93R9X29nRwLgTdat4yPlCf3UluZOc5TeWmm/xHhZ/a6pMn2oGQt9
	f3todRIvn763UBnUdbyz4M49HVUqIOlIF+EldvF9ELrcPIGsmnLH2T9qnP/c3onIgSqkDA=
X-Google-Smtp-Source: AGHT+IElR2BmN37OhskKNwSl180U3Q1uQQLlDr7geerd1rFPaPUWGE8sEvSrx30FegxHEtlY3cVFskonLObE384kYNY=
X-Received: by 2002:a05:6402:1eca:b0:63c:683c:f9d2 with SMTP id
 4fb4d7f45d1cf-64350e21861mr5528351a12.12.1763198539427; Sat, 15 Nov 2025
 01:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch> <CAADnVQ+AsvqZZOPmga0VsavQNt0Qc4Gbh9+KPSkaxoOsstELxQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+AsvqZZOPmga0VsavQNt0Qc4Gbh9+KPSkaxoOsstELxQ@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Sat, 15 Nov 2025 10:22:08 +0100
X-Gm-Features: AWmQ_bloP5zo6BM173PS3pL56k4zrD9VDJKlNBaCeT36fanbbrwNjmDdOXM_-WA
Message-ID: <CACkBjsbx7gDCjBOZMxK0tK0LopY9hvSt_EL2Kz5FzvHjsaddHQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/17] bpf: Introduce proof-based verifier enhancement
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, Hao Sun <hao.sun@inf.ethz.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> This is not a review yet. Small question first.
>
> Your github repo has ~1500 bpf object files,
> while here and in the paper you mention 512.
> What's the difference?
>

1588 is the total number of objects before any deduplication:
 `find ./bpf-progs -name '*.o' -type f | wc -l`.

512 (503 + 9) is the number of objects dedupped based on the verifier
log (see[1]).
Since those objects are compiled with different configurations, but
some are from
the same source progs, so after loading, I ensured that the objects must tr=
igger
different analysis processes, which is indicated by the number of instructi=
ons
analyzed and the number of states (captured from the last few lines of the
verifier's log).

Since some different objects may be deemed as dup, I still keep all the obj=
ects
in the repo for reference.

[1] dedup: https://github.com/SunHao-0/BCF/blob/artifact-evaluation/scripts=
/process_bcf_result.py#L334

> I tried to categorize failures from many of these ~1500
> and lots of them are similar.
>
> In paper you mention 3 examples:
> - ptr + str_pos, with size MAX - str_pos
> - s>>=3D 31
> - &=3D 0xffff
>
> Did you categorize all 1500 failures into categories?
>
> What are the specific gaps in the verifier beyond these 3 cases ?

Categorizing all the failures was not easy (e.g., I tried to write some reg=
exs
based on the error logs, but there were just too many), below is a rough
result I did a long time ago:

    "min value is outside of the allowed memory range",
    "max value is outside of the allowed memory range",
    "invalid bpf_context access",
    "invalid access to packet",
    "invalid read from stack",
    "invalid mem access \'scalar\'",
    "read_ok",
    "BPF program is too large",
    "invalid zero-sized read",
    "At program exit the register...",
    "call bpf_csum_diff...",
    "invalid size of register spill",
    "math between map_value pointer and register with unbounded min value".

