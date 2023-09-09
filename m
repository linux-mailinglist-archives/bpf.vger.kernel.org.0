Return-Path: <bpf+bounces-9604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C67799A77
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399CA2817CF
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF77496;
	Sat,  9 Sep 2023 18:51:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71C7460
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 18:51:28 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA9180;
	Sat,  9 Sep 2023 11:51:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso33282885e9.0;
        Sat, 09 Sep 2023 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694285485; x=1694890285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qg88dO00bRwdlF+BFm/svHoU3qGnTY68n2/d01bRZco=;
        b=ElklnI419pPEMlKGNRqk2K99rmVexgLawpVMaSL+3O9rRHjthR/2pETBzu7ZFPK21Q
         lPbPE/IICF/sBR8BpK+qod7N95tDvMTzKmRd2IWq7PXegEJDZueG9P/EP5iMDfQfciiJ
         GaNF+aA80QKHR+5XXyIky1q2m7BnGZkKDiAbUXgrdioVmMqvdvlFWGQSDvi4ONwawQtU
         xveh+jwhz6xHG6lvvJ9K2fbtfgUY3mLrD9I2JP8Oof6itxRahhRNz9FeZ/JQgH6ypqtg
         y3TfNMdzu+fk3ZTKQba5K8sw1v7lVa1J+bOYK9lygC6qzXKR2BG1lk/Cam6UierySZzo
         pbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694285485; x=1694890285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg88dO00bRwdlF+BFm/svHoU3qGnTY68n2/d01bRZco=;
        b=MrtdzH2lVAAk7amjTsqh7P2GtbeASKpwm9O+fnh1mOu23kul8Fd/FdiSf8+jXWdbHs
         qtoPFx808Embjne7dfDMjvS2dxYzSigQqSmfCiVcQXrw3t41+Vd/UHpanTjIvhXurIcH
         Fe0FODP9MJ7toYBDNXB4GAILamJ3kC/BVnTZJBqAuZiEw0BtbgZiXteu1wOP2o6gEhs1
         mD3WDPDFbij74VzF49dVhJZOn4ZOoEBcuztlOEDjxHU2NaWjJAH4sKbaFuEsr1VrirtB
         5spH18eBwgFruU8IXkXZDSK+Aou5W6EOGJP/D4dNSur4cwPxAzaN2czgWZbBKmps/nJj
         ermw==
X-Gm-Message-State: AOJu0YyVapz/zUUaphV7+Z7PGM4KtFPfjUwTITcOQPSoOzy+ah/FDJTr
	5Q2Bn2KJcavEuqw3Oi3fP6CvjadbGik=
X-Google-Smtp-Source: AGHT+IElAJKfISRNNoJ0W8gDMVvG1j6mkS9Tzigx6QQQDzOubfB1JZgxnduyFfKaieMIvnKQ3Unqqg==
X-Received: by 2002:adf:ea92:0:b0:317:e1a2:dccf with SMTP id s18-20020adfea92000000b00317e1a2dccfmr4623927wrm.62.1694285485398;
        Sat, 09 Sep 2023 11:51:25 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id f18-20020adffcd2000000b00317b5c8a4f1sm5441104wrs.60.2023.09.09.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:51:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 9 Sep 2023 20:51:22 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link
 attach
Message-ID: <ZPy+qpHt2JrVqCVZ@krava>
References: <20230907200652.926951-1-jolsa@kernel.org>
 <2deafa8c-94cb-247a-2a8f-97f756f28898@oracle.com>
 <CAEf4BzZ_=AQ2rt1z=FUE6QoHq44Y_fCmh+xjbn-39NhLw5-VNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ_=AQ2rt1z=FUE6QoHq44Y_fCmh+xjbn-39NhLw5-VNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 04:50:54PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 8, 2023 at 6:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 07/09/2023 21:06, Jiri Olsa wrote:
> > > Currently the multi_kprobe link attach does not check error
> > > injection list for programs with bpf_override_return helper
> > > and allows them to attach anywhere. Adding the missing check.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > For the series,
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > ...with one small question below...
> >
> > > ---
> > >  kernel/trace/bpf_trace.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index a7264b2c17ad..c1c1af63ced2 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2853,6 +2853,17 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
> > >       return arr.mods_cnt;
> > >  }
> > >
> > > +static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
> > > +{
> > > +     u32 i;
> > > +
> > > +     for (i = 0; i < cnt; i++) {
> > > +             if (!within_error_injection_list(addrs[i]))
> > > +                     return -EINVAL;
> >
> > do we need a check like trace_kprobe_on_func_entry() to verify that
> > it's a combination of function entry+kprobe override, or is that
> > handled elsewhere/not needed? perf_event_attach_bpf_prog() does
> 
> multi-kprobe programs are always attached at function entry, so I
> believe it's not necessary?

yes, fprobe allows only function entry.. should have put it in comment

thanks,
jirka

