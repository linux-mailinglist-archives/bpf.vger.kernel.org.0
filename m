Return-Path: <bpf+bounces-37336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F895953D5F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC43A1C21901
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F1154C1E;
	Thu, 15 Aug 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjUq8wD1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D615E88
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761704; cv=none; b=dpwGNFFS82sQoMx6acfQ1+d8uuPnTV62dyPcRERjng7sT9XuPNqKWDYshydJo+BcxCW128j9XjppvieVeJIFDxvhXB2mi0cQZ73S71GPfRvvQ9MCBz2y3VAuPuWkMh5ADoQOr/yp5qcJIQKotaUeV669jVnbdj/Rj8c5KjC8cnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761704; c=relaxed/simple;
	bh=YJMCICwnK/qdXrzRe3bkjkXv1EH7HICyH0wM77rbRzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8XhgwbV7CzM1s1Nv9xQFr+uvwkZBpTk3/YCYvzHAiTYuAZirNylUcJclzZHRJPuL6HNfaDejBgK6cLwJ3hKuSvbuk5jkLNJ5PB4+cvpUb+tKJGZuv/9mkMbya2XuKeGHlNxNOv4WGDZ2vQiSOna4ye12FhZp7MprJOOo5xpzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjUq8wD1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3b4238c58so1088565a91.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723761702; x=1724366502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qckin1iYT3WzaaBl20+6FwCN2RCyl52PjAFb4ANzvZY=;
        b=RjUq8wD1MaWwSlYzI4q5tTcb1kzZKFzswuVlivGKjBdurynvSnQNbtraMrb9NycNRo
         oDuD2HEZ6QztYV5vvxQwr1P1iqXAI9Hp8gMGHz5qNzrOVKyLIXQBxiYkDIOPieSmStfa
         rbZZUsQDfCZ2VfnZ4oSTmRqEeQcUpWODxwr93sKwkXvJVtVq40BoQdysejOc4u9WV+4d
         qiM94taHXdQhzGSLpZ5rcsRdUDaDi7ox2AU5sUOv1tjyOQVFyair7pwqj1xfD/5Jt55i
         /OBk2RqfTIU6fXcKRkc1ZxsYj9BVTsvPkMJwPW2zdRDMOidDmtK7tjNa2ysOgFjDJo22
         eNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723761702; x=1724366502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qckin1iYT3WzaaBl20+6FwCN2RCyl52PjAFb4ANzvZY=;
        b=GtOxJaZfvFXL0dTnseBpowFkBGb5Q4vflpG5sjGc03wNg/QSeGpfJ9wJSOSmmT+rkR
         UCiVv8IG3cuLXExnE5ckQK8jj1g2ySjg3x/AQodenPedTmrlGxJrmmx/qogiqnRS7Kcz
         uZOXPTjfNonwIhZfCgwS7aQ9Qbalch136aGVqxIjpto7dgcDKoCsZSGeU6g7i8b/aUGk
         0izF9/oCQ7ZiuFkNIZUX/UxzYaqcC2QJ+Z+X0I0r1AhK9R4Zflb7UHxgOPwjx8z+g4B5
         6GnfuIww7A3+qQxyDy+hlnANw7UpUN6lxxudVgjML35JrqVXh1uLfwKkRTMRZ9nxFmUd
         Dzjg==
X-Gm-Message-State: AOJu0Yxu5BA8UU/+8mtFOCfrJhc7zKTwaFFQqAdn5HfKVA8HgYLisF0E
	5GeNXd9d3NnqLV7xw9PdhI/QRMf7gdJbDFyKYMaH8F/N54ussoWTYKkmx4EABSinA5Io4agqtGc
	+y/oWjXWCDuVwh+Ctd9JOoCNaaDc=
X-Google-Smtp-Source: AGHT+IGVtfhzKby5w5apryctqHsM/8MFKrhaY3/toBe2q9n2KDJDZ7E0vKLt9lWTmeYGCf3BrF3XfC99xhdF5Gwzs0k=
X-Received: by 2002:a17:90a:68cc:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d3e00f1babmr1417670a91.39.1723761702048; Thu, 15 Aug 2024
 15:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815112733.4100387-1-linux@jordanrome.com> <20240815112733.4100387-2-linux@jordanrome.com>
In-Reply-To: <20240815112733.4100387-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:41:30 -0700
Message-ID: <CAEf4BzZVBEof6yUPu7wwVx_345Do7Zebgzyfp7uZi7Vr5o1pqg@mail.gmail.com>
Subject: Re: [bpf-next v5 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:28=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This adds tests for both the happy path and
> the error path.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   |  8 ++--
>  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
>  .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++-
>  .../selftests/bpf/progs/test_attach_probe.c   | 38 +++++++++++++++++--
>  4 files changed, 49 insertions(+), 7 deletions(-)
>

As I mentioned in the first patch, it would be better to have a bit
more extensive testing. All those rare conditions:

  - dst_size is zero
  - dst_size is one
  - string is empty
  - string exactly fits
  - string is truncated
  - plus various error conditions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 7175af39134f..329c7862b52d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_attach=
_probe *skel)
>         trigger_func3();
>

[...]

