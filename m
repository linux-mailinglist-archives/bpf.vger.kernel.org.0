Return-Path: <bpf+bounces-72381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBBEC11E3F
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EB6427D38
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBDC32D0D8;
	Mon, 27 Oct 2025 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPIKQ7c+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889E32C951
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604735; cv=none; b=qJAk4rJff1bCxFIdorRUxDuZH8HjFeqsl9I47n8L/SBbNxDTO8JM4q/gYmin3hSlbepJ8L/z5vaEIPmmBbyilfhzYBBaNN9a8BTILTT78ZlzSlgNoq8XsqeSVOXkUji7x7n8jDEK7OVTuQVnRo9KrWkr6R0EukxvR3IY1xCfdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604735; c=relaxed/simple;
	bh=mZopSRQVUi4354yRGOImkW196b7/LGd3/FDZsbsQQ0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCZ+p1HA05zjyPW0faAlHqiL4eK5oPamwZlSnYTSFPtEWOhbYenr/6sfFgBc0dbx1H4QWx2i81ewZvNjbmgQead/+oi3U4V1orRikYwh8vU80oZHdoBZpX9kUYqI06ZqM15UpQMoqebXZzeyq4PrnQKwdXL1MNK4e3bT3uyWT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPIKQ7c+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47103b6058fso38217605e9.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604732; x=1762209532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2tPDXG/coalmGQ6BNmejw+0knfQZmINzdFwuhoTotE=;
        b=WPIKQ7c+jry89ufIboEqbw6Vo9Xeq7CWNXYgGt9w4eSAvN2dvOeZJYLSlKvqv/Np8B
         QifYKJMBE4BpkWqyf3bxE6RUHGXNPFjfp5LT3kYmmZYo6WBCe0220x8Czf0991re3SCo
         gOADUa9r3CJ5VYcf8VvA/NsxZ5Iz0kq+6+8E6ZN5sK8Es/0X0xSLGy/tiMYucOZ10pt6
         M1KPLUP0lzFUtX28FQQopZCKNwUvenPBDwQf3l/MII+YZT4Cxfw+FiLofOe5a2snhCW8
         WjYfw2K9nWQPLFcG//MxoF0+sNeyGC5zH3ROhwaKU9kz8ZwEaRVrtYHT/XmXk5zcOffe
         JD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604732; x=1762209532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2tPDXG/coalmGQ6BNmejw+0knfQZmINzdFwuhoTotE=;
        b=lKsS5wpMwVPR1QsqGShRKA90JZrrGrq1NJWYxZwAlZ8Imiwa4FtbS7HPOax9DR+MIJ
         nb5EL1tS7Nbm3kWbeV7ECpFledeL0J3k76Z5bTAwDzpCRaedDxELz2S+C1ONGHJzfTyK
         q9KCTEO+w65gWhEgrxe2DFLFej34KDf8qqqy21CbHytcc0UkjRFV21bIBF6mC2LrKnmn
         8j9stbgVYGGNBB2Q+qqwvr6DFnM6LCzz1t0WjHKukgP8TZBKcNGTJer/IX41nQdbMzfF
         c3t0Dh8LkIpTgAEGpf/pBWw4pvpM9HP2KXnl+vYqsKG1AvbsxoBUbksruf28Tht3JIuD
         rF5g==
X-Forwarded-Encrypted: i=1; AJvYcCVIZS//Uh79JJ+GIKealCCD4aohlJCdRKksR1XXK2rHQBpelChD7IRCa4+Z9Bx8CE916Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoiW0jboahfkipMlyESEhr0Ok1DVrbxMsdI2JkDfFvXiP2VMF
	/KRv9zMmdWbND0DC85UAGGBQD+hg9Czp8PXC5Gz2l27F9B1EG6blVMzP
X-Gm-Gg: ASbGncvN5ZeErYcQIloBF8aOgWySeECdyLkqiohhR/fqHWN6z8btu6PiVc96GskVUSI
	6nAlC0mwA45v3drA6qPyO54x/NkSQHmQuSD5rCV12XGn7fh9284knb90C+BZ6W+ywVzCjGeXNDP
	kQM6TtQJJB10CYnlxQV4d8VfrVSs7MzZBD+sm9JQJElklkBBHtjday2qIW7eY9tPgXeqcXBfZeh
	3OWXQuvygIw3Wsah7PRHKM7IBEF2dNrMaM1iaVJ8Li34d4zm83iMGK6RK+Er+W5fHnNvxc9NV6Q
	WbFaxenXPLZnZSvUP1kU/uyViPi02BsDjGGY7pXqGmXlnRg5lBnjNzWX5zcNkgHtLIWItuDllAh
	Ivtu+Q9Pnf9DLLvh5zBKcHPIEI6rKX67Gp9r1IUqGlDlZmDxB5t2ZksLORqtOX294PcJvdeA3I8
	o=
X-Google-Smtp-Source: AGHT+IFiCCMIf/Ghw+gRyN8J8phGReAHAwec4nlXGAJ5oIjeHM5dgNEnOqJddAzoxLYreIXmbyyrAg==
X-Received: by 2002:a05:600c:4383:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47718051848mr5826915e9.0.1761604732269;
        Mon, 27 Oct 2025 15:38:52 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fc0335sm4081905e9.2.2025.10.27.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:38:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 23:38:50 +0100
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bot+bpf-ci@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org,
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aP_0eh7TH2f_ykhz@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
 <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v53j2leswscyunqmrj5zvr3bsdafxlze5z3yp4hvsd6epbvdvm@njx4yhpkqoiz>

On Mon, Oct 27, 2025 at 01:19:52PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> > Does this revert re-introduce the BPF selftest failure that was fixed in
> > 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> > still exists in the kernel tree.
> 
> I have the same question.  And note there may be subtle differences
> between the frame pointer and ORC unwinders.  The testcase would need to
> pass for both.

as I wrote in the other email that test does not check ips directly,
it just compare stacks taken from bpf_get_stackid and bpf_get_stack
helpers.. so it passes for both orc and frame pointer unwinder

thanks,
jirka

