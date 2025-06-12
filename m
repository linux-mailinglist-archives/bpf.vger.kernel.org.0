Return-Path: <bpf+bounces-60445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA8AD676F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0183A9A59
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD71F1538;
	Thu, 12 Jun 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqMoceN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F111F1313
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706901; cv=none; b=d5wwnC02Vj/d5/TUJgOOBFF6zua7ppwdbtQSZC18yeyXamTF395HiqcLQ95cz3eh2HZbgzjpjPIn5v+ZxM0CSu7Sn0WPvCHqZE0Jzb+jW/2VoU+u1X9/9669x9LzL6/fZXqs7eGA/zidf4t/63YU75Oo5gucTocgJQn2zHVBBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706901; c=relaxed/simple;
	bh=FlKSP0VcAJyGDGVB6iQBZG5yCj9/zrAUOb1YB/alcwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqhYqx9AvAvkr3AM8A5LhpyP0MDtegxEhIa+723aIf/lk5Hx914Ju4XzeXIoQjWC7G1pFCMO7Q6Eqvbtu/ZxuOfqBcFjRwKMsKq1T99rltuNlRKrAWkhgwZ+jDG9waAG1HkfLSWYpKLOkXpswg75ZfRd9jtnCdMayRgeri8vprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqMoceN7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5257748e1so404822f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 22:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749706898; x=1750311698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Lxw8WHXE87DxpuIDhIlmEn+yVhdV0OK+hmCPA4nHE=;
        b=DqMoceN7MJ9hLtLlLXWOvh2C+jTsKFYRy6PPVQVqXOq0fkI+cfBrMKi7VuiXXyyvgE
         iHv6/J88Dr4BFCVeMmhovga6BQwayWkv9Ihcoz4hx/nqQxc2wwTaLD9/yTTkE6Sj/BtM
         TViZNm19+Rw90gJrjSTpbCsnPIGFY1IW9XMrQALQdsTvAZSVwoe56335o2R1lSecc233
         jWlYGpiNxHee7ghhEfIx2CE7ueheYZCFLBLpwfEbpbbdEspCZw/PXnbwovDeFpkCNGIK
         Wy3RenUNL7BNxErnICYqMtaNmavBwsaUKf1WwHx/Mnz56N6MiyIMfIuS+4NJy8BG98QY
         rnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749706898; x=1750311698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91Lxw8WHXE87DxpuIDhIlmEn+yVhdV0OK+hmCPA4nHE=;
        b=duj5hKHWjioRVPusmsjXi6YXafd6K5kMsJmGOT/DXp3CYeubLGXYAd5yNCtxSC15KU
         HvWR5k18ARk+nHZw5KIZ6ciUvnlzg0f08SeOKZtpwsuoozTIosmUvlJR5xWtKq0m95Tc
         Jrydx2zBkgnQU1GZXYqBoRJ2GVq+CkzPlhrJNGwUUQxoENz1B75+Ho+pVbINKsVVu+/r
         Q0CCjV0ZbzWElVjAIkuYAlyxRX654ZNs+AMBGwpHsknJFNx+G3Sc31QTcrCc/DuTUVVv
         La2vGHSF2XXzXIMLkaEgAjNfMasatPwYzWLVB+8s1RrXmPsgDRuvzc63rT8Hy5ggFExN
         bN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8fCNQplGCzb9voGlNv+TVPwqJOIX9/rb5x1jfaV2eO5HzZzm2e1V8h5Jr9jtTOBAjJlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1H49T0lGiwOySm4zaVUi7FOVVefLKC9yd4t9UJTeZdYa/6kI
	CQgGXFjpQLxhpY9BP8832xpGLWyYlM8DjHOfZ4jpFnnfM2HoriEfUL9o8kkRd+Ms+3D+qX8fIAi
	BtL+TsYnqNeq2+Q8tYRNhds5kvTBIa77qXg==
X-Gm-Gg: ASbGncvel50YKB6Wcbf8bQSLR3bW7a12gNCfcgwypylljVK4OREog1MZvh2bc4GFkQj
	5S+HkRrXyWJN8UgZu9a4RTaiHV3Jy+hmzqKA+EeoorKlHxEW9jlfcahozCmV5SfBTrGg86RqWR5
	i9oXpjTtfLbDHJakVyBbDIXMHOPciR2HMGwaI68D2Om4JFwg/tdpTeC1qgVZIX7lvKgyLDPSzp
X-Google-Smtp-Source: AGHT+IGBWq3heoXHGLq6cJXFuMYW+Zv5P9++zWYihfyOxI30j98QCQh8/ZkB3ptSFRdmKAlpiPBv+3oTSXq+627atOc=
X-Received: by 2002:a05:6000:2085:b0:3a4:ea7e:4634 with SMTP id
 ffacd0b85a97d-3a5612f0dc6mr1203580f8f.10.1749706897814; Wed, 11 Jun 2025
 22:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d602ae87-8bed-1633-d5b6-41c5bd8bbcdc@loongson.cn>
In-Reply-To: <d602ae87-8bed-1633-d5b6-41c5bd8bbcdc@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 22:41:26 -0700
X-Gm-Features: AX0GCFtf8nGQ1cY4AMPBqajr_eQr-IVI5oIVPMkHK09zzmvQ6CHEAQUXSLRZiQQ
Message-ID: <CAADnVQ+jU3NZiHH1PE3sHq7QysffxteULQUZxri4PX9dWK_xxw@mail.gmail.com>
Subject: Re: [Build Error Report] Implicit Function declaration for bpf-next tree
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:52=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> There exists the following build error for bpf-next tree on LoongArch:
>
>    CC      drivers/acpi/numa/srat.o
> drivers/acpi/numa/srat.c: In function =E2=80=98acpi_parse_cfmws=E2=80=99:
> drivers/acpi/numa/srat.c:467:13: error: implicit declaration of function
> =E2=80=98numa_add_reserved_memblk=E2=80=99 [-Wimplicit-function-declarati=
on]
>    467 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:203: drivers/acpi/numa/srat.o] Error=
 1
> make[4]: *** [scripts/Makefile.build:470: drivers/acpi/numa] Error 2
> make[3]: *** [scripts/Makefile.build:470: drivers/acpi] Error 2
> make[2]: *** [scripts/Makefile.build:470: drivers] Error 2
>
> This is because the following two commits are not in bpf-next tree:
>
>    commit 9559d5806319 ("LoongArch: Increase max supported CPUs up to 204=
8")
>    commit a24f2fb70cb6 ("LoongArch: Introduce the numa_memblks conversion=
")
>
> Is it possible to update bpf-next tree based on 6.16-rc1 or at least
> apply the above two commits to avoid the build error?

perf_event-s are broken in Linus's tree. There is a fix in tip.git.
We're waiting for the fix to land through.
Then we will merge perf_event fix and all other fixes into bpf and bpf-next=
.
Hopefully in a day or two.

