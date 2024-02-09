Return-Path: <bpf+bounces-21664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C628500B8
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF59B223B9
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3C38396;
	Fri,  9 Feb 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSRebGQq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0B36AF6
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521046; cv=none; b=Pz6i24oVDc7fMdUYafZAOKaUdHurNNHzQg6VmtC5CFXyCWcnHYbjjIQCr5F5+Qqvuu7Zu7E0U0xyyo46fZp6AckIZsuDfj1nLfKqKyk42VML1t/59mTHlSUPCyY7SmlrdcguhN7FRK7Y9162WJYhL7BytroqsnlZBvE9A786HWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521046; c=relaxed/simple;
	bh=c5zE0yxqxR08+Mm/PPwWjK0JByfP8Y2v2ui4eHrcsF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pr7UNwf3k7SEDuL12Zn7Pz8B4+XeQmjbczR63LfOW2Ip3drBJwMXjepFuXMwK2O27opeQyjZHkqA+bebKPKwxZ6JebcWlMzbaeaLsP8F/teaOv1ZK/yqGm/N8FqXc9gkQoYIik9axwYN4zJhxdD+jj9TM0qSw5Vl7RjywCmwADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSRebGQq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc748365ba9so2349835276.2
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707521043; x=1708125843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lv3WhtCp3RlZ01qXS0JKXvhCWMCb9bduUXvXOs579U=;
        b=pSRebGQqYSLfKJpEZIky2TCHhG5uJ7sMXBf9hPk/a2GL7n7LRwiKd4x8vbFL4dqF3p
         vVx4Gv1Nv4KO8YsvtgeACWSCTqlnuRcmbvoWanSSZwym28sIX3Q4Hti42Q6wwK66Of1v
         kmYi1ZWUqg1cS7pVbEY28OJLBAH9DrgzoiL5H3lDwGJGbWNQsPvDwR9Zja5Q04BRPas2
         QjZsYt1+WDfR0UjJhrQQlEAyVi8CFbJTR7ESZrWFr8Xd4+N63wATw9/igVSwUPgJHjjv
         yF/Mk4+vUHZCb+u/qynW0ITOaGA2b3DMvgKEObMPE3T6jVUF+64cXK0/9pBC2hdErsfo
         DA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707521043; x=1708125843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lv3WhtCp3RlZ01qXS0JKXvhCWMCb9bduUXvXOs579U=;
        b=qcIOeJH8KKs04NpOar9472JwYD82Zj3kXvVtHh6cqmubDpbIgC7yIoFhuqUCyCq3G4
         9l0RW3+YdcImbq238ojyrDOezXlVhGPudNdETKtbQS6ra658OwiLBPtDD8WXbQbqsbCn
         dMw5DZUOX2J+yzy35bTK4zzPPhY/QnvN/8XnmQEUC9fiW9K30tw0v/QTbYmCbvGcA0Sm
         WM+Ma0SQ2fcLdkrcxdJGdDkC+4UUZZHPamTEgD3sRbQyxMNk4Z2uzvd79n3IXmGeEbjj
         KRciJCAVPAI8Q8soJOaRnomY40InbGMNMOQqF0RRQVAFhMs0iAwG5d+XDktoDeXLrkJt
         Mjhw==
X-Gm-Message-State: AOJu0Yw2oeiAWHGmZ1pjLy6hX97fnZfXoChfxtEfRry87F8AlQcbcgDP
	nY0kG7ioXUFlZBcEAoPyT+PWbuI2QHn9VhLMxVmXBfOyQbIvrRjJnDVZtNC+MjoOiQ==
X-Google-Smtp-Source: AGHT+IHyj0jdPRVMx+eiHBoN9VKdkf2tZWqfv/4kcPHZrnh/4hFRQLTwihOYkN2Op5b0292/oT0YZhk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:2286:b0:dc6:d9eb:6422 with SMTP id
 dn6-20020a056902228600b00dc6d9eb6422mr17842ybb.10.1707521043492; Fri, 09 Feb
 2024 15:24:03 -0800 (PST)
Date: Fri, 9 Feb 2024 15:24:01 -0800
In-Reply-To: <adwssgplvtrgagjw5ftcc5ogpq2nz4pp722wzn3yt2jnql6odf@peiwrqaoyil2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adwssgplvtrgagjw5ftcc5ogpq2nz4pp722wzn3yt2jnql6odf@peiwrqaoyil2>
Message-ID: <Zca0EfI9ttXileU4@google.com>
Subject: Re: [PATCH v2] net: remove check in __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sinquersw@gmail.com
Content-Type: text/plain; charset="utf-8"

On 02/09, Oliver Crumrine wrote:
> Originally, this patch removed a redundant check in
> BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> and add the checks to the other macro that calls that function,
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> To sum it up, checking that the socket exists and that it is a full
> socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
> BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
> function they call, __cgroup_bpf_run_filter_skb.
> 
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> 
> v1->v2: Addressed feedback about where check should be removed.

Can you please repost with [PATCH bpf-next] subj? I think bot is having
problem applying your changes otherwise..

