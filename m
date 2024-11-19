Return-Path: <bpf+bounces-45179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7B9D25B2
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13D9B23BDF
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4121CB30A;
	Tue, 19 Nov 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGo4dow2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197791CC15E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018961; cv=none; b=OhY6tJEc0JVFFC62I14ll9Mz4caxRZHFcOpr53SF0VGZxEHbi3jXh6mi1wLP0ExvPN2GdG48sqSWX9EcUaKkYAzTcMDiHzItMaxR2VloMY3D6rahBlkyLGSqJF1JOme4K1zt55G4KGATfJHjOIM1WKqkb886chZdxCJCWesZMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018961; c=relaxed/simple;
	bh=ABg3nqh2SspBq2EuQWpq+X64M/hCxNi/ukBuguvpkGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jj4xdN2reEDNtH2DeZ09FdufzE4iBV7FgZlEPTVBkHL8WlvXe7nQiiPbUAF599CCrM9Us0Yknbz7WZWLCNO1erWeRSGp1Uf1wF3x94Lgq+VZzCkD4jGpo9RaIHPISge95YgjYGiYa4jHH/1R9GxsjMBFYqiT3h4hgPxPEV+mzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGo4dow2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso142639666b.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732018958; x=1732623758; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABg3nqh2SspBq2EuQWpq+X64M/hCxNi/ukBuguvpkGI=;
        b=eGo4dow2TvzzvjaryeDnI59X6dqKeMg0UtEOiJ3rBWZSDfgTmU9HVaY9EnctMc0ywR
         ZvgVn6uD/Y+3iLo3aB/OGSmuQCQBzztsJlMowJVTY85BJqL9Pq+rhRZG//magzT6Dd5D
         aDsSnS7XJfjmnsRx6s+aXq6etA77+w5LsnwFWQTc9954rFDkpIM3hO60B7GVLt+DLpUN
         iCwLpgKYaOtdsw9C4EBnpl3ZSjjaEO+MTcEFi9oKRiQYuWGeOTNV/Qr9zq8O5mgG7lBl
         8+GfmDLLX2/9sgifVXTS88ooN1F9aijqobvxVyLD9hqvbVtp1kmWsPDTP7OsiQiGRO51
         6uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018958; x=1732623758;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABg3nqh2SspBq2EuQWpq+X64M/hCxNi/ukBuguvpkGI=;
        b=Bj5gjRO1m9o+n8ko8QvUbZlAxEXU7wrR2UGM0a0Acw92MEgvcycvPiT9csrXsPq2+7
         IAvJWlLo7gLpQR3GLLO9raf3WbUclUR48mJA+ba3JaybXc772anVbX6geVOsQ2mQRckO
         CCAphBa0xtlRjzhzSxzuzIRyTzw7fMaabxuefzDVAlnCBedGMUOimChSJG8wfgWhBRUK
         nMhX8+nn/ySafVz8PLlHiw1BdNbe9fsjhaMThLtes4saJYr5zsu0xJrrIXpxfdcZA8b2
         iAx4rGhBV7QyIIbbgBOaK/anRO8MfseCzPMTgtqCf6asxNS9yYe1lpa6kEI43WIRcS0f
         zT6Q==
X-Gm-Message-State: AOJu0YwAAASPGbfrywSQuey3wN1W6ozEreA3mpnsUpspI3TTEAI5gQ77
	qWGz2DlgoQpSgfMdvEXKTlW5mPrXIk9qAaUvBow/cVoyj1Qbjk0ZIMBgw/w8pjlVThpYgJpPFVc
	QvA==
X-Google-Smtp-Source: AGHT+IETIDK0IqTa/JQq0JxmmwUEG11avCz6DJk/DPa9Q5BDKMiCW4UYCH+2sGZC0NCfVSKZbl+SaA==
X-Received: by 2002:a17:907:3e8c:b0:a9a:67a9:dc45 with SMTP id a640c23a62f3a-aa4833f67b0mr1506059266b.3.1732018957897;
        Tue, 19 Nov 2024 04:22:37 -0800 (PST)
Received: from google.com (197.154.91.34.bc.googleusercontent.com. [34.91.154.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd721sm658789766b.107.2024.11.19.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:22:37 -0800 (PST)
Date: Tue, 19 Nov 2024 12:22:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
	jolsa@kernel.org, memxor@gmail.com
Subject: bpf: adding BPF linked list iteration support
Message-ID: <ZzyDCKrmgAGa4NDD@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Currently, we have BPF kfuncs which allow BPF programs to add and
remove elements from a BPF linked list. However, we're currently
missing other simple capabilities, like being able to iterate over the
elements within the BPF linked lists. What is our current appetite
with regards to adding new BPF kfuncs that support this kind of
capability to BPF linked lists?

I know that we're now somewhat advocating for using BPF arenas
whenever and wherever possible, especially when it comes to building
out and supporting more complicated data structures in BPF. However,
IMO BPF linked lists still have their place. Specifically, and as of
now, I'd argue that the BPF linked list implementation could be
considered more memory efficient when compared to a BPF arena backed
linked list implementation. This is purely due to the fact that the
BPF linked list implementation can perform more constrained memory
allocations for elements via bpf_obj_new_impl() based on the demand,
whereas for a BPF arena based implementation a BPF program needs to
allocate memory upfront in terms of the number of pages (modulo the
fact that not all pages for the BPF arena will necessarily be reserved
upfront). The fact that allocations are performed in terms of
multiples of PAGE_SIZE can lead to unnecessary memory wastage.

