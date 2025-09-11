Return-Path: <bpf+bounces-68182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04EB53B4C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E249F17390B
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445435A2AD;
	Thu, 11 Sep 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjjsmIKs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF247F4A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614797; cv=none; b=qnRl1KH7VxuKW8WkHOi6YmLmqGQMZKub7JowAwTUlyoK7yGsM2PCnq/gmo2hlztNByCWhL++adj0kG7Fio/WC+53sRevMyOoMv2zLb/UCiwnLalFiDjzVaah6r4nf1b0OrIrWyK9KnkSs7X3LlxOs8fGf8Z6oxtQKmcBGKqNEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614797; c=relaxed/simple;
	bh=f0yaI6+i0WsG3z7aqKITZCxaNsHFQ0BDBzwnfDuKFJE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LnLDbZqaEiJfvmG9xUIbcOPsV73Tx53uFku3FNc7a1BeA5mQxGATvZWyT6o192aPGlCczsKlBxHq7tcidAoIBUrNmuJ0ljn0yCzbEYTQA/ZjYQA1bYHquojeT9BxEf+Ad0l4VW9BlJMkwOnLT5HPl7z0oSAJlZxOuPzzZDWFAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjjsmIKs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266cdf64so866920a91.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757614795; x=1758219595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94yWRXEGEZcW6uSr/b1ykEf3bi+EUY7fVL5wwWS8plA=;
        b=FjjsmIKsa1U1SwpQgzMry3+cfnSA3hd9JOgNXujhHabo0oAGJIQlSKorXfQ7lojA2i
         NXukB45QDVTQJkzDL4ybdFFabcTfjKHH2V4MwZoTBu2OB1/oYmQdQ+3VMndxTnwpMO4q
         nM4PBdubBM4VeTjZFiZWwT8Neq++g5MV9Rm7GFoJcusProWkjpG5jeIT8tuinWVD7Uyw
         OcpvMWA1GE0fck1cr4ChcaT7SxJ+Z0fF7EwNgbSRgjaS4kjX2UTn++YArxQ0aGs+Zcs0
         IlvGpcxiBR2329xB0/uNgfcUcEgPbWPJf9E9d773qvzFQWloHsgI89/MAv3r4CGbhqZD
         w01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757614795; x=1758219595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94yWRXEGEZcW6uSr/b1ykEf3bi+EUY7fVL5wwWS8plA=;
        b=QaOjyC84XGUqj3TJf5yYwCnlOe5vjpwL3bnQFq3qPCTMYDg2Qw3UGrdBqTzrg2czBt
         SxlZ/QXB5MuW4IU6Wx3Xn5NYP9/nrRqo+/Bzgzhf1P20W0+9ZOOtO3X6MNVEWXp0Cjrw
         5G9wek03ddSLYDn4eH4ffgGwVUSrbYSlSlcJ0U8hY8Q998OaNMXbiG/0R/qCbd8QA/B1
         HmL22oszt2qZukowfK52+PKujaT/IznlhgGZJMSDnrSjJwWSrWQZfpRBZN4M5gk5yd3S
         1RwgDTbI9EvIA9WlNDlxrEuwMxOInFGHLXGUJrVDVNhdtlyb7I+EGE2VIQynMozoWOHp
         nu8A==
X-Forwarded-Encrypted: i=1; AJvYcCVbFJx1CVLapdzr4YCKTU0B2z4q2p1alsRCYPVek432dX4dbMTtkXzBL1/pT216SEt4qx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvunqO4b+NZWzTb9uO8/Gl95knWtKwxSIqCwpznJbKBgXqAgg
	/PNfLnKMEdlhkbf1NM4CndVDbMqMXB/NktXJ5+uldRjGM8hIFqckgRF+oV7dyA==
X-Gm-Gg: ASbGncsXxQVjPeXC1zF9Rsa6lMhcLeoogT+0+ppqqKtLZKRzty2Y+knnT9GKJaCYzyF
	HhVWRJSrfsYF+cM1mpShNqkqRDKL0u9GYi9qqnYj7rbDlNgZLZ+88kZDRd5aKNBDieouR+HKyBn
	UF5QgMq94Sn35VNMQ30+hwQ4pP9V/xdd8QiaWBNcviUgHmwKrzJKrtJAjWMPWdyGRa96PGRzbno
	PBW4L7smduTevCigsSryj7eNYbnmTsGSloJT+QYIjCSpbqVScMkcbF66NNeih0pW925UahJ1d0D
	ZvBoRTjKvBlFH/29jlaw3RfdPQ6zsxTcw3MLkC4NldPzRm89F9iJIU5pzqdYBB181s/A9r/THB1
	JnwTCRLxs4uqEM1L8vg9hfTRJM+AKzg==
X-Google-Smtp-Source: AGHT+IHJPpfgS3nvtYot4cTEnhh34DKnEO/VR4Sk1wjSJxZwEUCV/oQyBWvD5LKSGegaFl9Z6gRk8A==
X-Received: by 2002:a17:90b:3e88:b0:327:dc81:b399 with SMTP id 98e67ed59e1d1-32de4f895e4mr145826a91.9.1757614795294;
        Thu, 11 Sep 2025 11:19:55 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98e616csm2805627a91.19.2025.09.11.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:19:54 -0700 (PDT)
Message-ID: <137b87da5a7393602ec77d51cfd6398406cda9fb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: Add tests for arena
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
Date: Thu, 11 Sep 2025 11:19:51 -0700
In-Reply-To: <20250911145808.58042-7-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
	 <20250911145808.58042-7-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 14:58 +0000, Puranjay Mohan wrote:
> Add selftests for testing the reporting of arena page faults through BPF
> streams. Two new bpf programs are added that read and write to an
> unmapped arena address and the fault reporting is verified in the
> userspace through streams.
>=20
> The added bpf programs need to access the user_vm_start in struct
> bpf_arena, this is done by casting &arena to struct bpf_arena *, but
> barrier_var() is used on this ptr before accessing ptr->user_vm_start;
> to stop GCC from issuing an out-of-bound access due to the cast from
> smaller map struct to larger "struct bpf_arena"
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


[...]

> +SEC("syscall")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(0)
> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
> +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> +__stderr("Call trace:\n"
> +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +"|[ \t]+[^\n]+\n)*}}")

Nit: here and in other tests, the regex is a bit hard to read.
     How wrong would it be to write it down as follows:
     __stderr("Call trace:")
     __stderr("bpf_stream_stage_dump_stack+0x{{.*}}/0x{{.*}}")
     ?
     (or at-least add a comment).

[...]

