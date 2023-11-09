Return-Path: <bpf+bounces-14614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33947E710D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0302DB210CF
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5432C8E;
	Thu,  9 Nov 2023 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dceBBlQW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7D32C89;
	Thu,  9 Nov 2023 18:03:14 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072F3AA5;
	Thu,  9 Nov 2023 10:03:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32fdd0774d9so671589f8f.2;
        Thu, 09 Nov 2023 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552992; x=1700157792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQPmLdLHjp0U6fK2jzOSwK3vCgpMh0fu5pXh4aGJZPs=;
        b=dceBBlQWEm51g3lbgtBEBhCVGZ4eXCcjenB7L7+BzEENBQN0GjU+dmqKoInN9gJYrp
         /ysMmjm0xIipcoDdPIWTP2cN6ca/CkjWYRclxih1LWq/FZhSFnVnvnrCKIH4E4rbLcqB
         scO9/O9SN9xgs+xOxpRzKxBO/qgKLusoZbzZg+ao1ztMOoxn/8+YwllFdXE0eON9T6Fp
         s7P1knXWWNAs+6p48snhcQfP0i2xj7OAyiCQYb3SPb+M3FigUJx4rSlCQVoCHQEfhiIl
         XO6AYD9Xh4VJ3/Wh8nQbIdvE78jho6FX10RukOmxaYP8Zrk+VkKz7CxOJs7qe97JvvMt
         h88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552992; x=1700157792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQPmLdLHjp0U6fK2jzOSwK3vCgpMh0fu5pXh4aGJZPs=;
        b=WZKuP4oEk9lCZJOzXEQ3uJqeSa3zHSPWwyitV4jENBOur2iruQwWqJIns+rpk1sdQT
         ZuyfF1scz88l31Wl4TvCRbghotjhzUXn11i8hyi4wnkmbXa1AMk9iLhWFXAyYG786VRn
         nGZ/k2sb1qJfQiGm8Pcra3Yl3iHZEmI+4RWOuzHcAjqERoOdfk37c0BIngbnbVw3QBjY
         2ZKfbCfn8KnDC3Dlhugdzp1Bgwma1rZfJJe50bJdY9z0jofDa3ueXvBXpI0lgdcCE3Br
         Z7obyXIIRG4GMyVz5x6pm9+VoYET3Dcsy/5BgxYDBtgzhJaKi7LZ0EEX2JnU4tyW2zsF
         6gog==
X-Gm-Message-State: AOJu0Yyrd/uavXEPl9+xGB5vNpaweI+tgs4kiSjwkSw8pbqpAJf1UUxy
	iG8xvlBqnvXPqldx22/PY3DfHVpfJ9RkibjxtQw=
X-Google-Smtp-Source: AGHT+IEtBGQCplXPDboMTEzY5ylJDE3ujo/RzqX5g36yXyxvh6/i4hJM4W65YBtHs15I5nles1xOP7AekjF3o+gUbRY=
X-Received: by 2002:adf:f506:0:b0:32d:9ed0:c31a with SMTP id
 q6-20020adff506000000b0032d9ed0c31amr4501338wro.64.1699552991462; Thu, 09 Nov
 2023 10:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 10:03:00 -0800
Message-ID: <CAADnVQLTkhYMXxDsJ4jB5d7SnQ_Z51j9YT65TcdiXNg5DOO_Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/13] xsk: TX metadata
To: Stanislav Fomichev <sdf@google.com>
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

On Thu, Nov 2, 2023 at 3:58=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5/stmmac ones for the
> example on how to consume the metadata on the device side.
>
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload
>
> Changes since v4:
> - remove 'render-max: true' from spec (Jakub)
> - move xsk_tx_metadata_ops into include/net/xdp_sock.h (Jakub)
> - christmas tree in netdev_nl_dev_fill (Jakub)
> - fix > vs >=3D when dumping masks in samples (Jakub)
> - switch to 8-byte alignment for tx metadata length (Jakub)
> - spelling fixes in the doc (Magnus)
> - deny metadata length >=3D 256 (Magnus)
> - validate metadata flags and deny unknown ones (Jakub)
> - move XDP_TX_METADATA_CHECKSUM_SW into umem config flag (Jakub)
> - don't print timestamps twice in xdp_hw_metadata (Song)
> - rename anonymous xsk_tx_metadata member into request (Alexei)
> - add comment to xsk_tx_metadata (Alexei)
>
> I've separated new bits that need a closer review into separate patches:
> - xsk_tx_metadata flags validation:
>   - xsk: Validate xsk_tx_metadata flags
> - new umem flag for sw tx csum calculation (instead of per-packet flag)
>   - xsk: Add option to calculate TX checksum in SW

Stan,

new xdp_metadata is failing on s390. See BPF CI:

verify_xsk_metadata:FAIL:csum unexpected csum: actual 29212 !=3D expected 7=
282

Other than this I think the patchset is good to go.
Pls fix and respin.

