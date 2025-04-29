Return-Path: <bpf+bounces-56898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89243AA0176
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C085A4E76
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBC253F0C;
	Tue, 29 Apr 2025 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3NrL2OL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422A2AE96
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745902430; cv=none; b=tEvAYamGty86DPODw/t+XBGrOm7q/f8HICULcft0JSvGlxxL50cHkyxg/dCmlaDTgjJtAzHBiU48vo+EwCll67zo+qjmAIQ+vkVYL9XeATr1iPOhfeyNeU/cnTOSxDoWPx4lB/DFHQSwBuPqS9eZ0ifATSiswMRYeKHY5nt9Zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745902430; c=relaxed/simple;
	bh=O6sU6rJYRBQ2gGlqmVNq++VIem2PxHjQpsI9dQ4oSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpZFpn/s6q0uwYrq2zGCOcUwhdRqiVuc94YRf4CzWOX4jQ2T9jqUdz06JnDg9joYf6lBzdXMF1eN+7BLJDvZg2e2+gP04Us0wFaqooZCNiiJ0SyTZsMbp/tx/SY+91nn3N/mbWy1qZ+4R4Zzh9RPue20QieehhVjT9npPgUmYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3NrL2OL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769f3e19a9so38822091cf.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745902428; x=1746507228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xp6LAoUjHIVZ7DtQDxOY89fzDh7eityx2Li2YQGt9g=;
        b=b3NrL2OLy/zjz/+tgXGET6r7obC3gpMr3Yf+WfI8fmORda3zE6APAg8pyQ7Vo83gXj
         X4/A6d19EYtbJpd9+ETJINqxgTfGlJ6tQXfUYcWzlP1rbIEnpBMAI43JyCiNAstWXpz9
         cGPM8BxMMLKO+OIAlySgLarUjJu6WGCkv4Ur5jGBxAuxIhy9844iRoDo5w0UtlD9TXGW
         iTPOP8ee04018mHEgniYN6o5efpoB1ulLcAxsyckuYccyAWG7NpjL8ao6itQrvLrZEee
         wVhVOhoKae1QbD3qLiFCquxG6prhYWgAEEeMg3vMPoAeVD3AXp0G1kosc2j2ndjxlDjL
         vEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745902428; x=1746507228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xp6LAoUjHIVZ7DtQDxOY89fzDh7eityx2Li2YQGt9g=;
        b=Krxvt7LcUG6W1eVqjuISDMew3ZjRWrS8EPFIQc8F4mymsQ0MD/87H1VvXZi4jZoL6u
         mTn7eHTWfhaN1q22CJXg9lF97WrGL+fMHebdzpMq3HnwzGy3qsrACDSQVYxmwaeB4xoL
         AA3118lZozTFe8ZkZo/hUMMgktJbMgYW+BhQpIFkGT9O0/S8q8ydbcG4+81oa/0DCfn/
         +rx4mzA3x7iNuiHrQgW0LsKi1Bjsh4B3h51gqV8FuAApJGFXGJzqhIAi+gSLD0gm6sFd
         7lypE8kTpF7+TirD2szLLhvwwHEoS3cb2PjPtk/zLZbyNizwGIfvO4HMmCe4H1rt8SzM
         FRLA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+fVNlIyEvp1h/dVghXlusJCwmTcl5d7Bs4XWN+A2vpS6MdoWyw0odGLEr4pPl0dnX28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMa2cjvdf3YMjl8F/AQvzZ2U3IgcoJjngsLHc8B5m9EKunRgp
	AtRsZFPsK9QqO5NrDwYiUAj9K9Wxd5PqAiXjoCFvhFOcruaaZaAqwbjMstn+XO6j8oWJ/V9Uyxq
	Raqiyq1XzvHP0JYvOKViWJTtNL/g=
X-Gm-Gg: ASbGncvmsUScM2e65NJK0gFuNEWkRcapmvyqUDg1WcA/zet8KQOQm2Lx0ZXjjTXd4h8
	oR9s2Y19DuDZUeYVEYAHLJ4Pk0SZX0CT6RinmnD0P50/mz5eIY4s7Ww8iaUT2oWXOVwP+Mb7JCe
	NWaKicIFCy0hkwfvuGuqxNxZUsgwmrM+ou5A==
X-Google-Smtp-Source: AGHT+IHqbF1Xs5HUjuWrJmpqCoE9KOBo0/e/blblu+rdHTchfum8yhUjgDTekfMVgaPvq5Ok2+wx+IR43aUleYXG82s=
X-Received: by 2002:a05:622a:4d43:b0:477:548:849e with SMTP id
 d75a77b69052e-48813160ca5mr38410781cf.15.1745902427693; Mon, 28 Apr 2025
 21:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <aBBDUPzPIQ0z1RV4@casper.infradead.org>
In-Reply-To: <aBBDUPzPIQ0z1RV4@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 Apr 2025 12:53:11 +0800
X-Gm-Features: ATxdqUF3Eb1LIsoztpsMiNiEhfMAoSu1lU4u0Kjsvy09Ijj6whbC7nVCKK3e5bE
Message-ID: <CALOAHbD4-oRjgOC==2OL=xT1rOovB-TkpJeni95QZNAn1R=Zig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Apr 29, 2025 at 10:41:35AM +0800, Yafang Shao wrote:
> > In our container environment, we aim to enable THP selectively=E2=80=94=
allowing
> > specific services to use it while restricting others. This approach is
> > driven by the following considerations:
> >
> > 1. Memory Fragmentation
> >    THP can lead to increased memory fragmentation, so we want to limit =
its
> >    use across services.
>
> What?  That's precisely wrong.  _not_ using THPs increases
> fragmentation.

It appears my previous explanation about memory fragmentation wasn't
clear enough.
To clarify, when I mention "memory fragmentation" in the context of
THP, I'm specifically referring to how it can increase memory
compaction activity. Additionally, I should have mentioned another
significant drawback of THP: memory wastage.

--=20
Regards
Yafang

