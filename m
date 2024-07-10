Return-Path: <bpf+bounces-34380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3E92CF95
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB0B28857E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655119248D;
	Wed, 10 Jul 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="1OLhefG3";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="hPcthnPY";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="Cf5PUmHi"
X-Original-To: bpf@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BE192483;
	Wed, 10 Jul 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607838; cv=none; b=IUqfQwvuA+MXvhChGI6iRfmo5InqJHwcfiYhNu9lWE5NT5pqythLjW7iJ3mPfmbGIYcRH5qKQlxXoNTbos++cThuuqn8n9U3PGttWNUfL9jcCqUXSMWcyqdeVVrRdkKx2QV3OC6XAbJPcttzOWM60CTfB2Et3l9O1HViE3kk1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607838; c=relaxed/simple;
	bh=Vmbz1kK3GlYxZQsiTl+3RZqOOLwNAAA/LayB1v2Vt7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SfWcykaf+D9W5TUN09SjOPbEtqjDYTEQsGZVzHrhgw++iX4+kfmvdkThWYW973XDuJ6io/q3OOPDRyhnAz78fHKvKvAqdz2sHT016UzyD6bwnwHRvW27ICrSqZuG5jl9l4u4S0xStXmE2BIGnlzLbKhDftpVeOs9FnaNZlS5ZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=1OLhefG3; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=hPcthnPY; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=Cf5PUmHi; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1720607227; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=Vmbz1kK3GlYxZQsiTl+3RZqOOLwNAAA/LayB1v2Vt7g=;
 b=1OLhefG3fY7X3piTjP8dU57Kk6b/puhbX86fKVURh4XTnBxWW/HxXdThGhMuczN2Q8/Tl
 lrs0qu1n2sPyf2HBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1720607227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPG40DNeh1bA8vQMqxypWsF1Z7oGkQ4DVc3MuZC4QII=;
	b=hPcthnPYx9cfRcsQRcbRHAQnryhhxTX4kyN2wOg1V736dJQelk0pUokIA68Rx8eANwPGun
	64usllrnYTr1PuAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1720607227; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=Vmbz1kK3GlYxZQsiTl+3RZqOOLwNAAA/LayB1v2Vt7g=;
 b=Cf5PUmHimuZy3iMD3QwqJy9btT9R/vv119rhUjoQVC5elWFjKiRD1hoRQoV8z1xoZXmLe
 86TGGVTONoY5oeN2AYV6aZiGsT6b8zSpktTWpiuWxgv8jPglggcAPILRTOy4+HYvxCrApj8
 pwK0pksynmC6CNP9SbljvMFb/rokWZEqOWVnUSgJOG1Idwm/cwzWHvK8VXcmmRdDGIj2W5i
 mSQmqNz2qwsbqAIkONNWCSMLHAJq0vFDvyERc7WFXu0JQ0kVQg+v1sJ4PtBM7SneyIeQygk
 0NuDodHK0wIGOBfw7RrqVQUhX1Ve1EHg8Nujf8ZQpf9nyxK+YgdWwBPyszjg==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id D3E8C5FA2F;
	Wed, 10 Jul 2024 12:27:07 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:27:07 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org, 
    ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
    eddyz87@gmail.com, haoluo@google.com, javier.carrasco.cruz@gmail.com, 
    john.fastabend@gmail.com, jolsa@kernel.org, kent.overstreet@linux.dev, 
    kpsingh@kernel.org, linux-kernel@vger.kernel.org, lstoakes@gmail.com, 
    martin.lau@linux.dev, peter.ujfalusi@intel.com, 
    regressions@lists.linux.dev, sdf@google.com, sheharyaar48@gmail.com, 
    song@kernel.org, surenb@google.com, yonghong.song@linux.dev
Subject: Re: [PATCH for 6.10] bpf: fix order of args in call to
 bpf_map_kvcalloc
In-Reply-To: <20240710100521.15061-2-vbabka@suse.cz>
Message-ID: <d4e5caad-7a5d-863d-bf65-63978ff9a865@nerdbynature.de>
References: <CAADnVQK_ftwe5Dxtc0bopeDg2ku=GrFYrMOUWHLnXaK1bqoXXA@mail.gmail.com> <20240710100521.15061-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Jul 2024, Vlastimil Babka wrote:
> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")

Thanks for not forgetting about this! If this matters, just tested this 
against today's mainline:

Tested-by: Christian Kujau <lists@nerdbynature.de>

C.
-- 
BOFH excuse #418:

Sysadmins busy fighting SPAM.

