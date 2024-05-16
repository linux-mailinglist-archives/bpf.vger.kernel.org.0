Return-Path: <bpf+bounces-29870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3968C7BB4
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1121C2197E
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE3156C69;
	Thu, 16 May 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR67lSmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5B145A06;
	Thu, 16 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882388; cv=none; b=aq1ud61yMcmoFiB0vatjS9QJE9EOLJeEqB8/fmDp5HoJye2vDnBw7Nd/SWhBONwHUD/0bVJY0o+b7lAippgM/J/O9ARGhaO/psW9mQOW5ej02nYM6bhPfhYLhqYyGF4Ocm7R5FIUC38buyA+q2g8+6zzithKTcGzF3BH2fi/0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882388; c=relaxed/simple;
	bh=UL+0E+dEyW4smbrMu6MGZKPVd1DNfF5RLCnQF+Jbby8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rSKPvEX/zUGA4vmbDhFFm80GaAuI4proV0zmQlUXMkeFZrVSIdHsriE12l3Ea9IG+GnoGEuZRpQNyAuheCwtRSsOqGkp7ERKF6KeOgJTDfs/gmJd6W85rh5o66WQzYHeX9c0WpdeEKJZ1HduvJ7UF9oq57VR1S/sCkkf9+nYJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR67lSmG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a3652a74f9so3484026d6.2;
        Thu, 16 May 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715882386; x=1716487186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2+WnzvsrG3q05AgFPxDjhS97HlYQRIW0WgMF8TeUeo=;
        b=FR67lSmG+viUYDkDT6xwHR5ayK1pQRZdqwHJSGA1mbsI4DXrTSYKOD7mo7I8zY8Yxj
         CEEP8IPKSj9ZpVy3Os1nqjSeMJAy1B+FIGhYT2gmpDlUrqDCOfdSsTWQdh3xMMlj7NMw
         prFXeiU57uAjcN/osBgLfS32XXZ0ZG8kui/fcD5rsSYANXA64uH/x3rDYNYDeQsvG9de
         G8MMtpIr1uiST4ACbansycEzu4Xv0PLnRXl1bCRZ7tMEUeyXW98Sb6JR04bMAu+XYAoV
         /gy/Ph2VyMA5VMSdZmGhY/b2NbLl+0bmiOyZgDfO5mXvi3QnLJ2bJkA1z+GzdbKiZ0Z7
         pBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715882386; x=1716487186;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c2+WnzvsrG3q05AgFPxDjhS97HlYQRIW0WgMF8TeUeo=;
        b=MxImKjmUwSy6GKTZCvyCT+XSwVUyKJ7EBoEl644jQm6K8FN2dDp338jDdmE05jZCFq
         rRvXYfj85LbtWg9bDQRFL8DI9yAmjbQNU7V7gV/kqbyVRVLB10K6gC8h87L4Nurou/O+
         N53j3w5NyM1jd3fBhGWvcXJiSwtEErQFLyq5NpkWXZ06lLTUKj7wOjHoYLMOsiSe3ekg
         d7yhN0lcQZMVswEyVauop1f0li4MfRKq7+urNvtSOh3NszHOaHAFwE+9lrT4Cf3GhW8T
         umP0XSSogT/cUHyjFI6sxkOWKwM8WKiOvIcllhgbc2y41tYqUlQB4JMCUi8hApipfZ29
         LeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkhtjcGgA2shL+FGFbrPX8lAbsRYK6do47tumH6KpqM9/QcWOffw7PpajU4QEUBUcs8oSFJdflvOagMyh1kzl7hXKtQvjg5NmTKYEaJziWYiDJMXzz5cdn4c/XVrKrVJY
X-Gm-Message-State: AOJu0YwnmEe9ZNOn4q2ozs93YLrYJcVSxADpRqOxiU80E4YJM+9GrNYZ
	F5wbOB8XNDs65fx/wsaSS6Sr59cFS1b4bNif70r8DaFKmH01cZz1n+pKCg==
X-Google-Smtp-Source: AGHT+IEWyZIM0yefQfIkE6t7siD2O8yJ1NSI73yOkYWbSn6ECBo0aIWC5Iwg350Su939bcRRENZVGQ==
X-Received: by 2002:a05:6214:5a08:b0:6a0:b594:177e with SMTP id 6a1803df08f44-6a16825a4b1mr207278616d6.57.1715882386314;
        Thu, 16 May 2024 10:59:46 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f187c47sm77551616d6.48.2024.05.16.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:59:45 -0700 (PDT)
Date: Thu, 16 May 2024 13:59:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: dracoding <dracodingfly@gmail.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 kafai@fb.com, 
 songliubraving@fb.com, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Fred Li <dracodingfly@gmail.com>
Message-ID: <66464991ac8ea_54e932947a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240515144313.61680-1-dracodingfly@gmail.com>
References: <20240515144313.61680-1-dracodingfly@gmail.com>
Subject: Re: [PATCH] net: Fix the gso BUG_ON that treat the skb which
 head_frag is true as non head_frag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

dracoding wrote:
> From: Fred Li <dracodingfly@gmail.com>
> 
> The crashed kernel version is 5.16.20, and I have not test this patch
> because I dont find a way to reproduce it, and the mailine may be
> has the same problem.

That is a pretty old kernel.

There has been work in this space in the meantime. Such as commit
3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size
mangled skb having linear-headed frag_list") or commit 9e4b7a99a03a
("net: gso: fix panic on frag_list with mixed head alloc types").

