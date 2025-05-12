Return-Path: <bpf+bounces-58003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F5AB32E7
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 11:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98E23B3B19
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453225B1DD;
	Mon, 12 May 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJrkGb+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A725B688;
	Mon, 12 May 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041434; cv=none; b=Un0Pj7hMthx1hQeQC0eH8Fs287g/C9m7NNhsBpROal8cwr2uvm5l/MDBV2mr02AbsoEBaIXTLYJ5jvuCemR57huONdntsuCxQfNJSOCYympcYNEbStOrFuIC3JZIdNNFdvLjwymRLX3dAHTPyrw7OkCwgyqpBEzktgF2ETC47BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041434; c=relaxed/simple;
	bh=P3RO4uTvgPJ/nyC0opWGVPsTm1WUI+nNvITgfZ+op6s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkC8RRNcoj4FVmTrt0EzqiW5jrVn6VK0k22vn3t7XoEw0+1/6HbaTJmPHW2KKI4ipriny6Owl0Le7o3PHsBBEHZCqoPrPx8Zvk2PX9w4vYKMU9wkQdx7/2e1dpWO/qaVTURM6detFd3MwJ4749l6ZukGHY01eYOnYg4s0kx0Aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJrkGb+T; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ae727e87c26so2756505a12.0;
        Mon, 12 May 2025 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747041432; x=1747646232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jBu5hJfjZzXiWMlnb1HWsX2/XDd8JSuHJcwEjzDNow=;
        b=lJrkGb+Tf6SOYsc6+Pzvsl3o81IN0xmvR8v/Iu0zfOvHK6C2cBEMybAxgpqkOxMeeA
         tLn/4gHkyjFt3F4ZqhNuX8FSRlA0aojfuTjhynFqOE0pMG0PGoPOPUKlHat3Sbb4ghXx
         3miw/x/QOYOcejoNUYbZkx7WUSxR7HjPJlQoadTig8RUebu89dxydKeLfnXnIQoQ5BY3
         ieqnPxQGFz7R//mxjq4FuGF7wiJ+LuLxmM3IiJnd4HCJPc7+cIsF1hBcmj2Oyuy15Y/X
         bjsdn9r/pzQnJQRZlmwoVUDH8UBo6pO+V/NRmSbnHYaFhFhzimnxP7bzW+EaGgqJQtBQ
         FBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747041432; x=1747646232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jBu5hJfjZzXiWMlnb1HWsX2/XDd8JSuHJcwEjzDNow=;
        b=tji8q7RSsg1lQY/tU0xmlB4SPvlNxh5FhvBcstFcNlWDZamr/AKFKc1szA8kWsBzzL
         hqI7fcccZ9ZQpfoKhmyVMhNzRg7V9VdXbn+h3FuI5OVrc7mPScddZH5UkFJpT0VAE81q
         c0cYDGE+PilG3/+dTdesoDBNHwYY7k6DfGqg9lvYo5DXa2aNRuAi6UyQ0HSB7U2Xr53e
         m1aXRUt6n0aZUfxSXPdmJIkjQKtElOpsLDRKXqWIbumfFqQTCEHrH4MpVONoRdxc2XSU
         ce7/2OP5dfXJHtmn17XQBRshbMXzwakTbQVUmHzwt5z7luRG5TJHudLvE81qGCupExEd
         Qs8g==
X-Forwarded-Encrypted: i=1; AJvYcCWiChr4KoUsB1+nWMPVDiVmf8Gb+KxmVsXOVbZ3spvLXAuqfcLuGKhDXqUw+AVgAwbFfRg=@vger.kernel.org, AJvYcCXTjASoTrd077Ir9ZFAuxYk4idPxGHeOv9NFhkrdmF0k8tTm+tSFQSpylRccpODaWtkDGuAA0U2mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzWnZSJYOGWoF9/Q1BWlZ+2CJpeEczJy2L1ApQxF9ORZKz7QB
	4bA69CGMQKJ1uDju80/jzwNxM65jo60fJ2jkMstlxeEv0fSmilGa
X-Gm-Gg: ASbGnctSkabnCsmJqMHq84OnzhCMIZ2cSKbpGMqALTVg8lLgpBRyZCagfPn3bmZ39QB
	W0dht9oy/P+fDpWVBiC4x/f8fXifQjlWe6wBjHLG7sGyGUFXbDHyH8FmJGndvHZbqc4eT2RlobT
	Bca7aKdswXlhf8K+OXmOEVa3zTGoX5MZdUeWta+qjxzNM1GGNu8CBsCS/YmlxR7+slD4J4o58dx
	KTcXMNkBms7TVZRRdk2uCQYiXn7HwCa1H05o2EJctB7yBOtMOIkfTLVljJtHgHu2AA7u1sNz2rh
	S3ZsG8M97EGXdESprD5NgcD+f59LvuC+JZf6XPldowBzmoaRx7Ij9vSdnmHfKZqOBbl4/odRH3S
	m+LsICI1VS7PzgmBy5w==
X-Google-Smtp-Source: AGHT+IFfbzuYKpsOTWT62pyr+ORVdi61roFYUmfgA7Sx/VqLJzxuAFCHa5grksluo2iybb5qj1GIhQ==
X-Received: by 2002:a17:902:d4ca:b0:220:eade:d77e with SMTP id d9443c01a7336-22fc9185ef8mr201478675ad.40.1747041431756;
        Mon, 12 May 2025 02:17:11 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75450b6sm58724975ad.49.2025.05.12.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:17:11 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 12 May 2025 02:17:07 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, alexis.lothore@bootlin.com,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
Message-ID: <aCG8kz1eZjjw+sSU@kodidev-ubuntu>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>

On Fri, May 09, 2025 at 11:40:47AM -0700, Andrii Nakryiko wrote:
> On Thu, May 8, 2025 at 6:22 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > When testing v1 of [1] we noticed that functions with 0-sized structs
> > as parameters were not part of BTF encoding; this was fixed in v2.
> > However we need to make sure we handle such zero-sized structs
> > correctly since they confound the calling convention expectations -
> > no registers are used for the empty struct so this has knock-on effects
> > for subsequent register-parameter matching.
> 
> Do you have a list (or at least an example) of the function we are
> talking about, just curious to see what's that.
> 

BTW, Alan shared an example in the other pahole patch thread:
https://lore.kernel.org/dwarves/07d92da1-36f3-44d2-a0a4-cf7dabf278c6@oracle.com/

> The question I have is whether it's safe to assume that regardless of
> architecture we can assume that zero-sized struct has no effect on
> register allocation (which would seem logical, but is that true for
> all ABIs).
> 
> BTW, while looking at patch #2, I noticed that
> btf_distill_func_proto() disallows functions returning
> struct-by-value, which seems overly aggressive, at least for structs
> of up to 8 bytes. So maybe if we can validate that both cases are not
> introducing any new quirks across all supported architectures, we can
> solve both limitations?
> 

Given pahole (and my related patch) assume pass-by-value for well-sized
structs, I'd like to see this too. But while the pahole patch works on
64/32-bit archs, I noticed from patch #1 that e.g. ___bpf_treg_cnt()
seems to hard-code a 64-bit register size. Perhaps we can fix that too? 

> P.S., oh, and s390x selftest (test_struct_args) isn't happy, please check.
> 
> 
> >
> > Patch 1 updates BPF_PROG2() to handle the zero-sized struct case.
> > Patch 2 makes 0-sized structs a special case, allowing them to exist
> > as parameter representations in BTF without failing verification.
> > Patch 3 is a selftest that ensures the parameters after the 0-sized
> > struct are represented correctly.
> >
> > [1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/
> >
> > Alan Maguire (3):
> >   libbpf: update BPF_PROG2() to handle empty structs
> >   bpf: allow 0-sized structs as function parameters
> >   selftests/bpf: add 0-length struct testing to tracing_struct tests
> >
> >  kernel/bpf/btf.c                                     |  2 +-
> >  tools/lib/bpf/bpf_tracing.h                          |  6 ++++--
> >  .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
> >  tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
> >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
> >  5 files changed, 30 insertions(+), 3 deletions(-)
> >
> > --
> > 2.39.3
> >

