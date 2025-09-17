Return-Path: <bpf+bounces-68593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E61B7C5DD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3848C1886113
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095F1F9F70;
	Wed, 17 Sep 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwDyVy0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898D3C38
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070787; cv=none; b=IsT63Ft0U/k0GiMxzes1Hrrt7glKhWeL3BsYElG6VnpftlO+yA8oHqCeJlnIuc2S5pwrK7IfJ+ie4fMIF4mDEem6szMH5Vy/8KosN4Se69ynR5GO0/pXyD4eJ3qL8j9V50QgAiMXvdkCBhy2oUD8+3TwIG4iOjuTXR3L0/4ZSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070787; c=relaxed/simple;
	bh=578fNF4CsNjHYyvcx01evbvCcBs3sC+fN25XuI50yTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMBmC7kPQ6ga1//ej5Z+93YfsPWtF+MKxn7ZMh9y9zvQOUgNt/zWgT8ZU8IUt58iuTbgRS60feBdyfjtm9yoDimiLBvrkXiuH791Weg/rHQ9gX9Z361J3oCBgYIcvoGfRhSjiqSJ2ufN4EZqhDjmqs7piMfFXGQFnokmqZufWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwDyVy0X; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f6b1fd718so1499773a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758070784; x=1758675584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=578fNF4CsNjHYyvcx01evbvCcBs3sC+fN25XuI50yTw=;
        b=JwDyVy0Xke7UGyJ9u9PAjQE8ZvVC0pElVochhKgEhFnxB4az+3k3LKEvXZ7FN/4Y4F
         eRGyuoa3Aj0N2UfvPg4H9MCAVqRSmjIbXpcybbLxz7R20keLknHG9e+GiHi6SGYO6chZ
         dMtuGcL34xIfLBgAXmJ8bsC8kngxWmJJZ0tQ4uwoBvjgGY/MlfifkuGcncjqWv5hKQpJ
         FwFkEP7+DRMLl+hdkDKn4WMLMJso3CCYfcmRD4IwQbvGDfQeWtOK80A/hliKFVfbRZYk
         mTDI4spPXiUZuPdNBnyVNnxWwaSm7yH5pIIrQZdzu0FvtasjOfkB/fzuvxQ8DrhiHTEB
         YNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758070784; x=1758675584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=578fNF4CsNjHYyvcx01evbvCcBs3sC+fN25XuI50yTw=;
        b=MtFC2upgVtMxmPe7eH6BEgIlL8szGm4Zfu7zEOXA9H8ITxHjw61m/5jZmPhqcvuRCT
         hmAY13E5bPi7pDDjxt20nXxiO7d72UENB+WQEcSosMO898FK6WoVFMHROGGFaJdn8hF1
         rKuUO/9GQzEW3mm0o0u66FtptXo+yWTiMGiaj3vhASqnoHDkIDR5uH/29Yj5ItI/wtnk
         OiEJ1q6WLQwq9mywLzUqUPCzVozFfSR/a2mNiiSYACqwRYn2BBfQ9A/12s2u4i2J8dl8
         BOFFoipyhPDiqx/t/l+kgwovX3otXYXPXOeG1YPoeL8vnJin/7oF8M0Z+EYmAqh9gwU6
         j1Jw==
X-Gm-Message-State: AOJu0YycoNoErNSXI+ASiOax4T1LHqbJz8WktNgTEhoW9tlQVIdRo6Ba
	G0rgFNCNJJXCtxlSQMk3Bozx9gWgJHBWxrXZeuwVPiwVN3Oe5H6ufogS8zYUvSe6/xhWma80bC0
	z8QHcz7wTMHFuH58OgN7IxhxAHBje4QU=
X-Gm-Gg: ASbGncuYIL1No4g9VwhSUk7OlfzVBv98ZW7Bwc+NbSiOHu/Cbss+JdZbKcZhAQcSdwz
	//N0+mu2gEBxQXdpEcjhHWCQr1nkwG5Omush9DZZMptSMNb3FH9X4Jcm/4G7w9IyK8YFcMTnR04
	qqWijFGyVppGdEuBktfI8UZinZOv2WNQ4T1C8wHeSL33vdQJkDimktck9iS+jEgTkwZEAho3LyJ
	4tLbIMikA==
X-Google-Smtp-Source: AGHT+IGx92fJkfWx+a4MPTm8O6B5penGwEvAMgdgBvSn0/uWZU7tVzg7ObLBGVFz6CrLDrvs2LOOy+VLHKVHHfsuAlI=
X-Received: by 2002:a05:6402:a0d8:b0:626:1fce:d2f2 with SMTP id
 4fb4d7f45d1cf-62f84029f09mr601041a12.16.1758070784172; Tue, 16 Sep 2025
 17:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916113622.19540-1-puranjay@kernel.org>
In-Reply-To: <20250916113622.19540-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 02:59:07 +0200
X-Gm-Features: AS18NWCJVEcgaG5oy7P9Mk2gStRbRsdZtQnzIwvpNlFkysyZUzRDxA9_BivJDi4
Message-ID: <CAP01T76tA3LpsLHQqtTfxA03n=wLVLACS2gs_BDm8MV7ph3X9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 13:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Currently, nested rcu critical sections are rejected by the verifier and
> rcu_lock state is managed by a boolean variable. Add support for nested
> rcu critical sections by make active_rcu_locks a counter similar to
> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>

Apart from other comments, we discussed this once offline as well, but
it makes sense to upgrade the rcu_read_lock selftest to be higher
fidelity and match the error strings instead of simply testing failure
to load (which can lead to false positives). The other missing cases
to test would be interaction with subprogs (both non-global and
global), to make sure sleepable / non-sleepable summarization is
working correctly.

The logic itself looks okay to me.

