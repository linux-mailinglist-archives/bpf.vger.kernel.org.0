Return-Path: <bpf+bounces-3174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABA73A7CF
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B627A1C2117A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D0206A0;
	Thu, 22 Jun 2023 17:55:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DEA20684
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:55:35 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDF1FE6
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25df7944f60so5341543a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456533; x=1690048533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv7NlJfJhJSvHtOnzF0Vw0AvAYP8oSd8rqwNEKRHDJQ=;
        b=y3aeYLTTAtFq7eOyfvpRn0uncmtH9t7hY7Pp5UG0oRzmiS0tk9TINsyxY2a7yMjs4U
         VGQiWVKv3gmW/a+hb4B09yZ+XbFNFPNwUx6qzw+Ny4ouYwvZH6NDJhjxzdFuU06w/AYP
         bhx2eVKJppZ4KFCKM9LLPc9U84Hoe5HeXj5AECft9MlX5cm3JsG7TMAyenTtHBznFxA6
         kdfKeSTqmdJtCGComcs/k3ah1F+BkXECdNDNmlbohTMI7WrbfKBZHBlHpHpmEfwAzhgx
         eUdYMG1Q1pnvhlSO4pupQCUd2r76mDV+AkDChZIBWTfdHMC7RumTwl+mInKH5IlphdaY
         btLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456533; x=1690048533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv7NlJfJhJSvHtOnzF0Vw0AvAYP8oSd8rqwNEKRHDJQ=;
        b=Wrt7Ta3cQFBqsRTFkir4CoVOryWaIqsnK0WB+VMBeNQKVYNm8ltw93kIivkIHkstwH
         GJGFC1KNNTenD0BcJP4Qj+1iWS+/AatfL/DMJsRwDyxS9eBZo8I4jypGFSNw/t7kXsLo
         Azu6zuuoPw9DwXFix4PvliPoTS+bsL/Is/gjY4R8Ou5b876K3yKadflRv3GpwSHfKEtW
         03vO+KFwOB8LNcWSZw3ZjmgIAlEyk0Bk1ZewF6lT2im4CLRoFC9KuS2wMCAniSVKn4kH
         GGopeaXCgpNbYLdnwLIfpTYj7640HioYPWqCyWlcxM5KIX3MHjgu6A3+SMkohAYNU7Od
         qnCw==
X-Gm-Message-State: AC+VfDxV/biNTK+KhNqm+LZMUjYatGeP5g2DR0wkcIvYZz2Bh3PnZfCR
	Kb+2RHXx0K7sNBFwkkPVy40RLyjmKOMybTOdsbo8wQ==
X-Google-Smtp-Source: ACHHUZ5QIwVB5YCGccw2HBwN2qrXi2UYIkc6hSX23YS76M/7HZEdu4t/xFsxQHLbFSVYVJkts9IOTTiAdGVFxWgJrsg=
X-Received: by 2002:a17:90a:9ae:b0:25e:a643:adeb with SMTP id
 43-20020a17090a09ae00b0025ea643adebmr18044669pjo.39.1687456533344; Thu, 22
 Jun 2023 10:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
In-Reply-To: <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:22 -0700
Message-ID: <CAKH8qBtJ+8LQ+J67ybxXg23NRqpNr4sCx=hA4CuV0d5hiAQPyw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 00/11] bpf: Netdev TX metadata
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, netdev@vger.kernel.org, 
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

On Thu, Jun 22, 2023 at 1:41=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > CC'ing people only on the cover letter. Hopefully can find the rest via
> > lore.
>
> Could you please Cc me on all the patches, please.
> (also please use hawk@kernel.org instead of my RH addr)
>
> Also consider Cc'ing xdp-hints@xdp-project.net as we have end-users and
> NIC engineers that can bring value to this conversation.

Definitely! Didn't want to spam people too much (assuming they mostly
use the lore for reading).

