Return-Path: <bpf+bounces-51205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E420A31DC3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CBC165578
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A951F12EC;
	Wed, 12 Feb 2025 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVNOU5+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1112F399
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337315; cv=none; b=fJj7dDEIxY3r2K8HZOG+Jfq2+89bHvATCKNR5Cun142AWO1rvTFf5eErO8YJJAf/M7aEMhXu5rY1SLPLv0nkYWjkbKIaAjcGvTA6yuDam3+hE/8ynzzaDF57HfEL8/HMWOWSznQ5cNerRcTtMNbwA/T6H1JNK/klXNzJeqYWXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337315; c=relaxed/simple;
	bh=WlVpWlFqllmORDX45wwKbUaqqBa8fdbgYsRYUxKe4vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Mma/xznPP4xYlThW6uns0gdCTXlGxHi2zqGhlD5v5mHNyTc/KVLNfFh3Gak4HM/yTg8/WxuUi8WTWki6lzbR/j4DDqCA6wltEdH02CcrRhTSAfMXeZd3JA5oeq1+qchH5bCWvmPhM5fSaXxFoeKAO0GHhMXaHY4Jm2kOtPkw8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVNOU5+9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso7771210a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 21:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739337311; x=1739942111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by44FCaOVSwUNn2ppN1S+bcPDj+QJGdRf2SWLY8Rlvo=;
        b=iVNOU5+9D210Csbiy+Bi6M0LRXoQpX3Yiqc2nWTn+rmHBRd9+Q7gOqE5xgh6+2m2Ly
         TSkHgC/KCPb4k1gVjMO2z0NBivcn13ww/mQF2CUhi/HoiJYgYglM2U8cTZpSg2gPFpQI
         79yQ0gvsrGcRaYzjr+s9kllLizzZCHwm2GsJUxMBu9NlnhCOIW/r5+Io9Hj6o8qUNjeQ
         qJBVjALRdYPh7K2y8ELqpJmUg459C9naFCLT09p51OjP80Uai5ckWHtcHGsarExC7M+t
         dheN51dAI2B8uK2rr7KOFQstmLvouB9rfVpmw3Fm+0FD+Gc0/3F9gGQ19nDAmcdZo61t
         hZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739337311; x=1739942111;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by44FCaOVSwUNn2ppN1S+bcPDj+QJGdRf2SWLY8Rlvo=;
        b=K4m8vc/RQ23fWr/1mZwBjX6yKx0B5zpnhZxZp8x9Zi1rr9ijnkQutnsXdiKhNPzZQE
         bk30FvSMKB4e3/Vp7r1puM9k092tsfdEhinV2jT9J3vLav/X46ZQhTevHXLRATbV9K8Y
         pJfPdzSTHpuUou5gJ2Tn/vJwIXAmRj/P4Nl9pg2dhobsxyPQbhq5MUwmxtS1LVr8GdCq
         Pb/Vg4ThwT86qn2CI60ksGPazwrtlx7F71BjL8+KggGm9h71bMY1+SnU8AqbdRZ4WjdO
         jwztg/WjcD3zd8AwOiHDQ/H00f331xSUJvV4t4VPlJHsZnMDjODIVwJeNtOCxlLhg2eC
         gheg==
X-Gm-Message-State: AOJu0YzUbBu+81HoZaEvaocr9v/t/pdGnrE7xL+Xz/9X2bNZxAqrNszv
	zSqvgaSfIdAFfnmHKsNY8nnQeSepEF8pMkjX+nQONUPMqVfVBgff3JehbI281UZ5jzF5VBAGkFy
	qVOR3f2sLmO03MJq6AwpMcrMBO9nskQORxbs=
X-Gm-Gg: ASbGncv8InoZ0iW9Vw8cnEZLL+UXd6uTMkUXMJrEoymZ9LfeiYVYOyTab7+EFKeqGwO
	omYdSLg8CHeMVODX8Txs8yEe/0IHeidfPK2vpJNdpVmYLbZx1lLmQoHWsh3wthwy6v83FOOiC
X-Received: by 2002:a05:6402:4409:b0:5dc:89e0:8eb3 with SMTP id
 4fb4d7f45d1cf-5deb08810a7mt822059a12.11.1739337311279; Tue, 11 Feb 2025
 21:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210060252.59424-1-zegao@tencent.com>
In-Reply-To: <20250210060252.59424-1-zegao@tencent.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 12 Feb 2025 13:15:00 +0800
X-Gm-Features: AWEUYZkECkINKdDpeAaWDIXOxJkbqzgALmhirqnl_if-1ttNReBJrcUyOj7fYfw
Message-ID: <CAD8CoPA84v7ZsoVsCewB64t5s2PJxvK3nywBHsPKK4nBZBxumQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/sched_ext: Fix false positives of
 init_enable_count test
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I encountered this issue in the middle of backporting scx, which
no longer exists since
    a8532fac7b5d sched_ext: TASK_DEAD tasks must be switched into SCX
on ops_enable
    61eeb9a90522 sched_ext: TASK_DEAD tasks must be switched out of
SCX on ops_disable
cuz TASK_DEAD tasks also go through scx init/exit path.

Thanks for your attention anyway:D

Regards,
Ze

On Mon, Feb 10, 2025 at 2:02=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> Tests run in VM might be slow, so that children may exit before bpf
> programs are loaded. SCX_GE(skel->bss->init_task_cnt, num_pre_forks)
> would fail in this case.
>
> For tests working in any env, use signals to control the lifetime of
> children beyond bpf prog loading deterministically to get expected
> results.
>
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  .../selftests/sched_ext/init_enable_count.c   | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tool=
s/testing/selftests/sched_ext/init_enable_count.c
> index 97d45f1e5597..3b2c8ab8464f 100644
> --- a/tools/testing/selftests/sched_ext/init_enable_count.c
> +++ b/tools/testing/selftests/sched_ext/init_enable_count.c
> @@ -31,6 +31,11 @@ open_load_prog(bool global)
>         return skel;
>  }
>
> +/* Signal handler for children */
> +void sigusr1_handler(int sig)
> +{
> +}
> +
>  static enum scx_test_status run_test(bool global)
>  {
>         struct init_enable_count *skel;
> @@ -39,9 +44,15 @@ static enum scx_test_status run_test(bool global)
>         int ret, i, status;
>         struct sched_param param =3D {};
>         pid_t pids[num_pre_forks];
> +       sigset_t blocked_set;
>
>         skel =3D open_load_prog(global);
>
> +       /* Block SIGUSR1 in parent, children will inherit this*/
> +       sigemptyset(&blocked_set);
> +       sigaddset(&blocked_set, SIGUSR1);
> +       sigprocmask(SIG_BLOCK, &blocked_set, NULL);
> +
>         /*
>          * Fork a bunch of children before we attach the scheduler so tha=
t we
>          * ensure (at least in practical terms) that there are more tasks=
 that
> @@ -52,7 +63,13 @@ static enum scx_test_status run_test(bool global)
>                 pids[i] =3D fork();
>                 SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
>                 if (pids[i] =3D=3D 0) {
> -                       sleep(1);
> +                       signal(SIGUSR1, sigusr1_handler);
> +                       sigprocmask(SIG_UNBLOCK, &blocked_set, NULL);
> +                       /*
> +                        * Wait indefinitely for signal, will be interrup=
ted
> +                        * by signal handler.
> +                        */
> +                       pause();
>                         exit(0);
>                 }
>         }
> @@ -60,6 +77,13 @@ static enum scx_test_status run_test(bool global)
>         link =3D bpf_map__attach_struct_ops(skel->maps.init_enable_count_=
ops);
>         SCX_FAIL_IF(!link, "Failed to attach struct_ops");
>
> +       /* Give children time to set up handlers */
> +       sleep(1);
> +
> +       /* Send SIGUSR1 to all children */
> +       for (int i =3D 0; i < num_pre_forks; i++)
> +               kill(pids[i], SIGUSR1);
> +
>         for (i =3D 0; i < num_pre_forks; i++) {
>                 SCX_FAIL_IF(waitpid(pids[i], &status, 0) !=3D pids[i],
>                             "Failed to wait for pre-forked child\n");
> @@ -69,6 +93,7 @@ static enum scx_test_status run_test(bool global)
>         }
>
>         bpf_link__destroy(link);
> +       SCX_EQ(skel->bss->init_task_cnt, skel->bss->exit_task_cnt);
>         SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
>         SCX_GE(skel->bss->exit_task_cnt, num_pre_forks);
>
> --
> 2.41.1
>

