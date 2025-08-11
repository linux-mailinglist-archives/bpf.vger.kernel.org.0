Return-Path: <bpf+bounces-65366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10C8B21300
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06AF3E19A1
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DB2C21E2;
	Mon, 11 Aug 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE+xw+zo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B23482FF
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932446; cv=none; b=D3sX6p4sMRBhSH/Yc2gGevGtu8Fi9ppoMifNfC5Yn13xiMh3kMoPOQlzz8oJHNBqSwEjpeU/Fh8/IX/5m081sfYscj15QSS/QjMplCoWd/Lj6/8cdpXfw6q9t90moEgM0VMzl9kr+XL9DKn/qNvOTLKGgvzn8FjudP7JCvhELjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932446; c=relaxed/simple;
	bh=Qiy1Ox4uaejCjPTllR/fbNvijEi20qKrg5FLOv3Vu54=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GcdcVMoywT0xlKjrHSnIijmz8zzfIdU1kXDWjdy3byw60a4P7dG0el9BZ+P7SCBUXXenPzvsXCNH1CbbyrXEWZBG2jRlZBsQhrcxYDsdaF88NgO64OU97T/OMJtjnF88Vp5RgdRjrspnkZbv8yGf7dJ80Vo+OA6NDbuupR39ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE+xw+zo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af51596da56so3507196a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932444; x=1755537244; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM8YSgq02Hy9w7BSfP4zbjootRS3yILi5pNxeCrzcwo=;
        b=AE+xw+zouUmdCxD4aXQ6MKEyq/76Vk/2IM8GHEhnhb9e6FVegcIat0wTcIGacR14Ju
         KLNtZZXnV808q8w9H1ePBKS7JZNeHYIxyhr0g4milaKOOzR5JK5XRuktonexhVesKVRh
         0B5LfI3D4xDwTfe1qASFh7doZ7r+XQSn8zSQNraRfxImLhbH0QjjGXSQHH48RM4VfbqQ
         184BsrF36W2SWIJ88Jj0xF6OeL6NQ4/sYGz9lZQTWzknodi5MrLg1aijpXqB4Go6Vko/
         nI6pMhsTWoGzze9y5ncmM0f0o1cWSZtg0OlfI1segSmqk+x3atHqW9GygXk808/iXYEw
         sbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932444; x=1755537244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM8YSgq02Hy9w7BSfP4zbjootRS3yILi5pNxeCrzcwo=;
        b=EdXKf5cFjjH57SUGwGvmBvpJlGvS6PpgY/ClyVQVmoqg/9A+LlGYn2dhpnufTvsyk9
         z/usGxPsj5rQFE6rNd97I/Fy8vldyJoQUS7q8VadZHh9oo6bk1enGztRwE1kPf+Uhbp5
         T2qTGmiBzU1fGFKiVon4E5yapciCB50NeFpLEiylyVs0cNpTPPj2ozz64QuTet3oQJOk
         Uylh7L4sb28qmcBzKyCzjfoAQFJahS111ZShj+6Q8ZuIiED83n3ZDA6JRCskTSYze2Rc
         /19yPqkDLb9Be1Y2KCpwptqp1yiBmJIpzcHktL9/MNDY0M+ldNcjnh4N6LYytPplDxIw
         AYlA==
X-Forwarded-Encrypted: i=1; AJvYcCXel/0HayI6xDf4UCkkEO1mNW8ivACKKJZLX+FJ96JEy6WnZOvp9Rgq8P2txTnoNQnJ8Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/U6UMSUmkCdvrXV+iLoMUm7tEKrPlijtt/eSRBOt6dIRO1d2
	IYbD3UYnpbQ8pZ8kDc4RXrRGdHNQR+yoAXnSjRrh+c3yknYyWicUzXOa
X-Gm-Gg: ASbGncs4f0ASvGXiqCs1SH8Xd1qDQHBizCWfjwP4sVLm8A/3oOneRygpZxYHU+5Y9kY
	3Sh9YuPvlzxJpGJ3gmrPfIRce38bVx6yN/Qd2mowD3aa6JehfgdNZ9WdVPxPFELHWoBOP5b/4UO
	WkktOFF+s/yXvAPSDhAjcyCQmMpWFSwT6iyMROb9NHZfKlvg8V+Zao4+reZ+YDjvVclMCKPZo2D
	+gtFMOMq2yA85gJn5YD1UvL5a37w7FyqsqYxPvVg0GOwyfSn7tHAHa59nI0Xux5ju5AEVbH1dx/
	U/IFP1lj+YNmTP5bgc0IlZ1f5k/3W4Cpa/jKhdCsM2N2J75tYmA6S8Rez39BtvGpJFKPSAa9TOj
	OEOmsNELyEtceiiKzzLXPGZTOqO8=
X-Google-Smtp-Source: AGHT+IFHjZM0VQbzP7EwPDv+K/v8/fk1vnncFR6xZkoSX+pF5Y6/qw9XMd2LULKEdvaYAchj4cuwjw==
X-Received: by 2002:a17:902:d488:b0:240:2953:4b6b with SMTP id d9443c01a7336-242c1ecbcfcmr216473215ad.2.1754932444593;
        Mon, 11 Aug 2025 10:14:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::17? ([2620:10d:c090:600::1:56e6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6cb7sm276292395ad.26.2025.08.11.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:14:04 -0700 (PDT)
Message-ID: <2c415f65e1af61445606dd4d80ec2750bd9245ff.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault
 reporting
From: Eduard Zingerman <eddyz87@gmail.com>
To: puranjay@kernel.org, Yonghong Song <yonghong.song@linux.dev>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Date: Mon, 11 Aug 2025 10:14:02 -0700
In-Reply-To: <mb61ph5yjgt77.fsf@kernel.org>
References: <20250806085847.18633-1-puranjay@kernel.org>
	 <20250806085847.18633-4-puranjay@kernel.org>
	 <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev>
	 <mb61ph5yjgt77.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 13:25 +0000, puranjay@kernel.org wrote:

[...]

> If we don't define BPF_NO_KFUNC_PROTOTYPES then there are build failures
> for bpf_arena_alloc/free_pages() because the prototypes in vmlinux.h
> lack __arena attribute.

What pahole version are you using?
For me these functions are declared as:

  extern void __attribute__((address_space(1))) *
    bpf_arena_alloc_pages(void *p__map, void __attribute__((address_space(1=
))) *addr__ign,
    			  u32 page_cnt, int node_id, u64 flags) __weak __ksym;

  extern void bpf_arena_free_pages(void *p__map,
  	      			   void __attribute__((address_space(1))) *ptr__ign,
				   u32 page_cnt) __weak __ksym;

The __attribute__((address_space(1))) was added relatively recently:
- dwarves commit 40e82f5be9a7 ("pahole: Introduce --btf_feature=3Dattribute=
s")
- kernel  commit 21cb33c7e065 ("kbuild, bpf: Enable --btf_features=3Dattrib=
utes")

[...]

