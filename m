Return-Path: <bpf+bounces-31416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0698FC4E3
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 09:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9082817FF
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A891F9D9;
	Wed,  5 Jun 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klgkHToY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EF18C33A;
	Wed,  5 Jun 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573571; cv=none; b=giaw3ZrRKEJ6zfqS/9NKFtG5YX+BP/9ICliohvC9qO8bWgsJsziPx2wj3K0Mvt8ZX9i3zKWxi3ITr7VbULMDzJMctE4SfzP5b/bWVt1gwjyTuEjMq/g7FImxaqeBPGpWS6cWdVJT0YQnCbkXwM+gWhnjPxLsoijJMDJWBfocfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573571; c=relaxed/simple;
	bh=F9ITJIIq9hdfN/mR4kBg18xO0qYDglJuaeDcRWanxCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUu96qQXdvamLOeHbH5/PsKTSQftzV0fnFDShiz6aten4yM3kcA9WukogEkMgwOt1BVjzHdmFRg1y89+gTTsvD6qA4/bEjoY9D2fcxje1QtkrgUbaW0lTLmIfmqB9jDQGBjb9xMvccQKCy5uM6WW+rKJhJwy51C9+cXl5TbHcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klgkHToY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ae2e6f23aaso5297816d6.3;
        Wed, 05 Jun 2024 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573569; x=1718178369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9ITJIIq9hdfN/mR4kBg18xO0qYDglJuaeDcRWanxCg=;
        b=klgkHToYgxdUWLSbpUnHgaBvhLzpQyWUbi35bj21KlblQytILitReXdMEWW/nKLVY2
         IZ6sw5tC0hFYxM/CMNFx1k68TeR+61bjZIvFh3DCGfXN46aGHqYz7d0yql6qbYAH6PZo
         gExc9lcf4Ed5lFBxN2uVXVsrCwMDiMkeX1g2gE23U4WYIofAHvJJkNVsgy/Ks/XXoiBl
         s7Kz7/m06nfiWBuU6DdT0ZOVzBICjrRHzt2Wglel3JGR9pcS5HEeKcvTMofjtJ/ZYJXb
         zOFUTwflOR+xNIdR5QZq4uQVjlqsCfPiELsGLf+seKHUrLFNzdcuWKaNW/PQ2HMSFjta
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573569; x=1718178369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9ITJIIq9hdfN/mR4kBg18xO0qYDglJuaeDcRWanxCg=;
        b=Bf/yitnbaCc86cc+2YAeZzjiUjRAgoRpZubyp9LDNRgLuYz3ofIYMywLDDZ8awdsKk
         32fjrur6QOOENpVWey6/Gm4mn0UAsN9AVZCKRaYI1Guggvpej2tE8piLxwueTt9QOwTV
         WEzJAzcfd1m9UZ6+TKZnKfhRuRvxC/vm/0BiWsA1JDmmFRzBKKEIMyx6PsYYGy/22+/r
         s1zyq14iK+6SKzQs0AoNMShnPc+6txhwCYnJHE8xbDT7NhnLaSFdSTja6Robw3rNfNkc
         Gz0BLqSBTlR8iKNVg/sZ4lB63P4rStgPyibZPSRrrkeXyjGOEvAmOXcqdJDkmOL9OTbL
         /ZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaMotjr6O+ygJXYVgm55yulqYvvff6q5Lknxe53ON5cP0L8NQOBtVcatiEO/k4fKrwE3I2aS7zEAkjKiQHQmwx8CRW+WX9iW/bLVblZuMDAdTZ0F2Cor/1Oqjp
X-Gm-Message-State: AOJu0Yygl5d1ARmUuqwBRDgqlozEVJraseoCfyUNyAjx/4cDxJk8/pjJ
	3V0pADZx19uZU7l3kayBYWDfqH9rrKsZ9hgX8FLKN1SyMghmUU4i5T1gr8jy3ic/EnyIbE1NjTO
	FKpbBTUeoplFgZuxSbIliqArcLnc=
X-Google-Smtp-Source: AGHT+IESr3H9GJblbMc9/z2kS/LDt4+1zy23PCX9fZxn+2NB9JzY3oxBCLEkRCAircFSzq6HuDZl4tb52XjlqBOX72I=
X-Received: by 2002:ad4:5dc1:0:b0:6ab:8463:4355 with SMTP id
 6a1803df08f44-6b030a57ee8mr17531576d6.3.1717573569294; Wed, 05 Jun 2024
 00:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604122927.29080-1-magnus.karlsson@gmail.com> <665f9d3ba5a1a_2c0e4d29423@willemb.c.googlers.com.notmuch>
In-Reply-To: <665f9d3ba5a1a_2c0e4d29423@willemb.c.googlers.com.notmuch>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 5 Jun 2024 09:45:58 +0200
Message-ID: <CAJ8uoz0Zfv3rsLCuza2MW7Km-eU2sH1CDB1V_WHJ2vMAft_EmQ@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] Revert "xsk: support redirect to any socket bound
 to the same umem"
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, YuvalE@radware.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 01:03, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Magnus Karlsson wrote:
> > Revert "xsk: support redirect to any socket bound to the same umem"
> >
> > This patch introduced a potential kernel crash when multiple napi
> > instances redirect to the same AF_XDP socket. By removing the
> > queue_index check, it is possible for multiple napi instances to
> > access the Rx ring at the same time, which will result in a corrupted
> > ring state which can lead to a crash when flushing the rings in
> > __xsk_flush(). This can happen when the linked list of sockets to
> > flush gets corrupted by concurrent accesses. A quick and small fix is
> > unfortunately not possible, so let us revert this for now.
>
> This is a very useful feature, to be able to use AF_XDP sockets with
> a standard RSS nic configuration.

I completely agree.

> Not all AF_XDP use cases require the absolute highest packet rate.
>
> Can this be addressed with an optional spinlock on the RxQ, only for
> this case?

Yes, or with a MPSC ring implementation.

> If there is no simple enough fix in the short term, do you plan to
> reintroduce this in another form later?

Yuval and I are looking into a solution based around an optional
spinlock since it is easier to pull off than an MPSC ring. The
discussion is on-going on the xdp-newbies list [0], but as soon as we
have a first patch, we will post it here for review and debate.

[0] https://lore.kernel.org/xdp-newbies/8100DBDC-0B7C-49DB-9995-6027F6E63147@radware.com/

