Return-Path: <bpf+bounces-18884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D593D8234C2
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A30A1F24D60
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85671C6BA;
	Wed,  3 Jan 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmYw6glz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6B1C6A3
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso8340735a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 10:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307449; x=1704912249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wstdd2R4x9w1rL9a2xbRoFibIoSOhba7zkYjwVTFZFE=;
        b=CmYw6glz7AURuNGco3iLVuVx23i1TB8LPO0zT5o+8xVkU7B/aygE0coEv3LOxv4KmH
         n14/ALCjQva5+LD6dfYKroiV2nD8zdcRQdFyK3u9R8vIUnHpwOrYzTRk1W3eSkZJ/4sS
         RJxyk8CZ8cgliYtW2uFmOufrFJOpME5pmmoq7lIW4I55pHUfKlSfD9aCnceh9XlUMtSn
         RYmdFrIArXkXuhHk9rW0upfUbQNBS2eNr5VUdVzbI1PJslLji3IK7SkScubCgbo2fJMi
         GM+ZFGjTmbGSv754cL/Mv+HAWb1TQlK7TmFNt3XOWMUNZ7wV67klCzLE8pZPTDRMk7t8
         lu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307449; x=1704912249;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wstdd2R4x9w1rL9a2xbRoFibIoSOhba7zkYjwVTFZFE=;
        b=T4bBkD5+bP1KmPqj+hEJJanboMIvTBIt+qKCENFeZ/SH9G5r6nvm5e1+23CjOt+3lY
         Jl15hOT3FdHwuyxXJ4C+EUidNQQzR/hE7A+lGuXoSxCM7S7MjfgxxXcPwweFStkwezff
         7Ayc3PdTzOqKUvIf0xA1haAO6GgR8P2XTWl+5FlaTbdgZvQjGFk6qYnZW4erMZS/N1UE
         OmvgCUoIlXQ0yK2EgGWfOkgtC47XcupHCXvRejoT3bgA/Mx/KXUopUTkNHXH7gYtKd5o
         RqsvYyJ4XehKQY0u2TtCde7+mDk5IhqQn9MHgj2p0XQ94Eb1++UlXYkWEipdKBxzQ1TX
         fbUw==
X-Gm-Message-State: AOJu0YxZZW16Tx3QpJmwUSBd4i/iVMEzie0dgq8DJnDxzLg0lcjuiSWQ
	yil9fHKbTGLc1TtclzK7pX4fmhEpQ6s=
X-Google-Smtp-Source: AGHT+IGHUFjVQ+Ig3quTN8+JVR3eZ46rcqzPjIHAHrOHTRAAqm91+7dZGCAkRQTyqX9qI1Q9MLZq8g==
X-Received: by 2002:a17:90b:1bcd:b0:28c:6210:7ef with SMTP id oa13-20020a17090b1bcd00b0028c621007efmr7760519pjb.97.1704307449505;
        Wed, 03 Jan 2024 10:44:09 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090a528c00b0028cd463b4a7sm2084672pjh.46.2024.01.03.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:44:08 -0800 (PST)
Date: Wed, 03 Jan 2024 10:44:07 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Message-ID: <6595aaf770d81_2561220882@john.notmuch>
In-Reply-To: <fbdd0cc8-4078-40a7-9654-7e3c0cfce738@linux.dev>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-4-iii@linux.ibm.com>
 <fbdd0cc8-4078-40a7-9654-7e3c0cfce738@linux.dev>
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Test gotol with large offsets
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
> > Test gotol with offsets that don't fit into a short (i.e., larger than
> > 32k or smaller than -32k).
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> It might be useful to explain why the test will fail
> with unpriv mode (4K insn limit) just in case that
> people are not aware of the reason.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

