Return-Path: <bpf+bounces-10907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23F7AF5BE
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 23:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52D9D284512
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADB4A550;
	Tue, 26 Sep 2023 21:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF444A52E
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 21:35:23 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E216E9C
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:35:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4bd6905aso157112647b3.3
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695764120; x=1696368920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jP/3l20q4cmJeUJEOiPdOqwschqpcs+QMox+RO44YzI=;
        b=wijFVfwBs2JlWUuBx+FvoW2zEO+V8RBH1XfyjsW8jeRrJ6Wc5fT5EEY2yVceDxRmUB
         vqZZoznRIkvZcEavN8a341EinKVAglRO9yIAbert9dIBWTo1r2txBbGXfNpDUKtDaWsg
         w5x5Ass8ybsW2SwiQIaEyWY1INsJfdvVc1RW6LDj0fJBupmt2jZhK9VQ+X5WfvosDPog
         pHW1LQEl4ezQixgZGZ/KOpToj7IrjgD7ZuY6HeVdMcBiChb9Tme60E2TX1qpkJgsBZOV
         RPU0cFnS0KT3TWoRQqxoqrTag7NLam6r37yEX85cRNjx0MRqDEJKjvBXGj1cYngt+Eq/
         WhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764120; x=1696368920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jP/3l20q4cmJeUJEOiPdOqwschqpcs+QMox+RO44YzI=;
        b=ePx44mKFnssA61nEmqVJKqhu/deAL2OkX1Z3Fww4z2AgNXkU52h2aBUYYlSbo5EwYU
         EFNP9N7lZJHQmStCL4jRhIzZdOyeSlW55ZqaXxvGuoCPxDDA6nZvnwStAl4lwY0KNOZC
         mDkTFYCWr2UlYW28Hyg3Yc34ePPUlW9R/5acgRr2ghDRwHAr2cW5gB1VJfoQSn5uf3gq
         utfi3jfF6wFXxQdGVHK4O9cQdIS6biISuKmTiLqN+jn0u9ahrolR7PKmFPSd17v/SIOu
         iZgh1Ep4PZa9e/mkAwnZDEAn6RWNxTUDj9Vv5jnQf6jYqQSXYg60kTfCiVaPqMsoPmjr
         ZCTA==
X-Gm-Message-State: AOJu0YwdzN8cBRDFyscBn4CnCW/set2VMFEzvVgzcG4GoEzkCEeww3OZ
	0Uc3lhreEK0rVxkEuuwVKOGyvwM=
X-Google-Smtp-Source: AGHT+IFNcELhqN8EuhZbVyT32gCvl5RwkmGGRugGxRYwjXLBFu83Sq7Ys0P/z2CEcPqKL+MjC1zEMns=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ac49:0:b0:59e:ee51:52a1 with SMTP id
 z9-20020a81ac49000000b0059eee5152a1mr2145ywj.10.1695764120414; Tue, 26 Sep
 2023 14:35:20 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:35:18 -0700
In-Reply-To: <20230926055913.9859-8-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-8-daniel@iogearbox.net>
Message-ID: <ZRNOlsMhyILat405@google.com>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Add netlink helper library
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com, donald.hunter@gmail.com, kuba@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/26, Daniel Borkmann wrote:
> Add a basic netlink helper library for the BPF selftests. This has been
> taken and cut down/cleaned up from iproute2. More can be added at some
> later point in time when needed, but for now this covers basics such as
> device creation which we need for BPF selftests / BPF CI.

Should the netlink code be based on ynl
(https://lore.kernel.org/all/20230825122756.7603-1-donald.hunter@gmail.com/)?
Or it doesn't have full rtnl support yet?

> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/bpf/Makefile          |  19 +-
>  tools/testing/selftests/bpf/netlink_helpers.c | 358 ++++++++++++++++++
>  tools/testing/selftests/bpf/netlink_helpers.h |  46 +++
>  3 files changed, 418 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 47365161b6fc..b8186ceb31dc 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -579,11 +579,20 @@ endef
>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR := prog_tests
>  TRUNNER_BPF_PROGS_DIR := progs
> -TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
> -			 network_helpers.c testing_helpers.c		\
> -			 btf_helpers.c flow_dissector_load.h		\
> -			 cap_helpers.c test_loader.c xsk.c disasm.c	\
> -			 json_writer.c unpriv_helpers.c 		\
> +TRUNNER_EXTRA_SOURCES := test_progs.c		\
> +			 cgroup_helpers.c	\
> +			 trace_helpers.c	\
> +			 network_helpers.c	\
> +			 testing_helpers.c	\
> +			 btf_helpers.c		\
> +			 cap_helpers.c		\
> +			 unpriv_helpers.c 	\
> +			 netlink_helpers.c	\
> +			 test_loader.c		\
> +			 xsk.c			\
> +			 disasm.c		\
> +			 json_writer.c 		\
> +			 flow_dissector_load.h	\
>  			 ip_check_defrag_frags.h
>  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>  		       $(OUTPUT)/liburandom_read.so			\
> diff --git a/tools/testing/selftests/bpf/netlink_helpers.c b/tools/testing/selftests/bpf/netlink_helpers.c
> new file mode 100644
> index 000000000000..caf36eb1d032
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netlink_helpers.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Taken & modified from iproute2's libnetlink.c
> + * Authors: Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <time.h>
> +#include <sys/socket.h>
> +
> +#include "netlink_helpers.h"
> +
> +static int rcvbuf = 1024 * 1024;
> +
> +void rtnl_close(struct rtnl_handle *rth)
> +{
> +	if (rth->fd >= 0) {
> +		close(rth->fd);
> +		rth->fd = -1;
> +	}
> +}
> +
> +int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
> +		      int protocol)
> +{
> +	socklen_t addr_len;
> +	int sndbuf = 32768;
> +	int one = 1;
> +
> +	memset(rth, 0, sizeof(*rth));
> +	rth->proto = protocol;
> +	rth->fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, protocol);
> +	if (rth->fd < 0) {
> +		perror("Cannot open netlink socket");
> +		return -1;
> +	}
> +	if (setsockopt(rth->fd, SOL_SOCKET, SO_SNDBUF,
> +		       &sndbuf, sizeof(sndbuf)) < 0) {
> +		perror("SO_SNDBUF");
> +		goto err;
> +	}
> +	if (setsockopt(rth->fd, SOL_SOCKET, SO_RCVBUF,
> +		       &rcvbuf, sizeof(rcvbuf)) < 0) {
> +		perror("SO_RCVBUF");
> +		goto err;
> +	}
> +
> +	/* Older kernels may no support extended ACK reporting */
> +	setsockopt(rth->fd, SOL_NETLINK, NETLINK_EXT_ACK,
> +		   &one, sizeof(one));
> +
> +	memset(&rth->local, 0, sizeof(rth->local));
> +	rth->local.nl_family = AF_NETLINK;
> +	rth->local.nl_groups = subscriptions;
> +
> +	if (bind(rth->fd, (struct sockaddr *)&rth->local,
> +		 sizeof(rth->local)) < 0) {
> +		perror("Cannot bind netlink socket");
> +		goto err;
> +	}
> +	addr_len = sizeof(rth->local);
> +	if (getsockname(rth->fd, (struct sockaddr *)&rth->local,
> +			&addr_len) < 0) {
> +		perror("Cannot getsockname");
> +		goto err;
> +	}
> +	if (addr_len != sizeof(rth->local)) {
> +		fprintf(stderr, "Wrong address length %d\n", addr_len);
> +		goto err;
> +	}
> +	if (rth->local.nl_family != AF_NETLINK) {
> +		fprintf(stderr, "Wrong address family %d\n",
> +			rth->local.nl_family);
> +		goto err;
> +	}
> +	rth->seq = time(NULL);
> +	return 0;
> +err:
> +	rtnl_close(rth);
> +	return -1;
> +}
> +
> +int rtnl_open(struct rtnl_handle *rth, unsigned int subscriptions)
> +{
> +	return rtnl_open_byproto(rth, subscriptions, NETLINK_ROUTE);
> +}
> +
> +static int __rtnl_recvmsg(int fd, struct msghdr *msg, int flags)
> +{
> +	int len;
> +
> +	do {
> +		len = recvmsg(fd, msg, flags);
> +	} while (len < 0 && (errno == EINTR || errno == EAGAIN));
> +	if (len < 0) {
> +		fprintf(stderr, "netlink receive error %s (%d)\n",
> +			strerror(errno), errno);
> +		return -errno;
> +	}
> +	if (len == 0) {
> +		fprintf(stderr, "EOF on netlink\n");
> +		return -ENODATA;
> +	}
> +	return len;
> +}
> +
> +static int rtnl_recvmsg(int fd, struct msghdr *msg, char **answer)
> +{
> +	struct iovec *iov = msg->msg_iov;
> +	char *buf;
> +	int len;
> +
> +	iov->iov_base = NULL;
> +	iov->iov_len = 0;
> +
> +	len = __rtnl_recvmsg(fd, msg, MSG_PEEK | MSG_TRUNC);
> +	if (len < 0)
> +		return len;
> +	if (len < 32768)
> +		len = 32768;
> +	buf = malloc(len);
> +	if (!buf) {
> +		fprintf(stderr, "malloc error: not enough buffer\n");
> +		return -ENOMEM;
> +	}
> +	iov->iov_base = buf;
> +	iov->iov_len = len;
> +	len = __rtnl_recvmsg(fd, msg, 0);
> +	if (len < 0) {
> +		free(buf);
> +		return len;
> +	}
> +	if (answer)
> +		*answer = buf;
> +	else
> +		free(buf);
> +	return len;
> +}
> +
> +static void rtnl_talk_error(struct nlmsghdr *h, struct nlmsgerr *err,
> +			    nl_ext_ack_fn_t errfn)
> +{
> +	fprintf(stderr, "RTNETLINK answers: %s\n",
> +		strerror(-err->error));
> +}
> +
> +static int __rtnl_talk_iov(struct rtnl_handle *rtnl, struct iovec *iov,
> +			   size_t iovlen, struct nlmsghdr **answer,
> +			   bool show_rtnl_err, nl_ext_ack_fn_t errfn)
> +{
> +	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
> +	struct iovec riov;
> +	struct msghdr msg = {
> +		.msg_name	= &nladdr,
> +		.msg_namelen	= sizeof(nladdr),
> +		.msg_iov	= iov,
> +		.msg_iovlen	= iovlen,
> +	};
> +	unsigned int seq = 0;
> +	struct nlmsghdr *h;
> +	int i, status;
> +	char *buf;
> +
> +	for (i = 0; i < iovlen; i++) {
> +		h = iov[i].iov_base;
> +		h->nlmsg_seq = seq = ++rtnl->seq;
> +		if (answer == NULL)
> +			h->nlmsg_flags |= NLM_F_ACK;
> +	}
> +	status = sendmsg(rtnl->fd, &msg, 0);
> +	if (status < 0) {
> +		perror("Cannot talk to rtnetlink");
> +		return -1;
> +	}
> +	/* change msg to use the response iov */
> +	msg.msg_iov = &riov;
> +	msg.msg_iovlen = 1;
> +	i = 0;
> +	while (1) {
> +next:
> +		status = rtnl_recvmsg(rtnl->fd, &msg, &buf);
> +		++i;
> +		if (status < 0)
> +			return status;
> +		if (msg.msg_namelen != sizeof(nladdr)) {
> +			fprintf(stderr,
> +				"Sender address length == %d!\n",
> +				msg.msg_namelen);
> +			exit(1);
> +		}
> +		for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
> +			int len = h->nlmsg_len;
> +			int l = len - sizeof(*h);
> +
> +			if (l < 0 || len > status) {
> +				if (msg.msg_flags & MSG_TRUNC) {
> +					fprintf(stderr, "Truncated message!\n");
> +					free(buf);
> +					return -1;
> +				}
> +				fprintf(stderr,
> +					"Malformed message: len=%d!\n",
> +					len);
> +				exit(1);
> +			}
> +			if (nladdr.nl_pid != 0 ||
> +			    h->nlmsg_pid != rtnl->local.nl_pid ||
> +			    h->nlmsg_seq > seq || h->nlmsg_seq < seq - iovlen) {
> +				/* Don't forget to skip that message. */
> +				status -= NLMSG_ALIGN(len);
> +				h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
> +				continue;
> +			}
> +			if (h->nlmsg_type == NLMSG_ERROR) {
> +				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
> +				int error = err->error;
> +
> +				if (l < sizeof(struct nlmsgerr)) {
> +					fprintf(stderr, "ERROR truncated\n");
> +					free(buf);
> +					return -1;
> +				}
> +				if (error) {
> +					errno = -error;
> +					if (rtnl->proto != NETLINK_SOCK_DIAG &&
> +					    show_rtnl_err)
> +						rtnl_talk_error(h, err, errfn);
> +				}
> +				if (i < iovlen) {
> +					free(buf);
> +					goto next;
> +				}
> +				if (error) {
> +					free(buf);
> +					return -i;
> +				}
> +				if (answer)
> +					*answer = (struct nlmsghdr *)buf;
> +				else
> +					free(buf);
> +				return 0;
> +			}
> +			if (answer) {
> +				*answer = (struct nlmsghdr *)buf;
> +				return 0;
> +			}
> +			fprintf(stderr, "Unexpected reply!\n");
> +			status -= NLMSG_ALIGN(len);
> +			h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
> +		}
> +		free(buf);
> +		if (msg.msg_flags & MSG_TRUNC) {
> +			fprintf(stderr, "Message truncated!\n");
> +			continue;
> +		}
> +		if (status) {
> +			fprintf(stderr, "Remnant of size %d!\n", status);
> +			exit(1);
> +		}
> +	}
> +}
> +
> +static int __rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
> +		       struct nlmsghdr **answer, bool show_rtnl_err,
> +		       nl_ext_ack_fn_t errfn)
> +{
> +	struct iovec iov = {
> +		.iov_base	= n,
> +		.iov_len	= n->nlmsg_len,
> +	};
> +
> +	return __rtnl_talk_iov(rtnl, &iov, 1, answer, show_rtnl_err, errfn);
> +}
> +
> +int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
> +	      struct nlmsghdr **answer)
> +{
> +	return __rtnl_talk(rtnl, n, answer, true, NULL);
> +}
> +
> +int addattr(struct nlmsghdr *n, int maxlen, int type)
> +{
> +	return addattr_l(n, maxlen, type, NULL, 0);
> +}
> +
> +int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data)
> +{
> +	return addattr_l(n, maxlen, type, &data, sizeof(__u8));
> +}
> +
> +int addattr16(struct nlmsghdr *n, int maxlen, int type, __u16 data)
> +{
> +	return addattr_l(n, maxlen, type, &data, sizeof(__u16));
> +}
> +
> +int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data)
> +{
> +	return addattr_l(n, maxlen, type, &data, sizeof(__u32));
> +}
> +
> +int addattr64(struct nlmsghdr *n, int maxlen, int type, __u64 data)
> +{
> +	return addattr_l(n, maxlen, type, &data, sizeof(__u64));
> +}
> +
> +int addattrstrz(struct nlmsghdr *n, int maxlen, int type, const char *str)
> +{
> +	return addattr_l(n, maxlen, type, str, strlen(str)+1);
> +}
> +
> +int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data,
> +	      int alen)
> +{
> +	int len = RTA_LENGTH(alen);
> +	struct rtattr *rta;
> +
> +	if (NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len) > maxlen) {
> +		fprintf(stderr, "%s: Message exceeded bound of %d\n",
> +			__func__, maxlen);
> +		return -1;
> +	}
> +	rta = NLMSG_TAIL(n);
> +	rta->rta_type = type;
> +	rta->rta_len = len;
> +	if (alen)
> +		memcpy(RTA_DATA(rta), data, alen);
> +	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
> +	return 0;
> +}
> +
> +int addraw_l(struct nlmsghdr *n, int maxlen, const void *data, int len)
> +{
> +	if (NLMSG_ALIGN(n->nlmsg_len) + NLMSG_ALIGN(len) > maxlen) {
> +		fprintf(stderr, "%s: Message exceeded bound of %d\n",
> +			__func__, maxlen);
> +		return -1;
> +	}
> +
> +	memcpy(NLMSG_TAIL(n), data, len);
> +	memset((void *) NLMSG_TAIL(n) + len, 0, NLMSG_ALIGN(len) - len);
> +	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + NLMSG_ALIGN(len);
> +	return 0;
> +}
> +
> +struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type)
> +{
> +	struct rtattr *nest = NLMSG_TAIL(n);
> +
> +	addattr_l(n, maxlen, type, NULL, 0);
> +	return nest;
> +}
> +
> +int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest)
> +{
> +	nest->rta_len = (void *)NLMSG_TAIL(n) - (void *)nest;
> +	return n->nlmsg_len;
> +}
> diff --git a/tools/testing/selftests/bpf/netlink_helpers.h b/tools/testing/selftests/bpf/netlink_helpers.h
> new file mode 100644
> index 000000000000..68116818a47e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netlink_helpers.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef NETLINK_HELPERS_H
> +#define NETLINK_HELPERS_H
> +
> +#include <string.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +
> +struct rtnl_handle {
> +	int			fd;
> +	struct sockaddr_nl	local;
> +	struct sockaddr_nl	peer;
> +	__u32			seq;
> +	__u32			dump;
> +	int			proto;
> +	FILE			*dump_fp;
> +#define RTNL_HANDLE_F_LISTEN_ALL_NSID		0x01
> +#define RTNL_HANDLE_F_SUPPRESS_NLERR		0x02
> +#define RTNL_HANDLE_F_STRICT_CHK		0x04
> +	int			flags;
> +};
> +
> +#define NLMSG_TAIL(nmsg) \
> +	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
> +
> +typedef int (*nl_ext_ack_fn_t)(const char *errmsg, uint32_t off,
> +			       const struct nlmsghdr *inner_nlh);
> +
> +int rtnl_open(struct rtnl_handle *rth, unsigned int subscriptions)
> +	      __attribute__((warn_unused_result));
> +void rtnl_close(struct rtnl_handle *rth);
> +int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
> +	      struct nlmsghdr **answer)
> +	      __attribute__((warn_unused_result));
> +
> +int addattr(struct nlmsghdr *n, int maxlen, int type);
> +int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data);
> +int addattr16(struct nlmsghdr *n, int maxlen, int type, __u16 data);
> +int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data);
> +int addattr64(struct nlmsghdr *n, int maxlen, int type, __u64 data);
> +int addattrstrz(struct nlmsghdr *n, int maxlen, int type, const char *data);
> +int addattr_l(struct nlmsghdr *n, int maxlen, int type, const void *data, int alen);
> +int addraw_l(struct nlmsghdr *n, int maxlen, const void *data, int len);
> +struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type);
> +int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest);
> +#endif /* NETLINK_HELPERS_H */
> -- 
> 2.34.1
> 

