Return-Path: <bpf+bounces-23232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831786EDDA
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B57287031
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B3613A;
	Sat,  2 Mar 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtyknoB2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F21C33
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342922; cv=none; b=U3HDMbARVCXkmhWNgR0YFSS0TfgKYAfSXENO9awLduNDOBVCBqXzMjAK+MVFv7TIznTnGCv4YfCSQRPaqnhEJ4dpTmk/o408fesSSbWC5wKqhSbMHsq228vnTPFRzCXaWR/x9ItOQURnDM1DMW3a9RNEQFGqGJ9F5NZ3/MLwCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342922; c=relaxed/simple;
	bh=25L8DXgHOAdbKGnQdtVdqRu1Y3k46jO2nPZ7liWcwf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYSIv5ps4Z6iSVsoCZ97dDSYXq4X2RoNxpHon3wccmJ3dH96QePjYo9vCScBpRLRcZ/gob35lJxZ6pYO1EDN4LabnfuwJBcTGdiHhV/AXUfodGRbCq4U3TKOAGb0RyGVsjpj3LWtHNflzzGydwVDx2sSjYOsoHam/0CtDBIGbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtyknoB2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so22832895e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342920; x=1709947720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY07d7VMzj7Rpjokf82yWG3N7n1RJ8q0ZSliiKnZQKI=;
        b=NtyknoB2GTF67KA8Kzc94M85jbtaLRn8bZJsqzgexCPDYsoJbll+pOl0nqDwiO5osi
         WJDvmPpOxCSDuPpSL6W0uia/NcCcIxUYNKaISkaHvy5McLQJkFtuPxkcRixDwpgQzlZB
         DoWjJzldg9CwbS/7Z0Im/qvpVkOAYP/rDwbgKdhVTBg16Qj0NEta+UnlSf9+kjgtJL6a
         XuEUdtS/cZu1ABmTW1vRacHWa3MYCzRpKwGgJ/tL5yHCX9MYCTt6PY0DzopRZxrivBFI
         Vz/jX7caW9RpnlgYIZCC4uloFBsbIDxygAjRCUB/mlQVdSPTe5q9AjPyB3RxIPPQE0VF
         YJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342920; x=1709947720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY07d7VMzj7Rpjokf82yWG3N7n1RJ8q0ZSliiKnZQKI=;
        b=PRxKZIR7s/lFr17K+0Y+qc/gZ9Pvw/00L8eZLAepkvQgHFo0Eq2bD5+XfVfclPp9gZ
         qwO9Z2jMpI1Kn7MWI3yrlVUDgIlhpZFWmsjknAbA25hI3PrOA2sAwU6fCX+9pkWOn9Nd
         hdevwAwEoRM2wHI8PU5d8qTjfUZkaFYo128+h17emub7V5Q+4FL27uP4A0aEKBfbh0IJ
         rseDdI0Hb0v5GXj/DeSsHY6/taT/uigSeNhC4J7crXpQwAXo01HFIe76dndF1v+0n9Vd
         TyXhxMOhGp+i3RTCUQh5Zik1HnL1u7zgtIkw1oNc0JS4pSamj7rDkqwM7h8KrDdPijAU
         bQuA==
X-Gm-Message-State: AOJu0Yx1uB6gKmY0coAPvO6K2UnVqiWzRSz5P1JXpSTVeAw+Fo09iBRY
	y04cYZK8aiI27UM4Drt5jAm2EH8DL6BnwKPCoIUDI9+IsIaYAl4L0DzUn6pdHXKXdXk0NDmIg/j
	wtp9r4UHuw+2vPHumG7RJz5WK5DJS842p
X-Google-Smtp-Source: AGHT+IFXF4n7DluFSYAAukySVf3O9HM0AtXs5j3M+FoCszTzTD9YQ1BVfU4Tx6luk4RnfGLBjBYUU2V3OvFoc0lCK5g=
X-Received: by 2002:adf:a4c7:0:b0:33d:9d49:cfe2 with SMTP id
 h7-20020adfa4c7000000b0033d9d49cfe2mr3638836wrb.21.1709342919541; Fri, 01 Mar
 2024 17:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com> <3c98f93bb3f0520d01d764ac4d89c66e50cbe633.camel@gmail.com>
In-Reply-To: <3c98f93bb3f0520d01d764ac4d89c66e50cbe633.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 17:28:28 -0800
Message-ID: <CAADnVQ+3+HV_FxOGB5PpUoe_f2m_hPxL7=RZmpKnWF5KGT8Sjg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: Introduce may_goto and cond_break
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-02-29 at 19:37 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > v2 -> v3: Major change
> > - drop bpf_can_loop() kfunc and introduce may_goto instruction instead
> >   kfunc is a function call while may_goto doesn't consume any registers
> >   and LLVM can produce much better code due to less register pressure.
> > - instead of counting from zero to BPF_MAX_LOOPS start from it instead
> >   and break out of the loop when count reaches zero
> > - use may_goto instruction in cond_break macro
> > - recognize that 'exact' state comparison doesn't need to be truly exac=
t.
> >   regsafe() should ignore precision and liveness marks, but range_withi=
n
> >   logic is safe to use while evaluating open coded iterators.
>
> Sorry for the delay, I will look through this patch-set over the weekend.

I fixed the drain issue reported by John,
fixed no_alu32, and will resubmit soon.
Ignore this set.

