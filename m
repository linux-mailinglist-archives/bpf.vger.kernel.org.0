Return-Path: <bpf+bounces-22043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FD855888
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F46D281E7F
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546410F2;
	Thu, 15 Feb 2024 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWpaRU9R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0CED9
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958877; cv=none; b=umaEBaAoDNH+IkyK90kUF1d/WYp3OxUBBGEWvsQjLmjE9cKXi2CaYufx/dMexJ6LXf+RLIHTQrbXDdfwdCeCTCnAOaoLQxbgPiKCHguETtsgBbywSQsXOkcoz2pVhQMEMadbcnZzJgLXSmsugPOebxE+BgVbolMShW/u3tYd8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958877; c=relaxed/simple;
	bh=nYOXJMreU97vGjRwXQER/AMRLqm0bdhS/pmaem4fPTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9Vng1PTN3nTUny+AwbbizFH/bkir/+14LMes7gLAAQIO3KLFJZKrWkdC9hU/92yE7Oe1EDbLB6BiSVzlzbUV8wFmJQUJhR6EI6h6ihJBr0MAzzOigwkWITX6QLXTv5o6RFo1N8iKcIdfgezTv1jjTSBqscmGWY3PiPugqE9UcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWpaRU9R; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso33558866b.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707958874; x=1708563674; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWVacHrGNqlUG9kNhPAjcL6IOTtTUyft4NTIR6aU34M=;
        b=VWpaRU9Rs5OcZeNQjqnSDYhFL9HNqEnJ56ZOoS8XCsdMenC2xwCIDmq8UySXu7zW3M
         /0q5+qorMQp4JH/jfOyTGR7Bt2QaPfSbHUNUzgxJnHARohTK8yGYE424lcwxg0vw++Cx
         EOG/8TCV1edq95sdoe/q0YA+QU7W7pVqfnOMHQqz3YfTHccY04kvo9KzgRijctctmuHP
         NI7xRd9it/Sp6ugbrfdgZyAW1qBMKlO5bV4NnmnkdUyd6CvTdKh1/fsrQtm12owXtx4Q
         Yszi591iLe4ty9ifnn4S7F9qTqdvG2wLsHY9aCCdSN3tazAWtft5cIjbgOn+PwW9CPGY
         2PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707958874; x=1708563674;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWVacHrGNqlUG9kNhPAjcL6IOTtTUyft4NTIR6aU34M=;
        b=weRM1xihqPA0RSqzw2YJVKjBFTTZ3CyL+XT3Jl1twJMYfJWNhsuLHZRM4Jkh1rO47C
         FWGde3sxKK7WhtXVtQfFtYZzWG6XWfywmYdkGntvjA7DSVWsU5gZ03Jf5ZvJ+5vffSan
         mqZ6gp0I1JabcyQCfpjYMTzJ/0C4rsLmddhV+VrHxqhh20Zd4ht0UcHzCalm6q1i1dM9
         dvOZk7jeNTvKurJnI+d0Qoi+Lp2MF0bG1ZV1UR2+iJHV8SVBNeo0PjGKFl4PfFuVNXJQ
         RSITc9EXE2jUXu0tHK70v5TCAs7n0rUNe4jAjvGW0jva0cBqoasr43/l/KzW5YI4YD3V
         W6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU93BGwbzDnCi/j1WgN8Zi6WMkSAPi7srBIXdYQq6SEVA+Fgxx97sRjvDYyPB9tYl3Iu65+3D6pi/CeARbr5zaJQVs6
X-Gm-Message-State: AOJu0Yzc4Yf8SjJcqbo3jjeYj8nzuOP11oFqTQm64NKbQhjb5yMuRvJM
	0Yqe/wwzknqHcDNSPiy5y3VkyxAWtv6QiD7NhPPGQg45QR7fhCyR
X-Google-Smtp-Source: AGHT+IGUjkb7A7kvyOctjoCxqLzxdMKjB3F8+TbJv5g7hMq/QEM/qCEDJBOIsx4gsXgVyEf0good+A==
X-Received: by 2002:a17:906:3c1b:b0:a3d:87f1:3339 with SMTP id h27-20020a1709063c1b00b00a3d87f13339mr155289ejg.10.1707958873903;
        Wed, 14 Feb 2024 17:01:13 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a3d19aed4cesm48884ejc.21.2024.02.14.17.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:01:13 -0800 (PST)
Message-ID: <372870cadb0d01a26c7381fe61218f494596dfc5.camel@gmail.com>
Subject: Re: [RFC PATCH v1 01/14] bpf: Mark subprogs as throw reachable
 before do_check pass
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 03:01:11 +0200
In-Reply-To: <20240201042109.1150490-2-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-2-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:

[...]

> +static int mark_exception_reachable_subprogs(struct bpf_verifier_env *en=
v)
> +{

[...]

> +restart:
> +	subprog_end =3D subprog[idx + 1].start;
> +	for (; i < subprog_end; i++) {

[...]

> +		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> +			continue;
> +		/* remember insn and function to return to */
> +		ret_insn[frame] =3D i + 1;
> +		ret_prog[frame] =3D idx;
> +
> +		/* find the callee */
> +		next_insn =3D i + insn[i].imm + 1;
> +		sidx =3D find_subprog(env, next_insn);
> +		if (sidx < 0) {
> +			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_ins=
n);
> +			return -EFAULT;
> +		}

For programs like:

  foo():
    bar()
    bar()

this algorithm would scan bar() multiple times.
Would it be possible to remember if subprogram had been scanned
already and reuse collected .is_throw_reachable info?

[...]



