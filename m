Return-Path: <bpf+bounces-14790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB27E81F6
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02973B20C0F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F039878;
	Fri, 10 Nov 2023 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="10sfZJRB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769C200D7
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 18:50:14 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E515E1E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 10:50:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc2a0c7c6cso24640735ad.1
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699642212; x=1700247012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bK6sSKTu/pLIHN9x3Pj9MvG4rIqlBQlhZxQGfOa3RTY=;
        b=10sfZJRBzh/F4AVoF0KtEFTheYta5nZBdYEoAHTySy87hD8tZwRtt5vBblJ/zMYa4g
         kCqWXeVk9/GXzWshT3rl33KfMEN2NlfA8GCbN5Km1gA3AgxOC4QZ20AGZeuR8KtLiIah
         RsdL6NGOu9CYqRfDoKmMA34oTZ8IQZwgyksCKj9l9kzCXScPylz7vu56TYK+CJl/FKFs
         7xq7AyF7i47h58AGT305QKeNe1GwBD2RGcLC08nZrT92ANP8luMRczU1NKhJuH+kXtjL
         JPifyQOnWVsElBhzxIrh0Jud3njsmaekZR2gIiLnWl67KF3OjDOXoTDHKvOBW2T1YyKN
         f6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699642212; x=1700247012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK6sSKTu/pLIHN9x3Pj9MvG4rIqlBQlhZxQGfOa3RTY=;
        b=wpaYzmnHuEX0SeU1F8ES3KWTd77ik+qSZCeWl16V1srw96Ytwy703cMadsuK/5EfMx
         JxihQCiDtI4bIWLr50ffQroswhgz44y5pn5q/1ZAPDOsUDaEljhbYJiZLGliGzBI5xvU
         fMkljfDh1QMvd/RSLqIpdckNqMae3PS0cRYdsQR27b/RMKi+RDpvieyuzN4gQmwb7X7A
         HelnC6jg9bk0OdXf3V9zkXJEfURJIxjDVcx7/93bObiGhcvOUHGe+TdSA3FCeI18yBjL
         7Q9Zj22fJGzqZ1DffXHJKSgGWK/UjelBqdXYBwxJ5D8CgCkrAfmctZgRPj/TGjv0NfFN
         WAlA==
X-Gm-Message-State: AOJu0YwzXYAwRukNub0e1EAos31j5HWkWzGxdILEh3/aDVkUR5kK3WZ+
	XMZlhF/X8HjfPsKDLqV9qEFsvvI=
X-Google-Smtp-Source: AGHT+IHy3clwTeVTXe4/lKnfxXSHaJNF0GV4aOjgdMgOiS5o8ICB+skpiG9AWGUmip13b41XFYINJ9o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8c84:b0:1cc:3ac9:717b with SMTP id
 t4-20020a1709028c8400b001cc3ac9717bmr29912plo.6.1699642212311; Fri, 10 Nov
 2023 10:50:12 -0800 (PST)
Date: Fri, 10 Nov 2023 10:50:10 -0800
In-Reply-To: <20231110161057.1943534-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110161057.1943534-1-andrii@kernel.org>
Message-ID: <ZU57YmTj7GDY3ogk@google.com>
Subject: Re: [PATCH bpf-next 0/8] BPF verifier log improvements
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"

On 11/10, Andrii Nakryiko wrote:
> This patch set moves a big chunk of verifier log related code from gigantic
> verifier.c file into more focused kernel/bpf/log.c. This is not essential to
> the rest of functionality in this patch set, so I can undo it, but it felt
> like it's good to start chipping away from 20K+ verifier.c whenever we can.
> 
> The main purpose of the patch set, though, is in improving verifier log
> further.
> 
> Patches #3-#4 start printing out register state even if that register is
> spilled into stack slot. Previously we'd get only spilled register type, but
> no additional information, like SCALAR_VALUE's ranges. Super limiting during
> debugging. For cases of register spills smaller than 8 bytes, we also print
> out STACK_MISC/STACK_ZERO/STACK_INVALID markers. This, among other things,
> will make it easier to write tests for these mixed spill/misc cases.
> 
> Patch #5 prints map name for PTR_TO_MAP_VALUE/PTR_TO_MAP_KEY/CONST_PTR_TO_MAP
> registers. In big production BPF programs, it's important to map assembly to
> actual map, and it's often non-trivial. Having map name helps.

[..]

> Patch #6 just removes visual noise in form of ubiquitous imm=0 and off=0. They
> are default values, omit them.

If you end up with another respin for some reason:
s/verifierl/verifier/
s/furthre/futher/

(in the commit description)

> Patch #7 is probably the most controversial, but it reworks how verifier log
> prints numbers. For small valued integers we use decimals, but for large ones
> we switch to hexadecimal. From personal experience this is a much more useful
> convention. We can tune what consitutes "small value", for now it's 16-bit
> range.

Not sure why not always print in hex, but no strong preference here.

> Patch #8 prints frame number for PTR_TO_CTX registers, if that frame is
> different from the "current" one. This removes ambiguity and confusion,
> especially in complicated cases with multiple subprogs passing around
> pointers.
> 
> Andrii Nakryiko (8):
>   bpf: move verbose_linfo() into kernel/bpf/log.c
>   bpf: move verifier state printing code to kernel/bpf/log.c
>   bpf: extract register state printing
>   bpf: print spilled register state in stack slot
>   bpf: emit map name in register state if applicable and available
>   bpf: omit default off=0 and imm=0 in register state log
>   bpf: smarter verifier log number printing logic
>   bpf: emit frameno for PTR_TO_STACK regs if it differs from current one

Acked-by: Stanislav Fomichev <sdf@google.com>

