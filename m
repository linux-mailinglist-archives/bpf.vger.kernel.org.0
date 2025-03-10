Return-Path: <bpf+bounces-53723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275FA59406
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EFC3A3EBA
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849E223702;
	Mon, 10 Mar 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a17b4m2/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB019F13C
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609020; cv=none; b=Zllkh02LOWhFY5lDjtwD4TlTVVerPExDVqo5oBa6qUIDeZHApAMrOxfdfCT1TLv+osm20OnHKta3RkUul+ywuXsn9mGltcJgIMLKch8WCMfjWRirBIuqSaObL0Xa71JEFjLnTtKZSjv7KtnSHQDKBDADodo0k7KQzN2xiKIm2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609020; c=relaxed/simple;
	bh=Ndubh4drFAH+X8p5KakSbkUTqofxdAlUuJUVC/x2ryk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=awPB0GYvoeKhBk0NOukPhaEJxpkU4kon8FNtmiCJDSunbRRfyxVz43eBY3iyol6Mhvk6ogVa8BQigpQcSbZnq9JFB/qJEwk1AVvvM5p3wcpgxlj2OM/Ii5/3u3Pvpn74b2HLuOBC05mZMBju/cKCbgxlYl5Msm7ekxrLVy47QgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a17b4m2/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39130ee05b0so2508314f8f.3
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741609017; x=1742213817; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwY2zKuB2UZy7eqPz6XdxnCb4pXlnGrej1Qg4uUIN9o=;
        b=a17b4m2/uNcCXhHEqN18Odh9FYWNvctGgsMu+tIeBoylGm1P7OxJh6Xkk8+RlAqoLU
         d0r6wTvTLWU8/+uTaP12v2GHjBfc9vW+65mRNimS5Sh0J/tx4IwrC++6zJQpXjXfWSNE
         Hkdb++TNluaUmlyJJ3K/mG2PVWinF37jjWyv7TLpsluYdqmLIS3OHysIsF85xJvc8sID
         AEnBSvIpWH2EdT394W+xUcRgBmCD47cuRAsaYpKKfx6S5kiSrM2apreis0tR/h/f+14r
         Ptx1pmh+2LIrc/+xhd4V40/KquX0l5QHY1Ee8rcpnNV2WxgLRinHN73+3ktpEEVA/iEB
         TXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609017; x=1742213817;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwY2zKuB2UZy7eqPz6XdxnCb4pXlnGrej1Qg4uUIN9o=;
        b=mprGFMgKTj41C6UJm0xUTrFvR+X3C5LRoch+OAlPfCg4zkO2apU4rgqHF/13S/JJaG
         7eMDMt2PG25KQk/UDR8hSckXifsnLAgO9FzZijiTvT6GxMq1j03gXFdIDVP7aisPfZKM
         tKseUnf5/WxVcneSscwOXKwsfOccrI22Qp/tmEwksVbhkpaCwDFYKq2Tmg49Oc0iHEaZ
         PWC7JSP/xln6zOZ+o05wU/BYQfQZ+L1TJQBZKaBwgA7EhvagAhhkr2EORheb6SY350Fb
         CLtjLOtnIIEIgIt3786H1YHQYmTaDDOob9hI5Bh6g6mlKpO+qGpPKeNtDVy++/aKlGvu
         a/+w==
X-Gm-Message-State: AOJu0Yyv5RbsdLkZK38Sm46ft8IK9ycRePylEkj9x+8LLMgkkV/4EfOM
	wHmK+HqKda/Wua1xUIV2uxv5n4Gvc2lRjOiZrHwGpZebDgAACPe7m/4Qk2WRvR3ynv0sDhQK+W1
	WQeTTUCnn37GnPuF53L9WL5CAuDTnXflqkG4=
X-Gm-Gg: ASbGncuZiVXQBu122ONaI7uLOQpbLtNzOdHtYTVr1Wz8sIrU/Zlid0vsBh6pTzIRirC
	rp+7PDW4TFjqmtf8UYJ7Cw+2fZvjY8f54Bs37YJuzaNdH55AdcgvHdD5SbzKhEOtgXcdlvU1BtY
	HJu6LEUFQzwHdNJx7vtfSqfwEKnQ==
X-Google-Smtp-Source: AGHT+IHgwvUTDx9z3hAqSaeNJ3TOUgvfd2s+kzZuDAa2U3iPuMalCX9lqq05vBAFeKtPsZusOQ41Ki+AvPTBE05f4Us=
X-Received: by 2002:a05:6000:144d:b0:38d:d666:5448 with SMTP id
 ffacd0b85a97d-39132dbb551mr8271515f8f.40.1741609016595; Mon, 10 Mar 2025
 05:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503101254.cfd454df-lkp@intel.com> <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
 <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
 <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz> <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
 <9d8f5f92-5f4b-4732-af48-3ecaa41af81a@suse.cz> <CAADnVQ+MCxQsrVWC_DmQfwBxwv8pUw_9gXFJmO54Syybwwp6oQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+MCxQsrVWC_DmQfwBxwv8pUw_9gXFJmO54Syybwwp6oQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Mar 2025 13:16:45 +0100
X-Gm-Features: AQ5f1JrjoBIOcQCdfDS1oedWGGs4A4_VJdVtL-H1sBbJyMYYX6uZJAPy0ibavxU
Message-ID: <CAADnVQ+XGfYX0EzLJMVYDa05zY3DS4Ahvpq0XkKuzifwTJdY9w@mail.gmail.com>
Subject: [PATCH bpf-next] mm: Fix the flipped condition in gfpflags_allow_spinning()
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From 69b3d1631645c82d9d88f17fb01184d24034df2b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 10 Mar 2025 11:57:52 +0100
Subject: [PATCH] mm: Fix the flipped condition in gfpflags_allow_spinning()

The function gfpflags_allow_spinning() has a bug that makes it return
the opposite result than intended. This could contribute to deadlocks as
usage profilerates, for now it was noticed as a performance regression
due to try_charge_memcg() not refilling memcg stock when it could. Fix
the flipped condition.

Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for
opportunistic page allocation")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ceb226c2e25c..c9fa6309c903 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,7 +55,7 @@ static inline bool gfpflags_allow_spinning(const
gfp_t gfp_flags)
         * regular page allocator doesn't fully support this
         * allocation mode.
         */
-       return !(gfp_flags & __GFP_RECLAIM);
+       return !!(gfp_flags & __GFP_RECLAIM);
 }

 #ifdef CONFIG_HIGHMEM
--
2.48.1

