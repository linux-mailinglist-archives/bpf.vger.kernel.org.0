Return-Path: <bpf+bounces-69646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59134B9CD1F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C17A1660B4
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171B4400;
	Thu, 25 Sep 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+s0zJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D62610D
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758899; cv=none; b=e7EeLFMlZG/SQTeCnYvw9bA3Da2c/gMZGnOBbx1mc1KmEl7duA6D8KSnIQZ088tsSk3f+nORXvN6xWl7yidMXRheOF+9clKupKr7FDt1w/hVdusYGedfPunmgQuj95gyR366ZNyw4A4W7mc/EmG/M8127s56uiIcM4p4ilgiMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758899; c=relaxed/simple;
	bh=1j0WLj1QF4gS669f14k180su/X7X1j6huC+rxtu6YYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp/bjCauVhyvdWbaCvOde+LparwsOlYNZRs2eshG3IszH6Nb28C/+mYxW6czzvGt8D2FG+JMm/1dgVPt79uEyLeSR8WpHniyq+qMyHGHezvrPZM7ve3GB/9LWXV5EVt+lxibS4LRcPmdFVdwhJ7B03XQ8+eajUM+G7LQC94kXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+s0zJZ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5bdbe191bso350608276.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758758896; x=1759363696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDdXAgTmaSeAT4Oi3BmR6CFI1klm1bLgue8UYADMbgM=;
        b=mR+s0zJZfQwq5KcDAkwUfIutVZRxe5mAD56xbd0sxG4PKh238tzVx+06Ra8aAN4otc
         k1nESGE/RuJNnADRRY+e/BcA0Qf2bVCZli/SRNw6RTH7Qgq6Yfd7tTP4KyD8Pj/iTukp
         6xE8DPTZR8FvedIQvpFYB2jrOII39giVXbRt/gDYs/TS3O7VNMdbiwCQKhYgBQemkLQD
         tFxN+y7AIUAzDvR9rJBbRaHv01dW2Sqmrms/i1hSDjIMjXVEwp531SP/m/7HkK3r7jEN
         DrgphYT83C0jo95RXNkxDiAr6LLatnJVGl4C/W2cbx0zKrNnzi29hukoTlnNHXyPjzcB
         4ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758896; x=1759363696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDdXAgTmaSeAT4Oi3BmR6CFI1klm1bLgue8UYADMbgM=;
        b=VVvZwosevxarunjQ+HDMvU6v3CY1fg0S2RiaroLM3Rt6EDA91kkOYrWig5dWDFvECi
         jJTUMeYWGmz5ruaL9FhcSV3G46FFtnfLZF3SbkYoTYdQ73W7xDBCR8qQdhdy7X6Wkssp
         uFKu93HeYGv3ToGfQWydatIoOFwthJKRvdcCBsZNVRXPc04LPNqX5Y3mKodATL0kiaZo
         ygrUDom0IqUdSN2KasNn8ZUfSCLgCKhdMPg4XJ1TjunVQVLJSOp7fI9SIXBuzFmenybk
         yjAN/OhIUCZ4hTurN2+ok2OLDJGCS0+obTst+JvQMPKent7LylfiJ5MdHJa1iE3OoUwZ
         NNVw==
X-Gm-Message-State: AOJu0YwMdeNKHKdALslJRhmAm7KOUPvo+HYxLWEouhxCgifgV6nI9Bnq
	yeCHmdEKGvriiW85BAgxHhH7tpKJQezfGeSyJX1Pns5dZKRGHg8IiD06Z7/PDuEG4I9ljS8X5rQ
	DoGb88ZRaPr/TVb8hDYkxmvFZHyliqgc=
X-Gm-Gg: ASbGncv7+ZggaBPoDpj8iC8pkTG3rhshQg+J4m/HBNcRzzEe5HlBbSLGeDDX4yHjhYR
	VFgWwK0f2oCXLnkfZg21WPIyMN3Pdlls2/Pg+zp1h0O0SjgnLOiLUGLBCXR4RoO2TeSGbBEhLKs
	n/AYxpBRFeukoYIqm8Zp9K6h+2etTg6/2bgieyzDpxJsE/0i3jq9rzWvFQJYX9lE06d7PgsbTqH
	qtJV9fucy6rL4/W3NxfpXRzi0d7tE/0vLzMcCut
X-Google-Smtp-Source: AGHT+IH7u4UlUoQrCzp0iX/ZF2Xq7nDnA0PLfR7inNQ02Jb9AIa4sgs0pY86RONSHUEq03BTVpK3eA0hK7vOUzDcBhU=
X-Received: by 2002:a05:690c:8685:10b0:749:d874:e684 with SMTP id
 00721157ae682-763fddbf52fmr14878007b3.17.1758758895995; Wed, 24 Sep 2025
 17:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924232434.74761-1-dwindsor@gmail.com> <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV>
In-Reply-To: <20250924235518.GW39973@ZenIV>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Sep 2025 20:08:03 -0400
X-Gm-Features: AS18NWDpfeDX-uhYUa0rY5ZCQgxR8-I5TzkwtQoSoouaV71K4oxhB3DbDVwhUqE
Message-ID: <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	john.fastabend@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > Add six new BPF kfuncs that enable BPF LSM programs to safely interact
> > with dentry objects:
> >
> > - bpf_dget(): Acquire reference on dentry
> > - bpf_dput(): Release reference on dentry
> > - bpf_dget_parent(): Get referenced parent dentry
> > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > - bpf_file_dentry(): Get dentry from file
> > - bpf_file_vfsmount(): Get vfsmount from file
> >
> > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
>
> You have an interesting definition of safety.
>
> We are *NOT* letting random out-of-tree code play around with the
> lifetime rules for core objects.
>

File references are already exposed to bpf (bpf_get_task_exe_file,
bpf_put_file) with the same KF_ACQUIRE|KF_RELEASE semantics. These
follow the same pattern and are also LSM-only.

> Not happening, whatever usecase you might have in mind.  This is
> far too low-level to be exposed.
>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

