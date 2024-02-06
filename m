Return-Path: <bpf+bounces-21355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909A84BA8F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E814629080E
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264EE134CDB;
	Tue,  6 Feb 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+3wpa4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC789134CED;
	Tue,  6 Feb 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235399; cv=none; b=d7NJy4iPr6PUP+UvfdYiXOoSKvUWwGrwyjCmwBDTmd2kNovFpmvaLzY22KNBs3CAjMJStvDTTbLbb8310CJliP1KsGB88lBRgjMTGPx3fA21+NKLrMrz+2ZoBeGIvS58gpyQRDw6epwLDZ/kaidZ4SgeqFnduGLcPtBLDiGjbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235399; c=relaxed/simple;
	bh=eevfwA00ob/jZaiIvXO5cLFT/iQRzo/AiWwse8KJiO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBb0NZM8JwVwYPNobEW6K19j4WUbpTRsgeh7M7QVVleERAhMdjIdy2KupF6K40oRuQ932hm8WKhFn0AmYpN562c/fnuskNwkmuqFG1HpZuP5wzlWCaRRqdDtZgjxq2mhuerUsty+5t7vb4Z0eeqTCm8I+BAOR5kSEtIpyJydBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+3wpa4z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so7598949a12.2;
        Tue, 06 Feb 2024 08:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235393; x=1707840193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca7sqJlEHwlMaWT7ZGfBAoeIoHX1VcE3nux1pQdxFAw=;
        b=E+3wpa4z4csc97d3+xthjd6Ji9IxyZpvXCNkq0bx6b+tKFUYb0Xjz345Uu/RflACcL
         fSwcphcpuemyW/9PoCUwKccfKYZAAO/+w3ALg0zZdnIPNKd+QaNjyCLGa2IOusF7byFn
         ogf41dkMumSP5Uo4aMrM0Fw/4SmveDLj45IHES45hQ0ZBK3LFHg/WB73dYuZTp34XBlC
         grZdYBbXwRj28VWdlyvWMXjZ4gMwel+QQK8M30b7mmW49Kd4694nf8OQ0rccKoy98gmb
         Yjptez6+iy2O1IE2gL6FH1uBMFkgRSLWsqaDhK23nqNF60964U8LhSom1gk6jp82DYNg
         HJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235393; x=1707840193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca7sqJlEHwlMaWT7ZGfBAoeIoHX1VcE3nux1pQdxFAw=;
        b=jm8I/32BUFEFpsRqtBZ//5dVqeUpR33AmCC6vtbhmy6IHz5OD0WkGnztrXaMnWiawd
         v2fDa6lxLAX/UYWK33MetS1Hk4oicn7Np1qHP3p4ecOm4tG951dFPirwe/RWRKNraT0B
         fo3owSCrA87noB7dx080s0n8A1Q58N7u7ktE43v8hxepunI6GJWGuJAq1272ufezp1z9
         0oJHbXb/uZIptsQhvYzohfaz4sZ+3DK619QpADcIBqJz9/pSfNICVKZF+21q83ipF4Og
         ZA+SAfph3mkh41oftVCXxtCV1cTe7XFS/dMO6p3RHWXEBEK0bjfRK4hSokRHQGQhnlJN
         3ssg==
X-Gm-Message-State: AOJu0YxSS+jBbjhWHCnOuPU7ULpYJY8TG7QdfczaXgfG7TLLGCn2wVPB
	MSVChvS+9jphaU0UVvqNBcb0GCJd8+VeHqi0X638yZ2ebAQZ4QtK
X-Google-Smtp-Source: AGHT+IHx7wr4tpsrFne4mYKGJ67aMXu4rXFBAw+QNa3wk3pEjYuSj6HjrNmrxRIbr48OnxmCgWZ3Pg==
X-Received: by 2002:a17:906:1b4f:b0:a37:b5c2:d9a3 with SMTP id p15-20020a1709061b4f00b00a37b5c2d9a3mr1620690ejg.4.1707235392743;
        Tue, 06 Feb 2024 08:03:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfKJSUSnXlBhd01RlU5A+mSuF0ndZJ1emC+SkE6TngGBdET0ZzWC0I2H5GIvBiZT/kPfUZQY9QGLkCC0sMfRRru6WIH5GIt41MxKAA3Vlijf9GR/AqFIlOMjWqy9YnM9hj9Eq7+gdj/Urs2YDodENXWXkGxR+8A7wH03a5I/0OYOTiGZXC2XbYDqTMHw7CbPLgH2XPiiDaJtBKTziVkUcaRKmAwa1kz9/xyh64cbY1lNkOy+aQBsyLQrVgCV76j3N+tufffnQTtaPCQD5mYWFwBblVZXyUvzz9FRI3krNe1mVeDGpdmSVgcpYzJBnI/o56LxLRnam2avSI55Bllkt57f8yj1XixkdM0gQx5kYinvEG8BoHkiG7hjvhz/wdWpNFfYlUc9sto3U3/mQRQt4CFHO1PYVGXvO18lfpLaq2DFCByTJJQ3XXj1W2agY+z/jfSRJuBIU93KQY5po/w5vtAcGiM8dMDmGpB+LP6Bg=
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906680600b00a372b8ac53fsm1286628ejr.169.2024.02.06.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:03:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 17:03:10 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const
 pointer
Message-ID: <ZcJYPhiVoK-WIV6z@krava>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
 <ZcI3Pt6Gr45wiig7@krava>
 <cn7sqqtplcle3udyxsbywfxs25wqnwxoutdf7w7cbbucmxkfsm@x67uxj6ubmzk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cn7sqqtplcle3udyxsbywfxs25wqnwxoutdf7w7cbbucmxkfsm@x67uxj6ubmzk>

On Tue, Feb 06, 2024 at 08:44:18AM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> On Tue, Feb 06, 2024 at 02:42:22PM +0100, Jiri Olsa wrote:
> > On Sun, Feb 04, 2024 at 02:06:34PM -0700, Daniel Xu wrote:
> > > Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is now
> > > exporting a const arg version of bpf_rdonly_cast(). This causes the
> > > following conflicting type error when generating kfunc prototypes from
> > > BTF:
> > > 
> > > In file included from skeleton/pid_iter.bpf.c:5:
> > > /home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
> > > extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) __ksym __weak;
> > >              ^
> > > ./vmlinux.h:135625:14: note: previous declaration is here
> > > extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __ksym;
> > 
> > hi,
> > I'm hiting more of these when compiling bpf selftests (attached),
> > it looks like some kfuncs declarations in bpf_kfuncs.h might be in conflict
> 
> Yep, I was actually going to put that as an office hours topic on how we
> want to handle that for selftests. Marking kfuncs in bpf_kfuncs.h and
> bpf_experimental.h as __weak is an option. ifdef is another option.
> Final option I can think of is bumping required pahole version up and
> simply deleting all the kfunc definitions.
> 
> But given that pahole changes come with the feature flag, I don't see
> this as a pressing issue. So I was planning on getting to that after
> current outstanding patchsets (just so there's less stuff for me to
> juggle).

ok, I guess if the fix goes in together with the scripts/Makefile.btf
change then we're fine

jirka

