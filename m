Return-Path: <bpf+bounces-37899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B805795C0CD
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B51F23EB7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864CA1D31BF;
	Thu, 22 Aug 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAOPyLbc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA551D2783
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365222; cv=none; b=hmQLgp70fxscLTydiv6U+PqCAKcZW+ilD7nMQyQX+4Om0ygORae8M0i/OpagCO1Bvrq50Ip0z4wu++SegolykJPPSZ2g2z25bFyonLNakUG6Rie2LCbGesFs9iBBl6+7YO+kAgYDgalbDny6nCDdQYr+tMOvhI/QoSic8xw0hLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365222; c=relaxed/simple;
	bh=cwvvtIm5vG4d4f16YowuP9O9cMotc4z4ur9CNrcDat8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u51I95vuZDNCeJ5chtUYyVz9eukGHBXkodCgLwx4bt9LWAXS7s0pJ7yBjydeOXF64GQjDdOsA3laIy8EZMSFClBgZIJtdYuLNlFTBnGKYlDsu9tNVI4qtCgbyTDeCD1hgNEkOnYOKZR2YnOIN8NcuWdIAcZKUGZ8oXnzywjQzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAOPyLbc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42816ca797fso9887415e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724365219; x=1724970019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcXkIme9w4417kD7HDQVulS/HGowGr3wb/VXG6W0sqA=;
        b=AAOPyLbc4hyd1v6Fv6nq64J7RsqzPrHrScGcktPO2NNpKgPPHr98Ly6Z6YyTOirMA2
         DVLLj5AM3yhj9bmz/JFOB0KCSq1o802lxNFOtjMG1e5R5L5CGF5hh+Su+TtlEJaLfUNo
         oglkvXBt34+4hMLnqZjO23QlXExMtXkaibyFMsK6DjapP9hhs0kjRex+ZTpWd/TeRbEV
         KY9vxoqCuBLGew5XBir8WmNckduLdQtfCAIK9wiU5NO9iVIDNYFchpXBjHsiH+LCDMil
         CR4sBYK33ZeUeofxAouUOGOx/fxFCX6orzyd1GGytA4AQZg0r7n+iiZbQhSfgazhCfss
         EFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724365219; x=1724970019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcXkIme9w4417kD7HDQVulS/HGowGr3wb/VXG6W0sqA=;
        b=mjlmZDBIXJMwhLQD+3QdbGB/JHDNXuLyUtrNDvLn4M4+jzYM7d7E8/QebPkii8JQiV
         vB7vOvRcA/sf4X6rl08af+R+/UXlgrmxSPOGspCf7oo8yMqkLpv9VS+GOhnKn+wA3yVb
         +FPYzaGYY79b2I/g7jfOMZHtP2udOvB235yPKaNp/SgOkLQAS1v8hzB14cBm61keh7hU
         VkHZrrrBE7cc0BSbN9MdsytEFF35LdehRL7BJTDAM0BNyflekSoq9VNrpB+0PeIf0d7I
         dNXsQVKT12YxwTntknwUS47gohdU7LftLrFOC4k90t2Lck42Wtt/rXg5oA2orbgYKDpS
         EXJg==
X-Gm-Message-State: AOJu0YyUB6zMMWucXXtnJQLq8IuvWVmHKpr97zmZV1XPEkQfD2JFKZml
	orExnwkqVDYSrbBlr9T0CMt/bIMALWp0RD7olBpkfMcrtLmrpSA5ZTbpttddz6ku8mPzl5vMUG8
	cmbi+YOvk717X+dAYQZ5Jj5Z5WE1iimiE
X-Google-Smtp-Source: AGHT+IEyr/VCqLR/txGhhciG2p44MArrhXqvahXAqrSM9w+96Pm2Skb22LqNJGqnW2LOwNEG9aN6Ac0qqDwxqK8AXsM=
X-Received: by 2002:adf:e54a:0:b0:373:61f:e45 with SMTP id ffacd0b85a97d-37311840b89mr136806f8f.2.1724365218527;
 Thu, 22 Aug 2024 15:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820101725.1629353-1-linux@jordanrome.com>
In-Reply-To: <20240820101725.1629353-1-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 15:20:07 -0700
Message-ID: <CAADnVQK+zPvF0qTYnvK8jX9Q1d9zMnNUAU-rBtRXD4HVeHAf0w@mail.gmail.com>
Subject: Re: [bpf-next v7 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:18=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
>
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper except it includes an additional 'flags'
> param, which allows consumers to clear the entire
> destination buffer on success or failure.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/uapi/linux/bpf.h       |  9 ++++++++
>  kernel/bpf/helpers.c           | 42 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  9 ++++++++
>  3 files changed, 60 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e05b39e39c3f..d3b69cb055c0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,13 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * Flags to control bpf_copy_from_user_str() behaviour.
> + *     - BPF_F_PAD_ZEROS: Pad destination buffer with zeros. (See the re=
spective
> + *       helper documentation for details.)
> + */
> +enum {
> +       BPF_F_PAD_ZEROS =3D (1ULL << 0)

Pls add , so this line doesn't have to be touched in the future.

> +++ b/tools/include/uapi/linux/bpf.h
> +enum {
> +       BPF_F_PAD_ZEROS =3D (1ULL << 0)

and here, of course, as well.

> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const vo=
id __user *unsafe_ptr__ign, u64 flags)

'k' in __szk is probably too restrictive.
It should work with __sz.
The difference is 'k' requires absolute constant
while __sz is ok with bounded value.
Probably worth adding a test as well.

