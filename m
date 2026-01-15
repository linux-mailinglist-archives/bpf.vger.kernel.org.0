Return-Path: <bpf+bounces-79124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC4D27E37
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB81D30E3D57
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC93C1FF2;
	Thu, 15 Jan 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNI8ZNMc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11663C1FF6
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502777; cv=none; b=pB6H/e1ckiH+redxI1IesdwemYPzLxRH1zwZkV9GGC37qCc43p5FkcF/9CtmVQKtf0iv/tMek62X5MxnF8cl0imJHAU2N3jNR1omXSZAfjRX7H9i2fWKHU/JbkoEw4Z/XaH1o1QXenz3qWWKyLAkLIm5O67AQzKfqIR3PiRsbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502777; c=relaxed/simple;
	bh=yoL58zai68CZSyJdiYhMj7CCFJXXuq+Jj3HM8quNLlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC8HZVjc8Sr4Oc5JJ2ZDqGl3bdekA52C3OslHYHdh8E8Cb78jdcJXgyAt2e2aE0Tm0mRu1R2KLDXgfRxDXzMRuXUEfccuMJX/lRrhVM7f5j3CrKBONU4KRCLMKibDBp+4DtS39jxqpmbbaYzbequNU5pgCX3zp1KwJ65w0NHV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNI8ZNMc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so10691705e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502769; x=1769107569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfZUcI2wWecmILQbjLZTDNlnWfzX7KEX8mqfKcqDtxY=;
        b=HNI8ZNMcHLai94uyRYeK2MYeWXpl46PRBviSx/deIYDOl+C0ddtH7+O+cCGsFgelNA
         hR0EzYHvtUW1gkNtu6DZd5IWe9C+zx2gXiHjgTuUgrbbjN4NOlreda2OAEVDyRj/7h4a
         Rf6OWg2SAnwKK62i/0Z5STdRWisvu12NHJVxk+YKXoJQajbW/RqdsomLRzNOMyHJIbQC
         BK6Cwfb+1RDeIMyYOxtFODqn1x2DrHXWvYBsaoBdLbbq+Y834ckCWlwH1zM5rsIvIWft
         yB9EKy3PZrQJW/WbrgDwWg27N/+CH0TZ3OZbPwnyOmtIwHGyIRDc81DDP+wu7VEvRaBF
         uG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502769; x=1769107569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfZUcI2wWecmILQbjLZTDNlnWfzX7KEX8mqfKcqDtxY=;
        b=uA7eZ+AJUu6Z/StHXyljpPtGRJT8ZDW24BedhiscZRk3PqPkfKJ21DbGZBa6zrdyD5
         o2s47VXOfHtyf/V8Eykhq7V0MWXN4xFaf++F1Aopuc9aBKbRk0jrd7UmiOVygj2jWZiX
         W53CnvMwYkmxOddLAGkHfK7DlNq3GPbvilyWmolng8YzqMr4UekH8eol9E7GS6shLoA3
         61X38bk+DP6+mV5oSXgV59zD4OO5psTiNmNkRt5Fkjn18aKTP5O+aqsBw9I70yOd0RCy
         G1WmF87BsuzD9D52jhsswi9sdLac452mg/b2838KShu5ayDKlGBswf3TSbPqUVio6eYY
         uMrw==
X-Forwarded-Encrypted: i=1; AJvYcCUXDqPVkIilgFS+Z05GM6DSFCj7mt75AAS0o1MJGbmE0FBRtJ4VfCA/cY0RemOpw9MPCMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LPiODeMXJOtGexPxYS0Ore3PaK6uV1H7VeiTLJ86mYlrdSLX
	ED+RYkq+RxHGmh0oraIwsFDAnPCFART1lLiDyDkvEIzT4W0rpXI1TMlDvWkKwcw4tAgmKDxn3TV
	rBFaAo/r00Pucs9PrOvKyQdtqHMLhIv+kMw==
X-Gm-Gg: AY/fxX5fsMN+7iAZTv/i2fxAXNtXP4UMRjHDm8j5X0IoIvG+rhOsd2VWZBIl5ayQ40A
	Vyj1pSdpqJMr+gGhGpNl/LxLv1cY2KuQYD0ZhH3NfrvxFtjiDcMjq9Icv2XeWC/OvONHYtPkGJy
	OhSNC/h5ToG7j/zFi2qNjy5S+REFusKfGwqBIUjYRBwB+CKRjX33aRugLHuEVTQkHCdo4WP4o3q
	ZgxZZ5pZnd1V7zp0BdXewm33FyNJ8iILYonI9vs55L5mfbqD9zlJqgVHOSrRESVqy3NcxSLDJaG
	SVSHL0S7pLVg7R7q5Loguw==
X-Received: by 2002:a05:600c:35c6:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4801e2fdf57mr9930315e9.10.1768502768980; Thu, 15 Jan 2026
 10:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-fix-bpf_rstat_flush-v1-1-b068c230fdff@gmail.com>
In-Reply-To: <20260116-fix-bpf_rstat_flush-v1-1-b068c230fdff@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Jan 2026 10:45:58 -0800
X-Gm-Features: AZwV_QhSINgSoi3rz_nFYdVY7KfAkFH5D1xcTL8ipub-P1YjOCBQnnV6czHFcYE
Message-ID: <CAADnVQ+B7_oUcZDx2cs4sohAXNLy1qopkfsJsE-X158rfj2vhg@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: fix missing prototype warning for bpf_rstat_flush()
To: Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:34=E2=80=AFAM Ryota Sakamoto <sakamo.ryota@gmail=
.com> wrote:
>
> Add the prototype to cgroup-internal.h to resolve the Sparse warning.
>
> The function bpf_rstat_flush() is defined as __weak and global in
> kernel/cgroup/rstat.c, but lack of prototype in header file causes warnin=
g
> with Sparse (C=3D1):
>
>   kernel/cgroup/rstat.c:342:22: warning: symbol 'bpf_rstat_flush' was not=
 declared. Should it be static?

No. Ignore the warning. Sparse is incorrect.
We have hundreds of such bogus warnings. Do NOT attempt to send
more patches to "fix" them.

pw-bot: cr

