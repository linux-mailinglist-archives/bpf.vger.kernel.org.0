Return-Path: <bpf+bounces-43533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42F9B5F11
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E78B2222F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864A1E231C;
	Wed, 30 Oct 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klx3EVWY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFF1E22E8;
	Wed, 30 Oct 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281350; cv=none; b=DMLcBX4jIfjBY6+HoZ/6ra6pw/rbZF5X4kGaYanAbTls83qre+c0Wgj8olsWG0Rcr/i2U3VetZe0xAQijE1jA4brtkqrGkmsxhcAEMKUdJV8Wtw/CRcZqpMwWeRpaebRPxVixSGnrFi7UPt65dgJvhuUB/MjPU0umjHfCePZ+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281350; c=relaxed/simple;
	bh=162bqH31SougarnZJ1L8ILwyRO5oPWFkPAaa1swvXpQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm8a3fRVATbON6Yol5mGT6RAvaJrTm80R1EIWvBF26ys/dKZmCNDhcpYzdDg7JtwPuLhA5472AdDyrpksdLTeSZymFzzPK1Jon8/qRdfE+j0YQi4eso2Mid/JbqdpbCkPdpPJkRxwWaEgoc/e+FFsQlwHheeIfThnyEPzCAg6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klx3EVWY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so4183487f8f.1;
        Wed, 30 Oct 2024 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730281345; x=1730886145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWI6K/rf7yyzgkMjRv3kNpqClOPrOQ72cfml1iwnTbs=;
        b=klx3EVWYQ8RSnILLicUCsADn1IJsmp+NZHHJkH79/N3yr0K/PsYJ1p2qAkX5WdLxkO
         +fCAalzF0YDNHKw2PRZMRCSXje5/JLYjYWgiNWwY9ZUr3Ajl5ftoiCk5BEGEjb01MQvH
         3ty7mJF9VF78uBRtFz4qU83nslgGw2r2SCVQok6Tslq//s+H6qSjDAsu1kUwFX0xKvrR
         INHHMvV7yquGuX9DdBgGw/jnknwBvvfMxvLTELFvZv2z3rHe2ladUnJxUdoH3HMNMXxV
         j1MIut28iyBRTFG1lDi23vIhJRcSMScxayq4AykLIF2mErSJycWDiM3Il0TywIyXXS25
         qqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281345; x=1730886145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWI6K/rf7yyzgkMjRv3kNpqClOPrOQ72cfml1iwnTbs=;
        b=WVLbIkbS1fHXi4++6L/J+NoV4KNsYv+skHUFhl/lkZx2WtSzb4C4dbdnX+ZuDiWY2w
         9+mjAMzL2WX1rZnGRIN9I4GBwj9nwnOffw6QLgwMXPveBQocT5SBHuWu6+Zvm56puXQv
         LnaE7Jq1cJzrwdw5CfOh7y4YrqXSLqCdcrhRR1Wf3OUg7q2pXtTI8IEYlYQGtByjININ
         iNvjeQOq7eZiYC+iw4qEVp6zjyE/fPqHE7sHjbXjN7Zpoh17i70i8rgvBeJeXsV5qoCh
         dgZunZ2OM9d8wfg8h+/bBnulCtWqGlrjTegDHEXJGB+cx6t2MUuWFN7fsifUa3fEuNrV
         yAdA==
X-Forwarded-Encrypted: i=1; AJvYcCVkWp4Kai9+L2m/bP0qfKgAoQNwJ0iXHgeRQYN8NS8OiOgTqh36zyDUZnAFpHnHBAaME0/FEfaJOtjKLWHA@vger.kernel.org, AJvYcCWR8KQzaePvyZM+5Wi2QF9VEXEAK/bBdrknoRHpyHnGZvvomaHSeRKsCz+4C1baqVVlF8LVA9lAd15tAwvpdDFVhw==@vger.kernel.org, AJvYcCWnRicjNe47EVLEkOnA9CS4+WkB+3duo4u2qpLJ9W1zOSjhkvJPOUDmrErb3O53GnEoy7zFhljRNKcG74ukeQFnGwkc@vger.kernel.org, AJvYcCXlfEWqegeBkNXnSHraghNg+xSK5iDzkKIznzy1OfzzU34XaLdl9047tKYaNH3eU22OLoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtJJY/EpPZvMbGYUZrNNmlky+sQHG+nVFUZjLCbquDyF20RHV
	WglSkYQwJceIbzqLo9h+icOsNxVVNwXWNAQEVusJTh8mDBeevMkm
X-Google-Smtp-Source: AGHT+IGgxkYq0IK3fxqLi8TOsD2onQa9lxKRAUf/ZEnDRqoOPLnaHRe93zTXDeoP87QjxNur8CC1qw==
X-Received: by 2002:adf:e28a:0:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-380610f2a9emr11076817f8f.1.1730281344449;
        Wed, 30 Oct 2024 02:42:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4461sm14802711f8f.113.2024.10.30.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:42:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Oct 2024 10:42:21 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Peter Ziljstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: The state of uprobes work and logistics
Message-ID: <ZyH_fWNeL3XYNEH1@krava>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>

On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:

SNIP

>   - Jiri Olsa's uprobe "session" support ([5]). This is less
> performance focused, but important functionality by itself. But I'm
> calling this out here because the first two patches are pure uprobe
> internal changes, and I believe they should go into tip/perf/core to
> avoid conflicts with the rest of pending uprobe changes.
> 
> Peter, do you mind applying those two and creating a stable tag for
> bpf-next to pull? We'll apply the rest of Jiri's series to
> bpf-next/master.


Hi Ingo,
there's uprobe session support change that already landed in tip tree,
but we have bpf related changes that need to go in through bpf-next tree

could you please create the stable tag that we could pull to bpf-next/master
and apply the rest of the uprobe session changes in there?

thanks,
jirka

