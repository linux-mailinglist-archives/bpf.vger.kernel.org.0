Return-Path: <bpf+bounces-21724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E8850F07
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7674E2819B4
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA1F51F;
	Mon, 12 Feb 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGp3r5XS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D893F50D
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727456; cv=none; b=BmLIC60b9l92aeE8Ogc0jdIK/L8uM4EEKo5Av6/etOqaAqAgnLw8c7/3LdFXWztVWAgGd9p5HF/OxJMRPAPGwpI+5jpUgcnz5VlDI6tZUAZyEmR8n/dfCT5i6hCE/Yw68KdIBvRZjxegW5J7f67VP5g6Fv1GoeF1/RZAFW+h9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727456; c=relaxed/simple;
	bh=ATjwEUhmBxDq/KCkU6frfxMDP1x522q4neZaYt1HQWA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDCwselqReiyDlwaUhDln+8tQb1RVTWWf1tdI3KpFBGZ/mKnBBpSoHnYdSKDPoDTAZ9XrYL8aa52PNhDVvdWclO+aifmZEbLGwIPXuLzSMvOeCUprTzqb3kDsUmFNbumvDH0hwccQSTFXVXu3zP18wSqaZeEbpzHOo672QaAlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGp3r5XS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410ec928b83so1344215e9.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 00:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707727453; x=1708332253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/7MVtgjnhy5jN+N9y1+ro6J0YP7MUdBH0qcdZQKPE=;
        b=eGp3r5XSKuZ3/A1VpVgXkAy3itzhSeHUfDpain6x1iRQ6SfQNblqpzLVJJdo8nfnBq
         yGI15iUMalYNVWIWdtfNY7Tn4IsXmL1mxnpHKqUPGKDkLqzeW7BE168WI6oYKDdk3mAf
         KOwZ3su8v/p4GJ0A65sPbQ4ttA6IZsQ7PsYQitadu6aiaTqMjJY3dZSIMTXixl/+/Eax
         xVyeG5fDahDMN0OkXjLi3b87p7PceB+lxy+ZcAiGL8HWd+C9UDv2E5ckxGWKXoYDNe9p
         SbU7+zvmGgA9uDljb2um3kxL7gYe2M/2c0C469F+R+jNOY2lCcbmrVf1PTCosK6Y8NSS
         nqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727453; x=1708332253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK/7MVtgjnhy5jN+N9y1+ro6J0YP7MUdBH0qcdZQKPE=;
        b=mccdNV3dgoFSBO6MH4pZyDG7i32Se+3XIDpcV3ietQLMNBebUQoPauaPf+qrF6fjvW
         HwKt4nRQ/pE3Cl24EEsFFhFn5PNldhsEUL2mMl1ko3e/6tCeLaZQiGYn6Qcm0VLVtAax
         yZsGRn0yY8Gkr5qjUfJTScH8cm/2wcwj4Qfhb0hx+wgj6AWBigGyTr5lPywRXyNhTKOF
         +j1tzQ4JcuhEVKcS++PWtwrvzafRrf+DCLP4GMdb7YAbMXPaIs0KbS7b2gf7s8Y7oviW
         vwhAaY5sIWylhqawItqXb7yu/qNtONyuP8UhNuWFELRTiZyMZ1mYcrsxnSRNf6Gh3Gwi
         n+iw==
X-Gm-Message-State: AOJu0Yxgmy820XNl47fXYntxDtANuUqfM6lA8Hxtu64XPqZC4Vly8/3y
	4bTha1SwiMxIV5DRpZ+Ut5J/ZHh7k9NnRXaaQV3QwUeqxurIEF/p
X-Google-Smtp-Source: AGHT+IHcgWyTIRk2/s69vNuoTEzWZ7SFLhl0GNuRLIzRhxaYQASimFCJsRDo/BgmOO4HZWOvB9e+aQ==
X-Received: by 2002:a05:600c:3555:b0:410:61ce:f5c3 with SMTP id i21-20020a05600c355500b0041061cef5c3mr4944459wmq.19.1707727453055;
        Mon, 12 Feb 2024 00:44:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNzEsaHWl853SGIKgGisI7Lu5+D0WtUkTKgMogbKNkxzYqbjtC9qXdjgDrJQHzd8wX4J3TZ09EDmFB4ljXKLNpcH1/aG7W5GENEJD6ojRgdS2Nt/vdrlQpQFmmsXJn4Fq6+1eToKyJxbw9yovaf8tFnKGE4LXvPJb6eqaln3mEzsTsJyNy18e9WSsnhi64MUSBRGWj465JE5aZcgg=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q18-20020a7bce92000000b00410c04e5455sm3365842wmj.20.2024.02.12.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:44:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Feb 2024 09:44:11 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>,
	Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
	Kexec-ml <kexec@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZcnaW5hB8y3da3bI@krava>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com>
 <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>

On Sat, Feb 10, 2024 at 12:51:21PM +0800, Baoquan He wrote:
> On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> > On 02/09, Hari Bathini wrote:
> > > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > > to the below warning:
> > > 
> > >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > > 
> > > Fix it by using the appropriate #ifdef.
> > 
> > Same question here: how did you find this particular kconfig option
> > (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> > in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> > existing ifdef seems correct?
> 
> This patch is based on the latest next tree, I have made some changes to
> split the crash code from kexec_core.c. If you check next/master branch,
> crash_kexec is not in kernel/keec_core.c any more.

makes sense, it should have fixes tag:

Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

