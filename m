Return-Path: <bpf+bounces-23097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39986D702
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624F01F241EA
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0444376;
	Thu, 29 Feb 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXXMyoj/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE8316FF47
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246978; cv=none; b=bNphQ13dYPR4Ra3gjkc3MyaGPOL3j9HvNnG+WLGE5gxaDFpFfUOMkTd4BXKkKaDU+TOPnM4EDGAdoQ/ZYlRvPrvtSv+4apbEh3Q8J/nLWJkCH6uWhEV86ce2omCANzAfgwl6Vb8tN/peR7N2qS2WKBTXpqulRxZ6dPRyUtZbdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246978; c=relaxed/simple;
	bh=mPTYyW1WrXI0Rfnwgpiw/MLeEFV/skFR9j5Npf7iXGw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=orqpzAMNDRFjx8RdOjAhiWqzgqnuSdYe/trh6itwsRjPK934LtScsKcWSxRN8sJt87pI86PU+e6brawg+UuNMxRrKSmPIbBl1tIxlgm99Bl2nEUZoEtZgHJHDaNwR1d4JblkZRubRKyIA6cxge4FpBehcBmyYaxEgevLWPFCpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXXMyoj/; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1a9b567edso619714b6e.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709246976; x=1709851776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CH7/Jfg2DLAa/6f09ZiTdW7e89T7hvWgQVRXCE9eG8=;
        b=nXXMyoj/zSJQ6F5RYqEPS94so1CqhvKeT0sUgj+HSSqTD9xCfcf0s5jPI+bbzNdQ5g
         p4KKfarttlDe/MYl1h04/wC4is7Ie6mymgZjCYbI5DKl1GLZubZTU1dw7EbwawDy1XpJ
         W4kgdWiPJrFx36vUJsCmMLGnfwNGLRmSNQ/zorDehkas5hzF/YZWacgBLXfOteZviwrr
         UqQLITJemw27YO9thERFfpUbChj/AxGvlm+vOwUJKToy5aGbE5M5/hW2P6c/nVI8zHeO
         jGk8Ega0bPyR9LArgjMPaU7hjQvYO5qMCp7a/1pZ3B1VY8ZE39GFfBgqxlWHATF+Sa+a
         JVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246976; x=1709851776;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CH7/Jfg2DLAa/6f09ZiTdW7e89T7hvWgQVRXCE9eG8=;
        b=GE2BPrQmgEhv3EoGZ+Z9sExIZWVZVj1pDdL+hW05bRS5hByYNj76UzFQ6JZ/LQLDiZ
         ifsn3FEuP0ViCwNRdSbkQboKcIqeoc9D1fp3QKeTA1KhHYPNxUT5n+snZHhNfLDUR2qt
         q0Wf1srnFM+1tvwqkywUOXq/2+oc1H0NNnoAVaM3gDc52pUIvwFlUzC21BbdN0ftMikJ
         crIpCCxs0yeO0TsPReVmUOc1I/4kx7SH6s2m/4hgFR7x/GyhoM1B9Sy56CCJ8wxhugNj
         PZdigCHls6Twcl56oZPc/YZlkcC4f7r1tLKFM6RVNyPuWsTLlYN+gp4Z1jr2W0rxwj8A
         mdgQ==
X-Gm-Message-State: AOJu0YwZh2el+xH09f4wzhVMLySUudHhIgAT1Ikj7Aj0Iy5hPYNhujUN
	EY2F68iYZBjpQ/6eQF/V8YAmOESf2SYCJaZxFQ8gTXVRXoM6kqQb
X-Google-Smtp-Source: AGHT+IHO82z6rONC7Jv4un3e6Voj9tJVb+NOpNPfOt7LnCob5fZRPHUTC+w5jOxYTXv8JGjdCq19fQ==
X-Received: by 2002:a05:6808:181d:b0:3c0:2b65:dd2 with SMTP id bh29-20020a056808181d00b003c02b650dd2mr19274oib.8.1709246975990;
        Thu, 29 Feb 2024 14:49:35 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id y133-20020a62ce8b000000b006e45a0101basm1892897pfg.99.2024.02.29.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:49:35 -0800 (PST)
Date: Thu, 29 Feb 2024 14:49:18 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
 lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, 
 Paul Chaignon <paul@isovalent.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>
Message-ID: <65e109eec79ef_43ad82086c@john.notmuch>
In-Reply-To: <ZeA9Jqug3NqPwjtQ@u94a>
References: <ZeA9Jqug3NqPwjtQ@u94a>
Subject: RE: [LSF/MM/BPF TOPIC] Value Tracking in Verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shung-Hsi Yu wrote:
> Hello,
> 
> I'd like propose a discussion about BPF verifier itself. To avoid being too
> vague, this proposition limits to value tracking (i.e. var_off and
> *{min,max}_value in bpf_reg_state); taking a very brief look at the
> challenges of current implementation, and maybe alternative implementation
> like PREVAIL[1]. Before heading on to the actual discussion:
> - Unify signed and unsigned min/max tracking[2]
> - Refactor value tracking routines (as set-operations)
> - Tracking relation between values

Sounds interesting to me. Just creating a summarized list of the examples
that have forced the signed/unsigned separation would be valuable and the
reasons why we have both var_off and min,max would be a nice document.
The examples would show why the bit tracking and min/max has resisted
easily being unified.

> 
> Admittedly the current topic is a rather narrowly scoped. The discussion
> could be further expanded to be about the verifier in general as needed,
> some (less concrete) ideas to discuss:
> - Further reducing loop/branch states
> - Lazier precision tracking
> - Simplification/refactoring of codebase
> - Documentation improvement
> 
> 
> Thanks,
> Shung-Hsi Yu
> 
> 1: https://vbpf.github.io/
> 2: https://lore.kernel.org/bpf/20231108054611.19531-1-shung-hsi.yu@suse.com/
> 



