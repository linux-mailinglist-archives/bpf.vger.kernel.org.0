Return-Path: <bpf+bounces-23143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D386E31A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F5A1C21DCF
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806996F06B;
	Fri,  1 Mar 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Zj0+d7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEA386;
	Fri,  1 Mar 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302504; cv=none; b=j2U/bpRz2ZqwETqMMt1DnS6rzZYFOKXBQMlNyVfV9X+GLg1jHeubIFu8bCd6S500YxQ6aCrrTIoBzhHxjOyoxwrMjuK/1r2VKMqc4p4fMa2p6KWbI12gQxmo/sMAsa7lHuoEpYbCgzUgQB19o+WyFbhz+wM5yzqEw2TFsbZ/TWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302504; c=relaxed/simple;
	bh=uNMW83LNJ2amnFUbvjiWJQyAEGNgW0Olyi94J6gfEOs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvFwvtot3Fjjm6zK5pFc1UR8+qexGsGIC2hypAVG6/JqmWWX4E3yCT8q3L6BE0SCpmipsGOpnIZfy8JaXgSilNYro/ZAQrg0Qf+R+VZclJpJJ9vVHXrO+ZB0r9C95KWvOt3ucaWHlfc9WSZ8RrOCK2kXhfowyeNMtWXi+ha8M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+Zj0+d7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412c83a8259so5056325e9.2;
        Fri, 01 Mar 2024 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302500; x=1709907300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0oUCf6IAisxelJxCU2JYLXA6npjdC01/hvoCHou+0k=;
        b=M+Zj0+d7QIULJtkxzY2IYZxasw1Y2b05yrNKOViUQKzfTey22MuHzNZzSN8mDxZ9IH
         yxD4Y6IBHg8adGyxdKKYpBTkRS/rxdWi4pQsukBuzkTkQJD0ygmpE/x9N3EfXZRSY7xQ
         +A4KqXGrwdJmRCgIacm8co2qYAnWeOA+7FhqB1Aiq7gkJb63x1VRYui8YjQF22Or5sNB
         14Fw0WRBJJSaQKUBWfwGphXBfGWhRyzxMVukf1Z4n5OjDFFuCPxT0d7hZCCwRP5fLI/0
         2mEoC8b+IIrSckwBNdQ5G/UeflsOUXZbfI2rIaBdvEhwcSwBd4pbUGxUR0GagEZZ0CLy
         0qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302500; x=1709907300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0oUCf6IAisxelJxCU2JYLXA6npjdC01/hvoCHou+0k=;
        b=O3e0+w31Mgk+m4M8zirZ7YHQqvo21pbFlCuOyf0UvL4FIBAtO5Iq9G8rPDGHabSU7v
         qAbjcKLO6dIGR1ZOXVuEXQNhNsBQSFOucrnxyTa8hXYWLyUBywBatFpCOaX1bLAdJRVl
         A0o3F47C1r/lVQVmViDmhDwuH9TMcvQmD8M3cBV66XhjS550R/gJcoLxccmMC8MgmUWa
         uEbdRHNu5pDNAwR53BBUSprbmwDdSulJBKx8V0OHnyOdlbiwh+VxeDUUFutfz9OfBlVw
         o1YW1ovB4HQn+qhelvBI8LlcNEOBqXkeHTxqTYvmDWX6/K5gdVfgADdVu5RwTNRDVgg+
         Zx5A==
X-Forwarded-Encrypted: i=1; AJvYcCU/u+a+lM/jmufJA1SGNamvV0Ec6xH1dQ4DRudlvxR7KoZbl0mSMJ8tSOC0rgSBaBVSZKg9pEO3TOjLSwJWb48PiCujFj3NHe86jx9owkSluRYMnGvF1EdcCzHICuNlyP70E6qHNmleCDn5jc/pw4bh5kPMIWS5td+WVQ==
X-Gm-Message-State: AOJu0YzbQpzYCSXiouMfU4im5pkLpGx0XMcm0xUF/0wypWyWhY2NoYLJ
	nQbqExTUieGzOipiaPSpYtjcZrUQooQLfxJLHKLgQkhLO9aGciIS
X-Google-Smtp-Source: AGHT+IEf6QUcADO0SVa0VNze/d3gfBDz4XgiCRrsEP4Mtdzlu5/Pp+jwbT52L8f+i0X0rsp+pwOYmQ==
X-Received: by 2002:a05:600c:4691:b0:412:c809:5421 with SMTP id p17-20020a05600c469100b00412c8095421mr1539241wmo.2.1709302500276;
        Fri, 01 Mar 2024 06:15:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b0041294d015fbsm5634372wms.40.2024.03.01.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:14:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Mar 2024 15:14:58 +0100
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
Message-ID: <ZeHi4qz8HqDSCC4H@krava>
References: <20240228032142.396719-1-jhubbard@nvidia.com>
 <Zd76zrhA4LAwA_WF@krava>
 <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
 <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
 <34157878-c480-44bb-91d6-9024da329998@oracle.com>
 <f248cf92-038c-480f-b077-f7d56ebc55bc@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f248cf92-038c-480f-b077-f7d56ebc55bc@nvidia.com>

On Thu, Feb 29, 2024 at 10:15:23AM -0800, John Hubbard wrote:
> > ...
> > Running
> > 
> > bpftool btf dump file vmlinux |grep "] VAR"
> > 
> 
> $ bpftool btf dump file vmlinux |grep "] VAR" | wc -l
> 4852
> 
> $ bpftool btf dump file vmlinux |grep "] VAR" | tail -5
> [136994] VAR '_alloc_tag_cntr.9' type_id=703, linkage=static
> [137003] VAR '_alloc_tag_cntr.5' type_id=703, linkage=static
> [137004] VAR '_alloc_tag_cntr.7' type_id=703, linkage=static
> [137005] VAR '_alloc_tag_cntr.17' type_id=703, linkage=static
> [137018] VAR '_alloc_tag_cntr.14' type_id=703, linkage=static
> 
> > ...should give us a sense of what's going on. I only see 375 per-cpu
> > variables when I do this so maybe there's something
> > kernel-config-specific that might explain why you have so many more?
> 
> Yes, as mentioned earlier, this is specifically due to the .config.
> The .config is a huge distro configuration that has a lot of modules
> enabled.

could you share your .config? I tried with fedora .config and got 396
per cpu variables, I wonder where this is coming from

thanks,
jirka

