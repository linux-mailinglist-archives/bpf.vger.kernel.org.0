Return-Path: <bpf+bounces-14551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B977E6384
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 07:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF28DB21001
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9430D511;
	Thu,  9 Nov 2023 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUljgCGP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C1D287
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 06:04:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069E26A9
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 22:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699509894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6wrZg34sE5o38Zaav9BWJ8hWp0kxsaPC0/Swy66yu0=;
	b=OUljgCGP+k2EkaoxkeK2u+ewClKbbNURF7jUaHwJSxK7zIyBR0Ga+2O7/9aDu67C33m3ax
	oMloJqbdZj+0DpeDVv17ccVpJ8Pe9zsjhe/GCD5hQzmNvoO7jkn/hqY/jRbU7GlnqQicKd
	RhbBkqPRhH+D4/JKyFsQoTFzpKYplng=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-HTZH-S29Oxysv-svaX489A-1; Thu, 09 Nov 2023 01:04:52 -0500
X-MC-Unique: HTZH-S29Oxysv-svaX489A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507c4c57567so462206e87.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 22:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699509891; x=1700114691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6wrZg34sE5o38Zaav9BWJ8hWp0kxsaPC0/Swy66yu0=;
        b=Bsu2MZGLdTZq/jD2mryBpp1MJcXp/1IYrNqI5TUZld8veXhaeQyVlQlXdR/uYlgdRJ
         KFQkUIxIdvzdFtl+ikWljTiuHq0kNzQ6h5iq5UhVeS7O9MOR8I7Ge79XHkmUNeTauVpp
         EAZghVb60WNwbVnZEJduMsIfIc/SDryKyRq+aSYiw1dID63T/VF+GHWHTDQUdrFQKxkF
         CPY1OqiP2Ajx0Frw2e+lI00M/c/1DGHyKa/76x/C9lyZg/Lm/pHZ6V2lEpJhjgZ/waMg
         3WEci2AIdvAHVte4pc9og3qoB3hnRBeFEJ0PWQdOdR3mZwRe/q15FzfUqWa1VNZsEiz/
         oO9Q==
X-Gm-Message-State: AOJu0Yxr/yIo5ebTxa0aSwAIuzX2zSjzzgS9eII/0ztOoJ78bg0F8W6n
	thkX4/cFVptGONnueYmOwC20N2Nn5PwNubfD3RTUgBZERaFKgpxfD1/4IKZ9xr7uMSSW6dew42G
	7C3bdTqmLIAoDIvjmVTjG1SeOh0dr
X-Received: by 2002:a19:650c:0:b0:509:441d:9bea with SMTP id z12-20020a19650c000000b00509441d9beamr452199lfb.20.1699509891468;
        Wed, 08 Nov 2023 22:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzAjRQa0dfmmCDvdNARnAGJRrXV4D+3px8+TEbwSfElPkxyFVVMRozlkpArRetiFj2ltXw02BBEZNBlzFA+Z0=
X-Received: by 2002:a19:650c:0:b0:509:441d:9bea with SMTP id
 z12-20020a19650c000000b00509441d9beamr452182lfb.20.1699509891176; Wed, 08 Nov
 2023 22:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:04:40 +0800
Message-ID: <CACGkMEtUwfkyx-V-h_PjeGoVZz8Wu50yBRXHkDNTPgJQjzmvJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/21] virtio_net: add prefix virtnet to all
 struct inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:13=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> We move some structures to the header file, but these structures do not
> prefixed with virtnet. This patch adds virtnet for these.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


