Return-Path: <bpf+bounces-28326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CC8B8798
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B208B20A89
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA40750A6A;
	Wed,  1 May 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1IfKDyV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2534F898
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555424; cv=none; b=pe6OwCuLVPRgwGVgwZUVtxhBrUZhxucy/6eG6UG1I9tv1cq8ek7Gq4UsZ2/RBKTnghqUFij3S3EVmfvWLAXjUTyOCUfkCD4XRQ05brm0Q97MLGodeDQvVSCPkPRtZGF1n7pwatGRmgngOSai37FLvyio3kVbPtqoliuWE/osYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555424; c=relaxed/simple;
	bh=vD0X+lGb4V7vyuSCKXiY/n7lLuBlCBn9mCPYAmCQmto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWpjzUBmjWVjmdbnIX6p/kmbz5BJN1KYpLDfBjuVFLLfhh8uQCVca5Zs1oMJ02h6s3/inbV+jaTPcosyByl93p168+qJVvqvq4k3dcOkprr5MNkLzBi1wL/1E1kaUCl5/VthCh0Sg+GsWHTjUsYT5NOQYUaYZWT7rChxjaYqVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1IfKDyV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so8082704e87.2
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714555421; x=1715160221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD0X+lGb4V7vyuSCKXiY/n7lLuBlCBn9mCPYAmCQmto=;
        b=F1IfKDyVAVXFKyr0KEvQq5jPL4kHcbkV7VMrwlp9REWBcFcyIHsjS58KMPgEviRid2
         w9A3PMxBYnD63YjET2eJ6szxrZBWdY0mxi7wqq/5Y9GKT+J5Qq0v+7oAia2fdqsOHyBU
         rd5l7HLsCCEmDrQJZuoQjDV9VQLR0XOqrDJfvA9APagAeOKMpSsD1QoRIAKbTFaX2T/S
         FkFbq9zw7OrwuJis8u25mTyr7itRqKpHf2UM1Idehxhh98aNf/taXfGWD27IlYaYntWc
         trXyhHJ9W9MDr5S/sBLi0q7ahrH8I4axukv9DGFZEBFCxtoPA+1fDl/YZLWQJ2rMLYNP
         UORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555421; x=1715160221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD0X+lGb4V7vyuSCKXiY/n7lLuBlCBn9mCPYAmCQmto=;
        b=WYCTxAk8IHj3wSBo0LCrt2AikA9ppEGNBNAd8ij5FyfZlZZaPk/GXl/avaLrBga3Ir
         ERym2cTiBd41EVv3/1cwfj7meJb6zu13+2v/TzKHBqokahS9tCqK3ksp7thhzGmRMMtf
         JsoWM8utglC0HkcAfnNQ/Q1y+Qv2X8zR2m8LmBp5BRZ8epAGl4I+jLG8Gf7ZL4TkMXjH
         Ms+KoETPv7NJha1qtLn1G+wg8jzizEzf1GO5xhSoqvdeO0whs1CkZRj5gAVpExk7GH/e
         kxqOUNU0SOJk3XTX2rDFPXgZmKzbJlnDUNUUwwdTRpFS0pMqn7huOoNxi4tIDtz1pUQc
         sxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfvmfF2Y1fV7i4C17u8jc/PtIjm/+w5ugMI90nGe6WNJEl2DhpLDmzfCewFP2zzwxXIRR3o4d4+P9wF8c0Ye2ZXBXd
X-Gm-Message-State: AOJu0YztP0negMbcc6QPeLc6jtAhEItWCdSvMX3yiUvWWYG+y5s4/vYV
	Gqqv4ppq1tV5DAo6s/2sHSD0KCyKb5U/HwCzou/Fh5IdpmUT2IpuN7JR9zl2qbT5FxkyLpaOiYR
	tqeX/9EZT+eQJKG2z+Xdzar11dIdnEH1uKrg=
X-Google-Smtp-Source: AGHT+IFwJ2ZTPWB82bQGmqXjZ+em4GVTCB8pgGTWIweDg/nyRAA0fFCACi7KvyM62XECdnBuQSZyLWdzux8UxVeuplk=
X-Received: by 2002:a05:6512:32ba:b0:51d:2459:bdbb with SMTP id
 q26-20020a05651232ba00b0051d2459bdbbmr1212610lfe.12.1714555420795; Wed, 01
 May 2024 02:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
In-Reply-To: <b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 May 2024 02:23:29 -0700
Message-ID: <CAADnVQKthyDwpZkYyqt+3fMtLjWsTD41Dyv+CVFvfaAfbfgYyA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB: what's next?
To: Vlastimil Babka <vbabka@suse.cz>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 8:42=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Hi,
>
> I'd like to propose a session about the next steps for SLUB. This is
> different from the BOF about sheaves that Matthew suggested, which would =
be
> not suitable for the whole group due to being not fleshed out enough yet.
> But the session could be scheduled after the BOF so if we do brainstorm
> something promising there, the result could be discussed as part of the f=
ull
> session.
>
> Aside from that my preliminary plan is to discuss:
>
> - what was made possible by reducing the slab allocators implementations =
to
> a single one, and what else could be done now with a single implementatio=
n
>
> - the work-in-progress work (for now in the context of maple tree) on SLU=
B
> per-cpu array caches and preallocation
>
> - what functionality would SLUB need to gain so the extra caching done by
> bpf allocator on top wouldn't be necessary? (kernel/bpf/memalloc.c)

+1 to have this discussion.
Would be great to have it as part of slub.

> - similar wrt lib/objpool.c (did you even noticed it was added? :)
>
> - maybe the mempool functionality could be better integrated as well?
>
> - are there more cases where people have invented layers outside mm and t=
hat
> could be integrated with some effort? IIRC io_uring also has some caching=
 on
> top currently...
>
> - better/more efficient memcg integration?
>
> - any other features people would like SLUB to have?
>
> Thanks,
> Vlastimil
>

