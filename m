Return-Path: <bpf+bounces-37541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9A957545
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A7D1C223AB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078D71DF678;
	Mon, 19 Aug 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FYN5rL7B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B71DD3B6
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097959; cv=none; b=iTEQPcuKemEk3GRGIQfGZpsxMTR2SPH+K5chSgGpW6r2lwAPXUJqmoq5qvrLZ7GDCbnrz/wrOdcXAJ84spOOT9j+/JHQfBhtbOPexUYPpv3/0QjgGvsQPbDAs+wiJbBn4HZyPYFqN2phGRGdiB3kIr8CWswWYLNQEBUrKVw4e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097959; c=relaxed/simple;
	bh=+3oftQfhjhUYyg57I9ety2tn11QKkQqfdsVnyjwcBF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hPgHifTd3r3OjC+qmoc+A7scKawv8KBHOMbW9GkbwORm+4kSKfMbjPzvFPyM9rgBnQFVBepqofiUywHpq9iPoJQhCH2LXAaKpRhdpt0ZMSuQWJsfWC/obBXMLPVJkndIQ6spxLmSvZe5fmSRBho8c8/WgbQ1Sl56OxnIycZYpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FYN5rL7B; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so6171876a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724097955; x=1724702755; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMxfpfJClEZ+ltWCCNkrYDChDycnDKMNk4ece3IVdJ4=;
        b=FYN5rL7BUVI5sPKjDbpNz/j1GS0INuEG1nI/ZopaTaCAWbnqbBjSRQcpet88exNRTK
         bBsgWfnj/+E1EB1mLHban0qzTxua+ABmzAcT3HhUVbvHZY1Nkruu2metIHPJnngQTQ9e
         Lye5kotn1dEETGjSIq1LN73NPU5DvBnstf3YyiZBWwE25u3yS3l+6Z/WN5Fx94vrXfM0
         Pzq7d3bMdkP1nqO0kMWPZ3GJd7eT+VZ0eINSoD1XpXohvCXa0tT6RtFAbg1mztwtQ2HU
         MLZ5fhRIUjnl2Fwgx/vDsEONzyXtU0uIP57/2tbat3SzZ7V+3nE4QPQ2dBTrN9YpQz40
         ctIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097955; x=1724702755;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMxfpfJClEZ+ltWCCNkrYDChDycnDKMNk4ece3IVdJ4=;
        b=QUtdyI22z89l5V3NwG6LT7yrAxXPAkNnVr/aXBI84KSi2+P6DdrR1HYprOQAmTc6Jf
         MqFwjO3gYD2NKwheA/nM/bdaQXQr3yqPYTVwlw5aiVZ0unZJtO/casiE6JBkeCSsqHa6
         QnFF+WjxidiNgBi11wr5gmeiIp11XYcxLOS/Xf5oP72AaQo7JUGU2J5Mn1j3vFawN/8Q
         IwWDatlS/3ZQooV3UBhM1ucrwUPuVVr9f24Anu8SbZAgLdUxanF1N/Ws0B4p7fw5cBMZ
         CPvSgOHuRQDecGdhwXQEDme7NYHIZ9OqrGPyxFRp8gRc7HfOt8ghUEj6n1FEHbADF2CB
         6BKA==
X-Forwarded-Encrypted: i=1; AJvYcCUpIYsyvZSDJr37EPaw2+BRYMdngRuWnLfg1OvecozXDqdokWLBamyQlxSXwArASSOl/PqXOavdhBxqrtP9Ogbi/fZo
X-Gm-Message-State: AOJu0YxbqgM164wWYv7gDL9ffuYNxJYxtGbLMTtoMfnrrMOOq4CiZDzq
	yziQzKMVSODEbaBELnj9k0WVi7RxIJGrb4L06KAm6ulzfj1wdOMMLIKKZVNvXu4=
X-Google-Smtp-Source: AGHT+IHCD9ocXtZ6zDwa187R+PBvaqVuEvrwwPP2cleAnSgS3RYPhbyQRLrtSVrpR/ZkfoXjfl9kJA==
X-Received: by 2002:a05:6402:35d0:b0:5bf:79f:3b55 with SMTP id 4fb4d7f45d1cf-5bf079f3e28mr1220968a12.23.1724097954635;
        Mon, 19 Aug 2024 13:05:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48fdsm5851490a12.28.2024.08.19.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:05:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co> (Michal Luczaj's
	message of "Wed, 14 Aug 2024 18:14:56 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
	<87ttfxy28s.fsf@cloudflare.com>
	<42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 19 Aug 2024 22:05:52 +0200
Message-ID: <877cccqnvj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
> On 8/6/24 19:45, Jakub Sitnicki wrote:
>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>> Great, thanks for the review. With this completed, I guess we can unwind
>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>> wanted to take care of yourself or can I give it a try?
>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>> 
>> I haven't stated any work on. You're welcome to tackle that.
>> 
>> All I have is a toy test that I've used to generate the redirect matrix.
>> Perhaps it can serve as inspiration:
>> 
>> https://github.com/jsitnicki/sockmap-redir-matrix
>
> All right, please let me know if this is more or less what you meant and
> I'll post the whole series for a review (+patch to purge sockmap_listen of
> redir tests, fix misnomers). [...]

Gave it a look as promised. It makes sense to me as well to put these
tests in a new module. There will be some overlap with sockmap_listen,
which has diverged from its inital scope, but we can dedup that later.

One thought that I had is that it could make sense to test the not
supported redirect combos (and expect an error). Sometimes folks make
changes and enable some parts of the API by accient.

Just a suggestion. This will be a nice improvement to the test coverage
even without the negative tests.

> Note that the patches are based on [2], which has not reached bpf-next
> (patchwork says: "Needs ACK").

I think it might be fair to resend the series to attract the maintainers
attention at this point.

Thanks,
Jakub

