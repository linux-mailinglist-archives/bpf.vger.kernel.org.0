Return-Path: <bpf+bounces-50087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4385A22758
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F413A3981
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDB182BC;
	Thu, 30 Jan 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9bMUtUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0547482
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198450; cv=none; b=RGa90hG0BhEgyggx/Ckzy3Vft2FVhrrNn7v1ygB+sI3v0rHCIfEMVa8ZuKaSTSvuxkH1NFG8xgh4CwS7MXe6gaaavXw6thPDE7Wr3tvkPlTcAH4zhp3mcClRz854se05pZEgwWbQqo51L5iNk2s5XxAEidzDx6bP5rX1jlAC7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198450; c=relaxed/simple;
	bh=iAtJTU92MnDiRlu74jBo3Jthapsj0P4EQtYv39B6I0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbiLeP8mzGw+H+6KREyzY9O4HBoSuFmhPzMyKwbQLbl8Ut/eNU5Efs+DQ3jw8rUXJFVZAJyZ2MbFFCMKrTU0BRhjKoHr75keKYCm+kl9dP4UByQ5EVDLvJERj43LiDCco4/X9+gY15G1v/GZ44sVUt0dshv8xQjduX+h2ItKCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9bMUtUo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so120252f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738198447; x=1738803247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72JoaOAIxiFEEkcXBAjJ6H5RaF5TUObKLM9qdY59p8s=;
        b=f9bMUtUoq3yVpUwSb9ymEL4koulPbrQiI+SrMxrgNZBQF5pxOa3ykl01foZymLzXct
         jq6ZKGPiDCI7rEOP4QZOBGNmyjHAF2P8w1ZUg4IpjR+Eo2C21K8VBGtNJ76bUIpWmOOP
         sh/p315B5eJeml32CVYaukPl5Brw886nXOfSYT6/INC5rNeBEVUPTc+BwwrXNXPdKMZA
         ERmvmcvWSLg8V0VXYQYoZQSfBNDHp4Jjrw+0mX8+FvuWM5Da6u3C+AK5L4DJRmFyrVau
         6lOFbQhsRDwan9JpcJ9OsGhUNuO8UuIo3n3qAiHGXDa20aPKLNL9HEuuLHVyK/JfjP3G
         Gj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738198447; x=1738803247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72JoaOAIxiFEEkcXBAjJ6H5RaF5TUObKLM9qdY59p8s=;
        b=iFti7OWhMjLV18aNsqdxP9ycvbqKfTmf5kGL5hOq8seiAm5qI7vtFCWItI5cgA+iTx
         nEKgEdMu3pS7BgXhKKuHaa3L1QxHTpUG0DJzAMZfhYH8siJAf0S63yI+hHFZmrN5Ap8W
         ylqeU9VlQU7109UCmOkUGtfvaKhkayAuQB2ViNYctMaBPfvAHgS9gYNWAto/6ijujRGf
         nqxYu3g3Hx40kAdcC67ajRSIvi2Hhc6ssLUT141unIo8LkH+8VxIhPnJDW1S+ps6bhLg
         Yqnm/cBWGJzLIe2lAttxcxhhlWeH0wuS/afRqJDeBXxxEEG7pfx0w1Jwt3ucdXTaj74J
         tEEw==
X-Forwarded-Encrypted: i=1; AJvYcCV6y6Z2aihM1lfRPrLt9ueyQJqcNqrMugu8hlicLJHivEqzCSnGQCZYvxinH6VpxWf9Z5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQvNGFDG4B1Qbi0RJuKvpWCi5CwBOXz5WmZplbHFnApU7VK/m
	RG++5/zDretWx8C5KxyeXaOukByrHQ/Os8UD2YQN6f2g4uHDVqwYWQ08z3XxwkrAPGSchquMQIS
	OHMrZUVgsbFI1+yq7qOUu+t5ZGOu7ru1E
X-Gm-Gg: ASbGncvTLKYJ5FetW/ug0WfGqwRgiNT4jlN+T1d30zGRL0MYFZBfWiJGcyY8tabLbqq
	FIHG5x1VDPJ6uTOSW0EbQct43CVfQmAR2pDvJrZGlS1V+AG0StnlCWFYJD35sVj6Xivx4ZXH6Jr
	x8DdyTJsFkm4NpVKX8Fq3MxPa7eXzI
X-Google-Smtp-Source: AGHT+IHKATYhSehRnXa8c5MNH5ecqyLXPQ48/NRKsR+rTSaZtkPDStbrNIlTRorxD6AK5ATmoYORiDavRArlF/NwsDM=
X-Received: by 2002:a5d:47c8:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38c51930cfdmr4188949f8f.1.1738198446796; Wed, 29 Jan 2025
 16:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eac5f55f-8aeb-4a6d-9aca-820c5ad4c3a7@linux.dev>
In-Reply-To: <eac5f55f-8aeb-4a6d-9aca-820c5ad4c3a7@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 16:53:55 -0800
X-Gm-Features: AWEUYZllKPgiR4uW7aB6o9CPG77cl1pq1X9-_-FM9-JQp4PJMG9Aw-7O-j_Mg0g
Message-ID: <CAADnVQKmi0+_=BMLXXyv5YaUrfDoHVb+zW1Ns6mx40wYLH83Zw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Uninitialized Variable In BPF Programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	=?UTF-8?B?TWFyYyBTdcOxw6k=?= <marc.sune@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 1:42=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> If bpf program has an uninitialized variable, clang compiler
> may take advantage of it to do some optimization. The resulted
> bpf program may still survive verification but get wrong result.
> Users then may take quite some time to understand the real
> reason by inspecting asm codes.
>
> The compiler flags '-Wall -Werror' are supposed to issue errors
> if an uninitialized variable impacts the final result. But in
> reality, since compiler may not be 100% sure a variable is
> uninitalized due to limited analysis, the error may not be emitted.
> gcc has '-Wmaybe-uninitialized' flag to issue warnings for some
> possible uninit variables but still may miss some others.
> clang does not support '-Wmaybe-uninitialized' flag.
>
> There are already some discussion in llvm community for this ([1]).
> I would like to elaborate more with some examples, e.g. how llvm
> internal handle uninit variables, and discuss how we could do
> something to expose harmful uninit variable earlier.
>
>    [1] https://discourse.llvm.org/t/detect-undefined-behavior-due-to-unin=
itialized-variables-in-bpf-programs/84116?u=3Dyonghong-song
>

Compilers maliciously making advantage of unint vars is a tip
of the iceberg. They do equally nasty "optimizations" for all
undefined things. It's a real issue for all backends.
We can experiment -ftrivial-auto-var-init=3Dzero and/or
introduce similar workarounds.
The problem is clearly not limited to bpf.

But the main concern is that this discussion cannot happen without
llvm and gcc involvement, but only gcc folks might be present at lsfmm.

We also still have an issue of missing suffixes when llvm optimizes
funcs, compilers doing things that messes with the verifier,
gcc is still missing decl_tag support, etc.

I suggest to fold the status update (not a discussion) into one
slot that will cover all outstanding gcc and llvm issues.

