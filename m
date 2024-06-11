Return-Path: <bpf+bounces-31846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E783903FF0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402011F249C8
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCB28DC1;
	Tue, 11 Jun 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfERPvMJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3436AEC;
	Tue, 11 Jun 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119502; cv=none; b=pi5jPxWNLsuZhn++QnHIug37zorpg3Z8WQw9kNHCJPL9FbXAJ+y/dUAiYR31ij0Vnk6ozH4lfJ1+YewctpiKe12WLhEsbyigDgCE3ayPAU+xisbJ5SIlofEalM6gPsrS9yE37+Q4mgHZvEcTv5orXeFisj1bZT3Bgkl0brD/3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119502; c=relaxed/simple;
	bh=O1A6EIbresg0Qi18kGElLIKYlhKkknqVsrmv/n129vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC5kzpLZxOZrd8pJ1TNK3KdAlnmEWCDeLtk9LSqOyOpkPfnTg69uJzm7VN3n7PbsF7rw7aUTvLyh9R0uMJ6eULKpheQNrVenX7QKcaRCy6WZE2/prxE4/zhuJjZMFNsD+bqXsp5/gfgFJOrfg+Ixh9iA++WqprrD3+UwyB0zFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfERPvMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C08C2BD10;
	Tue, 11 Jun 2024 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718119501;
	bh=O1A6EIbresg0Qi18kGElLIKYlhKkknqVsrmv/n129vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfERPvMJ8YDbE0SPMQEY3mlvN+wv2WEoxPEoZgqCr8ICh8iBc0j6EUdVRqudBTHHR
	 QAi+3maKaru/CHJyCt0XIEN+p4PDUYI++BceEQbBDyT3wHrOS3FRY0gwW5Fer0X1eU
	 14+mK1bgsGzGuLuUW7KzkBB8NYLfHipwgU9LhtMenDDUCgOxaFjBtCHTL+UQU0JCEV
	 objpifsD7AiW6YB3dFbd78UaQf1vJx/XmMeZz1AA2nqewSwJMrsM/cHORRNWxmLTn5
	 h0fG0yrQVysLunPygE4w7w4QUpmbNgNK3Cq7/v/8WzMPKcc0vFJOr7Y2+iZQME9N6Q
	 fHeXdXJ/2YHNw==
Date: Tue, 11 Jun 2024 12:24:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	brauner@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
Message-ID: <ZmhsSF1UPcNZX8E_@x1>
References: <20240608172147.2779890-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240608172147.2779890-1-howardchu95@gmail.com>

On Sun, Jun 09, 2024 at 01:21:46AM +0800, Howard Chu wrote:
> as for the perf trace output:
> 
> before
> 
> perf $ perf trace -e faccessat2 --max-events=1
> [no output]
> 
> after
> 
> perf $ ./perf trace -e faccessat2 --max-events=1
>      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent")                               = 0

Yeah, before there is no output, after, with the following test case:

⬢[acme@toolbox c]$ cat faccessat2.c
#include <fcntl.h>            /* Definition of AT_* constants */
#include <sys/syscall.h>      /* Definition of SYS_* constants */
#include <unistd.h>
#include <stdio.h>

/* Provide own perf_event_open stub because glibc doesn't */
__attribute__((weak))
int faccessat2(int dirfd, const char *pathname, int mode, int flags)
{
	return syscall(SYS_faccessat2, dirfd, pathname, mode, flags);
}

int main(int argc, char *argv[])
{
	int err = faccessat2(123, argv[1], X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW);

	printf("faccessat2(123, %s, X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW) = %d\n", argv[1], err);
	return err;
}
⬢[acme@toolbox c]$ make faccessat2
cc     faccessat2.c   -o faccessat2
⬢[acme@toolbox c]$ ./faccessat2 bla
faccessat2(123, bla, X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW) = -1
⬢[acme@toolbox c]$

In the other terminal, as root:

root@number:~# perf trace --call-graph dwarf -e faccessat2 --max-events=1
     0.000 ( 0.034 ms): bash/62004 faccessat2(dfd: 123, filename: "bla", mode: X, flags: EACCESS|SYMLINK_NOFOLLOW) = -1 EBADF (Bad file descriptor)
                                       syscall (/usr/lib64/libc.so.6)
                                       faccessat2 (/home/acme/c/faccessat2)
                                       main (/home/acme/c/faccessat2)
                                       __libc_start_call_main (/usr/lib64/libc.so.6)
                                       __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
                                       _start (/home/acme/c/faccessat2)
root@number:~#

Now to write another test case, this time for the landlock syscall, to
test your btf_enum patch.

In the future please add the test case so that one can quickly reproduce
your testing steps.

- Arnaldo

