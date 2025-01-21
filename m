Return-Path: <bpf+bounces-49403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE9A18258
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDB5188B5E5
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F571F4E3F;
	Tue, 21 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eppt10vi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256F1F238D;
	Tue, 21 Jan 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478549; cv=none; b=BwGwdrm2s71jPSPtO4ZNWqlOwFOWwTzV/RMt3IB/dFVSdNTNrBfmV6hYnTF3rYIR/aOV9HxwDq3f9tZcOs+75TQkMoAujDR1iQRZQzGhw6p2PmrZTFvbzQNYrUH6C1nIRlnf02R/kvbfMBpENsjYHmPIoMVPv44KNd32HtE0mHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478549; c=relaxed/simple;
	bh=cnnGFNSfWAgwkSM7zsQdvaYzdzH4H7gunruggvNMjLc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWhQrE/na0sPh10JfKkT6W6lLF5P61KXnrPQlxxPWTIevlZF+/hBJ3C290IXizeZ1sR/llcQjuHNguoxplHQwlL6HMEqMqk+FQTzizO4zWRv/+BytQ28FkgJ0tTvTC41aVlfp7mxtUIpr8jgWlMQpHT9FjlWM+7Vu6Lr7z1mrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eppt10vi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so8549050a12.1;
        Tue, 21 Jan 2025 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737478546; x=1738083346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alO03S7T3KlWEJEtQ5hcElZTVFmck8Qc+hBURdBMDNo=;
        b=eppt10viHsZbNs9FYFy3jPm36AgITjuE7d+GVIxmVDWTUPPs8F7/mTnUVsXEG2IyF9
         pGShI3KniBJ0UzaEweyoLTTvN3lQuZJKe0a88Ki7+Df19sKooVdUL61XvkOYQHXzDl0v
         RmaSPRy+e67StertWSCN87rHrjcm9xvzgkY/uZT7/lp+t1c7dMVLpD1rg8/3Ws9KWkrX
         nZoS353ZxmoJdn9/SYmZgLn/6yXfz6EbFbNnEzLtDEpRao1Wq67Jy2Akkf28tbqH5E6A
         cO3ercz2hnDnQklGHd/b1wONalnkfI4FYjzxM8gf/1iuuF3Bo7dKHe3eKfA0AA+GJTrE
         pKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737478546; x=1738083346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alO03S7T3KlWEJEtQ5hcElZTVFmck8Qc+hBURdBMDNo=;
        b=R+cVszl4fC/UZpKCjv24k8wFpzqsLWtVxm9797J0WcrEIvRGWUNu2Qj7vYl4al9Vz6
         K0DKBk/USkGcqmrZrZ9pz/Tgb/kGy9/Bnm4LO4Rc5pTBXc1chaEhibZPZL/y5aijHJ7Y
         LO74/JVRtSuHyUapbicLu7aDwdnXigTPpBFs1WnKGw35ktF9sZc+t8HUvdtS7GB87k/a
         Qx7oKsbzZgt/95+IIJCxJ2XYfG8ujf/976ZJKcYvEY8lUaCJz4P9q1v0k6CO5MLR5fkg
         iEtiWghyYrCl+WVZxj3Q/14YVknj/tDFjTbIhreD5C6kl9oO3mVypHobEJYy4W5Lu2oZ
         fAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUqwKply6hGHgR/uZCU/7QdXeabI5Wzhts1xgDHsrVhD0WMf6x4gnClRt1M6us4fsoWbiekQw749yqc@vger.kernel.org, AJvYcCWSeseQ+KyxtfwdpfYgF/hmXeTXOmCJ3JEEDdlR0eRyDAZJ1tL32LlPIlCHSnMF/gzZ+hQ=@vger.kernel.org, AJvYcCWy7bXoMoS6vsM0j9QMJQGNEw2pB7x17KEMC6fmkdf9XwoiszcRztpjgeRbXSylqI9HimA6OartwbsuJjDmC8L84Gd0@vger.kernel.org, AJvYcCXYGmLz+3CbG4xG6icjIRVzZZZNHH+VgtiYXQIDHHEnclL7NEcht40Bck3W+9lJMFXopE9lsU3oVZtQUS/f@vger.kernel.org, AJvYcCXpkYLfqjFwBrEyxE84B14ICGqkPeblxGqVw8lWKwuqVykbNgzhtg7CCUa710I6DScpYL9gp98Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiUx/c8j8YkxvHSRbix0cvTxD4uQaREnj1MvpOGJnIs8LUaBH
	Ibm52tef0+XipBK2p4pK0kpCBLMI52/mjA8WeO51lHpySXcZknhM
X-Gm-Gg: ASbGncvJffDIv4S2vWlYVOLM62lUo9HUPDrUbrTiFOG2p8BX5ttpyAIHz3VO1FP8+oZ
	1HfxTno1TFRaOxEaBjPC/GME1A2n8nVYrKQ3nP8paMDq1O96jxCVgTWua1T6J9c5OofIgf6pnBB
	6c7FB6LLyQgx9xi+7lT6WclWZ7l32gjprHSR5E1ZTJX0wvrm6bKTS0yQflo67misnE5NgdG+/4w
	YJYzUuX7UYtM7NrjZUoNTnu1m1zVS8UGlvjBrlDxX9T8blyls+OzTd3xJu1rDokbQhY4b2Xhk+5
	EYFdCA==
X-Google-Smtp-Source: AGHT+IHs5dsq6f5lWy7xH6ZUMScER4G7haCOmBNmxLT2CwIbLU6QhwwGwmDdqb5dQ1YHEXvznKKjSA==
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr41318550a12.24.1737478545632;
        Tue, 21 Jan 2025 08:55:45 -0800 (PST)
Received: from krava (37-188-142-170.red.o2.cz. [37.188.142.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fccf9csm765655566b.168.2025.01.21.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 08:55:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Jan 2025 17:55:37 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
	Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z4_Riahgmj-bMR8s@krava>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava>
 <20250121111631.6e830edd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121111631.6e830edd@gandalf.local.home>

On Tue, Jan 21, 2025 at 11:16:31AM -0500, Steven Rostedt wrote:
> 
> [ Watching this with popcorn from the sidelines, but I'll chime in anyway ]
> 
> On Tue, 21 Jan 2025 15:38:48 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > I'm still trying to come up with some other solution but wanted
> > to exhaust all the options I could think of
> 
> I think this may have been mentioned, but is there a way that the kernel
> could know that this system call is being monitored by seccomp, and if so,
> just stick with the interrupt version? If not, enable the system call?

yes [1], the problem with that solution is that we install uretprobe
trampoline at function's uprobe entry probe, so we won't catch case
where seccomp is enabled in this probed function, like:

  foo
    uprobe -> install uretprobe trampoline
    ...
    seccomp(SECCOMP_MODE_STRICT..
    ...
    ret -> execute uretprobe trampoline with sys_uretprobe


I thought we could perhaps switch existing uretprobe trampoline to
int3 when we are in sys_seccomp, but another user thread might be
already executing the existing uretprobe trampoline, so I don't
think we can do that 

jirka


[1] https://lore.kernel.org/bpf/20250114123257.GD19816@redhat.com/

