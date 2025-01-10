Return-Path: <bpf+bounces-48559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C677AA092F9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C0A188D733
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EE20FAA5;
	Fri, 10 Jan 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HJjCHl03"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB20E701
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518126; cv=none; b=FzqG/BsXE1wGIVKh/BTIttnUyIwz3vcXsjUwzEjGF+WGEted7WER8Tlr0wde9ee4eDs23okq/rhKldCx5yLNKGy5b+Uzj01wWAIrzSd7L0kgY7wl1Po+GMrRyBj2a14DnDsu1Csnc9OUtu/FDbV0nhoaFJyciAu5QZapkJLAtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518126; c=relaxed/simple;
	bh=/4fpWhioTGSiSnlYkbyWirFUQqaK8UeMZl+KaNGFz8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MA+crdPmqDqE0MQYf4fi0Cx9Ja1TYZJpLqC40aUpVNp6H4xrd0gBH0M73bUQVufooiFP9CWE63a64cLMIA6B21Z571L5EjP4P03Uc3RSvHIxzJvo0LnRXiC7S9zcymu4Svf3T+wRtbovXYevKtvS5kgWey/5zlu24j5tGAYrsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HJjCHl03; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so386317266b.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736518123; x=1737122923; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4fpWhioTGSiSnlYkbyWirFUQqaK8UeMZl+KaNGFz8s=;
        b=HJjCHl03toVX55zgeoN/fRXYY5HSqIwAiSMc4CGx4y1BvvaR1CGeQrUZE1cwlLwOcW
         /xp8LyZsxuqlxs4ziPiWQ+bjYcuRhuSfF8Yuw5PZ165jpAGhRQujoeWYBXZ13UITk6zq
         4nE4S2cR5YABPUgpNyySoewOjIh0K/tkNI+U0gNKbLpBdTk++rLGpFNRZyjo1JTmBn/6
         VClCj4g6OIqSQmhv5D20lCaEPiF3ttOQKMwfXTGIoYgZS0YQiug65Hgcn37MbbRp3BVU
         vzqoyV/qB5b7IZovMbQ5zYv5TNz8d50tKGGhVEmIEWfRaBnG6PNgKVu2m9cNBbNZaLxs
         WyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518123; x=1737122923;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4fpWhioTGSiSnlYkbyWirFUQqaK8UeMZl+KaNGFz8s=;
        b=JRNaagHVW4P59w63gzhc3jMlNW/KZUHrM39Nn2adUxZ9bycGlIUKlaZsNoC31vulby
         /cyPM0sdHC4OhF7lJSaXlwTZgQtKQl0oxjw5RzGEgiI9HyrL3bjMNuC1E0wPEUCwL7oG
         UfLBot2jbm78U9bxroH6Bd3T4eQL1+weHNyAoCpnaTnJalQKvlzj1XQQIg1c22CMew9R
         udVkrnXItk6MlXTHJ/2ZX+nAm1DBbd9bRqfMf3ysZ/kQws/tdgfOV24FItPncEzcZnuP
         7xHq0kTwY4l/qesNgq/g/H25Y40SXI5WzY0223QA4wy3aUZ45rSHCcQneaYgE3kC9jeB
         +lRg==
X-Forwarded-Encrypted: i=1; AJvYcCUYu13t7sUI8dgjxxz6EY5ahbT7o/sT3y+nfd+QnwFqsPT/cJgDCNAJH/vHcc0LiE+JT3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPdcuCnDeu7Z4g9wVfA2js2450jzHPeSNXyVqqyZAZp94h2QR
	5uS172rb+R5VC+1lNrKtkUSdHFj+qvQ6BAu/MH9J/4WTpsyhyqb/FPItZJ+uoNU=
X-Gm-Gg: ASbGncvxutP6tUT670wK5gaogFecnY5uvqHV9pinfxBWpiyPWlxUy+T9u/fi1IwmUYy
	T+w5fKQ0cMtrMf5Y0CbcvoIQZ2SBu9N5TLeRjb3u3UnqlAfT+7Qr7jWiKWGdpwQbSjPXCDVe0E+
	cOScdn+g009umCDv7XJqjlqOsIAEjlqetpTj9afeSc2+q8Di+lpipopHaT8r0r3dZhy+3fd9Wdc
	hJLMB+fwdoRIaD2nFde/Ys6FdgVmbmf0NXMNZfsr/Wh4xw=
X-Google-Smtp-Source: AGHT+IGIQYbUpXh7cueBL8u+LVHU7VjsngWLddnMaRJAFI6CPxHz1t8vrgnBNnJ5i/Or1JHaRylyLg==
X-Received: by 2002:a17:907:7f1e:b0:aa6:7091:1e91 with SMTP id a640c23a62f3a-ab2ab66cf8cmr1002495766b.11.1736518123406;
        Fri, 10 Jan 2025 06:08:43 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm169414366b.20.2025.01.10.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:08:42 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ruan Bonan <bonan.ruan@u.nus.edu>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
In-Reply-To: <877c9z9e3x.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Wed, 23 Oct 2024 14:51:30 +0200")
References: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
	<877c9z9e3x.fsf@cloudflare.com>
Date: Fri, 10 Jan 2025 15:08:41 +0100
Message-ID: <87ldvi3gnq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 23, 2024 at 02:51 PM +02, Jakub Sitnicki wrote:
> On Tue, Oct 22, 2024 at 02:36 AM GMT, Ruan Bonan wrote:
>> I used Syzkaller and found that there is KASAN: null-ptr-deref (general protection fault in
>> sock_map_link_update_prog) in net/core/sock_map.c in v6.12.0-rc2, which also causes a KASAN:
>> slab-use-after-free at the same time. It looks like a concurrency bug in the
>> BPF related subsystems. The
>> reproducer is available, and I have reproduced this bug with it
>> manually. Currently I can only reproduce this
>> bug with root privilege.
>>
>> The detailed reports, config file, and reproducer program are attached in this
>> e-mail. If you need further
>> details, please let me know.
>
> Thanks for the report. I was also able to reproduce the KASAN splat with
> the attached repro locally and will investigate futher.

For the record, Cong fixed this bug in commit 740be3b9a6d7 ("sock_map:
fix a NULL pointer dereference in sock_map_link_update_prog()") [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=740be3b9a6d73336f8c7d540842d0831dc7a808b

