Return-Path: <bpf+bounces-15409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C97F1E95
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E7828104C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FB37167;
	Mon, 20 Nov 2023 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWjyDhkG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1DCD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:15:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso5823493b3a.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700514943; x=1701119743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJhAktQ8YptxCo0xFGqf0D0Bj/NGrMrR+E+DusKyhUU=;
        b=rWjyDhkGBnKExvoxje8U07YlSxaHW5Q+GgQ/iI3LYDj8hoiHMS5EAeR/6yzr8P5Xhv
         ALsFBiIqUjeET3nlxGcJjwpsIth2GU+GNVn/za1HNRIujNQ3Ytq+p0PQACWWz30yFdJi
         OU+BbdCqzdQCoUX+Vmpmr9N4lndYBbVs8xwHiAvI1Ppw09a/mw1q3XnP3FWZdHfMRi3T
         aio3IRpj5ENYgsnfSRlEJuyKVYMMYOvYVo9ERPfjxfGUT5I7+HNQ8Ud6gui4iD6NEBlh
         ig6klYomNhMDGbrP+5oZFvKqDNAZLbv08cY7jhomhIxgREJMGVeVPBWKxURzXQmBk1zV
         8bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514943; x=1701119743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJhAktQ8YptxCo0xFGqf0D0Bj/NGrMrR+E+DusKyhUU=;
        b=snaRi8fXxwwiNEkQvsQ+nAcAPUYX59lgxCSeFVkCan5MKcYnqeSMvARPGquzNlZwPT
         0kW4DwdBnGQdtwzlKu32cSLUuAgkqC2W++XljIMIAyaDZRLAE5/ITky0mzZwD9vkmraV
         zM4tgxeYujGBmipEUbeH9NT4VBBZcCduOdhNQ7oDduqrh0qzpG+WxNW+qJc5D8BaICow
         Ft/ZSLK/k1q67HBCyFs+x8Ojrv8/QDZRkKjcHCMSbBfX+hviFV4HfBXy5O4kdWj+24fT
         H2NN+Af5eo6RO4AQTXiLZt4PC3un6c7MeD9MygacR4vOTqs3/WLmuh23gIBYmJZf7Oke
         9Z4A==
X-Gm-Message-State: AOJu0Yx2vjQ7e4lko143/Zn9ggpDpotsuiRY/QofafLwStdYGNAfRvuH
	nIxtRuWR50uKH3sO9QovPA7HsFI=
X-Google-Smtp-Source: AGHT+IGAcpy14NB4SIG15bm/T8tGAD4FjydZmjX9MDG5i1aAXgYyTPNALf9MpZAWrbYKr22joYwvqM4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2314:b0:68e:3053:14b9 with SMTP id
 h20-20020a056a00231400b0068e305314b9mr207509pfh.2.1700514942953; Mon, 20 Nov
 2023 13:15:42 -0800 (PST)
Date: Mon, 20 Nov 2023 13:15:41 -0800
In-Reply-To: <20231115175301.534113-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231115175301.534113-1-larysa.zaremba@intel.com> <20231115175301.534113-18-larysa.zaremba@intel.com>
Message-ID: <ZVvMfcOnqsyocJ6A@google.com>
Subject: Re: [PATCH bpf-next v7 17/18] selftests/bpf: Use AF_INET for TX in xdp_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="utf-8"

On 11/15, Larysa Zaremba wrote:
> The easiest way to simulate stripped VLAN tag in veth is to send a packet
> from VLAN interface, attached to veth. Unfortunately, this approach is
> incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> such feature.
> 
> Replace AF_XDP packet generation with sending the same datagram via
> AF_INET socket.
> 
> This does not change the packet contents or hints values with one notable
> exception: rx_hash_type, which previously was expected to be 0, now is
> expected be at least XDP_RSS_TYPE_L4.

Btw, I've been thinking a bit about how we can make this test work for both
your VLANs and my upcoming af_xdp tx side. And seems like the best
way, probably, is to have two tx paths exercised: veth and af_xdp.
For veth, we'll verify everything+vlans, for af_xdp we'll verify
everything except the vlans.

Originally I was assuming that I'll switch this part back to af_xdp, but
I don't think having tx vlan offload makes sense (because af_xdp
userspace can just prepare the correct header from the start).

So if you're doing a respin, maybe see if we can keep af_xdp tx part
but make it skip the vlans verification?

generate_packet_af_xdp();
verify_xsk_metadata(/*verify_vlans=*/false);
geenrate_packet_veth();
verify_xsk_metadata(/*verify_vlans=*/true);

?

