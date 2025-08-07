Return-Path: <bpf+bounces-65212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B2B1DB2F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B5118C5ACB
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406926A1A3;
	Thu,  7 Aug 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKknOwAv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2692237173
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582445; cv=none; b=UC1BT7OsV5oF00CphIO8oXgH6jQJoe5HN7C80w7fU5H1AVcMXD0T5kG4eie9wYrw54Y6VnjoHrEqCYEdctWS26EZliv6vNPH7GQoZpX6kno/aeZo0j006IMchpcBtRElOFGhZN7Cw3Ltp8avtq2+3HtPcDJIAt2t7I2tgxghgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582445; c=relaxed/simple;
	bh=jzLCKTQo43ZZ6J152JXDvC+pL5B5MEcZ5OOKgRQThGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKihcsrPuoGK9OtlHhbizbkwXtsuSkJecIM9to+QI+mPti4UaqfDKrUEM60MR7Ohph6auVnJ2u+C7D3ABa2Jmyzu9MO+YViXPNq2/PW209RLIrHYG6O2uGIakZW6/FBe5UUoxylFffke2YsfD3eL5NGhsjmlFeH3nhZc4A0KHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKknOwAv; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so1273355a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754582441; x=1755187241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h340l7cEriae3FjaBK2b3VIxDIulZ8j4XUZFMyj6Dv8=;
        b=IKknOwAvImkkeypMFZcos2ZyXIjdfI15V4HaFX3MKzAxshZ3CmCuFyBeZnZNqL6E8D
         un8BFFNVjvDkr98cqK/etrF09V9SGvP6kfpysUjyQ2L3JPRLu5ajEUTvjog/izyhLnG/
         p8zLobxS1LoWa5QLWZ3I0N8kosmb6fgElpnNBfJyFPGiWBOzoK3roDaFKFngG5UFwZlU
         z5qdHPWzkClOxwMIFuENx218qcJyQo/88OiGsU6nl3nsnrzBA0eyOQniDwClRd5vW6r3
         jWg02I7bGaiI/WKRpSJUBWi1HWRPqSyoMZBGS3xVgNdVnUmf3KULX/dihljrDCky/TZO
         JAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582441; x=1755187241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h340l7cEriae3FjaBK2b3VIxDIulZ8j4XUZFMyj6Dv8=;
        b=FkjxIpumna79RDBlYkyMVnxxCFzuJDen/vTDEl2xV27h+xpuhbCymt6id1u1yAHCGj
         367RUa3urlpSjE/uhAkenmZ/veC18OANZcOiUNwuXwgaje3JKp+BdRprjeNeW9Q0gv8u
         6AesxeJSJbZ2OhQES8aFzXxE41iizw3lUqVYK/+671hpnfNqERYEsRBnwPu/pRlWRypn
         ke6ba0oFejDZVcEioJtVPmCmUDI8NjwVvaivm/0iBTynsMShe5BmUmX/kFTJFgVGPsM0
         rV1pD/XhTylzf2mKisC7QRnGL25JErpzwHPwRUWDUF1n+bd7syC0uBuALSb3TD8oMAsK
         yhgQ==
X-Gm-Message-State: AOJu0Yz5w6h7FaHCF3woYDN7wlhqlxZxpoDXGZ+VbEXhVmcUPmmnxSF9
	nDGUk1kBEksmWZ4GulRe5R+KRZ9/wGHmk4oKbJQyUa5sA5cMwbu93eEfQsn/sH1CfuFgfn21L10
	HOoS9d74mvTmL73D/jd4dCKgb1NBPGVY5bYfs
X-Gm-Gg: ASbGncvIcTR0mgdSCmVwSZ+Q5OonXgN3T5qimw5KQkF03SbaIKbPBdSu5m/nJRCcnQD
	bqLAeQs16ImhxRbbuVVh1DbsoYwTgceK7il5quBfeS4JtdmOANmw86Ii26EGRriJWvTTRLi2kPq
	ZaJII7DHJNHm5PGYNA3bFj2AZ1wrPPuwSF3TfI5AqtvaQsMXIOpi9tgldJBsTyGAMdcXMJ1oXiM
	QDnlFWNxmfQ2T3HBNZuzED9DVv5UQ8pSsxdJXMn
X-Google-Smtp-Source: AGHT+IHKZ+tFtar72WiuyIO1Wg+78rNLygprKecz4fV2sl6FVM9CvIBlP+ZObRTmp+0b5UCFjwgEHdziy4eXXyfcRl8=
X-Received: by 2002:a17:907:9806:b0:add:fe17:e970 with SMTP id
 a640c23a62f3a-af992aa34c9mr654953466b.14.1754582440735; Thu, 07 Aug 2025
 09:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807010205.3210608-1-eddyz87@gmail.com> <20250807010205.3210608-3-eddyz87@gmail.com>
In-Reply-To: <20250807010205.3210608-3-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 18:00:04 +0200
X-Gm-Features: Ac12FXwXsNrEq35VIK5dQxzo20bkEGdwoaHmyl1A1c4H3bGxVeiSvlNHuSUv4Hs
Message-ID: <CAP01T77ULuQtYN0cSaDN_g6_JZ9b5bVwFnNq0032+CxJ7swyZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: use realloc in bpf_patch_insn_data
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 03:02, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Avoid excessive vzalloc/vfree calls when patching instructions in
> do_misc_fixups(). bpf_patch_insn_data() uses vzalloc to allocate new
> memory for env->insn_aux_data for each patch as follows:
>
>   struct bpf_prog *bpf_patch_insn_data(env, ...)
>   {
>     ...
>     new_data = vzalloc(... O(program size) ...);
>     ...
>     adjust_insn_aux_data(env, new_data, ...);
>     ...
>   }
>
>   void adjust_insn_aux_data(env, new_data, ...)
>   {
>     ...
>     memcpy(new_data, env->insn_aux_data);
>     vfree(env->insn_aux_data);
>     env->insn_aux_data = new_data;
>     ...
>   }
>
> The vzalloc/vfree pair is hot in perf report collected for e.g.
> pyperf180 test case. It can be replaced with a call to vrealloc in
> order to reduce the number of actual memory allocations.
>
> This is a stop-gap solution, as bpf_patch_insn_data is still hot in
> the profile. More comprehansive solutions had been discussed before
> e.g. as in [1].
>
> [1] https://lore.kernel.org/bpf/CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=5w+ppRWWiYSGvQ@mail.gmail.com/
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

