Return-Path: <bpf+bounces-62561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B711AFBD5D
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38BF1894162
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC0287254;
	Mon,  7 Jul 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7mUMP3i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B751B4236
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923197; cv=none; b=RQ3bFv613/sj0Ufnl7RN3Iw7ClfJqk+yIgil6DK1dvTYN6nDWpvdkv9su/Q3lwdaXbQdNJVyX3QXs74gO0xdfgLFST2RvNiASPKMv+ZpvjtguaqkIC3nWmcyu6OotfFVNJwb0q5nn7TOI0cn2tr+EBiPhsHaaGVRvGO8ZOBsLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923197; c=relaxed/simple;
	bh=3a5jAiTp8yS6qb/i34pbOlQ3gaBo9s+omrxiO7fH0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcsWX7M8gQ03dwVqGs0AWLinp6kUD1rPXOLR1pKApQsazavO+N36qff9Ss/3DEedqCOytoXkgte+Iu3qAWzZStIg7C2qca5mLuVy2KaPCeEbURfK2FR+YsAtGRAbkXY9ftaGRfDznpPBIbeWaCyvEvwJPIXALJQ6Nw4TEeHLUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7mUMP3i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d6ade159so31720965e9.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751923194; x=1752527994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a5jAiTp8yS6qb/i34pbOlQ3gaBo9s+omrxiO7fH0zM=;
        b=L7mUMP3io57jYG7QcDEAzWWy3qoRqwHovmgS3m6bKOV+Nyb1yAnlX6puYIX1pfwogE
         DB3+p+3dWHD9IgmIwLtcYINZ8ACeSQfXw+Glb5JO7fl7lr1siKz3+8qRuqm9JH3CEIVb
         r0/kM533CfnNKDd3f9q2g7+O9WawyirY4ldcm3kprsCdCzwj+rEoqGd1K2/oCAyqwmKS
         pP5XBZHWwdOlwmzXX+YSjVJEog98enwWN1dN5izm4c+UpA786dH5YP1CtwMzvs6gRWxP
         yg2jL/5CD4P2GMWrr3W7htkWDnyYE/CdlxvOeWkdMD3B10poMafsB8tH61UZJEpagDw/
         rtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751923194; x=1752527994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a5jAiTp8yS6qb/i34pbOlQ3gaBo9s+omrxiO7fH0zM=;
        b=XHM6pjER815fMYUZzYJuPSvuZcvoC0K4XFbNdv1uTGPMB7KPz+zgDzcMT2lOf1BEzx
         CywiC6keNhnvMwN4nXlwy5IoBOBieugEM1U6pkbYkECtsPEjBefjBVKwr8AS+gTIGFMB
         2gAu98WGVLeiYO3mo91H6ElZJsjZD48JkFqHwyZRPQHvNenvwOX1vfWXT+0LeOT6UQCq
         AJUoPG0MpD0UamNTJEwcqgA+meixFAD3SOI0PrEEwVX4L0dXSYRf+/7j7TnriLUfWJ84
         PZeI94pLHLY2G+tO1QxPVDurU84RWuMI6ejL4UUkeybwGiOHwT8HzWekOT7Ma3hlLZor
         Er3g==
X-Forwarded-Encrypted: i=1; AJvYcCWtmtoQX8DsmNdY8vHnaCqgxBvhyGc+Lhk1d8OmhD4epbSO/P7umzXepqMsq6j/P7ZHr9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmQVFQBZj0ZBgz91hfwNIvOULA9kvL1sv6yfar0GA0O9Fvdly
	vDlAMF8Zq7P6Yd03cCHypm8AWWZ7Ls9bRoir6RGhaiPCq+BTfRQkj0nz7RvLrIBrJWleHlgVgRP
	5Fv0uAFKsrTy3Y0rgSF06s9GaNAirez4=
X-Gm-Gg: ASbGncvGJkaQlGJsIfGyhbFSyR4BFMo93SHTJKaBRivWk05/tKP5fY21V7p5ndxWytJ
	OLuB1gQaQ4C32XBAhfBcPgUUmLyMq/Ybo7iqs6DgnIvdkpWLS58PMGMkQMQ/MnOz39BhVVBhWDg
	pqHBF9myVIgNDVzjiH8TLJDCITzPBj4xq7gBpxYp1Jj0KKBAtwpo9cHMG58EzI9yY8+CnkulbP0
	yAb4hEfeKo=
X-Google-Smtp-Source: AGHT+IHmBjdT+TyJl1Z4uG1LaK68AKIjYSJ87o+AZQnF6g1t4St/+UVfEOU0qXT27fRRBNX3+y9IAO6cJRtXDZnR6Io=
X-Received: by 2002:a05:600c:3481:b0:43d:97ea:2f4 with SMTP id
 5b1f17b1804b1-454b4e74760mr120508425e9.12.1751923194073; Mon, 07 Jul 2025
 14:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
In-Reply-To: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 14:19:42 -0700
X-Gm-Features: Ac12FXwkbtJpTnlD03RYRJKhfYNd1XfPUlRUvE3q_4M-kqNyJFjxC0d4hayXDe4
Message-ID: <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com>
Subject: Re: Potential BPF Arena Security Vulnerability, Possible Memory
 Access and Overflow Issues
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "ast@kernel.org" <ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 1:44=E2=80=AFPM Yifei Liu <yifei.l.liu@oracle.com> w=
rote:
>
> Hi Alexei,
>
> I recently noticed that the verifier_arena_large selftest would fail on t=
he overflow and underflow section for 64k page size kernels. After a deeper=
 investigation, the similar issue is also reproducible on 4k page size over=
 both x86 and aarch64 platforms.
>
> The root reason of this failure looks to be a failed or missing check of =
the pointer upper 32-bit from the user space. User space could access the a=
rena space value even the pointer is not in the assigned user space pointer=
 range. For example, if the user_vm_start is 7f7d26200000 and arena size is=
 4G (end upper bound is 7f7e26200000), when I set *(7f7e26200000 - 65536) =
=3D 20, I could also get the value of (7f7d26200000 - 65536) as 20. It shou=
ld be 0 if that is out of the range.
>
> Could you please take a look at this issue? Or could you please point me =
where is the place doing the address translation and I could try to provide=
 a patch for this?
>
> Thank you very much.
> Yifei
>
> Methods on reproduce:
> 1. Use a 64k page size arm based kernel and run verifier_arena_large self=
test, it would failed on return 12 and 13. Or

Are you sure you're running the latest kernel ?
This sounds like issue fixed in commit 517e8a7835e8 ("bpf: Fix
softlockup in arena_map_free on 64k page kernel")

In general this is not a security vulnerability in any way.
32-bit wraparound is there by design.

