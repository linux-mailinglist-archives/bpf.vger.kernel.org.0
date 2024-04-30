Return-Path: <bpf+bounces-28221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874ED8B66B7
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32C1B21379
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D163B;
	Tue, 30 Apr 2024 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBy2dicw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6D161
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435560; cv=none; b=ntCGs7H1IdeF+JMxpYFkYPR8bS2Hb933A28RwDM6eu97CRcWpD3cfDuWeBya35r0WhU5TCkDaxwVq+w72nrPtvgPadju7hkOU6S5HYgMwALYyZsQlOnDjsPnRLkcixdu1WjUcM0pc6C0AtQMeafdcm2LhBK2yl/8YzRuNNJb4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435560; c=relaxed/simple;
	bh=gJuDTVJm9AcKVDDIfX5i9uqqPFvs2NbSxmNtE3G0c24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDTOHMde0hbLajN7RRizFx+E5SsZbneu0bIzIMMqtB8cWpjiAoDdaKFEG1C+Il8aGbMwJZ6wg6o3DPZOerU6JYnzfmIkXHJJrHwi0Yj/KahecS3jWjQAc0C5Fqk5tp0hkAvpWpyW9KPUy1qjmbFh326fTw4gvtWkKhU7vyJ8g50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gBy2dicw; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db17e8767cso59719921fa.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714435556; x=1715040356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls/x91/XqY1/yjdZUA1T/JakK/e7WGx+3CLMLeqey1k=;
        b=gBy2dicwPX3wor30/w/Ti7MrkDC/1x4fkQsKnRckY95s4Tkez0P9VLlIxYA4AVNZ4l
         geQJCOAKdsd8ammraKYj0chA/s4Fi182QnmZfCEIi+d9DwHwtnkoUOwLMFtDQ38Y2VUJ
         7+EvFQNnprhhnmcz58ha/Ht3YNSipUFsDROhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714435556; x=1715040356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ls/x91/XqY1/yjdZUA1T/JakK/e7WGx+3CLMLeqey1k=;
        b=inzeM8VWzXM1ztk6MX/1wqY5mk4k5FjZ2zbLy1skcNUB8XjIvMf8eBVnEwaLZ+F0rG
         zIzonNHWTKnqf+9/NOl9M/Zg4kElF8h447GibSk6oNzZ1YgZtBSiGv8203Cu+koB+HNJ
         coksgRjDZVx8KS82Gw8d2cpj6AHHYHoX3Mu67QkEszW9vSKa1dpCGc0BrzYxpJ+KFmW1
         fbpGU2CfHzm9D7ipYiMtoJNRw1EqnQhrdHcbI/w/IchzNliJVEcc10cdLvuF367jUQ38
         Sv4Im8xuq6MePtGY9b/qsFKK9ZGPN21KkUeOzofW0Pe3JwX6RCdRZ6glSa44FvDDwdFV
         L6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUmj03Ys2/CKuFIiZWIv6veqBnmalbp8HNWowENrsrNRWKS8y76VAdhanBLwvxfQOCR1LNNyW+DQ+xnrgrnNqo8kGgG
X-Gm-Message-State: AOJu0Yy3PdyHX5wHxZ8Ni0tdPEquPlbPkFlFez3I+J1e0OzYcF44AppI
	tIkBP+OU0Ev6mLt09c/TNnxFxUPFyUEIzofV+XI9dwsijsBF8opdDKwYJLENkISTGaLQcDKoIEe
	75YNTOg==
X-Google-Smtp-Source: AGHT+IEp8HYbSb/FGUtjaOpT1grLaOQAn43BwMWXOh+zh0+QFBYDjwJS7qOqnniwdWK6Lv0ELSRbVQ==
X-Received: by 2002:a2e:921a:0:b0:2d4:9fbe:b5f with SMTP id k26-20020a2e921a000000b002d49fbe0b5fmr710908ljg.36.1714435556526;
        Mon, 29 Apr 2024 17:05:56 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c9-20020a2e9d89000000b002dffca24d97sm796854ljj.119.2024.04.29.17.05.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 17:05:55 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518931f8d23so5286175e87.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+Pe7yqxwMxlmAREzX6sDZYZ/ACxXNQkFVRD4862pthXaIpTmSuVpuF0AA8937iXl3xDeUhnlCIDQyxFnna2gJbfV2
X-Received: by 2002:ac2:47ee:0:b0:51d:6f21:d3a4 with SMTP id
 b14-20020ac247ee000000b0051d6f21d3a4mr624436lfp.66.1714435555174; Mon, 29 Apr
 2024 17:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
 <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com> <CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com>
In-Reply-To: <CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 17:05:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW=HyBNE2sx+rVyB2q+Xuuah+Ycp4o89+prgHUFHm_hQ@mail.gmail.com>
Message-ID: <CAHk-=wiW=HyBNE2sx+rVyB2q+Xuuah+Ycp4o89+prgHUFHm_hQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Hillf Danton <hdanton@sina.com>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 16:30, Andy Lutomirski <luto@amacapital.net> wrote:
>
> What strange page table handling do we do for XONLY?

Ahh, I misread set_vsyscall_pgtable_user_bits(). It's used for EMULATE
not for XONLY.

And the code in pti_setup_vsyscall() is just wrong, and does it for all cases.

> So I think we should remove EMULATE before removing XONLY.

Ok, looking at that again, I don't disagree. I misread that XONLY as
mapping it executable, but it is actually just mapping it readable

Yes, let's remove EMULATE, and keep XONLY.

           Linus

