Return-Path: <bpf+bounces-41041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF8991374
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 02:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60BA1F22E5E
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94884C79;
	Sat,  5 Oct 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4WmLTGO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3CD196;
	Sat,  5 Oct 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087600; cv=none; b=Pwz5tUPcc4ZJTQlmjQnyzg4NknsqVrVyUD1K/gwyUiLGmVSWTI9WpVInxTkRLm87N52ETpXGLBRiJSsv1Zeut0QbtOFpiYrP9+EyPVrQ7MCgRTmBckjT+M/0UTS31cfnVamzrQ/AJOC6/Ry9XVloVYLo7rAN4f9SWHXkX2nw+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087600; c=relaxed/simple;
	bh=uqFIjh+hgP1B0M8ybYbBmPlSPHmYyJTZZzOGXuHsNCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9PwfvJorSPY9pmpwwozAjjqchqn1COlM/XZbB8cOdWM58Qu0SAAzEfiII9vM0oHbTHBxDcQ4+5hOh11Ny5Wm88QYIHf0vlLmH+y2nKXEZ8Wue7wTJBqBHyPEtOOtJ0O/JS+rFjk/VoPTf2iT1Yn5lVFcujK1f7rgU9kz+r3zgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4WmLTGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A81C4CED0;
	Sat,  5 Oct 2024 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728087599;
	bh=uqFIjh+hgP1B0M8ybYbBmPlSPHmYyJTZZzOGXuHsNCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g4WmLTGOOPjZoojEr4LK2ku1+OP32L9ABvAnLHGczkGpfqFlkWb0I9PeaH3xR60vm
	 j2sUAMtV8p2CB+2oLXfqA64Vu7nPXbJkEapzjALtkuZBXuHWiBfoeT9GkHgZp9Dkl/
	 usxWegmpLkA+Terq3V61Pn9s4Jgnc3qDBw7xvZ5etjg2UvQP9BVqyjmOymeTfhvmpb
	 RhZcsQllqOG/QJo41mb6FDJGTuDJNKbeYqzdz1snHoNEZX1GjVy8YiCXGDRpNr4Q34
	 LGQOAAjcd4gowprdtRtDFqe5l+pJqZc0xb2iNDXOAqcoaYyjblZz3/d2ZhTIOUj152
	 sF0JDBfBO3AGQ==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so130029739f.3;
        Fri, 04 Oct 2024 17:19:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZKQTJwiJNjYNlOKWbHN4RyCc9F64poioQQrEIDl3DY/WN6yUv5DxvHnWaeLpZ8UEdUKAXoyjVpC34ZijB@vger.kernel.org, AJvYcCX9p8i0XfBWa+RTEZU7YwhMw6XP8tXC+cDykbrDngg3Iikq1qohscOCYLm0G6LdPWnl+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6BNdUuAFDg44TP97UGJUCeaLaaOlEjawMztXR0pIJHoeqOsV
	2Cc/vA6mSIanopHqP9pe0tELMYjGYjWXkmOjLVLJfdqc66vxCOjmIftzayb8GZb2bkScRus1VGA
	rT1cybaSYTUKHTW99lQknqxEY1l0=
X-Google-Smtp-Source: AGHT+IFTDzpCge5DXl+DeLMwf6kPCyDOsa+FaSOGNOECxxKaDgYLbVK8E3NsWiUJu5aglhdNxgobHEwj0svUOVG1dY4=
X-Received: by 2002:a92:c26e:0:b0:39f:93a7:e788 with SMTP id
 e9e14a558f8ab-3a3759780efmr45444205ab.2.1728087599047; Fri, 04 Oct 2024
 17:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
In-Reply-To: <20241005-lsm-key_free-v1-1-42ea801dbd63@weissschuh.net>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 17:19:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6djGuT=tj8_rNN72POnnTun4p3bt2K1bQmGCq4pA3Gxg@mail.gmail.com>
Message-ID: <CAPhsuW6djGuT=tj8_rNN72POnnTun4p3bt2K1bQmGCq4pA3Gxg@mail.gmail.com>
Subject: Re: [PATCH] bpf, lsm: Remove bpf_lsm_key_free hook
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>, John Johansen <john.johansen@canonical.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:07=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> The key_free LSM hook has been removed.
> Remove the corresponding BPF hook.
>
> Avoid warnings during the build:
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
>
> Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security =
blob")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

LGTM.

Acked-by: Song Liu <song@kernel.org>

