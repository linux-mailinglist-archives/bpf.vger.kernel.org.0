Return-Path: <bpf+bounces-21919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5F85402F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D431F257F6
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446BC633F9;
	Tue, 13 Feb 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLjzweJD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12B633EA;
	Tue, 13 Feb 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867458; cv=none; b=J9e6U3zVDMFDm8rRDykDlbEq7uCpC8RvzVbEHML7wgoJjZOrIRpaig7ZYPKm61Yot8v8U3XKXj8RlcoEjhECxwPz0N2d/VdhWRi21M1hlzi6BeSSikAig+zx1QfF3x0JUxxfhjP8eRA47lP41HcEvaIiHSRaVksjO7QFGL/p53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867458; c=relaxed/simple;
	bh=7UQ9JeaXWtzFbLB9yxYNDU8IskIsKRHblwv4pcI2np0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLZJlitPBvPh5Pd3M5+Ow39Sv6ChzfRRduwkq1QBClSqwPQ5zL9CUtL1nUg7U1LsDWhct26IodoAq0JksL1IZxRZmV8/n+g02hqRyErPc1wsoWwWmGhiNm1qW+/v/GkMwUtMe0ktFKHYhC0iXonDsaI6LgRC5yqx5p/ApDuDlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLjzweJD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42c7f8588c5so18413201cf.3;
        Tue, 13 Feb 2024 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707867456; x=1708472256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUcHXkgPqc0MMlZzZ+7SGaRFKCrzpcmlZlWE9wzGE1I=;
        b=bLjzweJDdJvuIK7/ZM/sriK5v5JkCSJSK9pAlqU+ust9YcWSDB6z7URYMjiCWQv51H
         /j/p8A0R7qU7Mh5e09adCSTTo+zCFazaKXXnGmmGSt7yArDZYQPZZpsWD8w1THIGZcPD
         wOMGKqqVB+rslZllT3gZ9aWQ+P4SRfIEXOYVFhZa+kGiBXRXMKt6sgywV9SmMMPYSRyz
         7iXybRJWzifpIhgcq15qbG1QHc9VW0iotQoaL80GEry6Ann0wIn6aWwOAIkZ1Mfji6vK
         Wm3jClG2QcMSs8PKRTcqwMNfbPVhx36PCjwMVKHICAxv2jWQnezVvBMiWBlY2POCPK6Y
         T9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867456; x=1708472256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUcHXkgPqc0MMlZzZ+7SGaRFKCrzpcmlZlWE9wzGE1I=;
        b=dRHmi00fXVGhojXmzBs6ooi9o7XjXnfXBXqkFHbfF+p/3vMQ7U0ARLttijMyTVHudy
         VK4zDdnY3fVcel7SA9sEsX1xLU1iNkK0e/tYvjer5bQDSJW0nkHCUOGTaGGWMDBs6+D7
         vf+Ky6OkJAAt5BgsuqxFRj6w9+khvGTHzt1MEswFxPTzzbMLrcVzqZbk6RHQzK8Y1ghK
         N+MLvUZsZXS7+IQHcxNyTXYvy8Q4s4gwkl1+EuSDyS1QBsnHmHIqOmTdlHlWZOGdpjJF
         /LTy4WkCBW861AdgI+i8YPgkjAqkVsEN3RadpyIZCat0klbzj4RttJDXnn9CUrnHbpRw
         Vfuw==
X-Forwarded-Encrypted: i=1; AJvYcCWpE9jS0+HrowobdwE2qWeiVkRIQvsxhtS9QVHrXM4AcPiFyRBn8r1SS1uq1HOOCyWGGrSsAMLpr90qjobvyfA9mY2UaoNg9sF3uwp7tfQX+Rut4ok8JWUZUMLm9Tb6Nw/T
X-Gm-Message-State: AOJu0Yya1sgsJzUY5r4GGhGuDCqN2lzYUNjBa4jba0IRUv+Hsosy9ZS0
	Txb3hJCLyLOsabASwwZsWxCiEg+0HbiOjJSKYB24a8iKShsfuA31OXp8j+Dg
X-Google-Smtp-Source: AGHT+IGehijU+EjUOH/rg/zPszpjSENXmgLaa2uW6GFs+Juu/Nc79rXmMJigmpv+mPFkt8B7y1HAlg==
X-Received: by 2002:a05:622a:1984:b0:42c:7a83:1158 with SMTP id u4-20020a05622a198400b0042c7a831158mr1083644qtc.51.1707867456131;
        Tue, 13 Feb 2024 15:37:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdtxFh/4/GNFz8q/hMbdQCh15chCNe8CWzyxxbep6boUm2esT2DVOWmzJeOi4rRLld1eFjLgZiUdIhdb93XXIqGZJEABaSV/tNWKf+XRZypRIXQDbnDA1PQqcYTCZrI6Et0yPITnMnVzza5YWMxOjo552ejYs2Kaw0NrxTajmCHq1xnAHYmMfZEn6BA1Z6z67qXRxJb/jVzaXnrpNWTPyonoLX0Q889jqtBwWE39Nk54j8rwfzJYSQmtr2MqE9VMnG9ikLCBAWWSy4omLbb60nDkgWdr3lJIC2FiyHgXH7WJ1S+4Q8itxXErHKubQKB+Qi/R9Ul9X6MQNl3Hl7mbMzgbZAnlFF9pen7gOvC6fyzcr93HNYKtAIKOwrIxY=
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id z17-20020ac87f91000000b0042c5a47df18sm1532525qtj.55.2024.02.13.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:37:35 -0800 (PST)
Date: Tue, 13 Feb 2024 13:37:33 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next] net: remove check in
 __cgroup_bpf_run_filter_skb
Message-ID: <r4mpzzib2rzcinai6ctcb32jvcbaenrjfddfcr4o6ghfvnqwct@gcmlz3pi253f>
References: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
 <ZcpMCnJMwbgiUMmE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcpMCnJMwbgiUMmE@google.com>

On Mon, Feb 12, 2024 at 08:49:14AM -0800, Stanislav Fomichev wrote:
> On 02/09, Oliver Crumrine wrote:
> > Originally, this patch removed a redundant check in
> > BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> > the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> > reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> > and add the checks to the other macro that calls that function,
> > BPF_CGROUP_RUN_PROG_INET_INGRESS.
> > 
> > To sum it up, checking that the socket exists and that it is a full
> > socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
> > BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
> > function they call, __cgroup_bpf_run_filter_skb.
> > 
> > Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>

Quick question: My subject had "net:" in it. Should it have had "bpf:" in
the subject instead?

If yes, would this warrant another version of this patch or resending it
with a different subject?

It felt right to put net: there as it felt like I was working with 
networking code that was simply calling bpf code but I'm not exactly
sure of that anymore.

This is my first kernel patch that has actually gone anywhere and 
I'm just looking for some feedback as I couldn't find much good 
documentation on kernel.org that describes how I should be doing 
this.

Thanks, 
Oliver

