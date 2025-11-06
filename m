Return-Path: <bpf+bounces-73892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE74C3CF6C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D7D563D93
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA62BDC00;
	Thu,  6 Nov 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUK2aRbj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF281EDA2C
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451339; cv=none; b=s2uK8lfFj3NCabzvO24rLJB0TIX9fIl5L5WG7cQUvRkrcJplO1976Iz6SOgi2N/ax2UKtx6sPphha9LYXirjzhE1dhx6ydkQP7DtYw9eO5RTt5iwe8RUt5S+YVBoWOZ4FW6zhxVGpMQKoTS3btUQGDB61PCqMzyPVKESKjnB44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451339; c=relaxed/simple;
	bh=TGhZN1j638GcvsWGC22J7wEjbkdjpV4QFnKApAi/ONI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBFrqAHXj9MZvhmpPkq6oYt5AmKDGr0gn+WMdqOi/EMYjlE2i/Daix8bb9SmD0jJQntBqabKAPX4VbWcU2U3kGehPiNJUw6J0FmZOIzdqkI1/5O0iAhLDnGjhcGDdIQbHCsimMJAkyUTWhG+G70YhGC7FoWmSj+13yBysLlgBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUK2aRbj; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1374319f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762451336; x=1763056136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGhZN1j638GcvsWGC22J7wEjbkdjpV4QFnKApAi/ONI=;
        b=UUK2aRbjp7JcjCYrHgj+uSt2FGl4qkyx2aaTU+NuOmwZ5Uzo5WZofXN8ODF+HJjyxs
         LXXn5RDaMmTiDUPNQrHX6lNqTwUA1h5NzhBLBK3FS5EJqPIXIfZXUNHLldVY0nNNO8FG
         iCevnT61ASKzrsgVnyWwHls0MH1oYe+oJBl3Le7hiZg8SLX6jTov9OACpOxp4rIX0Orw
         I5Yd1eRJOv+Kj/9XwPJ02Fxa0ud3PHuAnjI+hzXPrTqT8lWnNAadcBNKnnBlvhs/M0Sn
         PilP2gTdVmAxXZX5InH0hdOnllRu0AZfvl1n91yEpJYP747tmXeIIzVVffkdO99c3UjF
         CegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451336; x=1763056136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGhZN1j638GcvsWGC22J7wEjbkdjpV4QFnKApAi/ONI=;
        b=Umm3ZPf5z+tX7P2wGcV5M7IFbTmPBj0KA3YxO0CYE1DeqNnv6A058K/eU7sLrqRtsM
         fFHw06Pikyj3P8RhTGORTAecCZkQ02S99UnVQkN6o3CT3U1DyNrH3UNuJorJcMg2+3yC
         CKFiirZiUvyeXjJ0Q/mAQU+loBMmduFsLbPRiaTR5oGT7vHjY3Bgq4N08u+3unrWg854
         kz2F8y9abdQ/v32cWXsohcQtUlavaIelQFqZ6qjRAqS3prdXhdakZr/mQWKup+aQKgN7
         1yOa6NYIa7y/uQVVMfphGxNhIZFlU6OpYuXaRjdYZYrnJwICI5updKUypoD+xJXbbMYB
         hsrQ==
X-Gm-Message-State: AOJu0YzgHFYCokXlPHlVbjlT4153XBdUpNUl6wpA2209P8ZGx44FowEz
	RyaTrNA7nQCbxOb+pUDoN7Bcmp3XgkCy93L5BcB6O90kortiG8gxQGXpxyN6XhncSUA7liFgJhQ
	pnJtfz3aR1/T379JCIRNF47PZ+dgy1O0=
X-Gm-Gg: ASbGnctzqkC6P6tMLmVX7dFy12rcarYjCgIZbK2gVFnVx8r59xqFLu+CI3Ldj8obaCx
	LIf/K1ou3zjBKQE4+A3GcNDK9qH3k1svgKXwPjGqz66hPKm0779/VjJt9y8Gfdd0k2yRM++4gpr
	wbw57SJaXeY1aYOgccHBm44hQ0DxalBVIH3wYPFNKSdQvoSIE3JXvBbvtilRxLC2MUZRBXCifVb
	mjiuY7iy4ZVnMec9RlNrcRlVFsWgdcdBnNX2ptvjTE5Cbr969pUGZUBmEO7J48oeacPpGsTn2lj
	OSw7X4iqJc+hMH0Z+AuAadV3xuO0TI+IawBo1OXiJ/98ThDUFg==
X-Google-Smtp-Source: AGHT+IE4Fr5N/IHoHllfsFlcS4LHoV0i6vT+rxZ5/uCK5Uw0SwKzYJXUGpjzpOnFqFGcdJ1/IWDC1xxw0C9srfNNUF8=
X-Received: by 2002:a05:6000:dc8:b0:429:eb80:11f5 with SMTP id
 ffacd0b85a97d-429eb80126fmr2747894f8f.26.1762451335948; Thu, 06 Nov 2025
 09:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-4-32698db08bfa@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Nov 2025 18:48:19 +0100
X-Gm-Features: AWmQ_blUehzCiH0CyRHtuVaz0IeP_6-HAQkfP5aRODGJqMhyQ9ervwZqOmKjNFs
Message-ID: <CAP01T77bipYaxBiQ7FG-OzhYOebrmTRKg-k8FZFysqRc7+eRgA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] bpf: add refcnt into struct bpf_async_cb
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 16:59, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> To manage lifetime guarantees of the struct bpf_async_cb, when
> no lock serializes mutations, introduce refcnt field into the struct.
> Implement bpf_async_tryget() and bpf_async_put() to handle the refcnt.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

