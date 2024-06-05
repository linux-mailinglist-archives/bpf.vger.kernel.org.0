Return-Path: <bpf+bounces-31421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0048FC6FA
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DDC282A6A
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA714B07A;
	Wed,  5 Jun 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGOV8clo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768E1946A9
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577569; cv=none; b=mnpAIbX1amuxgS/CUXFzDIw0NY6QFg+sOlSPhLFv6mKKRMbZ1UP22kx2tdENg2uxJn9rsYHxY030LMVyLtxMpE0Ha1GQj+IbpYEqZupxXXlXL5gutFP/n9H3HD8YkjXowbVooDg8+VmAPFpxZ3jdWgTF0P0ZsSr8LudGAI5V1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577569; c=relaxed/simple;
	bh=gbwV/j8kvPd7OaJtGO8YIL/DlAWkFRXi9Iq+4ranC4E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRKGfn+5A3Lk/Zd+3jytIp8nK4Sq4z8Zr41qwmHvvqP//z3AEL/hmhF5emJGTICI5HHEKoRwYebVhEMePpaH52sSRoA4IX0keFwP4sKUxqkLp9zPaHqh9nIJzgzvbtxsBnrCDOxAhfv1REEwG9oS8fE9Gk4YSxvdpVdL9Ksw8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGOV8clo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so7256325a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717577565; x=1718182365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIwHcfyNSQZTCR/tLgK0sgxjmf4pD8u0N9MXYYRWozE=;
        b=TGOV8cloSpANVHJQaYVPmjlLdraZCoB1HFhTpvMTr7qt7hVTRxzU+J8X++kkcUbmiS
         LGNUtz7i21uYN8nNYldXZqNMDof7SPLgKeOH4bPh9tehTM3UquSQo3a1XRAopvKmP2Sm
         epTCVhjNwc0eTCMr2sirr0R8w3javt/mt7rJKrFXDgRcpG1WFMwJc5DjNcXcsXDHbOUp
         FNJaqmdZzbnejydCQzj7+3IvZzMig6wHtL6UugRx4/nPw95M5rYdnAfgygG4XUyBAzd3
         NBULpDDX6+QhMdhP8H4Dv+K2K2BRba/5vPSzZUInjNwyaisc+pTiFqb96/DRvaor1R6N
         GIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577565; x=1718182365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIwHcfyNSQZTCR/tLgK0sgxjmf4pD8u0N9MXYYRWozE=;
        b=D7xOy1BWHD1fcFc/XpyB+/WDPp4YPXyegXxeJHsuVCVJhUaZrHNiCsakDSblJeJa4N
         UP0J8yapmkC+LeUKJimgRUqXzN5qinagYtrZR9V2nAFA9pEZB0O1fQiKJEaBjRUGdvKW
         rE074pow9SsxCBKK+yIZr6MjVW9YYeoN2xG7fDEPTS4Tkk/6SzSwwVdlm7Pj5sKCfMY9
         U8e+2tFDy1qyvkRjMngBq6tXHYwW2GJLFPCF79s9DVzexNYSymrbiNvIye6sIq2Xs2EG
         /vinKBGbI1IeMVL9GfbIBDRbm7sS+aa79TZLi/Czm9ImdZNPmQyPQ9BsDxC2tHZstGsr
         Pgrg==
X-Gm-Message-State: AOJu0YwsgJTYIwdPOKz9SpW9pPypuOSnj41Cn7I6Wk3CBjzHv3kf3h3h
	nNHedoi4UQhChXpW4UXkBlbNivFwuupejdAyptoq86sua0E2IIUn
X-Google-Smtp-Source: AGHT+IEQY2XpgGszW67jhaZeFTTtbiUcWsFMjl5/dFHpttFQ793MSbtU3DPT6otp7vXC3dETuAX/IA==
X-Received: by 2002:a50:9f88:0:b0:57a:24a7:2756 with SMTP id 4fb4d7f45d1cf-57a8bcb31dcmr1202598a12.33.1717577564727;
        Wed, 05 Jun 2024 01:52:44 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a468ebb00sm7738318a12.52.2024.06.05.01.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:52:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Jun 2024 10:52:42 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf: BTF field iterator
Message-ID: <ZmAnWoByxFnBJV4F@krava>
References: <20240605001629.4061937-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605001629.4061937-1-andrii@kernel.org>

On Tue, Jun 04, 2024 at 05:16:24PM -0700, Andrii Nakryiko wrote:
> Add BTF field (type and string fields, right now) iterator support instead of
> using existing callback-based approaches, which make it harder to understand
> and support BTF-processing code.
> 
> v1->v2:
>   - t_cnt -> t_off_cnt, m_cnt -> m_off_cnt (Eduard);
>   - simpified code in linker.c (Jiri);
> rfcv1->v1:
>   - check errors when initializing iterators (Jiri);
>   - split RFC patch into separate patches.
> 
> Andrii Nakryiko (5):
>   libbpf: add BTF field iterator
>   libbpf: make use of BTF field iterator in BPF linker code
>   libbpf: make use of BTF field iterator in BTF handling code
>   bpftool: use BTF field iterator in btfgen
>   libbpf: remove callback-based type/string BTF field visitor helpers

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  tools/bpf/bpftool/gen.c         |  16 +-
>  tools/lib/bpf/btf.c             | 328 +++++++++++++++++++-------------
>  tools/lib/bpf/libbpf_internal.h |  26 ++-
>  tools/lib/bpf/linker.c          |  58 +++---
>  4 files changed, 262 insertions(+), 166 deletions(-)
> 
> -- 
> 2.43.0
> 

