Return-Path: <bpf+bounces-3378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83F73CDA5
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED974280FB3
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB16633;
	Sun, 25 Jun 2023 01:12:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8B620
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:12:58 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161A8B8
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:12:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso1885763276.0
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687655576; x=1690247576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nvfL3Uv42kRId4d+CDNHw2D49cuMseCbdy4kyI3cdw=;
        b=Of3/7KIlfarGLy9KNUC9N0zhluxvptIe51iHYBRgJi2o3lT/JFDu02umwLOuhLGoUZ
         jP9FFFh63PKcaT11X4WmDVw1FFQkzbPEW/pohtbuW0wpTRQmXDfrjNdkhc6ClH5k7+18
         SRQm51yYve1HkDuTfEZ/XaUliBJJUp0es43RUMBSbfZNR6X1ghqKeGzIlRTNJp7sou2b
         CHsdBDe8o77rxblcKs93itt9L0vnq5JYkRZElSAbrpvu++SXBHnhzaVNqBpe6JL1699z
         XGrQkbg8dKDPBxwCONu/raWs3/wjbczvC5k6x+rWGSDqYOB+YT0H+I8n1XEKxoQggXr+
         iodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655576; x=1690247576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nvfL3Uv42kRId4d+CDNHw2D49cuMseCbdy4kyI3cdw=;
        b=OARg6tScjgQ381624dTzdVc8XHlpe8OfyQa1JFB1EZyXPnPkqXYiWdpU4CvxI01Xr4
         7fsWfZ/nKCWYKMSobsEQC2qiXH5uARPJ8nYs94bEHNtry6zty9Dl79+FWdzKsfoMfyNQ
         8g05xSFtN77ZpkAhblTXAjxdN4X7E4ffE4lksTrQO0zy4ZGa3gf60J5EREJx9D0GCA8q
         vjzDmH7fW2d7fD6PZKkbsjGrpT4EuN/UsAOtkIsPteidN0dF/iZuWlnBJHD4a4gaiWIw
         UYY22GxGIQAsTNgf0DlyLD3CIpL5ZBkRispoTr1ntkReS9BEQzXePLDnNAOC/iERH70N
         xe9g==
X-Gm-Message-State: AC+VfDxBYH4ukWPHUHBG2FNL+ccFjAkKUlCKyxW0lFoqysBuJIMqK/Fx
	bCBSbBoZHfkh+VdtDmDJBZcdiBg=
X-Google-Smtp-Source: ACHHUZ5gIcGFoew+OhdZbjpwQtc7tNXBaMKMF9VVxR7DxTOZttfHVHK/ZNoYwoIFtYLcJZw7Y1+fJWg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:dbc3:0:b0:c17:f547:620d with SMTP id
 g186-20020a25dbc3000000b00c17f547620dmr196289ybf.7.1687655576342; Sat, 24 Jun
 2023 18:12:56 -0700 (PDT)
Date: Sat, 24 Jun 2023 18:12:54 -0700
In-Reply-To: <20230624143834.26c5b5e8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-12-sdf@google.com> <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com> <20230624143834.26c5b5e8@kernel.org>
Message-ID: <ZJeUlv/omsyXdO/R@google.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/24, Jakub Kicinski wrote:
> On Fri, 23 Jun 2023 19:52:03 -0700 Alexei Starovoitov wrote:
> > That's pretty much what I'm suggesting.
> > Add two driver specific __weak nop hook points where necessary
> > with few driver specific kfuncs.
> > Don't build generic infra when it's too early to generalize.
> > 
> > It would mean that bpf progs will be driver specific,
> > but when something novel like this is being proposed it's better
> > to start with minimal code change to core kernel (ideally none)
> > and when common things are found then generalize.
> > 
> > Sounds like Stanislav use case is timestamps in TX
> > while Donald's are checksums on RX, TX. These use cases are too different.
> > To make HW TX checksum compute checksum driven by AF_XDP
> > a lot more needs to be done than what Stan is proposing for timestamps.
> 
> I'd think HW TX csum is actually simpler than dealing with time,
> will you change your mind if Stan posts Tx csum within a few days? :)
> 
> The set of offloads is barely changing, the lack of clarity 
> on what is needed seems overstated. IMHO AF_XDP is getting no use
> today, because everything remotely complex was stripped out of 
> the implementation to get it merged. Aren't we hand waving the
> complexity away simply because we don't want to deal with it?
> 
> These are the features today's devices support (rx/tx is a mirror):
>  - L4 csum
>  - segmentation
>  - time reporting
> 
> Some may also support:
>  - forwarding md tagging
>  - Tx launch time
>  - no fcs
> Legacy / irrelevant:
>  - VLAN insertion

Right, the goal of the series is to lay out the foundation to support
AF_XDP offloads. I'm starting with tx timestamp because that's more
pressing. But, as I mentioned in another thread, we do have other
users that want to adopt AF_XDP, but due to missing tx offloads, they
aren't able to.

IMHO, with pre-tx/post-tx hooks, it's pretty easy to go from TX
timestamp to TX checksum offload, we don't need a lot:
- define another generic kfunc bpf_request_tx_csum(from, to)
- drivers implement it
- af_xdp users call this kfunc from devtx hook

We seem to be arguing over start-with-my-specific-narrow-use-case vs
start-with-generic implementation, so maybe time for the office hours?
I can try to present some cohesive plan of how we start with the framework
plus tx-timestamp and expand with tx-checksum/etc. There is a lot of
commonality in these offloads, so I'm probably not communicating it
properly..

