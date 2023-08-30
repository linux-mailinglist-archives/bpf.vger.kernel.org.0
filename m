Return-Path: <bpf+bounces-8994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E578D762
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 18:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257561C20400
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658F7475;
	Wed, 30 Aug 2023 16:01:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E56525E
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:01:10 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9762193
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 09:01:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so55756891fa.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693411266; x=1694016066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WGwiICbPZooSECNAqi/C1KJ8WOBs76g+zAYmIRU8D0=;
        b=pwP/dl/w14gJXX+XcLyFJy/gsBJjtdfMq26+AojTUfoJJ/PGtGK+efKKljs8IEJzAj
         +K9VK+9mOw89aEuiX/uCeAzP3OEt6pkBA+J+OLf+yJ3Sqq6Rub0tlmWSdnGllTKyt7fF
         J8VqEu45pqyUufHtbXqcUKtUQ9oEA/BFPgCSQk/c8llguiigfhJOiHD9Z6uiyVo6A0Xb
         M5687edq/0AqXm2bIlsX8h+2ZNZQUII1DP7U+etMB0hz+/NThBvC2PvjWHQfRKVLHpNh
         xAogN9QLaHkysaRONSBg6swDGNEKSGIFLuQj6kAPV+Mis6Ctet5SivETG2uTwrNvf3u+
         eZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411266; x=1694016066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WGwiICbPZooSECNAqi/C1KJ8WOBs76g+zAYmIRU8D0=;
        b=Oy1PDjOWqG5yAStZaHueTJCr1hH4LkkJcMtCXdwC8OdHkJADhzaX9xDpvODddFVN05
         wrGKzpcQrlGh1FDYD7dlGEz1B9BEgnb/1ZS8YCG8kfnKAtQ8TYntTBqPqGqO9RuG2zZx
         0FCF4pcK2CPMnEkbMWKcATYwVEKFGWb9F4Gu7OrtASJZoEWmsd6SFeygbpBuv5HkdIFo
         Q3H+o1biwbzJLObCl/v4AoIO66i6Oz+/JiND/NVJXOe5sgeyfAOwiZFvOt6/DfFUsgPf
         7RCvPopS6466lbJ37ICJU0lsIRGFNrj3c0JsRhD9OVtSLBhW2x2Snvt+IcM0RSXHGB+f
         emug==
X-Gm-Message-State: AOJu0Yz2y5p46OvH8Xyk/TknNoaJSjULxz8m6/WdD0Qmpt2PkNlZEQa7
	Es9LR+IW0GukIjgbRMz6ThI=
X-Google-Smtp-Source: AGHT+IHDkjIrMyLWyVFn+ZpZS9VxsPddOiIIQjSWdHRrPYLH79FoNa+FlaAwT3qLVRQNR1KgY/N9Dg==
X-Received: by 2002:a2e:9dcc:0:b0:2bc:cdcf:d888 with SMTP id x12-20020a2e9dcc000000b002bccdcfd888mr2158522ljj.46.1693411265606;
        Wed, 30 Aug 2023 09:01:05 -0700 (PDT)
Received: from krava ([83.240.61.136])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0098e16f8c198sm7409483ejn.18.2023.08.30.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:01:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Aug 2023 18:01:02 +0200
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH bpf-next 10/12] bpftool: Display missed count for kprobe
 perf link
Message-ID: <ZO9nvixaUMUf//rs@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-11-jolsa@kernel.org>
 <1524610f-547d-48f6-bc71-671357e32ff3@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524610f-547d-48f6-bc71-671357e32ff3@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 05:42:49PM +0100, Quentin Monnet wrote:
> On 28/08/2023 08:55, Jiri Olsa wrote:
> > Adding 'missed' field to display missed counts for kprobes
> > attached by perf event link, like:
> > 
> >   # bpftool link
> >   5: perf_event  prog 82
> >           kprobe ffffffff815203e0 ksys_write
> >   6: perf_event  prog 83
> >           kprobe ffffffff811d1e50 scheduler_tick missed 682217
> > 
> >   # bpftool link -jp
> >   [{
> >           "id": 5,
> >           "type": "perf_event",
> >           "prog_id": 82,
> >           "retprobe": false,
> >           "addr": 18446744071584220128,
> >           "func": "ksys_write",
> >           "offset": 0,
> >           "missed": 0
> >       },{
> >           "id": 6,
> >           "type": "perf_event",
> >           "prog_id": 83,
> >           "retprobe": false,
> >           "addr": 18446744071580753488,
> >           "func": "scheduler_tick",
> >           "offset": 0,
> >           "missed": 693469
> >       }
> >   ]
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 7387e51a5e5c..d65129318f82 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -302,6 +302,7 @@ show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  	jsonw_string_field(wtr, "func",
> >  			   u64_to_ptr(info->perf_event.kprobe.func_name));
> >  	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
> > +	jsonw_uint_field(wtr, "missed", info->perf_event.kprobe.missed);
> >  }
> >  
> >  static void
> > @@ -686,6 +687,8 @@ static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> >  	printf("%s", buf);
> >  	if (info->perf_event.kprobe.offset)
> >  		printf("+%#x", info->perf_event.kprobe.offset);
> > +	if (info->perf_event.kprobe.missed)
> > +		printf(" missed %llu", info->perf_event.kprobe.missed);
> >  	printf("  ");
> >  }
> >  
> 
> Same comment as for the previous patch: double space between fields in
> plain output please. Thanks!
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

will fix, thanks

jirka

