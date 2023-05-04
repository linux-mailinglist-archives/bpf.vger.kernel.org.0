Return-Path: <bpf+bounces-53-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E66F797D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55231C215F0
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA313C159;
	Thu,  4 May 2023 22:55:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2658156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:55:04 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C51329E
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:55:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso1038527a91.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240902; x=1685832902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Y3WaB+7u68QVLTvqAImIwBX+k2ZH3QEYhYnY5U75TQ=;
        b=qM8iQmVnCPlKV9E4Llu5uMhb8Qvc1dPXm6IJr28uY4FN/wlQA6v1WQoilV5kMIriOn
         VN3nFzu2BwuFBxpa8PfkjOFQeagiSLxY+zcuzV18P6f7VDOyyypuF48De+WLLLfSkO/i
         ZawKzJ+mHYPHRxUPZPzrVQMYVon9I7Mx/sDSb30jhN6plNRLoT3wMDxvO40YcgXX05Lv
         +3Dfppr1/MljqrZeHAYPUMLpl4UivYx/3wJ+MD6HCJPjnlcwQtcgCxmzsdNXv6LIkLPy
         CWtBbb1mYnXq3I6+OkZB0GRc8Mz7C6ElJb8sCAbswO8q6yz0wlhu97TgfkAR/gWNEu61
         AiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240902; x=1685832902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y3WaB+7u68QVLTvqAImIwBX+k2ZH3QEYhYnY5U75TQ=;
        b=ETJR1uMxiENQiVhOzYFaOCeta7lPWrGNWkk1B6YXaszeaX2ATLfiyBrtzxV3FhWjSb
         8/bJkRm8AgK5xw/YjY/bTobYYnxw18XoEKY1G1IogaosV+FncAh/pP6cOHEzyFmhWfBG
         0gH0vnZSCTkxThyvrLDYfU2z7L2LjN1QBxIiLYpE0RNYH6/FC+xUzMy84ptqOFYxko5d
         vruEi0d7TjSIsExNBNlZySOKctdRlNYAbtX4mysvHrrFG9YUP5SX44r07c3eVm516Rmq
         yrncm47/x/9ZJXuuT+/AV2NcIVLzp8R+x5LXorDWLaat8+iybyjiJlnyy9DhHG14y2Ph
         qmiA==
X-Gm-Message-State: AC+VfDxIDFaWzmY2DaCMA4f5Dwq37fS0rUy/af4AxkGeJv9V8tQq/P9o
	fIy1ccbDwBwFiRb/z8Vm0WE=
X-Google-Smtp-Source: ACHHUZ6rwtn9Hqmi8apr9gcC0f0XPeUya0jXcnLGXWH53gWmb0nD2yd+x9mCgRKMyygG7voWEch4mA==
X-Received: by 2002:a17:90b:4c41:b0:24e:534f:7b70 with SMTP id np1-20020a17090b4c4100b0024e534f7b70mr3111701pjb.48.1683240902006;
        Thu, 04 May 2023 15:55:02 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id z19-20020a63e113000000b005142206430fsm191552pgh.36.2023.05.04.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:55:01 -0700 (PDT)
Date: Thu, 4 May 2023 15:54:59 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 04/10] bpf: remember if bpf_map was unprivileged
 and use that consistently
Message-ID: <20230504225459.fjbvxfx45m7ym5ft@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-5-andrii@kernel.org>
 <20230504200544.mikkqyc7h7ftxal3@MacBook-Pro-6.local>
 <CAEf4BzbT1MNiUC5A0MTFjVvYOsXnh06SHukGgvzx-wdjRV8uHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbT1MNiUC5A0MTFjVvYOsXnh06SHukGgvzx-wdjRV8uHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 03:51:16PM -0700, Andrii Nakryiko wrote:
> On Thu, May 4, 2023 at 1:05 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, May 02, 2023 at 04:06:13PM -0700, Andrii Nakryiko wrote:
> > >  }
> > >
> > > -static struct bpf_map *array_map_alloc(union bpf_attr *attr)
> > > +static u32 array_index_mask(u32 max_entries)
> > >  {
> > > -     bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
> > > -     int numa_node = bpf_map_attr_numa_node(attr);
> > > -     u32 elem_size, index_mask, max_entries;
> > > -     bool bypass_spec_v1 = bpf_bypass_spec_v1();
> >
> > static inline bool bpf_bypass_spec_v1(void)
> > {
> >         return perfmon_capable();
> > }
> >
> > > +             /* unprivileged is OK, but we still record if we had CAP_BPF */
> > > +             unpriv = !bpf_capable();
> >
> > map->unpriv flag makes sense as !CAP_BPF,
> > but it's not equivalent to bpf_bypass_spec_v1.
> >
> 
> argh, right, it's perfmon_capable() :(
> 
> what do you propose? do bpf_capable and perfmon_capable fields for
> each map separately? or keep unpriv and add perfmon_capable
> separately? or any better ideas?..

Instead of map->unpriv I'd add map->bpf_capable and map->perfmon_capable
just like we'll be doing to progs.

