Return-Path: <bpf+bounces-47416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D789F93CC
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D02916DE42
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE3217F2A;
	Fri, 20 Dec 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNha7EdX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDD215F52
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702992; cv=none; b=GgzalMBJVPgs2sjNWAC4bSxjrBWSNby402IAECoUhlOlE03cv8G71/hI1yEmz3BDU5yHDoq9C8TIt45ceLu4heTv2rBpW7FlY6jliwABCIrd8PaVYAXbAb7CQECKugbqSVm4pzku6LJTv58/ZygqoK6ySXjD0xvGjaJV/hRRlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702992; c=relaxed/simple;
	bh=WRtUJL7n1y6XgM/oH1ePGcT6/AwZsClY1I0EFTTZCx0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gmCaDObHTGL35Jo62UlVsSzdw4KwVrDXbvnJKd6oe4XFK9VLCVSburqKcwsfgcVGkCR1VkJtZht0UYvZvSjhTild8nFjAtEtnHW0fZdzh5Y43W+RRXO9PA9f/Q16MJj8l1bNe2VMhqYlYpHmTeo7aQA93Iem4Vu3W/F+9xaLt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNha7EdX; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6ef7c9e9592so21688297b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702989; x=1735307789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9P9/FOGdi/0ZLxDrN+xg8brCDfd2aQllcnBsJr2njO8=;
        b=kNha7EdXkc6o2dvPw9x+Taf3IDL3IJEy6Au0Q2tkIp/rx7Ojyd45SkyEK6xBq63yJV
         uUM3mtIm3YIWLz1KAKyLPwC+eCC3ljgZ9N39CYtibegAouGGw9PgTIBULrwhVgM6Owc/
         voC1edR7LQY6aFzNc8mM+TWo+5mZdI5Enfg1hSCNLrPSK9gl6GbsvNKOLSQtZf/xzzhN
         oUXoukQ9IZ/oAT4YPWWdrU8y/pVUGc0KohP4SKZyhgB+AsS80AkbBc+BP9T6Q8rrOePX
         jGaPxZCZb/U90HoGfaJiWhQbXYrS737LTt2NQy011mWeO6pdsKPQ2XFf+BD5zIRelZlK
         RPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702989; x=1735307789;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P9/FOGdi/0ZLxDrN+xg8brCDfd2aQllcnBsJr2njO8=;
        b=IALAl7LSNEmi4GuWKkK6Wc/WgKwCY9iNKBF9Hbvsk7oWXrg9YcsBFCH1LqASo6kM51
         HDqiKbWiUQeHbL5dmJlwquEJJTy3Qwo/TgbZF7doRnra8SkghvE3LD/PfUHNhA3/Hjpp
         c0i6zTMCQCUN2Nwm6mGgCGXyZzz0pVoEgMpfujZa9V1N5LS+oE4+KORDxe0/Rpo8XEe3
         aRXFWGJjYhJJwHuWeCdfbmRCZD/xVMqQS7TLuj6HBMJM0tsBQVeymSDWxQhpR21Y1Ilr
         +AmEWD4CCMEtx5IwwF+MlH/sqCbZcocbeAJ+FNYVdipvvDqHltaCXyHugv/PJBbk1O5b
         Tgow==
X-Gm-Message-State: AOJu0Yy5uNKqE/UpuZf+Z4+ETkavHvYKe6HN0RsX0Owjqdny/YRsO7DJ
	F043UszxATYTHAWpH8Yg4LogGLLDzXImwZxe1KnpXTuE0SlcAtRHZWYjQnM6PID0NhsVoycGoJQ
	FgGE6QQu/uJ45T4txHshjL+cyqLKB15spGQn7jA==
X-Gm-Gg: ASbGncsaw8ZWutG1f0cMG/InKdHz8zxWQG2Yk1k9P3P74b2xD19oHYaOJLLF9lPOw6O
	SR/WiF8DRD7NS9KDVKMEfAm6EM5hUvk3GToX9Fg==
X-Google-Smtp-Source: AGHT+IGDiC1dfuTkGsn/eONHZ08G/kY/814WyYwr3Z9R8xQnBjh+Sp16OAfsF2Sth9Jv45WOAExL39ODsO7bGH1tZro=
X-Received: by 2002:a05:690c:4c12:b0:6ef:c24e:5f5 with SMTP id
 00721157ae682-6f3f80d624amr26246347b3.2.1734702989618; Fri, 20 Dec 2024
 05:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 20 Dec 2024 21:57:22 +0800
Message-ID: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
Subject: Idea for "function meta"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello, all.

In the previous discussion, I'm trying to reserve some space (such as 16-bytes)
before function to store the information about the function:

https://lore.kernel.org/bpf/CADxym3ZfHv_VdgopE5TBQxhO7RrPTVm83VW07c8bAywp404QPw@mail.gmail.com/T/#u

And let me describe it here again. For example, we have a function
"do_test", the layout is just like this:

-------------> 16-bytes
-------------> do_test
-------------> __fentry__(nop)

Then, we can alloc a memory, store some information that we
need, and store the pointer of this memory to "do_test - 8".
And then, we can get the function information with "ip - 8" in
bpf trampoline or ftrace handler.

After I dig into the code, I find that this space is already reserved
with the config:

CONFIG_MITIGATION_CALL_DEPTH_TRACKING
  CONFIG_CALL_THUNKS
    CALL_PADDING

And the reserved space before the function is 16 bytes. According
to my tests, 9 bytes is used by the call depth tracking if the CPU
support it, and the insn is just like this:

__pfx_do_test:
nop nop nop nop nop nop nop (7 bytes)
sarq (9 bytes)
do_test:
xxx

And all the calls to do_test will be redirected to __pfx_do_test + 7.
I think that there are still 7 bytes for me to use, which is enough.
In fact, 4 bytes is enough for me, as we can allocate a function
meta array, and store the index to the reserved space.

However, the other 5-bytes will be consumed if CFI_CLANG is
enabled, and the space is not enough anymore in this case, and
the insn will be like this:

__cfi_do_test:
mov (5byte)
nop nop (2 bytes)
sarq (9 bytes)
do_test:
xxx

A method that I think is that we can use such "function meta"
feature only if the call depth tracking or the CFI is not enabled.
(I'm not sure if the CFI is a commonly used feature.)

I would appreciate some advice :/

Thanks!
Menglong Dong

