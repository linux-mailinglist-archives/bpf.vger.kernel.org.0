Return-Path: <bpf+bounces-26363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E689EA65
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A8B21BAB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0A29CE5;
	Wed, 10 Apr 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8FG5FY8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147020B27
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729373; cv=none; b=bFNjvUfJptk/c2oy2ri+Qh275cSBJwR7JJL3tQ0+9gvisWabBoSJ53MmPBQDGoXoLQeyNPbtW8wXSa6F+Aq+Q7IKuMPVzkMjO4l7KcswNjSQs8KbACKbf8u6wGWQlwN75AotWuIBd3/8gmhViUBofzVH2DWLNDA+3Z1yuLvLxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729373; c=relaxed/simple;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3yO6hDubn2xIfvtAcOXPmdX+vvgawaoMQEiQPktB4iV2OTVjD0n19DocS79E3jQXQaCm/CNlrMACMmU4UfvNfSuXOhy4r9+8J84INFIgqinpCp1jpJ9XsUSNSAsinTQyjj1acbznh3rIySy1oR8HMx29gAQx5EAISc0ktPKwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8FG5FY8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	b=J8FG5FY89TQS2x3QZOfSECo2JtHO3uzAk81JzlxR/1GRTfDbIlXXMU4jOZxdE9pIefsU+5
	sAmC0qiHq06XPdUPReKx+hA5RgQtXieHsSKiVrn86Y0tVkFiYYws4dwBswmZkp7StwU+Yq
	8KUQ59t/Zri3Aovq06NlElxMVih+RQU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-j-jUAXclOnmn5z8BrRQXew-1; Wed, 10 Apr 2024 02:09:29 -0400
X-MC-Unique: j-jUAXclOnmn5z8BrRQXew-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed34f8b3c8so2175122b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729368; x=1713334168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
        b=iWLCJ8kCH1yAPwd1rg7dYefbnE1TfOozlFhl0DdmH8xrsvp1nUin0rZ0NZx6g0ssNS
         U41qiv+vBwqeThivfrFQQx5Mb/6J5A+3mH/8+7ep/9exMfH+1RP7QiNhEwqz3TmIUEeD
         wuC2806xXtVSs8UkFAsmxhAeADBtVowlW0VbzPU86M8yrqPp0YtvvLAzovmc2KvisA2J
         hbGnjevUfoDv8GAchB0T900+hCt5WoU0yDRgZDtrxoOAMQeJAzwfid5OwPPy62H0kpCv
         fVayzr/KpzlLUYJ10MgYe83y1EPoauK7NAdvh9NUWL/dQuLQr0GdatlGUVbIqdx5AKjV
         H4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXydWeTrgodbte45hPnrofRrMPwQUQ+Z8J5l4k4fMkr3uPY7BZLqgFI5uPBnt0bBVVZmbtsq8CyANSy3x3US2rBKZ/O
X-Gm-Message-State: AOJu0YwxD/e7eVmuCTn9oh/W5lfBH6FTUGydbfhqB7ftIL1C7ylhSHOG
	oIlBAS1zhohLowwXWVE3YmTZ8oZBbV9qt5j+YmgShXhWgkrrLajhyEpfp7HCOBkD5iGgeAChnJ5
	nNhwqBLWKI63zzqZn6BcK72QNNWGANznUX2omsekOxwPB82rGbTB1hw56JMouPzNrbyLhchN98y
	cLvYg7+WzTlJHJjV/B/ySJV/zQ
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id le6-20020a056a21018600b001a7912c4a60mr2157249pzb.4.1712729368466;
        Tue, 09 Apr 2024 23:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU6Br+y7ZLlNLo4KSKT8o6SK3mGKJFVCb2xmJ2+EI/QnRnzH+iDld5ZX3v968qQ7jPjyAIw5rA42aTXkGCrl8=
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id
 le6-20020a056a21018600b001a7912c4a60mr2157239pzb.4.1712729368160; Tue, 09 Apr
 2024 23:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:16 +0800
Message-ID: <CACGkMEv=u19rOf_84rp3GP=FwxJ-5XAChyHwR_s_iao0xUma_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] virtio_net: remove "_queue" from ethtool -S
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The key size of ethtool -S is controlled by this macro.
>
> ETH_GSTRING_LEN 32
>
> That includes the \0 at the end. So the max length of the key name must
> is 31. But the length of the prefix "rx_queue_0_" is 11. If the queue
> num is larger than 10, the length of the prefix is 12. So the
> key name max is 19. That is too short. We will introduce some keys
> such as "gso_packets_coalesced". So we should change the prefix
> to "rx0_".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


