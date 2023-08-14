Return-Path: <bpf+bounces-7760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B5877BF83
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 20:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013DC1C20AB5
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73704CA59;
	Mon, 14 Aug 2023 18:05:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC9CA4F
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 18:05:02 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3E12D
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 11:05:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-563f4e49ff9so2623344a12.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036301; x=1692641101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wBdc2OtGKv5OJ2TPNg6Z3QRlAwIqqbuA4CQ/AEohC0=;
        b=6pHKTGWVGdOmP1EyGI1E/GeT78Zugn6Pa1gf3JF9qKC8hmo4ojoU1l8Bz7La+SwNc6
         iiqHzasde50XbQJSnQcXO4x7aOhDEES9bD1iZ+Zx+uhkPL8fslQA6jCEt7ANZYO/Sjzd
         bNV0Bt7Req8Gt4/HHQVA+TxqZ5kEzKOmucdE0tjOy9BCGeaXAFCkdxD3WB5BiWA7zPT1
         UiLcDT1esR/uKDC5nL0c/dEd+OxlS+LCCRnQCZEcugDtLIpuTSEf7fI8ito91JLMxj69
         godM/ulAVfKPf/5kKW1F3RkTifPGIeVzwf0N7JvByZxtU5Fl6GPOd3oUBH1Wjjw4mJJm
         dURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036301; x=1692641101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wBdc2OtGKv5OJ2TPNg6Z3QRlAwIqqbuA4CQ/AEohC0=;
        b=S4y3WtnSuIVpynSUoxoy7FFIDZ7iNG+6M5n529vfPp6RT5gLH006Ow+ECyIRbxXRdf
         Oo2WclEmbhAiwhumaAF4W03sh93+NG6sS7l0mWM3QoJsehAoCDecNG2TWIpwKQUKkWvj
         4MismPnynHrJWpmsSrMCZcaKWT3cW0YNJfdaTynpLIuYExEa7tQUEel6LozoIVG3QACF
         SdtESfua2ffMcNq7aNF1sdQnulwN9FvcKpoBCwH1TnskwvSfvxsJMn5tq7WlOfrDorq1
         KeMw0cbJIBdzw0341uG1doRtnEbmfG2oF1sKfKJ79oUI/z+kveVqpmENx+gf8ktVKlTQ
         VqIA==
X-Gm-Message-State: AOJu0YxQDoMYHsPyiBoTzacp7qzlxeE1CMhBU756NQjZgNGDamc/ABmw
	o7ZEMxVFd/8927fzbgN7a3nk052F89pcI4/PF0JBXQ==
X-Google-Smtp-Source: AGHT+IGPfPTWC2xmtl+CVOZ1y6flMKk+BrLnhIW5whlJyHKWDVa+ttYaTiJe6gSKHXzMh8xVBYfbFjIthl98axlH/YE=
X-Received: by 2002:a17:90a:6686:b0:268:8e93:644f with SMTP id
 m6-20020a17090a668600b002688e93644fmr7865412pjj.45.1692036300901; Mon, 14 Aug
 2023 11:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <ZNoMTVS0I9A1hyTQ@boxer>
In-Reply-To: <ZNoMTVS0I9A1hyTQ@boxer>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 14 Aug 2023 11:04:49 -0700
Message-ID: <CAKH8qBsMnuThCMJ+rfPHBiLApQ93GirCmy5vV332d4L2g8hswA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/9] xsk: TX metadata
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 4:16=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 09:54:09AM -0700, Stanislav Fomichev wrote:
> > This series implements initial TX metadata (offloads) for AF_XDP.
> > See patch #2 for the main implementation and mlx5-one for the
> > example on how to consume the metadata on the device side.
> >
> > Starting with two types of offloads:
> > - request TX timestamp (and write it back into the metadata area)
> > - request TX checksum offload
> >
> > Changes since last RFC:
> > - add /* private: */ comments to headers (Simon)
> > - handle metadata only in the first frag (Simon)
> > - rename xdp_hw_metadata flags (Willem)
> > - s/tmo_request_checksum/tmo_request_timestamp/ in xdp_metadata_ops
> >   comment (Willem)
> > - Documentation/networking/xsk-tx-metadata.rst
>
> Stan,
>
> thanks for working on it - we reviewed the patchset with Magnus and we
> have some questions (responded inline to patches). Overall we think it
> would be worth implementing this work against another ZC driver
> (preferably ice :P) to check that proposed API is generic enough.

Awesome, thanks for the review! I can try to see if I have some
ice-capable hw around, but if you want to help with the ice
implementation I'd gladly accept the offer :-p

