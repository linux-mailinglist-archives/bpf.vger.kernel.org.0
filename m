Return-Path: <bpf+bounces-53841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20AA5C9F9
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5707AD20F
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1725F7AD;
	Tue, 11 Mar 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWMJqefC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FEBE67;
	Tue, 11 Mar 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708628; cv=none; b=QMhrMrgb+LxIVK58q91xSWT8uVYPztpALXY9Rz4uMzu8ho7ijH4ISLV0sVJFoSj7cyQfYfrhA+HC08cCmA9eTqs40OTnYu4jN8EHfo6qvV8LpnfOsNvTxfRLNcxOub3y9yyvyL9fu7ViInIee5vE7a/SOv/xev46z1QQA3xr424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708628; c=relaxed/simple;
	bh=QlFbW1bJ+IJ20Ouvv0kgNJs8mTzYsRoSP6URexPhDYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0jTK62qmtLAUi/mu+h2IZ1ZNbVdw2dBG+vqK1qgmwyScyHFG6ih5WUkWC9xt0PfwknyvefgkA+DsxtkrQ5rIXnlCjurO7Imq0fHJttEihdoDh+qFk5mnWYDUN6bRroJdTQNA585cSxFANvG2a1lmc83urZLDswF2hypvhMBho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWMJqefC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so8540853a91.0;
        Tue, 11 Mar 2025 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741708626; x=1742313426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+j3TYJXdICnVRoNLJB0zASuwptCb9/IvvAbijCtphS8=;
        b=aWMJqefC2VlvxLB0PzUOVDsF6kmNqeKbwlIWe8xquMgJ8OE314XbA1hOX3+LVLO7qq
         s4Tkp9AcSS95wKyIF+hRVIPUV8ILfoiKRRYnOyA89gbtPuMKmdhqBfilIyt5Ylbq8lQJ
         wcSvJh6n5frZpwghbC0qcBDgeDBdyscYBurbrJdRHGIL4J3alZEMFQ+USc36zYJ7k0uP
         958Hdu7kL6OXkpZ/9Zzxpgp6rNHsjnDj0JftjS/sIWCS409YdpdpE0TkDGgcRHwVXKRM
         rn7JeE5on3Afkg9NZnUgyI+RlucWQVpcfSPryLDr76KSZiuB3XO1RpY0QAmB6qId269N
         LBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708626; x=1742313426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j3TYJXdICnVRoNLJB0zASuwptCb9/IvvAbijCtphS8=;
        b=H37TttlkqxUjWjjO3F5o0gDjx1USdfWOyGREuXNmCnXNKIBOC5JjlLqE/MPV8TwqyE
         Ffyjj+JIlNE2m/fG8pFSiyvjZxrzlP+wy5LaCLdUOMXYjwehZztgIildHGXjHWuAqSxO
         7anYTkgB6rsi44Jd406kJDOY28ILJjyPh3VD3Zx+96DW5T2JLCb8qUut9LZCYCxuAzvV
         KqtCrpIPztMbcxAiR13U0PnSWNDd+/MCycqMgHqDWHCzeByT9iVWoD7yuV5tBqQO3CMt
         uo3sF+yfOFEgN+XEsrNDkKe1fUU/xgpjQ+5/qTpj1JkUC8Tfbj5XBeV5b2YWUYYgZzcD
         cT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8aX41A7BYTTvUZvEkk7xszFLJlSkEGapaIhw9kmwuot8LiWNL9Rrzw6UQGJCXeV12vp+UbEv@vger.kernel.org, AJvYcCXfsWXL2Tum0WkmmhgC4P+v41dxKKnvvYcTisu7PmygXIptOXAiInvg8UgqrV/+3iixRIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxpO+v9qbVKPybnuK/6kUZHOWt9N3cDL8F99uWQLZj6vPG+hH
	xA/HXyOU8acfAk+wqDoabmEVI0nC/O5zSG1I7l1HJ8K+2t7qQmGz
X-Gm-Gg: ASbGncsfAD/LARAxp2l3P8e1jU3/PrPEjw3HUhZNfiJSXWx9zPt3XACBGEre/P4fuyg
	weslIfDFOtHFt7Eg7mR8IDuB3Smd+LcCzn0wXG5n/wbZtxjApPNIH6Hx/kAdRTg3cQxbJjpZN0o
	bdVDq7zh+vj3tyis58Gecv69+xhI/r3eRXEBge+5nKoYuArgTj0paQyCdfI6sgb4MnqDkBI6nWI
	Ss7q/Y1nuBoAQfeIrAyoG1bj40wU9EJCSsUVriWuihf6CyBT+xStyKSXPR0h+OXXwJj1AMYI6mx
	XfSxCKRXtCWCAZWnLC3YMBRSsmkqXFQn0dMeD5wLHiyVwA==
X-Google-Smtp-Source: AGHT+IFYbgtcxfa+3fpDq4hN0+IISGQSz8qI8vUC1mCL5BDKbh31A4QE7MkSLgsaWy7Zw5rRpjXz0A==
X-Received: by 2002:a17:90b:180a:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-300ff10d6aemr5537484a91.20.1741708626259;
        Tue, 11 Mar 2025 08:57:06 -0700 (PDT)
Received: from gmail.com ([98.97.37.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6cefb8f1sm11012911a91.18.2025.03.11.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:57:05 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:56:59 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, leonardi@redhat.com
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <20250311155601.eui5j2lta3q46i6u@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>

On 2025-03-07 17:01:11, Michal Luczaj wrote:
> On 3/7/25 15:35, Stefano Garzarella wrote:
> > On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
> >>> Signal delivered during connect() may result in a disconnect of an already
> >>> TCP_ESTABLISHED socket. Problem is that such established socket might have
> >>> been placed in a sockmap before the connection was closed. We end up with a
> >>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
> >>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
> >>> contract. As manifested by WARN_ON_ONCE.
> >>
> >> Note that Luigi is currently working on a (vsock test suit) test[1] for a
> >> related bug, which could be neatly adapted to test this bug as well.
> >> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
> > 
> > Can you work with Luigi to include the changes in that series?
> 
> I was just going to wait for Luigi to finish his work (no rush, really) and
> then try to parametrize it.
> 
> That is unless BPF/sockmap maintainers decide this thread's thing is a
> sockmap thing and should be in tools/testing/selftests/bpf.

I think it makes sense to pull into selftests/bpf then it would get run
from BPF CI so we can ensure BPF changes will keep this working
correctly.

I guess the trick would be to see how long to run racer to get the
warning but also not hang the CI. If you run it for 5 seconds or so
does it trip? Or are you running this for minutes?

If it takes too long to run it could be put into test_sockmap which
has longer running things already. We also have some longer TCP
compliance tests that would be good to start running in public somehow
so might think a bit more how the infra for testing is going in
sockmap side.

Thanks!

> 
> Below is a repro. If I'm not mistaken, it's basically what Luigi wrote,
> just sprinkled with map_update_elem() and recv().
> 
> #include <stdio.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <pthread.h>
> #include <sys/wait.h>
> #include <sys/socket.h>
> #include <sys/syscall.h>
> #include <linux/bpf.h>
> #include <linux/vm_sockets.h>
> 
> static void die(const char *msg)
> {
> 	perror(msg);
> 	exit(-1);
> }
> 
> static int sockmap_create(void)
> {
> 	union bpf_attr attr = {
> 		.map_type = BPF_MAP_TYPE_SOCKMAP,
> 		.key_size = sizeof(int),
> 		.value_size = sizeof(int),
> 		.max_entries = 1
> 	};
> 	int map;
> 
> 	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> 	if (map < 0)
> 		die("map_create");
> 
> 	return map;
> }
> 
> static void map_update_elem(int fd, int key, int value)
> {
> 	union bpf_attr attr = {
> 		.map_fd = fd,
> 		.key = (uint64_t)&key,
> 		.value = (uint64_t)&value,
> 		.flags = BPF_ANY
> 	};
> 
> 	(void)syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
> }
> 
> static void sighandler(int sig)
> {
> 	/* nop */
> }
> 
> static void *racer(void *c)
> {
> 	int map = sockmap_create();
> 
> 	for (;;) {
> 		map_update_elem(map, 0, *(int *)c);
>  		if (kill(0, SIGUSR1) < 0)
>  			die("kill");
>  	}
> }
> 
> int main(void)
> {
> 	struct sockaddr_vm addr = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = VMADDR_CID_LOCAL,
> 		.svm_port = VMADDR_PORT_ANY
> 	};
> 	socklen_t alen = sizeof(addr);
> 	struct sockaddr_vm bad_addr;
> 	pthread_t thread;
> 	int s, c;
> 
> 	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
> 	if (s < 0)
> 		die("socket s");

This would likely be a good test for all protocol types to stress test
the update/connect/close flow. If we can land it in selftests/bpf I
would be happy to make it run for TCP and others.

It might be worth looking over ./tools/testing/selftests/bpf/test_sockmap.c
and see if any tests from there should run for AF_VSOCK as well.

> 
> 	if (bind(s, (struct sockaddr *)&addr, alen))
> 		die("bind");
> 
> 	if (listen(s, -1))
> 		die("listen");
> 
> 	if (getsockname(s, (struct sockaddr *)&addr, &alen))
> 		die("getsockname");
> 
> 	bad_addr = addr;
> 	bad_addr.svm_cid = 0x42424242; /* non-existing */
> 
> 	if (signal(SIGUSR1, sighandler) == SIG_ERR)
> 		die("signal");
> 
> 	if (pthread_create(&thread, 0, racer, &c))
> 		die("pthread_create");
> 
> 	for (;;) {
> 		c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
> 		if (c < 0)
> 			die("socket c");
> 
> 		if (!connect(c, (struct sockaddr *)&addr, alen) ||
> 		    errno != EINTR)
> 			goto outro;
> 
> 		if (!connect(c, (struct sockaddr *)&bad_addr, alen) ||
> 		    errno != ESOCKTNOSUPPORT)
> 			goto outro;
> 
> 		(void)recv(c, &(char){0}, 1, MSG_DONTWAIT);
> outro:
> 		close(accept(s, NULL, NULL));
> 		close(c);
> 	}
> 
> 	return 0;
> }
> 
> 

