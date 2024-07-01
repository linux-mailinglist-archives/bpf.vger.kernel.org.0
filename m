Return-Path: <bpf+bounces-33476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFA91DB4D
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D161C21B1C
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DB71747;
	Mon,  1 Jul 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4duG36K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167C25622
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825529; cv=none; b=ZfuWst8z5bJh5Z4IK1ch0MYNiz6kdMhF9CZUm5t37HPDZEkAuKwnc5u0EZ+RKyP/CbGvhikJT7QgnjAj6YmM6thuIIX5rq7gwPp0Rp87c2Z2B8/JvcS9vIDTnqOZA2XbTM0iVY/NcrVImOHHY3V/IHdsvd+goFfPfKfj+YjUUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825529; c=relaxed/simple;
	bh=kLks9Xt8kT5upc4fJxVHC52PPkDDwwPQyo9LqvCzKx8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKbuH6q9USoPgsP1KhoNYOx4sCJMblFpkkbWzi2eFNScIQY9uQwUn3y+Y2Nm0/fV/hw1ktM5jBcPXjvr3mV8HEdhRKgFkyRzzPE4mCQiTx9Tyj+8T2KUjBtc0PNYx2XiY01hZYGNz9My9q7V9DIcG4T3ErlG1nhjebx/7GHk+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4duG36K; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72585032f1so307479666b.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719825526; x=1720430326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCimVIdgvyXRCKhzNgOKsf2aw8I+uDGTX+4mKOe1Ics=;
        b=b4duG36K1VoNg169nPwBPjz3iBO7trtmupqJtvgzBcTdE0uQLL2+jiTd/aw49THfO6
         btR6gFzGCKZP+QrCI6/UNGy1pBRubv7HdHLgzoqjWJ82M6f3b/46qwZWABJV9Wnau6TT
         uDAkQXbDBEPu/FKW37MOJRdNne3UVCjkUmIqHAqKOYu/eYy/mOxunO7On3eCz+DABxF4
         ioXNlkUwiuwfZ5TCddj5uCHa0BpvCu1dTeLt+VSD120CQ7OVRqmf/bGy91YwB84pelEO
         Ps5a3jFtvzOk9S3tYv4Ej1uQirALsNjksKV6lhg1OoX5S9USunzD/PYTN2qI0Ehz9Yxw
         VoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825526; x=1720430326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCimVIdgvyXRCKhzNgOKsf2aw8I+uDGTX+4mKOe1Ics=;
        b=cZqZEAKtG0TfZmdRJ9M8nX0uvO5VhrOyLmnsM6nQehLGRuDQ69TnPnEVmub+JJRiiP
         MSDt0Je/TscAqOJelP1YRK4/6VmJYhV/cKGcAoyio64yl+GS2u+sU0XTYBwPnhwD7Stt
         /OToVPFLuk+/rkCpSDRs9w3xC2aH2gRdxqwApBHYmoJIICjx5eNaWTfLzYup7w5cCbBX
         fIp66ByC4ql9Sivhi/Bro8bCAebEOuGvUiSudNSMvPne/AzMwiPKR1ntEL71RNYrWpFy
         vG1IXdEzV2JnbVcOFR+VJHMvJr72/gIDnfxiRwJRKUN2TUbcxeyFsfxhJjkLMtzZ/n/8
         eKoQ==
X-Gm-Message-State: AOJu0YxFLWvd24kqJuKobhfgXIk24T4hZZnCzZ1//DzJl/H1yfB2wRcY
	h+QXugO3WNzRUT9PPkrPQknvIxd8B0o10BebtsVTUDvBQd5U0FhK
X-Google-Smtp-Source: AGHT+IFLidnQYQkjgeYGGjUXaAWODQjX8qrAwzk74x5PMhqyg5sm1krS4Jb4njvCQCwNGutI78473A==
X-Received: by 2002:a17:907:7d89:b0:a6f:50ae:e0a with SMTP id a640c23a62f3a-a751443876cmr402041966b.37.1719825526376;
        Mon, 01 Jul 2024 02:18:46 -0700 (PDT)
Received: from krava (37-188-135-196.red.o2.cz. [37.188.135.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06584fsm311906366b.107.2024.07.01.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 02:18:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 1 Jul 2024 11:18:39 +0200
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 0/2] Use overflow.h helpers to check for
 overflows
Message-ID: <ZoJ0b_DtHvcTbehC@krava>
References: <20240701055907.82481-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701055907.82481-1-shung-hsi.yu@suse.com>

On Mon, Jul 01, 2024 at 01:59:03PM +0800, Shung-Hsi Yu wrote:
> This patch set refactors kernel/bpf/verifier.c to use type-agnostic,
> generic overflow-check helpers defined in include/linux/overflow.h to
> check for addition and subtraction overflow, and drop the
> signed_*_overflows() helpers we currently have in kernel/bpf/verifier.c.
> There should be no functional change in how the verifier works.
> 
> The main motivation is to make future refactoring[1] easier.
> 
> While check_mul_overflow() also exists and could potentially replace what
> we have in scalar*_min_max_mul(), it does not help with refactoring and
> would either change how the verifier works (e.g. lifting restriction on
> umax<=U32_MAX and u32_max<=U16_MAX) or make the code slightly harder to
> read, so it is left for future endeavour.
> 
> Changes from v1 <https://lore.kernel.org/r/20240623070324.12634-1-shung-hsi.yu@suse.com>:
> - use pointers to values in dst_reg directly as the sum/diff pointer and
>   remove the else branch (Jiri)
> - change local variables to be dst_reg pointers instead of src_reg values
> - include comparison of generated assembly before & after the change
>   (Alexei)
> 
> 1: https://github.com/kernel-patches/bpf/pull/7205/commits

CI failed, but it looks like aws hiccup:
  https://github.com/kernel-patches/bpf/actions/runs/9739067425/job/26873810583

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Shung-Hsi Yu (2):
>   bpf: use check_add_overflow() to check for addition overflows
>   bpf: use check_sub_overflow() to check for subtraction overflows
> 
>  kernel/bpf/verifier.c | 151 ++++++++++++------------------------------
>  1 file changed, 42 insertions(+), 109 deletions(-)
> 
> -- 
> 2.45.2
> 

