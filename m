Return-Path: <bpf+bounces-27048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90018A83E0
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99511F24BAF
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233B13D60D;
	Wed, 17 Apr 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2WKLze0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690313C9BF
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359501; cv=none; b=KwILW6jT4Ia/7dxUM9Ud0ZgQWipBzWi3f92Rg2eG93mpVqy/7AW0iV8vmbTK0gCTPlpt70nDgsGEy8617rEtoiLzhO49690wdA1dONsja/E9r/u93QUjFw/4iaGLwfvfkD34FKUdD1PMHZb1rSo7+lvFq7VGsRgWjKuWwITjpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359501; c=relaxed/simple;
	bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9AdVCODmx5bvS8opGmuD9xfwy+Tdh1WUySE7c85/bao6A8KqClWH3DPhRdtl8HGudJaOS23MM93QtE49eEaX1YC2BkTQxhitJBy9P46gsSofEXWnaChpgNTT5CRSu/McLejJbsPT1VT5nc1u/0lSpZnf/4gI/nHj8rxcg3jqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2WKLze0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso13289a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713359498; x=1713964298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
        b=u2WKLze0KsX0YVOx0gg9XsSbKqAy9u04N6ERpw0W8+L1Ohuxp92uU7dCjpYRRnCteu
         /GZNQaWC49hWzX49LqeN9yCeT9xsyeRtfD2qmSpJin5NSnDogQsULhA3P3e16HqNDvDW
         TzyVP9wAY2Q+Ugg6LzFRPoERQnziNewDowtqoVb6aNF2YqHaSZELeTfKSLVRGemSPzZ6
         iJgEoOcI1VKNZy0hdduD4qwRsKaxyk7eYoghW5LB0/WMC5JXiOV52X86rpNm514JqsIu
         IF5h3Q0jZT0X1ob84Kd3fXolqZiXfXcRwEY5Z5bWAHmDO55BDt9zcMbENUuNvjeAotzI
         Bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359498; x=1713964298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
        b=CxeH/3wj3KaO6qUx2sJNKiSv3DpiHQgQmHxshU8qBcH34IABKI/P1d2kmHVFawO0aI
         ZoqofCqNXMcmVDxKjwTrWiwP2nNarC3ftnM6cL3LPPRKEGGcMVriIMfdOSHTOEiRo1+I
         v+XWFkX3K5c281wtxALvywx+fDcpYE7s+K+tL4F04oFKbhgreJrLqJbqOCAJTxltr68p
         fehoFlBFkyeCpb6/OjM582dhqry+qD9KKQPwuoRpn3JxPLNqbxTxI3Xv57j72Ffm/eMf
         V9oOhKRce+J4EXRKE2dmyq845fNlPHGSvnQwLrDN+ZWLGbvSHC6fdUWRsMOukZX/5X4F
         Fjsg==
X-Gm-Message-State: AOJu0YzNnBbh+BENb5X2dRt6gCn6w3qnr6IWBrzrZZYhl1+8vnqY+fw2
	Bm+b7TTE2vSIc6KPuYlwM/uYW439GS4NNfcwBaghmYAfKiapzNvMgyFPHSZtCLhk00Idf9rGyxW
	ACQ8N1xs3MOSowj7GfYZm2XlfEyZnUdGEk4Da
X-Google-Smtp-Source: AGHT+IGypSaqPmVW4Vt+ptnrzFfjZDefxB3JQBi1r8flFTPfvlkbsiJVAOcbLm1miOgRjzZRGxqzK0j1VbLpU+0lwUs=
X-Received: by 2002:a50:ee0c:0:b0:570:49c3:7d3e with SMTP id
 g12-20020a50ee0c000000b0057049c37d3emr152170eds.1.1713359497802; Wed, 17 Apr
 2024 06:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417124622.35333-1-lulie@linux.alibaba.com>
In-Reply-To: <20240417124622.35333-1-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 15:11:26 +0200
Message-ID: <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	laoar.shao@gmail.com, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:46=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
> program. Then we can get the retransmission efficiency by counting skbs
> w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
> updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

This might be a naive question, but how the bpf program know what is the me=
aning
of each bit ?

Are they exposed already, and how future changes in TCP stack could
break old bpf programs ?

#define TCPCB_SACKED_ACKED 0x01 /* SKB ACK'd by a SACK block */
#define TCPCB_SACKED_RETRANS 0x02 /* SKB retransmitted */
#define TCPCB_LOST 0x04 /* SKB is lost */
#define TCPCB_TAGBITS 0x07 /* All tag bits */
#define TCPCB_REPAIRED 0x10 /* SKB repaired (no skb_mstamp_ns) */
#define TCPCB_EVER_RETRANS 0x80 /* Ever retransmitted frame */
#define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
TCPCB_REPAIRED)

