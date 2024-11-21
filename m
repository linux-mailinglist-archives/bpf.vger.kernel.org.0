Return-Path: <bpf+bounces-45426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF279D562A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6EC1F230ED
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021B1DE3D1;
	Thu, 21 Nov 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/MUxuwZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFC1DE3AB;
	Thu, 21 Nov 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231770; cv=none; b=t8U6pE0NDPC18F3KnnuMeo1wVWvMDZjM9ZmwIMgUFKM88ZF81zUQC7lQoc8HbIAOhWYM34P6eJhH8EthU4bf4tRdGoRGJtC/E0xQ3/acGs/pnRk0X5XZLAaV+v6Yb6F7mVMdAAiFPQ4Vz6LKCLmZJFeRf1txYPDtGEAaHrQHV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231770; c=relaxed/simple;
	bh=3agi3g463cUMfLUPzQ1P7IltDVf69J4wx8NL57FN8Y8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o0NQibaU9DPpLXenXxL/nzD6nge19U3E8VifZyo+XyoE5etZ+7lQmoM6FY2dr22tW6kdQKHnJkTybaMDe0ox61YU0W3i6SUVPyE3oFvDxE2NorYNAkvTGYsGfJzeT+KBUQGFfmObr0PoLutGbpzyEJW4+xAPnJ/nk5TJpi9CPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/MUxuwZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e681bc315so1078041b3a.0;
        Thu, 21 Nov 2024 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231767; x=1732836567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uvUYPAt+7GuR03C0B8LYpvwYn6Rpq5Y+1RIDzkqP44=;
        b=K/MUxuwZ3tHC9LG7eRFmE77UM/3Lyj3XmaFcQHACx/evgAGtEoe/AbkUO+B0MRkEvZ
         Q7QhSzudxI5lesBkoydvRLSoaID8jMCjXF7HbQTjZFBcK8+LNeUTO9wG8S28wMwheo9v
         alFzsk38J2vbstf3DOrnG6KeNXXZa7psHX8PKvlnwMxLwyNNzVtO+JW5ewzXbzZYZ0jn
         vv9QOgobzOjDWvUxJAEPBBN7JYXOLu4pY5/90pKCuvYewzv1fHdtx+N7f6UcSlThmInF
         +Z1J0SjroBvOo2qcHklXJpgbTIZWcNweCgGqhiXPx1LlyZF2MCRByLE4yE7K9gYpIEUe
         dhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231767; x=1732836567;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uvUYPAt+7GuR03C0B8LYpvwYn6Rpq5Y+1RIDzkqP44=;
        b=SiUIVD4lG37sfg7fd4vJovyKhsVWZ/24Y1nQ6iPiwyDJRCCS64vTHnYiqDOVzokxj/
         IvjuiCO58xm9wVuy34W8m/sKa87tIKPf/bOVjl1LxNfKvEm4EZu9Bz/BR3zuv/B8oURF
         y/jHOLNsmENYll574cow0BijmMpFkZFwfbXsWLOSl5xkljc1B1tSd8ZS3wb7P+tUdwoM
         UM0F+id8Wymucp1JGP2ScTcEK+GkXe/u2Hh7cM79+3ugtfLHC6gitHMfgMIHKCx8Kash
         5/AzmvxBtNrVCAnavyp+1l7SQZJVQllEhs+8s/XbwOHIJEgufzmV5gFZO5RkIaEI0cgk
         7O+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtHyS3+NnQZ4YBOxqmlJigocyriUqhPPBX9oENXlO73BE91pOEKH3/ukFzaqBr/Tc7hCYNBDBqlNHJGhzJ@vger.kernel.org, AJvYcCXX1OcwQLj0HSTQqFjV9jLuK+d1Oqi9s1yVeMPyvsIJ9wx0XFZ+rok+KxKW37LRbU78o3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hbGOvmKy02tKBzsSKggMEcYSVswJFTFasqBl+wGrCV8j93+b
	mcPAW2tk8imRI3K4Yu5h+6FpIqG8h8PERrji2FN/W6tqiSdXJM6j
X-Gm-Gg: ASbGnctGO4WW7hz3dYgjYbGg0p3u6u6TKPqK/hDtnYmcWgd1FhAKZK8vKK26R5VHqjL
	HOSbZD5ucEAoWGQvdFWUc99Ensf4ZjyjyASPseq+4OSWBnixKb0GhJOdmQrkpWkSNnshqH25JOE
	HV3wbZZLb8oZxINyA3B9Wikc0v718wZmIfEvO8gQ4DJQfMRb81Ksf2UZOw5z3c6ktEw0M/JKfZU
	ihU1ZyKzRLuHBAl0ARd//7y59EcQYtWgMzhFc62buRSJKlwe5U=
X-Google-Smtp-Source: AGHT+IFwRZR66UGKDfsRQTBL5+hGumVNJ7KxGH/k9/6jYpZRGJi6GXSmOSC6F4rG2rJoOhyuTRjP8A==
X-Received: by 2002:a05:6a00:181c:b0:724:d06a:e0b7 with SMTP id d2e1a72fcca58-724de571aacmr2027085b3a.3.1732231766981;
        Thu, 21 Nov 2024 15:29:26 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454bc4sm331221b3a.5.2024.11.21.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:29:26 -0800 (PST)
Date: Thu, 21 Nov 2024 15:29:25 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, 
 Amir Mohammadi <amirmohammadi1999.am@gmail.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
Message-ID: <673fc25593a24_111820886@john.notmuch>
In-Reply-To: <3ec0fb06-79a4-403c-8ff8-84f7477ddf1f@kernel.org>
References: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
 <20241121083413.7214-1-amiremohamadi@yahoo.com>
 <3ec0fb06-79a4-403c-8ff8-84f7477ddf1f@kernel.org>
Subject: Re: [PATCH v3] bpftool: fix potential NULL pointer dereferencing in
 prog_dump()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Quentin Monnet wrote:
> 2024-11-21 12:04 UTC+0330 ~ Amir Mohammadi <amirmohammadi1999.am@gmail.com>
> > A NULL pointer dereference could occur if ksyms
> > is not properly checked before usage in the prog_dump() function.
> > 
> > Fixes: b053b439b72a ("bpf: libbpf: bpftool: Print bpf_line_info during prog dump")
> > Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks!

Acked-by: John Fastabend <john.fastabend@gmail.com>

