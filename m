Return-Path: <bpf+bounces-15016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16987EA744
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343F8280E9F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23514418;
	Tue, 14 Nov 2023 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaKZ1Uvu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA744407
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 00:03:57 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0673196;
	Mon, 13 Nov 2023 16:03:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-545ed16b137so7072266a12.1;
        Mon, 13 Nov 2023 16:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699920235; x=1700525035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrAvSd87a7tN+Yr+cywvAUwRhFU/yIlb0TCaKPOOEqs=;
        b=VaKZ1Uvun8jeYtQd0GiyOmVaK3nrCOObplGD0DCC2YvcA/EHImigL/27Pp0r6XgJDs
         gKiJZeRccjI2wUsb15QFHPGHYnU8UvLUCJ2RgGW/Vi9e7ngZwX3E5CNZXZaH6NtvBRnB
         ArnVhBglrk+4WlA4OwTT5OW/WO+rPDvqFyOLbFL/K8LwYpAl5gqO0EB9WryUJucW255O
         lPY8W0zw5HeAN2w0/J4WwetoLKQva5vCKXzlKZozGrjj8Y1XY6ie0jyI6Wt48GovhSoW
         LIujyBR0zh4NF499ajReqfT5xdYqZuVuX4GS7J0f936oV0/ajbl7utWUAAnEk6s//CCR
         VY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699920235; x=1700525035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrAvSd87a7tN+Yr+cywvAUwRhFU/yIlb0TCaKPOOEqs=;
        b=nnWzGzkwa93XOWw7VTHfKFJ+rjQhUGfCarIQQ87461FZF0tSxrwpxLSh7M3TsZPpNi
         6FovqCoMWZmp0g/5UwFHS5AOUrgZSfYp66VN+cRX566D0pdpgh6NOK5Q087xy1+4GYIo
         FQa02jBSWkKdOvPfxIKWdJuSG8za5+DtKqoGupdhY4A19ebkiHx0uLiohjWvDduWhhWt
         vjYxUabwWwSz+/SHfD9YlURdw9hUZ2tz5fzQyMgCWbS7kGS4ch2dwMgjbHpT5QCHjoLi
         5FvvPU6QPdM+xwhvg5Ly3oeaZg0y5aDxlYbFzVBwjvf5dxgkwK/T+uAm6WSK34gCcXwJ
         QfEw==
X-Gm-Message-State: AOJu0YwjuJOMWx7GDwM8LL2LvkizPYA3XSdJgac8LOeUeQD9fa20zwvU
	byrtSNMSCQy8tk/GPbWhAbbqN/DJxU9ZF4EC83k=
X-Google-Smtp-Source: AGHT+IFxeqCNoHbRXoGQHIRWu/pCXhkOWB1OvijL+Z+GiHdMOYEoM3UWHslUsclC9IMzWDjUhMRlNkNhsvAaLfzBdVw=
X-Received: by 2002:aa7:c759:0:b0:543:5a91:a8b2 with SMTP id
 c25-20020aa7c759000000b005435a91a8b2mr6116970eds.19.1699920234763; Mon, 13
 Nov 2023 16:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbUytfJS1ns0pp=o=Lk5qbQ5weD4_f8bPFrW5oV0tCXZw@mail.gmail.com>
 <CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com>
In-Reply-To: <CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 13 Nov 2023 19:03:43 -0500
Message-ID: <CABWLsesED+S_XNnWJDvJnPV7D0K5U4y3VjGQ7EKeecnufw4xbQ@mail.gmail.com>
Subject: Re: bpf: incorrect stack_depth after var off stack access causes OOB
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have sent https://lore.kernel.org/bpf/20231113235008.127238-1-andreimatei1@gmail.com/T/#u
as a fix.

Hao, thanks again for the report. For my edification, how did you get
the KASAN bug report with your repro / which tree exactly were you
running against and with what config? I've run your repro program in
the VM created by vmtest.sh, with an added CONFIG_KASAN=y in the
config, and I did not get the bug report in dmesg; I got nothing.
However, if I change the variable offset bounds to be around 200 bytes
instead of 12, then I do get a kernel panic because of a page fault.

