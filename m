Return-Path: <bpf+bounces-53580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB7A56A71
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22857178A6A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EAA21C165;
	Fri,  7 Mar 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5bMQGaX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127421ABB6
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358009; cv=none; b=m8i0KUbTmBzLZhV0SZlIEBg1Kx8aCmhpZY6b8zmVuZHdzpYYFpWg3WR485c/dYPTtSxqnIKmlxGu3c1Pn6TOJzlXdj0ZPcnQ+TBAZ9pkHcFtscX+BIIqFSJF67rK6VMLsvVrHFT/CqWYyvtwqSYcCvRJ31yojH8ZywViYhpt5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358009; c=relaxed/simple;
	bh=v/AgWLHrrQ2VYPYzBhWzxFlMDI2s+LOACTA+EHHN6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6o2eJXqlhbSGPGxP/L6NjwTsW0hLJuAUBr6BroDOosctR5nv20Jo/HTjc6uIL19JbVIRjy3eNsRMt/SmVOb1iUEh1D4nEPrT6MJ+x9p7GYlUSq/38o/sRqrLNdzr/eiAOIkyiv1XQNbsgSKpm2rU17ZCRWUmw+whckFBEo3gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5bMQGaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741358006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfVgJzThl6qU0ktwEkW6YL2TZPOkm5c2XUTKql/oniw=;
	b=I5bMQGaXOpCSQ10/AzK3vdtoji+7/Pfdc89OBYuruNYUh585aZCp66niVE4f6QS+h/WE2o
	UjUJGja0z6PBYIBGFrFI/uXRZzhFnKFe91TSo0vVCMTkE5VY8xUcLOkue206QIreEuY5xS
	OS14KR2ywAtFpHLETV72N1IBZ7rqTWI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-wqNW2N54POOqnYbCJuLGug-1; Fri, 07 Mar 2025 09:33:25 -0500
X-MC-Unique: wqNW2N54POOqnYbCJuLGug-1
X-Mimecast-MFC-AGG-ID: wqNW2N54POOqnYbCJuLGug_1741358004
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab397fff5a3so326629466b.1
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 06:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358004; x=1741962804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfVgJzThl6qU0ktwEkW6YL2TZPOkm5c2XUTKql/oniw=;
        b=D4AbQYfjr1pG6pP4vDgbsqXzRSHkGJQ2xijV9aN1I0hlcTmGYiWK8oSbGlUWU6q7N6
         znAJzkrZcTXznneLv7E6AVKaVfoVg9cxyJ2/Ygqb4RP6fvgwvkoNxAbkSzZJ/Z3GynIz
         KOWyCuze0lWGlQzAAeQZJ6zgewV5x8J6M/XMPGj+2IjG6DGT/xOHJ7uuJZ9hZAMqwiJt
         DfAwYrx5ZXiAaGp3zMRjWTAQdFCPtEXt1MWOLr0ADM/YHsNf6layX2q38dehSfJeXwxz
         oHLlXi/QCUuvi6MCPFSS2mVA231gLNXh4NckHp0PNeH/5EDIvmZAk6B9H9vHIZilUjHD
         O6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW154pKZjWfuZgQneFPY9b83C9SwRFvz+l52CZbY6V3nYanV/H1xvrRhWoiW5pHliNzbVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWmVnmvI6fC7mnd2CCrm/t1GHPqr2oh358r8VZdLZjvVEyt+r
	Bk7PDRFwRMH/xVXGAu1w1HhvF3L67fVH8StH7DLnz+8OMz+2v8Sl2G9ywH/2qNPnjxaf63jv+dh
	7/tLBMK//dM0byqaUsw0O+4ZGhu+IZfuYK0KxGpWM3p5Rs7BbiQ==
X-Gm-Gg: ASbGncvfP4fyC6XuxfS82svajw/WJRfkYJEEccJX3DfwlhTRjCySuRCYi4KmZuWt27o
	phxxluEYglNia8p668qyG7mKD++xOXgmn9fqt57i1kMP82oUYo21GSvl+tnLccjQOR4sia0mco+
	QR5jIryiMDBeVwfLUmeJOxslKAa7R6V/yTH2ua7q4MJEhtOHDMzerLzdm6Kigfe+48sJ6OLEkWN
	MoQg48anpu34DUBStsF95O9/OzBYh0v1EXtoGdNg6JY29+48aEe/axH7+DKAJogxd+2fITeXRzq
	D4t9IE/rIlLYzTpla2wF81rp/RqWKOCRWF0ggHmyNXM9s2wUTy3cocOctR3nAZDi
X-Received: by 2002:a17:907:2cc2:b0:abf:427f:7216 with SMTP id a640c23a62f3a-ac22ca6bc71mr833960466b.1.1741358003935;
        Fri, 07 Mar 2025 06:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiQh441xM59qwFfF090OJlmAEuZlCdwlXxiHvCJYadWEnvU/ClOU1kiRzHG6fq22dRMTrpPw==
X-Received: by 2002:a17:907:2cc2:b0:abf:427f:7216 with SMTP id a640c23a62f3a-ac22ca6bc71mr833955566b.1.1741358003319;
        Fri, 07 Mar 2025 06:33:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239736389sm284326566b.103.2025.03.07.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:33:22 -0800 (PST)
Date: Fri, 7 Mar 2025 15:33:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>

On Fri, Mar 07, 2025 at 10:27:50AM +0100, Michal Luczaj wrote:
>Signal delivered during connect() may result in a disconnect of an already
>TCP_ESTABLISHED socket. Problem is that such established socket might have
>been placed in a sockmap before the connection was closed. We end up with a
>SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>contract. As manifested by WARN_ON_ONCE.
>
>Ensure the socket does not stay in sockmap.
>
>WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
> sock_recvmsg+0x1b2/0x220
> __sys_recvfrom+0x190/0x270
> __x64_sys_recvfrom+0xdc/0x1b0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c  | 10 +++++++++-
> net/vmw_vsock/vsock_bpf.c |  1 +
> 2 files changed, 10 insertions(+), 1 deletion(-)

I can't see this patch on the virtualization ML, are you using 
get_maintainer.pl?

$ ./scripts/get_maintainer.pl -f net/vmw_vsock/af_vsock.c
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VM SOCKETS (AF_VSOCK))
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK))
linux-kernel@vger.kernel.org (open list)

BTW the patch LGTM, thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7742a9ae0131310bba197830a241541b2cde6123..e5a6d1d413634f414370595c02bcd77664780d8e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1581,7 +1581,15 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>+			if (sk->sk_state == TCP_ESTABLISHED) {
>+				/* Might have raced with a sockmap update. */
>+				if (sk->sk_prot->unhash)
>+					sk->sk_prot->unhash(sk);
>+
>+				sk->sk_state = TCP_CLOSING;
>+			} else {
>+				sk->sk_state = TCP_CLOSE;
>+			}
> 			sock->state = SS_UNCONNECTED;
> 			vsock_transport_cancel_pkt(vsk);
> 			vsock_remove_connected(vsk);
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 07b96d56f3a577af71021b1b8132743554996c4f..c68fdaf09046b68254dac3ea70ffbe73dfa45cef 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -127,6 +127,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
> {
> 	*prot        = *base;
> 	prot->close  = sock_map_close;
>+	prot->unhash = sock_map_unhash;
> 	prot->recvmsg = vsock_bpf_recvmsg;
> 	prot->sock_is_readable = sk_msg_is_readable;
> }
>
>---
>base-commit: b1455a45afcf789f98032ec93c16fea0facdec93
>change-id: 20250305-vsock-trans-signal-race-d62f7718d099
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


