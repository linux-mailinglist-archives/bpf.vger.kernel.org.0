Return-Path: <bpf+bounces-53592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38214A56CEE
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80343188841B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC687221DA5;
	Fri,  7 Mar 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iAm6CnqF"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8421D3DD
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363288; cv=none; b=GBNe/qaFK/ONU2bmZRKPtFRRTMApkQiKUsotLM5GXU8+3+O1RnEXMksaurVE8CwLDcu608zIb/QBmjUdU0F3RuEx6aA501bEdhgX6jOII39/hRa5Yn6TSS4UtsAawXw4y75MqO18b6wkNuLx5au6ykxGZXYgPWsxQH1hbfWdNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363288; c=relaxed/simple;
	bh=rJCOlxHbfvrNj286RJQKWtI23KRMVeSeYEa5wk1Uk4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB9vyynvDotj6aTmLRnhhwVwjVjOrzm7fL0HNoFCituC+q+Gev89UXWJtSu7pzneMPxrFHv1P0j8zTdqH1Coyy4Ngz18oiRmYGxj0Gfvc6vvjWyMZ8Y6xGPf8aooM01Qi41iGQ6U322HXJVRAFx9m9FFAIG3xrZHnV+vSYk9vF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iAm6CnqF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqa8V-003sx2-R5; Fri, 07 Mar 2025 17:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=YHcxyyCv9TxOQbcYy9LzpkVMgHzsBozwm3s+VLvgWts=; b=iAm6CnqFEgxAUYuRwSR6e3/OqK
	Oyyn+IMuIfCZsWk7/CHZOooMjXCmnMhEhAjxZ4c4uuwpDpcSAlFdZ6z/yVn1FS8kRbcNJMmCRK3rf
	FUWzOokan3TT/NMcmeLL7mnUkLZ1APCNKjS0GRBwIwVnZx/3bzHWlDMtfpd2CVki8ea3issArOT4Q
	S75bQZxRkwGKA0BGttPh3duwBQRk+P2WfDQSjhhkzmaSNvULyXOyVPOM1F9diGYHEPO20C2PYVW7w
	MBLisSJBqB9HPdJaCLhherPTmiA74PPitnNlOtLcV2uPpr/PLbalSqTwGrPMsSThAA+IWWdHxOtGN
	cK1/WpJg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqa8U-0006nC-EY; Fri, 07 Mar 2025 17:01:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqa8P-008GEw-PN; Fri, 07 Mar 2025 17:01:13 +0100
Message-ID: <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
Date: Fri, 7 Mar 2025 17:01:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, leonardi@redhat.com
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 15:35, Stefano Garzarella wrote:
> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>> Signal delivered during connect() may result in a disconnect of an already
>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>> been placed in a sockmap before the connection was closed. We end up with a
>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>> contract. As manifested by WARN_ON_ONCE.
>>
>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>> related bug, which could be neatly adapted to test this bug as well.
>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
> 
> Can you work with Luigi to include the changes in that series?

I was just going to wait for Luigi to finish his work (no rush, really) and
then try to parametrize it.

That is unless BPF/sockmap maintainers decide this thread's thing is a
sockmap thing and should be in tools/testing/selftests/bpf.

Below is a repro. If I'm not mistaken, it's basically what Luigi wrote,
just sprinkled with map_update_elem() and recv().

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <linux/bpf.h>
#include <linux/vm_sockets.h>

static void die(const char *msg)
{
	perror(msg);
	exit(-1);
}

static int sockmap_create(void)
{
	union bpf_attr attr = {
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = sizeof(int),
		.value_size = sizeof(int),
		.max_entries = 1
	};
	int map;

	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
	if (map < 0)
		die("map_create");

	return map;
}

static void map_update_elem(int fd, int key, int value)
{
	union bpf_attr attr = {
		.map_fd = fd,
		.key = (uint64_t)&key,
		.value = (uint64_t)&value,
		.flags = BPF_ANY
	};

	(void)syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
}

static void sighandler(int sig)
{
	/* nop */
}

static void *racer(void *c)
{
	int map = sockmap_create();

	for (;;) {
		map_update_elem(map, 0, *(int *)c);
 		if (kill(0, SIGUSR1) < 0)
 			die("kill");
 	}
}

int main(void)
{
	struct sockaddr_vm addr = {
		.svm_family = AF_VSOCK,
		.svm_cid = VMADDR_CID_LOCAL,
		.svm_port = VMADDR_PORT_ANY
	};
	socklen_t alen = sizeof(addr);
	struct sockaddr_vm bad_addr;
	pthread_t thread;
	int s, c;

	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
	if (s < 0)
		die("socket s");

	if (bind(s, (struct sockaddr *)&addr, alen))
		die("bind");

	if (listen(s, -1))
		die("listen");

	if (getsockname(s, (struct sockaddr *)&addr, &alen))
		die("getsockname");

	bad_addr = addr;
	bad_addr.svm_cid = 0x42424242; /* non-existing */

	if (signal(SIGUSR1, sighandler) == SIG_ERR)
		die("signal");

	if (pthread_create(&thread, 0, racer, &c))
		die("pthread_create");

	for (;;) {
		c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
		if (c < 0)
			die("socket c");

		if (!connect(c, (struct sockaddr *)&addr, alen) ||
		    errno != EINTR)
			goto outro;

		if (!connect(c, (struct sockaddr *)&bad_addr, alen) ||
		    errno != ESOCKTNOSUPPORT)
			goto outro;

		(void)recv(c, &(char){0}, 1, MSG_DONTWAIT);
outro:
		close(accept(s, NULL, NULL));
		close(c);
	}

	return 0;
}


