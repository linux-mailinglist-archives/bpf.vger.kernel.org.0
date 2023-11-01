Return-Path: <bpf+bounces-13804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9E7DE242
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671BFB2108E
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4E134DA;
	Wed,  1 Nov 2023 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VDoCuOkp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7013AC7
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:18:10 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958483
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 07:18:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so1050300066b.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698848284; x=1699453084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrEHCOP+SrdwuHiekQNSbAtDkv18M+2JYde+YT0pEiA=;
        b=VDoCuOkpBkq37soRQe5/GvzJ3N/WtymrjJGvey4Jlvty4gZD3jjN6Vk87ezTQrZAKS
         VTaDPk4KIk0x1fqyr/IqB7eYZkIkmc+MGY1+N0JXZawaNP7srCtQzd1CJ/Mg/auC/Xgi
         cU6yAvUXxUy8cHoFGHrjxwpBYiBTq81NBNO4f1qWNM+ULPhfiITkUK1oOqWRv5KqWZ8J
         vRfPMd4r7dlBIGPqRN9MH98oIVJYca7DvBWE/yhOv+J7JxzmS+Tl36YCkG6UXlEnb8FR
         IXvVmjDmw+ER39AKla/W6TkQpcqc4eQ4fyNPCbXG5rkdTrV9/kXUnxEeHRa1EaTVIFZQ
         lKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698848284; x=1699453084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrEHCOP+SrdwuHiekQNSbAtDkv18M+2JYde+YT0pEiA=;
        b=eB3aVw+QO3kjUS3ba+qpkofWIvtDdSlHyd5wVhoQgADztzKND0xmCdKG72Kc9jfLSl
         vxkJ4xirLIG7kNvu7fBLXQYutvARFy/02MGj8z8n56d6tr+BlRtsdKm8jNT7cGUmzabB
         SRK/30pAR4z7TP/MmqgxVB1+YST46ah0F77Q5cM/2Px0K66Haa49EbrINKcdTf7uFqGr
         KQEEcjEeY+2SuynwYrmsd9CPd2UbTJOMTxF2WG2V5cSk1cwfn+MaHzswz4F3HkfOmLGc
         pcJ5/lU5NSUW2gL2GaLoNJkMlzIch90IsW35DqGJ6ajG1fzMtGhQPyocFV6jicCua3R2
         EY8A==
X-Gm-Message-State: AOJu0YyTFiybUcN85ja2pM90OJo+dHFrBkd4miW0jK5Cv7huppTyXky7
	0mD5x/Pa0Gw3iArkhT1XGn9lQaOiBKQLD67WgrCQWQ==
X-Google-Smtp-Source: AGHT+IFiqsiVNj+JAGLQWsiuUwb07AnMvv8qiUz/kFBZphQ2pfTKOZsZRuaw14pshUrkkP4UWHxYoIPRg2JPAi0u9sM=
X-Received: by 2002:a17:907:36ca:b0:9d2:e2f6:45b2 with SMTP id
 bj10-20020a17090736ca00b009d2e2f645b2mr1829025ejc.71.1698848284380; Wed, 01
 Nov 2023 07:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
 <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
In-Reply-To: <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Wed, 1 Nov 2023 14:17:53 +0000
Message-ID: <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 6:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> >
> > Did you get round to fixing this, or did you decide to leave it as is?
>
> Trying to recall, was there anything to do on the libbpf side, or was
> it purely a compiler-side change?

I'm not 100% sure TBH. I'd like clang to behave consistently for
local_id and target_id. I don't know whether that would break libbpf.

Lorenz

