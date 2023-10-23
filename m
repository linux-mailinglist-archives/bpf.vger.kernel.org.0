Return-Path: <bpf+bounces-13049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA77D3F61
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE0EB20F66
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1021A06;
	Mon, 23 Oct 2023 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uj2CgIuG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E4219E2
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:38:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A669CC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:38:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so45722317b3.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698086298; x=1698691098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=psPIDexlmbx2oQKoywMWkukSVUBQPWpjMzsLgIAN/3Q=;
        b=Uj2CgIuGEACRene++037LQ2/pIztr1k4ibu4jgeW+T6+5P1EEPNX0zLQ/TRO7LHWKB
         rysKqLgi7hP3omNPDriPZjRBJ+grgXPcC7vwZo+3O/Bv8lTzC52/nEVOsWh43eI2asz7
         cuftCczPHMQXKcRzeki17zMnK8sAum/9d7Ba2U9uQNaQF1b2lBcmniIqpdUed50mxLU9
         dCKSaeO3N9+lBzldNfAKNUYnwAIcW99d6kUuXcFKKL9icqrNHU+tKYHXzEx6cB1WwHD7
         wS/vv2zgb07VJw8wT/X+GZpLPZ/ajYZqRqTVNiTrzkglsyTOC04dyI4Reho6ATuSmc/D
         gKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086298; x=1698691098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psPIDexlmbx2oQKoywMWkukSVUBQPWpjMzsLgIAN/3Q=;
        b=tLrVZJqZh43VccjkqGHEE5L6z8gEPBraEhBLIqNJgoy8sZOP2JiAOWO8I1aRYRLCgq
         FjaZKMPUMbSkq7jT4/XbVSwFZRETgQI99Cv4Kxj4YIwSbcTnrItwvmZVRZL5F0Zm5WrG
         gwkVpiQNbjarSV9n5R8LcTTvpKoRuyGOtIMIEFBniijRkhIwB0IAuogPc2DXABwfg/FO
         jU0n8RJEGhap9GqrHof+TZqIGSHzKMe9ztreYh+LqXK0/J/vtaXQCtqBhuK766ip3b/O
         1zQ3WKtFulCjAEFYY/MnyXJ/vcOXBHYaYHcLx5/dzcmmtF5y4Cz1Gk+DZ64KkM995Qg3
         zyEg==
X-Gm-Message-State: AOJu0YxbVNZaxIsQycW7DXy+neWPH38phFIz2tfn7T68iRwzX3uRagAp
	mkBT3DsX2j3RjH5NJOSPWJ3g960=
X-Google-Smtp-Source: AGHT+IGSN2dlPUz4dYZ0sD/eg33lpIQ0p1bO+6bqKeVaG96gSQUEbAc0EauDKMZ5jFi/sXX6twYdvxM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:c7d2:0:b0:c78:c530:6345 with SMTP id
 w201-20020a25c7d2000000b00c78c5306345mr169998ybe.7.1698086298615; Mon, 23 Oct
 2023 11:38:18 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:38:16 -0700
In-Reply-To: <CAJ8uoz26Q-8etBpgc25xFY8ZRcoJeAM5RFOWO-Q2_T1=xBfL9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <CAJ8uoz26Q-8etBpgc25xFY8ZRcoJeAM5RFOWO-Q2_T1=xBfL9g@mail.gmail.com>
Message-ID: <ZTa9mO5esjWnW8Oo@google.com>
Subject: Re: [PATCH bpf-next v4 00/11] xsk: TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/23, Magnus Karlsson wrote:
> On Thu, 19 Oct 2023 at 19:49, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > This series implements initial TX metadata (offloads) for AF_XDP.
> > See patch #2 for the main implementation and mlx5/stmmac ones for the
> > example on how to consume the metadata on the device side.
> >
> > Starting with two types of offloads:
> > - request TX timestamp (and write it back into the metadata area)
> > - request TX checksum offload
> >
> > Changes since v3:
> > - fix xsk_tx_metadata_ops kdoc (Song Yoong Siang)
> > - add missing xsk_tx_metadata_to_compl for XDP_SOCKETS=n (Vinicius Costa Gomes and Intel bots)
> > - add reference timestamps to the selftests + refactor existing ones (Jesper)
> >
> > v3: https://lore.kernel.org/bpf/20231003200522.1914523-1-sdf@google.com/
> 
> Thanks for working on this Stanislav. I went through the patch set and
> it looks good to me. You have addressed all the feedback that Maciej
> and I had on a previous version. Just had some small things in two of
> the patches. Apart from that, you are good to go and you can add my
> ack to the next version.
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Again, really appreciate all your work with this!

Thank you! Appreciate the review and comments as well!

