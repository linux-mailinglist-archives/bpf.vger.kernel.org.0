Return-Path: <bpf+bounces-7839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA4477D252
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE58F1C20E38
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD71804D;
	Tue, 15 Aug 2023 18:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9C18026
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 18:47:07 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8565212B
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 11:46:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589cc9f7506so53028507b3.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692125121; x=1692729921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsrt+PiL4OQc0w1r/MsATpuKl0Y9Xd4SH/F6ewa1T0=;
        b=wOHiabJ3LIjpyxB2X6yAyPHihKHcNswhrpvCAshbITrgQdyf6aIoXFaeVB/zSoF13c
         +m1IDVEacvIj+aUE4Lx6Uzt5k6YZyMvxLPaMPndnVt4JjiCvroIkj4P/xJbxS0/JSf8V
         r9rWP68iL/mut2PtyXQpOJEiAnHVkKqz7F16sqYKnrSf78FePZmVVlqFaCjglCDKMSql
         bpI7wMYIEOBnBfzDYhMzf04KD+MkNpbEthnAM5Zqw+nT0jT1rVcw5bvV9fzC55BPJBRv
         0DZTc4nfRAi2y7iSLdamXLTXct7Rul2Nos4WBmbskP525McvHE+pRCWlJQ90Scni3l/n
         Y2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125121; x=1692729921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsrt+PiL4OQc0w1r/MsATpuKl0Y9Xd4SH/F6ewa1T0=;
        b=Rl/WfwFwhyjNe0akewfptZh5fFD14x+Fc4vPsMvpOsTjhpbeWrnPRh/9WdTnpBBF/7
         AbaejPYLh5x53W+hTYh0qXSvnNx9ySpygg2jjqJpW1p9sP6241HMOFLJ5ibyNDF4gsDx
         oR1OMg6ap4ECd4HJ4ax1/JMZkM2oxoOCILwV6tSdxkaVQkvzFzIXeU2V2em7wAnvFTvJ
         O+J6OnO5xmID5mOiBK4kj6LaIZ7PWLafP1XduO0wxS38Hbqtnqjd5qPUhI6kq75xAwUt
         CkKdhbv8zD0D/Rr32kUbF9um3fvqoGngIvPc6PGbntD7YygAKE1zH0GLLAgCsbPCrjjd
         hPWg==
X-Gm-Message-State: AOJu0YwFC/OcLc9GprYWmKuHeHYEhebag2c/8u2QiUHLIZV+/Jb4FZJQ
	G3GwkLvCdJUJdimIFLvwdJDJvho=
X-Google-Smtp-Source: AGHT+IEN2PBkoVD4NuRRK7kxDy/cn4+sZxakXZjjyJjZcxuiKUbPx2OfkpmxItG0ClceYq0bvL9nqow=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4413:0:b0:583:5039:d4a0 with SMTP id
 r19-20020a814413000000b005835039d4a0mr35594ywa.0.1692125121273; Tue, 15 Aug
 2023 11:45:21 -0700 (PDT)
Date: Tue, 15 Aug 2023 11:45:19 -0700
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Message-ID: <ZNvHv7TZjGRjVOSG@google.com>
Subject: Re: [PATCH bpf-next v5 00/21] XDP metadata via kfuncs for ice
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Larysa Zaremba wrote:
> This series introduces XDP hints via kfuncs [0] to the ice driver.
> 
> Series brings the following existing hints to the ice driver:
>  - HW timestamp
>  - RX hash with type
> 
> Series also introduces new hints and adds their implementation
> to ice and veth:
>  - VLAN tag with protocol
>  - Checksum status
> 
> The data above can now be accessed by XDP and userspace (AF_XDP) programs.
> They can also be checked with xdp_metadata test and xdp_hw_metadata program.
> 
> [0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/
> 
> v4:
> https://lore.kernel.org/bpf/20230728173923.1318596-1-larysa.zaremba@intel.com/
> v3:
> https://lore.kernel.org/bpf/20230719183734.21681-1-larysa.zaremba@intel.com/
> v2:
> https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
> v1:
> https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/
> 
> Changes since v4:
> - Drop the concept of partial checksum from the hint design
> - Drop the concept of checksum level from the hint design

For the non-ice patches:

Acked-by: Stanislav Fomichev <sdf@google.com>

(I've added a bunch of acked-by to the previous iterations but I don't
see them carried here)

