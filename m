Return-Path: <bpf+bounces-58428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77241ABA53B
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976099E46FF
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EB20B7FE;
	Fri, 16 May 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYGqP0kV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA90224223
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431129; cv=none; b=SnfpCGYv9UNUFN557tG1RQ69/OsLxrhVi76BBR2BJsXIRVusfiin5MNXA9bTN8VmoYBVt8gleAGPzdL96XbGYsnKvAH1tIYxrG6cfdchWFPzuh7xPqv0l0m7/frQAi427k8lhoPG14t6yB1cr/nU6eOev3pfh+CPEX4YgclmXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431129; c=relaxed/simple;
	bh=M/Nn42gofZzT+eNkTl5N7IfZ2BYQkEJxCe9EaccDHho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiylY+c+TcbIG476Z+tZfs45GDzUzY12NTatpO4ZOBQ4s34ZLcdi0x6yg58B71dU/tdL96f28goXXISQBgE0ki1f2ivqqAkwUDDz874jXLcTmSdvCZJNxSZ7qu2k10NfWxcPoej5QJOcqNNcQN2svSGIoJUBgIaf+NJeUXg6RY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYGqP0kV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so1732109f8f.1
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747431126; x=1748035926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/Nn42gofZzT+eNkTl5N7IfZ2BYQkEJxCe9EaccDHho=;
        b=UYGqP0kV+so+CgvqwkOxKuvT56pmzxKs2pUiT7abqhz2IorNzkSvs6whY+oV81/3EH
         MHxsTaBrz7QxyTgTB2HZ/mUPIckUqFMysTUZm48iPbOfNymevFQF9U0PyWEbL07PGx2B
         E7kKGBRjA4KsE+3bcXeFWANSJAXhjCZpEoAeaWCTMiZYPI9wGU8aRagzKuyW5YXvWoiW
         4XRbeujAL0TsYzEEZrL61BvayfiF2SWvgae2zgIt3u3UYFIJ2vUvUwrgNrUOCyxRTN4l
         XoRto9jZZ548N4lCeHcK+zB68HtJ6a6cuHwryc9Kn5YaBhwjrnL2hcxncLP6qWdM12MO
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431126; x=1748035926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/Nn42gofZzT+eNkTl5N7IfZ2BYQkEJxCe9EaccDHho=;
        b=RjJxIy4M8vn5p+MMrrRvneocc1jUoMCqrFWjZpcHtwxgkvA6bdOC3jHpniIrsmxhan
         k+QhyyhBr6XAaKzWEoZobOsMMolF4V1hK8sO1JFLe6i4gH9zzSJ4vE/kzKEIEl9F8+hs
         xUGvL1s250RsMwZSXRLEG2HEoBIrm0hkEq5LdRv7ikAuvRvaEwgJhOCbxztgYSH0lAxg
         sB7TZ+wXOPLsa74dkMdFrtteC2yN4oy8mCfrKF6j2w+7EXA9TLKKZ5XN0UgKTuz3kKSZ
         F63fkE/1tL0vaWdubXo/eseAFOtVySFsrY3mwGm93eYaaVuEsODHM55hAIKSHrqoKfis
         pELw==
X-Gm-Message-State: AOJu0Yxd0ACXYuSsUwV7vVXYB7tLFnX4LnR4DJLEmhlQYZBxcHYDvnGm
	IEbLZhtbCgNTksupJdlOVeokFgkOvBwm11sHYiAzqPJhGQwQCiVexn0ZgX6/jb+jW+sJVf+SA/f
	yugc8YNz7kjlFl2YNlf3jZhb0jCnyYF02bA==
X-Gm-Gg: ASbGncuL8hqXkvJ4MklnpDaAf+oTEZIOUYi7+E+KtkTLPqDLmJqg+0IhjralIMo8o2K
	t4PGaN0aJQqqnb+4VWsPC0SpAeJq/24+lrIQTxAVIkldTF168TN1h2T3ooAit2qRecPuBjXhtXB
	OYKHwU3t4O+AudGJ+oK2XhRoGjmjVkoqVSe+iVYp+KjvXvwbVcIZNg3IxwPwBUnA==
X-Google-Smtp-Source: AGHT+IFWBkyaUeOm7m0JK3n9oJWpdDxSzX+tpu4zW0IT8Y7OWsF4kCuGNkuMYrzd06wI/b4R6kNTYbxC9iNFje40fHc=
X-Received: by 2002:a5d:59ad:0:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a35c83b644mr5187212f8f.28.1747431125682; Fri, 16 May 2025
 14:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
 <CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBtS_xOs5w-LSq+p74g@mail.gmail.com> <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev>
In-Reply-To: <1742bbe7-7f7a-4eef-a0a9-feb2cda50bbd@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 May 2025 14:31:54 -0700
X-Gm-Features: AX0GCFsvct6zuTnvGnkKZ2403wgoMNFsk6EEuUNmAfM4_bKsUxleJUvquEApXD0
Message-ID: <CAADnVQJurPs_e3Lx9O7qZ+=HPk7XarXoGXeTiARbw8bW+-txGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Warn with new bpf_unreachable()
 kfunc maybe due to uninitialized var
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 2:17=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> So I then decided to add an 'exit' insn after bpf_unreachable() in llvm.
> See latest https://github.com/llvm/llvm-project/pull/131731 (commit #2).
> So we won't have any control flow issues in code. With newer llvm change,

That's a good idea. Certainly better than special case this 'noreturn'
semantic in the verifier.

