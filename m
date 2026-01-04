Return-Path: <bpf+bounces-77761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAFFCF0A22
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 06:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067DD300B936
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401C2D5C9B;
	Sun,  4 Jan 2026 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LCgKAjdk"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0DF24DD09;
	Sun,  4 Jan 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506129; cv=none; b=agcs/GLALDZBJtVIYIf6Gh8l5WievQLyx+0wRNuJUiUheoYk20eZJpuhwmE59YosS5ajCate3foJaqXFol9MBUv5QZst3NwNIsBWUWttScs7aSQ5s2UqOagAUfp4LYms2TJNtZCWhk4HnEQZNAeA+SPTR1oEPj9ozoyZ/3Zh4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506129; c=relaxed/simple;
	bh=bvcEYZX+JN8SQg3OfkTTKvOz8B84LEMdLKYmNZ5Vf/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WH8OvTEe8gOKLa2eoZbaRg74vuomLyXvna7R3/OvSCjpYBDeGwleNMKzth4VFMq7WCTKKq002PK1jttz7VVlx7QriuN0F2xcj6NO4E4PTUqPOcQUip1GrBN5l3/7P9Fde9dBKYkh/5aclhxuxt7P4fYwiZ0FnfYWsDm4gPzdNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LCgKAjdk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1226)
	id 3B5C32125381; Sat,  3 Jan 2026 21:55:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B5C32125381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767506122;
	bh=D1lvfzzfDtjTq1iLATeqBIsx+b2iIWukWZbLU9J7P9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCgKAjdkKwl0BjuW8Gchv+ts0i+CZPhE6MstaFRoRqPNDmqlD9f3/UStYCZEke3qr
	 7Svx2pI3wqGmp3OeBMR+y/vhcfyOVFfMqWJrJc8f9CjTy1RarEegzOSl7zmJ+VwRUA
	 awfzu8jbZfpMF5p7oWipiGwm4mcZv0mwYTWjMmzU=
From: Hemanth Malla <vmalla@linux.microsoft.com>
To: ihor.solodrai@linux.dev
Cc: alan.maguire@oracle.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	dwarves@vger.kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	vmalla@linux.microsoft.com,
	vmalla@microsoft.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
Date: Sat,  3 Jan 2026 21:55:22 -0800
Message-Id: <1767506122-8122-1-git-send-email-vmalla@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
References: <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi Ihor,

> 1.28 is needed for --distilled_base [1], which is only a requirement
> for tests using modules. Many other tests are likely to work with
> older versions, but the minimum for the kernel build is 1.22 now [2].
> 
> Not sure if it's worth it to add this nuance to the QA doc, although
> in general we should recommend people running the selftests to use the
> latest pahole release. Maybe add a comment?

Thanks for the references. Makes sense to include these in the docs.
I'll send out a new patch.

Thanks,
Hemanth Malla


