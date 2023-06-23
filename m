Return-Path: <bpf+bounces-3243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A273B298
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B941C2105C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9D2106;
	Fri, 23 Jun 2023 08:21:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C520E4
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:21:42 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C3212C
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:21:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso362775f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687508490; x=1690100490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BAROl3zysUoHqWEgKlzyyXHZlcOcMgghjEDqCOgxJA=;
        b=CWAJfwF9guGvg4j8gRv2zxdUZEaH92osCKalVeIidIVr8yudq//cvq/uWvGZ7o8I7Q
         VTHY82jSQCPWAccWK+n+UfNRKe/Pbug7s9ZYZIrRaSSafm94kwLAp+3/eP2iIRs1JPXG
         u9AS+ME0NKjHqYMy+TonGgUgFEGN1GZCRcGYD7g48pH6H39R2iJ0QUQuv2skCyiJuUx6
         HEGB4hSziVCXIZqUTZYY3e175Hefdnry55zu2ZyBqWL55xsvOmF5anzpwiPpYI6M7uQw
         v58awJny5J7hsXdaxt8LVdSpinMypTckxI75TRedxgMmf7M5l5ZUDNdkrQdqDEDNX/SI
         4WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508490; x=1690100490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BAROl3zysUoHqWEgKlzyyXHZlcOcMgghjEDqCOgxJA=;
        b=bVGesvBoHcQH39uORulGOoJVkQXOVU8awvpTuomUZBeTBx/P0muKp63X90XuBRvSgy
         RSweilg8yp1/pB2nVgqTOilJ0Cu0IOaFfhc/4Hk3R2Syb5ssdM3fmaRuiIYrMV43ptA5
         bsHhmKOQXLDTh6HUzbOxp4aPSaXkpw0EgXuv/7xLHvcH3XxmHicYytDsbswISfZoqlN/
         EP4cMoqGGg5dVlioTMLa7NesTVdkeyYtqF6r1GWxJBpX8FVsVj7+grekgEZW03b8R99L
         oMkhWXr/yT8DfGX9mpbbyu/71rPE/YeVBbj26xP0Cc2Gt/9eZjtV8NwJnwpV6D32EjJD
         NhJg==
X-Gm-Message-State: AC+VfDxv97A0v+2q5bDM+XM7I+Io5KACBsGnjno9TflrCciQm+RR9CH/
	Xzknsb9h0+ZCpVsqihIc9CM=
X-Google-Smtp-Source: ACHHUZ7RDLCDkXv0csxLLQzeYMIGEKl+0QfJmQ6+IaMKHRrSh9ixoE2RaK1XSmYQo5j3G2utP/Md+Q==
X-Received: by 2002:adf:ee8f:0:b0:30a:dee7:e48e with SMTP id b15-20020adfee8f000000b0030adee7e48emr14283054wro.8.1687508489897;
        Fri, 23 Jun 2023 01:21:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d4610000000b003112dbc3257sm8954960wrq.90.2023.06.23.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:21:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 10:21:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 07/24] libbpf: Add open_elf/close_elf functions
Message-ID: <ZJVWB1gpRdJRPSNS@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-8-jolsa@kernel.org>
 <CAEf4BzZAVUycbMeCMjGN8Sh+sR3Fe84neU1fkt_xp0EVMQe3CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZAVUycbMeCMjGN8Sh+sR3Fe84neU1fkt_xp0EVMQe3CA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 05:33:33PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding open_elf/close_elf functions and using it in
> > elf_find_func_offset_from_file function. It will be
> > used in following changes to save some code.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 44 insertions(+), 18 deletions(-)
> >
> 
> we should definitely move all this into separate elf.c file

right, also we could use this in usdt_manager_attach_usdt as well


> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index cdac368c7ce1..30d9e3b69114 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10927,6 +10927,45 @@ static struct elf_symbol *elf_symbol_iter_next(struct elf_symbol_iter *iter)
> >         return ret;
> >  }
> >
> > +struct elf_fd {
> > +       Elf *elf;
> > +       int fd;
> > +};
> > +
> > +static int open_elf(const char *binary_path, struct elf_fd *elf_fd)
> > +{
> > +       char errmsg[STRERR_BUFSIZE];
> > +       int fd, ret;
> > +       Elf *elf;
> > +
> > +       if (elf_version(EV_CURRENT) == EV_NONE) {
> > +               pr_warn("failed to init libelf for %s\n", binary_path);
> > +               return -LIBBPF_ERRNO__LIBELF;
> > +       }
> > +       fd = open(binary_path, O_RDONLY | O_CLOEXEC);
> > +       if (fd < 0) {
> > +               ret = -errno;
> > +               pr_warn("failed to open %s: %s\n", binary_path,
> > +                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> 
> let's add "elf: " prefix for consistency?

ok

jirka

