Return-Path: <bpf+bounces-55429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85AA7F0FB
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 01:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E77A53D0
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD9224AE0;
	Mon,  7 Apr 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YwtDhTTz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312041A08A8
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068660; cv=none; b=BXhypvs17UBVolKosINI2HHwS961LhWn5ClVLQ19CFfRalB3+Ix1rjZaLEVet6YoozXJuGmg4LDglwixjWJPc/KQoVBfxfSQPzkPxFxa1BnCxkdc96NbguDX09DGa/H3Kcl9Hhf8sTu0hI7Ym5/vDWYKleeage3+uOqaWvudUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068660; c=relaxed/simple;
	bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/FT2362jWlZfIbM6B/DWKTBoq5kZPDS2E+2EnYMZFuZlr2qGwx96+gnSjjpbpFcWCBOgF44FuUM8/Dy+0J5oWEMmgqt+0ZKq8S6pMcw5k4ydmtyZviDnU6KgzKsKHfG1ONvdfLG49q3ltanH813Eg8uVE2/zCCj6LY5f3fKjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YwtDhTTz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c53c6c28c4so81273385a.2
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744068658; x=1744673458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
        b=YwtDhTTzQBPj6jf4bUHIfJ8JrbslawTGtx0iQfw3uUDNd80l9ostyQOxuo8tv5CGmz
         bz6GBI7bgjMGle1bdbKU90GviRm6UdeBb+GzUL3LWZdAkaMroRHUELSJVz6FtSwEHIka
         UIb1vVZPiIiUyEclyC3dJCTxrwqLU2VPhURzuims5DoYW4vuTcTZ0qs0JHqHW0VIbC0t
         WlddW3BlQLiL6XfBcyRvP2T0tHhZ10yRAoj2zzvyrf0F03o575t6TZX9iOXodpTyiPfm
         8Aa9zrGf3VCfBjOtj8r/sjVt20Sbi9CajVj+03k1X4iMm7ZoJf2Wtyby5YHuM2se+PHL
         17Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744068658; x=1744673458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
        b=jsbWPL/r5m3hgbJg/RaU3gmSKbFpBolg64uR1YyDUZfIcHCo5B1yguwMkOwnbTmfKV
         4ngSgNcYfMHvYkWz9mM2BUon8WE+a1RlWJ56+BeU0EaG6QChjdspOMImNrPJ6MKXqy75
         gmx+ZwCVbTk38LDKOXgriQi0ElVbO4VTNr8+PkF54QpHaSrazH9+2Awe5Uvtw83MUJdF
         XJei5PO9YAgHlnvvnDPydNAi2TL4j9FNAdNZdXX+raDRX0bOUVH+zwOk4JV5UmraY1Yf
         33PUIvr4QpNNge6S//+EVb6fNLbPUrX11z3KvOKDYl4VagLXLCe+radTQiBelc3nd7GR
         AHgw==
X-Forwarded-Encrypted: i=1; AJvYcCVeP9YWm5+GZJJcLp4/2ss05g8keIEyzTzLl4lHBAOTuPYNuou7BJ+3+exUF5UqT6ujonc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pGwDzWbcwR7LuMkcvsKYsmDn/HZJgO6cGA30XuWvgOU+ve76
	oAvGivT0ZQF8lktJBNUcLEKXOUXUMINEdjrQaA7mu7w6euZUvyy0Yg/Chf8ANAVSGSKQdgH5qH3
	oHWPexyMpEdufBxOddx5o279jjgFcQPbJeh8sHQ==
X-Gm-Gg: ASbGncvzQWcIhR0bBT0RaScRnEVWuAkM6OLFDpT+dpzdPGFlbwJkX5e8UTcRx5uRb9l
	iIVxKFeE5Pnwo9hqCh4P7NJV85Y03gAt+y1n+AiPqx5DkBnP2Z9wW40UvSdHt3CKnrMHOOnCoUe
	kcHW1jOpv+ifeH7YJFAxWGfIuiP4tMjmk1MxLE1zfqLUUEh0eiATvJopN3Ng==
X-Google-Smtp-Source: AGHT+IHhiCTRGlht8elOD+UVIUjl9aUsadYnn3EhdHTdvFS4AvvMPLcKoB1jRXmegFpEnN+3wGcgtz/u64tJZ+JrYUc=
X-Received: by 2002:ad4:5c8e:0:b0:6e8:f88f:b96a with SMTP id
 6a1803df08f44-6f00de91910mr93078266d6.1.1744068657938; Mon, 07 Apr 2025
 16:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404220221.1665428-3-jordan@jrife.io> <20250404232228.99744-1-kuniyu@amazon.com>
In-Reply-To: <20250404232228.99744-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 16:30:46 -0700
X-Gm-Features: ATxdqUEjHSDiXYJqgh7obzV9QzLEoE7sCfD1sQC-LIOJ4P8NJ52rOMS3eMphom0
Message-ID: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> We may need to iterate all visited sockets again in this bucket if all
> unvisited sockets disappear from the previous iteration.

If the next socket disappears between iterator stop and start, the
outer loop would need to keep going until it finds a socket from last
time that still exists. In most cases, it seems unlikely that the next
socket will disappear between iterator reads, so in general the outer
loop would only need to iterate once; the common case should perform
the same as before with the offset approach. The worst case indeed
would be if all the sockets disappear between reads. Then you'd have
to scan through all items in the bucket n_cookies times. Again though,
this is hopefully a rare case.

> When the number of the unvisited sockets is small like 1, the duplicated
> records will not be rare and rather more often than before ?

Sorry if I'm missing something, but what's the relationship between
the number of unvisited sockets and rarity of duplicated records?

-Jordan

