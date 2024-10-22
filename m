Return-Path: <bpf+bounces-42803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0C9AB52B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09B11F216F8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B01B533C;
	Tue, 22 Oct 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnsqFD6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E341B5EA8;
	Tue, 22 Oct 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618431; cv=none; b=RiT70l2uRQoHwCuxV5LcpdlkIfjamHbCPGif7zcZR1yjd0cjEE87Ruugrfj7xooJ90NCvAJ2jRZhGLB1kFvJ7aNokCYdTPTrWsxibPNnGaT0abEpnQiaYG0e6sG6znfRIobUIbLUVgBzdagP0rt934msKzdpCzavs8TPSfb0p1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618431; c=relaxed/simple;
	bh=NwB4wZ4Th0Eo49n9H8wJFD6Cz8oQTVsVIRk34wSUBGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcNSbFDGNujjwSfP+L+CZYNMTEMJRRrfr1WxuE0lS/Rnas9+AexEWzPeorlLjgDdPmg+CHTA1VyJSQvQ8KFbvedSFAS9pFagAoy3fXsNBQr8c5ZHmw4FTagu2Fx+uhOcK0ds7XryVDcI3inJwWZ50NJWj/uIFdfbcaVi7rEtekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnsqFD6b; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so4198393b3a.0;
        Tue, 22 Oct 2024 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618429; x=1730223229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwB4wZ4Th0Eo49n9H8wJFD6Cz8oQTVsVIRk34wSUBGs=;
        b=CnsqFD6b70h4tDNYXbRCtcwQ6Ah1aLxNM1auPgZspmb26FlapCizw6fVpFN+cD9GQw
         w1Z4fWksKP8SS2hS0zXm7mdfDfqIZcxkTn6diHpLPAvSaJj4LrYgWwW1H8S4oPTOAIVH
         Sf+c1ZBg+xJU3UGe7VNagY5XGWux4GdtnaRKoxaOrRpQW+iP9vNyMn1+VOIHSj7zpQ13
         M5bGJd5d/Gl2gPA/xII8bSUnShqoGstkm7/bP7RsfXLRB4nmSzbz7LQgoXZXiakcWS/k
         DoIVB8auv+CsxPdQv3OSzfO9YBJDdb3vcSmoXBhINU7wL1sy/457xYMzFf9lyoqWXAe6
         vj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618429; x=1730223229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwB4wZ4Th0Eo49n9H8wJFD6Cz8oQTVsVIRk34wSUBGs=;
        b=Aw2Z7AwESpjf+LY1sZOUxcGRXcFjUpTDuKQ5PI7j1ms6pd6mo0K+ktVHSYHWa+tYRW
         9I+MgBxJwTOxrXr52o8SwnY0D6svk0jT+tofDlYgDoJFljyj2t7FplA7JwsFrSgzB9cJ
         kNOWT22EXhRzelf63nv9uEZSmMkFcu4oluIA1VlvVhUVc1CUOWQ1dcNuWHLKeP/wqNqk
         1i4cXSizQcmFLgcklTRVQnGo/1BJAmElpyITRfY92PVtRi2J8gibtO2z4MP4QJ7jvaLl
         4DlZomHHVf86q/zi9MIJFxoAAS3+CrxkUcvD3qHzzZNHQNYsCmYiM4P5Bk8yBDOVd21Z
         rVDA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhTkwe3Kv392TorZG0VTHlUbu56K8j8WHKaAfgsiSosRFqyVOY9VSRdGolNlrJd8XLWo=@vger.kernel.org, AJvYcCXbJ6iuMOHg/YIV0FLx8l23furyWDVB3+lhMaCdWHXP1sTorOcKAUGaSiKokW2M74KNX9ckwDPMWQfEduz3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoqv8DodDl4iuZ0go3P/P7lO0en/KFhfnZhCdBvkh31iyn8wQU
	ShG/Y6ZZP1VUbHhyELvcubO1bS/aWPl9mhA2VFQNwzdz3tPlYBVEnUg9XvbsbX3+uYaOne6pP4n
	gkWhZivnFfsDXIYOXVT8IH3H1Hg8=
X-Google-Smtp-Source: AGHT+IFr+IujPbD1BYPI1rmv4Td3aumUmqQNxdDPa+P8d6E1s+XcNlmes7Uhy4CeBHF+3+R1aLLGjCSUci4K6hgt2Dw=
X-Received: by 2002:a05:6a00:1716:b0:71e:374c:b9aa with SMTP id
 d2e1a72fcca58-7203090f8a2mr54985b3a.27.1729618428891; Tue, 22 Oct 2024
 10:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022111638.GC16066@noisy.programming.kicks-ass.net> <ZxewvPQX7bq40PK3@krava>
In-Reply-To: <ZxewvPQX7bq40PK3@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 10:33:37 -0700
Message-ID: <CAEf4Bzbp-LxpFR5Ue6YTfana5ST+sHMLi_zxS9Ax3uR7bXpuNA@mail.gmail.com>
Subject: Re: perf_event_detach_bpf_prog() broken?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, andrii@kernel.org, yhs@fb.com, 
	linux-kernel@vger.kernel.org, daniel@iogearbox.net, sean@mess.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf ML

On Tue, Oct 22, 2024 at 7:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Oct 22, 2024 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > Hi guys,
> >
> > Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
> > -ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can no=
w
> > return without doing bpf_prog_put() and leaving event->prog set.
> >
> > This is very 'unexpected' behaviour.
> >
> > I'm not sure what's sane from the BPF side of things here, but leaving
> > event->prog set is really rather unexpected.
> >
> > Help?
>
> IIUC the ENOENT should never happen in perf event context, so not

yep, if it does return an error it's a bug, right? So we can add
WARN_ONCE() or just drop the check, probably.

> sure why we have that check.. also does not seem to be used from
> lirc code, Sean?
>
> perf_event_detach_bpf_prog is called when the event is being freed
> so I think we should always put and clear the event->prog
>
> jirka

