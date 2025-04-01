Return-Path: <bpf+bounces-55114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DAA7849C
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BF63A0565
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BA21B9CF;
	Tue,  1 Apr 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkEbg7Jj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1921481B;
	Tue,  1 Apr 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545835; cv=none; b=MFbfOFoNrgJGTFiGTMCCNR47IJKxQEc8yDjqX5G3WNedC3uGvenYS3han51PvZriYGT8GYNxsprqcAer7X1AwIV83XNGb57sbiq9h2yLAH8iIIYfIQ6n9+zAQrIAAu3/TVZJPd+/bAQ9//sqkgM6u/B4u0BqLEc8ApVfe7ivTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545835; c=relaxed/simple;
	bh=dlt7QCpO5Xv9hp7ALZyMRj3fKMrEMyD8TZAEVGCrWW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iieU+Pgw305EysDEO3sNTpb4TJFE98k+Pf9ns4IqORUxXhHKbuqrhaSkM/t7THeGacd5jFJl4x4FiKvjqyRl25bdeArQSgqB9+RT5UuOn5Rxj19FT/HKcNVO+CbI+Y+bqEvDODkUGAHx43pGic5vcLmZjbYNMUJJlYHViVonddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkEbg7Jj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so528977a91.1;
        Tue, 01 Apr 2025 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743545833; x=1744150633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlt7QCpO5Xv9hp7ALZyMRj3fKMrEMyD8TZAEVGCrWW4=;
        b=QkEbg7JjxS/NimYunjx/yvyFCo8sRe8/ge0YIGn93necXdwzp24+ynwc7t8JXWkMGF
         dM/vSTe7e6Oq4sQb/aMHB1c0ZhotUjRhbwrssE31a52Q0qOuOx4Z2dmMGcaKjcoFuN6X
         48M5iIvLvyCi3rmnTmXzaEYKYGmWipqcxXQVs86dT3Y3seNSFkRKhxsz10w8SnFw/ZDj
         vtIS8Y1WmLBuaNhSzMXekpiM9E2JU/g9AXitwY3C45p6QlDa89Gvhal0qTBKtoGxe0S7
         xrMci4S3W5fY4IyDbT1p+DMSUlu0hQ4uIqKeWaiAb334gYlAeAl2hAxjlIlzuqDmSjJ8
         hcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743545833; x=1744150633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlt7QCpO5Xv9hp7ALZyMRj3fKMrEMyD8TZAEVGCrWW4=;
        b=XPwwiN17A3O0DyP39oQ61JFcrrBMObUPoQkjfuruOQkxNHrSJWUDMUUMgPxK0LT07q
         6TweA70a3GIx/II+AmqkIxE7G8g8RLc6DbmVRCCgQ1ISlYWqU5C1S5rCOoyJ9R0Px8mO
         f17W1TW0s+Nh9nc2+ceal2lxHpup4HWrM8STqIyEdKVAQgs9loyFWohdJRFmSFXjHD/x
         +li0Ms5qJgnBDrXB21L/kEout9Z2wOEyOgVQTzo5KFUtDmHLRsEFBba7qsU9IGoI/h+0
         eRT32FWo1bcmZV2/7r/xVZsEpjK+RStSQ8CaV+fJ3pFSKo3nxxW6rxuH65+GDAL8JR3L
         glQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQI2fQjiYSpEX5mozp39dn7uulVnW5slxFb/B5VyFcyBX5XnKvFBag23u7ubPIEWmVFgY=@vger.kernel.org, AJvYcCVaC4cD3o7cmVE93MsoyoIteMBTz8teKfFfirTFI8hNz38ZuyszEBkS1dVm6Xhh4u2+Jf+dYyyStpVzHB4EYcNmGDqz@vger.kernel.org, AJvYcCXdZsbbRaTAOs66Ti+QQnNP4iiCRWott9ksG1pywzPXNJiX9CitDOp4bOhPm0TgKkNWLaoxh8rJEnPiWSbM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs99r9AwiaEY7X55CcHB57JqEs+j/ravMQWJRrrqwOjJm0Jqpc
	cWYteZtRd6ryZkIJ7Fm8vuah4/kGFobhzINeQ+HMPFkVfK7ux2nnOmspYFfm7eHJi0z0v6+Z0dD
	0glbf+9ty4vwWdiyT+Zx47jeuaoA=
X-Gm-Gg: ASbGncuValnI+UEDqelNk2k2I3HknyDRj3OOnxzzmQD6wsKWWuqaNFqCaK/aKZO1XKQ
	Z+tUU2crwe7GnGKsmpZxDRHqj/X9plCcb2p/xEq9tGXFbLTldfFlkWNFlBrZenSd2MNabSXC9A6
	Z+LsLvM0waeYUV01qOwrXRQ+d9klCHw6niyvikYa/wGA==
X-Google-Smtp-Source: AGHT+IHsdVcRKU/HnAfaKmj45OiH/aGPI+lfz6VUo5PCwjZekRmsF12vaqobS72FeYh81aDSDOF6uW4pPq/F9Ohz4Kk=
X-Received: by 2002:a17:90b:270e:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-3056b763ac5mr2155472a91.11.1743545833400; Tue, 01 Apr 2025
 15:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401184021.2591443-1-andrii@kernel.org> <20250401173249.42d43a28@gandalf.local.home>
 <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com> <20250401181315.524161b5@gandalf.local.home>
In-Reply-To: <20250401181315.524161b5@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 15:17:01 -0700
X-Gm-Features: AQ5f1Jpy9wZlb6kYNbOfLWFJ_JgrVUqW3aufwWwkFsC5kDKyBIwH9DiG_-fmIas
Message-ID: <CAEf4Bzbq1AMdpBysK-OqJPwrKpibyLk9RffiwEU9xdGwwHC_3w@mail.gmail.com>
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before current->mm
 is reset
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, mhocko@kernel.org, 
	oleg@redhat.com, brauner@kernel.org, glider@google.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 1 Apr 2025 15:04:11 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > How bad would it be to just move trace_sched_process_exit() then? (and
> > add group_dead there, as you mentioned)?
>
> I personally don't have an issue with that. In fact, the one place I used
> the sched_process_exit tracepoint, I had to change to use
> sched_process_free because it does too much after that.

heh, I ran into that as well just recently and also had to use
sched_process_free instead of sched_process_exit, because between exit
and free we still can get sched_switch tracepoint trigger (so it's a
bit too early to clean up whatever per-task state I maintain in BPF
program).

So yeah, I'm up for that as well, will send v2 just moving and
extending the existing tracepoint. Thanks!

>
> OK, let's just move the sched_process_exit tracepoint. It's in an arbitra=
ry
> location anyway.
>
> -- Steve

