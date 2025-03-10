Return-Path: <bpf+bounces-53719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F2A5927F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5737A5778
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86590192B71;
	Mon, 10 Mar 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4AfpEz3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFB14F11E
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605321; cv=none; b=K9HK0IZ/X/1AyncwbgsVFrm6DnpFMZkuPHhibDVJfjV8O4F4GCKgnOS2KotVwya6jxH5Psrp/9N3OmPlsZ70LO/of/rHLHChN55kgrYe+PWa+qKYO246j43ZI26J5oVFGrnGgHeLo/9/KqZgke+rl7xCQkqKwm1C8LyCJbboDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605321; c=relaxed/simple;
	bh=sBdmbN/998ap3n2jOAKx9O4bek1KhiHg72aW+UT4uns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q7O0Z0DBfLf7+gSWgKa1/yLDCnYWYlgDxln2DQjNHaqsyDzXuqWs8qbjwxrxGg4DyDUCx2qR9TXewb1CY4j3lq67UuNBsiW5JwDhOtYntvbOhuasgcZ8O8uuZbqBmNrl/Iwog2EVkCuAKnv+402U/QZvgvN0eZbOeJOyJavxYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4AfpEz3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1938298f8f.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741605317; x=1742210117; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IdtA8mjTgKs6nOqmBdEZzYPPRcKOdGQsmzJkUAwOVk=;
        b=T4AfpEz3muFNiZYu8HB29qh0IVS8wqr4QvmEiEA82EDVzIu3SKu/WkKx4QcmYroO5k
         Fqw3Bpcv6NKG8rnzAGzzOVV1Zoyr+hcKqHd0CCwpZOgwRosLtmBzPCNg0FYvui9/Kabz
         xKpLRnSE8e5UqfpPg3X/PRC5Q4gx6H47sMbDHJFRZLBZsjKghjz56d5/DLS+BpErH2v6
         +aVk0HYTnASH8c+nHaqTcIK2aX/DsszvYpr/vK2IeCv2vSFTJDFtXyzT5g95psI/H/VG
         QdjpBVT8wZNk0aoj92LnIeK0rCH9bTNA/S60Sb0N8yTUCz197e7i1mbS4oCLkC1nn4JC
         GXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741605317; x=1742210117;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IdtA8mjTgKs6nOqmBdEZzYPPRcKOdGQsmzJkUAwOVk=;
        b=UUzwPS1HPB3NQRB6HUd2mNoukoTQJ+KFW7IlGv1VimovHSlcm+8/XGOBK6fLAWDByb
         GrIAQt9b4fTAxAwFvJ8sBFItzgj6Fb9himnsuyuXXQKNjKSTOvhLUO//Bgz0yJnT8Ief
         TerBc3WlLWmEhkMDVz4azWT0rtCUyhEhUJqng7HCzzDyq+iMlICoJyt1HAGa0I+BY1v+
         eBqOr5fDs2FzdsNN3kXtaxdsYB99+kvdtp4mmx6unl0SYFxSGo7ZJSo56LjkbFF6FFor
         TozVaUJKqHITGGZeuNWoy5ICmaQXI0JPHoEOa6luKDNI54mj9rFqlcO9YkpLj1RKIsm8
         5AOA==
X-Gm-Message-State: AOJu0Ywc3FcAAdamR9aJaUieM7SRqgU/RdAPA51BUdTFpLc51FKg5Ee1
	YZrzc5/Bj8FOZ8UR1tVPBrIfXe1yJReMG98q6cAgGa3IdwGrwFvyBZ2aACj9XjMUgCRbFHaMXFm
	BZWEU0G9HN/d4p4dOJpZM0oT62IF/Z4D68xg=
X-Gm-Gg: ASbGncvx/UATAiyQ9bQGqYMt1/OFqyTkCCrKZSKtQRhnLpC0EFlsG2HLUKXhZrcJJrQ
	sr1BdkDrqxGAMhDkko4aU0Fbf+MykYRxRznKlLxXDr/ov5WUy0FViK6BYbTjuP3iVa+/hOUMjkE
	p7sxPIUQ2qv2eqHBfQA/7L2smS3w==
X-Google-Smtp-Source: AGHT+IHzKwAKw3QRJam9KfyWHL0zVdIKBI9yWnAgcz2z8kiXyFQYdVjXaib2JsDh+QHNYhUIOX5EsM9t/lkj2JdiBIM=
X-Received: by 2002:a05:6000:1a8b:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-3913ae6c6f1mr5382346f8f.0.1741605315864; Mon, 10 Mar 2025
 04:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503101254.cfd454df-lkp@intel.com> <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
 <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
 <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz> <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
 <9d8f5f92-5f4b-4732-af48-3ecaa41af81a@suse.cz>
In-Reply-To: <9d8f5f92-5f4b-4732-af48-3ecaa41af81a@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Mar 2025 12:15:03 +0100
X-Gm-Features: AQ5f1Jrkx5ROU2CxIAnqsPNE1dP9c4mCzA6UP2LWU-mF3O-jdk_UCXXi1Iv8njk
Message-ID: <CAADnVQ+MCxQsrVWC_DmQfwBxwv8pUw_9gXFJmO54Syybwwp6oQ@mail.gmail.com>
Subject: Fwd: [linux-next:master] [memcg] 01d37228d3: netperf.Throughput_Mbps
 37.9% regression
To: bpf <bpf@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fwd to bpf list for BPF CI to pick it up.

---------- Forwarded message ---------
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, Mar 10, 2025 at 12:03=E2=80=AFPM
Subject: Re: [linux-next:master] [memcg] 01d37228d3:
netperf.Throughput_Mbps 37.9% regression
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov
<ast@kernel.org>, <oe-lkp@lists.linux.dev>, kbuild test robot
<lkp@intel.com>, Michal Hocko <mhocko@suse.com>, Shakeel Butt
<shakeel.butt@linux.dev>, open list:CONTROL GROUP (CGROUP)
<cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>


On 3/10/25 11:56, Alexei Starovoitov wrote:
> On Mon, Mar 10, 2025 at 11:34=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
>>
>> On 3/10/25 11:18, Alexei Starovoitov wrote:
>> >> because this will affect the refill even if consume_stock() fails not=
 due to
>> >> a trylock failure (which should not be happening), but also just beca=
use the
>> >> stock was of a wrong memcg or depleted. So in the nowait context we d=
eny the
>> >> refill even if we have the memory. Attached patch could be used to se=
e if it
>> >> if fixes things. I'm not sure about the testcases where it doesn't lo=
ok like
>> >> nowait context would be used though, let's see.
>> >
>> > Not quite.
>> > GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM,
>> > so gfpflags_allow_spinning() will return true.
>>
>> Uh right, it's the new gfpflags_allow_spinning(), not the
>> gfpflags_allow_blocking() I'm used to and implicitly assumed, sorry.
>>
>> But then it's very simple because it has a bug:
>> gfpflags_allow_spinning() does
>>
>> return !(gfp_flags & __GFP_RECLAIM);
>>
>> should be !!
>
> Ouch.
> So I accidentally exposed the whole linux-next to this stress testing
> of new trylock facilities :(
> But the silver lining is that this is the only thing that blew up :)
> Could you send a patch or I will do it later today.

OK
----8<----
From 69b3d1631645c82d9d88f17fb01184d24034df2b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 10 Mar 2025 11:57:52 +0100
Subject: [PATCH] mm: Fix the flipped condition in gfpflags_allow_spinning()

The function gfpflags_allow_spinning() has a bug that makes it return
the opposite result than intended. This could contribute to deadlocks as
usage profilerates, for now it was noticed as a performance regression
due to try_charge_memcg() not refilling memcg stock when it could. Fix
the flipped condition.

Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for
opportunistic page allocation")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ceb226c2e25c..c9fa6309c903 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,7 +55,7 @@ static inline bool gfpflags_allow_spinning(const
gfp_t gfp_flags)
         * regular page allocator doesn't fully support this
         * allocation mode.
         */
-       return !(gfp_flags & __GFP_RECLAIM);
+       return !!(gfp_flags & __GFP_RECLAIM);
 }

 #ifdef CONFIG_HIGHMEM
--
2.48.1

