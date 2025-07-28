Return-Path: <bpf+bounces-64513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B50B13B17
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BED1888F3A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68C19F135;
	Mon, 28 Jul 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Fl8+d5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E125DD1E;
	Mon, 28 Jul 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708477; cv=none; b=j4fVPM1TPzIbQhShTDJPhiZkrTzsYDiQ/c/yB2eCg8RQcb4FdVypIVnHJiD0/5YRDzzo4pVXEk+u97Ciu8X29Hd7HhSMNxpDTAF5BIhGDptuSGu7S00T4Ykv7kP9X1/rgQ6iZLUm3IhTdDcqcsqWfDxZYBphqVnkM5Vu7MHfQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708477; c=relaxed/simple;
	bh=/JmWk7zs3nfyhClMXqzipmUy0qSDDHncW6sykqFZENY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5KrR61gVm7oms/fVTxfMF0SHZL3KTnhQi1eLkkiVoB6icrUhWxZ/pwNCUvDyn0JRoGefkmRkwLd6XTN2vJrjhvV7WOsYsex5vBBtHfqmFwMsB4jxa5NV3NzTfvnMVz/iYxygS6+4DbjQvP9ADP92esU6fDsUwWwHPYI4oV/k28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0Fl8+d5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso921369166b.0;
        Mon, 28 Jul 2025 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753708473; x=1754313273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDFjPQjNHLQQewbHjrCkwV119Zp5gq44Dp1xWV5F2p8=;
        b=F0Fl8+d5wGYjBvzH01ECmzScCU3VO85/9LX4uLV+5vXj62SBdX0CjCtJWDjPODMehA
         M9am3eC81CR1rB1A1gEeyn+Q/6xGD8fHXdJvhOox9Eb3TW9+Kpi7DTIAUxtkqjrLRMVw
         KA3XXHjebb3entiNYTlExUTHAOa2p1DA7sbRv8uqP396t1QcktZQFZWgFqsQHx1RB9wi
         my1aw6FbxPCjXiwxJMJ6RmH4j3TPN0iX3X1DFmQvjLekkKSQukIKeH5vuYvmYsVsEHpf
         LdhDx+mcyTvHWfAYMnMnVPUhbxpW/9vh70CofdcSJe8Ak8GMbVq0nT9mu74OFWZBNqKH
         Bbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708473; x=1754313273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDFjPQjNHLQQewbHjrCkwV119Zp5gq44Dp1xWV5F2p8=;
        b=OEW4dqrqDOJf/6i91NXOFeObfaZ+diKJ5s590pI60smRQFS+tqD0I6dgsjxhkJ14bq
         maKM7KUVqshHIpAxG8CPDx04TdkpEdrtHvRnsb+xNvIvW/t/T1XGECJum+9+z/owjMKH
         C7K/ZKZ+osRQU0Fh4vQqXD2UxWpcEpEuRtZji2gDSPa0Owl1b9dnc3ipmgwQoYA4UNZJ
         g/GyH3eZth8SUFFoNEqEh99vNbvRkntTjYNbkkx85OxQLDI9vl2Ve0uN6q7Meie2IPXn
         Z3kLy+bIqyk5SPbIaBP/Rssu07zgJqmcavKCGr8PQTf0VieC1SAloTjjbICIOzovnOPn
         Yd+A==
X-Forwarded-Encrypted: i=1; AJvYcCUBEnimLauPmkNpGj09h9aj4RS9pOEy0T7craBYBKIC4BE+zDjfd2Um8VzP6uR1YcFZ5sU=@vger.kernel.org, AJvYcCWue7APP3W09XrX3DHNJx+7JZRIn4CN5Ds6y5ZtS9s5EFdoxSL0hcbC84Mpc9lxkxTkfuI2ZGS96Y28isKS2i017LgG@vger.kernel.org, AJvYcCXGBNfB7wDsg0ujbVg7S+3asMVlCJrlcdAqN+LoD9p1i3eO9O8zbySCwiQ0LQu0JFIipyh0uMXtI4T7Pw5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ef26iyRPDGu8G8OcaV8mQ8BChDFFY2jmbt1rz1m3TUWMSTnZ
	Dhb2k+iyEX5NC4ISV0GuZhgGp44Tf3/i55jwnQ0EcK6dRuRt7aP/Z4TwRrWqUwEA
X-Gm-Gg: ASbGncuowiO9JSKCQ4Ch7VzT9pw4zHbhhm1q1R5jGLoKmgkst5u6YQU2mUxj4aH96hM
	g2lDRP8fzQom4IiXY8RMfTqZ7tpXe+qZ3eubKdsXo6DUSB5AvTsNSD1+K2duLqKnksSwxf4MpLT
	XxH/dK4QeT98rvlKpj1+o2nm5Hzi2dAILVY1NI7FZcUIImi5G1l/K/xVbu5o07Sw0F6tTRLljbu
	SKMUJng5/L4bDP7mNvv58oTMXUKYWW/psdddJg0oln2o6THPj/VW5edTw95YwUuBNdrTMPgY9Q+
	hr4ySX9LjoTF2vUDX+kZ5dIy0VRTdcJmrm1q03n5tPloiQc0DsPiXLzSe2FBIiTbMoACsYmjRlB
	PNupBAlvP
X-Google-Smtp-Source: AGHT+IF83yApWustjCzSkrFTYttoyXch6R12wpIEtH4ogxlT87k++Cqgfg8D/XP99YLhQssIGlD2EQ==
X-Received: by 2002:a17:906:c105:b0:ae3:69a8:8da4 with SMTP id a640c23a62f3a-af617203561mr1080690866b.9.1753708472267;
        Mon, 28 Jul 2025 06:14:32 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad656fsm420271466b.121.2025.07.28.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:14:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Jul 2025 15:14:30 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com,
	revest@chromium.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] fprobe: use rhashtable for fprobe_ip_table
Message-ID: <aId3tjPnh_NyRLSv@krava>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728041252.441040-1-dongml2@chinatelecom.cn>

On Mon, Jul 28, 2025 at 12:12:47PM +0800, Menglong Dong wrote:
> For now, the budget of the hash table that is used for fprobe_ip_table is
> fixed, which is 256, and can cause huge overhead when the hooked functions
> is a huge quantity.
> 
> In this series, we use rhashtable for fprobe_ip_table to reduce the
> overhead.
> 
> Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> will hook all the kernel functions during the testing. Before this series,
> the performance is:
>   usermode-count :  875.380 ± 0.366M/s 
>   kernel-count   :  435.924 ± 0.461M/s 
>   syscall-count  :   31.004 ± 0.017M/s 
>   fentry         :  134.076 ± 1.752M/s 
>   fexit          :   68.319 ± 0.055M/s 
>   fmodret        :   71.530 ± 0.032M/s 
>   rawtp          :  202.751 ± 0.138M/s 
>   tp             :   79.562 ± 0.084M/s 
>   kprobe         :   55.587 ± 0.028M/s 
>   kprobe-multi   :   56.481 ± 0.043M/s 
>   kprobe-multi-all:    6.283 ± 0.005M/s << look this
>   kretprobe      :   22.378 ± 0.028M/s 
>   kretprobe-multi:   28.205 ± 0.025M/s
> 
> With this series, the performance is:
>   usermode-count :  897.083 ± 5.347M/s 
>   kernel-count   :  431.638 ± 1.781M/s 
>   syscall-count  :   30.807 ± 0.057M/s 
>   fentry         :  134.803 ± 1.045M/s 
>   fexit          :   68.763 ± 0.018M/s 
>   fmodret        :   71.444 ± 0.052M/s 
>   rawtp          :  202.344 ± 0.149M/s 
>   tp             :   79.644 ± 0.376M/s 
>   kprobe         :   55.480 ± 0.108M/s 
>   kprobe-multi   :   57.302 ± 0.119M/s 
>   kprobe-multi-all:   57.855 ± 0.144M/s << look this

nice, so the we still trigger one function, but having all possible
functions attached, right?

thanks,
jirka


>   kretprobe      :   22.265 ± 0.023M/s 
>   kretprobe-multi:   27.740 ± 0.023M/s
> 
> The benchmark of "kprobe-multi-all" increase from 6.283M/s to 57.855M/s.
> 
> Menglong Dong (4):
>   fprobe: use rhashtable
>   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
>   selftests/bpf: add benchmark testing for kprobe-multi-all
>   selftests/bpf: skip recursive functions for kprobe_multi
> 
>  include/linux/fprobe.h                        |   2 +-
>  kernel/trace/fprobe.c                         | 144 ++++++-----
>  tools/testing/selftests/bpf/bench.c           |   2 +
>  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
>  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
>  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
>  8 files changed, 351 insertions(+), 282 deletions(-)
> 
> -- 
> 2.50.1
> 
> 

