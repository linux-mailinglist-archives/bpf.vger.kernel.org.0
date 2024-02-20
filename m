Return-Path: <bpf+bounces-22329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5F85C2C2
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 18:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E04B21639
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E477620;
	Tue, 20 Feb 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf6j3JbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA79763F6
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450445; cv=none; b=Kwdf3hhMiGHH9Nx/kJn0etPftyit5MtrT6Nc9iTei7vUC9LI1lm0y25RKftGV33d+XA4q4DoSluhdjZ8Il6o8Z5KzWA4nnb7SxxsMH/bHBajXNfobUZ3qJUrUbDEQGDd/6yEx+g9TYM5MA5NlA+WSOZdH+ndRsgIpNBMFQFsJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450445; c=relaxed/simple;
	bh=6lXSrF5UAZanGRds9Z8pRkvw1aWBUg+HG+k5uGseyhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7lKy+iC+SLj4CJtXsRQ6MjcRbYSJxzYRik7rLzcyxrqfpmj704sY+fBGRYUDukBExgYwyoIb/MH9Po1HfkYKupX4hYjYYyVoJBQaMP1sx+s3qBt7ZU8tY1vHWTXbhMYu+xiJGq//BmFuyZmoEgn6Ta8qX5mxMRk+rhO7LeatrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf6j3JbF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso623231f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450442; x=1709055242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hq9MJRpGB31gWNRU1/tgciKdKYPK8sgYljgF0LN4Xg=;
        b=gf6j3JbFG9ALpbXPpcJFFrJp9v6m+SK+yuVl0P3F3SWbfHY5DhvGX2IXoUk8TAH9xI
         AiwtpxfJfnjVYYcNI9aF5Wnho58PplM6XcMZiXL/F/X8cl4A2Y8bHZFXPQiL2501PmA+
         RhI43ZfNV34X/T92IoWSCACjJ6bbJyzZZ+BwzYBCvi0GyKOVCOozTOpJSfbvklMUxphj
         yJtpQamZZCQinLDowDoM3igmcMDBlcpoabI2foy48ftLu2FpEz6sUu1kW1kdNi50TKe8
         5jDl5+DJiLd7524aBn20B8fxHRPGnOpLNmnAOPHqdO7nL/qH1oHgpwV5yQFvBdTFF+S3
         7cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450442; x=1709055242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hq9MJRpGB31gWNRU1/tgciKdKYPK8sgYljgF0LN4Xg=;
        b=C5dNrpfXnzth45nNEmqbIgKfv8/U8f09tPOeRXB0f0xbij/6P295tOb9sJ93rRO+aJ
         wrzj9axoK5QpeUOVS9r6uzBVXTGEYqGwOeh+69s8TihnDl9oT6Glh94rib0TSDx8nIj4
         m3gjKFs/JNU+p+bGmhQUAdMQdqOXE7jwVN0MA5AbXVjYvXJLt/Sn9IpQR/Og+JCZ9bue
         oaXWrgtKRdvVlOzO0dt3fJMay2YImaMnPpc80lNPkd8SVc3eiOqQBd+JIFs04mRNtiEe
         Yqz6UA4htmDMJUlsRhbr8+7M5kOMPHi8dgjNwDCHJOA+Qq2eFnrMY5C7s4X3VzUdv8GU
         lxwQ==
X-Gm-Message-State: AOJu0YxMU+470EYlGF5TY7nZ1qsYtcqoVP+ezFvgMgZyX9DWne5y4Kjp
	rTt2XvI+0QWyRxQPiuetmIk32viVll44abMu75bW4d3Fw6ECUDPkNrq8O8ULVuMkV8RfADHlQmz
	aihAhuQMgpQdgZZ4vSOka61s4Cak=
X-Google-Smtp-Source: AGHT+IFPh/UlvwCHYlARFJSldBoBUhup0E9HeMBnNuMz+bGHXeB/IpqDNh6aL2UEjO1IfuFwFzFzGt+Vo9A+6RhJBAM=
X-Received: by 2002:adf:fc88:0:b0:33d:3fd4:9334 with SMTP id
 g8-20020adffc88000000b0033d3fd49334mr6429579wrr.18.1708450441930; Tue, 20 Feb
 2024 09:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com> <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com> <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
 <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
In-Reply-To: <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 09:33:50 -0800
Message-ID: <CAADnVQJopb=p-w-RtrDPfNUePjtOO1QtMDEq0DW3nbG7nPL7wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 5:43=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> Finally, here's the diff against latest bpf-next with asm to handle
> percpu tail_call_cnt:

It is not against bpf-next.

>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)

There is no such thing in bpf-next.

Please make a proper patch post following the rules in
Documentation/bpf/bpf_devel_QA.rst

