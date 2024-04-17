Return-Path: <bpf+bounces-27028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AC8A7DE8
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8645E1C21B99
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EDB81ADA;
	Wed, 17 Apr 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrCARCl3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A080BE0
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341680; cv=none; b=Qslr7EdEedfCKJ0In+NHD/KD/iZEOnbW+baxM9aZ2Hu6BU4As82k/798VBSZ1RFs3xfsFhIJAwLyMNe2e8gEkijb84eBa1+jnxW/jb0233bo3zvYLhVuORgaT85FT6VQXqdqfzI6qI4dtHH9vQdpLpqJWsqtfST9nrpqeDwyZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341680; c=relaxed/simple;
	bh=IkUqyaRgQgMXzADsv4EzlRn6kcDKXTLdvqhGH+8RBp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aws18j2QfB33/q+6oCINSElc/zhTB+OF6vVb6Pl53Z9sHwxoIgEMQXKIkMQWVdClqILlAJtz+2HfWAD5nWtvCWAHg6zOPpuo91lLU9LgVPXxTixgIhJXDm0JYkgPZ4+qV6NwoJaXAF4oeotZuDDbrlk39iCvgG8WHrf2pIq5HWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrCARCl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0646FC2BD10;
	Wed, 17 Apr 2024 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713341679;
	bh=IkUqyaRgQgMXzADsv4EzlRn6kcDKXTLdvqhGH+8RBp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrCARCl3UWgxyoAK2NmfILZD/eLwCgSHFqDXB7/p9cl8FWd6Sv95rsFyRiHElyHJZ
	 C2QPDolYtucxfwpfgcQUV54MQBf0FMSkrn4hB5t3vIami2aIckHVVAP8hPaeuDj94w
	 ZZP/RxjhMxoa7gWCUaX77Fc46pO3Opnj/v4AXWZl8MQYEeI7kPUVbKmqyY/pszH9VF
	 FKOoTkg9W/wHpNRXg9QW2nF3t3+7UjLBPKHDZN9sKOPgcvL2xUO25Z6KidfoTmj15Y
	 x5ncTkSMOnKcWzZsncmwiuPFAlcBOHY8bSi4PTL2UrgqcPeIHlU/v/zSSLvaXt6y8K
	 iyrjzDSbARwXQ==
Date: Wed, 17 Apr 2024 16:14:28 +0800
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
Message-ID: <Zh+E5JlEM6fisrFS@t480>
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
 <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
 <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1xliXYEKyRZdwTar"
Content-Disposition: inline
In-Reply-To: <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev>


--1xliXYEKyRZdwTar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

On Thu, Apr 11, 2024 at 11:10:49AM -0700, Martin KaFai Lau wrote:
> On 4/8/24 10:18 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> > it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> > passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> > The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> > 3rd one.
> > 
> > In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> > some subtests of test_sockmap fail.
> > 
> > Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >   tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> > index 024a0faafb3b..4feed253fca2 100644
> > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > @@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
> >   		struct timeval timeout;
> >   		fd_set w;
> > -		fcntl(fd, fd_flags);
> > +		if (fcntl(fd, F_SETFL, fd_flags))
> > +			goto out_errno;
> > +
> >   		/* Account for pop bytes noting each iteration of apply will
> >   		 * call msg_pop_data helper so we need to account for this
> >   		 * by calculating the number of apply iterations. Note user
> > @@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
> >   					perror("recv failed()");
> >   					goto out_errno;
> >   				}
> > +				continue;
> 
> From looking at it again, there is a select() earlier, so it should not hit
> EWOULDBLOCK.

Can the patch in the attachment be accepted? It can work, but I'm not sure
if it has changed the behavior of this test. Anyway, I would like to hear
your opinion.

Thanks,
-Geliang

> 
> Patch 2 looks good. Only patch 2 is applied. Thanks.
> 
> >   			}
> >   			s->bytes_recvd += recv;

--1xliXYEKyRZdwTar
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-selftests-bpf-Add-F_SETFL-for-fcntl-in-test_sockmap.patch"

From d20ac7e06d9e869094f452d8c2dcdc316508dcc8 Mon Sep 17 00:00:00 2001
Message-Id: <d20ac7e06d9e869094f452d8c2dcdc316508dcc8.1713340686.git.tanggeliang@kylinos.cn>
From: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 3 Apr 2024 16:08:21 +0800
Subject: [PATCH] selftests/bpf: Add F_SETFL for fcntl in test_sockmap

Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
it to set file status flags. If O_NONBLOCK is used as 2nd argument and
passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
3rd one.

In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
some subtests of test_sockmap fail.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..8130f465afb9 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		if (fcntl(fd, F_SETFL, fd_flags))
+			goto out_errno;
+
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
@@ -1531,10 +1533,10 @@ static void test_txmsg_skb(int cgrp, struct sockmap_options *opt)
 	txmsg_ktls_skb_drop = 1;
 	test_exec(cgrp, opt);
 
-	txmsg_ktls_skb_drop = 0;
 	txmsg_ktls_skb_redir = 1;
 	test_exec(cgrp, opt);
 	txmsg_ktls_skb_redir = 0;
+	txmsg_ktls_skb_drop = 0;
 
 	/* Tests that omit skb_parser */
 	txmsg_omit_skb_parser = 1;
-- 
2.40.1


--1xliXYEKyRZdwTar--

