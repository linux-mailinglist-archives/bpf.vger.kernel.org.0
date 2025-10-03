Return-Path: <bpf+bounces-70318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A4BB7BDE
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 19:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 877824E974B
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E552DAFA5;
	Fri,  3 Oct 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuIjM07x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D162DA751
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512565; cv=none; b=b4DVLCQikAiDGKVPXh31l3el06jwXlq9AQHkBMUJcCuwmDw93tSO65k7HiGjA0CCEFFc8CG8S392mftbpxiebvMy1x+LArMX7uP5CPRaigfzbYQl9JsPnP/r6XGTIEwx4bo78/aUlOQeXufjUHZROFEylCK7J2iaBr13OVn5aoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512565; c=relaxed/simple;
	bh=1Z1eZgXUHbUhnt6ifRLgYY1bBpQ7uOGH6Pqiebn6sXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkMB93tW3fN5/N8G8sGbsX9eHQaoOKhk87NgQpIsg/ftYfUC77aoB061vibf0KOsT01iMW1PUJQdGkNJe8RnIu2vAMiI9gRm5qsZXMlBpi+1pEH2mJAwSoEw9jhhoFDWTuV+i5DFgk75ER4IOVKjtX1pBnjY6m/J4zO1OGCJgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuIjM07x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so28143485e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512562; x=1760117362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLx0sPfJY19ZneLVq1waLS70fIlfMNWcd5huW0a4ZEY=;
        b=QuIjM07xjJTmfIrnQR3EvK2scLSxqyNlBoHFsG9ROYsXOWJPdejEubRTYkiHQ7NEXd
         W+lIlRo8t6S+CNiU0osJ19hvsilUFjvbDcr5utnc2YbGMi3FHi0uQoel3s1q4sjdRSs5
         eLgI3p62lMP316xqNE5v54EMmNsmyJc6wrXS/2T0++F4LCdE6/MEwF4aeXt3Y9Q7Gd8/
         dlY7m8xrq2JWT+ExBD38YLx7kEcX8QWHnvHSio6iBlOamAsZONZqiJoE+jZZAPPup36D
         vkKGbMvplfBieyERTfi6y9wYK6o0AJkmb8Ami78AXI0u5nILJ+0UU8kFYjBCJFY/8qpT
         Ardw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512562; x=1760117362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLx0sPfJY19ZneLVq1waLS70fIlfMNWcd5huW0a4ZEY=;
        b=GS3/Xw5scLk4EkLywdY6GIAWWT91jdODznHs5SqQLfCLkqWv/r4okL64k8HPB1pU+o
         FyVhjlQzu05SXSIFB09sMzmHjUjXYTdRdDzWpy01NE4LPeFuny8GookZGsJ9HFFenXxx
         /ab+sz8rC1I7323qQ29HN+ZGJpkYlXb6RvgXt0sy7pShRTlDh3N7xIo9qNnAaVhD6kIl
         eUBdipMleZjcn9eq9LQw+eF63XMUjziy2sGDaO6zqszjzUFFZL0VE/whUf6miIh3dNpR
         9Sz0wFlcyGEJOEcHvnzKD9E79IyGS9Cfjd7f1accNZbZucunE/stgQwOgBVXr7ZYepM9
         sMRw==
X-Gm-Message-State: AOJu0Yx4k2cdHIUh9u1uh8To1+8SEZmNps5Qqhx9NrQrIpOlrso1Couj
	lSvv9ETxcXw+HhiEmgmm2VzoQ7x4qyxBxk40DTl6lard+IrJYCVJ5n62nA720+iN5ScZbtW6l/e
	uEXyzS84ApIkhwTydhxRGN81+HwwjzOs=
X-Gm-Gg: ASbGncttAPOdy3fi5O2vN5aF5VaGFIChbvkB5kptbeJwVp15wilT0F5QsktvT/PnGUY
	Ls0b4bGypdQ5CseA+rptNYkL5Y/TjEIjcvif2RmkUecYQkq2vAfvzdEQHmMKO3/7LczdiMXWtO+
	rsVYaIZnKBx7kgPVqaxSBOxhjaPkXsftZ2zGFo8sWC6zzBNff2NtFxblL+I+GJzdqzkBlTTI8Z9
	bOE8kz+p5b0ei6ZQz/3XsxWiX3v3+zUDwej+nqLb2GoJ8qZSoIHEB5ejg==
X-Google-Smtp-Source: AGHT+IFvUiOcacXwaHUMPjIbZAC1OpVWo3koSYKr+TsLcvQurc+EbgJSVBHYh7uNlChXhPHr/kAaaE2ILBWf0uEHlSQ=
X-Received: by 2002:a05:600c:8b6e:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-46e71153ad0mr27796655e9.30.1759512561771; Fri, 03 Oct 2025
 10:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com> <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Oct 2025 10:29:08 -0700
X-Gm-Features: AS18NWAYIb2kWQ3CTUdycIF8K0dYH7l-Aatdyqmy8xN3LnrgUgTCfZNHar8kh2k
Message-ID: <CAADnVQLGocfOT224=9_nJZ6093QDh1M_EDLQ3cNVQZKEDnjwog@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:03=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper that releases
> underlying memory. This happens when it consumes enough amount of bytes
> and when XDP buffer has fragments. For this action the memory model
> knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
>
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
>
> For this purpose introduce a small helper, xdp_update_mem_type(), that
> could be used on other callsites such as veth which are open to this
> problem as well. Here we call it right before executing XDP program in
> generic XDP hook.
>
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
>
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@g=
oogle.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, test=
ing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit=
 msg and proposed more robust fix
> ---
>  include/net/xdp.h | 7 +++++++
>  net/core/dev.c    | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index f288c348a6c1..5568e41cc191 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -336,6 +336,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 n=
r_frags,
>         skb->pfmemalloc |=3D pfmemalloc;
>  }
>
> +static inline void
> +xdp_update_mem_type(struct xdp_buff *xdp)
> +{
> +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp->dat=
a)) ?
> +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> +}

AI says that it's racy and I think it's onto something.
See
https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959=
919
and
https://github.com/kernel-patches/bpf/actions/runs/18224704286/job/51892959=
937

click on 'Check review-inline.txt'

