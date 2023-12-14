Return-Path: <bpf+bounces-17808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A7812B1E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 10:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ADD1F2192D
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271128694;
	Thu, 14 Dec 2023 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1lwOUDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184AA6
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:07:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so50486755e9.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 01:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702544862; x=1703149662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvS5P66rc0nwow6ARE45ZV15TmyCYzF3xT2YGq26yN4=;
        b=M1lwOUDPJrXj4/9rAkIV5QFq+Oo/O4K5mevLGDChUaTAkqUYtkr/E9B7mMMMVaMnxS
         RJQLGvf8dn0JA9cQc0kSva0P656NMH9wjS4UxkGcoD/ZRz2A5OX2chloptvyKhRyXE7+
         GdNaMA23Jj+jjeQjjSj7IXIjZVJ0dxvpNRBw0Sn4f/l/WesWD7w3lwfC+pRoAuwWvFw+
         NwK98Cct8MU/ni5P9NU+Is9aoAGW2mn66n1JbY6N5oYKlyMeM1JeIV/v2C7Gg6RDVjp+
         5my0uY3+unzxoqAFsYM7cdY2U4C8ZguTxAaUuDFGyNwwjMUK1W+2DZFkn7R90Vv7kuoj
         NP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544862; x=1703149662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvS5P66rc0nwow6ARE45ZV15TmyCYzF3xT2YGq26yN4=;
        b=a51IclKfIjfWLGi+tiaCWYnlIVZSsxAzJzJRqC/UBHxw9ptdXz25j4lv4HautJgT0X
         Cw1fUEQO2hZip7UrlMlXOctKJsY/1icu6llb5fcgYTm4Dv5hlMrNeK/v0t0gfftqbSIp
         KP3G+WbnmuPH27z4qzw8O5dQ3AK3LsK8c/4f3VA3Nm9EkmNGa1il5EQ1Q76hTpE4uDLA
         iCcP6y9isg7A26G+QH7F0RNDTZmsoilMfhdpoGm0umXpIDCcOzqVquw+3rhE0o7UU1AX
         G+lLAYQdn703HDwbQBT6i07G7QEpKij3ZcuP9yl6SkkBU4jU11PwmpIEo6ujyZ7p1B9x
         oGWA==
X-Gm-Message-State: AOJu0YwuxSnqYVrlGKNnpUBNU4QOMGGrzVZAK+kLQILxcg6fuwxntGuZ
	n9sdT5uvCRre9SvlUn2Imik=
X-Google-Smtp-Source: AGHT+IFb3zhlqAFdd1o/CQ7RL993bcfh3SbkSOy3eFe4Sz8LwcQnk+WF4qXViW+Xh81Hw8FjwsPpbw==
X-Received: by 2002:a05:600c:4591:b0:40c:256a:9c9 with SMTP id r17-20020a05600c459100b0040c256a09c9mr4704687wmo.40.1702544861879;
        Thu, 14 Dec 2023 01:07:41 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b0040c488e4fb5sm13870399wmo.40.2023.12.14.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:07:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Dec 2023 10:07:39 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative
 offset
Message-ID: <ZXrF25fC4V8RtHqU@krava>
References: <20231213141234.1210389-1-jolsa@kernel.org>
 <CAEf4BzbfdR+-ZXVvfmbc+Scb9i6SDqDG4C-4RvQE6vq8Pzcqow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbfdR+-ZXVvfmbc+Scb9i6SDqDG4C-4RvQE6vq8Pzcqow@mail.gmail.com>

On Wed, Dec 13, 2023 at 03:43:04PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 13, 2023 at 6:12 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently the __uprobe_register will return 0 (success) when called with
> > negative offset. The reason is that the call to register_for_each_vma and
> > then build_map_info won't return error for negative offset. They just won't
> > do anything - no matching vma is found so there's no registered breakpoint
> > for the uprobe.
> >
> > I don't think we can change the behaviour of __uprobe_register and fail
> > for negative uprobe offset, because apps might depend on that already.
> >
> > But I think we can still make the change and check for it on bpf multi
> > link syscall level.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 774cf476a892..0dbf8d9b3ace 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                         goto error_free;
> >                 }
> >
> > +               if (uprobes[i].offset < 0) {
> 
> offset in UAPI is defined as unsigned, so how can it be negative?

right, but then it's passed to uprobe_register_refctr as loff_t which is 'long long'

jirka

> 
> > +                       err = -EINVAL;
> > +                       goto error_free;
> > +               }
> > +
> >                 uprobes[i].link = link;
> >
> >                 if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > --
> > 2.43.0
> >

