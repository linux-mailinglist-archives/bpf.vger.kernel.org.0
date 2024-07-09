Return-Path: <bpf+bounces-34219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14F92B490
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AE72845BE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60D155753;
	Tue,  9 Jul 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eoHZbaEF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7C155382
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519192; cv=none; b=TPQmhr+w/z6vtujGJCebf5n0gdOTFpNAtuSkOvB2iCl5rHGUHMoJ5MEqnRrEDD+3DunOas9+2hC9+9h5Q5tM27q6kIiJ1IGcTNl0ieV0AhZNPURbaPtoxFIFzHP8THmE6AhVILW8YtjjkJj2VHYP+KynmegLCIwpFGeLEBPiASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519192; c=relaxed/simple;
	bh=NYKNdJdc/lZVLV2pn+pNgiMZvOILUE/EnM47Fr5AmTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NakKq8Si3Y2VS2xV16HfZo7+VCH0Qc108nuWDrhkYlp1qvHxQfoSqaWyvJoiy+56O///gaem2gHs1cg2yDTIiWOySlpSSA8ZPOX4ATdkIUYtXWcNzxVuZ5nm/DXt62mEH/NFTfdLM6hO6/hJdjksKIqrTnuc6+vDwhjdExP5xIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eoHZbaEF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c349bb81so429708266b.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720519189; x=1721123989; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcD8IiviBrT+0oztaFyghNbmv+g7vuHTxEmeSG/j8ic=;
        b=eoHZbaEFEk2fvgJ6OOsCsbbD3Xg/jdWGzNwrNMTsGKRItaytyMe1weufB4p+KYc+VC
         3t2lr6EAQi+ehS3Sd+NnH3E4I7dDhgcuCknbE8ILb9c7qMmh5csfM9HmZiYqVoyluuD0
         tkLDkY0OXJHUlO2zgigmRTakrmKVVYGlg4/+L7hUCJaA3ZbqnuPqmA0J3lxLFf6lEP6W
         D2ebrM4tu5pAxStpBu5QTICFNEapKJz0Pf38KHPoLgMJM4n5aA4dZCNjAoztt7FB9HyJ
         4ey1CB/kObXHvlF9f8FFdLuSsTWDeJWHjV9RGFSJoIHCh9iiVGJrcDwyXfQ23YBpmKSb
         ws0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519189; x=1721123989;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcD8IiviBrT+0oztaFyghNbmv+g7vuHTxEmeSG/j8ic=;
        b=hrc9KwfwdQJziWYCvQYFDuJEwV6hvTInRfRiiltqxi5weuNl7xtIoxGuFq5ylQJnfN
         muouuiO4kjMkAgi3cASlKFaze5pqIpNdicBiIz4RaPPQOJMnm/FKIgvkX79cGTGYWr6f
         cfFLAlcD6vz/61YZ37usl3zRgg7TJuggBZd+fBYqxrHCZUHN/IJJ3QyFYyOErXddKNFA
         Woajp19+50W8xDSzdwjsSrnyUlZkYaYEQDmtlNikNnbKR/SHB73augZyNOpb2BO3KB+c
         I5lf4XSSeucwEXWZk/aRKmE3DUv7qa7jsegsDZdrnzrtoy9pgXurhJQBC4l3rTtFaI7d
         X3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQUOhjjk9YEO5FUyE7jIJ7g0cw0WM7i0fuoZP5dONQO6rnclg8pQIiWBluYzrCECFyD6nBVVonn323Y2vpN5VFK8Ts
X-Gm-Message-State: AOJu0YwaKKpDZfElx7GhsuWY6t9NqMcSHXbgQtRCYz9XjzdKj7muYv0F
	TO4tyI39nD2l48O+I40O5MktN+k3pwVN8he506OoeV0SsfUuI7iGWRI9jLG+I4g=
X-Google-Smtp-Source: AGHT+IE1+l9EmjvSnLSLzCGBF09SHnOeH3tWxkex3R9jdYD71WyMVlNoI9/SbJj8r8GrnlCZMMSlwg==
X-Received: by 2002:a17:907:9720:b0:a75:3d6f:e4ea with SMTP id a640c23a62f3a-a780b6b3a7amr162169066b.27.1720519188727;
        Tue, 09 Jul 2024 02:59:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f57sm63223766b.206.2024.07.09.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:59:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 3/4] selftest/bpf: Parametrize AF_UNIX redir
 functions to accept send() flags
In-Reply-To: <20240707222842.4119416-4-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 7 Jul 2024 23:28:24 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-4-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 11:59:47 +0200
Message-ID: <87v81enawc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
> Extend pairs_redir_to_connected() and unix_inet_redir_to_connected() with a
> send_flags parameter. Replace write() with send() allowing packets to be
> sent as MSG_OOB.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 40 +++++++++++++------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index c075d376fcab..59e16f8f2090 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1374,9 +1374,10 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
>  	}
>  }
>  
> -static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> -				     int sock_mapfd, int nop_mapfd,
> -				     int verd_mapfd, enum redir_mode mode)
> +static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> +				       int sock_mapfd, int nop_mapfd,
> +				       int verd_mapfd, enum redir_mode mode,
> +				       int send_flags)
>  {
>  	const char *log_prefix = redir_mode_str(mode);
>  	unsigned int pass;
> @@ -1396,11 +1397,9 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
>  			return;
>  	}
>  
> -	n = write(cli1, "a", 1);
> -	if (n < 0)
> -		FAIL_ERRNO("%s: write", log_prefix);
> +	n = xsend(cli1, "a", 1, send_flags);
>  	if (n == 0)
> -		FAIL("%s: incomplete write", log_prefix);
> +		FAIL("%s: incomplete send", log_prefix);
>  	if (n < 1)
>  		return;
>  
> @@ -1418,6 +1417,14 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
>  		FAIL("%s: incomplete recv", log_prefix);
>  }
>  
> +static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
> +				     int sock_mapfd, int nop_mapfd,
> +				     int verd_mapfd, enum redir_mode mode)
> +{
> +	__pairs_redir_to_connected(cli0, peer0, cli1, peer1, sock_mapfd,
> +				   nop_mapfd, verd_mapfd, mode, 0);
> +}
> +
>  static void unix_redir_to_connected(int sotype, int sock_mapfd,
>  			       int verd_mapfd, enum redir_mode mode)
>  {
> @@ -1815,10 +1822,9 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
>  }
>  
> -static void unix_inet_redir_to_connected(int family, int type,
> -					int sock_mapfd, int nop_mapfd,
> -					int verd_mapfd,
> -					enum redir_mode mode)
> +static void __unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
> +					   int nop_mapfd, int verd_mapfd,
> +					   enum redir_mode mode, int send_flags)
>  {
>  	int c0, c1, p0, p1;
>  	int sfd[2];
> @@ -1832,8 +1838,8 @@ static void unix_inet_redir_to_connected(int family, int type,
>  		goto close_cli0;
>  	c1 = sfd[0], p1 = sfd[1];
>  
> -	pairs_redir_to_connected(c0, p0, c1, p1,
> -				 sock_mapfd, nop_mapfd, verd_mapfd, mode);
> +	__pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
> +				   verd_mapfd, mode, send_flags);
>  
>  	xclose(c1);
>  	xclose(p1);
> @@ -1842,6 +1848,14 @@ static void unix_inet_redir_to_connected(int family, int type,
>  	xclose(p0);
>  }
>  
> +static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
> +					 int nop_mapfd, int verd_mapfd,
> +					 enum redir_mode mode)
> +{
> +	__unix_inet_redir_to_connected(family, type, sock_mapfd, nop_mapfd,
> +				       verd_mapfd, mode, 0);
> +}
> +
>  static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
>  					    struct bpf_map *inner_map, int family)
>  {

I've got some cosmetic suggestions.

Instead of having two helper variants - with and without send_flags - we
could stick to just one and always pass send_flags. For readability I'd
use a constant for "no flags".

This way we keep the path open to convert
unix_inet_skb_redir_to_connected() to to a loop over a parameter
combination matrix, instead of open-coding multiple calls to
unix_inet_redir_to_connected() for each argument combination.

It seems doing it the current way, it is way too easy to miss
typos. Pretty sure we have another typo at [1], looks like should be
s/SOCK_DGRAM/SOCK_STREAM/.

[1]
https://elixir.bootlin.com/linux/v6.10-rc7/source/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c#L1863

See below for what I have in mind.

--8<--
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 59e16f8f2090..3ddffaead2cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -29,6 +29,8 @@
 
 #include "sockmap_helpers.h"
 
+#define NO_FLAGS 0
+
 static void test_insert_invalid(struct test_sockmap_listen *skel __always_unused,
 				int family, int sotype, int mapfd)
 {
@@ -1374,10 +1376,10 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	}
 }
 
-static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
-				       int sock_mapfd, int nop_mapfd,
-				       int verd_mapfd, enum redir_mode mode,
-				       int send_flags)
+static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
+				     int sock_mapfd, int nop_mapfd,
+				     int verd_mapfd, enum redir_mode mode,
+				     int send_flags)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	unsigned int pass;
@@ -1417,14 +1419,6 @@ static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 		FAIL("%s: incomplete recv", log_prefix);
 }
 
-static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
-				     int sock_mapfd, int nop_mapfd,
-				     int verd_mapfd, enum redir_mode mode)
-{
-	__pairs_redir_to_connected(cli0, peer0, cli1, peer1, sock_mapfd,
-				   nop_mapfd, verd_mapfd, mode, 0);
-}
-
 static void unix_redir_to_connected(int sotype, int sock_mapfd,
 			       int verd_mapfd, enum redir_mode mode)
 {
@@ -1439,7 +1433,7 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
 		goto close0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1729,7 +1723,7 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 	if (err)
 		goto close_cli0;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1787,7 +1781,7 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode, NO_FLAGS);
 
 	xclose(c1);
 	xclose(p1);
@@ -1822,9 +1816,9 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void __unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					   int nop_mapfd, int verd_mapfd,
-					   enum redir_mode mode, int send_flags)
+static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
+					 int nop_mapfd, int verd_mapfd,
+					 enum redir_mode mode, int send_flags)
 {
 	int c0, c1, p0, p1;
 	int sfd[2];
@@ -1838,8 +1832,8 @@ static void __unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	__pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
-				   verd_mapfd, mode, send_flags);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
+				 verd_mapfd, mode, send_flags);
 
 	xclose(c1);
 	xclose(p1);
@@ -1848,14 +1842,6 @@ static void __unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 	xclose(p0);
 }
 
-static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					 int nop_mapfd, int verd_mapfd,
-					 enum redir_mode mode)
-{
-	__unix_inet_redir_to_connected(family, type, sock_mapfd, nop_mapfd,
-				       verd_mapfd, mode, 0);
-}
-
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
@@ -1872,31 +1858,31 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS);
+				     REDIR_EGRESS, NO_FLAGS);
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS);
+				     REDIR_INGRESS, NO_FLAGS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }

