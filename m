Return-Path: <bpf+bounces-38944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068696CBFB
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 03:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534D51C245F7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D94C92;
	Thu,  5 Sep 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfEJRziw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315AD33E8;
	Thu,  5 Sep 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498173; cv=none; b=JB5enMGEL2wAtGpgjN31cVEwJm9KXEiauMYYPcPzlhxvBrLnEIR4Q4cJabssp4LP3DHQ96b7+Kf8gL7Ypf+Dz7B+DegjeH0lugBQDuypRurfdAqqg6HBCaa12XtqK4ID+b6ZQjyYXeXics+5mnufoqeEsuvX9xJ68Bfy/GhMlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498173; c=relaxed/simple;
	bh=KRuEWrieCLaH3fc1klZ3mm3e10og1WxJxlkUFPX+zQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L52gvevyrQGWhTtJ5/XXdzAvq4lR017k4CDZ0AlSzFJrXwoG0i/rpbEoCQbvjeqc7qu9HvCXjuS35iXIV0rDPw/2IxdqfuCDSbZwn5vig2bL96oGo7E5ItgSQQ/g2WbSvvfhmUsj4fkFOl0UdWNvVl1AMU0Q84nVL2m6j2o7RmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfEJRziw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd835872ceso222255a12.3;
        Wed, 04 Sep 2024 18:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725498171; x=1726102971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23NcoCKYtkqIlXp9mfOS0sc2slR4Z5aABkGecue8W6Q=;
        b=EfEJRziw+X/hY4gQ+TYTjJA7llrRh3whqRFW7iJ23nmAPR2PNZQC6MBzR7kgcMZm3M
         twlCWtzyp/HlgRnuBxChYq0qFEB40CWwb4hMH815BDVa5iYNaeEDKmnWDvgwJ/hhjqU5
         YIVLgic3TW4ws3WWv5V9xXwSj/E8HgTq/K+ZqG+97D2FafxEbKX/yaPaKyBDUymAG1q3
         2FTYxXmPaxWPqpEToMQoCwNXfV/vqJrr2qLw61BuFKcPPfx+/vc98V0nkKbEA3ji+36e
         3WK/Tdv8tW8DegCxwTyUtgLcTy4XiSxvTiBi5C6rZxe0/KJDuyl3h44IJuRRKcpELvgf
         +3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725498171; x=1726102971;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23NcoCKYtkqIlXp9mfOS0sc2slR4Z5aABkGecue8W6Q=;
        b=Zo0cVEOwNBfisw8b6ufDZMZ4OZAvtMNyg0MSUTkzSm11mRJ5MjMUb59WD1VMCCLyq7
         Z30U3OU5+GcaLvPyWvFRf1Dt3+IzBNP6C9zPX7HGZ7h2HyNxuLGzJsC34RWehf+Nq8Q7
         W9u6B0gLgYl0KtRiRiAnEYbspAHhk0aq4RQRA18WgstK6FsraPpK2XL0x3/+Pmp/K/Xu
         21KpeM8w6WA+tbw5uOw+yWSsm9UZpyYkPqoEq3VHpgh0LdWSNEyExtPg6TsH+94uyXkZ
         lhIFtmn3TSYB/DCgj44xXaDl8kYW6jwjvnN2MqVNRH0xfjYnLRoI76FsXOFQGrvyU4RE
         z9eg==
X-Forwarded-Encrypted: i=1; AJvYcCUWg8bmKbpnPuHt+I8z/wOgYLr4/tRyQR78lsvFXGxMKZ4Pcx5Yn+bipjp/uA+FBZwcGScrMGVle2Al1yuqxZO8yzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEZCdeXL2NDsLfn/ZZtgAjyoharpIZ508FE5Halb+8AjGymrH
	pVoQgO1hTnhutMkm3pE7Vyy/RjIwrxSLGNvXTPdafNzZzC6KfgD7ndOuWv/fROhaH3UcBYBXGyR
	T/kUpYWtbFxmaP2qrZLHDWb+UD5nl1yDz
X-Google-Smtp-Source: AGHT+IECdd3v01pDQPTlrTVTuKyGWqSfAbKvD5Frb/r2LumdwXB/3IJfSwMsHyrmIYf766sy2B/2PMjokTDclxVcRnI=
X-Received: by 2002:a17:90a:130a:b0:2d3:b438:725f with SMTP id
 98e67ed59e1d1-2d893a9dc2amr15454354a91.24.1725498171308; Wed, 04 Sep 2024
 18:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 18:02:39 -0700
Message-ID: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
Subject: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Florent Revest <revest@chromium.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hey,

I just recently realized that we are still missing multi-kprobe
support for ARM64, which depends on CONFIG_FPROBE. And CONFIG_FPROBE
seems to require CONFIG_HAVE_RETHOOK, which, it turns out, is not
implemented for ARM64.

It took me a while to realize what's going on, as I roughly remembered
(and confirmed through lore search) that Masami's original rethook
patches had arm64-specific bits. Long story short:

0f8f8030038a Revert "arm64: rethook: Add arm64 rethook implementation"
83acdce68949 arm64: rethook: Add arm64 rethook implementation

The patch was landed and then reverted. I found some discussion online
and it seems like the plan was to land arch-specific bits shortly
after bpf-next PR.

But it seems like that never happened. Why?

I see s390x, RISC-V, loongarch (I'm not even mentioning x86-64) all
have CONFIG_HAVE_RETHOOK, even powerpc is getting one (see [0]), it
seems. How come ARM64 is the one left out?

Can anyone please provide some context? And if that's just an
oversight, can we prioritize landing this for ARM64 ASAP?

  [0] https://lore.kernel.org/bpf/20240830113131.7597-1-adubey@linux.ibm.com/


-- Andrii

