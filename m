Return-Path: <bpf+bounces-14070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F27DFFDA
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 09:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EF1B211DE
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFB8839;
	Fri,  3 Nov 2023 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulzz937M"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACB8BE3
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 08:57:18 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80516D46
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 01:57:16 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so628055241.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699001835; x=1699606635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=az50WCtOz816X4yqlAm9CRG15mqp81zVvXjqRF65e0Y=;
        b=Ulzz937MBtt8u5GuSPJ0HVy4kEbObkBN6adH1AR9WSb7oKZTryqwYlmUlc0i0wJYuV
         0PFyVMshyC2QcFUTZT4h/0ekKVtgqt4vEzI452VOJPMmvPXXPTo/AYl7q8fosM/Staua
         cac1gBcy0dXuCjIQhqMVPWeZFUptaE5e4KLQkm+KTFv7Q0bbfckxXxZk2FD/69Oz/wHq
         Pt+S4IlPAIxHA9NjH6XaxdpkslTMlAYO+J1MRe4elww3aH7SFhBObnx7q+tLKTtBjG7H
         iK95jn5M3jttRV2U4CaExO2fAh7Yd+2SrEIq59ntGZb2LUQHB2xtslSigsgft/TbnpPX
         dqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001835; x=1699606635;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=az50WCtOz816X4yqlAm9CRG15mqp81zVvXjqRF65e0Y=;
        b=k7mi9YxFYXkXmN2GyYzViOYGxhiWwhFRrxoahdNzq5ZLWWYh//WZgyWO3SOdNewyHx
         1khQgbbO2aAOMtG8X478+jXMp3FSxOldv3aEYCeOOaxDrggFGFpfVP2zAc9KWh812wnb
         IMc1GclJ6Uinc8pDXrAxeYQuQAmRtkM+G8L1hQzIjDpZwyuhSmIO2UUEaSS5IqZiwx8f
         9fdQpxb8noD/F2bwJpXwtu2Oq/cLri5VDDq+kcEKavvEvdYOK6oeH+bA0AgLatBh0yzk
         9+ZZSCP+clhB0uP6Kn3A8T/OEj3AGHt3FKx9fwdlA4zRLE6cZ6IQCdjS0Vy48ND7xNCE
         wNAQ==
X-Gm-Message-State: AOJu0YwS1B/qwBYfaWQ+qyz/YSy6EVs1oMWfea3pCXDDl4yYt2f5BqFn
	tltQZ/R8cWOzkf1BHIiDYQb1m3VItN7li0k4Dozd2uGt5xSrUw==
X-Google-Smtp-Source: AGHT+IFOj226tzvtJr9DA0VMO4UXoIvm/9ARyF8HKvt+iR67HYec23ajm8diiDhz9nnKmj6r4Vx+dNycO9plTVTr4kk=
X-Received: by 2002:a67:b24a:0:b0:45a:9bd5:b38a with SMTP id
 s10-20020a67b24a000000b0045a9bd5b38amr15153362vsh.19.1699001835514; Fri, 03
 Nov 2023 01:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABfcHotwAEFraonQVhra82kzDK_3sFRqjQRg-WeVyzKkZHmJ5w@mail.gmail.com>
 <CAEf4Bzab7_N4s_+gJr9u_k+gU8XKkfmcnO7vGTGO4wD_kUZ+yA@mail.gmail.com>
In-Reply-To: <CAEf4Bzab7_N4s_+gJr9u_k+gU8XKkfmcnO7vGTGO4wD_kUZ+yA@mail.gmail.com>
Reply-To: sunilhasbe@gmail.com
From: sunil hasbe <sunilhasbe@gmail.com>
Date: Fri, 3 Nov 2023 14:27:04 +0530
Message-ID: <CABfcHou1zjOCQ_RtWDiUcpGaX8ABfXwk=1PVS1MZoznPRTKRvQ@mail.gmail.com>
Subject: Re: Need help in bpf exec hook for execsnoop command
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Check what error bpf_probe_read_user() returns. If it's -EFAULT, then
> it's probably the case that user memory is not physically present in
> memory and needs to be paged in, which is not allowed for
> non-sleepable BPF programs. So you'd need to make use of
> bpf_copy_from_user() and use sleepable BPF programs.

Hi Andrii,

We have tried using bpf_probe_read_user and it does not seem to be
returning any error, instead it returns 0. We are using a
non-sleepable bpf program.
This looks like a very special case where it is unable to fetch a few
arguments. This is the same
behaviour in opensnoop as well. We have tested the test on the 6.2
kernel as well and seeing the
same behaviour.

Do you suggest any alternative method to capture arguments in the ebpf
hooks? Or should we file
a bug in the kernel ebpf subsystem?

