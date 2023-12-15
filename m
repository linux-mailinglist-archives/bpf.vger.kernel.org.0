Return-Path: <bpf+bounces-18045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C01C98151E8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB26B23863
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77947F71;
	Fri, 15 Dec 2023 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUItJuQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2C82ED1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so6337165e9.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702675609; x=1703280409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWXwCAXYU+fJuD51DzYkw9R0jWW3OdNjH0Vt+NapsOE=;
        b=fUItJuQGooCD70qjPdc7kcOazCQPiwB8M4t9v0mncVfIvcHhPNz8WnKDwdDYXBK6RP
         TDLVZbL2xVKPcFZ7lgnOpKlQ4k0LLZS8XKiIZWwfkk6JK5ShEFz5VqZs9eWFTPaBIAG/
         mEB72H2m6sAeru9Q3teDs7EAmWpRKV3WphEiLNcplggWSfR054frdR3Q0NOF3xhKmRi8
         tJLyvCuSIcXre/YBDwC3M4/XE2H+N9p2Uc284PbJMQ6WaEj9Bqz70XyBExcR7cNP++EA
         ndRKR/ZttPHIfxjzVf3J1yxM0ON63wYWwTFh+AL+/Yf2W/b0w47fDlo2VIUFDGCWJqwr
         5DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675609; x=1703280409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWXwCAXYU+fJuD51DzYkw9R0jWW3OdNjH0Vt+NapsOE=;
        b=RaTbG6fCGSYTp7OoAmiCZ2npbSVPM2FbeIZ3kM1hknTkRisnMTpUVo4/IwXfMzk7ka
         RhxVdtegqMvhYEeDy1QRMr4D9yNBZXEFHoQwsMnfXoJtwzqXqwAx4a6eOk7WR6ZF5qsy
         d2cDou+AqKQYEaZVkvxe8ZxL6ygu2Hex4e8pGkk0bxE66ZzJpsUsMsYbJZuMvZxRu+Yv
         ze98aMCbC0BA8gOKqIYYVyE5GwmRwffQt4lRuvxiNQlfqCPqcxXcOZI7bP3a2ALcAkVW
         EGu8rOlDnZZ45c5czpnHumdap38b1rWAnr22SR3XF+J7C30xq1BUuS+hFQ6pAKLZ02Su
         ZUqg==
X-Gm-Message-State: AOJu0YxIe5vIA8e3G6NHUWW64gfxM8Diswiiam+AIPzJaxiOnc7w8BKz
	d5Vxcxley3aUM4T5g7ALEXA=
X-Google-Smtp-Source: AGHT+IF8g7pNixRR9qr6nE2bu1A5MTmwcufUAnUfajtRx6kh4nmHsgI8nGaMt7zktcj717bG5NiH9w==
X-Received: by 2002:a05:600c:b93:b0:40c:6e2a:6d3 with SMTP id fl19-20020a05600c0b9300b0040c6e2a06d3mr475256wmb.167.1702675608766;
        Fri, 15 Dec 2023 13:26:48 -0800 (PST)
Received: from krava ([83.240.61.143])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0040c37c4c229sm27780538wmq.14.2023.12.15.13.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:26:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 22:26:46 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Add missing BPF_LINK_TYPE invocations
Message-ID: <ZXzEloVywUSVRqAh@krava>
References: <20231215091826.2467281-1-jolsa@kernel.org>
 <841653bd-a32f-71db-b26a-e44fa6370358@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841653bd-a32f-71db-b26a-e44fa6370358@huaweicloud.com>

On Fri, Dec 15, 2023 at 06:10:55PM +0800, Hou Tao wrote:
> 
> 
> On 12/15/2023 5:18 PM, Jiri Olsa wrote:
> > Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.
> >
> > The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> > link and for several other links, adding that.
> >
> > [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
> >
> > Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> > Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> > Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
> > Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Some BPF_LINK_TYPE() definitions below can be guarded by CONFIG_xx
> macro, but I think it doesn't matter here, because these definitions are
> only used in bpf_link_type_strs(), so

ah right.. will send v2 also with Andrii's suggestions

thanks,
jirka

> 
> Acked-by: Hou Tao <houtao1@huawei.com>
> 
> >  include/linux/bpf_types.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index fc0d6f32c687..38cbdaec6bdf 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -148,3 +148,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> >  #endif
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> 

