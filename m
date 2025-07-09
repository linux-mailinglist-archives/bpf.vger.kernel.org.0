Return-Path: <bpf+bounces-62763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED65AFE26C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6DE1C42817
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED22741BC;
	Wed,  9 Jul 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gGBkfdTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304827281C
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049336; cv=none; b=u5ixZ5ccypXGzBos+zsXV0eWiGvZcxGGti44zUhAKhE64JnOGn6P3AOkY+eBpCdd2y05S5Dv78RRYz99f6V7Jxe4BqLM08X3iH69bfvBQ7VVfsvu1Ptu9QTcrBLeLVUxSEdtqvO5wIaiIHuj62Z+cXEyJ5vDVn8MfCbwHmuieEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049336; c=relaxed/simple;
	bh=bbp563xB+k02ZQyw0bOuD8J55G2HzTY7zLjAKvmY3ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0j4Yo/XrCV8nmuoGA0AVdzZCv9dGkZK0/B+1JvbBsM17kQ33+ONikI5DqdZWhy0b3+ohwzRggtl57lmqq26Phkt6n4OOR6tnvaT7LKReMUFOje6Pw5blnmNFUE4/j9M6vD0a3ux4Exusjyr+6oNmtNP022f7cuDJZNx5TX8ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gGBkfdTM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so837638166b.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752049333; x=1752654133; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=gGBkfdTM4AeM2aZi4PBrRYndhStsYrP/wjLmuon0igU8CWab+/NkkGnLSml3uVOR+K
         eqU6nJrvT5ITr4zgI2mHvZllvH2YPAHB8i8gVuIr/xZ5oMkwayw/kjsL52NmD9jlodEi
         btCVpPJexDd4/EQwDUcJJD8/EWEtx6yLRS/wz79QyWNzn1d1B5DtbI3OFBdOqHOlnd0h
         bcAioSFf9k5iEwhoobtiy7dk2CC+GHfvozOc4uFhJOVQK6MRnrrWTyW2Eg52Ajn33DjD
         DFLBqtj4ITIfaxQz3yBbA5Y48IPv2kpyPFpinFPltHQ0uEVDV/Bwnk1hhcAmaA6ghwUh
         cP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049333; x=1752654133;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=fbQKH+nPFslUmIZB/yXHCCwxJh2jgWBjaDtZMkN1w7PyB7N+oRBFXuWhAULW+hWggz
         EYrzmCn9CSrt3Nd4pQdPbpObW1htfkZdwGGKG6X6l7fA070TvoxtZvhFfOrW/qjcIOgK
         FRdzPyolO8NdFggsK9PGcRTJeUBR8JVW0e+uF3sRp3tN6ZdfSXuGvIXN/rXmkmTcG+YN
         xNPN1aLUZ6OOLJXKOqQHGtAMkX3+dKbJaBPCsmSWwVpV8gw+bCO912D8H6Yw1Ed6epa9
         QWg2T8RCLyoBKgb/Rjs5pG5TtRbVRmmOwI+Bbfk6tY+LEGRKxlUd/waDcGkCS6XYxiqw
         iZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW0bHPUwtHrcpPgNrLnYIfW4WyMI8EBhZqvy8JG//1rgoPqIDxXUQt0TyxoOTeof2BThI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4FskByf4kxz+8C/5QyWIZZZ+ZE0yD/elk5Qxv9nx/S/2Ab+8J
	BZ/dHSew1G/3VRNL9xALzWDhA7yzmBFeBW4QMnwE3CzwOSnSfdl1Qx4H8SPVTBp3E+Q=
X-Gm-Gg: ASbGnctwT0zy1ib2IPa0pAmDTZVu2fntzf0acWud8R4n8vagU1PCChdyonKdkOl+YjO
	vsFyd+AzGMdlU20K/kT1aog8NIJ5jMHv/TnA/M3Epu8uMlTu/7s6nVJrwLK0VAkHYCeZYXCTK6a
	qEwczd8wINWBSODWS9zErvMOOdnf6Wc2x5wrQDASP+ALSxdC7QTiFp718VxX7akIKLJewjtIhhk
	Z4vFFjrOmRJ8y/Elh3906aum26jS/t2e9/cHdaBsAs3L8H/J9F3VqMwYd4d5hNmaKIH5750VtDb
	V0NymTFsyumpGVlhXUAaJT/I5Qwkx79eWxAfrpQY3BLwLx67naenj6U=
X-Google-Smtp-Source: AGHT+IHhjLw7axM+sfg+4JbrvZ5uzjMQFSsgDBtJdAVL88Qnq4BGK12a+lUwgHht3jMZ3xAMt8/spQ==
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id a640c23a62f3a-ae6cfbea8f3mr137410866b.61.1752049331750;
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1f8856sm8372942a12.56.2025.07.09.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net,  razor@blackwall.org,  andrew+netdev@lunn.ch,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  ast@kernel.org,  andrii@kernel.org,
  martin.lau@linux.dev,  eddyz87@gmail.com,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mattbobrowski@google.com,  rostedt@goodmis.org,  mhiramat@kernel.org,
  mathieu.desnoyers@efficios.com,  horms@kernel.org,  willemb@google.com,
  pablo@netfilter.org,  kadlec@netfilter.org,  hawk@kernel.org,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v3 0/7] Add attach_type in bpf_link
In-Reply-To: <20250709030802.850175-1-chen.dylane@linux.dev> (Tao Chen's
	message of "Wed, 9 Jul 2025 11:07:55 +0800")
References: <20250709030802.850175-1-chen.dylane@linux.dev>
Date: Wed, 09 Jul 2025 10:22:09 +0200
Message-ID: <87zfddepu6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 09, 2025 at 11:07 AM +08, Tao Chen wrote:
> Andrii suggested moving the attach_type into bpf_link, the previous discussion
> is as follows:
> https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com
>
> patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
> will init the attach_type field.
>
> patch2-7 remove the attach_type in struct bpf_xx_link, update the info
> with bpf_link attach_type.
>
> There are some functions finally call bpf_link_init but do not have bpf_attr
> from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
> now use prog->expected_attach_type to init attach_type.
>
> bpf_struct_ops_map_update_elem
> bpf_raw_tracepoint_open
> bpf_struct_ops_test_run
>
> Feedback of any kind is welcome, thanks.
>
> Tao Chen (7):
>   bpf: Add attach_type in bpf_link
>   bpf: Remove attach_type in bpf_cgroup_link
>   bpf: Remove attach_type in sockmap_link
>   bpf: Remove location field in tcx_link
>   bpf: Remove attach_type in bpf_netns_link
>   bpf: Remove attach_type in bpf_tracing_link
>   netkit: Remove location field in netkit_link

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

