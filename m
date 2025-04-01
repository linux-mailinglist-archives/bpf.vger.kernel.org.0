Return-Path: <bpf+bounces-55042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D0A774D5
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AD3A9E7C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E1E5B8B;
	Tue,  1 Apr 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGUWTLuq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BC3BBC9;
	Tue,  1 Apr 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490673; cv=none; b=vBd1DWTc4Dd54P/1J7Ui3Q6rr1/6vWG/BNCmAirOAYXJk3x0jbAdQD6eY2RMq0mgwA/fjnVj9hLP6vTxOwznWdjpdytf4V1uUUVjkyJ6UQ2aVwPSFL5QyWLEnvBP39hyk9+zVBPD1x1BGFNtH9BUvngHHcUOQcUyuWn5zCCo3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490673; c=relaxed/simple;
	bh=IGCSEc7Ts4W/Xzxedq5JGQXSYv7wzW4BM7kIZ4pyBGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH8Lg/CfOG71e8rKpC/GcfXcmvcGv5EP2h98mCQBCVnfMGgDFTYqyxEWmR3OuZJjd/oppkmZdq3N4ILQJ4GogWURcKo464rir/rcSRBLYdK6XQHGGHuU6zHu0Rn0Y8GoEqNmd28JzZNXWHeofeB01YXShoSY+g+cXCI/rreYQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGUWTLuq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f7019422so46909766d6.1;
        Mon, 31 Mar 2025 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743490670; x=1744095470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ssnm22tzkENh8oJAuNiuanJgxcOth+qg0jpPFpBJdzU=;
        b=cGUWTLuqjA+4F99F7Hf4STbEs6beosoTp1GBEKtW95IGyc6bkiZylCshJNKN3ymPLH
         W+IE4SXa2R7RogEluuEpu3yegbgZvwlvrL0XIwoM1YRggqnlSItP6/bC5TbuSNHGKvfH
         ruIrFYeSWxEJgQ8LUsrm6RpF3UuM6ybsMwhNq6BO59sijy2o/jWQaOV2R6+WYlqALtxn
         GtHFopYVjo3IS/uIIygXNw6pgp9GYoYVC1Pgl7Dd6Q/E+bSz5v4C6FujBUiiid7EB9JR
         e8crPJgKpolZGsN8S9ncQQ9xD7OQZ9QHHu+IjF0MyoQ0MVJ9Ss1NdsiqOo+4mcPulnq/
         EgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743490670; x=1744095470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ssnm22tzkENh8oJAuNiuanJgxcOth+qg0jpPFpBJdzU=;
        b=Wqe2dAlcT5IhE3qvYbCVoYaAs2oB9LUWF63Q0i91N06dS9dIWno9Kbsi26HQ1N5sMW
         JYfOws4SNhjjJ0RA/AeoHDjAoNBkY20xpBTUruY5wubBZgzUJNFwQyLTLCK8mhRqLTN6
         HFi1soz6DgJ9MYS3pk5u/oG9wJtFHE8+Le4TfR5CLStGoqOx/wUr8NrtC3ymuhP/7KF1
         Q3f6n5jbQ5JBxL9y+eaDFY7upEnZVQav8K2mLLngOfJNwmICEvdXKxWRPDb+kjPIxRwK
         iWWQ3XS2hsFkiYiTV+WYGO1Y5Z2tpRgHLofNTykfomEt0CnZdaFnyMvyIziwQuUiabDh
         vMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUwAyo8lYc1/8er+I0L2dZNmBBTtH+FwOwW5GNToyXrPW2coZ6D71TM5SDrA6iM7yikf0yAhFwTV+blO2Q+@vger.kernel.org, AJvYcCWTWpbL/4wi+s2HEHYKG3gW8QYIo2AcJNLaN/JNafEwpDSewCyK8Yzb/V7di4bDwWNVwCQURB34@vger.kernel.org, AJvYcCXl8naALy2TqsErRhtR/7puTyH788/eihP0hpALrGxwTwV1eVAsvAdWXJZLfiijPLaml+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAEn1HiOSWHPk9Z5S2f57zj0AIWWjK0NFStvDL9uOebeYkS01
	iF6Dv0XfF/ezFDiRSps4lAFkCycCe8R2hCvnu6h1FTsM46SFqx/jLhCyD3QNyaMrQNqNUS/tYnt
	Qj+rkNhWJICPmP3cw96UAgY1E1cc=
X-Gm-Gg: ASbGncvC07b9zVDnPBPbi65VAVxTQ/pr2GefrvP9Fypik6soE7V8zaBMfAh765nVUAN
	YnVt9EjPGI7bAyiUlv2vgacqHCkLX1oWHujzySys+Bd/lEI7D/hTBzjW+nBxM/gq2mVrz1Y8uN8
	QWKDuNBZB6v8om/RNU5WWlGbBF/oRtNZoxovvpzMI=
X-Google-Smtp-Source: AGHT+IEdDAVr7gVEbl/GU6WDm3sxWkA6MwHWEQcbw2gEjH2spd6Tnyrk+S3j01CtNdHmm8Kio51U0o84zUlZceK8Um4=
X-Received: by 2002:ad4:5c69:0:b0:6e8:9dc9:1c03 with SMTP id
 6a1803df08f44-6eed61d4938mr215266606d6.21.1743490670336; Mon, 31 Mar 2025
 23:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329061548.1357925-1-wangliang74@huawei.com>
 <Z-qzLyGKskaqgFh5@mini-arch> <Z-sRF0G43HpGiGwH@mini-arch> <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
In-Reply-To: <0d1b689c-c0ef-460a-9969-ff5aebbb8fac@huawei.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 1 Apr 2025 08:57:39 +0200
X-Gm-Features: AQ5f1JoOBJ9GaGcDlhTEvX2DMHnIg27Jf5d7FVBWwMgFdH6LVMOQBiZvlY1hMAs
Message-ID: <CAJ8uoz1JxhXFkzW8n_Dud8SR-4zE7gim5vS_UZHELiA7d0k+wQ@mail.gmail.com>
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
To: Wang Liang <wangliang74@huawei.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 at 04:36, Wang Liang <wangliang74@huawei.com> wrote:
>
>
> =E5=9C=A8 2025/4/1 6:03, Stanislav Fomichev =E5=86=99=E9=81=93:
> > On 03/31, Stanislav Fomichev wrote:
> >> On 03/29, Wang Liang wrote:
> >>> The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_R=
ING
> >>> option but do not reserve tx ring. Because xsk_poll() try to wakeup t=
he
> >>> driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
> >>> tx_ring_empty_descs count increases once the xsk_poll()is called:
> >>>
> >>>    xsk_poll
> >>>      xsk_generic_xmit
> >>>        __xsk_generic_xmit
> >>>          xskq_cons_peek_desc
> >>>            xskq_cons_read_desc
> >>>              q->queue_empty_descs++;

Sorry, but I do not understand how to reproduce this error. So you
first issue a setsockopt with the XDP_TX_RING option and then you do
not "reserve tx ring". What does that last "not reserve tx ring" mean?
No mmap() of that ring, or something else? I guess you have bound the
socket with a bind()? Some pseudo code on how to reproduce this would
be helpful. Just want to understand so I can help. Thank you.

> >>>
> >>> To avoid this count error, add check for tx descs before send msg in =
poll.
> >>>
> >>> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not sup=
port ndo_xsk_wakeup")
> >>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> >> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Hmm, wait, I stumbled upon xskq_has_descs again and it looks only at
> > cached prod/cons. How is it supposed to work when the actual tx
> > descriptor is posted? Is there anything besides xskq_cons_peek_desc fro=
m
> > __xsk_generic_xmit that refreshes cached_prod?
>
>
> Yes, you are right!
>
> How about using xskq_cons_nb_entries() to check free descriptors?
>
> Like this:
>
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index e5d104ce7b82..babb7928d335 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -993,7 +993,7 @@ static __poll_t xsk_poll(struct file *file, struct
> socket *sock,
>          if (pool->cached_need_wakeup) {
>                  if (xs->zc)
>                          xsk_wakeup(xs, pool->cached_need_wakeup);
> -               else if (xs->tx)
> +               else if (xs->tx && xskq_cons_nb_entries(xs->tx, 1))
>                          /* Poll needs to drive Tx also in copy mode */
>                          xsk_generic_xmit(sk);
>          }
>
>

