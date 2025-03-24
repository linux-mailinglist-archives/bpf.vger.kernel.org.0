Return-Path: <bpf+bounces-54596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5BA6D568
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B2516835F
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922825C6EC;
	Mon, 24 Mar 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxLCFSWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FCF257438
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802469; cv=none; b=Ilm8waKDrBs1gj9gugXQLmX2owvQmXuHOFTl1C0yW28YUYfwKberqfZZE9aDCp/9gGcG/QzZI1mIHmD/LcrkpkLlRaBdIew94M3aqC0ImhwpUfWnHvlAbp4F6lFepSvEoZq5xWYM4P1pw0ydazxh3afNDmnq5MjkaTVjAXIEZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802469; c=relaxed/simple;
	bh=xM1RjYHZg1ekNoAXaFX4dfA87jJ+mzAUjYXKSB4NO94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoTQ9iyuHAzWdiLnDxCKoaU7TGMUJUQxytsFigZShqLEjQWzmX1kCfw9k9vE9W4pk3P3Djk3ckoH1RKEj8eCvw1/mBpVSa6w7dvD363nqjN1Twp/evAKJ7lP1lFuW9cM3VqXSyMUYaqfh4Kj1Vr9U+T1uVgDgd726MFHa7q9MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxLCFSWl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47663aeff1bso40099411cf.0
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742802467; x=1743407267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKZ69y/TQcyXRUiF6XUhG0mlXyhTl3QHF+MMx6pYAh0=;
        b=UxLCFSWloleU7t7QhvmkTXVY+GK/SlaxbyVtmDoA141NJMy6MZ8feFQPX7t4aMCHXD
         rHETt7F3+CPBWt1+a9Rz6TUyV6nVSjZ1unGPidBAwOZKS0qCqGqmsyLzpFcfUzRFIBij
         6/CYoIics6TmYw5lPVVhfi9VfUFrjvTIopWtgjGbiun0yRBvneMhb/VTdJ6PkwUEyCUG
         hf4Z7fNIvrPXFcNxCpCzhHnPtKB2XHTCLfYAMuLHdNM+Kx7J9ma0GbZhbBQvy8thFM3w
         F3JUwS+wdcqxLWaicWRMckNpEEF8YdAjq1HkaLTNBl1bRMxreJiK68Lr6eMC4pE37sKV
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802467; x=1743407267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKZ69y/TQcyXRUiF6XUhG0mlXyhTl3QHF+MMx6pYAh0=;
        b=Iai7WQR7wjqzKkAbkLghu/oABn0oS05uOYxn33P1a5x+BCDXqKXxmrkA1FKfcy96AJ
         PmAD6iDsRT4jQttTm4dyyA2aliXdI53m4pxccNaOi8P5QbV+OBnT/AqwTI9SS/b3BEXH
         /NL2KzhEwodfkE936baQc7+57sczF9zEbRX3/vbPyyUBYk839DugI1i+KFRlwq8hIC/t
         +1dqwz+7/UFKTyMhD++qSamLGATeVqrazVUmDFNKcNpbYfhQHdaqE4emxvHWk+d5zV9W
         YArWE6XNOJpr77mY+E3K8sqJ5/maWG/YIB9R1gLpa6iFD93TgQRmA26Cj+WDgaPuT1Cd
         gHJg==
X-Forwarded-Encrypted: i=1; AJvYcCXqt3fFHMU/DLmeQ2frPGZq00gvlb6yLNVy6r1zs8yagfU6/CktBaXUzph6A/eIfGAP+5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXLwCsDaSTCjVE65ds9FqXBT1dpWeutfnW+sa1PzbhLhjBJaM
	qDqRGCfUCM7m6HqkmwH23bWLSxWOtpGxppMTCIg9ah/PBpsAg0Jo+lVGktSG+lC7FPJGXnmejpk
	vu+jLsiiDdp5I+W+yS23NRfBgXSExv1tPBR5S
X-Gm-Gg: ASbGncvFUq/e4HPpccMcxlfEEOkB/lmjs10/CxCMow/bljHatWpMknMm60JubDvJuYV
	bd2TiXwfS9HfdvqKowdmfmUkxE16m/Nq84wRaEUJYI5uIvmNB8I/3f4ufiQ9D9xDvoThN4q7/XJ
	ssAO4ZFrgMhvNypivCQAHVH+2zl0nh9JSi3fHJ9Q==
X-Google-Smtp-Source: AGHT+IGVn8dvxxgjkwNb8YI2q+jmg9rlDVF2xdS1848nZqsdIPKHlHUnwUJJPFBj1qHHZDapYBLUSgCczoRLBR4OMeI=
X-Received: by 2002:a05:622a:4d03:b0:476:7873:91ae with SMTP id
 d75a77b69052e-4771de1183fmr195931471cf.34.1742802466880; Mon, 24 Mar 2025
 00:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com> <Z-EGvjhkg6llyX24@gmail.com>
In-Reply-To: <Z-EGvjhkg6llyX24@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 08:47:35 +0100
X-Gm-Features: AQ5f1JoywH4uiLtRUtKnn-7sY9WO8V0TlYkoOg-PlWum09feuGxw0wsL46OuhRg
Message-ID: <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in poke_int3_handler()
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:16=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Eric Dumazet <edumazet@google.com> wrote:
>
> > > What's the adversarial workload here? Spamming bpf_stats_enabled on a=
ll
> > > CPUs in parallel? Or mixing it with some other text_poke_bp_batch()
> > > user if bpf_stats_enabled serializes access?
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > > Does anything undesirable happen in that case?
> >
> > The case of multiple threads trying to flip bpf_stats_enabled is
> > handled by bpf_stats_enabled_mutex.
>
> So my suggested workload wasn't adversarial enough due to
> bpf_stats_enabled_mutex: how about some other workload that doesn't
> serialize access to text_poke_bp_batch()?

Do you have a specific case in mind that I can test on these big platforms =
?

text_poke_bp_batch() calls themselves are serialized by text_mutex, it
is not clear what you are looking for.

Thanks.

