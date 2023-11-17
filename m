Return-Path: <bpf+bounces-15239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2ED7EF683
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866F528148A
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09C3C47F;
	Fri, 17 Nov 2023 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbpQG+ap"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0F194
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c41e95efcbso311174966b.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239604; x=1700844404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyfATWwOjYS1dinl5sJkRxen3VyenKLGVOWtEnsSwvQ=;
        b=LbpQG+apc3HJ2pK2pFiL81JWGqOWoAsER9LOporS1NMf+82wnu0GNrnDlfozVq6QES
         l9F1JyyzDTt30JSoVnxOGjpVhqgqR2i5jLrhbqMKujJ7tyW/wWG0Vj2P9Y+CzoirZxgg
         17WlQkOKZKuIT01JXyTwWCu258EOMAimD9MhCF4f17Q3c/UlRczXsPcaSuI/rZmUsGoD
         6qAhnvGwirsSZaQ53YqXVUjvt+7xo5tHnkjKpIRStSgvctKzdFomtCsr9PRa+QOAsSjy
         1kFj30P1P0kUCk1D5zq1phGm12652wvRa5NkdwOGEbTM2Leeu2t7YMPJwD6fHeVQLb2U
         ELng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239604; x=1700844404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyfATWwOjYS1dinl5sJkRxen3VyenKLGVOWtEnsSwvQ=;
        b=vT1D58iJ1Kk4IMLMUyn0ixmgi3bJfBtoe/UeVCGCRCI6cU9i9z9eNaEi3ZBREcuIaI
         ULedG2WRE99dU+cRkPL64L5ukbwHvuQFtbitGYZrb4dKFXH4dPrXw9gjKIPTvu4BR5+c
         y7D2F7BsOyjZy/20VDfv8GNryEqAMJzDczSL11x7k1qMiKifJKHC0AZpQuKze+bgJ2Kt
         bOEG8Cbf/TlC/2vzLSsWFoWIh9Eo2SDNL9eCPe1Gx8wRmmLHeUhC5z1Yx/rdOAMnVjzz
         zQv1jRLTlnx16Lb+SsPtKI69tm/7fMa8VToZ9uaRhGa4ilw0fnOvcvcIiKQ/2lICfI51
         vpuQ==
X-Gm-Message-State: AOJu0YziQ9gmH/RmBSY/nfTIEM4d3blDDgHkRRE+2/Jk1a6CpmlWjM4m
	4DUpRK77a8Obi4DtIn6MD9rPTgT0wI5oywAPniM=
X-Google-Smtp-Source: AGHT+IF5LaXbco559ZPfPm+Sg2rEGjNfv4Q2BQ2Wi7s7BA7ziavmpyW9mnOW5WuWe+h7KkwI1IvHyyqCuHGAm7HWYRs=
X-Received: by 2002:a17:906:d217:b0:9be:3c7e:7f38 with SMTP id
 w23-20020a170906d21700b009be3c7e7f38mr14062154ejz.10.1700239604317; Fri, 17
 Nov 2023 08:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-2-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:33 -0500
Message-ID: <CAEf4BzY4ZFCTvSKJ3SR4KHF-QJhegCUkXn4nCS2G3uwQTeV2aQ@mail.gmail.com>
Subject: Re: [PATCH bpf 01/12] selftests/bpf: track tcp payload offset as
 scalar in xdp_synproxy
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This change prepares syncookie_{tc,xdp} for update in callbakcs
> verification logic. To allow bpf_loop() verification converge when
> multiple callback itreations are considered:
> - track offset inside TCP payload explicitly, not as a part of the
>   pointer;
> - make sure that offset does not exceed MAX_PACKET_OFF enforced by
>   verifier;
> - make sure that offset is tracked as unbound scalar between
>   iterations, otherwise verifier won't be able infer that bpf_loop
>   callback reaches identical states.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/xdp_synproxy_kern.c   | 84 ++++++++++++-------
>  1 file changed, 52 insertions(+), 32 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

