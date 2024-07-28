Return-Path: <bpf+bounces-35837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43ED93E967
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 22:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA25280E30
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2E75808;
	Sun, 28 Jul 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CQekjNt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9726F2EB
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198925; cv=none; b=m0qpnSK/2bTEVQyte54xeQ77STJPL3+12jbUqzOX+i1ORKuBDgrO+mZIBFJzp160IVNomKy5e3rJXBqFqQj4+OQ8mSJSQopHKtn6s1+yvWtvHBiZzSRtXUhPSbcMthN47WEontMGOwI6Q+/NCfWCjlFFBzx4sxZtkpIsOx2kKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198925; c=relaxed/simple;
	bh=mgu+Yj+jxGXZRLUlwBp5yMyvSwB9uW7xJptSeY98TYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj4CLsMyTfHKStxno3EEaPhdRpRow+Cr9p8FXY66YX07oOHkkPw+3QZABh6TW95uO8yzxFRxqhhyumo6UCMlrLAPdR9eT2DnFavpFW3KaY2EE/xWHaQ6tptIz72ADrVwJS1l9DnwA9m/kSPtiqCxePpgtATOphdq/a8ypByqHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CQekjNt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a8caef11fso326680566b.0
        for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198922; x=1722803722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nontbgcjIDqftJuySTTJnYyofNA22ioowgX6CXcR/jY=;
        b=1CQekjNtlMrhc1MzTLrrTrtie8iiIq6r9HG3w8OBpLErgkfG/hc4m3zSGvBRdO4u33
         y+jGatuCF+YxfMNdWwplzoLhnPfWsXpnaAAixS8bK/R0FP1mfKWZkx3ZTMVLGNYM4y5w
         E8ZaervwdJ5yfqcmqR0i3IQMZHVmLh+l2QzxgJnzUkDgLqPgtKZh5H3PMYCTPLVtgxz3
         AOcygCDmGLIasE6Zymc5FeKeddjxIAnhnrJaPAMXDg0qrT9nmslbDSGBepu+CKdgeFzh
         lbTubLqifTnFDn8Bdj8C7vOiIrWjAbTxY+SSzBYX0D1w0X6xi4gGe1Uog98QCmUpdLN5
         +DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198922; x=1722803722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nontbgcjIDqftJuySTTJnYyofNA22ioowgX6CXcR/jY=;
        b=jPgdYW62AtznHtW/NF8cmnxPlhKFmc3IuUerPMbovN98KBGGmK9YwVd1hTjZtID7eE
         5Q8KkqPnw9B3voq11OcL1suF6u55GFqJbLxewPQmxjOC+vlXem+Wy85Z8XjT9HTa9fV0
         hwZ37YO+N1XvAqzfWO2xqZgVBo7f/O5+EZlLzWuwvhRXJJbQMVwkfuGBnrmxlaEtEWu8
         1QmRBpSAPCaEeE49LWXcr1zKzt2Py3C+dT3PBHt7tbj8ZrEIfVqr4tivAv0H1m4PMWah
         SY2fNearcwrt+p4BGy2OsLoIV/M6o1MLWC+IAS+6LEopznBqgpMDw5mLqAfNnfsTJ+yE
         Er4A==
X-Gm-Message-State: AOJu0Yyzwt1/VyemzF/TIQ5887WLvwISm4DDIpSzuuSVUW+w+2acPP/r
	vqEi/aEPr3B70BeJfGIVRpX1IsIJGcY+9soaV1HvwW96b1MrWLvepbgeo3kOwQ==
X-Google-Smtp-Source: AGHT+IFOTQVaWR8X2b+Rf7JTM/y+VMpyyyTx6OFW82HRoMMJWD2DlJzr2AhKJfNrkWWaBypjQqOegA==
X-Received: by 2002:a17:907:9802:b0:a77:c364:c4f2 with SMTP id a640c23a62f3a-a7d40150ac5mr408195466b.52.1722198921083;
        Sun, 28 Jul 2024 13:35:21 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23828sm430409966b.19.2024.07.28.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:35:20 -0700 (PDT)
Date: Sun, 28 Jul 2024 20:35:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqarhaE7JgkkxASP@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAADnVQJdv9rjCHMzmE+W4AO3GgKjNjS_c06kC0iXe+itDstGZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJdv9rjCHMzmE+W4AO3GgKjNjS_c06kC0iXe+itDstGZQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 01:43:45PM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > +
> > +static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +{
> > +       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > +           prog->type == BPF_PROG_TYPE_LSM)
> > +               return 0;
> > +       return -EACCES;
> > +}
> > +
> > +static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
> > +       .owner = THIS_MODULE,
> > +       .set = &bpf_fs_kfunc_set_ids,
> > +       .filter = bpf_fs_kfuncs_filter,
> > +};
> > +
> > +static int __init bpf_fs_kfuncs_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
> > +}
> 
> Aside from buf__sz <= 0 that Christian spotted

I'm going to fix this up in v2 of this patch, so don't worry about it.

> the bpf_fs_kfuncs_filter() is a watery water.
> It's doing a redundant check that is already covered by
> 
> register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,...
> 
> I'll remove it while applying.

As discussed, this filter is currently required as without it we
inadvertently allow tracing BPF programs to also use these BPF
kfuncs.

/M

