Return-Path: <bpf+bounces-42714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14C9A9520
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20361F23CDA
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE677111;
	Tue, 22 Oct 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe12PJIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EE282E1
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558056; cv=none; b=iKuLmTBO+1YIpxtkr+YzKaPsMOaNUj8ToNd9jcg6RzzXwcB3kRRtKtImFxUmQLYYSKFkrcSuSv2ETr7ozlMqjAgHGTe+adQ7hajadKdN3GSShCnnp9W97AZk9s/DBUX3eV6S+K3Ax8qqA8EvpUKkrp+3ejkd6JbKq1I7F9m8Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558056; c=relaxed/simple;
	bh=H+mJJOuhCLXHcG+xG/UJ2OySjHEP9elUzI7keyW2TIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhL3oJihqMUr20pLTernnrnY9nb7Xhq7TS/rwQhRnqwHbIu/O7VXeKX/CspPzjWyNSuuYODalXlhVBA8EOPOTDpwfDcWFQxpriPfx6iVADABRCxGZReaqUg+ls/mI/VRALI3ib73lTbqdM6mJRmA4fOnMcTwNQ9sif/q3rvAzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe12PJIZ; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso6484442a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558053; x=1730162853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+mJJOuhCLXHcG+xG/UJ2OySjHEP9elUzI7keyW2TIo=;
        b=Xe12PJIZlUyVwmAUgG2r1PG77TyirwgNf8nKp1dKVR5JGQ1rT20b8FS2yTJN6VkT+X
         fGihkA0rCxdZTaEIqFkmjgwKWRa/zwkG7745tmHEM8nLi2q74EtyGroZdid764TKpQlz
         g2jhiK5822F6KbSbXHvpvxyLtCErGjP+xH8XasOZhmYnyj4/x5leqvV8qKB1G3kX1bP8
         zdx5MPU1eI5JzvcfYh5tYIXfoUW6lWPCdfaG94qtIrwcCqIoyi9/0Hc2XXLRSpSz3bp0
         kbh62LMWW/P5+TAjodY7wu+SZMGRvuG1jsRWYg4hsCwlvyGGj6QOxZvgXGgw7alV+AWb
         HSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558053; x=1730162853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+mJJOuhCLXHcG+xG/UJ2OySjHEP9elUzI7keyW2TIo=;
        b=NUuZ127WMRn1FyVR/JH36MNvU82bfcZWim65Z35N+nZHxzwZutXd9BAFxUF/kyhbBn
         MqImQdZYiCO1OA58b2E7D9N3iXWeurFt2hV7Oteknaw8pMQmiusH/6qTkznY+8wsLDm5
         aXPEgHvv4ImCFNqggXjcw08OKwBC7ynzpXpPDZDu4r0+Xbgn94xFvhZiTEl0jy/MSU2w
         c6k8S9QLr0RkJkQGDXyY6J4naCWXWpTxWNPfMNhGkDTgvXCa+C57yiIoQi+a99e9CiXH
         7V1LxCKvGtXFHwYhlINDdFGo8rrGHXu6MeQ7YFRoDWUEh9ALiML976Q2YRR3rEfsBVuj
         97JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3VHptDrE3fSKBFTm8iz+UpTt9jlr7r9Pat0wF/I1chpyRMZFFx5fYclFkQInZXLulhkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vOzkzQ+vyjp5PDBDdTx3DWSetdZhacgzc9UfgccsgZoIsyys
	3q8D90TaUx5tmGwv3Q+ZbfHl4y6FTYMW1UrHPnnFxUwyBews0le9TGZkUGmYXJ8OFbAD3xKzK6I
	4wjase5caQUzN6oInIwc5hzqLCrE=
X-Google-Smtp-Source: AGHT+IG5aYcYCLA8Yn4rLgIDawlJPK7HgjshQU6YQGufUL52QNKVVwlkcdMTivUeuII3VsuvQqtJnfvt6bg/hcfQMDs=
X-Received: by 2002:a17:907:9487:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-a9a69ba6438mr1396793166b.36.1729558052598; Mon, 21 Oct 2024
 17:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021152809.33343-1-daniel@iogearbox.net> <20241021152809.33343-3-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-3-daniel@iogearbox.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 02:46:56 +0200
Message-ID: <CAP01T75xMivKuBXqByp8dOvZYpH4AZMN3k6n-Z9bQScS2pfKSw@mail.gmail.com>
Subject: Re: [PATCH bpf 3/5] bpf: Remove MEM_UNINIT from skb/xdp MTU helpers
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:28, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> We can now undo parts of 4b3786a6c539 ("bpf: Zero former ARG_PTR_TO_{LONG,INT}
> args in case of error") as discussed in [0].
>
> Given the BPF helpers now have MEM_WRITE tag, the MEM_UNINIT can be cleared.
>
> The mtu_len is an input as well as output argument, meaning, the BPF program
> has to set it to something. It cannot be uninitialized. Therefore, allowing
> uninitialized memory and zeroing it on error would be odd. It was done as
> an interim step in 4b3786a6c539 as the desired behavior could not have been
> expressed before the introduction of MEM_WRITE tag.
>
> Fixes: 4b3786a6c539 ("bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net [0]
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

