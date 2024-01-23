Return-Path: <bpf+bounces-20057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4276837ADD
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 01:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3D61F243C0
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 00:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170B132C2B;
	Tue, 23 Jan 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjLAOtWG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E99131E54
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969118; cv=none; b=thdjzDUKKscbu4l8vVZVwL9+LbKn0t9WvI0ezTZpiNV66TnWSRqTsoneFhVCZ59S4Akdnofo80QxuysTDqlmwg985AbQipY5693SLmuHbCmVxWbS7YQg2JPhWebkSeTvHcH+Vd67xqod3HEOzN1iVMragcez+wEbl54GsPuNwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969118; c=relaxed/simple;
	bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TbPsYtTYWmbih/qqx0s2BCl023AKAcunQ5jnZFu7h5EbKWK+9y88ZWL8p70QxLzT25zTngaSkCit06gmLGVJVqdoWifSaSzLVhKx7LIUF321v6UMq1CD4W4H5jc37Vq76GJ/9ff4j9ksW11XSth8pl8GC5HgjUqm8gYRqWt2O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjLAOtWG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d73130a63aso39465ad.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705969116; x=1706573916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
        b=UjLAOtWGf3GPxISL/p6FR9uEmkw5YJYNWsgd775kKiULwOYS8r6J7O18I7+WnkWtVu
         e9yEqniuBXuQSeQkDoW0bLR8bzXHrQiqO68y/CdSPYTsiQhsSNKKEd44++1kA/ogLS2R
         zazB3RCFbZQ1QOADfmxmpUwTUd7jwjW9P+goXaraJ0hR1U1IMDeumy+Ky4geeCOKW1KD
         VT1hdEGITYRZaEkNBPwwwG4xy7PW2+Y8Y0IWVHFVDia6CER3eplc0C9+CFVGWrO9rrMO
         TqZEPe/YdHaNvsxZs3Gl8cOM0xzQzopx972dz9UtCuf++9NWS/fS1udM/zdZl6Xr7BWZ
         s3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969116; x=1706573916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wum8BJYj+T8SQW/eKNJQdcRou+VBvV/PoXpX8a7b+BA=;
        b=k3psh4Rzk4yCw1iz/8foU51iNvSXQHg4wqIH+fv1ZBgAVzQJ8BuVXrcZpXr7weIVeK
         h55HAWPY+Cr0Ln3dcth4HhztyvC3oLQE188YULb3aOt84lUta7BiAWhLWVuECWLvw5Mv
         cvbb0l87fT+KLlDbp4U1FH2w8DKqX72JhadSu367Gxw1884ni7OhauL8rWkJHGt16aP5
         oAiG4qja0f6umhgihA/NLE4E8wzPDVJwl7Y2fvB9V+ApkdmAFMwsh+f5Xee5MMU42B/E
         luwHYTxe91SUZ48+rj0BbP+3TA1/DMOjhLqUWGR3BXbdWJaDS1l2ecd9C8iMwG1S8dKs
         ibCg==
X-Gm-Message-State: AOJu0YwRGXvYe2rMfxK0BeuYjH/vC8bKcAYF2D7EUvVl0K55uAEiD8TL
	Vyw0sZFOXHm75kCLkyBkrzin+9fjaxYNCpXAWzhE6MOHQvVbp3LiunbNUuXDuucH9ZVzTpG/Bt8
	4fRm2K2ZffWaIl3jvOe9DVfH+Ir2DE94VHfa7ydNso/lGT6OmvU7nZZQ=
X-Google-Smtp-Source: AGHT+IGR3HJiIZxLpy0KnOUzu0aUKjwVwGb2urrMv/ETPZE4HNgQgZ059kjCAnNhTb9a5Auyfk6Ykplm7MqMOqocJqE=
X-Received: by 2002:a17:902:e892:b0:1d0:7052:aa20 with SMTP id
 w18-20020a170902e89200b001d07052aa20mr116321plg.12.1705969116212; Mon, 22 Jan
 2024 16:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 16:18:24 -0800
Message-ID: <CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com>
Subject: Better error message for kernels not compiled with BTF
To: bpf <bpf@vger.kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

if a kernel is compiled with CONFIG_DEBUG_INFO_BTF disabled then the
libbpf fails on perf lock contention with:
```
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed
```
The same error message is seen with BCC's libbpf-tools. I saw these
messages on default Rapberry Pi OS that is derived from Debian (more
context in https://bugzilla.kernel.org/show_bug.cgi?id=218401).

Given that distributions are shipping perf and libbpf-tools that
assume BTF is enabled, should CONFIG_DEBUG_INFO_BTF be enabled by
default in the kernel?

Perhaps:
```
libbpf: Error loading vmlinux BTF: -3
```
Would be better as (especially if the user is root):
```
libbpf: Error loading vmlinux BTF: -3 (was the kernel compiled with
CONFIG_DEBUG_INFO_BTF?)
```

Thanks,
Ian

