Return-Path: <bpf+bounces-8984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805A78D52D
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75EB1C20AC9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF63D62;
	Wed, 30 Aug 2023 10:46:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AD20E2
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 10:46:28 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC21BB
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:46:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cce6f7de2so710508866b.3
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693392385; x=1693997185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8jintge3+sTVJK2Uu77jvmcBVL90Gi5zBkTzekn+7A=;
        b=F78VD4BUhGA3J41a4PeaqH8pccvvKmOw4llRYgJD48C7cZIHVm22+NhAVk30Af7O93
         Nb3Ec+Xb8jh1RbNfPSo1evOt/tRWhgThSMcubxjY01V6Gy79Cz4M7TzyfIMETdB7KxQz
         vJnhFAtITl4KuKx6GRgiPIlF0n7DcGBawYAIIMGJXIa6XQ7+ebad5/O+UmzVlOXaThyz
         K+cF/TqelBtNFbGjSyRvpGHVA3zPfyrmcMKLO8WVTwv8ymW9c7peTDvw/HMwgFAPDJ2y
         Fyg3Ze3IT2i/zhiYoj+dsV6ieaHqe07F7zGCny7nicznEkTlcuibF6KqxxTCYJXTcZSL
         Xgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693392385; x=1693997185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8jintge3+sTVJK2Uu77jvmcBVL90Gi5zBkTzekn+7A=;
        b=e85gWGh/Z20FnUHP46ZfuWQb6sfIxG4RiFxyKzliIt5eav7XKHCLHjYf/DdNesGB7S
         aNdHJfQIDWqxRR7cqxUstKCkGv+v1y77SsPtF2WQkNi7p8lV2+t6NfgiNxWz8uoExwl9
         ggoAR/7FuztHWSXSf4plSJH/zsGfU4rqudM0vpqo9z9T2UcHcn65LaZ+Ib8kvbX/MtRr
         Ytnt2ho20M2p4ytnsmTmygqrMzWPEbyaPeG0Z7styDJNcPOCVIqVRON/93ZmimDH8vvL
         erlg25aKU3qa3gCCJPEPF/H6kNdPWKDgaLdNmuNnpf/b6csC1o3pZuvm2ZxY9wQxVDOy
         DB1w==
X-Gm-Message-State: AOJu0YxrVzM9LE86kxJqwulRvsTCRvnQXWPdZ4EfPqzMdxykCPKj73YU
	BeZXkrvZdDPVPh//SnJ+vPw=
X-Google-Smtp-Source: AGHT+IHJbjxMr/igvLMZuUTWmS3/co5BgU+q67TmOMCyidtLtILOdl5EG/OxQzVf6rMFsuHexd7aDw==
X-Received: by 2002:a17:906:5347:b0:9a1:fe9c:eee5 with SMTP id j7-20020a170906534700b009a1fe9ceee5mr1344554ejo.63.1693392385130;
        Wed, 30 Aug 2023 03:46:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qq21-20020a17090720d500b0099329b3ab67sm7082975ejb.71.2023.08.30.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:46:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Aug 2023 12:46:21 +0200
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
Subject: Re: [PATCH bpf-next 09/12] bpftool: Display missed count for
 kprobe_multi link
Message-ID: <ZO8d/edSSaztiY0I@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-10-jolsa@kernel.org>
 <26a20b9f-839a-4748-9cf4-4eac1e46ce00@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a20b9f-839a-4748-9cf4-4eac1e46ce00@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 05:40:57PM +0100, Quentin Monnet wrote:
> On 28/08/2023 08:55, Jiri Olsa wrote:
> > Adding 'missed' field to display missed counts for kprobes
> > attached by kprobe multi link, like:
> > 
> >   # bpftool link
> >   5: kprobe_multi  prog 76
> >           kprobe.multi  func_cnt 1 missed 1
> >           addr             func [module]
> >           ffffffffa039c030 fp3_test [fprobe_test]
> > 
> >   # bpftool link -jp
> >   [{
> >           "id": 5,
> >           "type": "kprobe_multi",
> >           "prog_id": 76,
> >           "retprobe": false,
> >           "func_cnt": 1,
> >           "missed": 1,
> >           "funcs": [{
> >                   "addr": 18446744072102723632,
> >                   "func": "fp3_test",
> >                   "module": "fprobe_test"
> >               }
> >           ]
> >       }
> >   ]
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 0b214f6ab5c8..7387e51a5e5c 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -265,6 +265,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  	jsonw_bool_field(json_wtr, "retprobe",
> >  			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
> >  	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> > +	jsonw_uint_field(json_wtr, "missed", info->kprobe_multi.missed);
> >  	jsonw_name(json_wtr, "funcs");
> >  	jsonw_start_array(json_wtr);
> >  	addrs = u64_to_ptr(info->kprobe_multi.addrs);
> > @@ -640,7 +641,9 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
> >  		printf("\n\tkretprobe.multi  ");
> >  	else
> >  		printf("\n\tkprobe.multi  ");
> > -	printf("func_cnt %u  ", info->kprobe_multi.count);
> > +	printf("func_cnt %u", info->kprobe_multi.count);
> > +	if (info->kprobe_multi.missed)
> > +		printf(" missed %llu", info->kprobe_multi.missed);
> 
> Nit: If you respin, please conserve the double space at the beginning of
> "  missed %llu", to visually help separate from the previous field in
> the plain output.

right, will fix that

> 
> Looks good otherwise, thanks!
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

thanks,
jirka

> 
> >  	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> >  	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
> >  
> 

