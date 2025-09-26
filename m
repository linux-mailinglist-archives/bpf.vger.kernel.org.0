Return-Path: <bpf+bounces-69799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E498BA207A
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614C9741383
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8738DE1;
	Fri, 26 Sep 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHRmN9zg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02B27713
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845389; cv=none; b=rZBR/aPfXbwvFzSrIW8zWcoUuyGCyfT303UG3B2eCtRBxRCOdOhZKEPwJpRLy+/zXIkrSIhFmqDPXuHM55V9TQXkgJim25ImveZWYJj2USELKjywLOdQ4PR5mJVs0TB4to/sH54E9TKYnN5H1CHnBsHgxTqyKTSre5SnzBzE+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845389; c=relaxed/simple;
	bh=EcF3KEFlgcW+csVv+7/3Ly5TOD8RBUoCKU9/CtUnizk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXtodeIxN3quAdwsL6Jx1nemyfDDakAa3YHOFEuTbrHTNafn3GxrsUwwHmEBgWX4Di5gZlxLoCdl5QD8r7Fk8aHqpJ2toSv0PR9MOQcJU1wFVHPYZqWJSlfTPRSQXZz+VsfNGnOPqZvfNSavc68unYXgmXw7awb3G1xYz1tpsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHRmN9zg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42480cb4127so17140795ab.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758845387; x=1759450187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcF3KEFlgcW+csVv+7/3Ly5TOD8RBUoCKU9/CtUnizk=;
        b=bHRmN9zge+PsOxGdMRb5SR1VLuBIWJpnT/VfGT6pOyQWkRX7IjyRiXHvqjv7ddI0lN
         qOmYCjEpkSjyNM5CuN2tnqJMwHYFGN4Lr9l2irfFbXIOBpSohqw6VrVk93BabCBE308K
         Xao6k+tYz/boDMalIHPtu+FNI9voa6R3BUhBbIjxReH51xLpJF/8/7viOqqYnoapWd8g
         KFn8ZWqfvNj9Dw2EgyexLYCvQx9LGJf07KWmQ3isrIRRAezUj6u+Q//ujXDxo/ur+zMN
         bSlTxN8TCuiuz3QDCQXMiO46l9Y8JRM+rG50SxfesAnR/zcezUOoG624YFz8VV0s3YOX
         rA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845387; x=1759450187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcF3KEFlgcW+csVv+7/3Ly5TOD8RBUoCKU9/CtUnizk=;
        b=dv8PQYHFkVEiIF0GZWKzdsiV8mmOyzODU6cP6T+V7UxlSPPkAKbnhHFHxqqrfXrwfy
         xIbqB37UcIxHmwDucjceGsUcqF2g62cJxWo3mQgGW+ey/uxde9lBtuWtt7D5l5AcKfEZ
         aqRIlwTFVdbdBDXRKX+e7GGZV2aubio+Il6h+dK5UQgEyKQHv2PnEOuVEJOJT0JU2C4t
         9ejcHqZPGJeM4XMex67Bu3NFK5Uyd3PVVzn/lYxKytYFWz9N1R99yQBGsJIxKFCHyIK2
         pMfhE0HhnanmVtrr7yceCvgS4RjTuLIiX7mnjTFojE3I9s3ssSOmZ5i7ihiffVvnBpJo
         WgZg==
X-Gm-Message-State: AOJu0YxPXkdFa6h/Ixc/8U9zhlQ8T+zONMODU8R2MIOJsaIc9wILG3Pu
	E1cvb/d67G3GV5wjVagUdFW5NytJSX0qS9RPPxzECSPi7Vmm9LHH3LpLBEfiixIMUymGOjGfIjZ
	UGL0c6nYuQ3P4M45qvQJ/WDZ5UFPzauE=
X-Gm-Gg: ASbGncte3nNwKDPSH4vXB0Migu3pqF0UUF7mrklK8ysiCzbPcPb5rQ4jRqr132gdmwo
	8Mjq65eAOLvzrIgBZOCx1g1f4RoXs5ItB+csC1iaTwzgoQZD3/dJBZDXuOaOr0reuJcVP3u7iov
	C25zZrNNgTDztl4ZSQr6mB7si/lWPBdtPWUq8zk6/pEQPkNnBJx/z22FfKow6CLed40z6bHTjbC
	yCxLA==
X-Google-Smtp-Source: AGHT+IEdUfwwxztT3hV1YzT7LIX8Z/JTiGmIH0ncgWo3wXZ3rUzN62zQT1aEcss1YIZCIF37iemyiaId0M3moPjmW8w=
X-Received: by 2002:a92:d08c:0:b0:425:8744:de9b with SMTP id
 e9e14a558f8ab-42595614302mr60924005ab.18.1758845386799; Thu, 25 Sep 2025
 17:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com> <20250925160009.2474816-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20250925160009.2474816-3-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Sep 2025 08:09:10 +0800
X-Gm-Features: AS18NWDQyjm8xJcDxkGLPrUwJvdPtkzVnU_2eax4yonamiagMhSPnDncCAnnd1M
Message-ID: <CAL+tcoCcdPYwrCUvnRFspH4CZOmia99XaW2sSe-CiGbNErnmkQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:00=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Instead of using auxiliary boolean that tracks if we are at first frag
> when gathering all elements of skb, same functionality can be achieved
> with checking if skb_shared_info::nr_frags is 0.
>
> Remove @first_frag but be careful around xsk_build_skb_zerocopy() and
> NULL the skb pointer when it failed so that common error path does not
> incorrectly interpret it during decision whether to call kfree_skb().
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

