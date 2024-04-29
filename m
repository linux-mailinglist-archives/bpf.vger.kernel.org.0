Return-Path: <bpf+bounces-28111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086928B5E1D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76E42815D4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D082D7F;
	Mon, 29 Apr 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QgzRthGE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71558287F
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405892; cv=none; b=nMGZTjqeK/tBQ8pri8b/XXfJiJd0k9H5PF9EV/o+4AciJ6WXlsOHwJ87xBgV1UWNHU1fC3aCSVYR5VnujJc7/jMruCiBIUbT4uZqziiXeQ3D/SJxw31RJGb1vTskM46kviA3/YwrAHofUFct/NXIUN4yDMcDcZUDuJeefHTif4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405892; c=relaxed/simple;
	bh=D+lhvJrYhUxu/0pChQYcmnU7oKvWHnEID0aAXtlOzO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmYepbRYPWmNj1bPIyOB0ldjq43GHNZkF6E3NLoZGEgKyFQvR9/ypo2FV5xtBQlomMg2QY4gjVtpHtdYMzlA1/iaEC9Z2znu95CxtlB8PF/sI7EwytGQ//d1ciUdMmXntn6SkpCfVdbRzAJWLnkIFN+q+dhrezbAeXJ0neoKTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QgzRthGE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ca95db667so4078596e87.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714405889; x=1715010689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXasHxM1egr/YdHGYASIzG/58nZx0kha5r74ZHvQjpw=;
        b=QgzRthGEZDs7SX2U7FD5DpJQtnz2zu7lNNEu/Ok8VNXHadLIZrPSVm7qAWvuhd93nt
         TV14pynJ4+p9HjL88FS28O+0t3Y0EpfV14/hVa03AXzfecIO5775zAUCkTvQHNOrop6Y
         VpA6rZqVZbco6b5Ey4ntPm9h5wUtQsqngncZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405889; x=1715010689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXasHxM1egr/YdHGYASIzG/58nZx0kha5r74ZHvQjpw=;
        b=gAhe0VMPSWtIWwMoYl3M4N8LGF6Rqy1wiZjwDIjwMGWzKvzXs2Tj9GdLCo4NRyYB9e
         ASC1nJJ9hvmNi0nMQyb4bDz07Em/wxOv22TkQfdRcX10ZbbR9KgZunuZ/6m02CFKDIAF
         E/jz9NvAKMZ1UgxtDofrv9KilPc52hwZIE0RIbCXFDeV3AN2aNrOurqoDPflI/9nPYe3
         HzShbsAPFnEyg1sueUVGEjomRxuXi+LzENYUEO3qllIHEOHiOJvcd0k3jyvFJwQ8K7Us
         yx7iV2hBnfkHwvRqo3JYb23nIcrbLM1IKsRs3Fa69kCBr28ULJeiVk8EkvSL5C9Y8mK5
         BfQA==
X-Forwarded-Encrypted: i=1; AJvYcCVXDeOPqKAZcaydvPpyGs8ENf523AP4ek6g7ksj9z0/7GI4BgAu4PT4FAK22rWYea+qf9B8jx3ynLZuz7x0w0tDvb2r
X-Gm-Message-State: AOJu0Yxmy1inMTvkHd3pFFjSfiZN6KGnosPQewWGdIg3F9Fkko1GbXwP
	/fLKCt38NpGK8gJHCrDrGmmpHmAPJBKzEkPXN0I44Pw7S+1Yr+mSbiyBTYIN8KRmijqbf+VkrNK
	ufCxf+Q==
X-Google-Smtp-Source: AGHT+IErpOCWwtgdNKR1HVufVXxSHWhUogKwITjDpIJZCfr2uop4yYIaVFzLXvqqEm7mXYTfmPs2sA==
X-Received: by 2002:a05:6512:1081:b0:518:c69b:3a04 with SMTP id j1-20020a056512108100b00518c69b3a04mr10956884lfg.0.1714405889000;
        Mon, 29 Apr 2024 08:51:29 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7d691000000b005727ce81ad5sm1825066edr.81.2024.04.29.08.51.28
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:51:28 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58772187d8so563627166b.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 08:51:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJlkrAPfiSvwn1hML54RFe4WAzR3SAn27cOcO/tZK7UbsM0esomGWFrx8q5mb+MKT4PevdgE+uTdi2ArW0VEXGUg1t
X-Received: by 2002:a17:907:7890:b0:a55:54ec:a2fe with SMTP id
 ku16-20020a170907789000b00a5554eca2femr8987483ejc.29.1714405887417; Mon, 29
 Apr 2024 08:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com> <Zi9Ts1HcqiKzy9GX@gmail.com>
In-Reply-To: <Zi9Ts1HcqiKzy9GX@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 08:51:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
Message-ID: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 at 01:00, Ingo Molnar <mingo@kernel.org> wrote:
>
> I did some Simple Testing=E2=84=A2, and nothing seemed to break in any wa=
y visible
> to me, and the diffstat is lovely:
>
>     3 files changed, 3 insertions(+), 56 deletions(-)
>
> Might stick this into tip:x86/mm and see what happens?

Well, Hilf had it go through the syzbot testing, and Jiri seems to
have tested it on his setup too, so it looks like it's all good, and
you can change the "Not-Yet-Signed-off-by" to be a proper sign-off
from me.

It would be good to have some UML testing done, but at the same time I
do think that anybody running UML on modern kernels should be running
a modern user-mode setup too, so while the exact SIGSEGV details may
have been an issue in 2011, I don't think it's reasonable to think
that it's an issue in 2024.

             Linus

