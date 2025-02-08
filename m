Return-Path: <bpf+bounces-50824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8042EA2D1EA
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D945188DD6D
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C23A93D;
	Sat,  8 Feb 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rr+qqf58"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434882CA6
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974067; cv=none; b=Izr2Xq7zsDUoRtgyNfvHejRFYUtIxECzlzrIl5fO1HjR7ee2Z37t9bimtnEgNxta75nlMIGPb3fC1tpFvufOOuA60y7GrFFO8GCEsnXJq1dPuo4CihWgUo5mOqKVblmoonuE+aTinN40u7xJ/h5yTGzPNXcg21CJ6jmlU2/mjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974067; c=relaxed/simple;
	bh=yOrQz9unRcpmUkjorbXeFY+d4qCf9xEGICDwqBsyfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXDKXozJ4Ufvr5mX131m5Xco3y16ZF5n2oG2+7uPhpL7cpXsEd2hAAdm7VV9MS6NA/JzeOjYrH+DYJMQ+kPEacirTzfzhjxLBCAT3Cf1hmsB6bS2jtJ+CDvsWyEEiLipbCQ11I+Z24CpVYyjCRcqODsMFQXZ1w2fmJPTrMDruzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rr+qqf58; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163affd184so29505ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738974065; x=1739578865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDnmsDfQ9ygAHi6YHL8PYxVfYS8JZ6/Tk4H6j6DXAnw=;
        b=rr+qqf58QJnnwvddJl3QdF5sHT8Gx9WoCUOLLwB9eeVk5bD35NY8wEKMpn+TpdNPm6
         2r6PmHA0vTL+qM7+GEHNiGPp231bt2/eYazgMbO2PEKQbIY+yHURlCR7E58vVpdPLDYR
         CoIjj/VS5djRNUoPTYghKUHoTBdEKyQuNhdFLCjgoPNX2uZ1wNZBxov8WqdBBUbh2jW1
         kP4jtGv1tJWUf8ppLO4MQVPRWn065uX7yU79F8rA2uWUOuytFRATZW7y4FwN3BBJrw6q
         mtG9D8DywFLJnBRqldvNH9c9GxtiZCyQaRPY9wKmJtSo7I7HXIXeMSubUfHs1sXr8Dli
         v0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738974065; x=1739578865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDnmsDfQ9ygAHi6YHL8PYxVfYS8JZ6/Tk4H6j6DXAnw=;
        b=hXBNQooCrJfs1lHO1zj7gIJMQADCjtn1NKIgPV+qgBOuGCSr3P+Ea660VlVqPoEgYI
         gUutwmyh69IUQkBXeSFoam/AIdyG/szHwUTpMVDdAwgCqhYbS1jA4rPv1A+qMxOOizaV
         +idU0VCzj8eDgYMPTZE9sQwTQIIAvuzahmW0slGEr1YsgbK7g+ZoBPGAC/cPVzw5u9u9
         sPlikkvt0ie0ZTXVBxibx9kOls/yMVXSKci9as1Au+6JcFcDokysAM+KSUS/CyfXkw32
         ZnThZqNDw3xmUsqKX2wDlEt86HNO3dyYrmL2hHNxcJh789jgu+5MnTShjrIy6H4Bk4c9
         UfHg==
X-Gm-Message-State: AOJu0YwS8tfrNoW+GdrKXI8eZmS5wMGYZhrMGytrFcrBAVK1t37X1XEP
	9R9E9ZhK9G/+7qL2kBbi/rz1UHd6ofgPEUysbW7SRN/s7yj1YP7hWDFSXOmn4lPtJqKqz46RhQq
	kk4ZS
X-Gm-Gg: ASbGnctmUEnkjOLWn8m+G8p4616fJg1A49BFt/BcQ5VBCO+r0qse5F/4LMOgUjT43mU
	fGbnJqYmz56quUW/AbISW6zaGEsBNNomsSZgjQye87YVDrm6LDaUin/wG7aQjoPiDnHBDejwRha
	qQjgZopYINDCSjcmllkGOLnbBA0qMTSxIrLPL+FDmNIYmAqL0UWCtE1RLEL6H82OM9nAdmBc8Jd
	K/F5gGPEIxpdYt1V6ndgoAafKjec1ywZSUbO8T753kEnKbcZSqDRSmv2zyq/9qUQmXK4B+Q3vSK
	6PHAOetmsQf9iHkw9YShFXkTKD2O8AAVlYCprnA/v6I236xPxu1meA==
X-Google-Smtp-Source: AGHT+IH8AQ/C6vnrRRfpvXO7lMPRI+npMeB/Vc/zMwEExBzDSAg1gMLPiOG7gxdFT6Q7rAfmKqEZ7A==
X-Received: by 2002:a17:903:19e7:b0:21f:2828:dc82 with SMTP id d9443c01a7336-21f69defa27mr1000515ad.2.1738974065041;
        Fri, 07 Feb 2025 16:21:05 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653b143sm36748745ad.54.2025.02.07.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 16:21:04 -0800 (PST)
Date: Sat, 8 Feb 2025 00:20:58 +0000
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
Message-ID: <Z6ajasn2k559SGNN@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac854ac5cc62e78fadd2a7f1af9087ec3fc7a9c.1738888641.git.yepeilin@google.com>

On Fri, Feb 07, 2025 at 02:06:29AM +0000, Peilin Ye wrote:
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -6,6 +6,8 @@
>  #include <stdbool.h>
>  #include <stdatomic.h>
>  #include "bpf_arena_common.h"
> +#include "../../../include/linux/filter.h"
> +#include "bpf_misc.h"
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARENA);
> @@ -274,4 +276,90 @@ int uaf(const void *ctx)
>  	return 0;
>  }
>  
> +__u8 __arena_global load_acquire8_value = 0x12;
   ~~~~

CI job x86_64-llvm-17 [1] failed because clang-17 crashed when compiling
this file (arena_atomics.c):

  fatal error: error in backend: unable to write nop sequence of 1 bytes

After some digging, I believe I am hitting a known issue that Yonghong
described in [2].  Changing __u8 and __u16 variables to __u32 seems to
resolve/work around the issue:

  +__u32 __arena_global load_acquire8_value = 0x12;

Will look into it more.

[1] https://github.com/kernel-patches/bpf/actions/runs/13191887466/job/36826207612
[2] https://lore.kernel.org/bpf/d56223f9-483e-fbc1-4564-44c0858a1e3e@meta.com/

> +__u16 __arena_global load_acquire16_value = 0x1234;
> +__u32 __arena_global load_acquire32_value = 0x12345678;
> +__u64 __arena_global load_acquire64_value = 0x1234567890abcdef;
> +
> +__u8 __arena_global load_acquire8_result = 0x12;
> +__u16 __arena_global load_acquire16_result = 0x1234;
> +__u32 __arena_global load_acquire32_result = 0x12345678;
> +__u64 __arena_global load_acquire64_result = 0x1234567890abcdef;

Thanks,
Peilin Ye


