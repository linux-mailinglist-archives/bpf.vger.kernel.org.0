Return-Path: <bpf+bounces-62105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49627AF13FD
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C413ACEEB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC9265CB6;
	Wed,  2 Jul 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fIanRNpS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2B1D516A
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456213; cv=none; b=oNFyHXHQUqQwODtVxz8ljVEgNAwvMX9m7TsddZK+Kt5NbgnTgnYUyoTBrsMoQ5oClncWU6gdGTL2IcvSexj7yLXj6fVeA3aPJlK5m6kn9mfEJZTrp69cd5ucFDuqIbFZkhBSlc2Y08embuQ+8jLkX7x4B1I9z4RvR1qS8hRMu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456213; c=relaxed/simple;
	bh=KGNep1+RUx9vozt8bjGWN3hHR3Jz1TATF1bPV+kzZg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojvWB43HN3VcB78Vchwg460ZMzy858ZzbSInuy/C/D/D5HDQLPgbtnVUDpPdIHnXUdIlV7b31JRa4G9aj+e4GMd2yiT7RlxgWw/U+odzKCd777KFH82U7DwhwwlWRxYN6/XXSiS7un0ayZ9CVEanUQtjAvQYszXJJOEJmMSqPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fIanRNpS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so7280682a12.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751456209; x=1752061009; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGNep1+RUx9vozt8bjGWN3hHR3Jz1TATF1bPV+kzZg8=;
        b=fIanRNpSo/FRmvqNYN5xYispHy2kSBGXDr+juqav8h3ABwKglbxBfERtIS0ztLq48O
         3Wqm/pT41QCtz1yR+Dui3mybwNanND639bdvtIzvBGMBdZBS9hq1daP3rUh78t9745SS
         b/VGlgTfPIFa8aauN0sBi/0h09xM9SRtRKcLUi/WoDty6/tFOOxwh+BPIEAYFpqx/geQ
         53Y6gZRqXIyFf8oydo2nDdTAad9M6pT3sxUadYYPlFgWpwtKv0N+cbair0GVoTbi3LqS
         QhQVMTD57OoReKyKyhl6FmCYpWH9YKCs0+nZ50qTBnd9rZm7fcaQs+Q4K+NHqqUsludx
         Cq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456209; x=1752061009;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGNep1+RUx9vozt8bjGWN3hHR3Jz1TATF1bPV+kzZg8=;
        b=fpi1gzeofl5WfLdx/z1qZnJjNg2cQGfPQmLb15WMAb8diigfUaLX6+W51MZRBm0GWR
         1iovuz9NXY9cvRpF5yuqgSOl1gIJVhHnsh+XO/ckazlqF3Br9GpEzJ362wVHVccIDaqc
         Gfou1Lzdg9C+2q9hsry/mfDGxnWVrgAloikiVD7d5TpMLrHxir6DbeZ/T8dktHpH/SMx
         V7gSla1mTimDlGYZjZ+LQzCfK1eUmAq2ARldIX/31ZIZ8Hp3FnUSHu6XTmhE+8N19tkF
         0HX4fvvnCIDP5UZAC2E6V/519QUbjux4JBXiYcR/mlvEww7D4z4USoOF96SLj/MB+4VD
         J6CA==
X-Forwarded-Encrypted: i=1; AJvYcCVhapgLoK/TdYBhhe2rNznllBBUR9I5rQdxnk5Igy8Sit8Y0FeBZ9O8TQUaMAuCI5lqD8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsnx7kL2OEoFj88m/geWs2kXOjHb31uDY+TsETx1JEb1tE4KT
	YOVS7ltLj543pFfYVDkFcww5KAc7bnoBF2D/XYa6VgssIzOKbvRqrPnf/LtQlo/XaTA=
X-Gm-Gg: ASbGncuNNfNZNDewOfyJPXNJhBFV0DsqiVxZRntYtQjVb1zpxmdeXRnw6JiObKPMDnY
	EFB0TucSY1sNbDsjrJOPpUjTcPhavtC01qCLyvOoyJzGwfZnLnGA0YkzmQPYBTCmramUkPO1e7b
	ZaxoBSHf/1XnyiCAe0jHWgL8ABe15uLiVXoXo/j0M11ueUff44AGvAfErSa5inApDrjfo9SEzOJ
	blAmD28pPmQrv01FsZ9m89aVLG6YOqrXFx1AQ5lSztw0nHBWTs544dZc1HnxCaSyqyEMRBA0pxJ
	Vw0qN8mMEkM5XbgnbYeC52EYJ56JdNfecH640QQd9//lPn1zwRDhviXvpD2UpfxrzA==
X-Google-Smtp-Source: AGHT+IHha9b9xQ/A0ZcnIav5AFmtDOwh7taBOwBfjUd88sadR4tukByoygPXpa/pAA2HMb1DNgXPSg==
X-Received: by 2002:a17:907:2d2a:b0:ae0:afb7:6060 with SMTP id a640c23a62f3a-ae3c2a960aamr279933266b.19.1751456209508;
        Wed, 02 Jul 2025 04:36:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01375sm1072556466b.107.2025.07.02.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:36:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 2/4] skmsg: implement slab allocator cache
 for sk_msg
In-Reply-To: <20250701011201.235392-3-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:59 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-3-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 13:36:47 +0200
Message-ID: <87ms9mn7sg.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> Optimizing redirect ingress performance requires frequent allocation and
> deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
> sk_msg to reduce memory allocation overhead and improve performance.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

skb ref management looks all right. Meaning I see no double release.

sk_msg_free clears the msg->skb field.

While sk_psock_skb_ingress_enqueue sets msg->skb only when it succeeds.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

