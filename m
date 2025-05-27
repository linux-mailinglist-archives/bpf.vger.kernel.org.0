Return-Path: <bpf+bounces-59003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299FEAC5326
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90A317312D
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44027EC76;
	Tue, 27 May 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnwbPPHQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0319E7F9
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363985; cv=none; b=AyevHnW0NY1U9TAZRVsI16VQeK++TcDpn2OMJYVdE6dEaib0SMXMpNRZMD8pndQoJwgJhCRQup/55DxP/pC/5DUvN3ANGL0mERMzUpNC25DJ7Pmwx6hVNgrATQEGv3hALVQUPWc9r/XyGCriu8QroqLhxL/JazWIGwtWzdB39RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363985; c=relaxed/simple;
	bh=E0BdDRP6yU2RXEf6SgUyFg06z2p9YqrKsxboYfgvFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKqzNlPPPeDsEkmuPiP77tkqeR2nCjr1f3Fb2oEJMPlWK1CwlREzkU/B4XnHufciWQ/c/W/Vp5V2cKNCQPNVIdA0q+C+ldBnt4IVVB0ZE8qXWa0U1Q1XpLXrCYZ6q9W1xo5zdWFPaPOk5C5vkd+o+xT/6rCPDsTdErX7CdxsqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnwbPPHQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c27df0daso2644283b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748363981; x=1748968781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH6y+qCFFa9gn1a67aAD+6Pqmp1vhecyqwdx3gild68=;
        b=HnwbPPHQR41Ksj+NM2sSqimYcNpjVpeuUI2x/QBLmXoNWIqa+avki4LmxCCX/fxfig
         V1IFPZXZ+9+vZh49aUh4K9O4Yy5e8aLm/cSdNT4F8LHH2u4d6zi1cZBIs4zLS9cd+e0K
         Idd9LwG4MTvFMIvbU3yP6iesH64MPJSH6z75msJJF/gbtUpn/q1adjwiyRHD9/eCbzX8
         8FFmJLTCDNjl+87/bMxxlFP24PXvp59hK34aCG55DLUzMvWDRT1aLZT3yBke4IhjdTVe
         TBvV6MnjoCl8ml1Ckq8f/6KpbRpMWquIbqt3itk+MvK7hOdhXjaOC+Kbys+Msfg7/gLj
         8ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363981; x=1748968781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH6y+qCFFa9gn1a67aAD+6Pqmp1vhecyqwdx3gild68=;
        b=blxllYBEcF9cJi0Je1wp2VGy8coMYuRn4Wr+0CyOKTXMEdOjaauy1FE3Hct8FcirZf
         VaVmsNa5jfFkgXzKCGQComJHdksofmwi3qFT1QjgJj2ucCs58eCxsKGNYTiQaCWFPlkV
         jKN1YlApc0c4nCjdHZdv8Ej9oIsJ1dQMKQ63LzyKYP8Oz6st8aEN2rmZEJkRIw4VDbh2
         TwVXKIRQKOj7oJ0bCDAidzZZjlui7K9ogGlq0tJlJ3jprFHkFYhyEAWyo7FAn6FA8fZz
         u6mRzZsvu1yOjs5kauH6zo1pOtZ72aFoMZW0f8mis1NOX1wB/1O2NZalqOtiMFkYsvx8
         3rKA==
X-Forwarded-Encrypted: i=1; AJvYcCVVynMBByI08CXZwT9+IPELNIofqmGqVZck+ODvwSuVq/bQgqZ+FO9OYJNb49TpKwv2eOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEmMbX2sGQM7wywsoTIQLx9lKZmx+5wjUxsx2O7yJ7w4e2iKG
	vH4WCYYK8ebQI8CBHC4dqs51AxmMu8f0rKhiLMhRsGnvahxUDsU5piMlQehXeLXQ+jRyQjkRq3T
	DaxvqQt1943/s12zVHHyohAJXUsvWPho=
X-Gm-Gg: ASbGncuVb2GziO4dsVQF1HlPecUFYMqiz6EnXCS0XC0WNzbjtw0ei6WSKhuvZeKWluF
	8goag966U8gHuZ18avP7TLKx1RFqOuv3v1wWw7IHJ7RXK9Yh4zg5g9LOVexruiQHLK4OpktrYMD
	ERsqqQWpRtJo62hWYNIES0/qImqixAe8OtL4MsPPmzzP48oe2q
X-Google-Smtp-Source: AGHT+IFwIHuShfr44tUqswOt0BhtexoVKFXqLY5W+BXFPQl1EpjDcyBeJ/9unXIq/uNDnG/QNv1mOk7qDjXc3n//NGo=
X-Received: by 2002:a05:6a00:2d1b:b0:740:4095:4d07 with SMTP id
 d2e1a72fcca58-745fdf4aabcmr22125276b3a.12.1748363981108; Tue, 27 May 2025
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527083729.285734-1-yangfeng59949@163.com>
In-Reply-To: <20250527083729.285734-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 09:39:27 -0700
X-Gm-Features: AX0GCFtDP2126GwDL2szjbCrAMiTA8Rj7XlXFEkTQneH3m1cUtyQzHDZrnijX_o
Message-ID: <CAEf4BzaNbLF7DEZvtm6Sg4hmQEqnGsxrYgZKvss1baA-sUHJyA@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in task_cls_state
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:38=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> syzbot found the following issue on https://lore.kernel.org/all/683428c7.=
a70a0220.29d4a0.0800.GAE@google.com/
>
> Related source code:
> BPF_CALL_0(bpf_get_cgroup_classid_curr)
> {
>         return __task_get_classid(current);
> }
>
> const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto =3D {
>         .func           =3D bpf_get_cgroup_classid_curr,
>         .gpl_only       =3D false,
>         .ret_type       =3D RET_INTEGER,
> };
>
> static inline u32 __task_get_classid(struct task_struct *task)
> {
>         return task_cls_state(task)->classid;
> }
>
> struct cgroup_cls_state *task_cls_state(struct task_struct *p)
> {
>         return css_cls_state(task_css_check(p, net_cls_cgrp_id,
>                                             rcu_read_lock_bh_held()));
> }
>
>
> So, do I need to move bpf_get_cgroup_classid_curr_proto back from bpf_bas=
e_func_proto, or is there a better solution?

I'd try to fix that rcu_read_lock_bh_held() check. Can we use
rcu_read_lock_any_held() instead?

>

