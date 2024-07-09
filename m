Return-Path: <bpf+bounces-34217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBB92B451
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085891F228AA
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036B155398;
	Tue,  9 Jul 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bugpNe+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1C1552FC
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518493; cv=none; b=RJAulbWoNEOdgGaIzMdEYdCTsr0Q7FdWJwP9MCKWoI32mIevykW7VNOYp1SKMZIsN+xqDLQUrjDx2K6ycnO27SVjQe+tSFpe7ALDyCWF3BZgU5EV5XLRSt8JNAWxgcZ8vt2xJedF1yF/mYYgy3TTooSnV2xMsnJeU16iOmB2fXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518493; c=relaxed/simple;
	bh=AWTB0NTTqgILlhQ6Z7xHF3dR8DuumJxzh5Lw6GO6YSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyZQyqoi4TdEZjz1z7td1NupXNcApDnS0HxDf5qbUP5y/J3iUdwf4Ej8WKvDb8+E/xAj4/XayRUOqb33aYMQi8Dv2SQ6bd9S+OBx8brvWTU97Oz5hDZddOrbvqA+mwnAHNHxmSAPliVOAo5spoV+11UzYAD49JFThqnz/0BKmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bugpNe+M; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso286120866b.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720518489; x=1721123289; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWTB0NTTqgILlhQ6Z7xHF3dR8DuumJxzh5Lw6GO6YSs=;
        b=bugpNe+MmG7kZbNAyxO5UEFxvVRJAzMFrIAFpsauxU4z+PKAoKkILHVDdHfcbtpJHr
         +aHZKwZleyNwJh1tVsS6NygJ+zZw8Lki+cs66A5IzAnwCWK13e/OWL73JqETCtW/h0Iv
         wPZqu5xwVXLvz3ZVDxNTtyrftpokS0Ut71xph3wfGa/rvXD3anx5/sX/wRkT72htGpDf
         MsWuP0OJGUpHFKia30QERD+9FGfMb6v9ufpNHW1V7HVxMpJ3QpThC0LndAFEuIsNThHd
         UK28qmCsj2VgAHhadptI6KQlxTSFa5IsQuwixArURv3gDjrkJg/zZXki2HCZN3riT6iW
         2h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518489; x=1721123289;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWTB0NTTqgILlhQ6Z7xHF3dR8DuumJxzh5Lw6GO6YSs=;
        b=b6J9oimcPCiiyrXR45IevlDNi/qHmuWabWlP5lhdQosAmAO5X17ZRRVxZwBwp3/cu4
         ZzSPES3X5fcdzkg+1Dk4m5rgU/kfuYcog/7OEBYa5CNc6nEj65L8Hie4v9ENgJ2hJtux
         GvQUNXAqx+tLRx6UFpvxBllS6diE5poEyOAtaCvauG4ihvR7TMa/XW0zjCFSN0QOTb97
         bNXvsXyJ9ddLb20tJnGcQqo7gO7zljYRBiPDH2pjV1nvpBqObsq4IYoDzrk/vprVJGj2
         Kri8ff3kfIhT3iOoeQYEYOYHV5vQYpBBCaI8zEFrbuJ82p2BJ8Xv3Tqdr5oXUlgEGCoo
         6BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyDROWUzm1/aViZDOQg/0qhnv50Sw1GZJkf6gH4FMEZPdaQP8PZujn6JYqxa1DlMALO4rcO9IMBpUXqhssPhY1IkgW
X-Gm-Message-State: AOJu0Yw14dPlm+Bd2aEB6ujhCspNFKij0l3ihAk86VeryXS+C49HyQWI
	3Yi52OMA+jh5ACjnV5dMssagSKFNxLnG1WdfTP/tL7f5urKSpd7INXuUT3BMNfU=
X-Google-Smtp-Source: AGHT+IEJ+FytStfsmRY6vrNbbjD+0EypVJPktrXamer74I0z4NRBlrliFzWC55kPLPAmr4G2ukk7Yg==
X-Received: by 2002:a17:906:4ed6:b0:a77:c199:9cfc with SMTP id a640c23a62f3a-a780b8856e6mr105170366b.57.1720518489244;
        Tue, 09 Jul 2024 02:48:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff379sm63180066b.114.2024.07.09.02.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:48:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 1/4] af_unix: Disable MSG_OOB handling for
 sockets in sockmap/sockhash
In-Reply-To: <20240707222842.4119416-2-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 7 Jul 2024 23:28:22 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-2-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 11:48:07 +0200
Message-ID: <874j8yoq08.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> with an `oob_skb` pointer. BPF redirecting does not account for that: when
> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> results in a single skb that may be accessed from two different sockets.
>
> Take the easy way out: silently drop MSG_OOB data targeting any socket that
> is in a sockmap or a sockhash. Note that such silent drop is akin to the
> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>
> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

