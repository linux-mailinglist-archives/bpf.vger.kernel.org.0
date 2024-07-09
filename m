Return-Path: <bpf+bounces-34222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961B92B4C3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0862C1F221DB
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E015624B;
	Tue,  9 Jul 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PDq3b3lB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8F60275
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519701; cv=none; b=flpRXxFcSJAGXP1Efq5gVRUj8zw3we0tbdDbXTlv2c5sFyVFpMZRwUGRjPf1w7ubNw8Y+WbH2nv871bxAKL+Zjg6K5b0mctGrncpiCwzCy5Z1t+k+HEfv5xe6TDOy/oItTltX4wxpQlhE8LlAOtD8AJGFUXAMmZ5atr+++6HYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519701; c=relaxed/simple;
	bh=nlWBh+HiRCCPt7rYeGi26dv5u49PciqG6bZqmNZR4zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkILWSzSSsLiNXZ4f63guriFNPKSMJi0vYzMZipfMQxG+tTJIFzFQfaAQ6+R7NKo9KCI5Xp76yNLO4ZEVCK8EIi9bliErudhbPr5w+C9yOmm810lPrCYLYh4dLcaEy47eDue9/2QdOS7ubJgkM9Lz0i0j2M+CUySCI5Q+a674ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PDq3b3lB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so334497a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720519698; x=1721124498; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urg/kKbqTlzOjHbwi9GFRUX7vnBQ0SVMjT61eb2f/Zc=;
        b=PDq3b3lBD3Ei27W6hhm3Qxot9nvZ9e21M0DTtXEvjkUmr1MXL0TfLVDNU1uIKw9cCr
         +P6gSy/GZpIuPkxW9wp/BZfxWuJEFARQX2jTZgO6FiOA94fUqOYN2Sdf0zzUbLvN0gBM
         Tj7iXjCDHZWQXOG/Z7yFQq/KZOh/FTVr4zkyZVipSLmIzjQQxUNLE8Av1ONBzob28zSE
         BTYJLdHjq8//iKkWzSmSheVAtpoMnvJxB/MDD9eKbUGh75ZhhvkEx5VMJ463OxGrjYsD
         r2N+RctH1gGYykyOUAZV+ZLnZLQLCIuAxH6uUpGHi2SRgTzGa4N9BVa8+/Yy8Iv1EvGl
         +s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519698; x=1721124498;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urg/kKbqTlzOjHbwi9GFRUX7vnBQ0SVMjT61eb2f/Zc=;
        b=rO2D3zfypfhm5YQec5fCncWqLZJxnPchfIzNW0VrSFc6X7owBUgE972gpi3QXY5i4p
         tB+C07JQ64m25FLOWK6NziMTM2Sw2Ad43UMClX4ZAJNoMQfDbkkG7QPnsPXRar+n0qVi
         ML3z0yMgm6c0wnMn0uUVly/1ly/xnHu6xnVwbXGTUOrkTk+fPHne/NDAlbZU9h9pTYeX
         TToZZD5sFqxAmUoDtILw4fePEjeZS5jEvgIxTgW1AwdOW6DifxZ3x25WpT6f4QQu4l7D
         W81rCqKmm5B7nfQtujt+3qylXXqdPOAY57KejiXaRhpdaitD231zjWYYlRMKKJJ4L5yh
         HWSg==
X-Forwarded-Encrypted: i=1; AJvYcCVqqprX1J0sXnMxexZg94hNzjSxsJmdrl8Cca9OXqosBP+rJnvqm7fMb35wA3Bq1WHF6uc6ZU9v8KXwzPKSO/jUoe9O
X-Gm-Message-State: AOJu0YyoQoB0KUZ8l8FnNmIOwEdsVR/mZVzqvAnnE9ba/BEcd7KqMBLm
	atC5yRzoJtaRJ5cbgcWP17+x7rHEnrlZDnHnJ5AirxWhlm1S1nl67ipupyxzhrQ=
X-Google-Smtp-Source: AGHT+IG9bB1uYyRNuvz6/mRdfTjeHsoNzr9dvTCxUOMZ4pg4+qCUwR/sHC+FiDXZ3RXQL614f2WG0Q==
X-Received: by 2002:a05:6402:2297:b0:582:7394:a83d with SMTP id 4fb4d7f45d1cf-594dcf6f438mr1363280a12.12.1720519697544;
        Tue, 09 Jul 2024 03:08:17 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc7c9e78sm884010a12.57.2024.07.09.03.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:08:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 4/4] selftest/bpf: Test sockmap redirect for
 AF_UNIX MSG_OOB
In-Reply-To: <20240707222842.4119416-5-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 7 Jul 2024 23:28:25 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-5-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 12:08:15 +0200
Message-ID: <87r0c2nai8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
> Verify that out-of-band packets are silently dropped before they reach the
> redirection logic. Attempt to recv() stale data that might have been
> erroneously left reachable from the original socket.
>
> The idea is to test with a 2 byte long send(). Should a MSG_OOB flag be in
> use, only the last byte will be treated as out-of-band. Test fails if
> verd_mapfd indicates a wrong number of packets processed (e.g. if OOB data
> wasn't dropped at the source) or if it was still somehow possble to recv()

Nit: typo s/possble/possible

Something like below will catch these for you:

$ cat ~/src/linux/.git/hooks/post-commit
exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell

> OOB from the mapped socket.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 59e16f8f2090..878fcca36a55 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1397,10 +1397,10 @@ static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
>  			return;
>  	}
>  
> -	n = xsend(cli1, "a", 1, send_flags);
> -	if (n == 0)
> +	n = xsend(cli1, "ab", 2, send_flags);
> +	if (n >= 0 && n < 2)
>  		FAIL("%s: incomplete send", log_prefix);
> -	if (n < 1)
> +	if (n < 2)
>  		return;
>  
>  	key = SK_PASS;
> @@ -1415,6 +1415,19 @@ static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
>  		FAIL_ERRNO("%s: recv_timeout", log_prefix);
>  	if (n == 0)
>  		FAIL("%s: incomplete recv", log_prefix);
> +
> +	if (send_flags & MSG_OOB) {
> +		key = 0;
> +		xbpf_map_delete_elem(sock_mapfd, &key);
> +		key = 1;
> +		xbpf_map_delete_elem(sock_mapfd, &key);
> +
> +		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
> +		if (n > 0)
> +			FAIL("%s: recv(MSG_OOB) succeeded", log_prefix);
> +		if (n == 0)
> +			FAIL("%s: recv(MSG_OOB) returned 0", log_prefix);
> +	}
>  }
>  
>  static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> @@ -1883,6 +1896,10 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  	unix_inet_redir_to_connected(family, SOCK_STREAM,
>  				     sock_map, nop_map, verdict_map,
>  				     REDIR_EGRESS);
> +	__unix_inet_redir_to_connected(family, SOCK_STREAM,
> +				       sock_map, nop_map, verdict_map,
> +				       REDIR_EGRESS, MSG_OOB);
> +
>  	skel->bss->test_ingress = true;
>  	unix_inet_redir_to_connected(family, SOCK_DGRAM,
>  				     sock_map, -1, verdict_map,
> @@ -1897,6 +1914,9 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  	unix_inet_redir_to_connected(family, SOCK_STREAM,
>  				     sock_map, nop_map, verdict_map,
>  				     REDIR_INGRESS);
> +	__unix_inet_redir_to_connected(family, SOCK_STREAM,
> +				       sock_map, nop_map, verdict_map,
> +				       REDIR_INGRESS, MSG_OOB);
>  
>  	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
>  }

This AF_UNIX MSG_OOB use case is super exotic, IMO. TBH, I've just
learned about it. Hence, I think we could use some more comments for the
future readers.

Also, it seems like we only need to remove peer1 from sockmap to test
the behavior. If so, I'd stick to just what is needed to set up the
test. Extra stuff makes you wonder what was the authors intention.

I'd also be more direct about checking return value & error. These
selftests often serve as the only example / API documentation out there.

--8<--
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 25938e66a3c1..1e30e6861805 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1399,6 +1399,7 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 			return;
 	}
 
+	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
 	n = xsend(cli1, "ab", 2, send_flags);
 	if (n >= 0 && n < 2)
 		FAIL("%s: incomplete send", log_prefix);
@@ -1419,16 +1420,22 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 		FAIL("%s: incomplete recv", log_prefix);
 
 	if (send_flags & MSG_OOB) {
-		key = 0;
-		xbpf_map_delete_elem(sock_mapfd, &key);
-		key = 1;
-		xbpf_map_delete_elem(sock_mapfd, &key);
+		/* Check that we can't read OOB while in sockmap */
+		errno = 0;
+		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n != -1 || errno != EOPNOTSUPP)
+			FAIL("%s: recv(MSG_OOB): expected EOPNOTSUPP: retval=%d errno=%d",
+			     log_prefix, n, errno);
+
+		/* Remove peer1 from sockmap */
+		xbpf_map_delete_elem(sock_mapfd, &(int){ 1 });
 
+		/* Check that OOB was dropped on redirect */
+		errno = 0;
 		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
-		if (n > 0)
-			FAIL("%s: recv(MSG_OOB) succeeded", log_prefix);
-		if (n == 0)
-			FAIL("%s: recv(MSG_OOB) returned 0", log_prefix);
+		if (n != -1 || errno != EINVAL)
+			FAIL("%s: recv(MSG_OOB): expected EINVAL: retval=%d errno=%d",
+			     log_prefix, n, errno);
 	}
 }
 
@@ -1882,9 +1889,11 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_EGRESS, NO_FLAGS);
-	__unix_inet_redir_to_connected(family, SOCK_STREAM,
-				       sock_map, nop_map, verdict_map,
-				       REDIR_EGRESS, MSG_OOB);
+
+	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_EGRESS, MSG_OOB);
 
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
@@ -1900,9 +1909,11 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS, NO_FLAGS);
-	__unix_inet_redir_to_connected(family, SOCK_STREAM,
-				       sock_map, nop_map, verdict_map,
-				       REDIR_INGRESS, MSG_OOB);
+
+	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_INGRESS, MSG_OOB);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }

