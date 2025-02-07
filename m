Return-Path: <bpf+bounces-50765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E50A2C374
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46D93A9C48
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C91F4176;
	Fri,  7 Feb 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqqwfjp7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E141448E0;
	Fri,  7 Feb 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934647; cv=none; b=rduSChKQHH8jDn/AszP6xMxPJA1eCsmo5IIklp8qZ5AAxA200NzMIiFH9IOiA/UIRZvQ1R5JmTXJWrzOaa/4oeD1eyKLBqyY+aBqxKiFnd7a2HepA2CCBeVi7emxbvkBoGo9WhyUUCj/POi7GhH5i6hpozGdzaDl/w1TOBsKuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934647; c=relaxed/simple;
	bh=AzWxQ2Sg+iUWihcfYL10pylpUN7zV6ouv8rPPjCM7w4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vASlLIN/Ap9VXk39zqv9TCELEhn+a3sgYoE23+bkyClvnwr85lQue+xbldf/BSEqCCEhRTA5RzjEFq64A3RWU0M2ZwvRaVawcba1pieakbyedp6DHiSZDfA2o54QdJO6JVG5IMHI1yY5Fa8+rUxZN0HwY6wfMGtN25+b0/ulB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqqwfjp7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso14115585e9.1;
        Fri, 07 Feb 2025 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738934644; x=1739539444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+hbCjT6LBaffMENlqpR7e1aJbG1h/qpXNwBhV0ZXuXo=;
        b=Aqqwfjp7Ljvyy1WdeznO9EoT5fEbvwOiZ0qaVjjmhfKInaAMMg4UAmx4TJYYGG18sP
         F7BODArGAZwhofoWX9b5K8yG3rnbdWT1L2UOyb6GxhQ6lYey9z1q04HNEm/JdEGULl4I
         4+oLepMlleY90Dl0GwHdd4rTLL17u9bVGFROj1RbCak5AUIs7AsQARQCmT1PpxoHEOZc
         cv0t/Jzag6zxVkoq2bWUPE/BepcVxR9QUB+HdT+uYPySgH4zg5CGwv9CaU19euyDX73J
         HXKSBGtrtAdxPiubU6hFuz32kTw3i021ijZfgmtPaMgaMF90eY9QHjO7K5FPa9jdKXVM
         XNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738934644; x=1739539444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hbCjT6LBaffMENlqpR7e1aJbG1h/qpXNwBhV0ZXuXo=;
        b=UeVo+GlFITvV4f2DPmfy3Vl+C/qt2q7KdihkF9hyqbcOiujPtPErROh67xYT63cL1x
         od2EglHY7EocmVRmv2JYE1cChsBgSc6MlN5DRdSlMW2jBZHqJ6U/KaYCAe725Kpz0s7i
         wD7Gf2LIU8s51Lzg6B/DJv9RlgiuBMTo9zvPsFBGMEU9bsVii8Y0ccxsv+ivkUZVULNp
         CZgHxYIGRMMXAG6t2RsF5aYhQa5BivlUX2I8vXauxEEcTiA0RqQlDzmKhWIC8cmYicIE
         HSi//i6xYL18IheVOR8NoPJGZ19Qta8pxulHPOgghg1JzG0Ut3zlYFUW+Em+x6LlvEXQ
         s4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV9jxeW35pCQE3FsgSAg6gzY9j8B0BqnZ1S68rD5j7mANHNlP+c41IrpG6mspq4iFgGhCvkwuwcB6NB@vger.kernel.org, AJvYcCWbQo/oakZ1VZt5REZ3PtrZYdogmOdichhUqLmNAmhgBpa2LBCcXuY6UgRaHnYBrEMYsiFTeI4QKzkYIRn/xHRkHS8G@vger.kernel.org, AJvYcCX9IAVfoDHr+zPwsQPNjOoyQXAEnzoJdHEZNq2mCDG83j7xeo0KSyjKtI96I908/Jy0oQA=@vger.kernel.org, AJvYcCXjIUI8zyCV+aoGlDxF0H/9Gru7FEoOUTb2tO6RLqsKHdOW2gNz/+1whP1V3stWnLWrgqMn+wK7J2rfDJvN@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKhenRQ2kcg0CDM1MYtHwO92RBPbZyZZP3Er4vhjLOqjdAlol
	5RWUmvrsIK5EnI7vfG61syr587/MegJm9zw30hw3taGGUfeqOQnG
X-Gm-Gg: ASbGncsF68l2bWUOFT84i7+tM2iRzds/JlMHb1Ug1w6MRx7/mTSlwaNuZ1I8eg/MQee
	nYm2h137fk0BfT4GNq9zrbfNulz9/3OypfmcX1rgI1oi8TlnGQPZLpmihiAWOBmvQi0VJE8wpQP
	eDhIx3XFdjE2LLiIKO0xPHXFO9/j/VUi8zGvgKXPV0eOmrPVyGO1qPeYkxt24CrucO5wIoU9lD2
	ZcNBrxBDiyWaTOGsT/hty+qzyRGKYS7IfbJdKM/9wBNYAbGFxd34P2s5YyoC3bzrhd5/zEqU6rv
	q1L5hkVYGKzHlnwIQhoTyk3tZCZLV/k=
X-Google-Smtp-Source: AGHT+IE/dkWaHQatq8qE3MpEXoCi7s+Hw+dw0vHj5fIDgdHGWKUguMXN1STdGWAXkSC2GuA0xGcc+w==
X-Received: by 2002:a05:600c:1ca5:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-43924987b0cmr26104705e9.8.1738934643559;
        Fri, 07 Feb 2025 05:24:03 -0800 (PST)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf44f3sm92400715e9.29.2025.02.07.05.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:24:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 7 Feb 2025 14:24:00 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org,
	olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com,
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net,
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through
 seccomp
Message-ID: <Z6YJcPS3ujIx6AJP@krava>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <173887689139.3506371.3849387827240027734.b4-ty@kernel.org>
 <CAHsH6Gv7SLuy+v1hRzxH7sk-dVDRKA=iTyeabRBkoFuMGz7_YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gv7SLuy+v1hRzxH7sk-dVDRKA=iTyeabRBkoFuMGz7_YQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 05:06:29PM -0800, Eyal Birger wrote:
> On Thu, Feb 6, 2025 at 1:22 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Sun, 02 Feb 2025 08:29:19 -0800, Eyal Birger wrote:
> > > uretprobe(2) is an performance enhancement system call added to improve
> > > uretprobes on x86_64.
> > >
> > > Confinement environments such as Docker are not aware of this new system
> > > call and kill confined processes when uretprobes are attached to them.
> > >
> > > Since uretprobe is a "kernel implementation detail" system call which is
> > > not used by userspace application code directly, pass this system call
> > > through seccomp without forcing existing userspace confinement environments
> > > to be changed.
> > >
> > > [...]
> >
> > With the changes I mentioned in each patch, I've applied this to
> > for-next/seccomp, with the intention of getting them into v6.14-rc2.
> >
> > Thanks!
> 
> Thank you very much for your help.

great!

thanks,
jirka

