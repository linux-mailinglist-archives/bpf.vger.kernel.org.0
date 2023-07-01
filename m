Return-Path: <bpf+bounces-3843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD26744819
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8434E281122
	for <lists+bpf@lfdr.de>; Sat,  1 Jul 2023 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B26525C;
	Sat,  1 Jul 2023 08:54:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5C3C1E
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 08:54:16 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC41197
	for <bpf@vger.kernel.org>; Sat,  1 Jul 2023 01:54:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so3219981a12.0
        for <bpf@vger.kernel.org>; Sat, 01 Jul 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688201650; x=1690793650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RjoG3d9gJLPJNG9ZeqimtifgBo7lPOhE7cr+hWlB3SQ=;
        b=L310er/veKXAkv+l4O/nf9EptKNrIoqxrFPqyP3QNnHb4v2yRh7lrr+n1Y0a5pPbPF
         dJNYNeoyfvWXFjUfDtxgq1iEEdTXt9DkTi6YyrWa5x8jPsMFffjEkZmFNBZHM4NcxOtz
         CCG5mzunuCjpYWjlwglLO+vQiZ2ncpzqxIttmIPqq3U0T8BgzxFjcW7nXmZFxo9ptMTf
         3nO8/Fz6Dik0qG1OKO7sGg0AsDWbhy4pWTV88mWGs7Anuh+jOaY39f9X+TucqcGlRMNJ
         v2tu8dbSMh04pUNbhTT9HVR5uQD3FRwddvO3TBNjute//JegKPOYiGkrslQve4hd/gA+
         X1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688201650; x=1690793650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjoG3d9gJLPJNG9ZeqimtifgBo7lPOhE7cr+hWlB3SQ=;
        b=V6KT+Pq+KNhNnV/czPfZU+ENA9GlIp9tokIMmzp/roY06PrhX1ALdbU/YnT1oCdZsR
         /LXpEMeoDDAh/1ay8K0BazVj1nqV4p18U2Jp2QtNeONm/qd89CvmnzVRGt/n3Qx26u+w
         VfHGLPd/TY599GrgeUKO/7dcEMcZ5S4EWsN8L+f/0nzrwzZPIohq4DO32izoa7B/s+/F
         WX2dTkyBRlQ4iAHXJVzc6x4EnmY07na4GDbO6mVHaIglL7hD6WKkKNxBIv6JjYBV8fy6
         yl6BqGJ/I0saBJ3c1Nwcqx7qgOzHl9FCs/S4ZmkYAgLQ21l35/IH+zsontsprALuRIqi
         BG5g==
X-Gm-Message-State: ABy/qLYNLtMFN8qus60DdOZYIryX4+m2Iv+5HoeKbL3ke0IiBjtPXWgX
	ZJLXNyw5JGIwAKZHYF066MA=
X-Google-Smtp-Source: APBJJlFLFCnWlSWbWTCeoRFgiyPg0xNbT0xLrfT8b1lRo3jacoa5rL+uXbILwbUKBym8mZqzNdwoiQ==
X-Received: by 2002:aa7:d94a:0:b0:51d:d393:3af2 with SMTP id l10-20020aa7d94a000000b0051dd3933af2mr3404544eds.16.1688201649698;
        Sat, 01 Jul 2023 01:54:09 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm7688911edw.87.2023.07.01.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 01:54:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 1 Jul 2023 10:54:05 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 03/26] bpf: Add cookies support for
 uprobe_multi link
Message-ID: <ZJ/prW5y7/QT5znb@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-4-jolsa@kernel.org>
 <CALOAHbDOdvNvFUMgQGvCVELKbbX4m6sokxqwdk1qwKMCzBCokA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDOdvNvFUMgQGvCVELKbbX4m6sokxqwdk1qwKMCzBCokA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 11:40:05AM +0800, Yafang Shao wrote:
> On Fri, Jun 30, 2023 at 4:34 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify cookies array for uprobe_multi link.
> >
> > The cookies array share indexes and length with other uprobe_multi
> > arrays (offsets/ref_ctr_offsets).
> >
> > The cookies[i] value defines cookie for i-the uprobe and will be
> > returned by bpf_get_attach_cookie helper when called from ebpf
> > program hooked to that specific uprobe.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           |  2 +-
> >  kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  4 files changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a236139f08ce..4103f395593b 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1592,6 +1592,7 @@ union bpf_attr {
> >                                 __aligned_u64   path;
> >                                 __aligned_u64   offsets;
> >                                 __aligned_u64   ref_ctr_offsets;
> > +                               __aligned_u64   cookies;
> 
> Could you pls. explain why the 'cookies' is defined as a pointer ? Are
> there real use cases to define different cookies for different probes
> in a single uprobe_multi ?  Why can't we just use one cookie for all
> probes?  Per my understanding, the cookie is used to identify the user
> or the application, rather than each probe.
> 
> We also defined it the same way in kprobe_multi...

yes, each probed function (or symbol/offset for uprobe) can get
its own cookie and we use that to get probe-specific config in
generic bpf program with the bpf_get_attach_cookie helper

jirka

