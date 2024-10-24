Return-Path: <bpf+bounces-43072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1F9AEE50
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B711A1F25445
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAB1FBF6A;
	Thu, 24 Oct 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPy0JSZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC241FBF58;
	Thu, 24 Oct 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791530; cv=none; b=IqT22sQdJkhlMYbQC6tNpiiZMg4LRQHIP8eszt8qxnqO5k1EAubNPZFNNjGUVAiNHU1+nT4/PI1L0WvHgJZcp5mQ8bSzxHTb3ji34/9zRitCkozi1Yl2nmlYFTgjd/Ea1JFamQd2FkISvqz1y3leE0VIfAboHfCuOqquqktj9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791530; c=relaxed/simple;
	bh=pINhcv0N6nz/VfV5Jhpd2PDP/ExPppcDqdNC675LxOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIlnuc0n/5Sk8p5f9KL4l+eEHXO7PtdqBNjkWKlx6YZBCl5C3hAsAlE4Bw7CZUijAiIKZfF8opl8Pcn/DgDaW++262oAyAKE6gTvEf3L003+UByDAkYCxEyl+CuITzGHXaSG/WOafTlrGmRkHc9n0BbPjt7eb/+V1dHALEekEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPy0JSZl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9aa8895facso175828066b.2;
        Thu, 24 Oct 2024 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729791526; x=1730396326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYax1c4EcHPuvhMblqzST6JvEaLizq8jVu6/eC35yLo=;
        b=QPy0JSZlYrDqQcNSKQ1Ttwf+1A2a2svMJu22TfKA9s+Jc+44PBuad3+V9n9UuwlFCE
         oha2aORjAP0kp1CqckOq7w+BS5ojZZId5x2fraoGmMPLdMvrkkrb+osNHs3lkR2kTT6J
         +fC/qDxMBsUpJOYmVu45wnN+gl5QwZjPDNWNneQVUnQpM9mDrvx2qA/m+FBTbWyqtVkA
         17taZ8uX4V6i0JTzvrA3+d5+3UcUF2iEYNw+udf/OVvfllqTQUhQEnpoIhdo1r5E1vxc
         T2vBEpF2FTD0G+E1bTeJnwEKCDvgXRuuLPhvWv+sUnKO7bBmuxqYbcEOGlp7CyG0183X
         83KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791526; x=1730396326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYax1c4EcHPuvhMblqzST6JvEaLizq8jVu6/eC35yLo=;
        b=mO/HB/mZpFz0N1eFHc8skiK9TNW0g+0gMy46WKy/4m9SDdBD7tqnjk8XPv9BZccTic
         Vb0qQDVEQFCjpW/ifMZzd/b37W1n0rNEcQTjlLqyDSlPr1OPfQze/OLb6pC7pWoaq7ke
         JQmEaqsA/0IQ6LmqJ5xURnZZNQJjHDCK+xlH2LSkZGoYQ3XvypiHiiiUpHFLhhMog6Mq
         MaftCAMLDY/5IzlpQlUb1gyTFvAEM8FK5xgTM45ahBK9qTLoD8xueATVI0Knri+bDJ3O
         gy1kZHivDnrCfndJJLtTgMYGCOziJKBUVp7Px0d6xsoFO4zPuYxPoFTdmJQSv6i1dy9u
         eeTw==
X-Forwarded-Encrypted: i=1; AJvYcCUUqCLdAqd2H6w8VzQ48a2Shf63mBtk5JWtZbwHLX7uOYzsVoWfP4xUhpcCs6uWug3MTYSHcsckkCw+LFwSvd3+1/25@vger.kernel.org, AJvYcCV8OHI3SKkFxvoVOSmmFeA33JsVf5dCglQQWvwxShKIP9b0Vtk3L0eTO/R/JPTFg74SYi4BW3nYbfURhVWHXu5xvg==@vger.kernel.org, AJvYcCW1RSCtGDRTj81Oycbotg4A3amotkSPZIc3hHMgNu5bLE6AD7jZE3Oc+QqEvmxhYNMop5M=@vger.kernel.org, AJvYcCWuWm0nrMbpVaJHv/pfbGlH6R1vfQC34DA8Bb29WNw4q+5s815PEpuBHzQ1olOmdM7kBSQQ3MSJM/zHuz+l@vger.kernel.org
X-Gm-Message-State: AOJu0YznULrke/Adyr3tlzd3Lpxk/6S06EKCtLwogS3wfck+WaLoXCsy
	M9LbrZlxPQZ9kYoGj5VgeNfGWtK2hlrq1kQ1EEAGW9dTFtaK++jX
X-Google-Smtp-Source: AGHT+IGQijkEwwhyn+S+mnlYVM5n4XrYCdRooz1oxvJslidQBkR9XRDm1xeUlhBy5dOaYPMf48xVKQ==
X-Received: by 2002:a17:907:7b85:b0:a99:ffdb:6fef with SMTP id a640c23a62f3a-a9ad2814065mr285615766b.46.1729791525922;
        Thu, 24 Oct 2024 10:38:45 -0700 (PDT)
Received: from krava (85-193-35-80.rib.o2.cz. [85.193.35.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f11sm642982666b.193.2024.10.24.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:38:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Oct 2024 19:38:43 +0200
To: Peter Ziljstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Will Deacon <will@kernel.org>,
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
Message-ID: <ZxqGIyvIQMXCyApJ@krava>
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <CAEf4BzacLW14OmuW1nV4s=cMcSqcrSAO2Y_0XY3jT2efGNfmuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzacLW14OmuW1nV4s=cMcSqcrSAO2Y_0XY3jT2efGNfmuw@mail.gmail.com>

On Wed, Oct 23, 2024 at 10:38:54AM -0700, Andrii Nakryiko wrote:

SNIP

> > Peter, do you mind applying those two and creating a stable tag for
> > bpf-next to pull? We'll apply the rest of Jiri's series to
> > bpf-next/master.
> 
> Jiri has reposted patches this time CC'ing Peter, heh :), it would be
> great to apply those two patches and get a stable tag. This is

hi,
any news on this one? I saw the patches in peterz/perf/core,
but I think we still need the stable tag for bpf-next/master

thanks,
jirka


> blocking the landing of uprobe sessions in bpf-next and also my
> remaining patches will be based on top of Jiri's uprobe changes, most
> probably. Peter, please take another look, thank you.

SNIP

