Return-Path: <bpf+bounces-41293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB99957B9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B32828B82F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E21E0DCC;
	Tue,  8 Oct 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25DGD5nN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F2770E2
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416090; cv=none; b=UA8Qio4cCw+8e7iZELgUGIMBxqMgQ7yG/VkT0xXakz6gUYq4zhoESHYUw3w2oCOWSlSMn9e0eznyoZPy8om+nB1dJfYNlG9hLKF+NW31WqKoNUU1lnzBPKs0TrHdD8h7x6lNiIaytzJfEItwZm5ZizHoqAuxdFCaVcL7EEMU5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416090; c=relaxed/simple;
	bh=a1eBAKb+IiIssJhkKo3Muao/vVP76nI3R2s5zzwX6xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Am2yt7VX30vjrPV60wVCOUufDk69Bf59ONxpJzGC9SnjrmT3qyGwlH9C2FpPvdT/veZChdBQPKyaMMi/sMnvSBajrdsbXkTrMQQlpaXKvdsUlKSqs8Kk1KlX3Ybna/4qordvKoRRfYL5Ymj9wFZfA7iAqq9cnSHALp3PNcRe4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25DGD5nN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b0b2528d8so68563695ad.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 12:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728416088; x=1729020888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1eBAKb+IiIssJhkKo3Muao/vVP76nI3R2s5zzwX6xM=;
        b=25DGD5nNm2uhbx6+iDK6cV/vKlbkYPPWpH5HZtColYhajAg1d7rdEL33TxWuUbs67T
         6/pwl9Z7diXvoq/fls9F9mhDVkP4QMjYvRQHqSJGRUro73xKnuP//+EGwtOdzhVKBKit
         /kZbLzZJokPFecL7a4aSOIP2fOXaA11zu+VU1s9vOY50vUOHpTK/8f+vnqYkFjZ4byRg
         xsja9v/RPHej19QoqNXKEs0br+7lvNuMx9JcrR1vMAJ+9SOTrvpTA4ST2sMM/5Ei5gAs
         M0AiUgae65TjxgR3qDG9muBc71cBtBYOryQvSMBhFPwMK+M60vRa/OeyGRAXYVAktRvI
         /DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416088; x=1729020888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1eBAKb+IiIssJhkKo3Muao/vVP76nI3R2s5zzwX6xM=;
        b=k8XkuNZzqwGlId0GwewyQ1VWs3obbH6LAgAnJ+nm8QlnuJ9Gj/OeWzqlPU/w3zJTaR
         iEkc2CnKbqkK6+vQ1NM98kJOAHcw4+GgMkQk52PTM0Wttd625MESP0e5yUt9YjAyTx+W
         OOAPJ+lna/zotMYTzXfVBWTbd2DHwdudKIW1Ec2PtO07x+xpzEQeo9ahPurr313Z2+ID
         ux70x/Nvn4DLM83rV/6RwKPkY8RiHKoSuwmdhWIX9CUj5WhW5oOkJnxFis1SoqWA63hm
         fHGj6UK/hLj5Umo0aeoEBqXzVvtme2NABtl1v4+ffi98zQdl1oDpa49ArfQYltw3H0KW
         qWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQuf0l+D/qt7FDM5kuXxbr+Y3xD3azqJeF8P3h4HGfAs5Iveytdo7+m2xF/Z71Os3emTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyud0pDpKSVre2LaVsvyhuiNhxBftsfIumBixTeSTbzGIGbn7XV
	HhlviMdGTxgqZleUcBbHWQnxw+/dcbNT5jcdbgPk58JK+2pZ/BiPRm9Yi5LbB4I97TGPcnFUCIQ
	8DHjSRtG2uTB6qpeY8fW6jBXjUyfAes/ZKIl9
X-Google-Smtp-Source: AGHT+IHYkc33I6J5rJ3ZrK3WsR4R/63QF58VfSy7YbQLLmAS3xIFpM5nkuhj8nCvgdfxMN2NVwszrk1J6M+tUzweF3k=
X-Received: by 2002:a17:902:e5c1:b0:207:7eaa:d6bb with SMTP id
 d9443c01a7336-20c6374711fmr1457145ad.29.1728416088034; Tue, 08 Oct 2024
 12:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
 <20241008192910.2823726-1-snovitoll@gmail.com>
In-Reply-To: <20241008192910.2823726-1-snovitoll@gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 8 Oct 2024 21:34:10 +0200
Message-ID: <CANpmjNO9js1Ncb9b=wQQCJi4K8XZEDf_Z9E29yw2LmXkOdH0Xw@mail.gmail.com>
Subject: Re: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 21:28, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
>
> Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kernel
> memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> the memory corruption.
>
> syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> KASAN report via kasan_check_range() which is not the expected behaviour
> as copy_from_kernel_nofault() is meant to be a non-faulting helper.
>
> Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
> kernel memory. In copy_to_kernel_nofault() we can retain
> instrument_write() explicitly for the memory corruption instrumentation.
>
> copy_to_kernel_nofault() is tested on x86_64 and arm64 with
> CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
> kunit test currently fails. Need more clarification on it
> - currently, disabled in kunit test.
>
> Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
> Reviewed-by: Marco Elver <elver@google.com>
> Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> v2:
> - squashed previous submitted in -mm tree 2 patches based on Linus tree
> v3:
> - moved checks to *_nofault_loop macros per Marco's comments
> - edited the commit message
> v4:
> - replaced Suggested-By with Reviewed-By: Marco Elver

For future reference: No need to send v+1 just for this tag. Usually
maintainers pick up tags from the last round without the original
author having to send out a v+1 with the tags. Of course, if you make
other corrections and need to send a v+1, then it is appropriate to
collect tags where those tags would remain valid (such as on unchanged
patches part of the series, or for simpler corrections).

