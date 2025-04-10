Return-Path: <bpf+bounces-55697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9721A85043
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2497ABD3F
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BDA214228;
	Thu, 10 Apr 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr9aFZVu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2E1DED40;
	Thu, 10 Apr 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328966; cv=none; b=gQnPr6Z0JrFyOpLFjsDkm1SE/cdnG0bFAae43NG/iqSO479/gvefz+4NWl0h3VjB9QK0rpcD0dq7fQZ4BthzoVOHLxEA+xNr9t12fH5tkUNZs9hhpitsrRM9DH+yKlLNaWvj86QDDuOgP1RSBVg6BNOcLEI9DkjM8NEKhsAh+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328966; c=relaxed/simple;
	bh=Wv9BgshAQXkLEPWk0F3rEd4hX9E17rxBZnp3n9Ec2BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9wy5ZB3VZlTl8sAtHC8ROhM27/+0l4Mk9qtX9fAnySt6e9k2PO9a45hYel0pO3ejukm0b9uIyOXWTyJj/UBogJwczTFA62KDkO9EDyTKKQFIaPj+WCky+PS3kokL2QgM2ORJNMPBJgq1KNJQZIoK6aMh3HxkdFhvpet0EmHqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr9aFZVu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso1065769a12.2;
        Thu, 10 Apr 2025 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744328964; x=1744933764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZltvLjC47FSqzOziDmU6/UE1HQXkh/eAOUz3qtoXhE=;
        b=Vr9aFZVuk/0GkhLa8svDWi7oQ9DC79WJkja7H1qhlEiMHcG3RSbW/zQEZ4kxqXjysz
         eS6BpnZFDx+Ilv55RXnoy64XGtpQJ8VnGcsrQ3ZlxQA8H1uzOcoml0vppyfd4ezbPUWo
         aSrTubb5HZY4972gfprb+Bw/meaErGj4gOmssoSa4iyk+DyIuBCT+q6geQwA0I8D/Wr4
         0NxvjYA+1sGjgMb/MVKF8lJHZnDH6aQXI2yGD+EIHw727jX6WOAjtPrB6owr4fuEdJ93
         f5Bc/ES+ytKLZjySgEd0aTxTtlkNmSynQOz9Rg/2KrRK4J601n8FAfbHvXQFkbJiox7O
         S11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744328964; x=1744933764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZltvLjC47FSqzOziDmU6/UE1HQXkh/eAOUz3qtoXhE=;
        b=vtfdppqINhlg5Tz4TRJekpFFy4VUp0+GidPnbbFy/AdhBeNmP188R47scClB+ruLCY
         Qi7ZqZfpRiwq5JFLkvqysMbELrNRF2+AszwXq+Zy6Vv1KXoLXQ/bsTvTwJC7bpGkTCBE
         XsynoW0vSsF/gYWpWOYztl/LnNYwrTvspJ/rRCa6RJsYLT/+LVdWSn5R68YFrIdNMSZk
         feTrPRY79hGAN5XD0NfRcUPIev7h6mxVAxUPzenlE3lacSCKrMMdHUIoBqZFin1Ib7U5
         xXbEU3u80MFfMsWoXnz0J28WBaPxY4gTAUV+Hdx93pDCJKW1FNzi03WiFMq0ActJnJMB
         u6eg==
X-Forwarded-Encrypted: i=1; AJvYcCVGWO2ucQwPuJcbZCMbUoCeY5MBoDUFUjgXLnabsAWaLq+rkG/+ZG6trJ1hSc/9GLPTpzv0ucQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1lQXdI/9xP1ahiauRv6N3y4an2raYVUuGXYptQ0k3mOtE4Hk
	vyVmeNTNGtQJemuToVqilThItfslXhFawkilceqDy8ypOvOQWtxvy79gase4yGd4DcjNosmN5p2
	7PA3y3A7GVLcM3s9zgXzF3kwVyic=
X-Gm-Gg: ASbGncucLwsAWGinUZr4epC/LpgMPSQ6h+ID9ZGwDxIyjY/IRTBZ72/mFN84tod/LqL
	nxNpMyVTHmiB6nL4baAN2b56HK33InYJoR1y/DQe9f/m9FxhdI8Qv9xhJ7Ki0KhSJ8dRfn6PF2R
	FmUqtLz0d9FiVIn+ponnMq15tUVf7awXo0wbdJP6/DfwNg9x+F0vKimA==
X-Google-Smtp-Source: AGHT+IFnPCpg+Af9AMFY/kI0/iRf/8XUIv9CBVfmUTJEeDLGMNoTipIJvQoH/SZ8e/AhZo8jHnbCpmrBdGDwC3D6A4Q=
X-Received: by 2002:a17:90b:2e4b:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-308236344acmr1237773a91.11.1744328964490; Thu, 10 Apr 2025
 16:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-3-ameryhung@gmail.com>
In-Reply-To: <20250409214606.2000194-3-ameryhung@gmail.com>
From: Martin KaFai Lau <iamkafai@gmail.com>
Date: Thu, 10 Apr 2025 16:49:13 -0700
X-Gm-Features: ATxdqUFrWO9PLHRjLCTTC5S2G2xd8VCDlI-waSfkXYK8iJuYiS5rqEWzv_9a8zQ
Message-ID: <CABx7vpWv7+q6zhPF_3acKGgThrzs+6r4=PtqJFndfWie8miOWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 02/10] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:47=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
> +static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
> +                                   const struct bpf_reg_state *reg,
> +                                   int off, size_t *end)
> +{
> +       switch (off) {
> +       case offsetof(struct sk_buff, tstamp):
> +               *end =3D offsetofend(struct sk_buff, tstamp);
> +               break;
> +       case offsetof(struct sk_buff, priority):
> +               *end =3D offsetofend(struct sk_buff, priority);
> +               break;
> +       case offsetof(struct sk_buff, mark):
> +               *end =3D offsetofend(struct sk_buff, mark);
> +               break;
> +       case offsetof(struct sk_buff, queue_mapping):
> +               *end =3D offsetofend(struct sk_buff, queue_mapping);
> +               break;
> +       case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb,=
 tc_classid):
> +               *end =3D offsetof(struct sk_buff, cb) +
> +                      offsetofend(struct qdisc_skb_cb, tc_classid);
> +               break;
> +       case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb,=
 data[0]) ...
> +            offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb,
> +                                                    data[QDISC_CB_PRIV_L=
EN - 1]):
> +               *end =3D offsetof(struct sk_buff, cb) +
> +                      offsetofend(struct qdisc_skb_cb, data[QDISC_CB_PRI=
V_LEN - 1]);
> +               break;
> +       case offsetof(struct sk_buff, tc_index):
> +               *end =3D offsetofend(struct sk_buff, tc_index);
> +               break;

I only kept the WRITE access to tstamp and data[]. Removed everything
else. It can be revisited when they are really needed in the future.

