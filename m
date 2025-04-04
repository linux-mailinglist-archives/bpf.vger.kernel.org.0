Return-Path: <bpf+bounces-55335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A138A7C0DA
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BDF7A71CD
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513211F5853;
	Fri,  4 Apr 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7rYvQdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B171F584D
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781486; cv=none; b=ZIp6oaDJEMYEyumjv8AjPPM8LFpGkS6rUULnlaSYzji1WgOBhH8DAA9PnYhCU1MFWpcR5G1V2G4Ii8+fHXSgq8IpeuFfOw0l2RL3z44114xLqKzVdj2AEBAMBa7qnNUH7V01aQcd7fnSXm+ACkBO9gDKdER6UUM4S4CgoNo3HyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781486; c=relaxed/simple;
	bh=ybaPPMHo6kBiwqh5QCyewCW7k/ZL6v9pkqY3urqBKeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3CxbkxT/psS4r3YkTfreK36fpK4HRBCRKIfIjfXwYYaRVYTRHyjCN6vAmXF0ycjqLe8BXxgb+pWbGhH1ytyfN7pSQuGtYEP9GtsnMj6SyIy4SI97L77bW6DifBWMUAYn/nwpCQaX2/5ThDrvqerIsfiRvDZc7GaIN6YchTdfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7rYvQdn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1efc457bso1357841f8f.2
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743781482; x=1744386282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL2JECqcuBAjhqPAWlPvTWT7FE7nQ91JGyQQbLlELEM=;
        b=R7rYvQdnLqFkaBUIktHK0w2AeS+/bbHF4frCEtO3b2S/o1bPn3YQDqCV3+rymjl19J
         hMF66L/N/TxNMXXxmdPdbLyNbQB1BCsEW/TAyjXhnbIwFRbpInoQQbN3aRQbFstEvcnx
         txEejtz8FZZaXTu88BA7Q54kRL1Ky9MGmL1dz5Q+snBvLJOX1WnLYiXBE2yhkrkCkxtw
         eGNB+hxTw4/Y6p/89CxqxgPS2L9il9StNHZom1M39qmnr6orHlM68qwZv44GZp0LNrB/
         fqdFiffp/u8cOZH5sn6Zp2i55IW4+Jde0baEbRogz3Q8h99EbM9OxImfIOV89mdoqJsB
         Xu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743781482; x=1744386282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL2JECqcuBAjhqPAWlPvTWT7FE7nQ91JGyQQbLlELEM=;
        b=aPbMvVqgs9dofsRx6UmX+ETpYKB87JLwNGqPb2JGjIhYXBzrJVsuBQ7zfWD6rQemUq
         pWbFneG+q/RF+gbw3jw4/NSzhCPhZihHngIUM2f3i8OL9Ac8/HeCYLk8QX+xawsonb1N
         xFh43eejSTuZoLs8N04uQ8DfQZYwX60IidW8ShlgHuhO1yZ49nXUZLzm7kGRMyz5/4tU
         guPhI9+nORp/d6+u0nnv3Kh7EBQxvK9WhrLyFNR3v2nT9b4rsR4XEmR4CCO7UgYABe+O
         66tuWWlu1xXhLxVLv+MumQGh1/Xr7QOz9yERAdtAs9Mc4EZyCQQ75CkO773AvZmHzjUc
         Y07A==
X-Gm-Message-State: AOJu0YztP6JeUfmSiX6x619izRyG2mk5WbdmSTi96FAcsARL22lpVIXG
	QuI2go5TDEdvR4fx8KDhNai+EoN9636MzH0Iw553xROo/io86uzcK1OT+6rLuRVFo70eukweB4F
	tSq1//mL4W9vYpwjdadlss+Hg8v0=
X-Gm-Gg: ASbGncvq47EALSreLIxcu60/mrAvlH/pHho3CrM3prlGxZTVIte+rqooVaiQiJTLl0S
	YkVPoJlCywvGsQwYtyG6BtnDe2cjRazz5jpdevfvrd1TQ7Y+/QJfNJQcijdNgqV+/5HM31k7q3Z
	1s8uyQkff9UWP3iyIx2L+Szt0UJvg6Kb4T1iuHfJ8wCq/ApWRHvqGP
X-Google-Smtp-Source: AGHT+IGHrWzpf80GSBBjFVjN+Wtv5V01DRd/+PO+0jlqsSmt8jmc8vXfATqlGToPHqiTv82/HPeJusSxH1wYhBo8v1Q=
X-Received: by 2002:a5d:648d:0:b0:392:c64:9aef with SMTP id
 ffacd0b85a97d-39cb3596df3mr3481344f8f.20.1743781482219; Fri, 04 Apr 2025
 08:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404030227.2690759-1-ameryhung@gmail.com>
In-Reply-To: <20250404030227.2690759-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Apr 2025 08:44:30 -0700
X-Gm-Features: ATxdqUHECZxe6RCKhfzemunyBwnEmZoINVElt1bNXdChATA74x9uI3ksZw5KXpM
Message-ID: <CAADnVQLJCaDq+KFOQ1Rzm0fuRQRn7f4qidMZKcuSqg0r7Yau+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] uptr KV store
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:02=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>
> Changelog:
> v1 -> v2
> - Miscellaneous bug fixes
> - Fix workarounds in bpf APIs
> - Reduce 8 x 4K data pages to just one to save lookup time
> - Only use dynptr for reading/writing value size other than 1, 4, 8
> - Introduce kv_pairs, a list of key-value pairs, for initializing and
>   updating kv_store
> - Allocate just enough memory for metadata/data if kv_pairs is provided.
>   Otherwise, create a 16-key, 256-byte value storage kv_store
> - Change the second example to show how to manage kv_store from the
>   user space

Hmm.
As we discussed at lsfmm the patch 1 is still wrong.

The rest is imo no go. If sched-ext people want to kill
their performance this way it's their call. I still think it's
a wrong path to take.

> make rolling out a new bpf program with changes to map
> value layouts easier

That was brought up at lsfmm as well.
The approach doesn't actually do what it claims.

The idea of patch 1 is salvagable with extra work on the verifier side.
The rest is not.

