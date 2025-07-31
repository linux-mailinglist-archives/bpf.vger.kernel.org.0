Return-Path: <bpf+bounces-64819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1710B174FB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11149546D25
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139401E5B90;
	Thu, 31 Jul 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjW+4ZFp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344FBA33
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979542; cv=none; b=fY84MQkddVPAYymNJVKUjQyCbBJSmy3TNGLMaXWkpV2wGLZP6/VtUKNbMb4UEDeM86lEaR9R4IqgPeWpORA38FYElmSsjgy+Ck7A14ACAGBncDH25RvPuF9oKct7LllTScVe6b2S1gSUvhkOWVLouYKEub0TYAcT0SCzzuXp0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979542; c=relaxed/simple;
	bh=NC1NlJZiCelLyYiFLVn3ElnN10TyyIDQ86freCW5uIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMlNufQH9tYQMqabOPGhcXLW6sgjpBOfCIR/5fYBZvACCUPI4bEBhY4pIYKmGkqnxMOg77TOxyNlj3rsuifX48fOiTiIiq8kSm0W5ECJjBxZA2AIH+LeL9thqF4b4Dz/tYsAHWzO7kqpYR0zEo20rLpc3EH49jVw+AayZKjSknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjW+4ZFp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so248974f8f.2
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753979538; x=1754584338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQni+teR8ROHoN9i8omMpiApwkx6Sa16nz/vwobeUlA=;
        b=HjW+4ZFpC94+NKYrrahddcEuuUKAd/WeE1qF7Z0v9++TBREqu/puseD1rY9IN2UnGO
         tKh7dYldnC5Tb5/dyd2uyyGuy/l/Nx7+NxJx/Bil8eqcGekL7krvdAl5Vmk/7sJ/Ky4i
         PRPEpwKhPtU4ZUwTzTN7D9QJHRrjasUD3WLlwBw+DtceZvMoNBf9jZky/fbRUhSrDueF
         wWLOqU/Z5wo9xxlLLkagn0wm2CtV+tPkqscSpXrQ6UGcQkhgOwwij547PuYSmAxVz7UG
         dVdY2JK9e+x77NODh8mzlpwcDbDvPQEws7i23GUFo6efZjtHKZuy2EoCYtNWsBKxlVzZ
         Ig7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753979538; x=1754584338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQni+teR8ROHoN9i8omMpiApwkx6Sa16nz/vwobeUlA=;
        b=Hf62xUcsQIdJmNi+4oCvgOCLxbD+ToN9JiMfN8goltxqAPGglohHpP0YIjc0382uZY
         R8OqoIlTg0l4TSNxt0fzThlneo/8qdPhjqkcbu/EzmvNjPJCyVwfZDs/1x0MJn4PUyw3
         cAMblX396clSXAUH9QF+7pynDVYOfcm7S6v+HbVDnv1DwioF2GbSmHKWgegiVVcK7Z5N
         I7TBRpDn01hcx0F7mlc0TwsVqVb19Hzc0+9ssa6TCdUzZbU9xLM4/wJd3/yVajAFJrEp
         rMo9dVCzQQBThZY4JkqvZGnlBqKv0dYOfgUrqNq3bjy68WpsBag1UIkJyI1UpQfe5t5D
         hqKQ==
X-Gm-Message-State: AOJu0Yxm4ieyzbANb8VK/cw3dPeWUOsUItKxLjJoBO9cR8X/6/+Rgu1q
	eaXRaSi78dJx71B6wYSmWPxDwHgWYe22rsgix7f+1fdL7vOPCbqpYdnoWwZGwrR+NL8KEJF63Df
	qcQBeyA+FIlvVHtOwC6onBuJXvLf9PRC8Zf8A
X-Gm-Gg: ASbGncvLmj4axqobBhsT6mWIkE+V50eHg5fLJqL3VtsUWn5mQhDop4iDHDMy+FKmBO8
	tlptlrLUeHQfgM6fKYafOEBrXnZhD3wzW43wMlo6yeIEtvSyzd2bof0kmogKuc3BdSGm80IJ+yD
	hhwcy/Cs5/ZWJv8rqhEet5igsN8xJqn7hHLH0KJumT2dn8uslgAIPRhhEjwUtvbtZA9js5rjxu9
	2qd610mgUspJ2IgJlRPvgI=
X-Google-Smtp-Source: AGHT+IGcwAw7O7iBLZM6EP1IpsgklgkXW8JRUzM8zkP6hrB2IgTxOc3sFBQ3vYoLW+QHhKkvXZN/nT25ChVx7jpW5/Q=
X-Received: by 2002:a05:6000:22c7:b0:3b7:dd87:d730 with SMTP id
 ffacd0b85a97d-3b7dd87d8femr1705482f8f.52.1753979538188; Thu, 31 Jul 2025
 09:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728142346.95681-1-leon.hwang@linux.dev> <20250728142346.95681-4-leon.hwang@linux.dev>
In-Reply-To: <20250728142346.95681-4-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 09:32:03 -0700
X-Gm-Features: Ac12FXyxrrPKFH4NHVouNMYfPo1hX-aO0LhA5q5o1v6FnD8OGOHN13SQObR1Z_4
Message-ID: <CAADnVQJ-wC5kpGZMzU5O7cd-m_4hKA-tjkAm42xEqh2Lu_v_hw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/5] bpf: Report freplace attach failure
 reason via extended syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 7:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch enables detailed error reporting when a freplace program fails
> to attach to its target.
>
> By leveraging the extended 'bpf()' syscall with common attributes, users
> can now retrieve the failure reason through the provided log buffer.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ca7ce8474812..4d1f58b14a0a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3446,7 +3446,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>                                    int tgt_prog_fd,
>                                    u32 btf_id,
>                                    u64 bpf_cookie,
> -                                  enum bpf_attach_type attach_type)
> +                                  enum bpf_attach_type attach_type,
> +                                  struct bpf_verifier_log *log)

Same issue as before.
Nack on adding new uapi for the sole purpose of freplace.

Patches 1 and 2 are fine, but must follow with patch(es) that
make common_attrs usable for existing commands like prog_load and btf_load.
We need to decide what to do when prog_load's log_buf conflicts
with common_attrs.log_buf.
I think it's ok if they both specified and are exactly the same.
If one of them is specified and another is zero it's also ok.
When they conflict it's an EINVAL or, maybe, EUSERS to make it distinct.
After that map_create cmd should adopt log and disambiguate all EINVAL-s
into human readable messages.

