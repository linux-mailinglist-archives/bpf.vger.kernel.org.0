Return-Path: <bpf+bounces-53734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86262A59863
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F21C18853A7
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35622F3A8;
	Mon, 10 Mar 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgSqzrmj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00F22F3B8
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618370; cv=none; b=M/51gVwA7ApRz6t4FUgj3ZJMOZQTL6lVLHd0GELkEvpt5XmzT7DzydIiyR5c8BdvgZiq83plgY9aJnsF3lmxGhPIYoGM+sp5FVN6ggde2bAB83QER47om5NGShYqHBEwC/7cuAy8Z1M8pljoFF+5kC+AhZbK/TiweLlJ2ZxjhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618370; c=relaxed/simple;
	bh=qrGb5lSwU6d/BiTcGEDE0iGBrg7QsIVsQ08BYads/bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrSE8KJZBqn+KNfr2GrkgiinYGhh5dohgTzFm1/cN/VkgSWfmYRAVwefXmV8/YJGurjaV6WQLeVik5YjnmCCLjzqPCqKv14Owebhci92KClQaEBwblDh2eZlYLa6oVMfxbz6n5cpflMoyKg7v8FqWec4SMe4R6XQl6Id5qAZAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgSqzrmj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741618367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tD8i+D5CkT0SBWrgEsAcKH9liSWprjwzpOukP8c/+ok=;
	b=UgSqzrmj5MOFFlMD2adbssh161Yv4+racXkh8EKXX9UiLjEiOGtrGmtkMwQ/gsZuVjzvfT
	v3J0Wx8LDZeTz9wbEXBhb1b3IBoZ+BMsexMMTeHGwA5jVVJvUR2x/qnN6O2o7VWRsxVQjZ
	1rJ1cud4Y8a3PuMHdlPSMfQbOyJ+xSc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-5FX4_I1JP66s1Ab1P8FGPw-1; Mon, 10 Mar 2025 10:52:45 -0400
X-MC-Unique: 5FX4_I1JP66s1Ab1P8FGPw-1
X-Mimecast-MFC-AGG-ID: 5FX4_I1JP66s1Ab1P8FGPw_1741618364
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39134c762ebso1201815f8f.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 07:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618364; x=1742223164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD8i+D5CkT0SBWrgEsAcKH9liSWprjwzpOukP8c/+ok=;
        b=RDU9N7Wslc/yDg98zhQ9L6yuyRs7Eo/9QQ9Szo4884GcCPot1efeCpGt8Kx/cwtnUB
         8iV58kF2Ifb0OYdbK0cmwzA3YjbHWHpVonOJpEw3fn8CtBnLAwS+J6dpCyiS9KYSwfzw
         gS/ioFpn0Y2JmK0AILTesRIbxl6rK+/TOkv7e3Omjkh3XcMu/6KJLQZzYVyYOI/J1Bty
         ONutNLpoD0rAOfyyZWAiGaD/fekTJ+EUN8n8+WPUehyEpSaI1uJcihS1RCDFcpYzGbXF
         GEIIXwAxxsTQrieXmis965CO/ofutWzol2miFlTw6ln3A8VPGHSYXWFfCKup7rqYKosU
         GeNw==
X-Forwarded-Encrypted: i=1; AJvYcCVUO9ANq4jizCjA0tx3Txm5mPtk9bvF4TN4oCr1N1EJFw9IHJ3lWNqGuWONG7w5uKYrOGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuqK2zH7lpDdbpB1ppYW0WW8VUJjVaefFkIFye4KXHuuSqj0Z4
	6667Yv4gN5Q2fb4oc0QOdQT6GlfNgfL13oa2GjkK3L9tTuzCNB7s/aQ2wlrunHlrFLE/ZcaZ36+
	kV6/AFMUyw70LKQ4Do4ue21IkbF+Qw9xP7qeyi9EttZWa6brGNQ==
X-Gm-Gg: ASbGnct31sOlKl63xVofieRjxxshnBRZHqjTroPoWmkUCJReZ4UUlErUDizqn+RwQ+U
	t4PgqkJODr8r/yHZfIL9Uozs1+E2BKVk2S4pLK+oeCJyJ8X8yiagNfgdEo8e8IUqIY6EWEnjTsM
	ZQOpB1GhRM/THHkie6xnzqMtZMlIC43mgOlidT114Ph5a7AyhXa/cboIU5NDzL0N6n65Bg+iRic
	A6XJ039VeDCTzwoEt1hRvNySQRSYKnXfg+0OAjyBhkdilC83RBpT4yRaZRoicPnxGJwlC+oSDuj
	5YE/KnvRzfrNukLxw5U0iTWqCEja9OXQF+7ypKK4Veky+K0wUmLOm74+2W3gFbTK
X-Received: by 2002:a5d:6482:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-39132dc580amr11065886f8f.43.1741618364044;
        Mon, 10 Mar 2025 07:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKpz/aRteORGLUQDVzSqjXbJRJcg6+0YPgJ4aq+417+m56Qchn6s2RgghTGP/jggl8UNdbAA==
X-Received: by 2002:a5d:6482:0:b0:38f:3e39:20ae with SMTP id ffacd0b85a97d-39132dc580amr11065841f8f.43.1741618363514;
        Mon, 10 Mar 2025 07:52:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm15532372f8f.34.2025.03.10.07.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:52:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, leonardi@redhat.com
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <fjy4jaww6xualdudevfuyoavnrbu45cg4d7erv4rttde363xfc@nahglijbl2eg>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>

On Fri, Mar 07, 2025 at 05:01:11PM +0100, Michal Luczaj wrote:
>On 3/7/25 15:35, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>> Signal delivered during connect() may result in a disconnect of an already
>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>> contract. As manifested by WARN_ON_ONCE.
>>>
>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>> related bug, which could be neatly adapted to test this bug as well.
>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>
>> Can you work with Luigi to include the changes in that series?
>
>I was just going to wait for Luigi to finish his work (no rush, really) and
>then try to parametrize it.

Sure, this is fine, thanks for that!

Stefano

>
>That is unless BPF/sockmap maintainers decide this thread's thing is a
>sockmap thing and should be in tools/testing/selftests/bpf.
>
>Below is a repro. If I'm not mistaken, it's basically what Luigi wrote,
>just sprinkled with map_update_elem() and recv().
>
>#include <stdio.h>
>#include <stdint.h>
>#include <stdlib.h>
>#include <unistd.h>
>#include <errno.h>
>#include <pthread.h>
>#include <sys/wait.h>
>#include <sys/socket.h>
>#include <sys/syscall.h>
>#include <linux/bpf.h>
>#include <linux/vm_sockets.h>
>
>static void die(const char *msg)
>{
>	perror(msg);
>	exit(-1);
>}
>
>static int sockmap_create(void)
>{
>	union bpf_attr attr = {
>		.map_type = BPF_MAP_TYPE_SOCKMAP,
>		.key_size = sizeof(int),
>		.value_size = sizeof(int),
>		.max_entries = 1
>	};
>	int map;
>
>	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
>	if (map < 0)
>		die("map_create");
>
>	return map;
>}
>
>static void map_update_elem(int fd, int key, int value)
>{
>	union bpf_attr attr = {
>		.map_fd = fd,
>		.key = (uint64_t)&key,
>		.value = (uint64_t)&value,
>		.flags = BPF_ANY
>	};
>
>	(void)syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
>}
>
>static void sighandler(int sig)
>{
>	/* nop */
>}
>
>static void *racer(void *c)
>{
>	int map = sockmap_create();
>
>	for (;;) {
>		map_update_elem(map, 0, *(int *)c);
> 		if (kill(0, SIGUSR1) < 0)
> 			die("kill");
> 	}
>}
>
>int main(void)
>{
>	struct sockaddr_vm addr = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = VMADDR_CID_LOCAL,
>		.svm_port = VMADDR_PORT_ANY
>	};
>	socklen_t alen = sizeof(addr);
>	struct sockaddr_vm bad_addr;
>	pthread_t thread;
>	int s, c;
>
>	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>	if (s < 0)
>		die("socket s");
>
>	if (bind(s, (struct sockaddr *)&addr, alen))
>		die("bind");
>
>	if (listen(s, -1))
>		die("listen");
>
>	if (getsockname(s, (struct sockaddr *)&addr, &alen))
>		die("getsockname");
>
>	bad_addr = addr;
>	bad_addr.svm_cid = 0x42424242; /* non-existing */
>
>	if (signal(SIGUSR1, sighandler) == SIG_ERR)
>		die("signal");
>
>	if (pthread_create(&thread, 0, racer, &c))
>		die("pthread_create");
>
>	for (;;) {
>		c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>		if (c < 0)
>			die("socket c");
>
>		if (!connect(c, (struct sockaddr *)&addr, alen) ||
>		    errno != EINTR)
>			goto outro;
>
>		if (!connect(c, (struct sockaddr *)&bad_addr, alen) ||
>		    errno != ESOCKTNOSUPPORT)
>			goto outro;
>
>		(void)recv(c, &(char){0}, 1, MSG_DONTWAIT);
>outro:
>		close(accept(s, NULL, NULL));
>		close(c);
>	}
>
>	return 0;
>}
>


