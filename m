Return-Path: <bpf+bounces-18378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4C819F97
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712021C234EC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB9358A9;
	Wed, 20 Dec 2023 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWvPwz7k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCD2D618
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e23c620e8so5772585e87.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077943; x=1703682743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4o/hFb434QVxvVhyAQeimO24kCvVAPKR7R9eiTPDJc=;
        b=fWvPwz7kQdhFxGeemZ/RC+zcsuT0MPd56caEq7/deFySySLQA+9NmqYmIyDZM6Tfu6
         kO9esdpeBhnFlNc2i7poVDw1AZk5NDs2ALuwCHRLS+WoqFXRiZYx7SBPvTxjR9oJFLyn
         YPWgWrJyJfr69VIhmIH4wd11vWK41/qgUkGONByrEQylAe1ssS1xPOBAoe2VTxKN2G7L
         LbenEPNueqWh+dTPXQnqpXl0sfflpnLmBcIZUiVVg2q4V8IJ/npApJbj59imS5xFW3jQ
         EFOALwKrnj/CIMHXzG4V8RC25Eun9Qt6Uh9PPaypBoeN2Wo4WWj+XJ0OfHZyWzBQH/ZG
         82Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077943; x=1703682743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4o/hFb434QVxvVhyAQeimO24kCvVAPKR7R9eiTPDJc=;
        b=PUuTTHIyBtbhOoWheZYCyIlQx0vtJ/aMr1KeTiKGYNmjxvXolLKegbNonetreHFYLb
         6Mn2dQcCy8DVwlf2RquoWLDrnhsZDsEnnt7wDIV8MpCfr2VneJ87S6GatVghfoeU8b2V
         jSUqEaY1+dANSeFeeDJQ3roemV+BDxv/RAkQfmvZaEosWMPlBnhbWNLurkIWgAa75Vgh
         p/kRcyp2baEUKMDntzftli1vELMOucQQzdFR2NTJ8EfB7OA/iraNaPOHIkFjdA3NF8PJ
         iXGkSRDNFJJROahqqC4WSDF8nmQGQ9TfMM8Bb89f/dKK1RioiM8b76wOIQG3dg1Ar3E7
         YZJg==
X-Gm-Message-State: AOJu0Yx0W4zmDtj3CXOxwofeH7FJr+OtajCN+y0Dqi5KmRtOIwkeOtik
	t1h3JTNJStg9fU84dZqtnnQ=
X-Google-Smtp-Source: AGHT+IGBRo1ukEC21MHbKrMVJ225uUoFdbRZuiUB44DsytCuJPE+9uJXQ6T/CGCCqMFrLafQOiwq6g==
X-Received: by 2002:a05:6512:208b:b0:50e:4c7a:ee6a with SMTP id t11-20020a056512208b00b0050e4c7aee6amr1004752lfr.4.1703077942992;
        Wed, 20 Dec 2023 05:12:22 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005527c02c1d6sm6475379edb.50.2023.12.20.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Dec 2023 14:12:21 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Dynamic kfunc discovery
Message-ID: <ZYLoNZTJfw5THieu@krava>
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
 <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
 <ZYKu1oysidMOHbbE@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYKu1oysidMOHbbE@krava>

On Wed, Dec 20, 2023 at 10:07:34AM +0100, Jiri Olsa wrote:
> On Tue, Dec 19, 2023 at 07:15:42PM -0800, Alexei Starovoitov wrote:
> > On Tue, Dec 19, 2023 at 9:29 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > Hi,
> > >
> > > I was chatting w/ Quentin [0] about how bpftool could:
> > >
> > > 1. Support a "feature dump" of all supported kfuncs on running kernel
> > > 2. Generate vmlinux.h with kfunc prototypes
> > >
> > > I had another idea this morning so I thought I'd bounce it around
> > > on the list in case others had better ones. 3 vague ideas:
> > >
> > > 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
> > >    let bpftool parse BTF to do discovery. It would be fairly clean and
> > >    straightforward, except that I don't think GCC supports these type
> > >    tags. So only clang-built-linux would work.
> > >
> > > 2. Do the same thing as above, except rather than tagging src code,
> > >    teach pahole about the .BTF_ids section in vmlinux. pahole could then
> > >    construct BTF with the appropriate type tags.
> 
> I thought it'd be nice to have this in BTF, but to generate the .BTF_ids
> section we need the BTF data (for BTF IDs), so that might be tricky

we could also move resolve_btfids logic into pahole and it could
add the kfunc data to BTF directly

> 
> > 
> > resolve_btfids knows about all of them already.
> > The best is to teach bpftool about them as well.
> > It can look for BTF_SET8_START and there it can find btf_ids
> 
> with the access to vmlinux, bpftool could get the addresses of all
> set8s, read all btf ids and generate the header

and maybe we could also read kfunc data directly from /proc/kcore:

  # cat /proc/kallsyms  | grep __BTF_ID__set8__generic_btf_ids
  ffffffff843be898 r __BTF_ID__set8__generic_btf_ids
  # objdump -s --start-address=0xffffffff843be898 --stop-address=0xffffffff843be8a8 /proc/kcore   

  /proc/kcore:     file format elf64-x86-64

  Contents of section load1:
   ffffffff843be898 17000000 00000000 15750100 85000000  .........u......

I think having it in BTF would be easiest from user's POV,
but seems like a lot of work.. reading it from kcore seems
good enough

jirka

> 
> $ nm vmlinux | grep BTF_ID__set8 
> ffffffff843bf044 r __BTF_ID__set8__bpf_kfunc_check_set_skb
> ffffffff843bf064 r __BTF_ID__set8__bpf_kfunc_check_set_sock_addr
> ffffffff843bf054 r __BTF_ID__set8__bpf_kfunc_check_set_xdp
> ffffffff843be940 r __BTF_ID__set8__bpf_map_iter_kfunc_ids
> ffffffff843bf22c r __BTF_ID__set8__bpf_mptcp_fmodret_ids
> ffffffff843be604 r __BTF_ID__set8__bpf_rstat_kfunc_ids
> ffffffff843bf074 r __BTF_ID__set8__bpf_sk_iter_kfunc_ids
> ffffffff843bf1c4 r __BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids
> ffffffff843bf0bc r __BTF_ID__set8__bpf_test_modify_return_ids
> ffffffff843be864 r __BTF_ID__set8__common_btf_ids
> ffffffff843be9a8 r __BTF_ID__set8__cpumask_kfunc_btf_ids
> ffffffff843bf174 r __BTF_ID__set8__fou_kfunc_set
> ffffffff843be678 r __BTF_ID__set8__fs_kfunc_set_ids
> ffffffff843be794 r __BTF_ID__set8__generic_btf_ids
> ffffffff843be650 r __BTF_ID__set8__key_sig_kfunc_set
> ffffffff843bf10c r __BTF_ID__set8__nf_ct_kfunc_set
> ffffffff843bf164 r __BTF_ID__set8__nf_nat_kfunc_set
> ffffffff843bf18c r __BTF_ID__set8__tcp_cubic_check_kfunc_ids
> ffffffff843bf0dc r __BTF_ID__set8__test_sk_check_kfunc_ids
> ffffffff843bf084 r __BTF_ID__set8__xdp_metadata_kfunc_ids
> ffffffff843bf1f4 r __BTF_ID__set8__xfrm_ifc_kfunc_set
> ffffffff843bf20c r __BTF_ID__set8__xfrm_state_kfunc_set
> 
> jirka
> 
> > of all kfuncs.
> > From there it can generate them into vmlinux.h
> > 
> > We wanted kfuncs to appear in vmlinux.h for quite some time,
> > but no one had cycles to do it.
> > Still an awesome feature to have.
> > 

