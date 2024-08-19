Return-Path: <bpf+bounces-37549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F4957770
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E64C1C22EC3
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37E1DD384;
	Mon, 19 Aug 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGr4RgAA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BB1586C9
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106579; cv=none; b=rMPwrzGtnJ8wOWMAWY5fR2Tc+5D+ggVH71MCrHZ4BcfiavPYUuQ68ITHu89K8ZASTjAz5zcKPal4Yc8Olz1el1ixh3IMkVd/AnXFmECoPNRYPw8p2CyhPhKoAEkk+ywkaPMWIIlISkLW7blvXwvzUMrsI2Fu1CG32yiXo9rqybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106579; c=relaxed/simple;
	bh=gw+/qIkdnlrrx7w3sBx6VrgoZGSAfJNP27P5z0w6L/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0BKMtu/24ZpyzxKSNITqofjHqdf+8NgZR7pRuqe+KnSOsOkrIdrEpZ7QTsXK4nLri7jop7giTwh4J2HHKTFTvXEBFJAq9cjOctBQ+fVuefjHiX17yCWMMyoo8rXhm36morQyGWT5fH1ESlZPMmCS1FjAcGw2bQU15Wnvjt5MEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGr4RgAA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so3229139a91.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724106577; x=1724711377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nuu8yaKQpA2cE+SF9/WuCacxPcRTUONv3JeKzydYFMY=;
        b=BGr4RgAA+4b6wHQgq9KxQIXQOdBzhWPCPGCU5K9Hb76ZTIQ4oJJFSP59HpW/kMSCOb
         8jYQ63mm7nuLTluTMtaViR0N7F8woID4lQs8qvtQmLCNSfQVNYp34d/Bgkj1P2FoCCo2
         X7eeSOtZ6K+MeFO8gnZTfXupTDy8x9zsC4Da35X70TNrAQdsr+vZnHANSFE2cYS1QDjK
         rPCnOGeBph30tZl2SQfdxCazw/sjF2KNtQcE5WR0dPV+fGktLgAGGSBjW8k1Ja4gkkwW
         rlDohEhjGhT76F//M9BmD6D4Wb/pkNVern+BASZsYIx1sUgijG+oZyltRJJu9sPYzofK
         +EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106577; x=1724711377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nuu8yaKQpA2cE+SF9/WuCacxPcRTUONv3JeKzydYFMY=;
        b=VaYQFLsrEPkO2tcE3AnT1K0HYsmBH3WXIZquolw7M89HDFjS3vgq/wro5kuIDCFDIf
         74myFhiFgYgQpLXVAFE5/8/u3Bt19zj4AAjlJtJeVIN5cJS54LRspmzlOYQ0WIBQqaWh
         YQkFwwEkS4oJmR5s8aIQ8GU3JqsqxRAUkwLRhpxFHS7Gia10CQXI2Jz2LwVziIcBipPI
         u3dCip7g+wBIQsImqwWqAbmR67KkN7tmEvTMYobWUvI3ZCadI1zbxEwXQeOmEt9cc7d0
         tUC+JN7SnQWjD0yIAkW2pixaeSOJgTn03TImLtMIi65EoFADsfpm2txbvBN9VUQuOtze
         0FTw==
X-Gm-Message-State: AOJu0Yzf0ktcY40C/4wyMQKVNb201+0ZAQkA5atuumvHtAO8KBjDQ4MQ
	Ay3XGZHQe20Rpt1s8QMKiGmUqPZWDeMVAJbC8qaOOtJBTlmPT4gBl+K1LlQhkZYYMrHavPlc8wK
	JVtwJcZc2XZfNYxaGPfPNsI9G10Q=
X-Google-Smtp-Source: AGHT+IFezSFz8qLAMA9Wsh9zTCW8e8mV3Fnbr8ybumzp66MSQoPdKVrGS1JH5UdrpWlpjwALRJPP/ii+nDOEi618OHk=
X-Received: by 2002:a17:90a:6008:b0:2c9:7d09:1e7b with SMTP id
 98e67ed59e1d1-2d3e076c675mr11380427a91.27.1724106576868; Mon, 19 Aug 2024
 15:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com> <20240819151129.1366484-3-cupertino.miranda@oracle.com>
In-Reply-To: <20240819151129.1366484-3-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 15:29:24 -0700
Message-ID: <CAEf4BzacphQ5MLVV=31auivPhMosGWdu_79nSLTv-8dRuyuNTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftest/bpf: _GNU_SOURCE redefined in g++
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Jose Marchesi <jose.marchesi@oracle.com>, 
	David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:11=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> The following commit:
>
> commit cc937dad85aea4ab9e4f9827d7ea55932c86906b
> Author: Edward Liaw <edliaw@google.com>
> Date:   Tue Jun 25 22:34:45 2024 +0000
>
>     selftests: centralize -D_GNU_SOURCE=3D to CFLAGS in lib.mk
>
> introduces "-D_GNU_SOURCE=3D" to generic CFLAGS used within bpf selfttest=
s
> makefiles which include lib.mk.
> g++ by default sets the _GNU_SOURCE flag internally which
> reports the following warning and subsequent error:
>
> <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
> <command-line>: note: this is the location of the previous definition
>
> This patch removes that _GNU_SOURCE definition from CFLAGS when
> compiling CPP files.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: David Faust <david.faust@oracle.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ded6e22b3076..f06c51bfd522 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -741,7 +741,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/netw=
ork_helpers.o $(OUTPUT)/xdp
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPF=
OBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(subst -D_GNU_SOURCE=3D,,$(CFLAGS)) $(filter %.a %.o =
%.cpp,$^) $(LDLIBS) -o $@
>

The fix for this issue has already landed in bpf/master, so we are
just waiting for bpf/master to be merged into bpf-next/master.

>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> --
> 2.30.2
>

