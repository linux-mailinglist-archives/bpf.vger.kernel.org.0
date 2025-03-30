Return-Path: <bpf+bounces-54901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74FFA75C34
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 22:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534DA168847
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71F1DE882;
	Sun, 30 Mar 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cUORZ5H9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE41B4F09
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368202; cv=none; b=UlnItgu3eOouLvO89seClWrPpb/6Kap8OJ9aEAm1J5STFfwmFAoFeR3NA2IrvVKZs1HZptR31o243hUihSVRFXQ3kAGgmUcyTXoiI1UpYGF+a/S0OCAF3pav4PEFWOV4kypFLKduplFckl8z/pdT0xLMP8fswYZPATMndDtvg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368202; c=relaxed/simple;
	bh=2NQf+mO6qVdzH6Wz1CSg+U7Kj2HvJtwz9HN9tyJTQYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYGcOGPFQyQADwBDwprrXuZtzyTMbtBQvv/NUAYDGDicq+EIZQn4/qiduNG9KZhGo/8P5X1oFQjdv+3hmcfkdOjI2MOVSguo9AJqvd3F1pAH5jBOzt7UchhQmm3BW30HRk+SM4pryNtVH9NbP7slxPat3hIgAtvZ2BRxmn9px4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cUORZ5H9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso746547466b.0
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743368199; x=1743972999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSOLpfQDj26hqGlCIT72Nb/pIYj7VgJoNsTI8j/3oiA=;
        b=cUORZ5H9RBqX8uWnPpoqT21vqDoJNsMpF1INlQrp87d2LdDb9FSUEp3GDprdeLb3aB
         tG9S2V9XSp+ay3OSt1IKPt7WUZH8Ar0XV5kmg131e2EZ7iPrXGLoYL80nDUs18s/kbVB
         ma03iE/uwDELEyrEn53JDLBhbMSxIKbw/KPW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743368199; x=1743972999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSOLpfQDj26hqGlCIT72Nb/pIYj7VgJoNsTI8j/3oiA=;
        b=D59IFKAtFi2aMwVfEE40hyW0XPECy33sduNfIjZxRsKh6IMCjVZdSW7QEzMjTAbZkZ
         cnDrKo/FmygI/0mZ/nPugLdl7U+fDp1CBmMM9mi4uLxOU5i1Ko1vIKaY9dbXE8ycUHyN
         mFcGOgOQ236LmGhz+6FCGDl16JWliddd/6SDpS6QQ8Zjo6Q37rTfNPZ6VCffASTx51Zy
         NBnIhIKiFSMg+U4ETP1pznWamOGJMG4iGcauRm0v8EQFW/SYWqGy3Z03HXE9HXs+kuKK
         F3wkK/mdIir0RaB41rOj1NRzpf/P2uMdZs1GH8UtwKXTsOYc3vTp0A/P+Rk5FyjZk4VL
         JVgg==
X-Gm-Message-State: AOJu0YzTOd0YbapNlutUywpUJdkFijpm30FgI+MMEIfuLIrm17/ccHQ5
	5PQ99y//cyAxWp2+e5hgTLvhxeUOPZvZkfgB4rcGvYYs2ermjxMXJskEj576eRxVM4AiNvA0KK6
	EMwg=
X-Gm-Gg: ASbGncsZCdFtyXqeSm+zFenNYWCm59a/ylfWg5mt/ie80BfrzTeHaMqQTl0NO04FnB3
	K1qxPe1w5OOuHnrRiT5XzEAQMET/SuwNF6BMwloVopVc0x5VBj5L4fGPBTuP95hyGxV1ZvEH4w6
	z9v2HJy7tZNhwPsd5X7hlfg3cThAEz9OsaECUIXcFqAuvhxM40i07bQuBOoXwmDBpDKln2VH6hk
	b7kLUNF7i/SJWwZ+CCtSe3o/5f4dUUf5FSKO3R4kvAEP/Sjh0QrPz15tc1x5K7khD9mIMeunB/Y
	hPB4JrtEPMlTjqFp+Yqq9Mf4e/aRlndh9Nh8mkFPnGEvkyZdtD0RePwamIa5/faZKxaUwWix1YO
	yCjmg0o0W6D6ioIAjN8T0D+LMshdQew==
X-Google-Smtp-Source: AGHT+IFFhP74RM1vCznX6MblsGVUEXTP/UC6uyFbXKENwCxppIk7Uqgir1Bvqv/doWKmrTFC7mKsRg==
X-Received: by 2002:a17:907:a03:b0:ac3:ed50:7ca7 with SMTP id a640c23a62f3a-ac738c1c93emr599940166b.36.1743368198656;
        Sun, 30 Mar 2025 13:56:38 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71971b700sm518322166b.181.2025.03.30.13.56.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 13:56:38 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso727765366b.1
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:56:35 -0700 (PDT)
X-Received: by 2002:a17:907:7e82:b0:ac3:8896:416f with SMTP id
 a640c23a62f3a-ac738a64ef5mr780959366b.15.1743368195497; Sun, 30 Mar 2025
 13:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com> <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
In-Reply-To: <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2025 13:56:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
X-Gm-Features: AQ5f1JpJ7geT4BoReQk_MXUrgZ8jgWTwt7ona-UlzJd5cAmwkXVKsuAn2yvli_0
Message-ID: <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, akpm@linux-foundation.org, peterz@infradead.org, 
	vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org, mhocko@suse.com, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 13:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The one reaction I had is that when you basically change

Oh, actually, two reactions now that I fixed up the merge build issue
which forced me to look at the function naming.

That 'localtry_lock_irqsave()' naming is horrendous.

The "try" part in it makes me think it's a trylock. But no, the
"localtry" just comes from the lock naming, and the trylock version is
localtry_trylock_irqsave.

That's horrible.

I missed that on the first read-though, and I'm not unpulling it
because the code generally makes sense.

But I do think that the lock name needs fixing.

"localtry_lock_t" is not a good name, and spreading that odd
"localtry" into the actual (non-try) locking functions makes the
naming actively insane.

If the *only* operation you could do on the lock was "trylock", then
"localtry" would be fine. Then the lock literally is a "only try"
thing. But as it is, the naming now ends up actively broken.

Honestly, the lock name should probably reflect the fact that it can
be used from any context (with a "trylock"), not about the trylock
part itself.

So maybe "nmisafe_local_lock_t" or something in that vein?

Please fix this up, There aren't *that* many users of
"localtry_xyzzy", let's get this fixed before there are more of them.

             Linus

