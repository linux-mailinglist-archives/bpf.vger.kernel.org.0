Return-Path: <bpf+bounces-54082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDCA62246
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0DC19C734C
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275A1F462F;
	Fri, 14 Mar 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8ZSGsGf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1647083D;
	Fri, 14 Mar 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996231; cv=none; b=Pms5yas+2eo8dgWKOIXUbtOcZJAnNzimh80FKvJqkuG4RB/VwxqzNv7vTnm3LFGeV4Q9vBJ8G5FPXld2JtyzhG5+49xl1bJqXsVKPm9xOd8WuzVvgAMqIGlPRBN7nK2bq1B/CrxEQZCmBvJ0zUZV0ODJFx0nsPhBC7gazvtPn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996231; c=relaxed/simple;
	bh=FhaLeXI33H4wC5eS68es3oEBN2a+09QOjpgGG+TYMwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYwRGPw+Py/EhLO2qL+S7c3UUho/LHcgzFZGYka00OpqHuCUNwMJlc2FY+9N5Kv6yfLCl519/LdxXKfjFdBZlqornDVisby0JsCB853iYQ7U9XJWKxbmTbNs2mFwoOzX6NCvuBIMksVUhgV45JCL5c0YABdSAktjanWAgNEaTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8ZSGsGf; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so356434966b.0;
        Fri, 14 Mar 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741996228; x=1742601028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhaLeXI33H4wC5eS68es3oEBN2a+09QOjpgGG+TYMwk=;
        b=e8ZSGsGfz1z/sjEOhaltzzNYe7H+t1MtcZV+143F/t3uYWmEqmsqVrsywUVcF/xeX/
         IDncvcV1bggSz7/ShnXuR8oWcROf+VIiDye4lHhqwpmjNNQXDShzNLIQxjyY7rmhsmaR
         qiB4uUGNWzDLiphPpUTJFU+Pouipd76BSbHUhUuSgOqzTQe679zeIU8TPANBo6khdVHx
         sGSQMT81TWJr8JQY+58aP/xHqPObIcqfhzhbrT7VNGV2gryYAzOFHivHRZEI0+M4Oo3U
         nu3NC4W7R3a2I7SVjSD1Xu/QnEMlJBdrotQfr1/oTqxKmJtTzxT8Io7oKYns/L3IUObm
         iUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741996228; x=1742601028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhaLeXI33H4wC5eS68es3oEBN2a+09QOjpgGG+TYMwk=;
        b=d40vdrckQzK/ZSOw+ACPrFLcCH2k8KuIOcvbF0gU++HMqxJ8dg6OEM4HtQbifvtuse
         Hw2vAD0tISqIReXyxg7wvTOxhraJfrKQ/kv7fifgAwztQqpdZ+rkWkx3fnMMfVhF7KWb
         U10Zq//op4qj0+vR97e75M6HlJSRusW/gTkNNS9d8+XBfzP5S1Bj9VJRNpOBdE+/Y5qJ
         bT6IR2RHj0kqVkA/di99fTdmsOEdQ1GTOHIhW7jDYzk9ujwCC0+ffkafctFeRlLgH6FY
         4R2b027gfYAg76s3vIkedHYNDqOtkusE3nbrvQxqJvcKRZFZOKKjGqrXAOEXSKkbbxyr
         a5fA==
X-Forwarded-Encrypted: i=1; AJvYcCVnDlf/3ZTewg+egkYpdO4+s11jw4BCqrj1eR+Cxs95gCDxhn+ynZz91B189CjJeqcjT+2H8+qSKW9SvLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2WkoyMaS9C8hNsj7Kq7CfNBsrKWVDSaJEqV01BVv9xYx0zkW
	gWZ6CCGhMh1zSberVrPcdfCDStNsG7qvujkY3oupWLl6e6ZIXIarbk/CT3wqXk40+zwCmpu7f0S
	HkE3eSpuUF26pD3Q4l0dnRR91cAyLWg24mC0=
X-Gm-Gg: ASbGnctvAtCnPb0MZp8gENe7IoxHfB1m64liYTqwZSwrUVD2YXJN0BaW+8iHRFDQd29
	pxrn5Y8oMo80mv/mMrMVa0gn0i82iPcB+zJpUSZzaGMPKG7hlE/D6pGtYPHrF+pNdGLbcHCKDAh
	k3yZsfte+mUypmPUj6QCv2yhasC2zLf3Qgz20IwpQ6kq0Ih3X5b5dChPqLDw==
X-Google-Smtp-Source: AGHT+IFseiObElwtIvtwwHdh6W2D/y7AiXA+tiz3sPg/0iJkCw16MaB9jRCfbh+AF0S93nY9BT48BWskRpDCmzUJ804=
X-Received: by 2002:a17:907:3f9a:b0:abf:68b5:f798 with SMTP id
 a640c23a62f3a-ac3301e1c42mr425515866b.9.1741996227456; Fri, 14 Mar 2025
 16:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303152305.3195648-1-memxor@gmail.com>
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 15 Mar 2025 00:49:51 +0100
X-Gm-Features: AQ5f1Jqb8X_ecTpFBQJRSB2pLw8-43_Uphf1mm0uCmpV5lZuYqh9UnxBIZQL3Zc
Message-ID: <CAP01T75iEw0mU6LeigHMp06DGsgZHp7UWY422xZtX1U7tVHa0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/25] Resilient Queued Spin Lock
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel@lists.infradead.org, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 16:23, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
>

Hello,

In v4, we will fix a couple of issues noticed in patchwork, where the
locktorture patch breaks bisection and needs to be ordered after the
Makefile change (patch 17 and 18 need to be swapped), but the biggest
change is that we will move rqspinlock implementation under
kernel/bpf/ to make it clear that it should be used by the BPF
subsystem only.

Thanks

>
> Introduction
> ------------
>
> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> res_spin_lock() and res_spin_unlock() APIs).
>
> [...]

