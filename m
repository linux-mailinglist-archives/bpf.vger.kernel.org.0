Return-Path: <bpf+bounces-70944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08744BDBB92
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C61B18A2244
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23D2DCC1A;
	Tue, 14 Oct 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iV86aDRd"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F717A2EA
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483369; cv=none; b=fmN5iPurUCs2lUKxz7EJIHdxg79arI1tMi1XUZB5kQfh4wWg+/cUJAtSrqssEOELaNzr5OL2WsxEYpG1sr9lNBcuVqwC/fdxURkJCh0uCjcz8Ti2JnH8QuMDiVV/VxvXaYkR28r8LJ1JLtYsWnm+PL26Nx5t098nsSkL7qu9/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483369; c=relaxed/simple;
	bh=vu4nw3WfFop+3BzE1QhLywGaWk937F1FIkK9sJLlHE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfGBgou0bg2+BN8etvsj2zb5DjggPbmgskEqAk1LvrzCc2s7BH+Nc678su6vyFhrhg1crmUW6vWq3Q4/Mr9kDPUdg98/k2Sl8hwZbv9Mwq+Fjfest3WVfKaqubi/vlQwHOwb7lCiJsGQcHC0eyWnleGvi8Y97NIcl5jNxdjUlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iV86aDRd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6e790a70-bb02-47d2-9330-f2eb9078c671@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760483355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMZ0tOuQFw64RjaBh1c7+1IgZYvZYBxMu7v4FXEnQN8=;
	b=iV86aDRdppgZQ/WU9jXSXqShVzK2luXQE4yXHNRZgnZER6MIr+lUj34Ro8z6cbdzLLheAU
	mgjofJUcKZ7i4aIKrpo6ICf66xoqS5+8y7pWx5ex9ThsIW4N8w22qCg0jp7Nk1yNqHhlXV
	PEd9fvo+MAW6ffmFPeqBRedAO7TVO5c=
Date: Tue, 14 Oct 2025 16:09:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 6/6] selftest: bpf: Add test for
 sk->sk_bypass_prot_mem.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251007001120.2661442-1-kuniyu@google.com>
 <20251007001120.2661442-7-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251007001120.2661442-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> +static int tcp_create_sockets(struct test_case *test_case, int sk[], int len)
> +{
> +	int server, i;
> +
> +	server = start_server(test_case->family, test_case->type, NULL, 0, 0);
> +	ASSERT_GE(server, 0, "start_server_str");
> +
> +	/* Keep for-loop so we can change NR_SOCKETS easily. */
> +	for (i = 0; i < len; i += 2) {
> +		sk[i] = connect_to_fd(server, 0);
> +		if (sk[i] < 0) {
> +			ASSERT_GE(sk[i], 0, "connect_to_fd");
> +			return sk[i];

The "server" fd is leaked, and...

> +		}
> +
> +		sk[i + 1] = accept(server, NULL, NULL);
> +		if (sk[i + 1] < 0) {
> +			ASSERT_GE(sk[i + 1], 0, "accept");
> +			return sk[i + 1];

same here.

> +		}
> +	}
> +
> +	close(server);
> +
> +	return 0;
> +}
> +
> +static int udp_create_sockets(struct test_case *test_case, int sk[], int len)
> +{
> +	int i, j, err, rcvbuf = BUF_TOTAL;
> +
> +	/* Keep for-loop so we can change NR_SOCKETS easily. */
> +	for (i = 0; i < len; i += 2) {
> +		sk[i] = start_server(test_case->family, test_case->type, NULL, 0, 0);
> +		if (sk[i] < 0) {
> +			ASSERT_GE(sk[i], 0, "start_server");
> +			return sk[i];
> +		}
> +
> +		sk[i + 1] = connect_to_fd(sk[i], 0);
> +		if (sk[i + 1] < 0) {
> +			ASSERT_GE(sk[i + 1], 0, "connect_to_fd");
> +			return sk[i + 1];
> +		}
> +
> +		err = connect_fd_to_fd(sk[i], sk[i + 1], 0);
> +		if (err) {
> +			ASSERT_EQ(err, 0, "connect_fd_to_fd");
> +			return err;
> +		}
> +
> +		for (j = 0; j < 2; j++) {
> +			err = setsockopt(sk[i + j], SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
> +			if (err) {
> +				ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)");
> +				return err;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +


> +
> +static int check_bypass(struct test_case *test_case,
> +			struct sk_bypass_prot_mem *skel, bool bypass)
> +{
> +	char buf[BUF_SINGLE] = {};
> +	long memory_allocated[2];
> +	int sk[NR_SOCKETS] = {};
> +	int err, i, j;
> +
> +	err = test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
> +	if (err)
> +		goto close;
> +
> +	memory_allocated[0] = test_case->get_memory_allocated(test_case, skel);
> +
> +	/* allocate pages >= NR_PAGES */
> +	for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +		for (j = 0; j < NR_SEND; j++) {
> +			int bytes = send(sk[i], buf, sizeof(buf), 0);
> +
> +			/* Avoid too noisy logs when something failed. */
> +			if (bytes != sizeof(buf)) {
> +				ASSERT_EQ(bytes, sizeof(buf), "send");
> +				if (bytes < 0) {
> +					err = bytes;
> +					goto drain;
> +				}
> +			}
> +		}
> +	}
> +
> +	memory_allocated[1] = test_case->get_memory_allocated(test_case, skel);
> +
> +	if (bypass)
> +		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "bypass");
> +	else
> +		ASSERT_GT(memory_allocated[1], memory_allocated[0] + NR_PAGES, "no bypass");
> +
> +drain:
> +	if (test_case->type == SOCK_DGRAM) {
> +		/* UDP starts purging sk->sk_receive_queue after one RCU
> +		 * grace period, then udp_memory_allocated goes down,
> +		 * so drain the queue before close().
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +			for (j = 0; j < NR_SEND; j++) {
> +				int bytes = recv(sk[i], buf, 1, MSG_DONTWAIT | MSG_TRUNC);
> +
> +				if (bytes == sizeof(buf))
> +					continue;
> +				if (bytes != -1 || errno != EAGAIN)
> +					PRINT_FAIL("bytes: %d, errno: %s\n", bytes, strerror(errno));
> +				break;
> +			}
> +		}
> +	}
> +
> +close:
> +	for (i = 0; i < ARRAY_SIZE(sk); i++)
> +		close(sk[i]);

It could close(0) here depending on how the "->create_sockets()" above has 
failed. The fd 0 could be something useful for the test_progs.

Other than that, the set lgtm. Please re-spin and carry the review/ack tags.

pw-bot: cr

> +
> +	return err;
> +}
> +

