Return-Path: <bpf+bounces-47733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0379FF320
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 07:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C827D1614F4
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5ED1773A;
	Wed,  1 Jan 2025 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9e8MyfT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B210F1;
	Wed,  1 Jan 2025 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735713311; cv=none; b=Hl5oiEeV+H2U2u3iRdf2kwEObMHxSS/s3g4yDu54m0/aK1Mol2CHjXodjA/8w/6TNoSKKRoCxXaotwFmZRrTApDYLypZk16V1nbvoaBY5T9a+sI9QJ3hlI4WJ4m4YF3BVPMJBz9KpTC+fv0jlpDyvzP4wZnsJW9ogkcqNU3cUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735713311; c=relaxed/simple;
	bh=N9DPcJ00zQ1NAaoMSnjCw8wdUTdbfQG6Y3QN/F+qfpo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iycx9J3OZPDnKr+ZB+qtxjAwUOlt0Pk2H8IDK6HTBLqSOFGPRFiChTCbg32B+BXHl6W/VoF7Ke7AdcHAoyhCThffUN+raWi/Hn4AvQ5WA1T6Dt2gLyPn5uhUzzW0Rw/fLxFMPYCGuZeUUaglzSIo6WnR7hvaM4NbJYdGLmY2xAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9e8MyfT; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso11096397276.2;
        Tue, 31 Dec 2024 22:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735713308; x=1736318108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjRUKLD8Bumt3e1+J2Bl6B2+88r0rX6AZyUAIAx2O50=;
        b=H9e8MyfTOrGQa1EPtuvA5McGJAG3S9He/OmnieQ8dABdo4Sg5Xo6ylgni0+jbGbP3V
         GJRL00Q9fMY+E2pjeUjY+KjGjOP76sOdG31m54wZ8Vr62Asyn89v7goaTNqun6dHcHKW
         zMA5uIaCcFcJ23wiWS/UzSlWTjugIB/N9rfjtoO2eKE6tv9nopRo48s3IdSJicVcP+PQ
         LC2hvP0lza5GN+A9V1XmfzKAqKknFlv2vmLpULuLBMWlIO7VvVWoiWTJlLOZ7yw8yHX0
         cpsLrcqajtwZOt2NT8Cj1ZF+PVzzcqtTKX+TUsEtQDgXaYODfyGlHj5vglULCB+yVDOu
         L3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735713308; x=1736318108;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjRUKLD8Bumt3e1+J2Bl6B2+88r0rX6AZyUAIAx2O50=;
        b=AsSdKHS2deleyYIohlJt397okIoY9ggnVvj9wbdqyf/rM/rGA0T7F+4XkgL/bGRLSG
         1u53ZIkhZzPEsqfSKUxf/mhNCiEPZcIbJOsc0uuJKUfRFkfZESWir+wrj4bEMgRiEw5K
         YZPnST2fxNAzH255E7wClKITIFN3OBHryAUDmO75VDEQ14Ou1Zi1PsYaOCz1WFN1Gg4s
         2ten2UGVshx2pznqjbe8AiJwGf8vru59bKhM3UEL7wDdO1z/0hLJejha3FCcmr4VqaPu
         lj7AtR8W6Phc7aGNWzzR9iPj07ro7uAzNkgS8rSjAu3vxZGR2sKzw9kKqDIhnu7AKaA5
         l0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVTZU2Dk44Kq+meOy2+1JwnVCFBjJxwsfTZb+EUAHWVXXRi8oSuckZCoYpL5o2bcDRQkCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyE4XvPaHGLWrn+b2C92S2Xgwmy+4Akhpuq/jDKAb3Enu78nCT
	r6HSb1hUdRPUOHJoZRCM+wZLtIdakbE5TfcdlIMg4oskbqVCJ2ltJ70JV2BKy9bottGRPPfHER0
	315k991x4bo5WVbDXgMrTi08IBXuSKeWeIek=
X-Gm-Gg: ASbGncuRcNsFXWXU4l/8cRX85ccvs5of9egeeKxGp8wx55e/qMu+TWcc3KcvmCGeYis
	7fOuYLmm8x9GK2iJsqYe2iSRFyRC+oipvYT+wb28=
X-Google-Smtp-Source: AGHT+IHOu/oIRhG13MDfx4abwpJNhF+F8OwNmkbA0Gt7/LClFpyFuL773FGv7SRH8gVMM++xgNLIaY4G/mZ0C9lv/Ok=
X-Received: by 2002:a05:6902:114f:b0:e4a:ea18:b44a with SMTP id
 3f1490d57ef6-e538c34ee63mr21280890276.38.1735713308394; Tue, 31 Dec 2024
 22:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Wed, 1 Jan 2025 12:04:56 +0530
Message-ID: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Dear Community,

I would like to propose a discussion topic regarding the enhancement
of block layer tracepoints, which could fundamentally transform how
backup and recovery systems operate on Linux.

Current Scenario:

- I'm developing a continuous data protection system using eBPF to
monitor block request completions
- The system aims to achieve reliable live data replication for block devices
Current tracepoints present challenges in capturing the complete
lifecycle of write operations

Potential Impact:

- Transform Linux Backup Systems:
- Enable true continuous data protection at block level
- Eliminate backup windows by capturing changes in real-time
- Reduce recovery point objectives (RPO) to near-zero
- Allow point-in-time recovery at block granularity

Current Technical Limitations:

- Inconsistent visibility into write operation completion
- Gaps between write operations and actual data flushes
- Potential missing instrumentation points
- Challenges in ensuring data consistency across replicated volumes

Proposed Improvements:

- Additional tracepoints for better write operation visibility
- Optimal placement of existing tracepoints
- New instrumentation points for reliable block-level monitoring

Implementation Considerations:

- Performance impact of additional tracepoints
- Integration with existing block layer infrastructure
- Compatibility with various storage backends
- Requirements for consistent backup state

These improvements could revolutionize how we approach backup and
recovery on Linux systems:

- Move from periodic snapshots to continuous data protection
- Enable more granular recovery options
- Reduce system overhead during backup operations
- Improve reliability of backup systems
- Enhance disaster recovery capabilities

This discussion would benefit both the block layer and BPF
communities, as well as the broader Linux ecosystem, particularly
enterprises requiring robust backup and recovery solutions.

Looking forward to the community's thoughts and feedback.

Best regards,
-- 
Vishnu KS,
Opensource contributor and researcher,
https://xmigrate.cloud
https://iamvishnuks.com

