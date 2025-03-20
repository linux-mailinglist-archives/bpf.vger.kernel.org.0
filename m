Return-Path: <bpf+bounces-54473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAAFA6A7A5
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693B817AAF4
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2982222C0;
	Thu, 20 Mar 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnhWvbyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC22AD16;
	Thu, 20 Mar 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478690; cv=none; b=TbGuznrU9M+3InA56m4Iy+zoGc7G5zHrOHggNrcD5cXgnf4lOcFkmakhVTms1nLfN/ymDDcHYV9fssfAHtmc/dhMKzCbALSq+lD2WCmfkHAsHVWzNzxOeSfxbU5Tjd93xhqyXcHJ4euYKbYinxeCkp1WoM1rtmG9h+ulil8ZlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478690; c=relaxed/simple;
	bh=Yt9hy15zEGNBpO91IHCS6p/xqj9mzRbON/1OE2Kyl1A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCbRrtWC02es8rg/XJtE+qfB0I1vBR9g4jvoAaFCaO8Nm5+ubq3LRLYZosDwjuBlS2EQV5Z18Cq5vWNT2ThCvT26mFVnxFgTxGvINLiq0wcZ2WvtPGFPzL2VisVIpEfgMtHjpT7Hft1J2kKDxBSvRIw39CPSAPv/PvrDvRe9vWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnhWvbyi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390f5f48eafso442502f8f.0;
        Thu, 20 Mar 2025 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742478687; x=1743083487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vn81ISR0yNm/qr0HtNJu+EHioxH/WEZq3aEC2iTSvKM=;
        b=CnhWvbyiXz3E1hWW9io39Dr391S8jtSftqxqHhhECAqXxYItUXlzsCEtOMUIjR1u4o
         ds8Z/d2zjWiMVSDLmYcgCxWpvuGHTL7COZvmSJ4IO0bspq01KueooOkWJLFkEaCXnGmG
         8bpdWJVWfvrjGxfqgDtfNa4ZDeMYQSbQVz+Y7mdmagybogbs/i8E5r9AICssADC00qX/
         vP/2JQmhEBSgOEv6qxaTPfcUAWDgQhI1B0r/xEANQ5AMLafqpkUFLWr/6QAdiMYKJyXs
         Jj5VpSzT9Qavx9ohvvyt/ZK+iXd5yZ9S66sfCljJVv5MVFmZQDeEneouEVgsriyjbrmu
         VuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478687; x=1743083487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn81ISR0yNm/qr0HtNJu+EHioxH/WEZq3aEC2iTSvKM=;
        b=L71v5zBW+ZoLUXAC4ghCss+9BhN06zlX6O83xxlqkYkEjnqeJdG7dgHK3w+YqhaMIH
         m8Is9EtnexTt0k5pIqnCjdF2+0f1ZV0kac3JMUh+o2DcOchC7D06kBkn1lC9Pb5n9Trv
         oh1dBs7CjNo0tJ/G5mORwRensbKkN+Z523whuqRYTBWPTLYR9w+xcHd/hqgUyP0d23aI
         hSTWiqCfcsOKFZ+cwdQmpgVYGY5i08uoNTin5nDgYewPXXSW+SnGYR8cnFVve+afdC7+
         +LZdFLb+1vgqbcqTYsEpbiCERTrPErRT6Sd7Aoii9OfLzM1q/5I9y4odZ2RDvF89S4xd
         tOTw==
X-Forwarded-Encrypted: i=1; AJvYcCUEIaWkeGilbOMR5gN6YHEZ4Yr3JqYQSokyzdfGV30KviFvobL/Esr1qZq+KcvaCTqLLKGqbP+MZudf8k+F@vger.kernel.org, AJvYcCUkotWcd9qkRiUxmrjB7nKi83qGx9phqXFvWhZd2OtkeMU6EO83BeSg6OmEOr0swMUATHOPnNbUC6OCW6nd7G8mf5NU@vger.kernel.org, AJvYcCXq/fOHQ4bPZs8fWVJUFs3xupPLzPAntn92v2mI2weXNvWiONvbXPsLXmwNeujfWbJ7bT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFIIBYd4eKn3Bmp0N1Ykl+1E12DtMpQBGp/dUVNLbXdcvof8t
	N3GXL5DuZqK+Rne8EzRHBfMyFU12+KsNuqZR/NrFpw4xKogVQqEeUPQsqNK3U+wHqg==
X-Gm-Gg: ASbGncuQ8mAADK0rYcn18MvoD/GQY4UnUDdPMP/u0z6RH7U0lCFwoZAkXuLxmzqyKT0
	CJvwSYLz3uCveCU9vHAgGe/w55Oza6GT7tt0iLzODXDd3wrV1R0IdIVKqBsML0zrWvxHLcLhJ4e
	cnBonzSJbJ7dImWKSOnLlKCk5rpFALRxPTf3wmIa9jxlWtGcDWHAbdYiHSXWIxJl596scIvbydm
	xWVfO3N35hwKtY5tI81ZB22+ahwrIfkBNWMCZ6F+t6mT8WgS9FtHJiB4crULBPbGqBaP7Pww8F/
	mfpfKSjg+27266X+2pHHyWidZzc4UuA=
X-Google-Smtp-Source: AGHT+IGymzs6LfRQCvzU5rTf+/HAxuRgWUZMl/ALUIWJKPpY2mXkpe5eZLLZXzrJE4QHfY7Txg/Big==
X-Received: by 2002:a5d:6d07:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-39973b32cf5mr5934125f8f.42.1742478686566;
        Thu, 20 Mar 2025 06:51:26 -0700 (PDT)
Received: from krava ([173.38.220.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881544sm23401269f8f.43.2025.03.20.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:51:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 20 Mar 2025 14:51:24 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 00/23] uprobes: Add support to optimize usdt probes
 on x86_64
Message-ID: <Z9wdXPtElYOpObld@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320122343.GC11256@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320122343.GC11256@redhat.com>

On Thu, Mar 20, 2025 at 01:23:44PM +0100, Oleg Nesterov wrote:
> On 03/20, Jiri Olsa wrote:
> >
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> 
> Just in case... This series conflicts with (imo very important) changes
> from David,
> 
> 	[PATCH v2 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
> 	https://lore.kernel.org/all/20250318221457.3055598-1-david@redhat.com/
> 
> I think they should be merged first.

ok, I'll check on those

thanks,
jirka

> 
> (and I am not sure yet, but it seems that we should cleanup (fix?) the
>  update_ref_ctr() logic before other changes).
> 
> Oleg.
> 

