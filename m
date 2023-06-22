Return-Path: <bpf+bounces-3172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFB73A7CA
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D46D281A73
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719AA20688;
	Thu, 22 Jun 2023 17:55:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E1200D8
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:55:24 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F062118
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25edb50c3acso4394369a91.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456518; x=1690048518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKB3mRshSFmiO5X8mqfZaGcfAhkZf796XK49+KeA2nU=;
        b=nivLASTMpRo9d/C5fU3XT02fBFJtnMyhaVhTA12az8nfW0Kci8JI7GsMYwiT7aFrCG
         eHybnL8S/H57MRFUktTry87TMzQPNlnF2W0zAdq3t0rhIkQpo1NmPoDfEvNdF+3UVshT
         fuV1N8YtFS1mt6PCw47isfruWcAGY33DdBjFG1sOlgcDA2QBzqq4DHsVDcXZMZKZuirD
         uaD747fWPzyYvG80kZaPdmVkgSq6l3FcJxbjkq/9V0fPkWvQKCG+YNROpxDX2gqW6Jms
         jf080wzNs+La5akpx2/SR26z5zxAVktXdubWWvsbl4koSLgoclR8uc4E4AnHSOEPgW4N
         ITHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456518; x=1690048518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKB3mRshSFmiO5X8mqfZaGcfAhkZf796XK49+KeA2nU=;
        b=Fjb33VdOlhhrZirU4gMxQ9NS3WYv6euAld27D3aAOOoCIQ+FaxPAJU37IPc/bJkL0L
         /UsrChKO8n5BpPEvtjS9ZY8JjgnZz2Dylnxd0zX5/nA2nVQ8rzVQzAc48IU/LWTDRnp7
         mqhzNfGWoX74pFQkEJduByiJHfjuJI6+/Yi36a3n2dEs9S/0pdvd/wy9nAYLx3E5nKSc
         W/cJjFf/OiYSAr6q1FRkPtokBJSh3hT9bqnP5n/SCUBo56dk2cA0/aC8AZ3M0MJdOgrU
         mud0sJK1ER5rbEucYGuVhKEOJ3rkuD38uYLm5XyqTSl9PR+uA/zOl7ZELccmucP2cT77
         MslA==
X-Gm-Message-State: AC+VfDy7pEAVKBIhHA5oHahmyEny+UfVGWE1qZqz6ihkbIBlaMSF3v6P
	vdI+dA+WysFoh/wpaclwwvCb4HMVd5q8YqPzvBAVwg==
X-Google-Smtp-Source: ACHHUZ4TuFEAfOpGSTIkuuYTNosZ4GiLS4czTKFi2KQ1GHQT99Gl+2Ti2MPTwkGC0EMbHvrwDRfu5KIHymSiNHRSMUg=
X-Received: by 2002:a17:90a:bc85:b0:260:9a19:5864 with SMTP id
 x5-20020a17090abc8500b002609a195864mr11786094pjr.1.1687456518292; Thu, 22 Jun
 2023 10:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
In-Reply-To: <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:06 -0700
Message-ID: <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: "Jesper D. Brouer" <netdev@brouer.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netdev@brouer.com=
> wrote:
>
>
> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=C3=B8rn (Cc=
)
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> > and carry some TX metadata in the headroom. For copy mode, there
> > is no way currently to populate skb metadata.
> >
> > Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> > to treat as metadata. Metadata bytes come prior to tx_desc address
> > (same as in RX case).
>
>  From looking at the code, this introduces a socket option for this TX
> metadata length (tx_metadata_len).
> This implies the same fixed TX metadata size is used for all packets.
> Maybe describe this in patch desc.

I was planning to do a proper documentation page once we settle on all
the details (similar to the one we have for rx).

> What is the plan for dealing with cases that doesn't populate same/full
> TX metadata size ?

Do we need to support that? I was assuming that the TX layout would be
fixed between the userspace and BPF.
If every packet would have a different metadata length, it seems like
a nightmare to parse?

