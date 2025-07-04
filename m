Return-Path: <bpf+bounces-62412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8ABAF99B4
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A40F5414E2
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EFE1494C3;
	Fri,  4 Jul 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htffF4Yc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37142AA3
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650366; cv=none; b=KqerGnKDMNqnID5ul2Mjq6HM2vumwM1Stxp69/DUtAjRtDZLdjQq9JycBZseS9OC/0SSmmmJgP2HOE3U6ZZxTsf1Q/0DamUSOgYptKL3945QwNosZdK42wWrP9A6s7rdQXjYrXlLaM/74Mw5b1UZziTqwDGwBw5XtqYlzwZqwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650366; c=relaxed/simple;
	bh=hezTlVd45Sle/FDeP9Dw6ZYb5dvRsVSxQnU3/PWGwFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY9CBhsPkHMANAUIRQv3+P93isjDm+OFTA03+MX1m1mncov1rB0uDqF3tYn587Q16wmYrDr36MdnqJaa1YrG+OB+GCCvd7VMW7hjJ4ZvjZxlv7OyKR/+qRlvaQ7mgDmS393yb/okVu43Skak8/Fn9Tj4df0TtTemkMPKXbIG7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htffF4Yc; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7111d02c777so9165457b3.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751650364; x=1752255164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hezTlVd45Sle/FDeP9Dw6ZYb5dvRsVSxQnU3/PWGwFc=;
        b=htffF4YciJ1I+myD1o8HBmXUzy+pmT0coDYCotPQigGEZqk9BWoerlpPZJ/lFuSvLF
         Hib62zSc3TJgcDLTRwlew6iAX1I1AYlPeqh+/RJNyTx8nic9uhthpjsT8SQDDrXQZpX9
         ey+yYYZVUKSPy5RIRtl9iJUS9X7o79a5ydF0ih6rklwIG73FTF7EL5+I2YNgvPczzW9x
         vE7f971l7AqvoByOT7AhpE+XAQTU5PfH0l/r+rQUII239P+UyM875B7EI+LRN/DT6qxO
         NVgGjKWhQGJLgZq3fK3TAMlzcb3C2CBhA78DMO5RsqQG0c37nLBPjAy+Tl/H+kSIK1K+
         Z4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650364; x=1752255164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hezTlVd45Sle/FDeP9Dw6ZYb5dvRsVSxQnU3/PWGwFc=;
        b=hoTMiRCnYwG70ofjcRU/L+yr5U1nCebxB1htN4owKK8tr+yiAB7wQj11M/pikmgls1
         OQ06Ah2/5M6cNZtyGUbit6IRsWgcy9g16B8D2r0Jz7SCnccFWmh1MiRHKfggrDnqY8T5
         O3khG8SLAy2Xk/6a2DboobYXGY7a9MaggQdhSB9kKGcSlznvBOkDKBSB0QTOx5cjYn63
         oW8FU1kaIxrukdq6FYbLEknhXdlP0XjIV/iAbZ1Yu5h7FZ4Z0Z5GoI7lTeJ0cwLZCL6/
         6DJbjSHntfbOApoluijgXuu9BViXCrTwHRoOVrYSCfJhiar+Vh6mVAtGai8y3DrBiFrV
         Rqew==
X-Forwarded-Encrypted: i=1; AJvYcCWNCpwEKE/nUcK+mKCM6XpZ7rVjp/0/zItQFBt7llod7UeanRq18RFFBNWzuSvD0Eqhl6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pt33Z6ZSH/uJMZotwI53WIm2FhuBKQq8q5vNsw5lpMBTTfi4
	9cyLe72NeuJqNmmrYJIWCs+IhnTX52FqdMSOOx5wkM8UYpGeF54NFlBdAIiDEUA27FeuyG6ED8U
	TuNujy7L8L9JDKXcbSATJdnj/O53e8+8=
X-Gm-Gg: ASbGncsQtnUJz1CUEC2w3412WNABQ0tkb6/tFRAa2db7FKf6WnWetGhcAhI71/+aNp/
	hvEFJfj5MIyF6+y/b5T9WGaYw8+foE9pJ5ZHDl9PcL6/F7u8exQy8dxu39etixaHJxRaNEp6d5d
	Sk5mrtaH8u7ONBNGdyjkGxb3txpqQm9C5sJJAYfi1oA7MOHCNc8RTxU2JohR9Edp6SWMrLX5FOI
	W4x
X-Google-Smtp-Source: AGHT+IHNB2BkITg4AG/F8Yj7L2t/j4vh/2yLdEjAqXUd7hlrxuVVTDXhLqa+5Wm5F/PvpPYrIUN/xqq40RD89KCicNA=
X-Received: by 2002:a05:690c:6285:b0:710:e6b0:1688 with SMTP id
 00721157ae682-7166b5bd0d0mr38850097b3.14.1751650364338; Fri, 04 Jul 2025
 10:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-3-sidchintamaneni@gmail.com> <CAP01T74u=EJqDEyB-gEsmRGqMF=TRPY+cb_eUHNVY3hr3OWYvg@mail.gmail.com>
In-Reply-To: <CAP01T74u=EJqDEyB-gEsmRGqMF=TRPY+cb_eUHNVY3hr3OWYvg@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Fri, 4 Jul 2025 10:32:28 -0700
X-Gm-Features: Ac12FXzKeT93H_3qazdwZZIyT-aH5iSskgcsknsr5uLZw3C1b24_t_135QCfC9k
Message-ID: <CAM6KYsvaPFHqdb-ZW+Bc_-N_VhJix8cQEvBbRo+pE_cBs++PPg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu, 
	ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com
Content-Type: text/plain; charset="UTF-8"

> The parts above this function makes sense, but I don't understand why
> we need programs to be cloned separately anymore.
> Instead, can't we simply have a table of patch targets for the original program?
> They'd need adjustment after jit to reflect the exact correct offset,
> but that shouldn't be difficult to compute.
If we understand correctly you advocate for storing the state of call
instruction offset of helpers/ kfuncs/ callback functions (incase of
bpf_loop inlining) and adjust the offset during JIT?

While we did think about following this approach, we are worried of
accidentally introducing bugs while implementing offset handling
either now or in future when some new JIT optimization is being added
by someone else.

We also thought of decoding JIT instructions (right after JIT) similar
to the runtime handler but there is an additional burden of figuring
out the helper/ kfunc's from the call instruction.
Currently, the cloned program is simplifying the whole task of going
through the weeds of JIT.

> IIUC you're comparing instructions in the patched program and original
> program to find out if you need to patch out the original one.
> That seems like a very expensive way of tracking which call targets
> need to be modified.
We can avoid this overhead still (by creating an offset table right
after JIT) so that the termination handler becomes faster. However,
since termination was itself a rare-case end-of-the-world situation,
we didn't consider having great performance as one of the requirements
for the handler.

