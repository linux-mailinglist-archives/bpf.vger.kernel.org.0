Return-Path: <bpf+bounces-18417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A1681A760
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBD21F2382E
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3B4878D;
	Wed, 20 Dec 2023 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0PARZ3R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607848780
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so553655e9.3
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703101464; x=1703706264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O1lnUkpPrZoKGtIAeX5Km7AFbpO5FSh5SKb4KTrF3Ig=;
        b=Z0PARZ3Rbn0dsIFTdcHeiCX3h2eAg5K5l0i2Qjguw4/Ot0Shcuq+F9NJEuwo/bydiP
         /gGRzV7fqs5Zzy6q58xEKsgR+n9VwP/G8ZXbbxnDWPsVE3gtTbAG2sg4xOF0xOheB5h1
         u9MbkFlKK3oCtmExjqm7pJ6I5nVA3IiI1on0AZL2LJW9tVioLtIdI78S/3nAapZe7x2p
         x7ATmAHyvV+pf1FheTZ+z2q8Gj9tTuHJsvB5pg+x4XjCrLql1ahvawUxxCpGZJUhyVEm
         TXCuIOl2xcA5bNrlYY2/oUy2zyxNfAkRHGR0lbovA4IBCAkIXVD6VyhY6kzh09FCtI5q
         TxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703101464; x=1703706264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1lnUkpPrZoKGtIAeX5Km7AFbpO5FSh5SKb4KTrF3Ig=;
        b=eihOirgvimT4HQkOGpnLjhk0Vrqb1tkexVhiKprDMBQ1GXQCQMGvp8QLnlIwm9hLbO
         +1WpQ88py7vL969TGlwhbJr+rfmgMRp6AIlTwicxSm5Ia7EcYztX4tcrdZbBgHivUZ1k
         yDIkDYW5j56OeVFYp+rLlN+uOakrgS7bRXrx9n/jbED4r+drTMhbU2baCqdrDTDFBerO
         KE90kczzIif0zgy8rpT/JFdlAJ9/vXif5abQBPLpwagZfeMgsuQsE1uk8QGq0f4dzvLB
         QlWWU4qOh0oNCzFey6tvhUuc9vBxKlx+H702EKV5EY8MgSLyoE3YHRzdTcW/py2jvOf8
         p2yQ==
X-Gm-Message-State: AOJu0YwOleTyPU1rJ4iSfxvxkcbC5sJASsCtlY16nJFIf5H35Pe/hOIu
	wgiyyt6CQygWz7rqQo+0VWw=
X-Google-Smtp-Source: AGHT+IEfz+jaXNGKaqXoEV3JDnXGO2VpnUfji6dqLN4As7n9U9LBe/9VQmoMnS9VJA0cs30HFAjIGQ==
X-Received: by 2002:a05:600c:a08:b0:40d:1a54:fef4 with SMTP id z8-20020a05600c0a0800b0040d1a54fef4mr68717wmp.95.1703101463507;
        Wed, 20 Dec 2023 11:44:23 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id vw17-20020a170907059100b00a2699127f98sm149701ejb.87.2023.12.20.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 11:44:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Dec 2023 20:44:20 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Dynamic kfunc discovery
Message-ID: <ZYNEFLQSK7C2A7AQ@krava>
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
 <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
 <ZYKu1oysidMOHbbE@krava>
 <4hfjkuvoprm5qawiscm6yd64ffhuf7ig2onm2zqc2bb2r7bbvv@u774my22jfn6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4hfjkuvoprm5qawiscm6yd64ffhuf7ig2onm2zqc2bb2r7bbvv@u774my22jfn6>

On Wed, Dec 20, 2023 at 09:44:10AM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> On Wed, Dec 20, 2023 at 10:07:34AM +0100, Jiri Olsa wrote:
> > On Tue, Dec 19, 2023 at 07:15:42PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Dec 19, 2023 at 9:29 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I was chatting w/ Quentin [0] about how bpftool could:
> > > >
> > > > 1. Support a "feature dump" of all supported kfuncs on running kernel
> > > > 2. Generate vmlinux.h with kfunc prototypes
> > > >
> > > > I had another idea this morning so I thought I'd bounce it around
> > > > on the list in case others had better ones. 3 vague ideas:
> > > >
> > > > 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
> > > >    let bpftool parse BTF to do discovery. It would be fairly clean and
> > > >    straightforward, except that I don't think GCC supports these type
> > > >    tags. So only clang-built-linux would work.
> > > >
> > > > 2. Do the same thing as above, except rather than tagging src code,
> > > >    teach pahole about the .BTF_ids section in vmlinux. pahole could then
> > > >    construct BTF with the appropriate type tags.
> > 
> > I thought it'd be nice to have this in BTF, but to generate the .BTF_ids
> > section we need the BTF data (for BTF IDs), so that might be tricky
> 
> Isn't .BTF_ids already present in vmlinux before getting to
> resolve_btfids? It looks to me like all resolve_btfids does is patch
> symbols to the read BTF ID values.

yes, it's there but it's empty.. IDs are zero

> To inject BTF type tags from pahole, I don't think it needs a patched
> .BTF_ids section, right? After pahole has generated all the regular
> entries, it could walk .BTF_ids and try to match up symbol names with
> BTF function entries. And then inject the BTF type tag.

so what resolve_btfids does is to lookup all __BTF_ID__set8__* symbols,
finds their BTF IDs and stores them where the symbol points

there's explanation on the symbol name in tools/bpf/resolve_btfids/main.c
header

pahole could do the same and once it has the IDs it could add the type
tag to them, initially I thought having extra BTF section with kfuncs
BTF ids, but type tag seems like better way to do that

jirka

> 
> > 
> > > 
> > > resolve_btfids knows about all of them already.
> > > The best is to teach bpftool about them as well.
> > > It can look for BTF_SET8_START and there it can find btf_ids
> > 
> > with the access to vmlinux, bpftool could get the addresses of all
> > set8s, read all btf ids and generate the header
> > 
> > $ nm vmlinux | grep BTF_ID__set8 
> > ffffffff843bf044 r __BTF_ID__set8__bpf_kfunc_check_set_skb
> > ffffffff843bf064 r __BTF_ID__set8__bpf_kfunc_check_set_sock_addr
> > ffffffff843bf054 r __BTF_ID__set8__bpf_kfunc_check_set_xdp
> > ffffffff843be940 r __BTF_ID__set8__bpf_map_iter_kfunc_ids
> > ffffffff843bf22c r __BTF_ID__set8__bpf_mptcp_fmodret_ids
> > ffffffff843be604 r __BTF_ID__set8__bpf_rstat_kfunc_ids
> > ffffffff843bf074 r __BTF_ID__set8__bpf_sk_iter_kfunc_ids
> > ffffffff843bf1c4 r __BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids
> > ffffffff843bf0bc r __BTF_ID__set8__bpf_test_modify_return_ids
> > ffffffff843be864 r __BTF_ID__set8__common_btf_ids
> > ffffffff843be9a8 r __BTF_ID__set8__cpumask_kfunc_btf_ids
> > ffffffff843bf174 r __BTF_ID__set8__fou_kfunc_set
> > ffffffff843be678 r __BTF_ID__set8__fs_kfunc_set_ids
> > ffffffff843be794 r __BTF_ID__set8__generic_btf_ids
> > ffffffff843be650 r __BTF_ID__set8__key_sig_kfunc_set
> > ffffffff843bf10c r __BTF_ID__set8__nf_ct_kfunc_set
> > ffffffff843bf164 r __BTF_ID__set8__nf_nat_kfunc_set
> > ffffffff843bf18c r __BTF_ID__set8__tcp_cubic_check_kfunc_ids
> > ffffffff843bf0dc r __BTF_ID__set8__test_sk_check_kfunc_ids
> > ffffffff843bf084 r __BTF_ID__set8__xdp_metadata_kfunc_ids
> > ffffffff843bf1f4 r __BTF_ID__set8__xfrm_ifc_kfunc_set
> > ffffffff843bf20c r __BTF_ID__set8__xfrm_state_kfunc_set
> > 
> > jirka
> > 
> > > of all kfuncs.
> > > From there it can generate them into vmlinux.h
> > > 
> > > We wanted kfuncs to appear in vmlinux.h for quite some time,
> > > but no one had cycles to do it.
> > > Still an awesome feature to have.
> > > 
> 
> Thanks,
> Daniel

