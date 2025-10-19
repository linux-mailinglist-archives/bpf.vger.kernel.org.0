Return-Path: <bpf+bounces-71286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF0BEDD8E
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 03:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA14E22DC
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51061D7999;
	Sun, 19 Oct 2025 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdkn+IRa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100C18859B
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760836397; cv=none; b=oNnR00gqb3/JyY8vMMIX8BRg2NXIrN0k7eoq+enmVpDR/FzRQTqWa/EHZkReaJY8Kq3BhC3ffGsEhdpqWd2/XvCpyl4kQi0jpzqGghd3+04WL9ZWzrKUV/hlzN5h49V3+DJjPR/mvkFzblo4Lv9f25xPETpOZGGu93s4FgZrmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760836397; c=relaxed/simple;
	bh=ycN16ZdUR12Rz3CMFIwbo64D8uYdImlK23EKVoR2q9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouRzfR+fMoWyNzfXl5+Ijny4Af5e7tv7yD/pxTxmnHSFCQzszek+ek3yr1X9c0M7xuGD4PpvoKwh7scTw7Kr1KCWPacNhaSjkQEcbLGdR341xYiiqlnjQ6niJLDrKHXGkAIbENVm/ttNnw8FudZxOFh8C4etJ7f2F2r3PQoZ0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdkn+IRa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso2967302f8f.1
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760836394; x=1761441194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqCffS0MkdcG/B0C2qwy945tPaz5iAMXW2RAM//wKK8=;
        b=bdkn+IRaRaQYdajdRTpustDdqDUjytIXfLK6nPkqg5Wtc/hxZTZlPIj8RyIylt8lPK
         R/L8tyJl48iRrn1axZxByFvx1FbqNyTjhOqSN/xt0MZd3VjgCwg+bgGyhOq+PAG0A83A
         HuS/cUYyHa8ysEmxm2qBdaQV9JmVqlGrysKZdat7EU86y5CZZx2rmLdZ5ADVZIYMWcna
         z1eBrkR6zR/+mc5bNBWiQ1iiFZxuPjFh2lMPOLsOJLT3MfWFTJN7+NSvNrzmOFM1XkWD
         AGb/kdIa6Adk6nomRRgDArp4R5Q+FRumhIDL1IJuOkfw1//rBxyGKgXT/ag8K2jcpEre
         2o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760836394; x=1761441194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCffS0MkdcG/B0C2qwy945tPaz5iAMXW2RAM//wKK8=;
        b=OMeLh3yeAcBRapNbxLMdpf6M3GYXqITnXdf7QVcks3cvgcF5YKdEH7mDsHjahbb/Jp
         mRxt9ddjuu2vCw0Ou13DLNDwia1myQAIECJ8LTeD00/19MuFIGWg26o/KAqf1SJZFx8e
         d2UE6xf/UvubSOLLD/gKAA9XjSn7xWvyoL7acWiG+aKQoVdlBIQB39DKZxYboJHeOx+v
         WmwNwpMCbzpZNwAPK69zCL+5L33kGKqFDB1w5KPrdg0StyejxD0S5XM3Nx1EgP5FIMn+
         OBlp8w8IXJSlIn22FxKAhcS17WAMRfJD2ak85vinRhmI0xAmGpB5o8dpx6t2vHlPPhMu
         ywgw==
X-Forwarded-Encrypted: i=1; AJvYcCXNj0jT0QETwWHs6lmjwN3CERvl1RDEr63cI0SB015tpp+2SdxnObyba6X6EcXi9CIphsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaFe5XrTGvSzcpQeAsngigt7TmmLewKBTKRLbJNTsIb06oh5o
	rSsNAjqMYc7YE+BmSYSTfMPHCso5WO2WknqakkOMCTxQvtiorLFWf1uFZ8mzJRD+qk0iTwglFdz
	0Mae2EyWuoe00dUv57TQ59wQAemlxmpg=
X-Gm-Gg: ASbGnctR45HUDBfaMwgibB2RZPuZUiYu1hLoyTZnrA1pTch8aJu7mcJdyFSNv/3X780
	bfb//00XBoX9+JJ/SwcrLNfuSVn+qtIqgLsEkRSSNhkfHfRhXWa4eol3z+2GB8WG3Hva0go+ZxI
	xulla8G/5fSeFe2TQlJLSYS5LiFSwSdTMP85WA4g+/2BQDHalOs7JRP1XHP+i148PTZbFl4AG0x
	75HlWOORCTYPgbm6Tsnv6+ODC6jF58eLNouCtHBVa9XgyU+DGz5GNT3mTa3/QYW2MHNu0VLct5W
	dewr+zHCf2rmd98d0PB1ScbG3HlD
X-Google-Smtp-Source: AGHT+IFGfgUCaIDK4EOgSAG3sWnV3n/0YMtEyKtWx7opXLcgYBMX4mZ1XBeMJbT75JRVdWx9oY0XQc+e9rWWM5ycj4E=
X-Received: by 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-471178b14acmr61603585e9.18.1760836393523; Sat, 18 Oct 2025
 18:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018181156.59907-1-nooraineqbal@gmail.com>
In-Reply-To: <20251018181156.59907-1-nooraineqbal@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 18 Oct 2025 18:13:02 -0700
X-Gm-Features: AS18NWCinBurDJyOY_gktgSZeVjS-bMOMD7I5Ui94jU4eqSqJIbM_iViSKXLBac
Message-ID: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
Subject: Re: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
To: neqbal <nooraineqbal@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, david.hunter@linuxfoundation.org, 
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 11:12=E2=80=AFAM neqbal <nooraineqbal@gmail.com> wr=
ote:
>
> Fix a possible vmalloc out-of-bounds access caused by pending IRQ work
> by ensuring all pending IRQ work completes before freeing.
>
> Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support=
 for it")
> Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2617fc732430968b45d2

Why do you think irq_work_run_list() processes bpf ringbuf in
the above splat?

> Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
> Signed-off-by: neqbal <nooraineqbal@gmail.com>

Use your real name.

> ---
>  kernel/bpf/ringbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 719d73299397..d706c4b7f532 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_at=
tr *attr)
>
>  static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
>  {
> +       irq_work_sync(&rb->work);

Sort-of kind-of makes sense, but bpf_ringbuf_free() is called
when no references to bpf map are left. User space and bpf progs
are not using it anymore, so irq_work callbacks should have completed
long ago.

pw-bot: cr

