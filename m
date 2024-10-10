Return-Path: <bpf+bounces-41618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF4599930D
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375BF1F2A216
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D281CCEDF;
	Thu, 10 Oct 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS5ft44i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49561CBEAB
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589636; cv=none; b=aUdF+HgTCojaWaamdgwGBEdkezgnuJOOUDeFykV09EVd2kJCTdr2UW8nKTbh4KW/jI7m4umFrSrY7e+8HKzuvdIPM2OOp3cCATtP3t9goWMyXjehfX7uK8XhoE4bcHGLI3X1WTabvwBnqGcenAP/Wlbuv8q4ajnJMJOxyQa6+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589636; c=relaxed/simple;
	bh=Ad2gWHqcU6SoASPNqqdUbr1GqjxY2e2f6FY0xerOblM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=K5FA1W8Ep5rgm9XRCk/rpa6EPn/xmbe/noG2SaFPm2hGLPIym+DrVFx+1of9eIcgsbnJxk8x5fF3a8pGX8SRCoTLjeumUe879yI2R+NINk+wrVXdoLRLYcgMcoGwE0X6I5MZMTh6mUJWzXAyI5mPpImUmpimrUEs+4qs0RjBPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS5ft44i; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398d171fa2so1743891e87.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728589633; x=1729194433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc+Ec5BWD0Lmm6JZu7KaiPIjr6AnsGMR83RPBOUTmr8=;
        b=fS5ft44iEHPM5f7Hb7v66s4B3v5g3lolLqWEbe8MFoZOMrrk7TFZJxBC8f+TXFovY3
         IxBPqzrV6Xa+lpuhKFpz1Q7XsXVjGpX6ULuuCPmkJ5mBHAZeari/Wh+TKuU6jNyAchAc
         txgycGN8LRSOb4Z6LohGq1t8j4GJfThRRA7NZm5K9swOKqXYGlOqRpEv4/LZxRLJ7S4i
         AXut+9xt5Egx0ACic41SHcO739mA7etIUDOk9/yb6p0feXhUB0YckSKzwrv3R3g06Rne
         lSzwaNc0cZXpr5fZAavs1MFtf8L/p6E+KnVy220zDRvQKier8yFXMJULY6J5DyYaxq1Z
         StUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589633; x=1729194433;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc+Ec5BWD0Lmm6JZu7KaiPIjr6AnsGMR83RPBOUTmr8=;
        b=EBSEX0RBtXZDzq2a/r1OE9vdt7R5aENzJwSMZdZ9tD2+Z+r1KQbtQsR91wDSkwv6hY
         Vr8nSnHGdTWXF4MfWEs1nZjv+ZxM5oXH6hvLdDMCT6m3fV6pRtEzZCSPFPXxo+k3+Sqo
         DUIghn8dUK+E8AWdJ+/Vl7PE57J6nl5KucDjihgy0WbVoGAo3Dl7zr5w+v8pgpXZlHJl
         C1jXD5QKjxeaexjxsxsnN+EXjEFaww1Cj14pkgNU0VRhIWkEE0owsdOa5uuyOy4AYArg
         fwMA5fP/4hu9lj1gjYZkXOtZAkVeKjVjbGuZDxDibUYtDpMg8icMNrzi9OzKvuSHcbRO
         rCGw==
X-Gm-Message-State: AOJu0YyIaXTHnPLPfDo/Jqf1BQ7QX/CJD2eeqnHyuaAUwb6lXJ1Msgnb
	aCv6x0fLtGfA/8K73YJoUeEBOGR5GoOpHCWJzJNWK6t4uC5VrSRiytBrfg==
X-Google-Smtp-Source: AGHT+IEB1D4NCtWzJxV3C5jFt0h+pAaDi8fP+6iC2VeUZC4rwZ3fNIEOI8w2XMV5a8V/Q9W7HU/7Tw==
X-Received: by 2002:a05:6512:e9d:b0:539:8b1d:80b2 with SMTP id 2adb3069b0e04-539c48e4794mr5046073e87.33.1728589632432;
        Thu, 10 Oct 2024 12:47:12 -0700 (PDT)
Received: from nuclight.lan ([37.204.254.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c12aesm370666e87.20.2024.10.10.12.47.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:47:11 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:47:08 +0300
From: Vadim Goncharov <vadimnuclight@gmail.com>
To: bpf@vger.kernel.org
Subject: map records expiration problem / multi-references (conntrack)
Message-ID: <20241010224708.67f18726@nuclight.lan>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; amd64-portbld-freebsd12.4)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I am trying to implement in XDP/eBPF a somewhat relaxed version of TCP
connection tracking (defend against DDos attacks). To do it correctly,
an expiration by different timeout values is needed - e.g. 20 seconds
for SYN state, 1 minute for established state, 10 seconds for FIN/RST.

Using *_LRU map variants is NOT an option - as it is anti-DDoS, an
attacker may evict legitimate connections by fresh ones, because those
maps do not offer explicit control on expiration policy.

In a classic programming environment, it's simple: a conntrack record,
in addition to `when_expire_unixtime` field, would have a LIST_ENTRY
and whenever time changes, be relinked from a previous time's list to
new list, under locks held on record and both list's heads. Then a
per-second timer will cleanup entire lists whose time is in past.

But not in XDP/eBPF. I've encountered multiple problems in tries of
different ideas.

First, let's assume 100 million conntrack records. We can't have
a `bpf_timer` instance in every record - it would not scale to 100M.
So still need one timer as in classic variant.

And there are no linked lists in eBPF, and no pointers from
multiplemaps to same object, so I came to idea to (ab)use LPM_TRIE as an
"index" by time and 4-tuple with value be bitset of in which main maps
to expire records (TCP, UDP, ...). Then I found that:

* can't `bpf_spin_lock` for several maps, and values could be modified
  by several threads in parallel (modify old and new LPM values)
* `bpf_map_get_next_key()` is unavailable to kernel! So single BPF timer
  callback can't get just needed records in a loop.
* kernel helper `bpf_for_each_map_elem` is unavailable for LPM_TRIE,
  only for array/hash - very strange, as availability of get_next_key
  implementation makes it trivial to implement for_each for *any* map
  type.

So this leads to *userland* must clean up those records, but for
syscall this will lead to much worse performance; and
`BPF_MAP_TYPE_RINGBUF` is also of no help here...

The question is, how do I implement expiration properly in eBPF/XDP?
Anything I missed?..

-- 
WBR, @nuclight

