Return-Path: <bpf+bounces-3203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A373AC4E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADED62816ED
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430F22578;
	Thu, 22 Jun 2023 22:04:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282420690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:04:56 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91561BD0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:04:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so511055e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471493; x=1690063493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LujOXmM/k7wgPtidmXuGKcEe/byLIdn8sn1BJB0VqSo=;
        b=qd0/pDPLmza3n9Q6dhJfoJ9/GZf2pNsVDCeS9uZrFIS4YToUWIY7m6KSff0zQEWbYc
         EuWygHj14GnP+9SYnIIonNUQJlVinLY969fCcgcABq73Hraf3FYI35+oHG6zixvim6lP
         PgWxzWpV7MqAdbzz+xhWMJuMsvHV9yGXj6Ll/NcfwZwwuQp5Tss5yJM1Zrszy3CCXUcn
         vzkHPPK9e2YabwMR7tTFjeUJudgANmhCtnEOse1onzBTIPpDSme7zz4YDpVIvkTEYpRS
         wpJ3tG5/ecZNBl4VqLhjnesKyyYbrOs4sn8obsOgMLurt1i+6GcDk9Tm37Q5T8pqyj54
         Os/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471493; x=1690063493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LujOXmM/k7wgPtidmXuGKcEe/byLIdn8sn1BJB0VqSo=;
        b=Hjt1iJMOgwcabkXiHCvwOOKWG2I6+M1aze7NGhyEMtYTIavhayx7T7xud5Kx2XFVBG
         3Ha8Wi7Hufz7X4mhboDPqhM/ERY9bCr5D1EL8nI0TPKoYmbOfXOCJDwRj2OO6ND+PovO
         2bKC592rdkdSIfq323K8/4QAiJ4pI2PC/7e2rNfCN3wCXz3UUwqj+5O3VZWSP9Ntkjsf
         fx7fyOS9mCiPexQg6L91Fm0SwqQNdmyVJQayevKPt4icjAypp1+a/fgbA+vRZ7Upcpif
         cPGF6UzSJvS0golFLedrnomjbXH1iG7smWkn30yARC0wr28nHSnpB2dq8sB4VsPujgD/
         29WA==
X-Gm-Message-State: AC+VfDwwBwi7aLMJAJNv8kSmg3w6+p67K58EY0JJCfquMQ+xGdu+G2Or
	achYYoO9APH+iuCQLKxYMAwNGuxji6DYOj8i5hs=
X-Google-Smtp-Source: ACHHUZ57P5rIYCoCSc3P5JT2crp2hesI5sxPA8dsGi1lsI/fvFra9uhbkxZQ/ZfTIYdIEeojKMjEvn6s2oEarHQKnDw=
X-Received: by 2002:a7b:c457:0:b0:3f9:bd3c:31b0 with SMTP id
 l23-20020a7bc457000000b003f9bd3c31b0mr5155800wmi.39.1687471493084; Thu, 22
 Jun 2023 15:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-8-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:04:41 -0700
Message-ID: <CAEf4BzaSJAKZ-iEvzcLuoJTuEr2Z_JPgrSLABtFPh8zKOz+OvA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/9] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 10:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and kind layout info
> (if available); for example
>
> $ bpftool btf dump file vmlinux format meta
> size 4966513
> magic 0xeb9f
> version 1
> flags 0x0
> hdr_len 24
> type_len 2929900
> type_off 0
> str_len 2036589
> str_off 2929900
>
> ...or for vmlinux with kind layout, crc:
>
> $ bpftool btf dump file vmlinux format meta
> size 5034496
> magic 0xeb9f
> version 1
> flags 0x1
> hdr_len 40
> type_len 2973628
> type_off 0
> str_len 2060745
> str_off 2973628
> kind_layout_len 80
> kind_layout_off 5034376
> crc 0xb6a5171f
> base_crc 0x0
> kind 0    flags 0x0    info_sz 0    elem_sz 0
> kind 1    flags 0x0    info_sz 4    elem_sz 0
> kind 2    flags 0x0    info_sz 0    elem_sz 0
> kind 3    flags 0x0    info_sz 12   elem_sz 0
> kind 4    flags 0x0    info_sz 0    elem_sz 12

well, bpftool will know symbolic names for most of these, so why not
emit them? I think it's fine to emit both, something like


kind INT (1)  flags ....
...

and for unknown:

kind <unknown> (123) flags ....


WDYT?

> ...
>
> JSON output is also supported:
>
> $ bpftool -j btf dump file vmlinux format meta
> {"size":4904369,{"header":"magic":60319,"version":1,"flags":0,"hdr_len":2=
4,"type_len":2893508,"type_off":0,"str_len":2010837,"str_off":2893508}}
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 93 ++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 3 deletions(-)
>

[...]

