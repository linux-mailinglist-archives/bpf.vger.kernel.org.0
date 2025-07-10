Return-Path: <bpf+bounces-62921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDFB005C4
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525913B6CA2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206CC275AEC;
	Thu, 10 Jul 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXzMBLTL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2327587E
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158979; cv=none; b=mwLOcyuCLFTYFIe76tqIG5VCnAfNYYk9jWoSr2luw8Hh3FpdQ6vNf6zJhaBpWxTQLd7CeWPUIw9BRjS+5GP0QIsLDJTMqVCGdspITKRR+exStUtX7vJzGK69sqHbLm2uklitsiAqzRS7aV8IYI4z2jtw5xM3y8cKHlLfL5qJJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158979; c=relaxed/simple;
	bh=ZP1jNyOt1L8fsmvxvgMR+lXfUqXlJIY8mtnojQX6JwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhMm7PtAkPsV9rXtcCDaErh3SMQeSOaIuQi8xIdiQd7BRXYt67IUNoAWdz8xSakyfy01nUnXuBGLyZ9sggFTSxjJC52KO1d5ooo0BS0GDrZZ3r9DiW8aWqPfAvzu4jeSeoFYg4MA2dpO1NXUJs6zu+SwxPk2xZNm3QfbeQYOiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXzMBLTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E9C4CEF8
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752158979;
	bh=ZP1jNyOt1L8fsmvxvgMR+lXfUqXlJIY8mtnojQX6JwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lXzMBLTLKApvzE3e2JZbOS0PVymnL53dOY2W99GifIrSpGVfs3ocJehJnAwq+BNB5
	 cy64XqKiA5LtitDVnmG/lPc3e6rhNY6OnCjh1TXEPh/Mo3gR4pFWQdFlpYMSuD2UFu
	 bE7pSZzH75PDUxv4vTfAPNnh5TTvxvIK8reJPjs12HmNmxYV6z4ISCeXsFjnUoN7v9
	 rwiSLT7qhnZqGtyLe43Li1/xeu5eWoU9UTmpo2zWpZHqozM3WjzIBu+CRrghBlCq92
	 HEJSxCgO4og95tz1pTpPjgCtbSLxw5cfHV4tmCYVu2stfO/W9ZNNTbqhEsoZLsGsG0
	 N1vNmhURcdCSg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1748877a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 07:49:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwaR9kTg3SBC22BXFFd9RcCKNvSX412n/DMRzM1xTTUvhf7i9HD
	J4gdsiGmP3CR+SHiX1nsxIgxkMiVfLY4OOtWdYkpmxmhJbGBgj+z9zZZDr9DVF8PnmH47jsKwXz
	5MxsC8VAJAGpzpofPlcfx5M41/sibdh+OeNmgt/dc
X-Google-Smtp-Source: AGHT+IG5LqxN8Y7QPn0M5OvHQYHryiYWMk2HHWYrm+2pibxrZTEAyzYkdGqMZyc28N//kaSbMNBhfAg46ogVeWuB0Yw=
X-Received: by 2002:a05:6402:35cc:b0:607:2d8a:9b3e with SMTP id
 4fb4d7f45d1cf-611c84b930emr2833156a12.2.1752158977566; Thu, 10 Jul 2025
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <87ldoy1zok.fsf@microsoft.com>
In-Reply-To: <87ldoy1zok.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 10 Jul 2025 07:49:26 -0700
X-Gmail-Original-Message-ID: <CACYkzJ72QRnyyjmQ9OqRgiY9FtP+v5GQ5GCZwNWZmqesMtHTkA@mail.gmail.com>
X-Gm-Features: Ac12FXzyrrU7Y0rSRJqmlOt3nVTCkR4zhB4tgzTsUcs90xUFuHzQkTR_AC2WMxA
Message-ID: <CACYkzJ72QRnyyjmQ9OqRgiY9FtP+v5GQ5GCZwNWZmqesMtHTkA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Signed BPF programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > This ensures that the loaded loader program (I_loader), including the
> > embedded expected hash of the metadata (H_meta), is trusted.
> > Since the loader program is now trusted, it can be entrusted to verify
> > the actual metadata (M_metadata) read from the (now exclusive and
> > frozen) map against the embedded (and trusted) H_meta. There is no
> > Time-of-Check-Time-of-Use (TOCTOU) vulnerability here because:
> >
> >     * The signature covers the I_loader and its embedded H_meta.
> >     * The metadata map M_metadata is frozen before the loader program is loaded
> >       and associated with it.
> >     * The map is made exclusive to the specific (signed and verified)
> >       loader program.
> >
> > [1] https://lore.kernel.org/bpf/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/#t
> >
>
> Can we expect to see a v2 of this patchset sometime soon? We are
> planning on submitting follow-up patchsets that build on this effort.
>

I have been on PTO due to personal stuff, will try to send this in the
coming week or two.

- KP

