Return-Path: <bpf+bounces-27348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C08AC223
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 01:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8991F215D8
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF545BF9;
	Sun, 21 Apr 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFhAbRPO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2E1BC58
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743277; cv=none; b=Q2BNoqIbyff/j77hGQHzPZaCdSRWkK3joXArfMX13ugpuGkrUp45yGyZJlu6fIOid34fQ7TMTLRO/uobR3LZqR+QWKbzQCsHfl4zdZTY94bYbD/S79alWGXvO4wTgQKRneoIWp0InStUyosBqDZK2gD408x1824Qnw2qS4Ji+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743277; c=relaxed/simple;
	bh=GMD9a3sE1DVIkgIWGZsPG1PvM154XUDUFEu/5KUPjOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmfT/yBjyi4zpbKwHzcK300Hu6mzsZ30hjzRHmyIHaED6ilzhjtwOvO/ufhUCOjICiRkaKgtDIxUQkVKubDyuK8OCsYiUKNGOkQLejBte6kRWY0HknECwAsXWN/DBq1Uz7evBJoDuhFXAigE8WU0Zyz3YBkFIHnBl7tIS3KFzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFhAbRPO; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4daa91c0344so1179039e0c.3
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713743275; x=1714348075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMD9a3sE1DVIkgIWGZsPG1PvM154XUDUFEu/5KUPjOo=;
        b=lFhAbRPOF9rXixmfZqUgN++tf59w1lkcV2Sb1rib1ntcy3HICNEHJfEyVJCxUS+yKM
         qfdeqHkzwFp0htiKunMVYWVzceIl566mgpdgguOum6SAmRCtxvB3pu0ui9wGxqZW2nzf
         gcY82AAZEmGn7ow1P0LHTMKaF5fLbJZRfxxETBn9uqCQiEydCFIyGqdkQHNtQK3ehxD2
         559/sGHzuNsGjDlbWVZB9nQ547cMlOlfs57Y0Z8fTJhwlbj93fVWo+Ntn1HtoTgNjquw
         O32dIi9xL/ju/QjO6Izf2cG9o7uuuT/9IdmE5yRZKK0Ni8HfyQ6NkvVD7KL6SEp7qYKF
         FrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713743275; x=1714348075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMD9a3sE1DVIkgIWGZsPG1PvM154XUDUFEu/5KUPjOo=;
        b=bKtHfJmCxP2pCQkJq8mkjuVuDySIg+xjf0aj4Ro8pbMLqfCObsgYlppYvgyqIcB6Q4
         CZ6VeBKmkC+80MocI7PUR/J2XXEp8ZUBINFf7gajXHwR1C+hKuOyylQWMQLtyrD2y9W6
         TzNadJMVx4xA0z3xVCbE1G2uZ7T6GTOcVMs+h7Lswm8TShZAOPD/ydFenvYCNONAnrhS
         VVtWT6cIMELMfG7km5DD4rFbmXMua80v2TJSM6xGXwbiDbzrBuJlv9qrfHgrt2L9PdOh
         84k6fJ/cekGpLr/bJTYmWxAj0+N6iNyC4s7woPQ1exdEHA50NzT3bFNv+iNA7bJmndNC
         zBJw==
X-Gm-Message-State: AOJu0YwA94IrQx6PVJFQekQqitcjEJKxWy1BYp87nUngvPKN12oguT5I
	IiKSO9oXTa2HSlrONNJsTkUQWlTPgjaagNciIaXetTwq4iU1sX02BkzohZ7gLoY2XBKXMMR+G32
	BSDHDb/42UbpJf3IR0hrJEKkjtrI=
X-Google-Smtp-Source: AGHT+IH9TjY1sjSZ9/F+H6Edu8zhzn9Dcd3sm4dD0uXQVhYXdBS0ZD8bvimpvBrbdrIOsvlG8AzJ66umVhS3voRoNik=
X-Received: by 2002:a05:6122:7d3:b0:4da:aedb:fa9a with SMTP id
 l19-20020a05612207d300b004daaedbfa9amr8128650vkr.15.1713743275078; Sun, 21
 Apr 2024 16:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5sdEjqMe2pMDOO4MZkuncKu5PxMvcxtXmnpjwpHSM1Ek9Hgw@mail.gmail.com>
 <ZiV0ICqUbLNsnG05@krava>
In-Reply-To: <ZiV0ICqUbLNsnG05@krava>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Sun, 21 Apr 2024 19:47:44 -0400
Message-ID: <CAE5sdEjreyioOKy2xmA5mfd4BA1+mpaA5YoaO_raeNKiv302Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Add notrace to queued_spin_lock_slowpath
 function to avoid deadlocks
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	andrii@kernel.org, Yonghong Song <yonghong.song@linux.dev>, "Craun, Milo" <miloc@vt.edu>, 
	"Sahu, Raj" <rjsu26@vt.edu>, Roop Anna <sairoop@vt.edu>, "Williams, Dan" <djwillia@vt.edu>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Apr 2024 at 16:16, Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> the patch seems to be mangled, tabs are missing
> you might find some help in Documentation/process/email-clients.rst
>
> jirka

Hi,

I have sent a revised version of the patch with v2 tag.

Thanks,
Siddharth

