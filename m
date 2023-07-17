Return-Path: <bpf+bounces-5124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2577569CE
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475F9281C7E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FE3D74;
	Mon, 17 Jul 2023 17:04:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1451878
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:04:21 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D7E1
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:04:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso70872001fa.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689613458; x=1692205458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PEAOb1jXVJ7ALlWk/4YorL7FQdVxh/+CGl+FcaUJFDE=;
        b=Oe7sRa70nZl19oqaTc1EPtiZzxWIXpvjJxfp1TwB73Znfmeno6e4Mt52zf1mQhrxlG
         hDA+0DmW1jVTIMjdNaeO6IQPymuv/yUsAtUc0KhaQAeOtIbBE9BayTXuR9RFSgKJKcE/
         q3G1NuqoUXHx6kQQiXwwy2SjmpYuwF+tPUVIRtsZoyshLVOIuFQp4RLOj+OqZaOhQKHX
         Zj+Ml4e5rBQ1ZfFKUnVoBYboO1KPcGZT9gFymMPfY5tFuAbxgwzhlfSv0bQ1c4wLuXki
         DF4eUXix5yIDAKRj1EADmxknSGEaaCGa+8AfvENymKv+0XcOUzPm7DRlB/T+AbwQHtOe
         63vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613458; x=1692205458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEAOb1jXVJ7ALlWk/4YorL7FQdVxh/+CGl+FcaUJFDE=;
        b=TCcBuZ2zCBwk8ugFMl3YFZrb2QUVzFPldL94Dm33bEs8+GopeYhncsBC9sh6pyi6y+
         9SKsFMtODqGBf5/amcnDlEfMsro06uXh0LdziB21BMyH25XMKUF6DkFYIRdPmcwbZery
         iz1eNRr+T0zFRmnIInJ+SqhTwVtPYLzaV1t63w5CaYFaHYrOFB9tQKmlFSNXkvnEprUK
         2GQQBvZwST3FnxQ9MtAh3LT5gY7UXk8OBjK3+av+WBHjDXioKRtE387iSqa8mOqMRU3b
         RAPL4X7cWYJV+YTQgF58frTKgW69Txg/wupja7QEFNBLai+BEA5TEuwKNKeCriWHHndJ
         3myQ==
X-Gm-Message-State: ABy/qLYTB7nVhvOboOilN/sTjiSSZ1sI2MnzdS48yXRM0UetIOP+6I62
	Wu1l9xtCD6j3U0uoRLNhaDK1MWYpPQg=
X-Google-Smtp-Source: APBJJlG0blbNLLgix01xLSWXOs8V+OBVDQEINR7sljg/fODfp8kAAYzJggwz384tyeDa8zEfdwQFuA==
X-Received: by 2002:a2e:9b82:0:b0:2b5:95a8:4126 with SMTP id z2-20020a2e9b82000000b002b595a84126mr8252756lji.52.1689613458052;
        Mon, 17 Jul 2023 10:04:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d60c3000000b0030ae499da59sm19699450wrt.111.2023.07.17.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:04:17 -0700 (PDT)
Message-ID: <0221715cb5d4bbf35b61f8e75a792f9c781d24fa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>, Kernel
 Team <kernel-team@fb.com>
Date: Mon, 17 Jul 2023 20:04:16 +0300
In-Reply-To: <CAADnVQLTVodyZXJTNcSB98hT25DahFVfVga0d7R8Cb3F5HfTJQ@mail.gmail.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
	 <CAADnVQLTVodyZXJTNcSB98hT25DahFVfVga0d7R8Cb3F5HfTJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-17 at 09:56 -0700, Alexei Starovoitov wrote:
> On Sun, Jul 16, 2023 at 6:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> > - I've looked through the usage of BPF_LDX and found that there
> >  is a function seccomp.c:seccomp_check_filter(), that directly
> >  checks possible CLASS / CODE combinations. Should this function
> >  be updated to handle new instructions?
>=20
> This is classic bpf. Why would it change? What is the concern?

Sorry, I missed the call to `bpf_check_classic()` in filter.c:bpf_prepare_f=
ilter().

