Return-Path: <bpf+bounces-70336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F5BB7F2A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EDC4A81FA
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEB18A6A5;
	Fri,  3 Oct 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUefcczm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA306FBF
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518129; cv=none; b=ZSDKFLt/BH+ga7NTgVk9mRxmVo8aC3rjVLcUv6fLjAKMPQNPuRNoFKZ4UZi56X1lDeWeYeqDd436zKnSE7w8+/ECfiV8RYGqWDhDIqPwwqhEjQZNBERIPUjJvZhE3j0N9kDbetoizhgCcuugKuKLJXCu0+8OGElMkZJRfQsxQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518129; c=relaxed/simple;
	bh=nsXxESHRL6oaBR20+1/AcJjnmAIcoTP8Fd0BtIqzMq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcvJVPjDLrym6XHandwvEzlc6UteubNPOq/4uS/4A7Z4PvgodSzj5E1yxdPy2GX0I1O6mOmxGwlodfvG1y1d1bh94IskOxzMIOTYOO1QYpc92GlCzawj9O+IPrfysjAyWVMDsv5ykR9S+AFc8xcgoVAnn/NdEtEllzJ0do1tG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUefcczm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so2254466a91.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759518127; x=1760122927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nsXxESHRL6oaBR20+1/AcJjnmAIcoTP8Fd0BtIqzMq0=;
        b=CUefcczmfmYpigWrBMbZWYYJFGfbK+D8+/+M4n/wgJHzcDxztmoHRCmHifqNgHJeY7
         640QyhvCirszHN6PCtwT11bzg6jC8TOVuildAFlBCI1cE+CQlLodkzd0i0qcHMcHayD8
         rWqMkUgxr3vg5cC3lOKhiUzPRgzqhckhnY1RK34jS7i9Zs9FoyBxfe2D/zybb2EfdSJ9
         D1CGOcaUUckejunUbSE0gzl/k1OltYwkFLCuuJbuBBgFxxRuF9O6DUf3yuRpTZ/cvA00
         TsDVuVzEjdfnTZVmJtN13nc77gagHX8f4fAnf0yEaMorEfEHG1l6gB5QhqOwMETGtt2b
         18dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518127; x=1760122927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsXxESHRL6oaBR20+1/AcJjnmAIcoTP8Fd0BtIqzMq0=;
        b=w88RDGE7EB5kDqry3mFa691wEX9sDmQ1uq0R5CvK/k3R1XrniscVXrwe86fivdUjfc
         B4pVEVnWz2pLOiftrNWMPE9NpUoXd3vkZypCY7W8XbvP9z6mt273FBKPZDwtFEkAZb4k
         6lr/REN5tsc8HIIUSDFzqksfTDfCEo1IlSlPbuyv6RZnsVF0a/MQfU2Y28AIVflCw5YG
         4fLL3vm/WkcnF3yc+qJy6gJCQ7PCye2efCyUiumVYQ/F7DW/DAWQLbfv5NsXJYIHrRes
         iWpzo90b4brWOi/fXcnoJ+B4d86TB+koAQBqtU7WIfw3GgjjowoKD8xLVlioL9U8XNFb
         VKgg==
X-Forwarded-Encrypted: i=1; AJvYcCWThpTsroZYlRhIAPuT8GlK6zFxgtzYgHiuFIMxR/TVbpA/vBUzHgWHLmpqNgYdxkrsf9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioLY3hVh5zsDS79GM0mi8bImSwSyEFSm7EHzzD7XfPLK3Ki7i
	ncRyczhb4HAo7yI2yv7H/jUNnoov1rFzexT8I6CRKk7wsa3WbUWe4a4e
X-Gm-Gg: ASbGncv4oIdOPECx3PMu7Aq6Rk0cMaQ9zzfOVuRtm8fOkAssBolNaX6Md4KKBlCN5cg
	zP4Gp4PqMkjYuqqmQZe/M4ra0xRmI5l3HSViA0uv4sc4oI9qJOkGpS8Po4oLARtvZkAp8/pDIp8
	0KTsMOGX1WjGF/UJMybe9loHqz5B8yu9WwUvz8KwnkHpJHMohbib/lGC/xjXg+PqBxvFW1RTxkP
	dC9CnrN+OQrxF6dmgtcoSEKcGI64B+QYZto/GzVL0aJ36rVWJRNUAZNop6gVm6rjcgpmlvQxuzs
	BoluzZaKXijzhqMX2Aa7TPICs2khmnQ15tu2c85B95Gbk0vh5lD5LQ+SeFGSEu18sET98PSaY8v
	TRh5vvbEIDrQeVXLPRyuEKfsULE77pRmtob/jRJr/85uHSTgg11VBBlLzmkeg6lh4/+4w4MkN
X-Google-Smtp-Source: AGHT+IExdlbZj/uXVNj/8Q6TQULAndjQh+HtS0biLkyTY7VOgN6DtcJ/jPG+P4QvZa7DyBetj6YDcQ==
X-Received: by 2002:a17:90b:224a:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-339c2807227mr5692138a91.37.1759518127095;
        Fri, 03 Oct 2025 12:02:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff27fbsm8538801a91.14.2025.10.03.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:02:06 -0700 (PDT)
Message-ID: <224f98084ef917e3ea5c5a27cac59a4ec067b03a.camel@gmail.com>
Subject: Re: [RFC PATCH v1 05/10] bpf: verifier: centralize const dynptr
 check in unmark_stack_slots_dynptr()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 12:02:05 -0700
In-Reply-To: <20251003160416.585080-6-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-6-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the const dynptr check into unmark_stack_slots_dynptr() so callers
> don=E2=80=99t have to duplicate it. This puts the validation next to the =
code
> that manipulates dynptr stack slots and allows upcoming changes to reuse
> it directly.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

I don't see any test cases covering this error condition.
Could you please add one?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

