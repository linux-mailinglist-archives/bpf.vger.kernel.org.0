Return-Path: <bpf+bounces-30086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1A8CA6B5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 05:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A25282757
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F861BF37;
	Tue, 21 May 2024 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEKqPsHI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439BBA53
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261309; cv=none; b=BI1ah40e7cP3C1MTwWVXqxyXPPdWekZec5xyx9WqkMSulnNAHmtZUSCRDSQe/GbpPFrFSyvWcJ4U1h5DFwhyKng6slVcuA2IPImf3//hDKA1esyfqwRkgxgiL2bTx3AZAU8ZCYFlRYGL16+TL6ZN412Rv4MtZm/gORtqvyiGQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261309; c=relaxed/simple;
	bh=iHysDecOttwIFdH4smp5oFCmHAlrwA4qmEKVYK8hNXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QI+Lqgx60JHoefTmp9jsTTzXagvF2JDjzy/DwW3ADhaSsenbGMfkxSsAmpHKXs3B5/amty+gp0jX5Fq9VW/VFSwzqxJhg6BywNEA864BJE0escHBPpTnCuZZ8bBBA/Fev9cZ+/yQzK4azpPALyJ+h51Gs1vaWwXOWslQCKwONIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEKqPsHI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f3efd63657so11387028b3a.2
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716261306; x=1716866106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rofaiJOkgI0u+L/hMvBVHKuVQV1ohwi1Ww3tpTCPoc=;
        b=WEKqPsHICbdHC+l/VUDZS3nNWmJqL/kiYS7/NkUQLg2apGruvHTt63lxSzy6TBEa6p
         W7Fi0AAZtFeRjymM7PBoHiQkQAdcz9WDWDyAK1TxCoYjm53faw6leNCt6umwPA64qYV4
         zofyQgU95Fmhc87Zkr8keQbCKpf4rrUm+9yEvZxhOa183XAtf1hjtiF7mVKxnZu1Wqsf
         VM/LURlmIWP4GCVXfz6/A+duHuXYToBLHwJhaOHImDomCT7m7KOSn0XfJJ0+btIKy0s1
         +kEfhte//Gwu6Jx2I1sQPDGpZOsI1mWTH7S3r9JV9PkjHwKvvVCDk6ADKn4SOzaX+zE5
         1How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261306; x=1716866106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rofaiJOkgI0u+L/hMvBVHKuVQV1ohwi1Ww3tpTCPoc=;
        b=RhvH2Giq06b4NLwjZz9/zG1KUpCixkrnMRk5kHjHDtnD7ldiVlmE2747XB9+TzLEqc
         xlrAIM0tJ2gA+aF3QOOO2/VF60EpYrOWRoO47Np41Ert/aQoHextGIsKwsnfqlFZtUTg
         ciYnOnm8XNnrpLKFzEz8bVwKU7vS6sYjpyzY6IYBxuGi237QdryGe8Gam7f/yEpJjSSh
         9y9FhR6RZWTA97a03alHdwMH1BAJNp+8W8MicRQ3LmmmFBTd/kEbhWYN3FVU2WGq0TMJ
         ZDAyuIXTgLRsA39rxiUs16DMYa4KBjEcbvm1INkyKp0D1da4wI8pX95v9b3lvgueKtX+
         usUg==
X-Forwarded-Encrypted: i=1; AJvYcCUh383cPoQUBZrghECGUWRKZRoQ/84wuuh0ggFwlmQzYwLwBsNiGWRkZtlycpRV0hAZ5U3ILjiXzbEsYeyBjd9VLRB+
X-Gm-Message-State: AOJu0YzvkR1RwyLMDJMIoZLXSV8qxmpvU3xvM717uXY17Of1LUojud6U
	0OPiVXtosazQqLhJpHlutVmX1YqttsP210lH4IfNDODEFnOlr3ahr0nhlql0UhGOUA==
X-Google-Smtp-Source: AGHT+IFSnTDwSKRETum7a5rl6TifbFmC49dhr+wfOyP2QWT5i+3rjrf5XuyAJDIr716nOVQXixFr0bc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1384:b0:6ec:f5b8:58cc with SMTP id
 d2e1a72fcca58-6f4e0395b9dmr1224901b3a.6.1716261306229; Mon, 20 May 2024
 20:15:06 -0700 (PDT)
Date: Mon, 20 May 2024 20:15:04 -0700
In-Reply-To: <20240510192412.3297104-18-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com> <20240510192412.3297104-18-amery.hung@bytedance.com>
Message-ID: <ZkwRuEExDs8QnVu1@google.com>
Subject: Re: [RFC PATCH v8 17/20] selftests: Add a basic fifo qdisc test
From: Stanislav Fomichev <sdf@google.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="utf-8"

On 05/10, Amery Hung wrote:
> This selftest shows a bare minimum fifo qdisc, which simply enqueues skbs
> into the back of a bpf list and dequeues from the front of the list.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_qdisc_common.h    |  23 +++
>  .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  83 +++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> new file mode 100644
> index 000000000000..295d0216e70f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -0,0 +1,161 @@
> +#include <linux/pkt_sched.h>
> +#include <linux/rtnetlink.h>
> +#include <test_progs.h>
> +
> +#include "network_helpers.h"
> +#include "bpf_qdisc_fifo.skel.h"
> +
> +#ifndef ENOTSUPP
> +#define ENOTSUPP 524
> +#endif
> +
> +#define LO_IFINDEX 1
> +
> +static const unsigned int total_bytes = 10 * 1024 * 1024;
> +static int stop;
> +
> +static void *server(void *arg)
> +{
> +	int lfd = (int)(long)arg, err = 0, fd;
> +	ssize_t nr_sent = 0, bytes = 0;
> +	char batch[1500];
> +
> +	fd = accept(lfd, NULL, NULL);
> +	while (fd == -1) {
> +		if (errno == EINTR)
> +			continue;
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	if (settimeo(fd, 0)) {
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	while (bytes < total_bytes && !READ_ONCE(stop)) {
> +		nr_sent = send(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_sent == -1 && errno == EINTR)
> +			continue;
> +		if (nr_sent == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_sent;
> +	}
> +
> +	ASSERT_EQ(bytes, total_bytes, "send");
> +
> +done:
> +	if (fd >= 0)
> +		close(fd);
> +	if (err) {
> +		WRITE_ONCE(stop, 1);
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +static void do_test(char *qdisc)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
> +			    .attach_point = BPF_TC_QDISC,
> +			    .parent = TC_H_ROOT,
> +			    .handle = 0x8000000,
> +			    .qdisc = qdisc);
> +	struct sockaddr_in6 sa6 = {};
> +	ssize_t nr_recv = 0, bytes = 0;
> +	int lfd = -1, fd = -1;
> +	pthread_t srv_thread;
> +	socklen_t addrlen = sizeof(sa6);
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	WRITE_ONCE(stop, 0);
> +
> +	err = bpf_tc_hook_create(&hook);
> +	if (!ASSERT_OK(err, "attach qdisc"))
> +		return;
> +
> +	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_NEQ(lfd, -1, "socket")) {
> +		bpf_tc_hook_destroy(&hook);
> +		return;
> +	}
> +
> +	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (!ASSERT_NEQ(fd, -1, "socket")) {
> +		bpf_tc_hook_destroy(&hook);
> +		close(lfd);
> +		return;
> +	}
> +
> +	if (settimeo(lfd, 0) || settimeo(fd, 0))
> +		goto done;
> +
> +	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
> +	if (!ASSERT_NEQ(err, -1, "getsockname"))
> +		goto done;
> +
> +	/* connect to server */
> +	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
> +	if (!ASSERT_NEQ(err, -1, "connect"))
> +		goto done;
> +
> +	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
> +	if (!ASSERT_OK(err, "pthread_create"))
> +		goto done;
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1)
> +			break;
> +		bytes += nr_recv;
> +	}
> +
> +	ASSERT_EQ(bytes, total_bytes, "recv");
> +
> +	WRITE_ONCE(stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> +
> +done:
> +	close(lfd);
> +	close(fd);
> +
> +	bpf_tc_hook_destroy(&hook);
> +	return;
> +}
> +
> +static void test_fifo(void)
> +{
> +	struct bpf_qdisc_fifo *fifo_skel;
> +	struct bpf_link *link;
> +
> +	fifo_skel = bpf_qdisc_fifo__open_and_load();
> +	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		bpf_qdisc_fifo__destroy(fifo_skel);
> +		return;
> +	}
> +
> +	do_test("bpf_fifo");
> +
> +	bpf_link__destroy(link);
> +	bpf_qdisc_fifo__destroy(fifo_skel);
> +}
> +
> +void test_bpf_qdisc(void)
> +{
> +	if (test__start_subtest("fifo"))
> +		test_fifo();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> new file mode 100644
> index 000000000000..96ab357de28e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> @@ -0,0 +1,23 @@
> +#ifndef _BPF_QDISC_COMMON_H
> +#define _BPF_QDISC_COMMON_H
> +
> +#define NET_XMIT_SUCCESS        0x00
> +#define NET_XMIT_DROP           0x01    /* skb dropped                  */
> +#define NET_XMIT_CN             0x02    /* congestion notification      */
> +
> +#define TC_PRIO_CONTROL  7
> +#define TC_PRIO_MAX      15
> +
> +void bpf_skb_set_dev(struct sk_buff *skb, struct Qdisc *sch) __ksym;
> +u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
> +void bpf_skb_release(struct sk_buff *p) __ksym;
> +void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
> +void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
> +bool bpf_qdisc_find_class(struct Qdisc *sch, u32 classid) __ksym;
> +int bpf_qdisc_create_child(struct Qdisc *sch, u32 min,
> +			   struct netlink_ext_ack *extack) __ksym;
> +int bpf_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch, u32 classid,
> +		      struct bpf_sk_buff_ptr *to_free_list) __ksym;
> +struct sk_buff *bpf_qdisc_dequeue(struct Qdisc *sch, u32 classid) __ksym;
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> new file mode 100644
> index 000000000000..433fd9c3639c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> @@ -0,0 +1,83 @@
> +#include <vmlinux.h>
> +#include "bpf_experimental.h"
> +#include "bpf_qdisc_common.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> +
> +private(B) struct bpf_spin_lock q_fifo_lock;
> +private(B) struct bpf_list_head q_fifo __contains_kptr(sk_buff, bpf_list);
> +
> +unsigned int q_limit = 1000;
> +unsigned int q_qlen = 0;
> +
> +SEC("struct_ops/bpf_fifo_enqueue")
> +int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> +	     struct bpf_sk_buff_ptr *to_free)
> +{
> +	q_qlen++;
> +	if (q_qlen > q_limit) {
> +		bpf_qdisc_skb_drop(skb, to_free);
> +		return NET_XMIT_DROP;
> +	}

[..]

> +	bpf_spin_lock(&q_fifo_lock);
> +	bpf_list_excl_push_back(&q_fifo, &skb->bpf_list);
> +	bpf_spin_unlock(&q_fifo_lock);

Can you also expand a bit on the locking here and elsewhere? And how it
interplays with TCQ_F_NOLOCK?

As I mentioned at lsfmmbpf, I don't think there is a lot of similar
locking in the existing C implementations? So why do we need it here?

