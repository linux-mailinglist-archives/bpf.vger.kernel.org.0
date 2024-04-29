Return-Path: <bpf+bounces-28054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16728B4F04
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 02:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A0B1C21393
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 00:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D9624;
	Mon, 29 Apr 2024 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YZs4FT6z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BB7F
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351852; cv=none; b=Zy1qgKpp1Av8WPlR2ZwUGYlhIZId8/h/mmkni06v4mn5Nz1oauqLid30dbkIcR9HLLKXbBtd+5GS5C8S0n5uWHmNot1cUoGsQXnZwgLwfPK/3c4uivqDkfXpgN5RT2zEqdSru51L0G3bGDd5r/WSLVFLOBBZsLF4uvnEaM289Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351852; c=relaxed/simple;
	bh=8oDxzBVo1kq0eWqfKhLqk7ONSyhHgSnPk/KmVfBq9lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWXFN3deIoKUgBjb/LC5BEdtLTQamlu+nWnotq+sn8wGxIyo9qBlE3lhMHM8qe93uI5+MDbN6/PtphUADplDSkZ5Ag0yDqEdiUYZhgiJgaFkCBXnJ96HCU7lvwvoNN0d4jjIFw9VNGhCMkYthyX0TPRZfpTtKwQd+XY+SemZmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YZs4FT6z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a58f1f36427so122282966b.3
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714351848; x=1714956648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov8T+3rEvepBtcwwxhOn/X1LqhIWl/sTR0FMGae+mzs=;
        b=YZs4FT6z9EdEAf4YJnVf4JJUAXkpCAVFf3hlJQXvctmUOEqWdSk4YhC/b5BcDcTU2L
         r+5rjEbQBTv2koVcwe7zWfCRzhDbOMZDHmI5wUhiASgMJWWEcl9qJUDB4H6RqCUr4Iaz
         6jK8HTlqWj7opAM1ovi0fIt7g3I7wTFIxCho4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714351848; x=1714956648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov8T+3rEvepBtcwwxhOn/X1LqhIWl/sTR0FMGae+mzs=;
        b=C8OIKo2yaSm3eM6XVz0++pwZeQOUS70ByUuB12rbSu1qJrolqYgGijF2D3ysOKOEkR
         tilzUXbc/NHF1QgRDs56Pe5noHI8LtbbEFZeBYGqkNvpafOB/DGM3ngy7wJ7+MOxb0dR
         ACZIFclFm75VkhNp76xM17wAoX+oTdxXcjKRZSPajalN/bqlwS2FP7pcg+S/uIpOHtEM
         58l8hC9Zaklw/ypigkJghOuXxopQuazaGSw4VkgSW8UhWEWXuXTuCvYaj5tjtn5x/AtR
         2v3WuGsZP9XgvgbE7bRMCXJIULFC9PXQxUX8hFYIlYybVcBknp299gNgVzqpgZxfcRhN
         JREQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+JGo3CWPZWD7z2Xkm1yPylmrX6kT6TrdtySAxBOUGNp6rDBwcpnHBeqg7HhZhmTdpQnG0zSstAIH+KzK6dxK4aT/5
X-Gm-Message-State: AOJu0Yx7vodWyajxneHlaqjvB/9QjPlbbT65QQmGjBhFSWxCRuvIENvz
	BOxoz7TSIThV8CWuorzRGcLPuAlKwraQ3gtVhUyM8mtqqBU9QMzQoWVtWuL3AlLPuN56ClNmx7x
	W2Rjc5g==
X-Google-Smtp-Source: AGHT+IFn3P0jgKKzrJdNYuXj1b2CEF1pxRKc+gdUVKL4JJdGdQkICl5OdRnc02r5x1ceKTubHBZx2g==
X-Received: by 2002:a17:907:78ca:b0:a58:bda9:cf2c with SMTP id kv10-20020a17090778ca00b00a58bda9cf2cmr5327175ejc.3.1714351848430;
        Sun, 28 Apr 2024 17:50:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00a5256d8c956sm13243420ejb.61.2024.04.28.17.50.47
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 17:50:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55b93f5540so514311066b.1
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 17:50:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWahLfHFPyF39aR2w8nDt2CXL0YH39pS04WWfRQyULlzu8OyWfjexkLbVqrrhTY3QKv+gN4XsG03BJhCtow+kVCQtUR
X-Received: by 2002:a17:906:6d3:b0:a51:a288:5af9 with SMTP id
 v19-20020a17090606d300b00a51a2885af9mr5202593ejb.51.1714351846927; Sun, 28
 Apr 2024 17:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com> <20240428232302.4035-1-hdanton@sina.com>
In-Reply-To: <20240428232302.4035-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 17:50:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Message-ID: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 16:23, Hillf Danton <hdanton@sina.com> wrote:
>
> So is game like copying from/putting to user with runqueue locked
> at the first place.

No, that should be perfectly fine. In fact, it's even normal. It would
happen any time you have any kind of tracing thing, where looking up
the user mode frame involves doing user accesses with page faults
disabled.

The runqueue lock is irrelevant. As mentioned, it's only a symptom of
something else going wrong.

Now, judging by the syz reproducer, the trigger for this all is almost
certainly that

   bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f00000000c0)={&(0x7f0000000080)='sched_switch\x00', r0}, 0x10)

and that probably causes the instability. But the immediate problem is
not the user space access, it's that something goes horribly wrong
*around* it.

> Plus as per another syzbot report [1], bpf could make trouble with
> workqueue pool locked.

That seems to be entirely different. There's no unexplained page fault
in that case, that seems to be purely a "take lock in the wrong order"

                Linus

