Return-Path: <bpf+bounces-45612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A516C9D901E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F11B28A11
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B3D515;
	Tue, 26 Nov 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auUReJse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F6C2ED
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585404; cv=none; b=J5YqgB7vVG0iq7pu4yGXk+jJIRZlA8vaKDcz+s5XFCeHFPqZcEvfwO6dpB4E5Q6vtYdUqhYrUR1otqAVKB9SBroQFjKOG0pPFknxMxEJRauwUgqI5yS4rmQvFI8FmDhpUlUz8P2iiwsxEKzmsT0g3pB+zVbSgbyXqJOLZrq/ByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585404; c=relaxed/simple;
	bh=LUv+HDk8ZKr8PEhxV1XiJoo9kr0p5md9DsM4YDTU5dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AX8gRjnXza4ZFPfuSHbwAmyKwX63exipYbq72hOsWUlBUn3zPr45QENiinpmlPZsdlxknbqCstF9gmXmE3+Pp8c2ke5Wdf637U/nRzodTxJnJmneKenfpHwSogSyiq0Z94J7hbxUtBrg7Nw26B8X3TMTCmkyzH8aL9Ny2HrXVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auUReJse; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38246333e12so5077417f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 17:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585401; x=1733190201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKwJY6Q9jlEw5AcqBT7Kv5UbOHyKeolB41scLL0Oves=;
        b=auUReJse5pfwYLFUuFjYSRXMRdSvxXf7LGVrWPM3M1eWtB6BkONotH3HJX2/RPXKyE
         LgRXJ7Kv869yHMAoW1dw0/fHsInE5YGwK6tx01fbqEv01DRMW4H/1RKLQtdKQOUgxOyY
         uHkpQYPbN+3y8LPO11v8sGIiy/6TwT7FtM7snTM2vKGfP0HMjeKbrJgi9t0dqRgMUMrG
         fT+A3gmqOH6o2cuDOwMBghLvmlFQojBh5pAPgYQu4nFjRR4SqVMBhEVKp2MuqblEEwNN
         86jIxVW7d5qJC+fuVvWFLYQzxIJid3F0pEFh6OmXjP7TOW7LhPo1XNL/i83tPlcsJrrz
         sxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585401; x=1733190201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKwJY6Q9jlEw5AcqBT7Kv5UbOHyKeolB41scLL0Oves=;
        b=pE/Dcv8uhVc5U5gXWR3EEeFDkpbkPP1BiH3vte2D/GzYNawiwjkgH9xGmHHZV1Fk1Q
         Vwm2ulL8Gcw1ndk35gGkqYL1lZSPBDt6Im5E8J+KCgobBUwS4+5zA5mqUrsdaIR8ukR5
         id0H3wjJQPLjcI1dvE5Dd6rJvJLmocOib+woxlHWN/Rm6Y04xZAoD24yNY25DHNtwjqQ
         1rmNbrah5BLWuJop5wbbRukMjF4FiE5kCe6xyhKFPIF5EwWSd85xm/HQRZvcF+CfXDUo
         dWSNYc85m+bx3JVSe5UUz/MBpi5E+Iq+TrcwCiojb9Gtc9yvhOKlHAzMUyJyg+DWExNF
         1Tqg==
X-Gm-Message-State: AOJu0Yy1wfx05nXbfOpSDZ8oXzncU63aHROsRhCR2CkKnZr/frLqGd8p
	H0RrrwwGlYJ6nXqg4Vnil5/iBLSxHApTa2XxLKGbitDB0rkT+vELd0/TMK2Ckjtv/o5Wf6M8DWa
	1TfSMtYNEIcyfqpT4YSiS7j/cfLc=
X-Gm-Gg: ASbGncshqy+X3o0LJRO4BZcuR3XkaHoAlmVcUO++/7c8AmPmjiOU5CKU9/clMn4311c
	Kj2hNVj9ixQhxGgRgoJExMn/Je4JnmECdDP3okq/1I4Y9kk0=
X-Google-Smtp-Source: AGHT+IFRgtVNyC0MAGvDqyH9SL60ubJVk/nqxzmVaWPvf14ezUytVHoY8coDEhwpYp+GDHfz6HBSPqivdV4MIVRYgPo=
X-Received: by 2002:a05:6000:1f86:b0:382:503c:da45 with SMTP id
 ffacd0b85a97d-38260bc6ba4mr17060808f8f.38.1732585400542; Mon, 25 Nov 2024
 17:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-6-aspsk@isovalent.com>
In-Reply-To: <20241119101552.505650-6-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 17:43:09 -0800
Message-ID: <CAADnVQ+=R-ai4wpBuGkDa9GeARYGeG3oXBjoQSXP06BN6TPdpg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] bpf: fix potential error return
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> error is a result of bpf_adj_branches(), and thus should be always 0
> However, if for any reason it is not 0, then it will be converted to
> boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> error value. Fix this by returning the original err after the WARN check.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 14d9288441f2..a15059918768 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_pro=
g *prog, u32 off,
>
>  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
>  {
> +       int err;
> +
>         /* Branch offsets can't overflow when program is shrinking, no ne=
ed
>          * to call bpf_adj_branches(..., true) here
>          */
> @@ -546,7 +548,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off,=
 u32 cnt)
>                 sizeof(struct bpf_insn) * (prog->len - off - cnt));
>         prog->len -=3D cnt;
>
> -       return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, f=
alse));
> +       err =3D bpf_adj_branches(prog, off, off + cnt, off, false);
> +       WARN_ON_ONCE(err);
> +       if (err)
> +               return err;
> +
> +       return 0;

That looks very odd. Just return err ?

