Return-Path: <bpf+bounces-28300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28128B81D3
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430641F2468F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27C1A38DF;
	Tue, 30 Apr 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq1m/I6u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35412C819
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511819; cv=none; b=VpxugZh4uZWw8iY8v3R4QAlJZuHECfGtnb+AtOzHXYqLBZiDkamo7c/kFBL2WlaYcdmWKxXmcM8N5YKBVf+VPIifMxIq8SxifRHdsSb83iLmwtA8i/OhNXL1pBimxFX44xR4nMt6CXlrnFDqwZ2MWyrcHIh6xm1fTBLE0IMZKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511819; c=relaxed/simple;
	bh=9Mwv1ful8+4xT+Y5jGCN+FVviNYq6kBfVRPNYxC7Wmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csxCSnnwtTntFKN68IoYEtDvwvoGfqSCjsqfUa3XlmbpesX+VON2zf+eHsfR8Dds/PlJK5Fe8NWcLURRTGPZyOu8nnEKrEdUtI1/ubzAGxInHZfKdieC4Zxbbc1ODso8O1c1MPCu6St1wvCmBM1vICpiLdR5v5EQOzE6H8rOPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq1m/I6u; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-57225322312so8220137a12.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714511816; x=1715116616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mwv1ful8+4xT+Y5jGCN+FVviNYq6kBfVRPNYxC7Wmw=;
        b=Tq1m/I6u/8Wd4uwcmZ2kw/K1bAO18iLh7rYomeqI4G2cWEOf/N138JACla6Kkzye3i
         uQWJL41bqCwJOE9dUqMNeUL7AtNCF/QUNttBk4WJSWD078PDVu1ucYTmaf371YFUMonk
         waeFr+ubnfpTs0h2kv3/9b+sy/0dgzDwLI0wGRITAwcqbAL7+fzhts8yTmvYeRCnVHKm
         MLdJxJgB4kbaM7VfTDOGn7y+3Yfh53EN1yO8OcihMsbV80S0TEMk7vtRZSFwsuZfXre7
         np8a2Y9WzLJlwa9LhSpCO0XLfpilECg6UbeVSTh2AK3AgOHoFj+qTqy0+Wtr1jrvx/Xq
         2SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714511816; x=1715116616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Mwv1ful8+4xT+Y5jGCN+FVviNYq6kBfVRPNYxC7Wmw=;
        b=UaXnpJBN/Zy29MSn6n/nhxL2haOZPLT53ZpK1bgKsFt25OBfiOPj50CqrUc8Cf5t3F
         mGWPhqN2kcNXsmgU/UAj8tL47HTabbzvMNRcbYprxqtpa9OXVLqXub2LWNVFF4BuTRKN
         ABqNW61d5LTGzxHr+XseD06HpyzHJTO0k3fxxpXeGFnL41vLrQ44ZxkXemkjEETfDch/
         hEl1iBCHiE9pTam/velMOnSlkSuL5ZN1yTkJTT38SEOo3GGcsouQcI2cvnpMeOx+b4Gq
         imoDB0LMyV2+KLaCKNH0yGD7K1T9rdE9u16KScwdWT058pul7YeZYlu7HT7TA3C/srxh
         Kqzw==
X-Gm-Message-State: AOJu0YxyGOZh1iRu49EZJyEjQzwk32gALGvf+jxPqkX5ViHW/Y9cbxe1
	qrDYsk8jI5XCXBuOVl2rVYtJPEfiTB381Ub1/nWYyhkfvnzAFdNorGAmI3MxwOHmunRFqkYk+AE
	pZJNHSSnlzUHzrCGWfU5xJFs3zr3LVRsn
X-Google-Smtp-Source: AGHT+IHeNFWeoniYzxVmGpKyl9Il+8hslKmHWLS2mZTT2SVWgJXc0J/6WMlDAcMMkuiZLQhsvjDR+WE2egiDpuddIkY=
X-Received: by 2002:a50:8e55:0:b0:572:a731:dd14 with SMTP id
 21-20020a508e55000000b00572a731dd14mr308792edx.28.1714511815996; Tue, 30 Apr
 2024 14:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430201952.888293-1-andrii@kernel.org>
In-Reply-To: <20240430201952.888293-1-andrii@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 23:16:19 +0200
Message-ID: <CAP01T75gN8US6BZXa5K6wOsEJdOqc0N=mUUNBeXDYrgFzKUM-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix potential overflow in ring__consume_n()
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 22:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> ringbuf_process_ring() return int64_t, while ring__consume_n() assigns
> it to int. It's highly unlikely, but possible for ringbuf_process_ring()
> to return value larger than INT_MAX, so use int64_t. ring__consume_n()
> does check INT_MAX before returning int result to the user.
>
> Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

