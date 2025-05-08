Return-Path: <bpf+bounces-57791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2EDAB02B9
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3698F7B98F7
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75C284677;
	Thu,  8 May 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNGCZlW1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628401990A7
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728933; cv=none; b=i4bpoKPHGeft/qB98bgEATsfA3ZRR7kZqRgDUUy/x6XklvAKTJlbk6f9qlL2dyYNnAzq4G3qRLAo5HipT45uMVlwk/sSJZEnGwA4zq2BQzBo2Nfj3BC+6mBFtQThuA20QXkAEpypt+zVOZdxhnEzrhEuurHmb1njdeRAxRv1IFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728933; c=relaxed/simple;
	bh=dpIXhJIu/+Nt4o4jAUBzKtQOKOvwKOixSSV3TLMMDd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRe9hpj4DSE3bFI0hUoRGlDMdnZraelBAS0o1gSXnkOLEQNCc78OG2ZZdMP4sc+3TJPrWOLmVyZrQ2ctV6qw29LFWreuN6BgJGkQlGsu1heNB0kRKc16VTTrfxtrf+rRPh5zIheLovxybBSm5q3mPNyDfs6ga+jy9VJIIKLMwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNGCZlW1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so763715f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746728929; x=1747333729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QnquOGNr+qDoT5eCu2zr3h74x6bLM4R2gRt5w/HxdE=;
        b=TNGCZlW13+E5VrcxftseP7k2mCIl9gIfp1tv7UL91B7jwg+dO86km+aV1lxZ3FF5u4
         1DwnXFyZH+PytprRAn8deNkqaJ9Z1qAZX9HBLFvWycJf0flPGd7caLdwA1X5PnUPvayl
         sr7W6xGi8/bemw5qeGUsYth4lBC1AepRGSx/2YU77ZKIzuNbIKtNGEngKqp7uwhFxNRy
         2lywslmSMCrEMY/41crCBPibzxtAUa4nDB3yT5P4/rqFzd+pwFFLsmlJHxX83FGN2lEy
         kDY+QF2DoTrMKnteB1WaG9pdz8iF8VBqbxv3fDJ/G0HjI2aBCsl73OwRK0glkENyk8v6
         hurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728929; x=1747333729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QnquOGNr+qDoT5eCu2zr3h74x6bLM4R2gRt5w/HxdE=;
        b=HPOc5fnGFnjLgzp8ZshejDfpHdO7O4XRQKnPJZl+EJPExKoVO1S/3lvVuGjBqDww5k
         VGK4rAHrc6KRr3AS+83wTrhq3G8llC109u8V2dGys5m36PMeHUXRXDBGDhfWtsEPosMo
         Xjqzf9hQ9n8u1LZqRHIO6iX9komGafaKckAVDVBDs5dgAGoSUji9i1D8TLYbQ90icxRp
         tVf2TA0gEAYY6AMhi0zdmJ8njLPW4sE0VC+wS0u2IuPTbk0cNK5sR51+O5O5KWmfkzD4
         bRiOnNWIOvF/gWv2HlD56kkvaMOFBrj35P6+jys+PQXs+eCe6XXQVcAdJ9YV+fNgMBDp
         SbYw==
X-Gm-Message-State: AOJu0YxRLZnA5Q/kIw0Aoi5XCC5Zx0fzyfilXQYtHk2w7k5AgGMx6eiF
	DyH3es/ySHin5SZPRPBh47dcwNvOcpBjHGBrTL0QYu2EeNg7izItj3RH/fJRVud+aK07qU0k3nr
	L/I1JDDjJyZmEu746+le/Tws2V8c=
X-Gm-Gg: ASbGncsfKbLaZyCaZEhhI65J4D+kCEaZ6ZJYZwA4oNgdjJ3j9VXTYUu5djug1dZrqpS
	NMcIxYGRKjzBxrh1B+T1/UyP+ci2dbP9FS3xuHB1VpqejtS9TQhneWUd9qJaYXBlf0nBTaPmOUw
	i3Tzw6pHVbHQGqw+oCTGscHheFAfBqE8lIwzNB/w==
X-Google-Smtp-Source: AGHT+IGayMp0Xys+bIBXlZ85qAaJe5sr9jFzrFqi1pmTZieJqvflEfE+/5mtmchnsbyM2CCYRNBtIalZL8VJD7KnZhU=
X-Received: by 2002:a05:6000:22c1:b0:3a1:3543:a749 with SMTP id
 ffacd0b85a97d-3a1f647ce71mr401892f8f.19.1746728929298; Thu, 08 May 2025
 11:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com> <20250508172607.158382-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250508172607.158382-4-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 11:28:37 -0700
X-Gm-Features: ATxdqUHcTCbcP8obYAifnUnw8Ubc3OFJeuZNg1ExZwOmGEYRDG9hYzc8oC2Q-gc
Message-ID: <CAADnVQJxjji_3f6QiKiUwi2Rf96K9cU90kG81dv5nPvGK2VeRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int test_copy_from_user_dynptr(void *ctx)
> +{
> +       test_dynptr_probe(user_ptr, bpf_copy_from_user_dynptr);
> +       return 0;
> +}
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int test_copy_from_user_str_dynptr(void *ctx)
> +{
> +       test_dynptr_probe_str(user_ptr, bpf_copy_from_user_str_dynptr);
> +       return 0;
> +}

...
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int test_copy_from_user_task_dynptr(void *ctx)
> +{
> +       test_dynptr_probe(user_ptr, bpf_copy_data_from_user_task);
> +       return 0;
> +}
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +int test_copy_from_user_task_str_dynptr(void *ctx)
> +{
> +       test_dynptr_probe_str(user_ptr, bpf_copy_data_from_user_task_str)=
;
> +       return 0;
> +}

you probably need pid filtering here.
Otherwise in test_progs -j case these progs might trigger
before test_progs had a chance to setup:
+       skel->bss->user_ptr =3D user_data;
+       skel->data->test_len[0] =3D sizeof(user_data);

Or use syscall prog type instead.

pw-bot: cr

