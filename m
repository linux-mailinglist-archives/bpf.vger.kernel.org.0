Return-Path: <bpf+bounces-45656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E385F9D9EE4
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4673281177
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE961DF74F;
	Tue, 26 Nov 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNe2S8sh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACA2500D5;
	Tue, 26 Nov 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656767; cv=none; b=HRXz2Iz1WpF8Xw4CYRlbAVrIwWxGk+F/CucnTu2QLe0pR5HGOE+piqDoj5879ae8l3aEfqKXrZXvAjYzb7TrhZHKBqDWP2poe9povzXIF0MNcXkGh2+t+IsUGu1hvbLxjy1L22/oAn6LKac3MN4AnZJNzXcf9RnJSsh341Parz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656767; c=relaxed/simple;
	bh=0wCsuxITPEB/qQiSToxKrpFwqxBfdJEEDl5cKo3lIJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIfATQ2I7ArDYC3Nln7D1NOZjMLSg/ZzuaIKodZ3eyT0ezn0HTONAg/SghYxV8ryiVtZnf/uDWodpMa6EafU+KrFbElKlDv9Jzhec9CkXqxU49TjI+A1Nv4bTvAyKLiMPogsLaAakN+uc48nV/hTX6jh9qHzdelwL8q95joNIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNe2S8sh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724ffe64923so3419859b3a.2;
        Tue, 26 Nov 2024 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656765; x=1733261565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99ARIrKJg/Feo5MQX4mvPQCETiaQdyVKXCsh0VDpwNM=;
        b=iNe2S8shgbHVmu2iezVNumRMAb49/yCMGa4s5s2Alde0t35+89j/NpgBMbE/vr1427
         /26u5u5LF9s4ZPgfa2rjbdQ7zKdnbXXXOoEMKgVhbvR1tMMDtGSJCAcA58/zUxHFV42k
         wqAhR/Iq0MluxLRY6hReBVAEE2dhEdznXi4399ewYZ6RHQd+yNGeLLQdUI/uMP+6ogR7
         2vUmPvDEqgErXIO/lpY/VprHK+10oM19fkpeWsygkP/AZTs+oVP3/7DpId9ZsszxxqCe
         iV1Hj/ANSGM1V7+vUa8wmKApw0XHbd+rk3YPRV6ItqcAltv9XRhcYpm1xmG8KYctuoC7
         LIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656765; x=1733261565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99ARIrKJg/Feo5MQX4mvPQCETiaQdyVKXCsh0VDpwNM=;
        b=MdldPhmPys4KFxee6RcZ4G4HAVmGZQtvS4RvlOjMWj497R5NLmbY/mh2zfLk9Q24/N
         NOI9bOsaumQ3nB6tkkW42S7rqtyqiegu2jUdCZqc/JquakxJD4J7EHUdapfOtcYRvJeE
         S24P/caPJsi49L35HECHGmLoUdj861YSaoATWHeVHoj/XhEqJoprI2AtNR1xUH6BJh0g
         6ZJhuyDYJq4gp3icdRakB32PghK9fEsr65a87eVoh5tFqli+TbYxMurzWUZiYScguwwI
         /U8wQk/oGg7LS+s4IvQZaaZslswYHagfUXFzNdZfZr85uNqnydRfKd2/CXts323Lt/eK
         8k1w==
X-Forwarded-Encrypted: i=1; AJvYcCUvbciUDLLe0yt5+iYZ3bMqCHRSl9t2R6HPJL2DUtGKTuD9N08DuCQ1DRgdc7c2DwrW8n8=@vger.kernel.org, AJvYcCWkV5AV0RH5hYaDgKKCxh1qMfUzbRV25cQMaUkWEGYsXFR6y2v10qvZ4uMihZ+sHxCoHd8wC0ODRvk4xWVS@vger.kernel.org, AJvYcCXXqnraZbL6d7qZAflXsRs7FPQ21/0FueZvJur7XJEPyhZ+CG4nGPINHy6UV+0sqjMT/bGzdn6XYVsS4eSGdVOug0Z3@vger.kernel.org
X-Gm-Message-State: AOJu0YzxC4SLprY++pVdGMx9ZW65lkDr/kFbjoKqKbR2LSgnHibaVy4W
	cGpy7QY6vW0CiqQYqmU+2vwl1+GnSr2jZQtc0bz2QKZ5P2Oniggu5vdke1Ct5n6SnJtN00tnGOy
	OFaoTl1C8rWcWCFdCoXyvNd74aFQ=
X-Gm-Gg: ASbGncu8rHa1Hmte15+ytWknlTlL8uV5iM+S+GJv+o8MC9sPi3bE/CAuxWYlYjVHvq6
	BFvz20io55HL5jMVAVzD8Ar1QJIEc8VNucro5DxbD9/lGK1w=
X-Google-Smtp-Source: AGHT+IHaLhaRzDezR3Iq4R/Qrg75a0wqOx9j6VCE2ogEU0qqsQKF0wZ8QjqQ/Pq6Itqd+6UgXwypwGhJ+idl65Kz0N8=
X-Received: by 2002:a17:90b:1e11:b0:2ea:9ccb:d1f4 with SMTP id
 98e67ed59e1d1-2ee08dae675mr1156944a91.0.1732656765167; Tue, 26 Nov 2024
 13:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126165414.1378338-1-elver@google.com>
In-Reply-To: <20241126165414.1378338-1-elver@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 13:32:33 -0800
Message-ID: <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:54=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> The warning message for bpf_probe_write_user() was introduced in
> 96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
> tracers"), with the following in the commit message:
>
>     Given this feature is meant for experiments, and it has a risk of
>     crashing the system, and running programs, we print a warning on
>     when a proglet that attempts to use this helper is installed,
>     along with the pid and process name.
>
> After 8 years since 96ae52279594, bpf_probe_write_user() has found
> successful applications beyond experiments [1, 2], with no other good
> alternatives. Despite its intended purpose for "experiments", that
> doesn't stop Hyrum's law, and there are likely many more users depending
> on this helper: "[..] it does not matter what you promise [..] all
> observable behaviors of your system will be depended on by somebody."
>
> As such, the warning message can be improved:
>
> 1. The ominous "helper that may corrupt user memory!" offers no real
>    benefit, and has been found to lead to confusion where the system
>    administrator is loading programs with valid use cases.  Remove it.
>    No information is lost, and administrators who know their system
>    should not load eBPF programs that use bpf_probe_write_user() know
>    what they are looking for.
>
> 2. If multiple programs with bpf_probe_write_user() are loaded by the
>    same task/PID consecutively, only print the message once. If another
>    task loads a program with the helper, the message is printed once
>    more, and so on. This also makes the need for rate limiting
>    redundant.
>
> 3. Every printk line needs to be concluded with "\n" to be flushed. With
>    the old version the warning message only appeared after any following
>    printk. Fix this.
>
> Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.=
com/ [1]
> Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2Vaekd=
L4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/trace/bpf_trace.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 630b763e5240..0ead3d66f8db 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -359,11 +359,16 @@ static const struct bpf_func_proto bpf_probe_write_=
user_proto =3D {
>
>  static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>  {
> +       static pid_t last_warn_pid =3D -1;
> +
>         if (!capable(CAP_SYS_ADMIN))
>                 return NULL;
>
> -       pr_warn_ratelimited("%s[%d] is installing a program with bpf_prob=
e_write_user helper that may corrupt user memory!",
> -                           current->comm, task_pid_nr(current));
> +       if (READ_ONCE(last_warn_pid) !=3D task_pid_nr(current)) {
> +               pr_warn("%s[%d] is installing a program with bpf_probe_wr=
ite_user\n",
> +                       current->comm, task_pid_nr(current));
> +               WRITE_ONCE(last_warn_pid, task_pid_nr(current));
> +       }

should we just drop this warning altogether? After all, we can call
crash_kexec() without any warnings, if we have the right capabilities.
bpf_probe_write_user() is much less destructive and at worst will
cause memory corruption within a single process (assuming
CAP_SYS_ADMIN, of course). If yes, I think we should drop
bpf_get_probe_write_proto() function altogether and refactor
bpf_tracing_func_proto() to have
bpf_token_capable(CAP_SYS_ADMIN)-guarded section, just like
bpf_base_func_proto() has.

>
>         return &bpf_probe_write_user_proto;
>  }
> --
> 2.47.0.338.g60cca15819-goog
>

