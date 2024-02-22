Return-Path: <bpf+bounces-22507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A585FD87
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5672878B4
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0391509BF;
	Thu, 22 Feb 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/ISuEyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADE150986;
	Thu, 22 Feb 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617865; cv=none; b=KyBxulLpAXt5Mqx9WQN1vl7j8YJyapLWm36ZDCTiPAIc9ERFaQ5H29bAyzZIjoyww4hVVl8h81rKokLIyR84OL4YG7PKiqSjiIx0f8kkLtqCHidXWQO/PWVDGfE2jFGkks8Hr6tpeLIRUFli21JQbMytqDw4chKobXhUbRRfgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617865; c=relaxed/simple;
	bh=JVBLLr+iZprmUmwCC+R0KK2nXOwL2BBt8Mfr8ABnv2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtHqGdHAe9/+qFFCrCWXhpxsXyZmLOrhdWmQy2/GLje44Jo59yVHMtxxndnxJm0e21v2+T96T4IY2TRCi/XSow5hvzJClX5hr+W2Bz0Exyap/G32/84CxfmxqpnIioUZQbqtyF3jQvhzk5VQU+KFPSBMwNb+uXN5iwtjs4Fghgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/ISuEyS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41279203064so11996485e9.1;
        Thu, 22 Feb 2024 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617861; x=1709222661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVBLLr+iZprmUmwCC+R0KK2nXOwL2BBt8Mfr8ABnv2g=;
        b=c/ISuEySjzZoXx3vE4Fdtk4MEdz4pgt9Q49BMWQTITPe23PuMDhoYEeDqbhmijM3+L
         xkgv5waOYJQ1Ms5cx/y4YkxlxIwBwjJIg1Sd2j8oTtKyLQT4pjw3hU8kmL03RTQNbnST
         1VUvOgyWGDWdaF/PgTkgbNVKWmkhy/yufZCqQsObhw3e5OPMuKRmg/TGeTpLGebNC8td
         1vOxf8+2RNyj2TnxVe/h0xiRang1ev4I+h+BlfEsmZPfB9tZ0aSG8OwuJNBJPf/x8keh
         eMkZwlNiJaUXgwQFmFQ9sauFdLWrG9QwrRDdaFMB3wpfl+Si2N4/nBi3N8sU31k+h4mU
         Tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617861; x=1709222661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVBLLr+iZprmUmwCC+R0KK2nXOwL2BBt8Mfr8ABnv2g=;
        b=CcEQoG6s5i+k55EVRT97RfxQyXdKdkTOGWq5l+C1/zapyspwiPgL5cYXsTTMPUkWnW
         nRGROMJiYv3B9Dszd4vC3aMxWL3OC+tqL1DhO+xtrnKIJvHMd+7LDeSAXzXMCEuFU/Lj
         yZLxqAgXJz73kHfmtsLGHZvRQegcfpA2eU52zecqX0Xmxy8dpWNIPxQKiQUNkNcd1vgp
         KbD/kZEz/wYHjdXbaPSe6LSoDqFsk3UhyIqvA5lGLbdZu8m/mKVJVUvdqeSA34y00PRx
         8fAtm8oEmgtHY9EFOUsLWnhBYaUIxyn82Kg2bMz/rBelmzjjf43h4GZkAIHIkwQeC4zU
         dAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7/NRctY4VmS+6N9uomRDczrdABAB0deQ3Smo87/JR4A95jtYrZtkyR354DMOyFLK8RLGIauTL5VJtbf1yQAw8bCUmxSe43Zc8QibRDPBDLmST6CckRvc87WX1nZlnKXrxsT2/I8yub2Pe0p+07dL0U2f3T1kcJliB
X-Gm-Message-State: AOJu0YyngMiM81Ca06m0IUPsLybWsiIoSXOUbI0tZd6hG15w2yULLIv9
	qKJMCQe0ODrQOE5dMu/lcvki7hQUBxkrN0jnffgC5Jzek7UBE7SIm8Hqh/C2FgL0h4cNY+s4K0W
	cFVuOUeWdyKHWfeChd0Qs9cUHC1c=
X-Google-Smtp-Source: AGHT+IGB2NfIFYABbvqpx+xGpqV1zazBTchiC+Rsgsxx7Uav42ncBZx3rYUdxZGSjR+FGf5b0qDXtAOwJep8kJ5sQgk=
X-Received: by 2002:a5d:64e5:0:b0:33d:5e4d:51c0 with SMTP id
 g5-20020a5d64e5000000b0033d5e4d51c0mr8963375wri.25.1708617861318; Thu, 22 Feb
 2024 08:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87r0jwquhv.ffs@tglx> <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
In-Reply-To: <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 08:04:09 -0800
Message-ID: <CAADnVQ+9vTBj9GgxotLF0_oV7cNFRebmcq_DNUm+cRJHQXCz1Q@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in copy_from_kernel_nofault
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:30=E2=80=AFAM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Hi Thomas et.al,
>
> I've been testing some syzkaller reports and found 2 other bugs that are
> fixed by this patch (see other report at [0]).
>
> So, is there anything we could do in order to get it properly submitted
> / merged? Lemme know if I can help in anything, I could submit it myself
> if you prefer, keeping you as author and adding the tested tags.
> BTW, feel free to add:
>
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

The fix is bpf and net trees and probably will be sent to Linus today
as part of net PR.

