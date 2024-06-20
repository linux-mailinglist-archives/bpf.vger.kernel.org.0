Return-Path: <bpf+bounces-32558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39790FC25
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24291F25426
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDD2B9BE;
	Thu, 20 Jun 2024 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W5dWTMlP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15D628
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860708; cv=none; b=C0fvsDlAPJErLkNvvcKdNMaMS2gVBKeMpDC/WKYDpNkYd27gVaifB4NV0E40HNZQ6gBlikZWNK83JiQNcamFz3/QUUBZQM/g2Qb0k/cctObCOi12ZqZvYIpcXPCk8Z13EV6+OCbj4k237ctAEGPU3UYMMOrVoi468DzoAD7Jq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860708; c=relaxed/simple;
	bh=UT6nUltbUEWlmEUxQq37Ej/2x2yOcMpJeUnnC+sbyog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gDMb56YLcnHDOrp8tu5dQvUYxGGcMQupV7ViqYM5AFSnNXUTi6o3gloxNJ7STNtA4zpq8bStCMV9OwQB20R4d0zfcmgWa0RCucoyjLVBvzuqtaBoyRFzjGUl/S8qMOXwa58xEV7oYSLkif0hTeeQvTQfU3k8fPhgEnxeanU+mFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W5dWTMlP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso5622401fa.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718860704; x=1719465504; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UT6nUltbUEWlmEUxQq37Ej/2x2yOcMpJeUnnC+sbyog=;
        b=W5dWTMlPa2O9PoFUnrSiFiCrHoyNoArpSfqZW0dOF/ERs+dSxnz5G3qljZ4gJW1wMR
         4l82ceTsulPZFnA3E6RUkB+QkhcBMeSc690FlLxVLSHXKm6uoky9flYNzeOz00FYx+cT
         mw9md9v3cNx+no7cmdLZcyjhgLFJFar3nGGLpHNQRJxzqmAnq/k2lR5XWlpF3wEey1cs
         //0SCyCVGcQE53/K9DsIiaGc2LUM1z8jWh+zuRNV29gUIwDNXvlXdFXfUx3BXNTBviYT
         VZNIAXIcCpU6B99esCV46o/Evth//Zd/Drw+6s5/5n9mJ/LHlOcBPbhjkk1s1yZVNx2M
         OXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718860704; x=1719465504;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UT6nUltbUEWlmEUxQq37Ej/2x2yOcMpJeUnnC+sbyog=;
        b=MLA6f33Ri8KTM0VVPcwdk7F+xeAJL0vYn7z05b1Sc2sEPE2eKBjFgnH7J39P1je2fc
         n1dgoflfvGz69HLicVNW8Siij4NhxeAGNf6XiJw/NsRp+3FwUBpFx183ZUEraz0HMOLg
         ZY5IA/8jdJh3kfEYosElURfPNBfOs60lq8+/BSGVftwzSHtksCYq2Q/B62D5U4bJEsyc
         BQxXi699K+NepHONU6FQ+1CwPeiVV1CcoUzWFtlCv1BGtahY4TPJQ3MEh/ctYVF9MeP4
         PasSxx9Zr8G+sIorjA7Rq0RxGNgKnCzRbF5mDoCNj6bfI6hqH7bzvQdDEkrC37doIFsh
         stUA==
X-Forwarded-Encrypted: i=1; AJvYcCW7l1LtFc7IVISm8J/vkXJS8eRl5P72MSLoIuwpqotMrgN56mI+451NsTij3vecTXbuHvSaRoTC9u8tUp+8PlGk7HZc
X-Gm-Message-State: AOJu0Ywg8bDMSsPgHtqxRpRRaJ6yAuUnatWs45HfqteHxkmgR5Fbj01G
	TotqgGQ/esRJkC2ue9QdnVJ0ykw77cTca4n0UjedDK40IYZJvp5otdYkewL8Z1Y=
X-Google-Smtp-Source: AGHT+IGZwsVwRnknrE/Lj1KrxSQfRMR00W0/023af15VLbMOJ3j8pX02dMWQCK8avPxzGO9xQzotGA==
X-Received: by 2002:a2e:9210:0:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2ec3ced12bdmr31621471fa.26.1718860704178;
        Wed, 19 Jun 2024 22:18:24 -0700 (PDT)
Received: from u94a (27-53-186-216.adsl.fetnet.net. [27.53.186.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9a778b347sm1172634173.173.2024.06.19.22.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 22:18:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:18:10 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Viktor =?utf-8?B?TWFsw61r?= <vmalik@redhat.com>
Subject: Backporting callback handling fixes to stable 6.1
Message-ID: <7k3olfmgvvdjumu6c76nzyynqp5hq252f7u2hqtqo5wbz2ii3x@ksker37jvude>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eduard,

I'm seeking suggestions for backporting callback handling fixes to the
stable/linux-6.1.y (and similar branches), akin to what has been done
for 6.6[1].

Testing with the reproducer from Andrew Werner[2] it seems 6.1 has the
same problem where the bpf_probe_read_user() call is only verified with
the R1_w=fp-8 state, but not the R1_w=0xDEAD state because the latter
was incorrectly pruned. So I believe the callback fixes are need.

The main difference from 6.6 is that 6.1 does not have BPF open-coded
iterator, but AFAICT it does not mean "exact states comparison for
iterator convergence checks" patch-set[3] can be dropped. This is
because exact-state comparison from commit 2793a8b015f7 ("bpf: exact
states comparison for iterator convergence checks") and loop-identifying
algorithm in commit 2a0992829ea3 ("bpf: correct loop detection for
iterators convergence") are critical for the fix; but it should be fine
to ignore all changes to process_iter_*().

The "verify callbacks as if they are called unknown number of
times" patch-set[4] name already suggest that it is needed, so no doubts
there (again, dropping iterator-related changes).

Does the above sound right to you?


Thanks,
Shung-Hsi Yu

1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
2: https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/
3: https://lore.kernel.org/bpf/20231024000917.12153-1-eddyz87@gmail.com/
4: https://lore.kernel.org/all/20231121020701.26440-1-eddyz87@gmail.com/

