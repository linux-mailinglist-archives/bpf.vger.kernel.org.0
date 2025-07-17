Return-Path: <bpf+bounces-63645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D7B09305
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917F9A450E6
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DF2FA63E;
	Thu, 17 Jul 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN8liwjn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BECE2FD59D;
	Thu, 17 Jul 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772848; cv=none; b=pA0XeKe5Mb7ujNgh3KuODUK92edNTPvGDyyRrug0NeTnnnto7oZx2FJibB16COqfxZJrzQfj9f6MMlXGHJbGFhm12jpKk5S6r9h+emimq0CT2MSkJ9a0hEcSrpAQJqohzbxtbUu789GjLrX93smZA/mqPuL+hlFU91v0y+AP7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772848; c=relaxed/simple;
	bh=QzW3TzJHY7MTLMOOnMpu8mKFRvV0aVq6toqLC/Mg3PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWa3NDJGiJrSDeSkLWbstEDOAToH0b4i82Pfk29+BXZhPo0K7e5jR3Z6ZWTDBkE2qER+joRiFmHE2ZQ+D84lkiLTY3Z1rb+S8fST4j9ubYP1tLLf4rxk3WfhCsnxXDDGA4te70Q1rvWa+ghWXpv9mY743Bl0/R6jCB06DA/jfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN8liwjn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso832503fac.2;
        Thu, 17 Jul 2025 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752772845; x=1753377645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzW3TzJHY7MTLMOOnMpu8mKFRvV0aVq6toqLC/Mg3PU=;
        b=KN8liwjnxwH/FrkPls/1jOAFu8tA3FLPuhyb4+bQbeYkAJM250hn/HMWYqIV6vfvQB
         b90VXRP/P/URz92W5sg7/U0SgCivmB6eRcCRhj2YlKM9IhmjArUT7xNqx2CBfyPZeesV
         G23N+pALhV4HfarxRMPrjSxtNBIBGbXkDuFMHAisoUCS2I9wNy9ei1CPIFtl1oBd/XCS
         Dalv0LyYDR6Y7E6zOKavLR9ERfyL94sbDGH3dAVAGgvzIB7INUdsZPxM0GQeJjGh5zzZ
         ePRiAnpJcdazDYgEJfJTQaeCWXIxv9sg/j9G3P0gVHrEGrU3zJGkzGH44SKF8yCIiqux
         lkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772845; x=1753377645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzW3TzJHY7MTLMOOnMpu8mKFRvV0aVq6toqLC/Mg3PU=;
        b=w7lxT6Fsyhjgs7K6AMojkqgT7NqlCATnZSlOFrGlB3FZCNc2HTbmmAYNdpa5HFp7JZ
         K8OfmPiSKq3P6N9Wi44INVRDepc0z+hBeHF7hMOgVbrRrz6BzbLk9+6iXVrunONo74Tu
         iwLVULyDzU7luEYmO46vrH5xiZve4PvMcy/giMjK/vvaBJA9JYXCvTIE5/O/NjuE4ryM
         kpLhhEhspOiZbbAExXpLY8ZgO29slKqX6eDM55Phd2iTEMavWDUZLrdtqyxhYgdz/FOZ
         WklIfjyoHYUcydL9T43XeuQl59I9mK4VhLh4sLLB/37/gdNxElbIcJADJ/lLNruP6J70
         /isQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMm0604MikcqmWRQPvWl9Oj7ASN+zyTZ8Lbt059vRS9nBNS5wEAKpcoqBfXRgpN1uuz7BYUnLFoHiVn/CU@vger.kernel.org, AJvYcCXBkuhdTi3zp9RKAOI5xxTUlzbc81vSoiNbqb9f2FW1uV32kdR4oWr6PUXmKaFJzyeIESw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQINg6cMx254MKUOkPj/FZOLT3A68ql5GHSAp4Hbu9f05OvNSl
	7yj6x3Ejxw3YskE/w5fWDa8jUbZzK0VqqVyJO66RNeVQqG96/Ugs/ZToAUwyc/aE4of7GRKE8KW
	FuOquzKknCjRtxVRs0SiYVImjn5ZvL/o=
X-Gm-Gg: ASbGncs0IGCcN9MwYCoteMV762ss5n0AoLopBIPsan7qCilsMiDtfbpHPKV5jGLRuAz
	4DP3eaUGWWQIs8H+/vqK7CXmLc+LcDiiJcbxJmCKyH//Al9mLItSWYJziBnwbNxUXxmSdiDsQZp
	DDQ/fGPXuATefqLQZc5DJYBfEtp0ISoXXvab6lWO7tPYL3leq2MBszBXdW3N8fncmuFUY9nAZWI
	5OpMVAC
X-Google-Smtp-Source: AGHT+IGkry+/VfENK4FfpgTo78UQOqjs2I1quI25rQ7ik3+6oBFDseF6tGEewUI75qPag3XTu41YslI06Xj3GfBcdds=
X-Received: by 2002:a05:687c:2c20:b0:2ff:cb23:97b4 with SMTP id
 586e51a60fabf-2ffcb2398d7mr3207511fac.18.1752772845406; Thu, 17 Jul 2025
 10:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
 <f6c4944d-c6c2-4a7e-8dd3-791d0c29022b@linux.dev> <CAO9wTFjEJOfF7krFuV=DkZFzRU3FpRXtnq93UaX8=_Y=wnwbHw@mail.gmail.com>
 <2025071756-motor-slackness-ef0d@gregkh>
In-Reply-To: <2025071756-motor-slackness-ef0d@gregkh>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Thu, 17 Jul 2025 22:50:34 +0530
X-Gm-Features: Ac12FXxLcp2VHp2DpkAP_e7qN_lhHYsL-fQPhMc5_0UqSpWKkgNzljuXToTD3Yw
Message-ID: <CAO9wTFioFna7r_qxfWNQasAYC6rodkqP+1GdYJKSQEFKg-xXtg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Your change also did not do any bounds checking at all, so how is this
> now safer?
>
> confused,
>
> greg k-h

I assumed bounds checking wasn't necessary here because obj is
allocated at the start of the function with enough space
(sizeof(struct bpf_object) + strlen(path) + 1). My main motivation for
the change was the deprecation of strcpy(). However, thinking about it
now, I'm not entirely sure memcpy is even needed in this context. I'd
really appreciate any feedback or clarification on the best approach
here.

