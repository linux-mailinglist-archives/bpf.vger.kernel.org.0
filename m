Return-Path: <bpf+bounces-30526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F098CEAF1
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4052281B4D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859057350E;
	Fri, 24 May 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b="MjaY6hzV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9A5EE97
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583160; cv=none; b=FuoXuKjcR0IA/tT/NooS1Scp200OVravMb8cLPlh1YdwiUWuJ4hS9lE6dxtnwNm2PECKQxlUK+ReGpFooW+e2mmh9jH3Zz3K0AHGwc5D5WGrVT1WOSz1ngqwMvtjDl8CkvnUFO4sbSzbaxAE9MFWCiBtmOL7TYy5by12gGtwtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583160; c=relaxed/simple;
	bh=RXZPUczqB95X8X/mfChG2GAtd+n4ZzVW59i80BUg7p8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uu4+ypBc6aioj4dw6Fb8LmRc7FKg7bfkb1QVFDMlq2gqP5G+qF1BhNbvA5hcg2uBT27ELyHzYUvgHUSNJAc8WPZeQVRkF7MlRb63ThC2Pc7BBdRFC71P1YZcWTd+eteCqo5BjM3e/DsLUcxIUxdD4XxIdmpPAVL2G7Opf0EXY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com; spf=pass smtp.mailfrom=polarsignals.com; dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b=MjaY6hzV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polarsignals.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df771fa2b8bso1331370276.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=polarsignals.com; s=google; t=1716583157; x=1717187957; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYVKjGesOOGSPTkKnH4afJPSD2U1mdDsrYWhw8wuEm4=;
        b=MjaY6hzVIrkmD/8ej4Or2cgnZkhdceqhvzvDCR6NTtceVGcpBH98PZRwFojhh35WfE
         FJsKb6cfAwyNn4OE1+cnj16BU9QyZ2aDBDmy8nc4VITmN5BhbQcUuS51Vp31lrTyGqYv
         4j2zFuO6ojBhr9spxVzvDJOfPct0P+et3+IT8+AV77SCxqcgZBnIUfCswhKjdF503ldh
         3Ic46jjLfemXGdQxS6d4LzsnfN9YC3NIV9IPQkdTbbg+v/gW9v4MmOegbFOl1kY+IIel
         4kFThGr0LgqSge7KgT9d+QejQhLL7Mvh0hiRkahuuEVwuwNH8Jmylaq20llEssEjgam9
         wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583157; x=1717187957;
        h=mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYVKjGesOOGSPTkKnH4afJPSD2U1mdDsrYWhw8wuEm4=;
        b=iD/p/27v1ykzuyGgGOOZzPW7SUg1r/YONigB/x0AqFrngGr7zsRGxepxKdUGzVHX6L
         7SvzN3xeLTmwPzSkjj5KVJwG+lSNbSP7K0koshR5iiIxh7/GAWk38kXvCFXzg0ZzkvDb
         qThypiiYzWINwdqoLXdFgLOUyOE4tV49KIV9r9meq41Z4yQIpW4ORfKmDhakj1IrD/Uj
         bBD2c5lAuKVN02vgyYSpgcfacosZZ6tbNSEPRy3xNOzaRsUb3xvcBQ39x5/KLmBVC66G
         kvqQD6TCQaF4seobsqzVaheKHu0jDizDEF8wu9ScGFtBzCTYyAi7Ec/WDTU45LlrAWNc
         G1hw==
X-Gm-Message-State: AOJu0Yz/OjLQ96u3J0MUyxJukpZ2iDsvOJqm87Ipt8y2GjllP6SZIYA0
	2wTyaesTnLwrh+8Edz5KAgwGlmXSjtsfCJLQ1dfGdy8DlZIdLQtVATRKsvj8tR/BgnRN+l4iTmn
	8
X-Google-Smtp-Source: AGHT+IG2qel0DliyIGEtWtBvDKTF8yS0lMeK6CS51rXVCaWEUXT3CP7sFNrNu361YnnoWfd0GZ64Aw==
X-Received: by 2002:a25:86c7:0:b0:df4:9844:3226 with SMTP id 3f1490d57ef6-df7721572bcmr3508513276.12.1716583157455;
        Fri, 24 May 2024 13:39:17 -0700 (PDT)
Received: from localhost (pool-173-56-0-190.nycmny.fios.verizon.net. [173.56.0.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794b2fd8f71sm6946885a.103.2024.05.24.13.39.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:39:17 -0700 (PDT)
From: "Brennan Vincent" <brennan.vincent@polarsignals.com>
To: bpf@vger.kernel.org
Subject: Minor page faults in non-sleepable programs
Date: Fri, 24 May 2024 16:39:16 -0400
Message-ID: <874janueq3.fsf@taipei.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

I am working on a bpf program of type perf_event (thus, it can't be
sleepable). This program needs to be able to unwind the user-mode stack
of the current task, which of course involves reading stack memory.

In most cases, this works fine with bpf_probe_read_user. However, in
some cases, it causes page faults, even when the relevant pages are
resident in memory (and thus accessing them shouldn't cause a sleep).

One example of when this can happen is when running on a NUMA system. If
the process is migrated to a core on a different NUMA node, eventually
Linux's numa balancing feature will kick in and the task's stack pages
will be migrated to the proper node. When this happens, there will be a
(minor) page fault the next time the process accesses the page so that
the mapping in its virtual address space can be updated. But if a page
is _never_ accessed again by the process, then bpf_probe_read_user for
addresses in that page will always fail.

Is there any workaround for cases like this, or is it simply impossible?

One possible direction could be to allow bpf_probe_read_user to incur
_minor_ page faults, but not _major_ ones, but I don't know whether that
would actually be possible.

-- 
Brennan (he/him)
Staff Software Engineer | Polar Signals Inc.
P: +16238249252
E: brennan.vincent@polarsignals.com
W: umanwizard.com
TZ: America/New_York

