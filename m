Return-Path: <bpf+bounces-47813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4379A00217
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B3A7A1A3A
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D4130AF6;
	Fri,  3 Jan 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3XVIhQ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9D3CF73
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735864978; cv=none; b=f4nWB/2ME4HuHR+7jTJPBGRb2qxqbz3WuIXyxE2STlxjH8KsYczDJ6dFZqNj+Kw0gV9CSqBp3dowdIBvq7Y2sgE9sLdLJAdmjAFkUQGXnom8iDlmEH2dijExHlcHOwktOKT8bjoG25N1TRMxgAZyV4eInHLbSL7Q8OWNsNqronk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735864978; c=relaxed/simple;
	bh=58RyrTRVMjKJBN/v3kJdUkvQ05FK9PeMp5VhuDyRu+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOU6riUIP3B11KIbCattM1CdJkEe5PvYyKU9gvm4hYj2rrF0wZF0CC1Q28QGmToRJK291d+cdCRInK3utn3wCizkSPlOSFt5aQIz0a4L+zJeAzeM33kJfWzaBq4odVJauJNzvl31IdCI10kz6ivpq9sMVVmxwe4WCgeGoYHAJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3XVIhQ1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so204203925ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 16:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735864976; x=1736469776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wlvj/EdcXrxs2bTGZMSFUMuOGQ64ak+ztyBapKeTHGw=;
        b=m3XVIhQ1+24JB5ubDMh93jsfv4Fle8T/5+piOr4iGVi50brQVYZKLmPG2PeooGli4Q
         DBHYRShy18ul5lsiRLzDZen+bZnAUEdtKFCPmDDfKbvzbz+dRRzlhAaqVpdJDMOnxS8Z
         Tqm3WwD2taV+Fe8DiFfBlodjmmjQRm1FpI6RYNyc5l2Y3XYuPavdUHj/61b/mAJMN84q
         4AabVw0HNEuLMHBzl8TthsqtB5SEjK5nctj6Mrt6xwQPEvkJJtTrCnGnCN4yKEB65Da7
         Rg5uJoq69OSy794HWVBsCAYOVZeoNjZlS8lbYsPMq77477AWca4bOgWt2zIxEbeWBR5A
         wCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735864976; x=1736469776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wlvj/EdcXrxs2bTGZMSFUMuOGQ64ak+ztyBapKeTHGw=;
        b=BfOgFu+VKvw+IPCBu4RjHIT+tgYEKi+5w4HU9UL9CPD6dQYmfoSSRXj893PeYluWUa
         qSJyXmBiY31BQpk843+7XcxqcehxsgQ6mH59aFt0xPN8rMzkR8wRkAp73fGTBuhds53c
         +JN06ORxVRkR8XY/9j6Wa09mwp15IpZInL3HtTZpTenvuIuTkLNP3AkiSQCXeqQuumGG
         zVE27eQYDvfHjRGIKF8E5jE57CiqzoBYq+cHAmr63ANeZ/xiLWwtW4ZcHJF7RV+9s2rw
         IPXZbwSaf38JIPIDL9yfqYvMJTw4Z1f5Dj43e/AMaJIvXDkUS+cc0g7MvRtYERK8g1A8
         Qbhg==
X-Forwarded-Encrypted: i=1; AJvYcCWyfvf91JAIGEQ/RhQiMV+RphDMTJHA8edQ4oVMPVvfp1pMieOm7R/AOy3R/ohYu9ADVew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RLsXLiEAQWa1JQxaAIR/7R/Cdntxj8zFJn6tS+UjR5/tXxl5
	FUgFsxQ1M47/5TBVtrsiqB5rmDC54bCLmMHDH3nZgOhl8D/UEqca
X-Gm-Gg: ASbGncsqimYJjB1G1UKaaxCXm1m9mKV/NjIxE3cscj8eJK2u8m5L52w23ALJgG8RHiR
	fWAwSxzvsKp19CMGpyAkP2Nkp/asYzEy+JhSeABivGhitJtIvyVmVKR5RC7PfKK8zJA5QlOw6gL
	5+kG2UFA/xRfg5H1xXaOYB1KIwpek3oW2ceE8wHJC55hCS6JJ3RKN8IZzKWDcEvFWp/Bo7KNVWL
	1eoqr4a/KTbvlWIZIryfq6P1qziiWfgx2wOVxxo9Zn8QuIdqPvzbA==
X-Google-Smtp-Source: AGHT+IGyG6rU4+xiAWB/G6X+zPMQmNJUapakg8a94ysoe4fp0Z1eTqTdtbZKX+zT8y78zgazogXbCA==
X-Received: by 2002:a17:902:ce92:b0:216:4169:f9d7 with SMTP id d9443c01a7336-219e6e8bc7cmr728936535ad.2.1735864975923;
        Thu, 02 Jan 2025 16:42:55 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c80sm234282705ad.30.2025.01.02.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 16:42:55 -0800 (PST)
Message-ID: <5fc0ff106733d93488e4dba03f23a9ab71444fb1.camel@gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Ihor Solodrai
	 <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Cupertino Miranda	
 <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>, Yonghong Song	 <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 02 Jan 2025 16:42:50 -0800
In-Reply-To: <877c7daxbi.fsf@oracle.com>
References: 
	<ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
		<87jzbdim3j.fsf@oracle.com>
		<HfONx8uvT8UvgKSa4GGd2dyrUNHSFTv6VHMDSeCw0849N7REwVvl5MGyyvEmVIIQRcQIEf_-fyr6TcLJodeWdczujiEqrUZKJzX3sfhrPwA=@pm.me>
	 <877c7daxbi.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-02 at 19:24 +0100, Jose E. Marchesi wrote:

[...]

> IMO the BPP selftest (and BPF programs in general) must not include host
> glibc headers at all, regardless of what BPF compiler is used.  The
> glibc headers installed in the host are tailored to some particular
> architecture, be it x86_64 or whatever, not necessarily compatible with
> what the compilers assume for the BPF target.
>
> This particular case shows the problem well: all the glibc headers
> included by that BPF selftest assume that `long' is 32 bits, not 64
> bits, because x86_64 is not defined.  This conflicts with both clang's
> and GCC's assumption that in BPF a `long' is 64 bits.  This may or may
> not be a problem, depending on whether the BPF program uses the stuff
> defined in the headers and how it uses it.  Had you be using an arm or
> sparc host instead of x86_64, you may be including macros and stuff that
> assume chars are unsigned.  But chars are signed in bpf.

This makes sense, but might cause some friction.
The following glibc headers are included directly from selftests:
- errno.h
- features.h
- inttypes.h
- limits.h
- netinet/in.h
- netinet/udp.h
- sched.h
- stdint.h
- stdlib.h
- string.h
- sys/socket.h
- sys/types.h
- time.h
- unistd.h

However, removing includes for these headers does not help the test in
question, because some linux UAPI headers include libc headers when exporte=
d:

    In file included from /usr/include/netinet/udp.h:51,
                     from progs/test_cls_redirect_dynptr.c:20:
    /home/eddy/work/tmp/gccbpf/lib/gcc/bpf-unknown-none/15.0.0/include/stdi=
nt.h:43:24: error: conflicting types for =E2=80=98int64_t=E2=80=99; have =
=E2=80=98long int=E2=80=99
       43 | typedef __INT64_TYPE__ int64_t;
          |                        ^~~~~~~
    In file included from /usr/include/sys/types.h:155,
                     from /usr/include/bits/socket.h:29,
                     from /usr/include/sys/socket.h:33,
                     from /usr/include/linux/if.h:28,
                     from /usr/include/linux/icmp.h:23,
                     from progs/test_cls_redirect_dynptr.c:12:
    /usr/include/bits/stdint-intn.h:27:19: note: previous declaration of =
=E2=80=98int64_t=E2=80=99 with type =E2=80=98int64_t=E2=80=99 {aka =E2=80=
=98long long int=E2=80=99}
       27 | typedef __int64_t int64_t;
          |                   ^~~~~~~

On my system (Fedora 41) the linux/{icmp,if}.h UAPI headers are
provided by kernel-headers package, sys/socket.h is provided by
glibc-devel package.

The UAPI headers have two modes depending whether __KERNEL__ is
defined. When used during kernel build the __KERNEL__ is defined and
there are no outside references. When exported for packages like
kernel-headers (via 'make headers' target) the __KERNEL__ is not
defined and there are some references to libc includes
(in fact, references to '#ifdef __KERNEL__' blocks are cut out during
 headers export).

E.g. here is a fragment of linux/if.h, when viewed from kernel source:

    #ifndef _LINUX_IF_H
    #define _LINUX_IF_H

    #include <linux/libc-compat.h>          /* for compatibility with glibc=
 */
    #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
    #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
    #include <linux/compiler.h>		/* for "__user" et al           */

    #ifndef __KERNEL__
    #include <sys/socket.h>			/* for struct sockaddr.		*/
    #endif

And here is the same fragment as part of the kernel-headers package
(/usr/include/linux/if.h):

    #ifndef _LINUX_IF_H
    #define _LINUX_IF_H

    #include <linux/libc-compat.h>          /* for compatibility with glibc=
 */
    #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
    #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
    		/* for "__user" et al           */

    #include <sys/socket.h>			/* for struct sockaddr.		*/

As far as I understand, the idea right now is that BPF users can
install the kernel-headers package (or its equivalent) and start
hacking. If we declare that this is no longer a blessed way, people
would need to switch to packages like kernel-devel that provide full
set of kernel headers for use with dkms etc, e.g. for my system the
if.h would be located here:
/usr/src/kernels/6.12.6-200.fc41.x86_64/include/uapi/linux/if.h .

To me this seems logical, however potentially such change might have
implications for existing BPF code-base.


