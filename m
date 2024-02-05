Return-Path: <bpf+bounces-21251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724684A6F3
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7F81F29975
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1925C5E8;
	Mon,  5 Feb 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq613mnL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E048780
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161449; cv=none; b=cNHqHTZpGb83I0aSXWTpLIOZGYDcih0RqlYE+kHyvcwn2XLUO6yVmDrs940f3jr8S3iMKbIVhqmJyZWi+va/HTxabvGSVU7II/zhzSMMBio/R3WDFMAD6Wa7+Ti2QqH2IfiW5boY1hS9Q7sdt3N4CrobEdw/KF5xyiM/Hnuvyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161449; c=relaxed/simple;
	bh=WUr4nLvpo8rOjlJgyAHH3YPE/xNEJfZJCsCqqG6mCLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKGqWlGTMlb2UEPkdSFB8sFG1ICVRlDT1s7nMWOmtHe+D3pSw3n34AO9hdVHUevyg0p13Is7SecoGKyLrZBTslnccyIPT1jLYSehs7zqH0qTWrstZzCGOnyQOKgO5WRkDDOWf37SbkdeSu/RnX32FXj33WZSX5Tqw1O8aWNcSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq613mnL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so4070868a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707161448; x=1707766248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqkqERVm4z5N5qHot5NtszYYzZ5Pjn8PqPHI1UdMBUI=;
        b=bq613mnLR4N0gqe6aP2eEsNM95IhcgGYSWtboQlGOUp4WdOJyWgfgpWtfs7l54+/o2
         dg5BoRJQRDpQrMOZq9xiz/NsYg1RLzFZ4jixBeH6Ej8t0WfJAXdlwSnSj8baCo5vZbEB
         QtW2LDcxsYCkIpYYB8qKnIhlYjlLYOepmCro4b+Bdak1jCs3bScY1jkmEMZ7VyNrnZtz
         p/kNG7bvYrcbMPoV98KD7AikxaUGz5nc2346Iq5nKmx+D1J7T11AAg4b4eXLS8NGIEXU
         0i1BnN/XHIM+VQMWR5vm8RjkF0WDwTTi3PBJ9z7nqFozQYal7WTnMJXRz5fNDXTgkCHu
         rB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161448; x=1707766248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqkqERVm4z5N5qHot5NtszYYzZ5Pjn8PqPHI1UdMBUI=;
        b=sxk8dApl+OnHgTadU57rPsBt5EDfrNbRC3JXx98eBrf6loAytssYscg30+uUvqxvns
         1rNihxirV6XSK3Uphx2/CENUTWOLhfykYjvmvbaSLuwMp6Trh3otU772AxZzYpL4UyCm
         ezOWPdJZHiw+1rtXRhdQSM9rp2o3t0YHNIPqocmWsKa69PyErl2GN/JDDZP/EZKlfWiC
         qsvfhwiTvGYLIgO+FDAe+2Slo+Jr48Kfktzy4WEg8CF5agjLEtac7VZMbFRo1wE9pmop
         FU2W0sBR3UGTvpWS8y+ytzDg0AvNRoKEf/lmgod0kxWHYtgyzQqfrWuwRkPE+SILKY9G
         NyaA==
X-Gm-Message-State: AOJu0YzIXW2Jq5FkeG2UrZ+hyuTFURNGoQGW5vlcI9fxNGkqToU1UoXH
	nU6cxI/scZ7OBlz7vnSnz4bOwS9ZT4CDtTI9G0LJ1Eu5cIbVqGMudnoa9k7NvwZY41HYfptJqVD
	bakgiUow3N9LWwwi0cXPYXNEa/Sk=
X-Google-Smtp-Source: AGHT+IGbQuE96pID2wZTwuik4lTy2/ziKlrPm9lzk4r7/zLPPkcJJz6eiGNIKPi/BpA21PFjLyPSIoIGxV5fooP0QMI=
X-Received: by 2002:a17:90b:211:b0:28d:2aa7:b684 with SMTP id
 fy17-20020a17090b021100b0028d2aa7b684mr443826pjb.1.1707161447538; Mon, 05 Feb
 2024 11:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32bde0f0-1881-46c9-931a-673be566c61d@linux.dev>
In-Reply-To: <32bde0f0-1881-46c9-931a-673be566c61d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Feb 2024 11:30:35 -0800
Message-ID: <CAEf4BzZ9L9kUz--+K=D7CubSG8xWCxuw1R6tWxFC=93VbZ4ZUw@mail.gmail.com>
Subject: Re: FYI: bpf selftest verif_scale_strobemeta_subprogs failed with
 latest llvm19
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 10:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> The selftest verif_scale_strobemeta_subprogs failed with latest llvm19 co=
mpiler.
> For example,
>
>    $ ./test_progs -n 498
>    ...
>    libbpf: prog 'on_event': BPF program load failed: Permission denied
>    libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>    combined stack size of 4 calls is 544. Too large
>    verification time 1417195 usec
>    stack depth 24+440+0+32

Is it a `struct strobe_map_raw map` in read_map_var()? I think we
should move it to a per-cpu array anyways (not saying we shouldn't fix
Clang regression), in production we've done this already a while ago
:)

>    processed 53561 insns (limit 1000000) max_states_per_insn 18 total_sta=
tes 1457 peak_states 308 mark_read 146
>    -- END PROG LOAD LOG --
>    libbpf: prog 'on_event': failed to load: -13
>    libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
>    scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
>    #498     verif_scale_strobemeta_subprogs:FAIL
>    Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
> The maximum stack size exceeded 512 bytes and caused verification failure=
.
>
> The following llvm patch caused the above regression:
>    https://github.com/llvm/llvm-project/pull/68882
>
> I will do some analysis and try to find a solution to resolve this failur=
e.
>
> Thanks,
>
> Yonghong
>
>

