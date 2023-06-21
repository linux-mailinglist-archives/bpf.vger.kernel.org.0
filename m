Return-Path: <bpf+bounces-2964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA87378BB
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758B5281449
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F815B5;
	Wed, 21 Jun 2023 01:30:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7710FB
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:30:35 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37073170D;
	Tue, 20 Jun 2023 18:30:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-762092e1fb7so465689785a.1;
        Tue, 20 Jun 2023 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687311032; x=1689903032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbKPzULuZQ7OK+cUksKOLZf+gU8tuU0Fl0xPWDwXZRM=;
        b=n6aDvaJR1hGy4aMuO5gxNYhzvyikObUFoJPTu6lc0vyz9AgCCnQjp1MgHMHNALmLAr
         7ukoYd2xVSA4/Q4L6mXZeo7lXHpKQrUQfCtqnBgWFEO//frpdVWQPjt8KQMbzWsVhK/x
         Lu1XQBS190Kvj4GYXbrun4EINx+G4oryYfHCKui/RQpF7ylIq2yH5TzVpPfxDYU6hqbw
         PPsWHnPyA8GQMhY0+2hDMP5lZs3kPc0RcmYrGhmGzrp45OksEwOagcMosAMiiAk9EbTS
         AFwp0IXevYrWSj9yH5Vwls1RmA9EjMIslDCsbMxsd2AzBgDYQIKCSbv2WYS4XTPmX0z1
         x32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687311032; x=1689903032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbKPzULuZQ7OK+cUksKOLZf+gU8tuU0Fl0xPWDwXZRM=;
        b=NoIQFkdeYq+/JYQotL4bjOmxBDjUBWKucJSzkbCpkxpQBEEWcW37JGMuNhCreLxjXE
         WZ7stocnF6oH9cpW+K6X6v1USXMpMMQKXSGDGdex5+yiwdWxk122XXC8OsT12RS5G4aC
         XGdpeOn4V348YbN/BeML1i0R4s8ClczBZHVBBSgmlX1y7+EYwgIXKmgr4Doywtl9ck0c
         JTXP2YajBoPkvW9gs5saEXzTAhbmBGInjYsanL33ZiK8RnvwnxReiACjaT4QnqMXY2pn
         jGKecUGKM0VJU4NUpZg0Fq94WmBf/3h92bQXpRTWELuZ+Qvqtq6lC3F4w3/M18Gn0c0b
         RPWQ==
X-Gm-Message-State: AC+VfDwmd3NVOlF8sJolJOdqEbPNgIrXmhYNEpyk5sma90UX6hTwZk0F
	+HKF8GBvZMG5UkV6Z4v+71tG73RIvK5T+bVHW40=
X-Google-Smtp-Source: ACHHUZ6ZfiAK35FpQI77q/rhsOptH5faMW0fgLY0Evd5jg0lKOVRy+q1wSBWY4s7D/cU++cQSQspPnwtDexZ6phdq6g=
X-Received: by 2002:a05:6214:1d24:b0:632:80f:4734 with SMTP id
 f4-20020a0562141d2400b00632080f4734mr2517920qvd.40.1687311032217; Tue, 20 Jun
 2023 18:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620163008.3718-1-laoar.shao@gmail.com> <20230620163008.3718-10-laoar.shao@gmail.com>
 <CAADnVQLjaKbe6JgPFe+=dJWxmNwdo9rQzCjvoqJ9Frn_DOSpCw@mail.gmail.com>
In-Reply-To: <CAADnVQLjaKbe6JgPFe+=dJWxmNwdo9rQzCjvoqJ9Frn_DOSpCw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Jun 2023 09:29:56 +0800
Message-ID: <CALOAHbA13Akkxa4VWwBRVwB4-VWWH89Ux0oOAwJ1wiNyF-eVUw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 5:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 20, 2023 at 9:30=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > +enum bpf_perf_event_type {
> > +       BPF_PERF_EVENT_UNSPEC =3D 0,
> > +       BPF_PERF_EVENT_UPROBE =3D 1,
> > +       BPF_PERF_EVENT_KPROBE =3D 2,
> > +       BPF_PERF_EVENT_TRACEPOINT =3D 3,
> > +       BPF_PERF_EVENT_EVENT =3D 4,
> > +
> > +       MAX_BPF_PERF_EVENT_TYPE,
> > +};
>
> afaics MAX_BPF_PERF_EVENT_TYPE is completely unused.
> Every patch should be focusing on minimizing additions to uapi.

Will remove it. Thanks for the explanation.

--=20
Regards
Yafang

