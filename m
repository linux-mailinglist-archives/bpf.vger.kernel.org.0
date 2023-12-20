Return-Path: <bpf+bounces-18367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD3819B18
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A821288366
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340D1D52A;
	Wed, 20 Dec 2023 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzeJphkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EC1CF8F
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33666fb9318so3369096f8f.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703063257; x=1703668057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5m3o/8QtBp1qvDfJR3Sap+uR79GLhsD7VKEz6YbRDL8=;
        b=WzeJphkb//SvwjLjo7g015zQ48X8LYXhMR5Y8xMWmJho9AxbmBAKq1uelynfArR4RM
         gtz9m89EOa3UvDaJEzF0SbZqOceGNQ4zH9fqMftgII6znxVPJQcULw3fCDxuF/ukiGc+
         1wVYfFRXD0Uw251nzLIfpmI9FwMPUA0d1BwxVhPtsG+Xni+e5A0uYkhODtoVd/ozjWhi
         j19uSS/0betIoo+uoLEj9ttNDdEVI6GY+z1dWEX57V6/y9m0MKDcH2/MK8jBr1mePo4E
         /r1RgkMPPMfv7I2XHrqtGEuRj/fZwZpJMvV7ZPWC3riG0O6MFvO9dLhkBzAjhyn9Q/3v
         bdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063257; x=1703668057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5m3o/8QtBp1qvDfJR3Sap+uR79GLhsD7VKEz6YbRDL8=;
        b=WVnGXzWc5UNF68oh5RurQBSOCTy8ollORxkUkkzYPhq4ikuRoe55iUFZoG870RiyQX
         N8Wfk+GMeR06f8IYVaYJ+qI22+50uifg69wSa4q0zR1EEFMQVu/xGQTogYS9Ypmx/I7P
         hNRzXc3HUx2OT3LD8UGasutjyS2S90bHWzdKqy2LHkSCH5x+l1yShN44nCdNF96tEvb6
         eSAqpPA3ElMl97DSIHeSZ3yzAmAHLuybD0S5/UP8uVagJgQJ4m85doPsMRWxlZdU/qT+
         GDkdCgcwsjOBL90uy38At1a4x50Rg4rS9F9vFdosFsXBhUbaul7wjljEiv/D8cacr3Fx
         VS5Q==
X-Gm-Message-State: AOJu0YwYaBcUo5mn79qXNIDkighUotloyv8nO4NRFxynw2kykpjRhoKJ
	RAnzcKz9bKhr7n2PtZwhc9oYKObumIs=
X-Google-Smtp-Source: AGHT+IE4C/RsGpWeeT4JwbNWS5OMo6UHElI8hvZFrbQEd/nekOlQH9WLs1EKnz8ftsCMyc9qgbFGug==
X-Received: by 2002:adf:ef51:0:b0:336:6d7d:24dc with SMTP id c17-20020adfef51000000b003366d7d24dcmr1986828wrp.9.1703063256486;
        Wed, 20 Dec 2023 01:07:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f18-20020adffcd2000000b0033660aabe76sm10496383wrs.39.2023.12.20.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:07:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Dec 2023 10:07:34 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Dynamic kfunc discovery
Message-ID: <ZYKu1oysidMOHbbE@krava>
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
 <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>

On Tue, Dec 19, 2023 at 07:15:42PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 19, 2023 at 9:29 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi,
> >
> > I was chatting w/ Quentin [0] about how bpftool could:
> >
> > 1. Support a "feature dump" of all supported kfuncs on running kernel
> > 2. Generate vmlinux.h with kfunc prototypes
> >
> > I had another idea this morning so I thought I'd bounce it around
> > on the list in case others had better ones. 3 vague ideas:
> >
> > 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
> >    let bpftool parse BTF to do discovery. It would be fairly clean and
> >    straightforward, except that I don't think GCC supports these type
> >    tags. So only clang-built-linux would work.
> >
> > 2. Do the same thing as above, except rather than tagging src code,
> >    teach pahole about the .BTF_ids section in vmlinux. pahole could then
> >    construct BTF with the appropriate type tags.

I thought it'd be nice to have this in BTF, but to generate the .BTF_ids
section we need the BTF data (for BTF IDs), so that might be tricky

> 
> resolve_btfids knows about all of them already.
> The best is to teach bpftool about them as well.
> It can look for BTF_SET8_START and there it can find btf_ids

with the access to vmlinux, bpftool could get the addresses of all
set8s, read all btf ids and generate the header

$ nm vmlinux | grep BTF_ID__set8 
ffffffff843bf044 r __BTF_ID__set8__bpf_kfunc_check_set_skb
ffffffff843bf064 r __BTF_ID__set8__bpf_kfunc_check_set_sock_addr
ffffffff843bf054 r __BTF_ID__set8__bpf_kfunc_check_set_xdp
ffffffff843be940 r __BTF_ID__set8__bpf_map_iter_kfunc_ids
ffffffff843bf22c r __BTF_ID__set8__bpf_mptcp_fmodret_ids
ffffffff843be604 r __BTF_ID__set8__bpf_rstat_kfunc_ids
ffffffff843bf074 r __BTF_ID__set8__bpf_sk_iter_kfunc_ids
ffffffff843bf1c4 r __BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids
ffffffff843bf0bc r __BTF_ID__set8__bpf_test_modify_return_ids
ffffffff843be864 r __BTF_ID__set8__common_btf_ids
ffffffff843be9a8 r __BTF_ID__set8__cpumask_kfunc_btf_ids
ffffffff843bf174 r __BTF_ID__set8__fou_kfunc_set
ffffffff843be678 r __BTF_ID__set8__fs_kfunc_set_ids
ffffffff843be794 r __BTF_ID__set8__generic_btf_ids
ffffffff843be650 r __BTF_ID__set8__key_sig_kfunc_set
ffffffff843bf10c r __BTF_ID__set8__nf_ct_kfunc_set
ffffffff843bf164 r __BTF_ID__set8__nf_nat_kfunc_set
ffffffff843bf18c r __BTF_ID__set8__tcp_cubic_check_kfunc_ids
ffffffff843bf0dc r __BTF_ID__set8__test_sk_check_kfunc_ids
ffffffff843bf084 r __BTF_ID__set8__xdp_metadata_kfunc_ids
ffffffff843bf1f4 r __BTF_ID__set8__xfrm_ifc_kfunc_set
ffffffff843bf20c r __BTF_ID__set8__xfrm_state_kfunc_set

jirka

> of all kfuncs.
> From there it can generate them into vmlinux.h
> 
> We wanted kfuncs to appear in vmlinux.h for quite some time,
> but no one had cycles to do it.
> Still an awesome feature to have.
> 

