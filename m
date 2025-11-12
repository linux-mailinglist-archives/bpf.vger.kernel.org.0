Return-Path: <bpf+bounces-74332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549FC54A23
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F574E20D9
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D072E1F03;
	Wed, 12 Nov 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYrwUZUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40C2C21DB
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983464; cv=none; b=YvbFUn6NqoDsxF6yMbLWIFIsWMu7XS7vk57hUy9l+CzD5lpfwBc9h00UTxyqPCr4CnNaU4beU4LiGk8DsVr16Lecu1UBTzzKsuyDJdIHe9mJsruFFjFoMYSlRpsqGK7ldWEsA2dqnCnGFiHX5EV+79bbRpfn1P2WXWoLeJBVV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983464; c=relaxed/simple;
	bh=HUjRpcgFxZlsaHDR5Oqy1tRZ/gEUVjG9KwG6dKCpQwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjomXKCt+lbFdLzI/8Yf8QXXmFvIGMmAkf5eWBdV5nx6j88/BvNSPv2eNLQvWba0PUnny4pg3KXtAYhAwm6jB9UTKrx5KFtrdKkyWeZb+J/b+QW13Xr3oEY3I5GGZWevgr0exHC0vbLaHLWXPJXBv98euRLFGvgawNDy9k5NlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYrwUZUP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso765465e9.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762983461; x=1763588261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMNC/ZxkQfI0c8vktPmv03MO9ljLn0+pOW6ecFqMx5g=;
        b=iYrwUZUPJ7mnhRrogjjl/7mIb8tshRGbgPCsEAy3HhYGRECWVAy9QIc2nMe0Lb3U8j
         joNPnKjx9fEeyvkwg28Sob9n2pbBM6cK/+mLKpjO3xPqFAUOrnZRuQknUeB6zh1FxcEC
         /lRF5ZmkbxyRNSI2wnfzLbrDqGgGBCHs0BHJn7E4BcdIaDQ2qqeoiRA+V1DYVIuY174I
         JAE5d+fEN6MkiFE0qAy6BPBckM9m5lrHTM3GO4n2i6xkTsQgk/CsGKALmFXKCr9Hgqnl
         h3lYTu2/j9hedq3zipRfroXmuz9uBGY3sYuvq20HXpd11qHup5Z3czL9CoCZzPMvMsDT
         jj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983461; x=1763588261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMNC/ZxkQfI0c8vktPmv03MO9ljLn0+pOW6ecFqMx5g=;
        b=Xru/zWhJE8uOkhonWyLNSd1grB7ZdYDCc1Mnjx/Bagfw+1/lgfknQwRRWvkfSHBrh1
         V/R6pw/t05M6uPYnAMbH4JMEnhgYEUk+bSUS2pQnZ54jlOmLMOeU8WzeGkc0W95VfJyh
         QN155fIo3VIPlUh6jygL+ZJf6bsqkcXfaus8fkZ0rgL6Nq88NZNXq1zzued+FgExTxWG
         U8Qe499TuRyBpSiX0ZLeH5VadLgmQM0OT35QS5PW4JV5u1mK5rcsQtU2VewS2Qn2+3dd
         Q4uIvz9RvBniG1gpoOFPtc9yvQfySKP9vp1kdtDFf33BRsKUpoQfyJA6R7+X7hHJ6tlK
         QCrg==
X-Forwarded-Encrypted: i=1; AJvYcCVmqCtR62CHWFg+XcmqIaE1E7dk986r2C5zvFjZDx4QPCwuD7pfnKYRw7aXrA6r++Gum9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnllMhmN5qU3IrIiB1mmo8VKQdZ6WaYXaV+d8duonbRp/N6sD
	EQgB6L39tT2gcp8fUuANS56SjL+lUoDuoVhRr+NCSk0Fw35DMqKdcxIs
X-Gm-Gg: ASbGnctD73h0eqInT/XsRXdtJLRDSkreyst824Pc50Q3Dn2Wbg+9CcQpvh0l18Fv5FL
	MwRX13wxP58ns+VCvbIf9LU4OsYUXhQ6n/OXXgLX/ey316r7JS3cmotqnSuoIZg/LNMZAn5ZmXZ
	WXwDuIZ12CdgFHkNBMWa06x5yqHwsrLVxkbQSeWzPfIb44WM9qh8RBqpZ7vg62CuWEpcBTi/Bgu
	ETexM+a4sdBpBPLWYYCXqveTCLXEQQLibEoG6oyQQ830TSjQFV6dEZh9Z5oGHlMN0OJQePuY/7f
	6bAfwF7jOLMf235DZFRXOYf4dxGjfx9qlRbCoHdtk7+POXZZk7+s+dyDXR7LmEGJLOgiauLRlY7
	umSYFaNebvVEfvfa786gg5K3xW4hye1pMN4F7wPSx3O7mMa8JN1i0z6vuFzN0ajKx3ap/gv4Suu
	QC+XTcjR/Z+x7RgvV5Q4VMwoRmibDlbVyUg7W6cwm/Cw==
X-Google-Smtp-Source: AGHT+IEDSNODJ3nVTpsyc0L/4cxRnEnvAJ/B+BZ/K+v6Nx94yhuMxFrpIqibz96viADsSJoC80InpA==
X-Received: by 2002:a05:600c:4594:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-477870623f5mr42996915e9.6.1762983461012;
        Wed, 12 Nov 2025 13:37:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c8479b7sm12365e9.3.2025.11.12.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:37:40 -0800 (PST)
Date: Wed, 12 Nov 2025 21:37:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: Brahmajit Das <listout@listout.xyz>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <20251112213739.40123684@pumpkin>
In-Reply-To: <fead1ceb-c3a2-4e61-9b11-f30da188d93a@arnaud-lcm.com>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
	<20251111081254.25532-1-listout@listout.xyz>
	<20251112133546.4246533f@pumpkin>
	<u34sykpbi6vw7xyalqnsjqt4aieayjotyppl3dwilv3hq7kghf@prx4ktfpk36o>
	<fead1ceb-c3a2-4e61-9b11-f30da188d93a@arnaud-lcm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 16:11:41 +0000
"Lecomte, Arnaud" <contact@arnaud-lcm.com> wrote:

> On 12/11/2025 14:47, Brahmajit Das wrote:
> > On 12.11.2025 13:35, David Laight wrote:  
> >> On Tue, 11 Nov 2025 13:42:54 +0530
> >> Brahmajit Das <listout@listout.xyz> wrote:
> >>  
> > ...snip...  
> >> Please can we have no unnecessary min_t().
> >> You wouldn't write:
> >> 	x = (u32)a < (u32)b ? (u32)a : (u32)b;
> >>
> >>      David
> >>     
> >>>   	copy_len = trace_nr * elem_size;
> >>>   
> >>>   	ips = trace->ip + skip;  
> > Hi David,
> >
> > Sorry, I didn't quite get that. Would prefer something like:
> > 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;  
> 
> min_t is a min with casting which is unnecessary in this case as 
> trace_nr and num_elem are already u32.

Correct

	David

> 
> > The pre-refactor code.
> >  
> 


