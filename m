Return-Path: <bpf+bounces-49405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC6A182E9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B418B3A3822
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC61F560C;
	Tue, 21 Jan 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0FcVJz6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782881F543E
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480628; cv=none; b=F0uAceK67VAMY6YXHqZwvfeTXtBBOhcsWHuQ6IcBDArn7/5X+fK6+WjF3iWvoGwtg4lLNePwYSa15nyRSyJzvDK0qJZ2zK6eqHSvamkQ7gfp2LRBfcIH42j6f0iJnmnTZLYmzWsiSH/njmDKdwqkjN/WeTv8MO0GHxaqwzuZiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480628; c=relaxed/simple;
	bh=+XqZ2mIVewpWYnLioiQaGxFPazonOEuVdIMJXoMPQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkSFdYeJQTlgTV8uGOYekJpCj7yOQqNxTdgUk3h7P1uABsd51O8S2EyhkEDbQNgVVfDv/lXF4i2uoBtTgCQbJN1arLsizxLt+Dvclb0S3yg/Gr4UMFJSsAyItpEmv/D5JjWR69/B6JXEpMEmBTEeRhpWlcnCNnKe4GyhVsz/Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0FcVJz6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737480625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ohl61oQvrjRs6MMIBMI/1E+/f+GFIL7csbNfKFkQbk=;
	b=M0FcVJz6XTC0/RXi48r0DJX0aWTxYzAxXp+4iTluzZG1u8ErryjuBkds2ibEL2SPU3mQK+
	aSzmxJcTnSOJ1MbHrDvKNCrEy/YzLsE1UuROgVZNr7st3jrr0zyWg20W6Sk+G5tGs0JZYO
	ePX1BJfv+5BI9K1zmlw6YYxMOTvsANk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-3WJUYiJZNQi6XDMUBaqFQg-1; Tue, 21 Jan 2025 12:30:23 -0500
X-MC-Unique: 3WJUYiJZNQi6XDMUBaqFQg-1
X-Mimecast-MFC-AGG-ID: 3WJUYiJZNQi6XDMUBaqFQg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43624b08181so43335e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 09:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480622; x=1738085422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ohl61oQvrjRs6MMIBMI/1E+/f+GFIL7csbNfKFkQbk=;
        b=SNvaPfdQ0+J8nqdllu9cxIOlHYej2DH5OK3jfg3alvEaYrU+brKuecn364ybUfO0Xe
         +H0rv6mOPR5mAjTZlmAGQ03WP89PlQ+V41xI6TvOjnzCwh3DKEgBfuKFwmcMyhzcGC1z
         CfrbvPX0v/7CjYi0qVqouA9Nl7sadeoqitkMibVC6ndbfxMhdFpic8F04XKmGYGNf7GV
         6NiNDDtraiQKURNReYguSV61bzOQVV+9H1IRiblCVLy62W7E74ie3TP32g5cXAt4qePS
         HHWf6+wtIhsmlMIoZL3r2Bti6XITJT/yr9WUGEfBQEyUTiH2FG/m4UlvYtqXqwCH/c1p
         riFw==
X-Forwarded-Encrypted: i=1; AJvYcCVYOCBbNVV/YjCZI6R8q+MnMCy3+qyc5PVubfm5Kwm1uqFW/8bdypw1Q2BTi16nxNFBVjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELxgUeraFcDECIE/2QVWF8TIf7W06M4rokY70F13OLA6/GO8o
	CuI7nuXicsrcOnoeGtfyzsfli9fgFjhmoMGToE9JELZPbrf9YQcn2EahIrK4c0x4SO0yRaw+Mox
	0+bqThU68bS0NMV+Gt0Ye7J1/zqNF0Kgc9l3NTnmTqFHOMtcChw==
X-Gm-Gg: ASbGncsprhXkGNy4Ww1zL4aPRGz+xR5zASwoDWeg5Ju8ioe31MFyM6eXN7gceDKDcNO
	200eDYR7o/Gn2n1VdKIBLJ093hT98QtqNRw6x13lJyNBBLsLnqaGGuWzQymvUBJa53mFcrxMfii
	xMk7KaQSM4XI0nwJJiVlWr0qltA4Ij1J4tihZtBiSqZy2yFui36fZ1GhsNK8ZG3xj8OWw47hHf+
	/MzoqvHziDOU885wLuI3Ym9F8QV0+hFjrUwSeXMgJ9BGevJoUvi2MPuhrNf+e14BSDhh4ck/A==
X-Received: by 2002:a05:600c:3d89:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43892806237mr136001285e9.5.1737480622518;
        Tue, 21 Jan 2025 09:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOXs9Ya5kOuP/W2rM4xk+vm5PSiTxIW1zce/YaupUUzohswvYEtJM6u59IjkgPls10nttGDQ==
X-Received: by 2002:a05:600c:3d89:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43892806237mr136000975e9.5.1737480622163;
        Tue, 21 Jan 2025 09:30:22 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm190273065e9.5.2025.01.21.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:30:21 -0800 (PST)
Date: Tue, 21 Jan 2025 18:30:19 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <blvbtr3c7uxtbspbfwrobfk7qdukz6nst2bnomoxbltst2yhkm@47k6evsdceeg>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. 
>Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.
>
>That said, when I apply this patch, but drop the `sk->sk_state !=
>TCP_LISTEN &&`: no more splats.
>
Hi Michal,

I think it would be nice to have this test in the vsock test suite.  
WDYT? If you don't have any plans to port this to C, I can take care of 
it :)

Cheers,
Luigi


