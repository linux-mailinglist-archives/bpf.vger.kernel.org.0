Return-Path: <bpf+bounces-63063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C9B021E7
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DEF7B55EF
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3C2EF280;
	Fri, 11 Jul 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRWEXUJg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845381CDA3F
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251771; cv=none; b=ma5MghZa2m0Qd8v7zJxxpUok/6HepL6MJxbMerNTbF+OH0U0+LmoiD/t1+xwcS1QdjQ9Bg+6koD9hH64vj746CkkPRVkPWgot+u5dTxIrgSSLs/ayFbgKyH3IPgnIvOtjrEkUd+ixuvoZajFmQ9ILG5ngQVwo/Jxhle3Ydgx5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251771; c=relaxed/simple;
	bh=5wPyZtDNwwkb3K8/N2XZYrfKBaKkyitwYya2wpyn654=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2QZjY3+5P3kmITyDhaRZNPjX8Y3qrKbbS+rq0IbXVq4scLLBaBlLtsJtcj7O5CgMwT1vbDhMKEpRXYtLRArjX4rf1+ynGi1qQc/OF8aiRZ4lhNEWYNfmGZdKVUisvi0toSMSW1z++mm7nHaQeIy0vuFai1E1jLnOjU+VgeQ3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRWEXUJg; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so404332366b.1
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752251768; x=1752856568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ym0w3Dmg2hTkbNc7WwQCmWObMK1qE++/1HIeeWTiUpA=;
        b=gRWEXUJgrg7DmtUAAHuurppBimdTL4PVzqzyp2PrShG1k5yKEDjn5A6IP+tgWwTzm6
         GDe3xGi4L4bLtNxX1VHpw/2clGU9RYHCnn5oJJ+7sZItvy5fZOGeU4nvpR7htJ2Ey5Bf
         iVoxs7Dl+FGQGHizrSfwSo4l8LHD9KYsZRc3ohqOqcURewKxnBzadrQk+uKV/9OuNNsR
         mIfkm3rK21206isToG3L+GunG+CPsanqV7T98mMGlFhMdDOz0tKYkYgJBQ3wPOd6k06Y
         BIWs7Ce2eHpe7eAkBo+jugMtz7M4owh/Ca77igtCjw43YuVuG3CoMLttsByFbrF8aG9O
         Q/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251768; x=1752856568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym0w3Dmg2hTkbNc7WwQCmWObMK1qE++/1HIeeWTiUpA=;
        b=absIO6gn/cQgkjHXiFLbAWejLsJDDQoWpzkoEaNQfAR73JHvtueIwKmEYs0gqB7xLw
         +Df7zUBlwHOWD1spVfopJfkTPUxvAk2YDPaRGVYb98DU7yUXU8rZIOORqcV/0xDLY/8W
         0ur0BxHwyDJjUwdg0DqbJi3AmxpSwWyf3MM5f4vFKDXr1ASBOx3UhusgVWzfWHj9KPW8
         4axYXVSEEkZ124VOnKfKe+pws2XqAIWUDVlWrC5lGFDtnW8qveiz03CRgVMloXMtA594
         peUK+5tEktwDDa1VKtCiTZW9ElXkZrdZTy1fTgMGYM7KIFo0NYNj/x9L0O+fFzCBpCdW
         a3yA==
X-Gm-Message-State: AOJu0Yw5Ze3imv0YP/gliH41rnLU8BM00E9VXYw8f6wzpCqAYbKbW23Y
	4vXfs7STI84ckT0fLyt14KFwx0WVaVRWZO46hvBbs1pLoW3sSMEPdpiYtJ3kxLA3yj3QUw5PSjy
	bsqxIqsXWrOW1ZmpAx4o09p5+e1x2+Bg=
X-Gm-Gg: ASbGnctOuYsjHTORfWRotdn5MktuzGZ8fAmZdvXIc9FtpiznQ7tocn/8hFxD1umc7gi
	Yo2nmXbeZwbw3sTuIanSaw/ht2p+L1ioMbj9ODozgB9o5MUcxM9T6rg7FN33jpXhnJ4jElJCCTv
	R8oBd+s98teuiQukt2xWwYOspU1xDrAUN/Chcs7B4nc3g+8lpiupmSSTyz5E3SqNj0WB8iDLl/h
	v1p1QUs58TE/eX0L4JDlVH4kZX8Xa3jnLq5iT8S6RnV/GhCMok=
X-Google-Smtp-Source: AGHT+IFTPUwDM+U2hNHFg4yrQePoTh3vLN7F4QnPpzh5qbPpZw4xgEJeBG8ICuYmuhoppPrhX30idbx350MkbNNSmFo=
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ae6fbe3d07emr467676966b.27.1752251767566; Fri, 11 Jul 2025
 09:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191312.29840-1-emil@etsalapatis.com> <20250709191312.29840-3-emil@etsalapatis.com>
In-Reply-To: <20250709191312.29840-3-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Jul 2025 18:35:31 +0200
X-Gm-Features: Ac12FXxMRIo3N0x_bJsVG8OXJSucNkRntxiGuWcwbMM2tMuvhdMnSByChRRhtEQ
Message-ID: <CAP01T76DPFeMvwijbD3frup_Fn8FhA3YQPwf5mk06D4gvzUmyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 21:13, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> Add selftests for the new bpf_arena_reserve_pages kfunc.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

