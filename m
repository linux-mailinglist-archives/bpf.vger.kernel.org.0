Return-Path: <bpf+bounces-68923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19266B88A6B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B587EB60A6C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344E26B0AE;
	Fri, 19 Sep 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SoxxNhd4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181521CFBA
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275390; cv=none; b=CqCEuIL3rVmS3LGwJuRfv7M8mfBZdnN/6+Y+LtL0CGLYKOxbUVKgBs3G+KH+KsS69S4zw0kcna9gw5kkNyacY8ryy9lg2cBep2EGeyKOJfgxrigtPIDXwkvmBEF4RLilTCJP5VBeaMtZby8lOq1FbuiJ9GoRKPu2XjJxtYkfZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275390; c=relaxed/simple;
	bh=+vn2beOL9iMmMYtBKIdblfpGt0ByFQU+AXOHY7wMakQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/RyTQEz4lLpzuQDP+H5Bqs/qPMWIKTed/f5t7IA5BiW7wrmvDfES3UtBoM9xkDrldnSnAOADm+ltmRd16ELc4ACZok+tG67lqz9TRMGoAhHAA4jrgBT8kCHAyT+dxm7hCil1g9vRoSnJ+muZxx/wbzz97f9SLcyk0WQ+7o/P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SoxxNhd4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7238b5d5780so24966247b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275387; x=1758880187; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=SoxxNhd4qxOPCLTfLfMyg6V9quHrYYl76RID6alKKtBo6kSdEaRQ6YS1QrseFaoY7P
         CJhZdQcB54vDQQ2IdGSiEov7Qn1vi8frxMjWyIYszXAZmPk8U1VjXO3bLAKDiVur/3Ro
         GZACoi0x6f5tFzeY/IA9M9u9q+7qV4RLZkU3BhfW8EPmvhF6gB5IwMWzPEcjTNLf9Joa
         CaNhs8DNsoJgYaUkdrxLZlAy+uyuOtkQqfoGVQe7uXmPDREcI0cs0mQDhzPuiY7CoUe5
         q6CkNkg7MMMIQ3WB3tOCNoGQFb02gUXSKl5B4PD7D2FJL80fxULaKHo/EtzK6getU9Op
         dhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275387; x=1758880187;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=g+2OABOCe2uJPIWq0wFS+e2EsSTHcrvCg6oLU9eros3d1kSLujnuhte6VwhtMTjfv8
         edJj0ka8gm5Ozs34QLPHanODLEP78HJ2pO8y9/Q9gvY6YcbKNPHVFi9whKbBmPi8qWSt
         QNYZDGQdYR0rJoTyFr5/9CxVVneNqlDYYxQD7ddsWN1HeM17R2ndxc3V9HkA/lEzmhUF
         0U46UTAE682yMOfo5Pm8zxa1YxLVBD3Y5WxVGWJAlXkn0/VKW2r8TFPec6Dg3fah/uGF
         yXqZgjOg2J5m1v9amyoP97/k3ojkWHsMD3emzXJeQwNvbOhcLK5WqqK0NAybXw2BkpkK
         r3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVjhq/N1U+ajK3fcGFwpHZot9pPLJack/UmHCi9xflvz++nHq0z25rYAfgJTBTXmKQEN4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy/AJ032JkDKUjTapDQEovV4mzMXtiyAf8YvPSVGvauTgq4Kb
	LpBZX86HDYGRyrusSH8YdvxCgGPv+6GhrSJ/DVfUQwAZ+83JkP4pdb9yh0JqO+PX2ms=
X-Gm-Gg: ASbGncuA6nKybz0mTVLcwxzqBX7Z1K+q/bFlsO5/twOLn3xPnz4VEvKfWt04rqq9Qdn
	EBwK98Sx2xTprUvYWlqHLId5yGdVdCqj28y3OVSBsjHxPeqhidhA/F0JlLE4LFj82pYLzOpBgkX
	sRKi4HyjG61iDa4WGDeRwLLxYW6P3TWY8cZCDA9jrKIczjWf7SU0of6hdohfF1Neqp8ifrwQi72
	syE8AErz07R0AGWpejDHnaz29Cc+q/mPuivbu3md/8qMB6YNOTf+spb9oKBqQnEeBOwAfX3nFJK
	nklWQbEfpLG5c2uwFANQEpcJk7I9liVZqEYccPQcbc9fXp14EUiNmenXhYUdlh6v71huHTApEJ7
	kl22wGNl4fqPbfw==
X-Google-Smtp-Source: AGHT+IFpVVlH/GN9+lAL03mMctGhSJiZkSMnotDqIFxVyomur2G0cmwXdfQol97zehSveNubfzRMoQ==
X-Received: by 2002:a05:690c:2502:b0:71a:2a13:1e44 with SMTP id 00721157ae682-73cc45b4c3cmr26463757b3.4.1758275386983;
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd08b24sm1610356d50.8.2025.09.19.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
In-Reply-To: <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:42 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:49:44 +0200
Message-ID: <87jz1uu5zb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry for the super-long time-to-feedback.

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> In some test cases, OOB packets might have been left unread. Flush them out
> and introduce additional checks.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_redir.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> index c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e..4997e72c14345b274367f3f2f4115c39d1ae48c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> @@ -184,6 +184,19 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  			FAIL_ERRNO("unsupported: packet missing, retval=%zd", n);
>  	}
>  
> +	/* af_unix send("ab", MSG_OOB) spits out 2 packets, but only the latter
> +	 * ("b") is designated OOB. If the peer is in a sockmap, the OOB packet
> +	 * will be silently dropped. Otherwise OOB stays in the queue and should
> +	 * be taken care of.
> +	 */
> +	if ((send_flags & MSG_OOB) && !pass && !drop) {

Nit: There's a similar check a few lines before that:

	if (pass == 0 && drop == 0 && (status & UNSUPPORTED_RACY_VERD)) {

For readability it might make sense to introduce a helper flag:

        bool no_verdict = !pass && !drop; /* prog didn't run */

> +		errno = 0;
> +		n = recv_timeout(sd_peer, &recv_buf, 1, MSG_OOB, IO_TIMEOUT_SEC);
> +		/* Ignore unsupported sk_msg error */
> +		if (n != 1 && errno != EOPNOTSUPP)
> +			FAIL_ERRNO("recv(OOB): retval=%zd", n);
> +	}
> +
>  	/* Ensure queues are empty */
>  	fail_recv("bpf.recv(sd_send)", sd_send, 0);
>  	if (sd_in != sd_send)
> @@ -192,6 +205,9 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  	fail_recv("bpf.recv(sd_out)", sd_out, 0);
>  	if (sd_recv != sd_out)
>  		fail_recv("bpf.recv(sd_recv)", sd_recv, 0);
> +
> +	fail_recv("recv(sd_peer, OOB)", sd_peer, MSG_OOB);
> +	fail_recv("recv(sd_out, OOB)", sd_out, MSG_OOB);
>  }
>  
>  static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

