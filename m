Return-Path: <bpf+bounces-43007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896AD9ADACC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491D8284528
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1C1662E8;
	Thu, 24 Oct 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m05TVQnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB22C9A
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742796; cv=none; b=e7LLq3tAZREU5f3rzkkjIh84UHOkTaGfYN4zz7KLL7xfDUU8z4B5+wua4AoMGZpUHqK0w1ijMW4kMaEZcuh1yJGHodi38RfnPv5nAQk2qaGicY7Uh+DM6+PNMaKhm22cTcWOtuJu0xouo/zvQrTQOa1zx9v9xkaPfQes7Qlpcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742796; c=relaxed/simple;
	bh=Ubn3ADj/RK2pVpTJ7zGxfP69KJGaf84WXGePW5ic5Uc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DOm+dbhyRB/JuYD3yFBqjsU0plGXRAkssr1+pXSvKPLfSar+Vv5+xAojuBUEU9AMPKHkODrHa1veaVBsIKgt6AYeNMQyjqh8A8gYuKcPzBzcI/3hFotgP7c0VbekCzz0Q9X3KuXPkt7K4S+93d4oN/kkwg4XxW1iPvTntcKx22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m05TVQnl; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288a990b0abso303045fac.2
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729742793; x=1730347593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5k6XpXebzSXjEaPioIYzJzLGe1jtN4sNETS862RRe8=;
        b=m05TVQnlKiVbYkB/FPxUEF77xVTO1VmxxGc6lD9qZbx8Z3mV+iEz3k57Z1VaM5jEHb
         +3VMC6L6imK7PXeZqDJhZeISnKAP7NY41NfTkM3qZAKh6OV6rCfiD3B1gPsip8yr3Esn
         v0wYCLDvs9Q1lMSwSO/MDI6U5f2xp2R33YKqCBiif2rPPbyjxtSZipxwuy4JemGJFNtn
         u2ZDURxAuvnESILIb53cSrkU3h4uygr2DbWv9aaE3Fzmh9YY3m7PC0YQtwTZ3yOag2ob
         wfNrk+6X5NsR1yfHWp5JspxAnxNjd4sN5LKK9IlCJJBQ5ChRFkrl6Luqdvvb7rVKWzVu
         2hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729742793; x=1730347593;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5k6XpXebzSXjEaPioIYzJzLGe1jtN4sNETS862RRe8=;
        b=X0+Z2VVwkGztZddT3DEPxHH6KLsDjfAaVgLpOsEVfL1Qn/ZVVXGZ42BeDW7uANqx/Z
         5aTBaAFYGtVqEIuJ9HCCgTnwlLNMSkMl6POzg/LcH0kSN6wi7GEcKzdMPB/vA9bfYTrg
         LlIFaHY68jcoUgYQkMsIfpr7+Iv67ddDav6V9RbDhiuCLyXm6WwF/SvOiWP/xsxBOTXW
         lhx0O0gxJEG5E6C1Uxalxn1knpZDZOz0VgAys1CM3jzyX8FcH9k1jo9Yl3MHBQFBjDIP
         zuglRlNNcSVbqoZHdDSQXlQvcgIBRWynPpXbIJXT8ZjgVhqRhAkNiakwT1oQQdj2TLCN
         aXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhEiblXyuNiPfoy7joHzig0uWizlxLOb3ht/F4yheOnErhSRj2DkqGndR7QygGZP+axCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOOFlv9hHS2TSKAgg58rk11eNupUBApbZKHS2NY/+RD7GJouh
	slpq1mZRjqcdcauxumohffUdULgnUHJ4gVIH0akRZbxhz9N7o5Z7
X-Google-Smtp-Source: AGHT+IHaed8yti+2EPrmOZh8ASFqxwZkuPKor8k4HqZTPaSiNC7XnZ/prBgP0g645CMrOL6ow3QKHg==
X-Received: by 2002:a05:6870:a710:b0:287:b133:8aca with SMTP id 586e51a60fabf-28ced2df260mr515956fac.25.1729742793468;
        Wed, 23 Oct 2024 21:06:33 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab5862dsm7674502a12.51.2024.10.23.21.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:06:32 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:06:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <6719c7c847ddc_1cb22086f@john.notmuch>
In-Reply-To: <20241020110345.1468595-2-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-2-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 1/8] selftests/bpf: Add txmsg_pass to pull/push/pop in
 test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Add txmsg_pass to test_txmsg_pull/push/pop. If txmsg_pass is missing,
> tx_prog will be NULL, and no program will be attached to the sockmap.
> As a result, pull/push/pop are never invoked.
> 
> Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

