Return-Path: <bpf+bounces-41926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF299DB73
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B841C21786
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B016BE0B;
	Tue, 15 Oct 2024 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+J/hCpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A15531B;
	Tue, 15 Oct 2024 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955854; cv=none; b=tSQT+SO8yTfVKngC6or5vPvKDZCJVM71C670yR4Mv9xmkBa7WHkwQ8RVRhlIdYOscAkgJ7QdCt+3EJB8R5mjNrdry1BZplVU20YLAeTUV/ALsBoIO7dPpqvrHWcta2RIuJ8O7UdKziB3bANJ7hfhjltNM+XTQNs4swBITqiOOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955854; c=relaxed/simple;
	bh=ONwEt1qF2gnrKk8AYHsw2vANXqRWmSlSBZHZSf2w5NU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o3yUnONvOC3hm2XqxAGz/kfvycMc8KKjg6t96goSBjTIgQc64JKotbiAKc9leJGhQJJ4GRv8GYiudgo2inC/hPulho5ERohTxSq2pUYNyuxP+JJe1aDJRmmbtE564uNHFZbKzDuKwvnamG0S56IGALAPypLYHWoGYzMLdQHNZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+J/hCpq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so37899506d6.3;
        Mon, 14 Oct 2024 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728955852; x=1729560652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMGHn90jdK1Apdx6ox+0iliPpJbyfHmeOMFwrILCXrk=;
        b=D+J/hCpqBla4okiweOPXHqw2pZr4zJiqKyFLadML8NSmrBv+P7BjsvK2EW+JvDJzxh
         PqDHjqf3KyUHhiPlnNppNV/qxDXzdlVBeO9dZWNceiXyke2OaRN9TC/BWM/uwjdLh/pF
         8919+cP9/C3yQUa/dfWZa60Gqn403u/jfUaxXHeX+iBEgxJD6KMhibuIKx5yRrpBM8Fs
         YHMLPR5wSPLAJCWkCxQmQEIJeHuKtyXwJe2kWqcGuQbwhYW6YPnJ3jH8XWb5RxYuWjiB
         RigAns1sdslnbP3buWO5e4+MdEoPmJo9q1vkzdIAbxcfqeENCJ9G6B6hQByZ17A0CDRT
         XtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955852; x=1729560652;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LMGHn90jdK1Apdx6ox+0iliPpJbyfHmeOMFwrILCXrk=;
        b=CsWhuQFofx0uu2PXxGwGV93FeYGzm474jurIWZkvzZZlN/N8aixU5qfH9pKBLnJYUK
         5ghUywHpsgmn6X2KrThDpF6xsZkkWtDEZ6lapXhp0SnF6Wv8hVMMiW7+Lu6HZkciOv8v
         9n6RySOI9k5mrxq6i3NbVCjDvPCSvPGuUxT02qyu48n0wMhigGSIxLWLSZyV+1NPG97C
         ldNw8pr2IYWU3O+Pt89bW/UQ05wCze3XMkozSowO4qHSwXYfl4mVtppL2jAFjho3PkJd
         LAF/2hoeOC0uNfD8Ycju8Eu63Nt3CYmPzkfs7TO5RwB497s35bvAF1WhHpu5I+YvXgaB
         gnaw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhR8OYXnaBOapOoLXgXIMQx4whIC1n+OIJrAO6YjOEhKP4kUzLM8m1BHxbv//Z/CQtCdwB5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxmQoMl8N+vTHAXm7Slzu0WLuI9anutTy+nmEBg4b43cubIYV
	Ilyx7HReRfyd/MOIKrM8guPxJIbATlvugoqFKgZDSo2eckZB4FfD
X-Google-Smtp-Source: AGHT+IGWNmu38/JGic1tS6JUWwL04UT03YEF6hrgrIMa7SB5gYtRN5ap+Uf6ck786HKewFOn2jWHEw==
X-Received: by 2002:a05:6214:43c1:b0:6cb:98d3:3e67 with SMTP id 6a1803df08f44-6cbf007c225mr212672146d6.53.1728955851681;
        Mon, 14 Oct 2024 18:30:51 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292e964sm1403136d6.59.2024.10.14.18.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:30:51 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:30:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dc5cab30f5_2e1742294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-2-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 01/12] net-timestamp: introduce socket tsflag
 requestors
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> We need a separate tsflag to control bpf extension feature so that
> we will not affect the behaviors of existing applications.
> 
> The idea of introducing requestors for better extension (not only
> serving bpf extension) comes from Vadim Fedorenko.

As also said in the cover letter: I prefer sk_tstflags_bpf.

This array approach adds code churn, may have cacheline effects by
moving other fields and anticipates I don't see a third requestor
happening. And if it does, we'll deal with it then.

