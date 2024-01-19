Return-Path: <bpf+bounces-19909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C3833027
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF90B22CEE
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D435788D;
	Fri, 19 Jan 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKeHqZfq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BF7EF
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699100; cv=none; b=QLT9949/w4dW+umtlz8TOxlFCcqGPNZVTQCRLYGN0l6HTFpIUmdriF4eO8g9KBecDFtIfywYq9YIrb0yjh3E0Jnd1AQuLtFbfRJvMqOlgO8tTd5CmOQUiNNy5jFFHS7/0J2EOBusRUkLC6UGbQQ890RlAHsNAAmHopu1o3fYTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699100; c=relaxed/simple;
	bh=ZBM5YDBR5TNXY9yOKkVoFRwOTsswuMgqYOkVxtgrALc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPFXzXWpKgD0S9uf7BzJIbwQqVxh1ggtBqq+4Er1OaOrLBCSO7unc/hoPq6CY6llUeUMr97TLERvNflMU9ZMH4z18OhEe7kMU3bvs6M9AcV11RBNKNZrbx43wfKIefqul9NyJpwCfs9NzGxnGGeWp3xhTLpbez3N7vNov94bh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKeHqZfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210AC43394
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699099;
	bh=ZBM5YDBR5TNXY9yOKkVoFRwOTsswuMgqYOkVxtgrALc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VKeHqZfqBuFxf8jOY73Re+0/GJAnuq8MmfMPVKtZzclpQw8SIx/UjDgJnC0AHQq1f
	 HQMShkI5wKaclIb7szIOneHLMSYugcNQuhdAbfoCxL/bk1UQ15i80Qg2+OBmVrC6u5
	 SzKv4Yttsvc7P4dqjgwXrwoa0BXned44kXhdidOnt8cyW1xjHg0SQxMY9vjskkeByK
	 ZOXTsqw96nE8imu2TvRT+54lHR2o7pBHFpak5kxpyO/smXSoWB3N8gd1pcwysFQV0F
	 evtVnBXu1MKPgm0uaERAyZw4OEb1V1g8Qei/mIMkbL5PnaiJINEDeS01eW6xk2xMAO
	 kP9CkvF/zjy4g==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd64022164so19193751fa.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:18:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxEVwl66T8Uo2NsL6AerJAoHkpNq56UmR1yRuNzyFm3P6xIhxqa
	zh0iZEsNB7WHtBzURNumu26mg1Qpdkz8lNe8h9lbW45Gf3v1dMBuiLlXA9ZS+7FeHOoRl37Fhdp
	Q0XW50rSFsJs4cHSj5l0Nd1mTmD4=
X-Google-Smtp-Source: AGHT+IH4oeBzhyIINTslOnQNcYe7Q08uWEOLTy2C/rqxGjBguJiwcil4+D4t0kAxKKPnHPCME2wIc9LDZVncbuUJ2Fg=
X-Received: by 2002:a05:6512:3fc:b0:50e:80dc:b729 with SMTP id
 n28-20020a05651203fc00b0050e80dcb729mr138037lfq.34.1705699097543; Fri, 19 Jan
 2024 13:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119210201.1295511-1-andrii@kernel.org>
In-Reply-To: <20240119210201.1295511-1-andrii@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 13:18:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
Message-ID: <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:02=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> We've ran into issues with using dup2() API in production setting, where
> libbpf is linked into large production environment and ends up calling
> uninteded custom implementations of dup2(). These custom implementations

typo: unintended

> don't provide atomic FD replacement guarantees of dup2() syscall,
> leading to subtle and hard to debug issues.
>
> To prevent this in the future and guarantee that no libc implementation
> will do their own custom non-atomic dup2() implementation, call dup2()
> syscall directly with syscall(SYS_dup2).
>
> Note that some architectures don't seem to provide dup2 and have dup3
> instead. Try to detect and pick best syscall.

I wonder whether we can just always use dup3().

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>

[...]

