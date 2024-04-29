Return-Path: <bpf+bounces-28211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511E8B663B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CE71C212E1
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90A19069C;
	Mon, 29 Apr 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="LfmuV6E6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1951448DE
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433409; cv=none; b=P2LZ0BK6qNhCxFmRKGK5lrd/rAT16HDaftXtIWpFwy10XB3AcfD6BZNth/bt3CTqK9M0BDpv6Tw8yOO+pIiyBAy/lpLsESRl6r954HI/wpUmcevWIAPkkrOPnhD8APpMjJxvSuL/VgPgUUgt0KnvgSJV9ZjzWnMMvJSD/CJFMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433409; c=relaxed/simple;
	bh=u0KHfnhQSTTAa6+Ev4aG0HxtMJ4Us7qI6bmhP7ma5po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edk1mJj1fmhENS969W/HOySsjDjbt7jMg6p0z8tafjlfTQtj+yoPVoi7/Ckp4R4QUnZkSgtfzrpDjGYJdkXtgHxmThrrwO6U53t8FGA05PSS9Q/Wzbue4NbeT1DTAXbkQRXRjmlUW/nLRBhTcob+aOM445fFlEu1U8mVxLi/q2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=LfmuV6E6; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4daa8e14afbso1534242e0c.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714433407; x=1715038207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvmb57NgTeO8uIkd6BBuUzWtadOgqdJbm13OykRMpNU=;
        b=LfmuV6E6gZYi6Es+LEXgCk/RfMr7RGVNOX6zzviputiPhgaRA6J1N5j/ppCA62Hm72
         981ZWutuhS2GuOMheK/ARLSGpm+mAkcbfhXEcFVE5J2ydcjGvV8zAmQpOmGVBj3QhJ7t
         E579D6GNeRg9Y9PaaT4w1+va60vcP7+WNSLrXdx3U2hFmZaYDU3WlFPjvSKx4PNjWnV/
         q/5A/pvqzVD6dDJ5HSNrwnyZBDSBH5OfpSbi5EIkG31520ZbJpG5/I22UDU4WFyJRkSy
         h8LPEtf8R9aNJ74qioxFueuTzq06qo146COEyhFZvKvKOxkJI28q/lndCL/Sal0Af+L6
         tlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433407; x=1715038207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvmb57NgTeO8uIkd6BBuUzWtadOgqdJbm13OykRMpNU=;
        b=eD01DEvHGCh6z89fR3KXsFFjx06IFvuBoSvOPtLCsqpceuufPxyAmk2f0cAFHKJspu
         AijkqocLmmxQAkneGXZxyKhSr7sK23/mGzYKecvDG4iBVkvYuNnEgPJ03TMyNXIy4iA6
         RHnScuS++mXN3437z5c+FIq59yTluihMZEBATFAuUXaED8ajEx8+ilRHGd/dygSvl7lt
         +cqJN1DyyqAMILsMxvWy5spQqvQN/xnEpabdVBgLI78AjQUr3KjFzulYU83Mngzmltz5
         a52aD7xqH2kWHXsemmqZJoduIk/4nfDULujBhBdXD6XAbQ/nMfOlygqtRy45N0xFTZVp
         yg3w==
X-Forwarded-Encrypted: i=1; AJvYcCUv2w4w+AlkI5Zj0evFea5tIWhDIMFTrsJmVOGgj4CrQJWjd7OuXYT2XuSlxM02WBjWUW/WCPrq96CoXot9btVfv921
X-Gm-Message-State: AOJu0Yy3ewoeu2SxV+EvlyyArwPRLrZp/XxWUiCbj9ZVex73NpEjDic3
	yfoZUgPVMolWBpppFf4SO5PLJ5cByNmuWqYxrS8Z9qxeumsN+TORMKlVO0UyZafjb64pk8yV7wf
	UWdUFsb75+b6cjNegV/UM7drR0jXNFFILVOdv
X-Google-Smtp-Source: AGHT+IFQ6TF11qD3dSWxMP3kCR/1GHDpO7sIX6dXB0PaZw3Ummfl3Kpezh5cj9LOGtzU4ydgTxtKPh9a3+35MtHp8fE=
X-Received: by 2002:a05:6122:200c:b0:4d3:4ac2:29f4 with SMTP id
 l12-20020a056122200c00b004d34ac229f4mr11565163vkd.2.1714433406711; Mon, 29
 Apr 2024 16:30:06 -0700 (PDT)
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
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com> <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
In-Reply-To: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 29 Apr 2024 16:29:54 -0700
Message-ID: <CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Hillf Danton <hdanton@sina.com>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 29 Apr 2024 at 11:47, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > In particular, I think the page fault emulation code should be moved
> > from do_user_addr_fault() to do_kern_addr_fault(), and the horrible
> > hack that is fault_in_kernel_space() should be removed (it is what now
> > makes a vsyscall page fault be treated as a user address, and the only
> > _reason_ for that is that we do the vsyscall handling in the wrong
> > place).
>
> Final note: we should also remove the XONLY option entirely, and
> remove all the strange page table handling we currently do for it.
>
> It won't work anyway on future CPUs with LASS, and we *have* to
> emulate things (and not in the page fault path, I think LASS will
> cause a GP fault).

What strange page table handling do we do for XONLY?

EMULATE actually involves page tables.  XONLY is just in the "gate
area" (which is more or less just a procfs thing) and the page fault
code.

So I think we should remove EMULATE before removing XONLY.  We already
tried pretty hard to get everyone to stop using EMULATE.

