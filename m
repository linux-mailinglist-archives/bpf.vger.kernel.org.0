Return-Path: <bpf+bounces-77391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2525CDAFD9
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5A13300789E
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16721773D;
	Wed, 24 Dec 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQLpaHYu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g62rC903"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47711F9F7A
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537575; cv=none; b=YPdBzUBwj3y9gdrLfPPxHK9ToEvcBTt8buZSdyBob7SNjj1dDchTjzTUBJ87NBipVw2PSMTXkbSPiSiMpGzT0Kxl7GPwHbW38U6/3ee/pW4pmteWDJWYn4G3IU0sXS0TLMFnM/7K7Ps6WbbGy8DD1Tx4oIt14pFekhHUjh3hzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537575; c=relaxed/simple;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqRRNEnM5KkvjKfDXamJiLyWHTG/wQoGdO9lTtBhVcAN/HSrcrMAbqmIQIjTmdwKz3Gz5RA2DHlQAhVm7ow4ZUkZUnTiqOEDdjJrtxq2a4HLHXvXQnOjeXAn/FEKhjNynRdJG0vvawY1YxUeSDkDJpVQn/UwbwvpbzE73CzrGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQLpaHYu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g62rC903; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766537572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	b=ZQLpaHYuxKWix0wOPqIluBvC3eMrwRrY3FhFandm7yAgH8AJ7Fb1+VcP/Drfmpo/s9ri1x
	PFtM4uLXalBisT4AfW6/8cWWbwoHFG3Gjw+KeMRPmxiRyUvNzdNjjOkLsLdIVdyemsRZJL
	fShjPeqpHnWhQczT4A41VBAL1H12MWw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-FjUTv0VEP8OtS1nf8in_GA-1; Tue, 23 Dec 2025 19:52:51 -0500
X-MC-Unique: FjUTv0VEP8OtS1nf8in_GA-1
X-Mimecast-MFC-AGG-ID: FjUTv0VEP8OtS1nf8in_GA_1766537570
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c5d203988so11426575a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766537570; x=1767142370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
        b=g62rC903dm8IXE2lOS4pwyMFXwnL8tdTrcPQI/x/e85UnBC8Cx+eOH6mfrDOmC5DkK
         lpE8qz+wFEhWYkW2+u3ZpU5X3b6cYrZ5ZzJEP8VZpY5+9DIYS9khyEv9Yd6iUKuE6+3S
         RPL8d7b00zraCCQw96fYTWvNfsO3/7eVLO5UAon6oq23yUfSwaXS6Y0SizuxQIvwCU+X
         ODE7KKiEqwvtmnq/GrNyxUMHiRCmCkj7vrjL9WSMo2D7y4TbM80MyY27LSZnQY+8mgQB
         1IOcFPodITXbOdIzkUFwuxYHS8cB+OKVK1rLukHTlGcHHr9msHDYFkT3RwbicK7hbhNk
         S5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766537570; x=1767142370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
        b=Fy78p1/OPlyJkoEp27/2qWLjDA26ilw+xqHukcbgGeSru+snuQdmmz5IJl4lPgQM9B
         f68kuFry7fCt7Z6ReCSDGsz2fOHIla2sgNcJK4/AYSi84a/Tn5oD375D2bEDcwDy7Sn/
         vBz8PkfeD9oLctK/0n1Hmi7WQx9ZqK+eVZyE2JWAtJ3jwtqVyBXKAIYXAHvIO6KjCQ+E
         JJgluVXrclBEqPjysGySJThsqc6oGjBBrS6AwapbdJLMn8xTCzUqtnB+nryDsCDdZpFA
         OOrgK904e9YRU0UBkiOt8AiBc+WrWLmk4FC0ZJgrBBc+h8M3Piarho6dHvnQJGvz5sO0
         jazQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9XHwXCbJTQzez6nbgSoA9uouC1LKqFVyNUSegA9wN2wlTYVTH0MRGmrkjyCF8TzEZfmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNEI/9HwmMmLxkQ/x7m348XiWRK9z2gmuAatYFoY5iMgKn9mp
	sYDPJBjL+sb1R3+VkZC0ocNHwODvhQ+OiPkfIVLQOsUSeKSDbqXFvgBUbARmFj4TFTYXXk/gkYi
	HO3SEJvCdmoClj7Ua8lpsExazeKWhxPLGCLmDSZ1M2HLkZNZuXK63K/pWsYO3mcDZWtLUf+/Hym
	h7M5EXo2MFhU28K96Np4WZitdsf97B
X-Gm-Gg: AY/fxX6ZSL5XSWpPBiN8Muh1LMNs+MARImgvuXYLKTEjFxolEUiGpgfBzfk26RBRfOI
	D17vhQKPRcyJ2msNyRsCmPyMvONwHwvCVYyEqCl53VXHfBopM4CjjtN7AGiNEjPNuTmqYoN24tV
	4G483g5nqoQkuAlwK01eUBCxVmyqcLP3c/HDG3N+QWfDGB0cF7rV1bYG0KlDmq/P86FKU=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-34e921f6feemr13113366a91.35.1766537570559;
        Tue, 23 Dec 2025 16:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF+noWfN2ySEUI8GZb3Ntf51HoydRghcYL05TuV9bQ1tdT4T7RAnx9LFZiea6uBQnWuwOmdQQ+4Kqavimq6ZU=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-34e921f6feemr13113351a91.35.1766537570192; Tue, 23 Dec 2025
 16:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com> <20251223152533.24364-2-minhquangbui99@gmail.com>
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:52:36 +0800
X-Gm-Features: AQt7F2oh4rVbS-8aQ3gvuoAlLwJB54Xn2U1CBKxMODTcXeAZWD0c1j8udrn6yHE
Message-ID: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 11:27=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, the refill work is a global delayed work for all the receive
> queues. This commit makes the refill work a per receive queue so that we
> can manage them separately and avoid further mistakes. It also helps the
> successfully refilled queue avoid the napi_disable in the global delayed
> refill work like before.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

I may miss something but I think this patch is sufficient to fix the proble=
m?

Thanks


