Return-Path: <bpf+bounces-2808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44D734347
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E902813CE
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C24C8F4;
	Sat, 17 Jun 2023 19:17:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E65A945
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 19:17:01 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E121BD
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 12:17:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso2416818a12.3
        for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687029418; x=1689621418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/QBxXvVSFdiMIxzQqkzHz1C2fxSlsYJ6syGf94gShY4=;
        b=qM+REUJpvk849D//GXu23SZFJcZN+9qqCHQTqnZPJRwDopTeecpPQ33op7Tsu2EKaz
         Msxn9hNCMKjGWtGsM9kCYHfAzRkH191AAXr2sVFKCReSzee9DspemoKttbPEJcYXISq3
         YP/ODFL1BPetg0YKotRgFVx0Y2vP39zSsxRWvEWc0+GNMuTL5oCJxuH0lSl21dN1lJe1
         h/1OtMM4Un0193obGcgivics4gS0luchqreVaPz2PxN+ai0aPIqLrP/9spS6lusHRVPC
         GPEENQ3kl5KbDRQ4oF++qg4OCtjb06KZ1yadHXx2FqOdip+jybZEr1KJmGG+NhZ0ekje
         Cuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687029418; x=1689621418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QBxXvVSFdiMIxzQqkzHz1C2fxSlsYJ6syGf94gShY4=;
        b=Iu5znSwJD84QJeW97B8iJe//ZvD77K8CUg8t9097nTYH52yl0kxer9jSKnoutD5uRJ
         HpOVCqzo7wU9J3tEe2PaqPjX2YgRsUcdEbXjhp6g43MpGxDvq13NXAH8HDwI9h6UmBVR
         OsDmFcKCR7N9T9dz3IRFr3eGKh5nbnEYDemjxzTJB1aUQZKbohFMn94Fa/uC/tiwh321
         1FeX/kgdl8Dh8VyT3AbqqOR65TZfsEsInxB4AzMC61uOBrnn7mh6zQl80fxoFtU9heFl
         0580MyNkaVSxM9eoPpKUc+9T2qHhO7zt6NrMOOWLLqirnr5TEu9UZNjMDuMh3Ym6kw7o
         UhWQ==
X-Gm-Message-State: AC+VfDwuS6JCfmsAAobMhkwM9EvCH+PmboUWdHc+Xqx026XDZN9QVefQ
	9cbQjyN7DByFfqY0oJ6w2s8=
X-Google-Smtp-Source: ACHHUZ56791DjZrzhH/IaoYdT+8JATFBNcrwtTuoAcQ9gOyRE2WmNM6K6UH11WphznQIjUgx7kRk1g==
X-Received: by 2002:aa7:d78d:0:b0:51a:4557:2caf with SMTP id s13-20020aa7d78d000000b0051a45572cafmr1529620edq.34.1687029418367;
        Sat, 17 Jun 2023 12:16:58 -0700 (PDT)
Received: from krava ([83.240.63.131])
        by smtp.gmail.com with ESMTPSA id u13-20020a50eacd000000b005149b6ec1bdsm11182338edp.29.2023.06.17.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 12:16:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 17 Jun 2023 21:16:55 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Force kprobe multi expected_attach_type for
 kprobe_multi link
Message-ID: <ZI4Gp1dI0JtDM9Kx@krava>
References: <20230613113119.2348619-1-jolsa@kernel.org>
 <CAEf4BzaoecaejztBK9O+hbh1d-g_iTSXgpDrJAZmcaWYiWBn3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaoecaejztBK9O+hbh1d-g_iTSXgpDrJAZmcaWYiWBn3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 09:53:00AM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 13, 2023 at 4:31 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We currently allow to create perf link for program with
> > expected_attach_type == BPF_TRACE_KPROBE_MULTI.
> >
> > This will cause crash when we call helpers like get_attach_cookie or
> > get_func_ip in such program, because it will call the kprobe_multi's
> > version (current->bpf_ctx context setup) of those helpers while it
> > expects perf_link's current->bpf_ctx context setup.
> >
> > Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
> > only for programs attaching through kprobe_multi link.
> >
> > Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with kprobe multi link")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 0c21d0d8efe4..e8fe04a5db93 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4675,6 +4675,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >                 ret = bpf_perf_link_attach(attr, prog);
> >                 break;
> >         case BPF_PROG_TYPE_KPROBE:
> > +               if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> > +                   attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> 
> there is a separate expected attach type validation switch above this,
> shouldn't this go there? We also have
> bpf_prog_attach_check_attach_type() call above as well, and tbh by now
> I'm not sure why we have like three places to check conditions like
> this... But I'd put this check in either
> bpf_prog_attach_check_attach_type() or in the dedicated switch for
> attach_type checks.
> 

bpf_prog_attach_check_attach_type looks good, will move it there

thanks,
jirka

