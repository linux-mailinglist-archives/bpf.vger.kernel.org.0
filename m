Return-Path: <bpf+bounces-14616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA967E7136
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA441C20C8A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AC347A2;
	Thu,  9 Nov 2023 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr8IWXYH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7832C90
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:07:29 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89881727
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:07:28 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4ac89e8e964so494398e0c.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699553248; x=1700158048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5jof2dMXbvUyv/2d3eh8cYmtslz7u0wbU9sqNUptZw=;
        b=lr8IWXYHFzQZXnUU/VHDOE8lzRLYhBk24xaDUt6mknLxoRwm7q0viGidfxl7KDrlCR
         QnA0pqSymEsMbFUasogVdy9OGiRjtQLhMV20dscCeAI4CHg2SS9Rlztk47AhFcON74MC
         MTdcm+5DEFN+A+0xAAvu8FPGfHavRjZ0i5j3u2w33sVqv1en/vz7c/vted6S0e24f5BG
         p0PN3NaxisoraETVnk26pNzhs6/10RPrfhiL3VgmWD4FsSo2fF24t0quXHsofq/9q2Uk
         fh8nmn/ghtNzMtDnSPmpYb3GNxVd6P8+G435DDTCLmjKewsP1sTGjZGScTDzvC7J6R+e
         Nhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553248; x=1700158048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5jof2dMXbvUyv/2d3eh8cYmtslz7u0wbU9sqNUptZw=;
        b=OI3gb5i1zH1lFZCXxD97d3dkwd6jPq6VKI2SThe7qvzMPlqt2k0SG+pWIaUaS4jlug
         1jLjttKn+MS5FDXcjoLBpLByIBuzo+1MCV+ga25Iw8Q8GE4hr1tBZFqRH6VSqE+Of81w
         Qc3md2CLU3Ml1IsWulyEExgSJVUZnviD8JQI7erjp5GxGUoI1SS+d4Dh/uwewcHyPs5W
         Tw5ha/0hnt85PsxG7NvREVfsCdxREHcYQY5VtTV5np5h0WLExWj9vK7DTTy9xNjOQ82I
         3h8WYHa/Q/YpGjx1nsi7yusR4SIzEhlP/uicSaLwA7MPoKy7Yzxhsw4iKkwQfbZE5G5P
         OLDw==
X-Gm-Message-State: AOJu0Yw3fBmRvJtjpGUKQWDd3sKZDG2AdW003/LSr6E32HkVUuBcE8MJ
	hvipBnC5bJ4xBaxhnzv7KHKFpgdZWnVgCPgwuUvKbw==
X-Google-Smtp-Source: AGHT+IEnm0GQvFTNs/hpK2AqwHKtIdbux6hL2chbJDT/1nnPxaXSEMiQmybsy0eZF4F5OgkJ1E0jEiVEkvhvNTuTRrY=
X-Received: by 2002:a05:6122:1799:b0:49c:79f3:27a4 with SMTP id
 o25-20020a056122179900b0049c79f327a4mr2654001vkf.3.1699553247892; Thu, 09 Nov
 2023 10:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <CAADnVQLTkhYMXxDsJ4jB5d7SnQ_Z51j9YT65TcdiXNg5DOO_Fg@mail.gmail.com>
In-Reply-To: <CAADnVQLTkhYMXxDsJ4jB5d7SnQ_Z51j9YT65TcdiXNg5DOO_Fg@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 9 Nov 2023 10:07:14 -0800
Message-ID: <CAKH8qBskineuye_0cUP6_aPb+FO2=PigFgC=n5upC1rt2ritQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/13] xsk: TX metadata
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"Song, Yoong Siang" <yoong.siang.song@intel.com>, Network Development <netdev@vger.kernel.org>, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 10:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 3:58=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > This series implements initial TX metadata (offloads) for AF_XDP.
> > See patch #2 for the main implementation and mlx5/stmmac ones for the
> > example on how to consume the metadata on the device side.
> >
> > Starting with two types of offloads:
> > - request TX timestamp (and write it back into the metadata area)
> > - request TX checksum offload
> >
> > Changes since v4:
> > - remove 'render-max: true' from spec (Jakub)
> > - move xsk_tx_metadata_ops into include/net/xdp_sock.h (Jakub)
> > - christmas tree in netdev_nl_dev_fill (Jakub)
> > - fix > vs >=3D when dumping masks in samples (Jakub)
> > - switch to 8-byte alignment for tx metadata length (Jakub)
> > - spelling fixes in the doc (Magnus)
> > - deny metadata length >=3D 256 (Magnus)
> > - validate metadata flags and deny unknown ones (Jakub)
> > - move XDP_TX_METADATA_CHECKSUM_SW into umem config flag (Jakub)
> > - don't print timestamps twice in xdp_hw_metadata (Song)
> > - rename anonymous xsk_tx_metadata member into request (Alexei)
> > - add comment to xsk_tx_metadata (Alexei)
> >
> > I've separated new bits that need a closer review into separate patches=
:
> > - xsk_tx_metadata flags validation:
> >   - xsk: Validate xsk_tx_metadata flags
> > - new umem flag for sw tx csum calculation (instead of per-packet flag)
> >   - xsk: Add option to calculate TX checksum in SW
>
> Stan,
>
> new xdp_metadata is failing on s390. See BPF CI:
>
> verify_xsk_metadata:FAIL:csum unexpected csum: actual 29212 !=3D expected=
 7282
>
> Other than this I think the patchset is good to go.
> Pls fix and respin.

Oh, thanks for catching this, probably some endianness issues? Will take a =
look!

