Return-Path: <bpf+bounces-31918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5A90508A
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB011F23B2E
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FD16EBEC;
	Wed, 12 Jun 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="SYxtjrje"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA736B17
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188718; cv=none; b=qAC9lj7O647ivElNAwdtlB2hiwx7KOMYY1fQx7ghC0knLfQpBt87tDMN+IiAkBYekhbaZSdng2Lni3RHmUeBVgw1Nn/5oo6rjsFg+uBKOfFOb8JF3tq815w5tN7y40maR8aOQaxSzjUsPif8110krv9jItnmIvJMAwSixUOIF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188718; c=relaxed/simple;
	bh=xfFjrR9Bt11We1NtKccQkD+L2BBdMot6qwz+0cqK44A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CK6pp2H6qjiGK290lkfwi6YOxAMiWlKoU0X3EAYz+EANsmbKKxnZYp9KOmgyUdoC9DA3YLlD7Zh43yo2UX9hvhDeoGPEFZT/cSShOBXD8ZtnAwgOv6s/a+wdOnXY/T/YdgNlFNZPuyEhRP2eHg6ZiaXy2RCv3IPVNQtLjZdMg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=SYxtjrje; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f177b78dcso422873566b.1
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1718188715; x=1718793515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfFjrR9Bt11We1NtKccQkD+L2BBdMot6qwz+0cqK44A=;
        b=SYxtjrjebmI9Af9WmHb9DyE6p4+EnMpSpXb3Gb1Feft6ZFCCBNxd6QoCrdyQ84LiXS
         LkUas0yPZOwzxwXPAJw6kVB/MkkhtQFTCC/aLvdy1tFpNazu0GW/ZLZ/zt/1twmM47PS
         Rt95rVZg8E5Spo4IZ2+zXfOO0+4frWNShps4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718188715; x=1718793515;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfFjrR9Bt11We1NtKccQkD+L2BBdMot6qwz+0cqK44A=;
        b=rJ0hokL2/82UKMMZ3oX4NlEyw5648TNlmkxO1NYji40FqSUJor87RA9U32BWIG+AJb
         Skg8mHzryi5JytCPVELQwSbenlFWOzKGq6NOwEqUIdibd2hNYWKqCnzMe5G0mPd8smxw
         7bC1KkktmzO1FvjSiAbMTfa0i4LPUDcInXdq9TaL2iJ7MW6RMXceWCCBH9XeINav7IFX
         SaAsYBP0YjnpT2ErxG9PNjNVKZlXjNz+P4Gd7TnVYREDVwcjF3LsGTilI5srdWePcrar
         ttNXIgstzNyQIMGlzS+hAs4pmzwR8dOAJyxRwo94exgZwGHg/0nZsTai/S46JcYxPva7
         VOMQ==
X-Gm-Message-State: AOJu0YwimkLfTsrFBrXN7kSMtoi7HZbc9/Ak4I0eXNlUvp4KGOs2BxUh
	D2tJ2SDGao4ubGDiEM2gDd+p2daWf3zfYBBQrdGQEhoeB5vY7XJCrg2j79qspGCeT/MfOmgcLyN
	YWu/dNWOJLQPswLXmpw93QQdVdl7w+3h/Niz9Eg==
X-Google-Smtp-Source: AGHT+IGFe5avf4ogGJe6t2a3ADOb0zwi3+elK46gtDE5nXMlkgF/p7z7/2HUkIPBIFubUJ3GVgPK5BdlSYQF0RjYA9s=
X-Received: by 2002:a17:906:794d:b0:a6f:23a:914e with SMTP id
 a640c23a62f3a-a6f47f9b2edmr95141766b.34.1718188715046; Wed, 12 Jun 2024
 03:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usama Saqib <usama.saqib@datadoghq.com>
Date: Wed, 12 Jun 2024 12:38:24 +0200
Message-ID: <CAOzX8ix3TVUOgNAWkXbK6RAqBCmazgeL=PE-fCV+KZ_HyfLW3Q@mail.gmail.com>
Subject: Why is recursion protection needed in bpf syscalls?
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org, 
	song@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Some map operations via syscalls on hash maps (and some others)
disable bpf programs from running on the same CPU with
bpf_disable_instrumentation. The provided reason for this is to
prevent deadlocks when a nested bpf program tries to access an already
held bucket lock. From my understanding, this can happen due to a
kprobe on a function called after the lock is acquired. However,
htab_lock_bucket already handles this case by returning EBUSY if such
a scenario were to happen. Is there any other reason for disabling bpf
programs on the CPU?
The effect of this is that 1) bpf programs attached to a kprobe or
tracepoint in an irq context get skipped while inside
bpf_[enable,disable]_instrumentation block but before the
preempt_disable via htab_lock_bucket, 2) when CONFIG_PREEMPTION=y and
preempt=full then a bpf program running from user context may also get
skipped while inside the bpf_[enable,disable]_instrumentation block.

Thanks,
Usama Saqib.

