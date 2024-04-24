Return-Path: <bpf+bounces-27641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179918B003C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C291F28CBC5
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2715144303;
	Wed, 24 Apr 2024 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsXnMLS/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539C143C5A
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930751; cv=none; b=rWy7OxCLfrEQOWqAmlYXd1w0plROw/ZK8A2a6spslAG8Hte6rJkAbpP5ulU1rh5TjCeaqQU+UJg/oeEmN24k4FOfmaPKDsgCeAUznPCQ47XhV7hQxCaqq4NpDDPBO+FdlynPo3dEizQZpIosokwpKYmdqahxuEkd/phTSJUqYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930751; c=relaxed/simple;
	bh=grgr8wFdoOCKelHN0/YG8NRrSXx88B1nTn4dCXxCUnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNX1638/sB4mxEXhUUfGgJtUcSejGO6UvGF3ntWz1DfGF3alDOUlKzaQTA1958/pz7B+5uOBJy4WANaRdJVKGD9Vgeb9MEVoquLyW416T4zFMKv1JMWFyqesAYAPipcQwacjSOdf/C+78EddmOWj9hPcL0FBRNmzhpHpGOM5D9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsXnMLS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJbnHKMdDBEsQMRLBXg/P+JcLGfgFupAvDL3tdrY4dk=;
	b=YsXnMLS/wDVCN+7ictbVWKro5FOPRT+orrqKBW04uzuhvFWN75Q4uiFeDGs8NADG/ppp4a
	LXUgw/c702sHVH0UNgC5Y+QQlgHWc3FyR3FWcq5YkFqgnDSY1YEtz8XbhInFsCP9e8q17R
	HVa29b+X7w0bsqt4npoeqva8csL2y7g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-tC7iBN2aMTKlZuYYtWH5Eg-1; Tue, 23 Apr 2024 23:52:27 -0400
X-MC-Unique: tC7iBN2aMTKlZuYYtWH5Eg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5fff63b4a87so2443249a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930746; x=1714535546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJbnHKMdDBEsQMRLBXg/P+JcLGfgFupAvDL3tdrY4dk=;
        b=Art5rL89hTakFnDqBY5ClVzNZsoKtgS4hf3dFD2KIjsQ0CQqLnZjDtbaNAKC3N/xhg
         f5BtEKqnt+R43Lr8tnvxO6oN9QHzCbLywcCzaBykZjrc9GaW8TWelffryn60P32TU27r
         vFh/oMWPWMTMWbVs+Likgb1dYgFMbSmfTkNlWAaKkkeIyWRZcshI1fctKREgtGGx4D84
         uZDb1+SWhM6QbRk8MIPadUXBRgcZdG3QoGa1TMkCaqaOkfwcZwylAAjnqwHuxgMgWpaO
         tByYUGxCDc2oUkeJvFEFgsYVgyev2ZsyrTd98kABjTz+EBYwGHiNQw0laJblF0kSnunH
         PtDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRffaCBaA0zzIMQ7QdtyQvRUuVL+w3fbf0Cj8iJOyhHcKL2BH47XQE4JgHo1xcrnBb1cNz58vSIhJuIP65Hl2ngZCy
X-Gm-Message-State: AOJu0Yx552DUSlvfqStSg4xUc+GMWLvtHeD95zgiIOkuuC456Lc5p2ux
	1fHnjklUYRymuRp6/yNHkFeJDwmi40hqnt2576DgKFzFqombU4jzLg5hB8MBUCr9+hNGgMj75P4
	S3DWGX1vsTbhBj27/BRItMrsVjz04ZGz/ns+4tcgiVPqCKk+o7giZMNyJDTp+IoherBJQugIKUe
	eDZ6Cb4ZfdTaMrFBAgdS3ZPlam
X-Received: by 2002:a05:6a20:9187:b0:1aa:118c:22cd with SMTP id v7-20020a056a20918700b001aa118c22cdmr1538210pzd.62.1713930746046;
        Tue, 23 Apr 2024 20:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA+deojCMQ8Z7djFD6weadRa90BTPWmlecKHcAHl1rKT0HigiYFO4WsDxVxXKywA17hDJwnoWBOWI53prC8JI=
X-Received: by 2002:a05:6a20:9187:b0:1aa:118c:22cd with SMTP id
 v7-20020a056a20918700b001aa118c22cdmr1538188pzd.62.1713930745714; Tue, 23 Apr
 2024 20:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:52:12 +0800
Message-ID: <CACGkMEvaJuujaXoJ3jnvMFYX1-CnXH7cUEz4KbXivgEmt=OUxA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/8] virtio_net: add the total stats field
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we just show the stats of every queue.
>
> But for the user, the total values of every stat may are valuable.
>
> NIC statistics:
>      rx_packets: 373522
>      rx_bytes: 85919736
>      rx_drops: 0
>      rx_xdp_packets: 0
>      rx_xdp_tx: 0
>      rx_xdp_redirects: 0
>      rx_xdp_drops: 0
>      rx_kicks: 11125
>      rx_hw_notifications: 0
>      rx_hw_packets: 1325870
>      rx_hw_bytes: 263348963
>      rx_hw_interrupts: 0
>      rx_hw_drops: 1451
>      rx_hw_drop_overruns: 0
>      rx_hw_csum_valid: 1325870
>      rx_hw_needs_csum: 1325870
>      rx_hw_csum_none: 0
>      rx_hw_csum_bad: 0
>      rx_hw_ratelimit_packets: 0
>      rx_hw_ratelimit_bytes: 0
>      tx_packets: 10050
>      tx_bytes: 1230176
>      tx_xdp_tx: 0
>      tx_xdp_tx_drops: 0
>      tx_kicks: 10050
>      tx_timeouts: 0
>      tx_hw_notifications: 0
>      tx_hw_packets: 32281
>      tx_hw_bytes: 4315590
>      tx_hw_interrupts: 0
>      tx_hw_drops: 0
>      tx_hw_drop_malformed: 0
>      tx_hw_csum_none: 0
>      tx_hw_needs_csum: 32281
>      tx_hw_ratelimit_packets: 0
>      tx_hw_ratelimit_bytes: 0
>      rx0_packets: 373522
>      rx0_bytes: 85919736
>      rx0_drops: 0
>      rx0_xdp_packets: 0
>      rx0_xdp_tx: 0
>      rx0_xdp_redirects: 0
>      rx0_xdp_drops: 0
>      rx0_kicks: 11125
>      rx0_hw_notifications: 0
>      rx0_hw_packets: 1325870
>      rx0_hw_bytes: 263348963
>      rx0_hw_interrupts: 0
>      rx0_hw_drops: 1451
>      rx0_hw_drop_overruns: 0
>      rx0_hw_csum_valid: 1325870
>      rx0_hw_needs_csum: 1325870
>      rx0_hw_csum_none: 0
>      rx0_hw_csum_bad: 0
>      rx0_hw_ratelimit_packets: 0
>      rx0_hw_ratelimit_bytes: 0
>      tx0_packets: 10050
>      tx0_bytes: 1230176
>      tx0_xdp_tx: 0
>      tx0_xdp_tx_drops: 0
>      tx0_kicks: 10050
>      tx0_timeouts: 0
>      tx0_hw_notifications: 0
>      tx0_hw_packets: 32281
>      tx0_hw_bytes: 4315590
>      tx0_hw_interrupts: 0
>      tx0_hw_drops: 0
>      tx0_hw_drop_malformed: 0
>      tx0_hw_csum_none: 0
>      tx0_hw_needs_csum: 32281
>      tx0_hw_ratelimit_packets: 0
>      tx0_hw_ratelimit_bytes: 0
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6d24cd8fb15f..8a4d22f5f5b1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3344,14 +3344,15 @@ static void virtnet_stats_sprintf(u8 **p, const c=
har *fmt, const char *noq_fmt,
>         }
>  }
>
> +/* qid =3D=3D -1: for rx/tx queue total field */
>  static void virtnet_get_stats_string(struct virtnet_info *vi, int type, =
int qid, u8 **data)

Nit: -1 for all seems to be a wired API, could we have the caller to
iterate the possible qid?

Other parts look good.

Thanks


