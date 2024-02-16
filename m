Return-Path: <bpf+bounces-22164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581E858314
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E815B23312
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16ED130E34;
	Fri, 16 Feb 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgwgYf3C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB8130E55
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102464; cv=none; b=O7v2w0fpn701vYMT1Vpc1I62Ec2EbqVWC1ft5t5r3cgiRtkFwvDmIrFMbGMjol2tiY3vU1jeQ4Zh5nuov9oQo8L2NHT0f5vUkhazxBQOQrPSTAjgZ79ggrBcpKDa/XcqZ4EXrgzdtAly68lcNKnweyLgoJRztLfiYwK5Ap4lENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102464; c=relaxed/simple;
	bh=7Z8qTJiGqvDYL1tysuzS+vSOwPcoDWNyosl3lTfTqNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cf571Eh8uz6FgeXwx5guIfWSWn/scadQ/TG5rl+/jpcAxDL/9cCAv0CH2DqrKdXFGc9OvmKN5k3xRsUb1zgAdTC0s1NW3m2+HDOjv003lB8aj08Ksl5FOPPvjk1hpjg3XB4uGuxNK3RZgdM+ma76NE5lnxfYIHiCcK3MeQWP/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgwgYf3C; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d05b8942so1458055f8f.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102461; x=1708707261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/rBy1piZrbgSj//PD0zeJtSiUezOf2Qd7EyfjySZPo=;
        b=XgwgYf3C7Y/VIHrdWcm5TVzx2WvbnRiZ4zQOwAz+6KgES+bh8O+etjfAIE2j8QkmlA
         ca8cmgWH3K3TMzZmQjLviKzO3DirstNpiVwql5/7JOWjIMwpgLM2c17Ovmdvhz5LEfKn
         oO2C/6k1TzgNFH/K5q1rOC2An2DQmlBEtGpaCfpaW3wmPJtGRrqgt2doX+4WVjMJXV0S
         HjSnJQ0W29QIpNCC+O8dWp6TFsOvzq1+MGCB9usMeFBrr+TaZOQZUREXB3h76qU54Jyf
         ZZ8quQlvWsejntmXAa0MSuqX0ANlhivOV4PKw7/AW1VZ86W4UjlQisHazvmCv8jNbTI8
         tJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102461; x=1708707261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/rBy1piZrbgSj//PD0zeJtSiUezOf2Qd7EyfjySZPo=;
        b=ujee/SEpdhlhZRkFHNaFkSLYGqjNmY+jmJ/3e0FbsF8KAmHRCwT7vMwzduuffrjLxe
         ZQK4zWIo/rsCGbmkDnzsVQ/PBEB72lPYMrMA0oCAqe5FNjfXHIpN7OCLr8IqxaQD4Bd3
         abobR1VB3eGm+9pI6O2HAwx+dG1wymEPXJtBiQcYbVryLu1r3640FAjqsqOlrkmac+ww
         v2YPVEGBld+s9j8qnh/0KZF/+hdmz6poNCW5LizpcxqJlTNfs7ejWu1P4r9qIgWFLEvV
         Wo+xjKgiAoYDYw91J293bVfsHv3Zt9CP1wW3rY/PHyAH0GT7sysEH5o4WT8jNKkq9Fjd
         erAw==
X-Forwarded-Encrypted: i=1; AJvYcCVSSJLNTj8w2KwLpcKwb28bLvWUBaC1qvPc6fiV3eF2col57r0tPXg97fIMKlwO3Ao8/UGuk6izfh2CJ1kzD4IGw1I3
X-Gm-Message-State: AOJu0YzEjDT90+kHS91XmtKSeSfPNa1WdRnWmOrMOLkVVSsy4XKQUI6n
	dkGdNy1L+3H0q45kfoiEYv9Wju6aCaTv2/BMI9oVOBgmLS4BVMQ2QVLHhY5PMk1LaU1aMtRYK90
	oIWhw8FLcOuN+3QJ74DvYoz+KbSCRiTAu
X-Google-Smtp-Source: AGHT+IHX7Wpx+GDA6dByQaJ3O5AT6e1sonZooDx+69THpMDnjEja2+Mz49EXejtB/GGkmGDL+Yu9WSjwaySafKdXJX0=
X-Received: by 2002:a5d:6385:0:b0:33b:4ec0:8161 with SMTP id
 p5-20020a5d6385000000b0033b4ec08161mr3778611wru.10.1708102460458; Fri, 16 Feb
 2024 08:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org> <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
 <Zc8rZCQtsETe-cxU@infradead.org>
In-Reply-To: <Zc8rZCQtsETe-cxU@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Feb 2024 08:54:08 -0800
Message-ID: <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:31=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Feb 15, 2024 at 12:50:55PM -0800, Alexei Starovoitov wrote:
> > So, since apply_to_page_range() is available to the kernel
> > (xen, gpu, kasan, etc) then I see no reason why
> > vmap_pages_range() shouldn't be available as well, since:
>
> In case it wasn't clear before:  apply_to_page_range is a bad API to
> be exported.  We've been working on removing it but it stalled.
> Exposing something that allows a module to change arbitrary page table
> bits is not a good idea.

I never said that that module should do that.

> Please take a step back and think of how to expose a vmalloc like
> allocation that grows only when used as a proper abstraction.  I could
> actually think of various other uses for it.

"vmalloc like allocation that grows" is not what I'm after.
I need 4G+guard region at the start.
Please read my earlier email and reply to my questions and api proposals.
Replying to half of the sentence, and out of context, is not a
productive discussion.

