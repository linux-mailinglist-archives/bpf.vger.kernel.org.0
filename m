Return-Path: <bpf+bounces-7546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C07790A7
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B08E281607
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8F17754;
	Fri, 11 Aug 2023 13:19:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7F63B3
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:19:44 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F426A0
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:19:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so18043465e9.3
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691759982; x=1692364782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saIHY7ip5g41OCU/hcmyPfu99P0NwzJeRYdAsrFaf+k=;
        b=jYotq3fM+kVPtBp1dvHT6P52oy4LCIkCxfUhBKpb+r6nG84A9hVIM9a5RXWJpD4gjn
         5P5y6IbVbsylRcu3gqvgylNoNq4UXl6CsNuHhbO4xb4BGAVHNcUC/XKhi+rcfnq/YlCS
         EXzWQYnkoirzd6b9dJeoj+wuGXp+b2DDs9gVVNAd/alVKmNafuOiG/4vhXK3LESfa0ty
         uJw7Y2vLKo2cvB6UyhiQek6RuMvbjaUv3QYZgeE/AeWiPlZglBFj+S+UTXKxv3qCvYdn
         vJsgN4fkHDnoLK2ngOg4Akywq2xGEz5aBi9NzErSypTPAUzklkn10WjI0c9ueUcZDhRq
         TV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759982; x=1692364782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saIHY7ip5g41OCU/hcmyPfu99P0NwzJeRYdAsrFaf+k=;
        b=dMifPaVs71HX0Vjw6oJxT4LhZembW7evAZ6jF35pepvTtF9YkJrFuszvORPq4g0F/w
         esh6PxG244gUFhdQxscrcIU0PT9hBcMJeIItTNsyAS9tsoMjyhuDOgPLVVrmnSFw3B4i
         XdLJqZUO3FgnkjRIVQ/MeH9Mii1jEC5Cy2o61UzKrTnAOZrTDkOynZmKRjGU8B7BsG5d
         KVKONUM7l+FfDG9JIgz/kum2cEzlPzwq1YNDKw+S4alYg1N91NJ3AFD3JqTigqpFMRyx
         Ty3IfYGR7Mt5n/Un8WD3u4fsOXfbtEllIpYkgeqrm5KxvCGUBGpPMCeKuTHEan/80jlO
         gfYA==
X-Gm-Message-State: AOJu0Yyz9yVjRZ9+2DvtQHfvgO4wY1s1YZn3DP2CPwmtxVuSzR2DtPSv
	cyXtNkLkg/43nBi+B121Cyk=
X-Google-Smtp-Source: AGHT+IF6ZhNjlPls18u1XlkmglkVavb+nnJEMJAheQTG95rQGq+uL7GG1U7+l4zs9XtGyqmPe6ANnQ==
X-Received: by 2002:a1c:7910:0:b0:3fe:20aa:ada0 with SMTP id l16-20020a1c7910000000b003fe20aaada0mr1635131wme.15.1691759981636;
        Fri, 11 Aug 2023 06:19:41 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003fe29dc0ff2sm5187561wmi.21.2023.08.11.06.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:19:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Aug 2023 15:19:38 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv7 bpf-next 04/28] bpf: Add cookies support for
 uprobe_multi link
Message-ID: <ZNY1asYGaZ9k3BtV@krava>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-5-jolsa@kernel.org>
 <ad33766a-3be9-0d77-bf98-add0ec42b206@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad33766a-3be9-0d77-bf98-add0ec42b206@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:39:53AM -0700, Yonghong Song wrote:
> 
> 
> On 8/9/23 1:34 AM, Jiri Olsa wrote:
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
> > Acked-by: Yafang Shao <laoar.shao@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Ack with a minor nit below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> > ---
> >   include/uapi/linux/bpf.h       |  1 +
> >   kernel/bpf/syscall.c           |  2 +-
> >   kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
> >   tools/include/uapi/linux/bpf.h |  1 +
> >   4 files changed, 44 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e48780951fc7..d7f4f50b1e58 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1639,6 +1639,7 @@ union bpf_attr {
> >   				__aligned_u64	path;
> >   				__aligned_u64	offsets;
> >   				__aligned_u64	ref_ctr_offsets;
> > +				__aligned_u64	cookies;
> >   				__u32		cnt;
> >   				__u32		flags;
> >   			} uprobe_multi;
> 
> The 'cookies' field is inserted into the middle of 'uprobe_multi'
> struct. Not sure whether this may cause bug bisecting issue or not.

the idea is to have all fields related to the 'cnt' field grouped

so the problem is that the bisect reproducer would fail on previous
patch because of the changed uprobe_multi layout, but it only got
introduced in previous patch, so we are close ;-)

I don't think it's real problem but I guess I could add 'cookie'
field in previous patch

thanks,
jirka

