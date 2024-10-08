Return-Path: <bpf+bounces-41295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE319957C4
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595AE1C211BF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E01E0DCC;
	Tue,  8 Oct 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRiZgYqS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A49213EC7;
	Tue,  8 Oct 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416500; cv=none; b=KHi9VGdtXM/p13aaUk2oM+BIv4ML+tORjbs4TXlqYT6H1569rg9U0MfZAVkPVAV38b4gJVDytp1gyy1ru9D1oLwRapgdK9qGzxPvrfw/gskrX8cOT+pSVWQo2f6CiFdODWmlXLcSkWKiUNaqv9cjH2bzQOpoH4WoU85K13B0ekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416500; c=relaxed/simple;
	bh=fVGMZtZhgtHCxuhHyUnzKVZDOTuydFWJ9mdX2wICxOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH4MkrZcyJ8bd8STFFa/Iedfg716mTdW3rfi61LlWfjqO3qWEHtDRUVDqiBqF42ZVV5KtMTA1GMNaO+2pDArZK85C0iWeblKzGlskDYWvehO67nZRaHoeEs7ALAZD2A5nTkC8dK0p+odAB6ecLveIwr1UL0IC2PHsdAWyRBwKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRiZgYqS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5399675e14cso7029766e87.3;
        Tue, 08 Oct 2024 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416496; x=1729021296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubbmBflcQYl2zP8nv9YP3haRuCtPw16r/0MycKENL+U=;
        b=eRiZgYqSWAlzsJrj+VqSltKUDXsPu3YskxddL9NH1BC+GostNprfGf+ahgA5djbI8y
         oWqX57Fm0IJRKo4FNmEbxMZYAo0hk3Am2UV14NDLHfL+7qdR9mNRMSojI7TDmgedShtE
         YsQgQkj3TRGNrgEMEQQxSc5pt/ea89YBNXEXcQl+ihujWpcqBBXY3/n8YIusvRQkn/Qa
         602G+rCL7y3zqsebGSk2P9XjvW3qoEttnnzRg934h671E6Kt0NTVCTJTPVapepiqutw1
         dBL2DgCD84Wte3JxaxAxPBO02tfmg1RNYjvHZFPMVIAcUjB4Bc+aJ4V3UyAdgb4MISrb
         vQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416496; x=1729021296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubbmBflcQYl2zP8nv9YP3haRuCtPw16r/0MycKENL+U=;
        b=M1U3CA4CcsUY45dEQ1uAFgBF1j0kuBor2VVHKw86c4XVEFjir29n+N9p9VwTPuMXna
         V5RWQtO+wWmSSQjJhWzw0svkswXjGBaoLvkl2PZ08Z+SEA2Q+SnbWXdIzhMZ/G0sN5uX
         6LnBYe1bNIeeeCzrnGM4iYso2Os4OtsbLLbuz0dExd5b6b/z/ZOwwcd0LCj6MWEMfAgu
         Atnd1mjaZtvvOKZvC2mhyxdqsSRx6azSp/F4QDKpGTXgvgxN0OvAQZF+/EaTU13qAi9L
         L0DRRaYxXY2MNEMQmt0DQfJ91LMbtxetbUu+5XbYx9h4xaZhAqOKDtnCWygNcKe/cWOS
         g1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJEAOsWvOclUIHItKQXyX5f8a06++pkIXwoHh5GIR4peKnggu00vDMoSCnY4hdAw00Qmc=@vger.kernel.org, AJvYcCXj+233yqRXcHC8gmJGIo0LE9QzzROUdItFrrzpB9sjz5yYB509saihlIf0sFXzhpniYT+1a0Bvm7UZaLuu@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKOQMaiLdU0fwb1Y96Ko9dgnrRL6ZfXDTcdDzQ6ehCehKtnxi
	weZO6Vsy+N/hqxbNmFIAa4/wjVVYpYA2BRI6Z2Y+adPBGe4bPa6ytwzizuBOu3Rg6gFXHxe6V0P
	Xd2s2KezC0xYyeuTX0CKT/WkrY0U=
X-Google-Smtp-Source: AGHT+IGqIxIVzVAfRF4E8lIehQu2QDm54fmsyMsTO2KtX3X0XxhDyaqYworH63hJ1HFcE0ofa436QIXdupAQ1EQQi6c=
X-Received: by 2002:a05:6512:ba2:b0:536:9f02:17b4 with SMTP id
 2adb3069b0e04-539ab9cf41bmr8639804e87.40.1728416496101; Tue, 08 Oct 2024
 12:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
 <20241008192910.2823726-1-snovitoll@gmail.com> <CANpmjNO9js1Ncb9b=wQQCJi4K8XZEDf_Z9E29yw2LmXkOdH0Xw@mail.gmail.com>
In-Reply-To: <CANpmjNO9js1Ncb9b=wQQCJi4K8XZEDf_Z9E29yw2LmXkOdH0Xw@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 9 Oct 2024 00:42:25 +0500
Message-ID: <CACzwLxhJTHJ-rjwrvw5ni6jRfCG5euzN73EcckTSuM6jhoNvXA@mail.gmail.com>
Subject: Re: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Marco Elver <elver@google.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:34=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, 8 Oct 2024 at 21:28, Sabyrzhan Tasbolatov <snovitoll@gmail.com> w=
rote:
> >
> > Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kern=
el
> > memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> > the memory corruption.
> >
> > syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> > KASAN report via kasan_check_range() which is not the expected behaviou=
r
> > as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> >
> > Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> > copy_from_kernel_nofault() with KMSAN detection of copying uninitilaize=
d
> > kernel memory. In copy_to_kernel_nofault() we can retain
> > instrument_write() explicitly for the memory corruption instrumentation=
.
> >
> > copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> > CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> > kunit test currently fails. Need more clarification on it
> > - currently, disabled in kunit test.
> >
> > Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1=
X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> > Reviewed-by: Marco Elver <elver@google.com>
> > Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D61123a5daeb9f7454599
> > Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> > v2:
> > - squashed previous submitted in -mm tree 2 patches based on Linus tree
> > v3:
> > - moved checks to *_nofault_loop macros per Marco's comments
> > - edited the commit message
> > v4:
> > - replaced Suggested-By with Reviewed-By: Marco Elver
>
> For future reference: No need to send v+1 just for this tag. Usually
> maintainers pick up tags from the last round without the original
> author having to send out a v+1 with the tags. Of course, if you make
> other corrections and need to send a v+1, then it is appropriate to
> collect tags where those tags would remain valid (such as on unchanged
> patches part of the series, or for simpler corrections).

Thanks! Will do it next time.

Please advise if Andrew should need to be notified in the separate cover le=
tter
to remove the prev. merged  to -mm tree patch and use this v4:
https://lore.kernel.org/all/20241008020150.4795AC4CEC6@smtp.kernel.org/

