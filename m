Return-Path: <bpf+bounces-67776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A65B49934
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09204E39D5
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7831D741;
	Mon,  8 Sep 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQnSjSa0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011D31D732
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357967; cv=none; b=LnYJLIVBY/VeDagPakdAFuCTKj3EdOVysNsSwN0Y0HaLhlw2cA8eMaRsqHnw0gx9bj1ejAKlTLRAavsDQnVRxgdLrlv3FMVwgyaeUK8UMgZTsQIF9Ev+03Qzxw9nkOZzxNDaCHiGH21O+DXBsKQAUHZQjET0ypyvAYMoCnem4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357967; c=relaxed/simple;
	bh=/xzolQsjzTYT6taqMCWEpwd0QGnBy5TZrNwPxUuKCT0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dinaJyG1CaDhBy0ZD5fA9PG4UDWWUrm8tkTfjH1/e5f3oL8/13jT7wF3fhRfgqQ/631YBVaSHyk3POIUjbt8LBNem7sdkvliEIsKQ1vODLcq9tWXx4qeovgYr3xR0GhjkUyMOywbdJjuuCDTW/Zv+RVUmDaR2CEFeulrfMlLX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQnSjSa0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3277c603b83so2955054a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357965; x=1757962765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nkZgWNMfFj22VFNMncgVqsm3S+MC2BMzUS5tQUwMg4=;
        b=fQnSjSa0KBij7n8o8B9uphbnSbZyiMIEqZVH2X+KXJd3MunpDlhCB29i+RMHD5VtSS
         uBnRXWk8AYvyUtkN+oyPzTsOzWV9pXXbIsNeFGreFev94+YEh+Pg6Dt/w9IpddKgCxuJ
         En+l4RqkOJpracKu4wsjnGAV7W0Z4znrObvcbMtmJnHMz5DPCNReq6uswiv3azU5Rk/0
         7qEK9uCMFvJXwZDWWdJ6TXMoiUwJHeg9CrwjN5fJOcCesRF87k2W+UG/qBttUrkGqp/V
         17w/0OUYsGObKwm/yAa5EAOnxRi2lcRGwmuDBPr6wuaImRYxTFDHOopCdwDr9RFNzT4Q
         H/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357965; x=1757962765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nkZgWNMfFj22VFNMncgVqsm3S+MC2BMzUS5tQUwMg4=;
        b=egVQTzGHIsYXEpVqiIjwjxHxIxfq00rLE0FszKEcneWQ+mv6dHgAUj4UWTcPfFDWYp
         MFmAKjFIGls2iuOpJHSZEceA58+3YBxPdPG/11DCOWycD7s4tJtJuXkvRSfUovT2duB1
         aQQpW1ua9VgpnRczmgadXh1mi3I6+mTlKjUNyn3/lzi90aS/qpiVgxuGjY5TuZqwhU3H
         YrGVvw2eo13wH4/72MKm1imRcaZEu5dO1heM40ihpGeTf/Z3gJa1FR+mE9SuWdabPWY3
         cE+pk8ifIoJ7OdBvTxJa+9pQfiacMBxc7pGP69f9FCk2EdpaAW0r/CRLEYDVjLZup8lK
         bC8g==
X-Forwarded-Encrypted: i=1; AJvYcCWZVFw+gGQLOogNtxSd0D5REFF7QbdNqoAURPKsHmDtH2bLPRy9XwV/+NKmUvnbbM/SZ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjF1aE/ToJdCfMIlQwrZgIrwUO73sUybI7RNLc3caKZCtZeln0
	wEM+idJElD0ur5d8HLocyEOoh4aS8+pzvE8qRloAgdKnPrWn4MTnu/AG
X-Gm-Gg: ASbGncueh6dW1OG1ltQqRp1wQqWCe68uI3inqbCKd+VrxrkcRGg/rVMuP9pXKd41Xb7
	GeCm4lM6p1LSRNPaHckgarQeQyr6h57TGeXiulZfGPOKjTr9c41nuR2gElXBZykC2O5wCIvS7ZR
	QTqYzf/MFdTPO08sU+TeJWnDPlOmpW78u7SLukCGVxHqqro1BACpL6MfFTLhYlGg7n1pJUeBc7i
	0oL9PdIC/9GktKiQamtFHWdNdWlXiicoNxkJ1zdK1CoGc7gQfqpECWz84shZ7d4OThKZiUVsM7q
	U9N/BgybVXaN0xu4c3GMGpTgMjpdunbWVWh+xtcGFYIK16hI/yGdx/KKhmK8C/PzAUaYmaXYcxK
	qcdtkKStcNd4MAMKKj0XFbNlaUuUfSl8yTrwF955nR1BHRcz8uXnR2uRLvw==
X-Google-Smtp-Source: AGHT+IFOWXPfNpXAHWa/hfUw66dQMeVbh0vWXutC3nScWWMOxPNNDOKmGoDKCC33v/qa489g2Nx/3Q==
X-Received: by 2002:a17:90b:1d4c:b0:329:f630:6c3 with SMTP id 98e67ed59e1d1-32d43f608afmr12240402a91.20.1757357964749;
        Mon, 08 Sep 2025 11:59:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b95d31976sm13594461a91.22.2025.09.08.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:59:24 -0700 (PDT)
Message-ID: <2dd69a42f7683ae65c0939833ab1e663620225fc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add tests for arena
 fault reporting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Mon, 08 Sep 2025 11:59:22 -0700
In-Reply-To: <20250908163638.23150-6-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
	 <20250908163638.23150-6-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 16:36 +0000, Puranjay Mohan wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index 9d0e5d93edee7..61ab1da9b189b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -18,29 +18,9 @@ void test_stream_success(void)
>  	return;
>  }
> =20
> -struct {
> -	int prog_off;
> -	const char *errstr;
> -} stream_error_arr[] =3D {
> -	{
> -		offsetof(struct stream, progs.stream_cond_break),
> -		"ERROR: Timeout detected for may_goto instruction\n"
> -		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> -		"Call trace:\n"
> -		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> -		"|[ \t]+[^\n]+\n)*",
> -	},
> -	{
> -		offsetof(struct stream, progs.stream_deadlock),
> -		"ERROR: AA or ABBA deadlock detected for bpf_res_spin_lock\n"
> -		"Attempted lock   =3D (0x[0-9a-fA-F]+)\n"
> -		"Total held locks =3D 1\n"
> -		"Held lock\\[ 0\\] =3D \\1\n"  // Lock address must match
> -		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> -		"Call trace:\n"
> -		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> -		"|[ \t]+[^\n]+\n)*",
> -	},

Nit: maybe put an update of the old tests to a separate commit?

> +int prog_off[] =3D {
> +	offsetof(struct stream, progs.stream_arena_read_fault),
> +	offsetof(struct stream, progs.stream_arena_write_fault),
>  };
> =20
>  static int match_regex(const char *pattern, const char *string)
> @@ -56,34 +36,33 @@ static int match_regex(const char *pattern, const cha=
r *string)
>  	return rc =3D=3D 0 ? 1 : 0;
>  }
> =20
> -void test_stream_errors(void)
> +void test_stream_arena_fault_address(void)
>  {
>  	LIBBPF_OPTS(bpf_test_run_opts, opts);
>  	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
>  	struct stream *skel;
>  	int ret, prog_fd;
>  	char buf[1024];
> +	char fault_addr[64];
> =20
>  	skel =3D stream__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
>  		return;
> =20
> -	for (int i =3D 0; i < ARRAY_SIZE(stream_error_arr); i++) {
> +	for (int i =3D 0; i < ARRAY_SIZE(prog_off); i++) {

Nit: start a sub-test for each i?

>  		struct bpf_program **prog;
> =20
> -		prog =3D (struct bpf_program **)(((char *)skel) + stream_error_arr[i].=
prog_off);
> +		prog =3D (struct bpf_program **)(((char *)skel) + prog_off[i]);
>  		prog_fd =3D bpf_program__fd(*prog);
>  		ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
>  		ASSERT_OK(ret, "ret");
>  		ASSERT_OK(opts.retval, "retval");
> =20
> -#if !defined(__x86_64__) && !defined(__s390x__) && !defined(__aarch64__)
> -		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
> -		if (i =3D=3D 0) {
> -			ret =3D bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> -			ASSERT_EQ(ret, 0, "stream read");
> -			continue;
> -		}
> +#if !defined(__x86_64__) && !defined(__aarch64__)
> +		ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
> +		ret =3D bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
> +		ASSERT_EQ(ret, 0, "stream read");
> +		continue;
>  #endif

Nit: move this `#if !defined` to the beginning of the function and add
     test__skip() call there?

> =20
>  		ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(b=
uf), &ropts);
> @@ -91,9 +70,13 @@ void test_stream_errors(void)
>  		ASSERT_LE(ret, 1023, "len for buf");
>  		buf[ret] =3D '\0';
> =20
> -		ret =3D match_regex(stream_error_arr[i].errstr, buf);
> -		if (!ASSERT_TRUE(ret =3D=3D 1, "regex match"))
> +		sprintf(fault_addr, "0x%lx", skel->bss->fault_addr);
> +		ret =3D match_regex(fault_addr, buf);
> +
> +		if (!ASSERT_TRUE(ret =3D=3D 1, "regex match")) {
>  			fprintf(stderr, "Output from stream:\n%s\n", buf);
> +			fprintf(stderr, "Fault Addr: 0x%lx\n", skel->bss->fault_addr);
> +		}
>  	}
> =20
>  	stream__destroy(skel);

