Return-Path: <bpf+bounces-52419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB8A42CE1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD957177999
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6E204F9B;
	Mon, 24 Feb 2025 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGJveXz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB71F3D45
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426094; cv=none; b=OHXWFW6iiiH7LItNaqiN8X6D8oulxG094Ai1gA/6W0NbUMj/aQAjo3nIsT9a3y79ZnRMovQBJn+nzjoo3IG04Rf4qUxwVwqdqVNEdehkAIVuTtpSrOxjPFGw/1bg2EjNxJS1r1tL0ylmUVtoEfHP4Kyi6HGOL0IHeYcyt9P/gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426094; c=relaxed/simple;
	bh=e9wZUaMsThqXA5Psm5TQAGgpxXYXehCMn/PsCVL/Jys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3iLrAv4IJozMH/txK02ROrrI69+mWHZbnnfo/AjkK51dH+drg0/3MPXY5lELqEa8HdR3it//3amXUnVdHC/4cshlQkX735n1ExmvVrz1O2Z2D23jyy/d5IGCJt+fCCDplM/bo8snKOtiGQqnIbYp4rlLh0dFmsuwi9mbljFXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGJveXz4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so5085412f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740426091; x=1741030891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc5l4UFmBL3LDHJS2eZwaejbWuDpDuxA/29lD2jIyuM=;
        b=HGJveXz4Pzbs+B/5ar0G4mOfqzMfSJpv27djDrjh8wf3WBXZkL+GArcAUq4E8eYrCe
         3vNvKwOUwbaPVxQpgfQSZaYe6E0F8D2M4WuDIZ2TWH5hq/WVkTscBhi/jGPD0dNUvp4m
         F7D7HZXHN2S4KVutcdSSNE7k64/Y1QMHliak6J2feMP7JpTG+HfuTi4b4jXttuQtNYfl
         amraZXn4RRqtUuamCu5zfKsoN90DpoldWuoOAUKuTZwIyj6vF8VxwSsrea+eDBKvSwK6
         Vo4vMyjSsCP2OoY1GRbeQuU31bnqgkoQe7J0wVNE37mVBaA0geDZ+BhS4yXCWFFkFrD5
         mogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426091; x=1741030891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc5l4UFmBL3LDHJS2eZwaejbWuDpDuxA/29lD2jIyuM=;
        b=eG6c+9Iydpo13uB7XpaQyGyGh0jvwOn+dssuLGh5iQKJ0eCUQ3jBZ+BNTkQa9rZ1uP
         yYYjVL9EXrEmtQOxIRTQjJYTxp+PkQbxA1BNJnZLkbdzjjLBxVzVMWshchjMKNLlgyN1
         ajZvB5vJBcnCe1A4mYwlT1KPi8MXH/L+HELZhWnoue539CqVoIEWFdvzRa53ZfQ4CgVe
         pGNBXxsOHC7gaicrwUl3lbY4RWuChn/b/bkp3y2RucnUVUz3/ZTGweAQScapRi4mpMp3
         cxhJPClzRsp2/My4HWcVqJUrOB373+CqIJsRB6gkczRBqLkk3qYkHa0rgX6QZcwqizP/
         x5kQ==
X-Gm-Message-State: AOJu0YzetVTG8gg1WiGMeHdNyYugJc5/U7qd5DKsD8P7GpmyefK1pNCI
	IKBE5IoIUQcdSmg0Z7CHTRvflF8wkZXfptUzg87xn4S5ZgozZAVo3nGojKB6yfh3Axjob0lJUv+
	hN5hpYh0joqLL5pFYI6Qbg0gsVhxMxrfo
X-Gm-Gg: ASbGncszFw8yJ7Xe+tRkMTXYdCnfPfbfGfpeiGjfbtc4tvPO6wKHXckwVfGD1BjXDOw
	IdIp1VVbXD1ENyc3wt0LuB2PIZObQAvBnqWredNP78Y87B1gCO21a/m4zrOkXESoez/8T+oLm19
	FqbbeSWX3S/KWIVqlEDhHArdY=
X-Google-Smtp-Source: AGHT+IFWKGniNzqJbRyQdd99kLN5oLYNkOvIAwlznTeSMArpbX7mdgvET3TnUxfxJ7INhnfxdUe0eyrvdZwiJOKN0Vo=
X-Received: by 2002:a5d:64e2:0:b0:38f:4244:68cb with SMTP id
 ffacd0b85a97d-390cc604087mr364295f8f.12.1740426090868; Mon, 24 Feb 2025
 11:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224153352.64689-1-leon.hwang@linux.dev> <20250224153352.64689-3-leon.hwang@linux.dev>
In-Reply-To: <20250224153352.64689-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Feb 2025 11:41:19 -0800
X-Gm-Features: AWEUYZmKpG9LBKZQFx__YcP2LC4TmbOBEsHC6gPM-JQquoih6_t6RK6YLMFPlFM
Message-ID: <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:34=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>                  */
>                 struct bpf_attach_target_info tgt_info =3D {};
>
> -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, btf=
_id,
> +               err =3D bpf_check_attach_target(log, prog, tgt_prog, btf_=
id,
>                                               &tgt_info);

I still don't like this uapi addition.

It only helps a rare corner case of freplace usage:
                /* If there is no saved target, or the specified target is
                 * different from the destination specified at load time, w=
e
                 * need a new trampoline and a check for compatibility
                 */

If it was useful in more than one case we could consider it,
but uapi addition for a single rare use, is imo wrong trade off.

pw-bot: cr

