Return-Path: <bpf+bounces-30311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D495F8CC4F0
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B131C21942
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4C1411F3;
	Wed, 22 May 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="HtrmE6xM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69782877
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395741; cv=none; b=tG0FmDQGmK41HxbWKcsxp/WcxbQ0ynkQnl8O/pZB25FXYOyETa6WRjk6wPUUxuOHdzWVvD6ucYkIKMuXfJva0fCtBdE1/XjtLjcPoKmWolhAYosKtsV7pxGfwp7WBoKLVltpX2fI89N8WMPlN5d0Ux352EhdcmGoIeeKHCtMmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395741; c=relaxed/simple;
	bh=ecV+Oyo2l55T+lgG4gHLU7xjXVBi1+Yif2LgyDcmDxw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=OQC/bhrndU0dID0mODGTiZJr/SHvmmhjGISN15rVbQHEp7hrjE+bREddWYr4Fk6NRHuCnLnXUDZFyrFW8qrUjXpBy7Ip/pJHJZ9EBHWF1+2RAJjuauq4ONkGW2M3lhqFzI7eJNrzrMVkG4Bn++DFsr4znVNpoLvuYXEVEdTG65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=HtrmE6xM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso1665249b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1716395739; x=1717000539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqGp54J8ESCUs+m4e0ISGDjXBHl6d8o9SoEATv+WGEw=;
        b=HtrmE6xMZTdFEhKgt13YIQEDrqCI4ETA+mjN5Zapn5pq8wH5H/bTFaH4dEZ1vgAdxq
         CKNgUjZg0rFvTd1D5hpKDQhBF4OtHTmUfuGQb5hxa72Y1gKFGCwtL3IsJ/UOO1At5J3n
         VSNKPScxudu36ZAMKQdJH+yuQzzRb0OxvcSFEzsgxcr1i8t/Xd3JTxghdlwb1IjJLIF9
         rUVIt9sjaLUq8QdGO+Hbv0eqxNOisT1unXxBkmSi1WRN7y27Y9mOJCUZYPHC9I9xIruW
         F1VxBtsdn1H0RwoNz+hpHDR+jldkP8oAalp+tkpE+OVcM9p+qsUztnZJZkDn+ut/WIfm
         qeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395739; x=1717000539;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqGp54J8ESCUs+m4e0ISGDjXBHl6d8o9SoEATv+WGEw=;
        b=kL60PogiYodeJaLJVaOhiXPVEiL7Ljy+2xU8IFHXibMKLZEgQsCoaIPV/sOkRx5MDd
         V3qlB6wvW+x04vGOvX9qrePxlvfAOxu9K0ha2JhnwypAfwYnC0P3VH3NpaPzpd4CtQpu
         s+j35Vvc74lH6PdZyH63ucj5ZrKn78IdyPLIl9Y4NQpHyyNCRJKeKsbkxoyaTJXmc5Au
         LrW4PAF1Q/+dXrY/ZaTkiEtWXkDgXYKV6rxQrs5ZPxEoZBI3C+0xHDWO6ZytUd0fmltw
         HxA+pBG1MFEvY/dHFIo2V1g+4zC4XDvHDKx2veye/i7bSUKzZItHtqWnGR74/NUrt27y
         B81Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLpUAresBq9F+H6MRxbsb2IATdJRqsn1VKSfrREhGhf+3L2VXhuYNwxbX9smuOvZEPDDwASAw/VgRPmWC8ZGQw8nrp
X-Gm-Message-State: AOJu0Yz8SokXJAgaVscY5vjvRwtBgptKxr4mQ9igZNFh7bHt+sQdXMCS
	ev2iUSMgg2m7fareo7FwiLKhuhEYibZ2ZkweUQ5o7GB4bP+t7aRS63Z9g18mGEU=
X-Google-Smtp-Source: AGHT+IHNg4G/+FrYZDK16ARdepdZLQp6DOCEY9we0rv5z5/42V7Fb/cT4nWy7dXR6Rb1X80XjYbanA==
X-Received: by 2002:a05:6a00:4f8b:b0:6f3:ef3d:60eb with SMTP id d2e1a72fcca58-6f6d62200f1mr2432509b3a.34.1716395738743;
        Wed, 22 May 2024 09:35:38 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a82896sm22664747b3a.69.2024.05.22.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:35:38 -0700 (PDT)
Date: Wed, 22 May 2024 09:35:38 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2024 09:35:36 PDT (-0700)
Subject:     Re: [PATCH v2 0/7] riscv: Various text patching improvements
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
CC: Bjorn Topel <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, samuel.holland@sifive.com, Ard Biesheuvel <ardb@kernel.org>,
  daniel@iogearbox.net, jbaron@akamai.com, jpoimboe@kernel.org, peterz@infradead.org,
  rostedt@goodmis.org, bpf@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-0ba9a35d-4bf6-4331-9c58-67305b5b56ad@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 27 Mar 2024 09:04:39 PDT (-0700), samuel.holland@sifive.com wrote:
> Here are a few changes to minimize calls to stop_machine() and
> flush_icache_*() in the various text patching functions, as well as
> to simplify the code.
>
> This series is based on "[PATCH v3 0/2] riscv: fix patching with IPI"[1].
>
> [1]: https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/
>
> Changes in v2:
>  - Remove unnecessary line wrapping
>  - Further simplify patch_insn_set()/patch_insn_write() loop conditions
>  - Use min() instead of min_t() since both sides are unsigned long
>
> Samuel Holland (7):
>   riscv: jump_label: Batch icache maintenance
>   riscv: jump_label: Simplify assembly syntax
>   riscv: kprobes: Use patch_text_nosync() for insn slots
>   riscv: Simplify text patching loops
>   riscv: Pass patch_text() the length in bytes
>   riscv: Use offset_in_page() in text patching functions
>   riscv: Remove extra variable in patch_text_nosync()
>
>  arch/riscv/include/asm/jump_label.h |  4 +-
>  arch/riscv/include/asm/patch.h      |  2 +-
>  arch/riscv/kernel/jump_label.c      | 16 +++++--
>  arch/riscv/kernel/patch.c           | 69 ++++++++++++++---------------
>  arch/riscv/kernel/probes/kprobes.c  | 19 ++++----
>  arch/riscv/net/bpf_jit_comp64.c     |  7 +--
>  6 files changed, 63 insertions(+), 54 deletions(-)

I don't have any issues with this, but given that we've run into some 
possible text patching bug with this ftrace thing I'm just going to hold 
off until 6.11 for these.  Maybe that's a bit too conservative, but with 
the bug only manifesting on HW it might be tough to sort out.

