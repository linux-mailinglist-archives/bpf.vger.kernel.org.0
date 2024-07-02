Return-Path: <bpf+bounces-33700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EF924B9F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD61F23238
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2B14B977;
	Tue,  2 Jul 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrVyYa2b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899E1DA30E
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959756; cv=none; b=BZ9zvvVR+MEb+rXtoQRHQGS1loARHBwynZSz3Z+rAUKzkQOEhS6bjRJ0jdO0QSmdwWeXTpJGIY+kWTxT7EsIRWL9nHg7sp9Ywu9XdQxnL1dFr3rPUR7TiI9CozHYoYYUmKzZAv55AqUw4CLOTZjWYU78Zm/JgrEqL6wNWdoN82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959756; c=relaxed/simple;
	bh=LzpLBt7sr9BaKFERQhGA4/jBAkPrKXa2+pIieXUYQ7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiGMourFdAGndT2/e8yi9Wo8/ln59vrOTbo00hjqlidGcvOAuMxrpwBOBDKm7pt8OUqYYmvF9u/HDZczb4+fPubzSyBW9WFf4QNzZA633Quz0GwyP6oIVi8wgOPJ/eNmOWpmPJQXjQjuc70nJA/zOGSUsWcBoKY9UdE+XzYCovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrVyYa2b; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36740e64749so2908776f8f.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719959753; x=1720564553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2bOmBawLrkYhHUE6yDTZzH4ERg/YXFkFULSJJPxnAg=;
        b=OrVyYa2bTGTXYn/Z3RUvLLSzMvR4SB3MkgY+ASWYlhFEF9yYxYEDtey11QMbnkHw54
         eUApltUCp0JIntGZysCqhV6PatBH7AP7j9tzJznp2cbkOiP56hyhqji6iL3wE1w4Wlr2
         CDQ0cCGuVF/714u1Ou/fb5ra7RfXL1GPsIGp7Rrw6/M08rqswVck8UdsQBRMQ6giJPjC
         PwSYR6TCiitQyTuXJfV9bZCWcSrCySEeUyBnfG4y/RxOHU5dmFA2gqTthEeXKZP+SXs6
         Vz9VLIFvVVFDY36tD1LxvKj+2G/0PVYxsKIWdya5EqZSoelWwkk0Zaj1n39Nn+mBhgG/
         RyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959753; x=1720564553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2bOmBawLrkYhHUE6yDTZzH4ERg/YXFkFULSJJPxnAg=;
        b=lbvnfaxPdgNEw8MRdeyjoXak5Xb6M+U0h6B3113GAgoAOCJoNsZGcaUbojgH7ikz41
         KtyYhKWDkMI3bJPAAD3H2C9ATrq/cpwT3890o05DN6OLep2CFznGErJ/2KyXH1/pTUIs
         HJLBE+PzPe4GRh4yIMTVn+sN2v0EO0nzcVbvz9D7fKIz8bXKcwzC2ku5JbvmvjWqDAYO
         MDE108Z3rjGWamRnN2W041biu0JLcgb4C36xKQ5ZBiwM0Oe7H6QJ329kJ2RtO6xbk4Mc
         bfUUvyv3qbiG7PfslAZHgMtO0vXKdABnxgdKe6VMeey+1L2GheLN2pgz7tPLzYR49Omq
         KTWw==
X-Forwarded-Encrypted: i=1; AJvYcCXdGaDEYtcKpITm41xAuslFuMMOP41hcykRZUuovw0+abw++aUwhDcIqIV+5KNS6YtMjGwn4j1HQhpvX8a1BowUkPe4
X-Gm-Message-State: AOJu0Yzn8bVE7mUQx0+MvOB+k6ITBf5jkwMuNoj2b629o6AK2bKrovFD
	SV3XMYBKIsfhaBIRacJCPbrdbubFuVuxnn1tYrnyQ2mIBUW30fdlmeHugVj828n963MWeulz/cn
	GjwdKdx8vWqfNJnXwTwfKj3ByrEackpguD+BbqHouygp2E1sBiRMR
X-Google-Smtp-Source: AGHT+IEFwhG42oXvgsr6r2k99l6CF5tFarLCMAJ++99P49IhNtMO5ULVTz+ShZj/NT7rtPwroQ6bFGNyzg/z3hMMHOE=
X-Received: by 2002:a5d:42c5:0:b0:364:7846:8ce0 with SMTP id
 ffacd0b85a97d-367756ad163mr5557753f8f.21.1719959753021; Tue, 02 Jul 2024
 15:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002be09b061c483ea1@google.com> <98dcfbda-6237-4bf6-bc66-6f31cf12f678@I-love.SAKURA.ne.jp>
In-Reply-To: <98dcfbda-6237-4bf6-bc66-6f31cf12f678@I-love.SAKURA.ne.jp>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 2 Jul 2024 15:35:14 -0700
Message-ID: <CAJHvVcjOjOTyrf4K+pTQ30doOx7hqheTExZY6_U+PCcdLigg7g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:09=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> The local lock itself will be removed by
>
> mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer
>
> but is there possibility that this bpf program forms an infinite
> recursion (kernel stack overflow) bug?

It looks like the answer is "sort of yes", based on this stack from
the syzkaller dashboard:

[...]
[   54.017745][ T4691]  stack_map_get_build_id_offset+0x252/0x360
[   54.023698][ T4691]  __bpf_get_stack+0x1d7/0x240
[   54.028425][ T4691]  ___bpf_prog_run+0x5f6/0x2280
[   54.033415][ T4691]  __bpf_prog_run32+0xbb/0xe0
[   54.038058][ T4691]  ? migrate_disable+0x38/0xb0
[   54.042785][ T4691]  ? trace_call_bpf+0x4b/0x3d0
[   54.047944][ T4691]  trace_call_bpf+0x164/0x3d0
[   54.052580][ T4691]  ? trace_call_bpf+0x4b/0x3d0
[   54.057302][ T4691]  perf_trace_run_bpf_submit+0x3b/0xa0
[   54.062809][ T4691]  perf_trace_mmap_lock_acquire_returned+0x141/0x170
[   54.069877][ T4691]  ? __mmap_lock_do_trace_acquire_returned+0x3e/0x200
[   54.076596][ T4691]  __mmap_lock_do_trace_acquire_returned+0x1e1/0x200
[...]

__mmap_lock_do_trace_acquire_returned is called with mmap_lock held,
which apparently in this setup eventually calls down into
stack_map_get_build_id_offset, which also tries to take mmap_lock.

But, note that stack_map_get_build_id calls mmap_read_trylock, so I
would expect in the recursive case that call will simply fail, and
then stack_map_get_build_id_offset appears to deal gracefully with
that?

I would guess this is not unique to the mmap_lock tracepoints though.
I think the same issue would exist any time a tracepoint is triggered
with mmap_lock held? With ftrace on the right function I would expect
it to be easy to trigger this.

>
> On 2024/07/03 3:54, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc=
.h
> > git tree:       bpf-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D130457fa980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D736daf12bd7=
2e034
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D16b6ab88e66b3=
4d09014
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125718be9=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14528876980=
000
>

