Return-Path: <bpf+bounces-58599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C36ABE478
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C465C4C47F1
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18C286D50;
	Tue, 20 May 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGBbPy5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596011EE7B9;
	Tue, 20 May 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771694; cv=none; b=PhCjxl4mlGfzARD7wi4uWsG/6P/ZkeZlTL4fVZQq2vzDcJwo93tmgf000IFXbifJ591Evz5Vvog/tRKNWExZhKrzg2zL1oWSdkow53pxUBVpOJKkJFuRj4yoeI85xYI+3orxSDf/OcXXCo/dsyDY3kVborw/Qe5pb4bjEsn2Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771694; c=relaxed/simple;
	bh=8Er8OhibuPRtXGUsiYNrQztXPWzDdhAQ89FUTn+HcLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbwQiAFdc1lxoM9tO7OpyjPg7rrLy9c1UkBU2Z2gsCujdTqXzoLNfrgfN/DU8fl0uI8adEeE12JaJhSHMx/OA2XzVKBCIg/H35w08TE9+F6WCHa4kZ1Dy5LMx95FSxv3v8cK0ZbSMIuLYQ3slSidytBAq1GYkrhJKg7VrqNDWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGBbPy5e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a361b8a664so4419997f8f.3;
        Tue, 20 May 2025 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747771690; x=1748376490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3IPTweDtnrYm7kj/ndhlz8BOXodo3QwD16xiasY3w4=;
        b=SGBbPy5eISIamHyMln7V6YjnIL1lGSHJ/FwvGoh9mu6G3MxhHpry6Y4UP12LT796w0
         Hh9ZqwKM0isce9tpCUHoMKOsmZDvqdRy7CvHWa+XJJgSYa3og77y3hI0hZPga8BK4HHx
         AgpBM6LaefOr76s3geHcnApD7/5mZnzLJyudV7gpRuZ3vMciI3Zt3SInjDkqWrjQDfp/
         0FUemGHg63vjRbohkj91xPcNhs4isVVCyPE7NnwtoMJs/3tQcr05TBBRobEwuvvZZyil
         ApDL+6qs4caSD38gHu5sU/EmyWdyIY6b9iaVLWESm/3wxx8FbHmve+NkD0AdkoKeQpc5
         Jvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747771690; x=1748376490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3IPTweDtnrYm7kj/ndhlz8BOXodo3QwD16xiasY3w4=;
        b=vijc2kcBxJyXPTw4dxkt4CH+7L842971eZDghIAVgu2mJXWBT6oVM4o2PHyMgaaV0L
         VY/ngTdeggc6Wed7KJeRwEt0YJOvU2KmlCTYFWDdZ2LUP6q00aG74RODokKSDqmUb4tj
         X25jXUIjoHz6qbZnOfas9sWTaBlVB2lrRZp6z773tGjNMm9d6tIhMVWpSqt964SPxuQd
         y5W1hf2G9J5RKvrugnzUYqnzZ9NsA6pKmpuqNqb+2I4uLyxI7P3gp1ixxKgv47SDzUGB
         E9cJm2qAcbeQ3sBw7AOQIn2076P9xWWGbVLcYAAJvEf77uk22mSBCJfcto80eaKMpc2q
         /bBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIxpqxzLz6HWZhQpErUzGMt4AVShgcR/ME/KZcdSuGOb71FNUrh1RKKZkNEZt51FQog4gVx09CvLv1FiuK@vger.kernel.org, AJvYcCVSkFZFLFlnmEg7uZ+xyQSTg+lsbw9jOr/P+5IMw1PvlLwY+yQIUkejkQ8CNdNnGRdU55kzpK/HTk/Ctj7TzUYHR14B@vger.kernel.org, AJvYcCXy+A2gRrKHpjONDB0qqbUOKNc76ZVxMOHjpJkvj02FNEIMxG03wcsfN2v0d9BfftaR4+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1I6LLX8vD6u7ILQXCIdFpnZd0D7Qnn3No+rLotJfWIQL8d7T
	u0vq3AFLAtzgC3WnrLPp4XxF3pfgVDoVYIph54amoeNXEMpzdKDnWtFEtlCv+G0OIEOjrK7v1fH
	+1PsqJSidkwTHKvKkMtSGY5UJBH2QU3Y=
X-Gm-Gg: ASbGncsetdUMoDQcabsNJpZ36KvWlq/Ho43cD8EzGsLwQ0hDlXlKBXUtA9u55qgHffE
	+54vF4DRY7lJAobChigJW9/RmtzfDHQxwCy+IbnJlfwcArGHp4XgXicJRemvpFoqxjbq+2jkk6b
	i8tMv5uXUI+Y2eBZGUukgMHJCCpqSbSgmdgCFfc4TmZ+a4OkDg
X-Google-Smtp-Source: AGHT+IE1Nhc3de9UWe3Uxv90peDfXcg1RuNvCCTJNxAJCrPuuxtt0XQoISjWo9GfCVadN4ymgJNiD6mSYc+5zATWoSA=
X-Received: by 2002:a05:6000:2502:b0:3a3:712e:c4c9 with SMTP id
 ffacd0b85a97d-3a3712ec624mr6806601f8f.52.1747771690406; Tue, 20 May 2025
 13:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520054943.5002-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250520054943.5002-1-xuewen.yan@unisoc.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 13:07:59 -0700
X-Gm-Features: AX0GCFsnSVJV_z_TzSzEMH1vd6p0Zn_P57_mmxCuj59sGtD1WNdRI0jcFppQQ7A
Message-ID: <CAADnVQKZti=SXM=4owtk9jEqGMcD0mUqb46PNYwhquYfyORUuw@mail.gmail.com>
Subject: Re: [PATCH] Revert "bpf: remove unnecessary rcu_read_{lock,unlock}()
 in multi-uprobe attach logic"
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, xuewen.yan94@gmail.com, 
	di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:51=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com>=
 wrote:
>
> From: Di Shen <di.shen@unisoc.com>
>
> This reverts commit 4a8f635a60540888dab3804992e86410360339c8.
>
> Althought get_pid_task() internally already calls rcu_read_lock() and
> rcu_read_unlock(), the find_vpid() was not.
>
> The documentation for find_vpid() clearly states:
>
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
>
> Add proper rcu_read_lock/unlock() to protect the find_vpid().
>
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  kernel/trace/bpf_trace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 187dc37d61d4..0c4b6af10601 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3417,7 +3417,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         }
>
>         if (pid) {
> +               rcu_read_lock();
>                 task =3D get_pid_task(find_vpid(pid), PIDTYPE_TGID);
> +               rcu_read_unlock();
>                 if (!task) {
>                         err =3D -ESRCH;
>                         goto error_path_put;

hmm. indeed.

Jiri ?

