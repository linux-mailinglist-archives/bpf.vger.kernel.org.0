Return-Path: <bpf+bounces-47522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6C69FA22A
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FB71645D3
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410731885B3;
	Sat, 21 Dec 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H5QUcRJH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235D63B9
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809052; cv=none; b=YgJz5LlSMEbk/GCiT0sn29a2OgyTYvbxbFT2rf0XHDcGPgvblujlh+6FXgNlKAjttQYMTQKBRasyoAMHD6lfxPjjkJB2gI5M7pBpPNwkAXEQLaT0+K3fR7rkXtVevzypDUacKNTWomriEwjgsllNvfHa1ANQ2bj7pKAgP+mAslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809052; c=relaxed/simple;
	bh=3b+zHvea9cKHj6T++qmfvZlWCPqBD6A42wajl14DSAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeFsl/3d7M3h28fe7kTlTlGn98nWyR2ZGkb89N/bRe/rHMepTzG7ToIAYawAsg138o12cKTd3gEw++HTQHjKneuJBtjXMe5Zi1ptkGv06Vapaqgmh3F3v4dNCT8wyOxVHUyKlaCdV4nRdYMUdRb3oFhcKmp5mOt3Z6nWZ+CTwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H5QUcRJH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab9e281bc0so552655966b.3
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734809049; x=1735413849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgRY31V4J3YXxNtclTUESjesGeOmptqFSuTQWyZWZNI=;
        b=H5QUcRJHPt6zVsn3lcG2ckOSdL3fkAd++7uzabqPJeCcagKU2palC24Ie1C7MI85QT
         1QFwGRO21TQMMcrPZ5gyYdizMYVCdXdOVwSToAyxUqxnJMNL35nXzbhLTSgotvWKHi6k
         SoTNjaeA+ygVnEGkl5wE+9RgEEjnwaxYGYcCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809049; x=1735413849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgRY31V4J3YXxNtclTUESjesGeOmptqFSuTQWyZWZNI=;
        b=ttRsethR46GB6V5D71HF33O4kzGkK1MJzZwmwAC/qn/zxmW+eqijbIFq+jTbeyHfo5
         +R1snkww94GGCkWaDxFXhtsP1J+LOHjBqYC9S60M43SIHUBsnn3iMlBgqbxR58f1qvqp
         H1nOJcUVIK3Om0KTYNe2FKClyPFrsjP9usIs6dYrYqgzxviapjF0l2VfEiNO1ORuDuff
         1+ubLNYnwaaeqQA82BiTnWPKl0P2cnpatTP40MCLMowdNykHnrSVfb87mOIIsAk8kzRb
         oVH42CtgjyD/seDbteLmIeH7ZkWuobiPc658je8Z0IO74VUEhyQ6d3lT5lO+ihYyGHy9
         IskQ==
X-Gm-Message-State: AOJu0Yyo7XVvLf0ybQGy391O8BV82BdBgYSBcbvrsqfpSwvyp69zPigJ
	H709cR3JmDa7m1Ard/Eg9ddUMsnU0J/iUAG+D18+VFks5FEKtLCoINhkvvY4nWydLLEWfgKeTj2
	JbAg=
X-Gm-Gg: ASbGncup5SQcGlUmx4SyvYeFdIPAel/JawrhbewlFMVp16uAy26ELCokr+5JpSXaTUI
	97oGzUuQsMTbuIsX1EMqC8enmvLLYmcWiYz52iWRJRIHefCmuzO9EhnNpPWVFSM/lj7FEHyIr2T
	J4sganiq06od0VFPM6ZFDOw41P07mvqPs7cqr7vNrKqKZNYLI/oA12C4a3fGI+9lFRHtFy0b4AW
	BAolIU6nu1VhTNR4cBW2FxFy7gS8sAeX49mC03rEvdpwteMfZW+Bu5o+LlcZ+jAjQxb8Zgcxf+s
	pDL/wnU1XPq8zUuluqkit8FUrlLlk6w=
X-Google-Smtp-Source: AGHT+IGLBVOb7UgdUXXZSu+Ti6uOqxSmQ7X3Y2V00u67Rah7rWey+fd4wDvM00VHKm2aTt8uZQbQjg==
X-Received: by 2002:a17:907:97cf:b0:aa6:7091:1e91 with SMTP id a640c23a62f3a-aac2702670bmr690779966b.11.1734809049029;
        Sat, 21 Dec 2024 11:24:09 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f065391sm309411966b.178.2024.12.21.11.24.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 11:24:08 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa69107179cso511554566b.0
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:24:08 -0800 (PST)
X-Received: by 2002:a17:907:9728:b0:aa6:82e8:e896 with SMTP id
 a640c23a62f3a-aac26958bc8mr590576866b.0.1734809047907; Sat, 21 Dec 2024
 11:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221002123.491623-1-daniel@iogearbox.net>
In-Reply-To: <20241221002123.491623-1-daniel@iogearbox.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Dec 2024 11:23:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmQSiZzQuUMLHf7jn5eS1=PEhpPdTNVq8LX0qBk31w0A@mail.gmail.com>
Message-ID: <CAHk-=whmQSiZzQuUMLHf7jn5eS1=PEhpPdTNVq8LX0qBk31w0A@mail.gmail.com>
Subject: Re: [GIT PULL] bpf for v6.13-rc4
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Dec 2024 at 16:21, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> - Fix inlining of bpf_get_smp_processor_id helper for !CONFIG_SMP
>   systems (Andrea Righi)

LOL.

However, it strikes me that this only handles the x86-64 case.

The other cases (arm64, RISC-V) may not have the pcpu_hot crash, but
they still generate silly code to load off the thread pointer. Does
that even exist (or get initialized) in UP?

End result: I think you should have done the UP case separately and
outside the CONFIG_X86_64.. And why do this only for the
"verifier_inlines_helper_call()" case rather than just do it
unconditionally?

Anyway, I obviously pulled this, but it does seem silly.

          Linus

