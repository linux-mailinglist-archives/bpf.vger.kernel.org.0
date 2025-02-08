Return-Path: <bpf+bounces-50836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D0A2D303
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466F3AC32E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA114F102;
	Sat,  8 Feb 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spTY/a3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CA1448D5
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981209; cv=none; b=a26hZULfZkhtPpDqEXbs1w0U8h//uiBqTrL/BPYZlfZjyA38LqujJyqUco35JHEhoR1RpOqpcxDIAIZCfE1kw4Kl0VtkN4l/p9VyHFIqorErXz2qZY43UN+fTOYGA9Ok0KPqqy1MqaZZPDhd9JfiRgG86AV8XFEN/8UPFz1v3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981209; c=relaxed/simple;
	bh=uYj7Wd3kl+ZY/8nvKpyK2tHanFbVkqe62iX1Kz7vm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8FwcT4kHxXCZrhdPdqiuZgocgsLTr66JuV/C0TNytqDI7lpgV4mW3OxlMJmzOltwJSWv/wW2DJ9vtlI2QKRoL/bifbSjZ+klKE+1dxCcOa48mzV/0exfc5+pQjEr1fDQi83CXgoZ1QyUvgZiAy2U11BGC9khCUtyhpXcjIKSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spTY/a3L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163affd184so37955ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 18:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738981207; x=1739586007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDYadGDopo/kQCy0AbShI9sRbHzG3KIQ1tPEzUCUA1A=;
        b=spTY/a3LJlB7rt1CedLNPEKimB45Gk5kmvchqhUvtEr7gu8IF+woPTRD5PYqB6Ujan
         r7xfpoGEcWe4pNUwtkVRbN+Pb7cCddZZ7NG/bRpTRPpIcpFd39TWNl1ozZCuuaNuCVt1
         +HzZyje9CnoZTKrgbof461v2DV7HK5AGYOtSoewq69SDUJacsKhMnAJkXI0fPKwZ1ukH
         QigkdKlYHIUwAm+UGzXWZSw6WRiMyk92PhGiRuEkkMVsj881wBAxw0HJJxkAGwA9Y9Nl
         7bZkav03NZDPr911m37/exNvukQzQimzbXv8EX4PqnFCwdXvULmbQnHx4bnJBF+CKatB
         A3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738981207; x=1739586007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDYadGDopo/kQCy0AbShI9sRbHzG3KIQ1tPEzUCUA1A=;
        b=cIK059HDQqh1+ld0Pz7iaN5rJxIiUdqfVawBN12jvIX9doDEvmbjHjrgT2gD45yHFy
         hpJMecPC2zaaTwZjPITjljsB68+v7CPWjHZMF2phwDzveBx4ApXvRMUj37jKpV2l+/nd
         cjx8lyJ8WZotMf6e7QRxMuPZCR19o+DW+8oSlNAf/zeIdY/o7GSWOdBHnowQjADz/ADC
         YkYHzbnrFtZeBIciuJhxIKgZ284kt6e5lvSS7/IZ8FLbk8hMmRB24IuXbabEaLiXwjxz
         afiozbNORaLXsOj4zCXjo+nVWwf8JTNQn0fnE+Nu7F+WqRCT3+NDWbRKl3Iu79dQHVP4
         bqvA==
X-Gm-Message-State: AOJu0YxpuJZ5kYZqXYCHmgzKghP/r3Gb9FWdKSA8tfaAwDbjYYAyg4AT
	ggbb7ZMNALQv8JUOPRPubWAolWjURyIrI1vP2wrIUxab3GMdsVkxH5H+ppBN5xTXMa8qBjjfirp
	kJ6WC
X-Gm-Gg: ASbGncun/noY9wjUZtYvXRkegXxMnBWWr+83Uo/vc5YDa/2oLyyMPLQcj7AluEmA5N2
	AOkL30SAl18gkaMCLL1uX0Se2t0d+7n95fh1miy+vUMFvw+DUqYp8ox+yPcUNEHc22nz7cnfYC7
	4JhniTwhFggarH6Gh5mK/eh2W7OvBd6mwTrsc+TJ3QWLCtTgPVuhk3WeegavrMB+VIlhfpvt31q
	tlZJxdxPXGPCq+7cBu859ObD3b4XvUJeAzTQLTowBC324RD9wEVZpVx5YvlQI6Es5RdgtRCnZU8
	XBKCAqziKLMiYFKUSPMPTlGqlvDpK+p6PJzDSDnKBp9Jvc1cY+pQWQ==
X-Google-Smtp-Source: AGHT+IFW7Dg0rfg79gNlOmOZ/6V2FDiboe3xwyeaFxXl+wT8n5p43lmv5zIvkgHsQpAmIZegolvnfA==
X-Received: by 2002:a17:903:1a27:b0:216:6dab:8042 with SMTP id d9443c01a7336-21f69deebc5mr1209985ad.12.1738981206955;
        Fri, 07 Feb 2025 18:20:06 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa4d1220f2sm16756a91.40.2025.02.07.18.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 18:20:06 -0800 (PST)
Date: Sat, 8 Feb 2025 02:20:00 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z6a_UILNqVGBqnvY@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
 <Z6ajasn2k559SGNN@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ajasn2k559SGNN@google.com>

On Sat, Feb 08, 2025 at 12:20:58AM +0000, Peilin Ye wrote:
> > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > @@ -6,6 +6,8 @@
> >  #include <stdbool.h>
> >  #include <stdatomic.h>
> >  #include "bpf_arena_common.h"
> > +#include "../../../include/linux/filter.h"
> > +#include "bpf_misc.h"
> >  
> >  struct {
> >  	__uint(type, BPF_MAP_TYPE_ARENA);
> > @@ -274,4 +276,90 @@ int uaf(const void *ctx)
> >  	return 0;
> >  }
> >  
> > +__u8 __arena_global load_acquire8_value = 0x12;
>    ~~~~
> 
> CI job x86_64-llvm-17 [1] failed because clang-17 crashed when compiling
> this file (arena_atomics.c):
> 
>   fatal error: error in backend: unable to write nop sequence of 1 bytes
> 
> After some digging, I believe I am hitting a known issue that Yonghong
> described in [2].

> Changing __u8 and __u16 variables to __u32 seems to resolve/work
> around the issue

Sorry, that wasn't very accurate - we need to make sure there are no
"holes" in the .addr_space.1 ELF section, e.g.:

  /* 8-byte-aligned */
  __u8 __arena_global load_acquire8_value = 0x12;
  /* 1-byte hole, causing clang-17 to crash */
  __u16 __arena_global load_acquire16_value = 0x1234;

LLVM commit f27c4903c43b ("MC: Add .data. and .rodata. prefixes to
MCContext section classification") fixed this issue.

- - -
For now, I think I should:

  1. change existing #if guards to
     "#if defined(__TARGET_ARCH_arm64) && __clang_major__ >= 18"

  2. additionally, guard "__arena_global" variable definitions behind
     "#if __clang_major >= 18" so that clang-17 doesn't try to compile
     that part (then crash)

Will fix in v3.

Thanks,
Peilin Ye


