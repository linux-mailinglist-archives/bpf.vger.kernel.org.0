Return-Path: <bpf+bounces-40008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D405A97A89F
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 23:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EEF1F21ED5
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A8415DBC1;
	Mon, 16 Sep 2024 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJH9UEvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA01311A7
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521249; cv=none; b=bMsc3sGPDqJjYJXVwAeRMSkLe0CZErEUwxieS28J0gKfy4NPRu4kJvnrY4+nIHOH4lJVUZ9AnUiR2+YmUedPmO6sbwYc58Vgkx7sO+Kg8N/HoK6saAQxKcxvQ0OBnWmYzn26/S1seTU1i88S7wuaLMr2N/0mPQ1iziC/mGFTB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521249; c=relaxed/simple;
	bh=viYTzhEzzSsiWpjdCk4DIUGKgReUIm1sGRVEW0veLjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j03iwlWoZoa4zmi3VSAwnuMVyFrc/KcKkQtx9EFna3hgynxfy7rHPDTF88xEXZvV5l011nLJ0DfonKIaah/R1YTs36rQqtPhGnuXQt7qHTMrbMs6T8IvoLGBFvBRk3KDSS0GlpF7OM8IwXoomvWc65IdU6CrSIVEKsSEOD2v954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJH9UEvR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20546b8e754so26525ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726521247; x=1727126047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkeSCb4r0UOyVJi+xaz1+UhtIWSFPjN3TONKaNoSG5Q=;
        b=hJH9UEvRAN/eam8tI3wJHJjpoxcmBpEBkvMk6ymkX9QVuqtsNv0eNT7rtg1rBWdwiX
         3R3NxKSW5Cq1xOOPRBzcORObrPscTOCewkWuRPTGEiEOK+pFEM8cYCBPwH6IoQKRD+vp
         DxGZXEfdY0wu17r0nqHPIDMgyIfXWTcBCXvMfR6T79bhf5mgIQ7g9Y6zO0UHMrkkxSAY
         Dzf+dIXQ5sXjXbVXVu2nIRawjBIifknzvm+5x2XI9fek/Jf6p9P8EUGjcIGZfW6Kjnu0
         DtY7NMG1KR1JodQQifhEzIUmLmi7eCP90PhJ+uLsUe7fHwUI6xO4VIRSq6UynUzHIo6T
         J/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521247; x=1727126047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkeSCb4r0UOyVJi+xaz1+UhtIWSFPjN3TONKaNoSG5Q=;
        b=q8TTnGpSpkipFsfW9rIzfsNKQyyBtK+F7SvfoyMlzf97J3JGCk2NsQSbBNsssocAe7
         CQPp1Y/G0wvXF9OpBSvkKIQP9NFOwJ/aoHrOuX6Y8Jy9zxAvdGh3CMzeMNlXaZEkg2sV
         WVgm1uCUvdA7W/shqbBOJyy4vnS6BtXJ7BigFOy23wwsnnLY4gLrHVMsXlXJIp90Txq4
         2qIIFZeYRPx5n4kyckHtF4H8SpK3FXtHAfTIKck8KwEPMxh3T3jnIeIAypnKBtXPw5sw
         DYrjBcGV7B+ZabhULP0TssPqokYLEkBZLfQYrIswEvfch/oWkchsA1JsaTBJR9gDbyQs
         axqw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1QkBMNrGDNji+N+Xfy3qX2q0gwMB+Esij4jo5TVIhzde6LrkKig2ZuA92fOHkcOlh7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pyTKJVL4W9EukyLCdzT3qOYPab2IYFRLeZ0R8KxR1MNXrdCH
	01mUV/yUGnEpfeA6+EtxyrOp5UX6ydy4BkiJKKkJbgO1HFBMADvV7FDGMvdeTA==
X-Google-Smtp-Source: AGHT+IG6SCNZyjkLXKDRRfmhq3HusIXpiCk1ejMM36bGHRpm75fOnrSMn8kKyrFk47APz80qehIiWg==
X-Received: by 2002:a17:902:d4d2:b0:206:ad19:c0fa with SMTP id d9443c01a7336-208afd8cdacmr884405ad.0.1726521246975;
        Mon, 16 Sep 2024 14:14:06 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d98a2sm3949743a12.16.2024.09.16.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 14:14:06 -0700 (PDT)
Date: Mon, 16 Sep 2024 21:14:02 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	Eddy Z <eddyz87@gmail.com>, Peilin Ye <yepeilin@google.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZuifmkOiuV9-oXgN@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <ZrJ3_esc7nBb6k9_@google.com>
 <CAADnVQJDki9GCxDAaGJWb+HrKT2EnzYXM8K3238XxPtHkhU0Ag@mail.gmail.com>
 <ZrUxxRpp_hd-2zyc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrUxxRpp_hd-2zyc@google.com>

Hi all,

LLVM changes for load-acquire and store-release are available for review
at: https://github.com/llvm/llvm-project/pull/108636

I've tentatively put them under -mcpu=v5.  Please take a look when you
have a chance.  Thanks!

I just noticed, however:

> On Thu, Aug 08, 2024 at 09:33:31AM -0700, Alexei Starovoitov wrote:
> > > Speaking of numeric value, out of curiosity:
> > >
> > >     IMM    0
> > >     ABS    1
> > >     IND    2
> > >     MEM    3
> > >     MEMSX  4
> > >     ATOMIC 6
> > >
> > > Was there a reason that we skipped 5?  Is 5 reserved?
> > 
> > See
> > /* unused opcode to mark special load instruction. Same as BPF_ABS */
> > #define BPF_PROBE_MEM   0x20
> > 
> > /* unused opcode to mark special ldsx instruction. Same as BPF_IND */
> > #define BPF_PROBE_MEMSX 0x40
> > 
> > /* unused opcode to mark special load instruction. Same as BPF_MSH */
> > #define BPF_PROBE_MEM32 0xa0
> > 
> > it's used by the verifier when it remaps opcode to tell JIT.
> > It can be used, but then the internal opcode needs to change too.

There's also:

  /* unused opcode to mark special atomic instruction */
  #define BPF_PROBE_ATOMIC 0xe0

0xe0 is (7 << 5), so it seems like we've already run out of bits for
mode modifiers?  Can we delete these internal opcodes and re-implement
them in other ways, to make room for MEMACQ (MEMREL)?

Thanks,
Peilin Ye


