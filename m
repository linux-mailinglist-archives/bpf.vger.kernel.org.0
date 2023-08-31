Return-Path: <bpf+bounces-9040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A278EA57
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2DA281488
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E28F55;
	Thu, 31 Aug 2023 10:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC963CC
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 10:42:24 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CACF3
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 03:42:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3904430a12.1
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693478540; x=1694083340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AI1c6/zxcVTKMOd4aSToYNMwX2pq4pMGNmpPkOO9lg4=;
        b=nPNAT3qdCbrRvOcUKfON5HOka5ilsTWT2q6HNvoZLbG+pRQGzyRajYfHGkTeFXysTf
         SIpWQRwSt/qVDovQitkTeZpTirNNo+QMRLdu9LanDVNFHyr8V68AqVoOeOVmzg5tpsZ1
         KfDCTwWkvWoOfE7dxTy57VZJj2snQaSxtbscQOuI6uP5PQf74ygJMd5nY7dFntYij6vA
         7yIaOzJ/x8H0XhTZoJu3uQvG04FyYz5v4JbstLKy4hjNqSS3AqHDvvyUSF0dDcQq5YBA
         3k2YXuq4UMd8pOvOBTnu90iC0Fd1DR1+9OB0utgqM5OtjL4oMdigWMm2tcNUM7VHjN/x
         1JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693478540; x=1694083340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AI1c6/zxcVTKMOd4aSToYNMwX2pq4pMGNmpPkOO9lg4=;
        b=lQzklf2Gskk+1I8CnkKv2hKMiAQe8kxLJ/MUMwcZtUk6yG6r/xbgfJT8GYPklGfuk4
         ZQjW4yzHzw2gvj+CRx+ot/a4MQZULOxP6TrITxEQwEThQkVC4Sv/4bG5DNbtVdTYLALe
         SzSeBQDwblF3Vu/fonQwMFnzB2Gcl4pyYcCEM0kCXvI1voX7FCtlfbfwcRywDGbOaf7E
         XY58ah4CJ/thXbSfB4vlJJGluZjTbWEH8vn/47EkzP9GV71rjXaylUu+2DvHtpUyHMWP
         nSNvQpyj8sOSq7GXTNzz9JeA80qbVdIzYu6IQRqNbD/b25sME5yewdXsZef7MQJHghRB
         fN6w==
X-Gm-Message-State: AOJu0YxwitHGZxk+I6ih15zTC00+zYOwIQw5HMwl2Nko82RM/IpQdCDY
	PBsLw4LqTgjRlK+hSBhJYAE=
X-Google-Smtp-Source: AGHT+IEoCcg/6TXFxEjcgPuTSB3nMU8PX614EDOXPbNI3TY6IJDTTUU93PvFoD84KZU64oq6t0LJyw==
X-Received: by 2002:a17:907:7202:b0:9a2:25da:d71e with SMTP id dr2-20020a170907720200b009a225dad71emr2777668ejc.0.1693478539873;
        Thu, 31 Aug 2023 03:42:19 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906805800b009894b476310sm609557ejw.163.2023.08.31.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:42:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 12:42:17 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZPBuieNxPhMz41oj@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <ZO9DvsaOImg4Dt5r@krava>
 <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com>
 <ZO+Sqomnp5BkH+m6@krava>
 <CAADnVQK2a76Ax7_7xQWEoKi5HSKbx3TrzrBoPWXi=AXD_U_ecw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK2a76Ax7_7xQWEoKi5HSKbx3TrzrBoPWXi=AXD_U_ecw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 01:29:18PM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 30, 2023 at 12:04 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 02:35:49PM -0400, Song Liu wrote:
> > > On Wed, Aug 30, 2023 at 9:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > > > > Recent commit [1] broken d_path test, because now filp_close is not
> > > > > called directly from sys_close, but eventually later when the file
> > > > > is finally released.
> > > > >
> > > > > I can't see any other solution than to hook filp_flush function and
> > > > > that also means we need to add it to btf_allowlist_d_path list, so
> > > > > it can use the d_path helper.
> > > > >
> > > > > But it's probably not very stable because filp_flush is static so it
> > > > > could be potentially inlined.
> > > >
> > > > looks like llvm makes it inlined (from CI)
> > > >
> > > >   Error: #68/1 d_path/basic
> > > >   libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3
> > > >
> > > > jirka
> > >
> > > I played with it for a bit, but haven't got a good solution. Maybe we should
> > > just remove the test for close()?
> >
> > I was thinking the same.. also we have some example with filp_close in bpftrace
> > docs, I think we'll need to add some note with explanation in there
> 
> Maybe use __x64_sys_close in the test and recommend bpftrace scripts
> to do the same?

we need struct file pointer as an argument, __x64_sys_close has pt_regs pointer

jirka

