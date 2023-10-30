Return-Path: <bpf+bounces-13642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0577DC1AE
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DE32816CA
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA61B29C;
	Mon, 30 Oct 2023 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekmPkSO+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72E156F6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 21:17:44 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46041E1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9becde9ea7bso1268933266b.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698700662; x=1699305462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nsbbncSe2xfzmyG61O3oc4LIZNMyZMDfdbU3umUAgY=;
        b=ekmPkSO+7+bpiw6zPV2HMRimlYtJ5q/Z77EJuLqjQn3ik5yNFpIYk6uChdE/AfSJ0i
         UAE28JVVStY1j+GCk6YeuNZAfz5hnJcYJXG7PywS7w1RN7ru9aHlwt+DbcixdYnSrFiE
         YAPpxhABTnOwgPWffTjqHgH6tQ235zBvBTqjhJab9RZ47p3AlBu6ZhDqmtXT+ZgaUieb
         vHQ4VIQ4G+zbum0CSIEvs7UdieaxsVk5YF8sgsQFUip+k0FzlDjQP4TobE79TfZBpNMT
         Vjx6hSCnwZP/bkNJgkJpTOSTEAfLHSWSYJ3kgByZkdIy+aO+Mm+g6BrNhGy97+cXR4Xz
         Zdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698700662; x=1699305462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nsbbncSe2xfzmyG61O3oc4LIZNMyZMDfdbU3umUAgY=;
        b=cWjEa1srjm/ApGzwprGa39uL0K72xnxSjXFKWihwPE7J2D/uVFxqkVst5HCgr1XpzA
         JPzXW1j0P++8bTXqpDyuG4I5eK0a3VKM4lGKK8r+TE1DEOhC7IXKeOpPZFuRcodRxYvi
         7TQnS06hlYccwdABRSCBz6h6UaocMWQOCdzekElUBLDkdevgWJX5UjT7dedeBYmIGduY
         0gsgUVHLqp4Fkv7MWk+hImEveaeMyU/9L4K9XO+d3XhJJ2SJX9omMzw/gBVGYdDapHq9
         LCNqo2ZY+cgv8cEIwfk8GQFVq5TpR/4O/H5GpwQqbzhsZOQLrCA2LIpgwrq1+VQ2thie
         03Mg==
X-Gm-Message-State: AOJu0Yy3/at1rBvLxfBYkOuQrDlYbx9eQDcCFrtd/88w9hlk8dSkXy2K
	NbK2B/tkvsRNLl0mIvonolc=
X-Google-Smtp-Source: AGHT+IFQFIL+MSm01fLLR4mACxO7zDBfOTS5+UmrjeKbTIJXuKD5phLw4f79GRMoOPxkOL72Ka0YSA==
X-Received: by 2002:a17:907:da9:b0:9b2:bdbb:f145 with SMTP id go41-20020a1709070da900b009b2bdbbf145mr806948ejc.34.1698700661339;
        Mon, 30 Oct 2023 14:17:41 -0700 (PDT)
Received: from krava ([83.240.63.31])
        by smtp.gmail.com with ESMTPSA id ci6-20020a170906c34600b009929ab17be0sm6450147ejb.162.2023.10.30.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:17:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Oct 2023 22:17:39 +0100
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi
 link
Message-ID: <ZUAdc3mQXAqXiWvr@krava>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-4-jolsa@kernel.org>
 <72a9c3e0-f73a-4a63-8602-712d44d7cee7@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a9c3e0-f73a-4a63-8602-712d44d7cee7@isovalent.com>

On Mon, Oct 30, 2023 at 10:18:59AM +0000, Quentin Monnet wrote:
> 
> 2023-10-25 21:24 UTC+0100 ~ Jiri Olsa
> > Adding support to get uprobe_link details through bpf_link_info
> > interface.
> > 
> > Adding new struct uprobe_multi to struct bpf_link_info to carry
> > the uprobe_multi link details.
> > 
> > The uprobe_multi.count is passed from user space to denote size
> > of array fields (offsets/ref_ctr_offsets/cookies). The actual
> > array size is stored back to uprobe_multi.count (allowing user
> > to find out the actual array size) and array fields are populated
> > up to the user passed size.
> > 
> > All the non-array fields (path/count/flags/pid) are always set.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 10 +++++
> >  kernel/trace/bpf_trace.c       | 68 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 10 +++++
> >  3 files changed, 88 insertions(+)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 0f6cdf52b1da..960cf2914d63 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6556,6 +6556,16 @@ struct bpf_link_info {
> >  			__u32 flags;
> >  			__u64 missed;
> >  		} kprobe_multi;
> > +		struct {
> > +			__aligned_u64 path;
> > +			__aligned_u64 offsets;
> > +			__aligned_u64 ref_ctr_offsets;
> > +			__aligned_u64 cookies;
> > +			__u32 path_max; /* in/out: uprobe_multi path size */
> 
> Just a nit on the naming here: I don't really understand why this is
> "path_max", should it be "path_size" instead?

right, path_size fits better, will change

thanks,
jirka

> 
> Quentin

