Return-Path: <bpf+bounces-49825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB246A1C83B
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1583A7008
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0725A658;
	Sun, 26 Jan 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NOXEi7oE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE2153828
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900229; cv=none; b=sQUsAbpNvZkZurUupYmfFL9CjaKzmV4p1M6ZG0FwTxax0OOkGeKioRLyZMr+v11o4at8wq1vFmcs2bd6aBIW68WMZ9+fhxeCcP3serJZJOiDrHp1txyhDyO6PKZMo7DdR97Pz+8nb77qcrna6VI9YEcsUZMCSp7NTKKcicU7mgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900229; c=relaxed/simple;
	bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsqwmeOA5s/hjYszIRBIvwUmMHxNN0xoBmAkN0oIRZJWsgHJP5yHtm3wBHDoGHDSvYTR4+zI23hw6iQphKdt/LxWu+DzgDGCU+bAdMS7pHkwfIlbAMwzBlj8VY2cThdYwa6C+0Vk8aL6KNQQk1L47nQEFADNQcey+6gpEMK7zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NOXEi7oE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab698eae2d9so128618666b.0
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 06:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900225; x=1738505025; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
        b=NOXEi7oEIz1DHEHbZnl0lmKWa5axJwlKmut6toFhcB/MtSjjok3ntn4uOp3eTeIPJp
         HXGf8wEqc7t2DUipWeqENeUXClrx7f4DW7Y//bynu8CRsV4YbPABBy4XmPHak2j53Onj
         d6RgB0wfrSON3QcgzcfQruvvc9ocgssiWVUgaSxn7selra6P5efPRg12vHP3CZR9dSog
         MBxAFIBEAcLoTQSYXtMnHJS8Mr6uGRJfha5u3HiJTPrBXJJd/BOtrlj15YRUTlv0P70V
         4Op2WHuO2dGl4A65BwLsGvZerqN9q5P5L8WACG2YSxWiZuNBCfr3f7ReWjR/H/46kfza
         2uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900225; x=1738505025;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9zlLkMNuptz1MrLYOUQcIFDBpe9clffCABrxF07OvA=;
        b=TuoeFb5NMt2aE5qA/Ksiqd7t4BSxzzU1APqS5jiTQixL4afR/S7u0U8bR4GNTmYqML
         +sbGp7GiK/D21InoMfwieziI021Bxv02N3QrWBVhIUOQPLIIrPQeYLQxUc726vZkURQ2
         Fvt08phBNP14+K6GJer+qVKVCF+oqbLxBljkLBBp4wbEjg4MMaSFuOjAuRqTMH/FO1+1
         mnQRJ2MN5ber7+qm9NghOZfY/25XUD8Zq+BPQpNPlujcOv0FdAlkkG7RAzoCBJl/gBsr
         0Fcz3qPlQFo9x4YBrsc8lPavDVICYCBoXJnNmZ/XYgXxpupVyF/eP5PEk/nvfen35Ecv
         FBDg==
X-Gm-Message-State: AOJu0Yy1OB0s+r0Yqlq74Hm3jaL+bq2R2s2tLs6krbu//934/dZ8LfjZ
	MQ8uUG4XR2noLKzN7ByEASMQ8nMx4cs0jVQ1mbf8ay4FDWGOxKFGGmBAaxvJflc=
X-Gm-Gg: ASbGncs0JJI4mO3EguVjoV4IQKiO9iYtM9cdzWHyfnDqc5DbIX9aC3Y5Xbx3OXKsQU2
	SezPg87qkVCrku3bKQXnaU9pfdcO0zQ5Z5oVxJ6/qxt/ANMkdkYK1OTPBRDrRNkQg3ya9tpAA0R
	oi0PMIn+qpEAuO+6ykkHQXPXJzp1liNIpPvOuVSC35ua24mZC7Ctq61qh3G6aTuD+Lxj3vS6BPv
	jSrO15/TIPSuaUkcTCGEJWelm888GvvVlGMCj0+VgwfUQjG4ObtT0/DAdExOwQUOJLejaK3mA==
X-Google-Smtp-Source: AGHT+IGWs6TCgafm7EZsQWtNb77Wb6bDxT3YATHBRWhxGzfd6txwT/XuznzYq9+S9m2UEGIDSMl2sg==
X-Received: by 2002:a17:907:3606:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-ab38b274a03mr3048962066b.17.1737900224947;
        Sun, 26 Jan 2025 06:03:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e67836sm430235966b.66.2025.01.26.06.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:03:44 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 1/5] strparser: add read_sock callback
In-Reply-To: <20250122100917.49845-2-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:13 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-2-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:03:43 +0100
Message-ID: <87v7u1d64g.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

