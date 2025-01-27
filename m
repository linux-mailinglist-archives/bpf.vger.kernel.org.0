Return-Path: <bpf+bounces-49863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28CA1D9DB
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9238E3A7CAF
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189236F30F;
	Mon, 27 Jan 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7tioE1h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196417555
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992749; cv=none; b=mnDBM3q04tsD1BIGCjCn54UzjwOzhh5eZfKCOCPKko+0km2lYSk8QNsszNSCg0wsM2IVQgXFs/NLpDUecEtR/xRM6iJl1RjYhsBaSJNFYW/Makc0RQdzDqZ8pNP4bmEdxT86LFrOJGG4t/yT1Xa3yWnWNV8WnVLMiNjrpmS/XPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992749; c=relaxed/simple;
	bh=o3TT/FPtnmJzo1TBgflq2y2N4m0ES5b94uW0QQfGMKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsZNTwRNyfr4/yxcWmp34V8u1v1jCTEsNtKdT/K0wcLFBrBXiesXBOpngwvD0ytnq4pWpJTW7mCwZbahRDzHO9o7/bqjMQwaGaB1AtnOBCFG4DqpR/S7sXplyWTcKRgk0KNLQE6blDVriP3/OZslvPbIgti+JpBF2sF5OnseElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7tioE1h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21670dce0a7so96504865ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737992747; x=1738597547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+DAmN6SmOy7g0IJ7QX7FL09bN8S37oiHxGD1id9D9o=;
        b=Y7tioE1h+EgemkSJu4nh49H1w138pTfJvO2JnI9um66W5rVFwCYxpMfKK9t68Yte92
         EYjfW7PffkqoVbtrXpehAcYayRhyXZb52ZtFUprp86Y4vIT0s7N8Dl2JJJE5/NrCaRzT
         PEcZn1c//wAUjcdLgXvHSdMDt1VG41MZpY+nmd4KGSVsvMBAeKvCeX2wR/Vj/mo1ikh9
         6c2wTTcVoAQQ62iCICAy4j+e8hmQwenujq2SEyhiQ6fUs8uwPNNaGFyWSqSu6NISp+A5
         w/bIeeLbbX7HkUQplgN48TbWBLfjuU1m9EdUvsQ3N5Tobw/eDwagXFT0B2okLhbaosDZ
         m1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992747; x=1738597547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+DAmN6SmOy7g0IJ7QX7FL09bN8S37oiHxGD1id9D9o=;
        b=pw2HZ2mVBCVpVp1HgqfoT5/W+pO+mf9C40EfCAB257B9+Zc82gkS3hW2tLmdMKvG/v
         wRafQQQnIMoFbOhltcZ//QKVxg3Y+B2kfcA65+clP+Ekp4/DWo1c5RKhNp9cnPt83EQQ
         4xiNtjbfB3l/L+Qaqq2NmqeaKKCSUbfKOhp1MXKmK+hsu2Xiu+CT6RyaBCUELctXbA5i
         Nc95/j7Ugl0ptLlTi4YVGiZKJv/65s51Wy8GZ5dDg2bDHul0ZlnVQfKLEyiXCjJ3K6gL
         H7z5lQEqyi+3auT0iYKOiG8tE+ygMdNQKzJ4pBU9TRcRNGisdSF7LdQpn2RxutwcN5Qt
         XBSQ==
X-Gm-Message-State: AOJu0YxwSwpj486g4A/eUBYQgfixF/9JrgFDG0Jm9ygEa3K6ihBOB6+F
	fZPjre6nF2TmOXwKgtgMHhvCEsZcR+N7Bu/0j0AzuOtltGnPCWMZktqt
X-Gm-Gg: ASbGncsAAxkrYLNk1DLw+N0ozUXKGVVpTbf/yaq6Vy2cD2H5HCW4IXPb/hFziX0Qnro
	7Yoa8qP3NCPYzXW1gvNNrG9k+SNPmDoD6vT7pBMQH2KafisXxkv94c0deHjyuax4XezfZfgIpIo
	eAxv2ihDKvKx9iPjCoSbl95IZ2PLumyV2hsmLYfAeceQ+m2h72O53mfFGqqN3M8z+k2NmD9Dpr6
	Vd7AL6+mJ2SfTITqSbsWXF5VeQ5rOHEhuIILFhbcEp/YsJz9p8c6P21yG62YG9mgHcdHmakIvDG
	8yON
X-Google-Smtp-Source: AGHT+IGqbT6xjbeeZjXs+XDDBBUlzDXrcOZPY/PfAjXYU/43TAq0NNfESzgj0Ys2m38FnoFjCmNcdw==
X-Received: by 2002:a17:902:f682:b0:20c:6399:d637 with SMTP id d9443c01a7336-21c355c427cmr634562815ad.40.1737992747207;
        Mon, 27 Jan 2025 07:45:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48ea371dasm6557612a12.12.2025.01.27.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:45:46 -0800 (PST)
Date: Mon, 27 Jan 2025 07:45:46 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] bpf: avoid holding freeze_mutex during mmap
 operation
Message-ID: <Z5eqKrvkAH4CIWje@mini-arch>
References: <20250124195600.3220170-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124195600.3220170-1-andrii@kernel.org>

On 01/24, Andrii Nakryiko wrote:
> We use map->freeze_mutex to prevent races between map_freeze() and
> memory mapping BPF map contents with writable permissions. The way we
> naively do this means we'll hold freeze_mutex for entire duration of all
> the mm and VMA manipulations, which is completely unnecessary. This can
> potentially also lead to deadlocks, as reported by syzbot in [0].
> 
> So, instead, hold freeze_mutex only during writeability checks, bump
> (proactively) "write active" count for the map, unlock the mutex and
> proceed with mmap logic. And only if something went wrong during mmap
> logic, then undo that "write active" counter increment.
> 
> Note, instead of checking VM_MAYWRITE we check VM_WRITE before and after
> mmaping, because we also have a logic that unsets VM_MAYWRITE
> forcefully, if VM_WRITE is not set. So VM_MAYWRITE could be set early on
> for read-only mmaping, but it won't be afterwards. VM_WRITE is
> a consistent way to detect writable mmaping in our implementation.
> 
>   [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@google.com/
> 
> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

