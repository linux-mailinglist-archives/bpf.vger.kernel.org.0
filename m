Return-Path: <bpf+bounces-41223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44E994437
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878771C22BB5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66116EBEC;
	Tue,  8 Oct 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDViIe17"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CE2566
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379656; cv=none; b=nru8CQLJs1Gj3w+0o2LvuoSGp8+vkOfFsWzcMVS7OVszn952MU0PjS594qG9jptHHyJ1nNWARiYUhjXSRn5RAxQmB0y+rywlE+8CEw4zk6kWCkG3qqZH+48Yc325fSiCmiXO8q6ycM2lheRvNViEZxFMEmQo+m7QnUg1D4Y5gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379656; c=relaxed/simple;
	bh=88D/Fq+mjy0D1DO6zuCimKIvel1R1AM8zgQjDCMOP/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4khjFS0L5OS2hRHmB7ubCzXZAhdt3w0NFczV4kW+pg0XSmSDXUY6OY1lDEw2cZj5xeU2YQ1Jb1hEDtxuA2Mkp4Mfos2wIBgiZ/Empq/O1ywE3dRjsty2MjfzOTbUtKlp/PgeOxSkC9ShOAuym+D8Eq0qAPCeXNqC2bllqNSfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDViIe17; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4305413aec9so3039825e9.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728379653; x=1728984453; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftu5SMGfw++3h3QWzAJcU0tvoV223zfvN8/LiEMFNTQ=;
        b=sDViIe17Af8KN/RX+yVgKH4Q3YiwayOM6Sg5lZpPckERaDqrPX4bmM5Qy1bIBgJ8jQ
         sXld1ZX/2xzLysJRktEPSwkiHVMkFrYXb42Qh5iuQQG4xDg5ErZxt0QD6WsLTP8dQXWR
         l7iNiWUVhlCDvOuaQMme3uFcql9J7hOxrGIiWj/uPTjN5l2DCpQ0oh+0Igcrm/ZPW+01
         hfIxlag0n3W4HTBCrb1ZGSF7h9iDN2iq7M5Fa15jFrgZDvT0FwxwLkz7wZEAKWtPTsmG
         guG5CWB07+YTRzPPFsZHNSd8aO69S8zCz3PVJQWlBD0oncjKg/HbkSE5eBSbeWIFmjiF
         0TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728379653; x=1728984453;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ftu5SMGfw++3h3QWzAJcU0tvoV223zfvN8/LiEMFNTQ=;
        b=bHLlW3xTqaRYdtn36UZVOrJaxU/82toVm8wxZEPnXfsYKnV5O7ledQA1GsypC8F05n
         mV+QoxlouiIiHYwXK2B5fNYvj7ZJXoYeMAPWmD9Yx5pkxMI9PPd45cF+P4Mm61wiDNTT
         uM4zP8hHw+kK6s3/fpzZpc1irg3m2MiBOL4ikRXM8YQIgWrW0Q7MDa8AqTJmlggqjZgF
         Ot5fkazwN3YMF5ctB0jYRdmSGf4NLAMPMaN6mYdU2UEzbk7k3yiEunQG2BjsbXlJIj6R
         uW0sa2FqjNCQk9RdpU4eHLyTp1L3KzYM96fJ0/y2vrlao7xnbUSPpx7I31B3DN/O8Nz9
         50bw==
X-Forwarded-Encrypted: i=1; AJvYcCUdigvEs6Eqsl5Le+B9N2AJC+tnc37ofErXilRmHb5QQ2hVwcuFv6je1I8/Jkf1lg3RNA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZbJPbsnobpe/f5LIFT75LR8gFzUBCyTtshLYPfKKz6slrZAG
	EcyQW4wi7ZGrivlYK0VexzfFbtHb0tIaSGENDO1Z8otImgc7HFFrXpnhLGpCIQkx/W0TKWmREmU
	wow==
X-Google-Smtp-Source: AGHT+IEyVvOcAQ883pE177fhTi23NiZAjw0ZWzY7AsaEeANWZD6rGY74lVjOqOIHKEywH+G44G+LWg==
X-Received: by 2002:a05:600c:1907:b0:42c:af2a:dcf4 with SMTP id 5b1f17b1804b1-42f85ae8ee5mr101095455e9.27.1728379653199;
        Tue, 08 Oct 2024 02:27:33 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c862:2d9d:4fdd:3ea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f63dsm43016745e9.26.2024.10.08.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:27:32 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:27:26 +0200
From: Marco Elver <elver@google.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org,
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH v2 1/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
Message-ID: <ZwT6_gzV2evijOGK@elver.google.com>
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
 <20241005164813.2475778-1-snovitoll@gmail.com>
 <20241005164813.2475778-2-snovitoll@gmail.com>
 <ZwTt-Sq5bsovQI5X@elver.google.com>
 <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Oct 08, 2024 at 01:46PM +0500, Sabyrzhan Tasbolatov wrote:
> On Tue, Oct 8, 2024 at 1:32 PM Marco Elver <elver@google.com> wrote:
> >
> > On Sat, Oct 05, 2024 at 09:48PM +0500, Sabyrzhan Tasbolatov wrote:
> > > Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kernel
> > > memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> > > the memory corruption.
> > >
> > > syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> > > KASAN report via kasan_check_range() which is not the expected behaviour
> > > as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> > >
> > > Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> > > copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
> > > kernel memory. In copy_to_kernel_nofault() we can retain
> > > instrument_write() for the memory corruption instrumentation but before
> > > pagefault_disable().
> >
> > I don't understand why it has to be before the whole copy i.e. before
> > pagefault_disable()?
> >
> 
> I was unsure about this decision as well - I should've waited for your response
> before sending the PATCH when I was asking for clarification. Sorry
> for the confusion,
> I thought that what you meant as the instrumentation was already done after
> pagefault_disable().

I just did some digging and there is some existing instrumentation, but
not for what we want.  The accesses in the loop on x86 do this:

copy_to_kernel_nofault:

	#define __put_kernel_nofault(dst, src, type, err_label)			\
		__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
				sizeof(type), err_label)


and __put_user_size:

	#define __put_user_size(x, ptr, size, label)				\
	do {									\
		__typeof__(*(ptr)) __x = (x); /* eval x once */			\
		__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
		__chk_user_ptr(__ptr);						\
		switch (size) {							\
		case 1:								\
			__put_user_goto(__x, __ptr, "b", "iq", label);		\
			break;							\
		case 2:								\
			__put_user_goto(__x, __ptr, "w", "ir", label);		\
			break;							\
		case 4:								\
			__put_user_goto(__x, __ptr, "l", "ir", label);		\
			break;							\
		case 8:								\
			__put_user_goto_u64(__x, __ptr, label);			\
			break;							\
		default:							\
			__put_user_bad();					\
		}								\
		instrument_put_user(__x, __ptr, size);				\
	} while (0)


which already has an instrument_put_user, which expands to this:

	#define instrument_put_user(from, ptr, size)			\
	({								\
		kmsan_copy_to_user(ptr, &from, sizeof(from), 0);	\
	})

So this is already instrumented for KMSAN, to check no uninitialized
memory is accessed - but that's only useful if copying to user space.
__put_kernel_nofault is "abusing" the same helper to copy to the kernel,
so adding explicit instrumentation as proposed still makes sense.

Thanks,
-- Marco

