Return-Path: <bpf+bounces-3173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EF73A7CD
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42142281A6C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2FF200D8;
	Thu, 22 Jun 2023 17:55:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109932068D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:55:30 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D54B1FF6
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25e7fe2fbc9so3733980a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456526; x=1690048526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp48nVtGyA7Br8JQvoHipeg5lrmuPTRf+zZ/Ox3/D1Q=;
        b=hyuLl0aOwBk06RO/KCeKwpeASbRRuwk+J8d/SapksEOFoivhOssFweFwx6v6if4gAx
         WhgI3RAANIA6zZeriPODW8jQW2VK98pVKgEkawYkKJ2AUUekakUtz04V24oGGLO02Bdx
         Uw89ZbLnXPXdQtwTeEPYX782hHML9gnLfQBOBGEpeFIe4hZ/4VNvGLyFxxSej2C168VP
         4EsLh23xpe5+fGM8xZPfiMVNbKlsFpggYZW45VDlm9q2p9wmSZvDrIDdfdwMj1SCnvD5
         ZPtwNdEgTv/dBAJeyTWijby0if7eyivywp/XrheMYBkZPtWRur/mkSPyus8xQf6ZcPF9
         hkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456526; x=1690048526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp48nVtGyA7Br8JQvoHipeg5lrmuPTRf+zZ/Ox3/D1Q=;
        b=Gwe10S0/s8tN5rRnb7PaIMTy6Gi4yfr1K+08YnsAGOg6VcpkS1vFTtuZXauDGsyYa1
         LmovFhQ0eeetynRhXuQWfVoTSq1kAH4xTbneHdQKl+u30N0AFwlhqTSqkW7wzUuA7dAa
         xGKgYWR/qSFnWu+vuQGu5LAgdBGoqyh5HA5kvqUgR5B+HraeJSpC1pfPFGOxrVdfzlPB
         IzFoqLoPL5nLZyMFzxV4djQj0VpSBUySlIQeGo8YUz6Kz0P8pHiI9+nw/9v1S1djSk6F
         sxGpvQ313L/M7lJIbx8EFs1qiO+GqQiBFFXegF7Gk0Prwje2YLyfPEI0JSgyYf9Ocgcz
         wADw==
X-Gm-Message-State: AC+VfDzazxdUycxqqTWTrpz+xHuTZu+sCFhge5vxHsCqVcT62oAlHDaj
	mkOKOrJVCT5liQ6nBS6IlxIWXHNk3kcuSvFmudZIHQ==
X-Google-Smtp-Source: ACHHUZ7FtQbcRUc8WTLtjIXwmhf0dP4E0sMApQm7RE+yKIgq4QNlnxIanJNTRDZhTsnXNaRQmz1bVKfp83v4/d6NFV4=
X-Received: by 2002:a17:90b:3141:b0:259:548b:d394 with SMTP id
 ip1-20020a17090b314100b00259548bd394mr13787062pjb.28.1687456525795; Thu, 22
 Jun 2023 10:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-6-sdf@google.com>
 <00c76c9d-cce8-f3a7-2eda-1c4cc6f36d93@brouer.com>
In-Reply-To: <00c76c9d-cce8-f3a7-2eda-1c4cc6f36d93@brouer.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:14 -0700
Message-ID: <CAKH8qBthYBKdxGs8idSXwM6VRpv4-sQH+j9N_QD9eXDmrAnmEA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 05/11] bpf: Implement devtx timestamp kfunc
To: "Jesper D. Brouer" <netdev@brouer.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 5:07=E2=80=AFAM Jesper D. Brouer <netdev@brouer.com=
> wrote:
>
>
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > Two kfuncs, one per hook point:
> >
> > 1. at submit time - bpf_devtx_sb_request_timestamp - to request HW
> >     to put TX timestamp into TX completion descriptors
> >
> > 2. at completion time - bpf_devtx_cp_timestamp - to read out
> >     TX timestamp
> >
> [...]
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 08fbd4622ccf..2fdb0731eb67 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> [...]
> >   struct xdp_metadata_ops {
> >       int     (*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timest=
amp);
> >       int     (*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> >                              enum xdp_rss_hash_type *rss_type);
> > +     int     (*xmo_sb_request_timestamp)(const struct devtx_frame *ctx=
);
> > +     int     (*xmo_cp_timestamp)(const struct devtx_frame *ctx, u64 *t=
imestamp);
> >   };
>
> The "sb" and "cp" abbreviations, what do they stand for?

SuBmit and ComPlete. Should I spell them out? Or any other suitable
abbreviation?

