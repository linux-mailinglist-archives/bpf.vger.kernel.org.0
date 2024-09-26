Return-Path: <bpf+bounces-40355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A86987779
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D61E1F25EB9
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12625155A4D;
	Thu, 26 Sep 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYVsHXNG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBF14A4E0
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367699; cv=none; b=cdfmUhfe2DsSN3XyC8dMvu0XirBY3OCk9SYph+NLPArY90+w1c8cDEkwQlPmlvO31MPoua7XEQ9DvRDWFhhifp2cAdSl8AE4xzoJGL3CDqcK8x8mtP4bE2zS3QT+kHm3exBn7PTEi+IywwKtfHGGYINX5YqwvMBit2HEEBQ8jEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367699; c=relaxed/simple;
	bh=5mwqQcXwPQG1vfYfRzhvQotKJ6GybY8C5A/l+9oj7Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAL4X9saV3ioL7gC/lEHU2ObdY5sKFWdMFWCHmY8lZFJtq/lZYSMAc1LVqyPG3IZiBLcdGJJRJWLCcOl1q/R7wPAOMPyXoBfMbI2xkOllGcSE3vKrdYKU8yGswUiucSk2MlBvBge67O+akGzrGtL+IHXxOo5qSC6QEUC0xKdpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYVsHXNG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so150168766b.2
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367695; x=1727972495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SrfyyC+PRLC+WpPdeRspDOSitUa47cS/B9RDYMZnzwI=;
        b=eYVsHXNGeG7Dja3fqneB3j//pfr5Wx43Z/+p0Gb6OsMFNqmjTe3w573Cep8bskx9WZ
         z+EiAhHk+IgAanxzcpkI0Rv0bcBK7vdBiGDtDLE0ggSVWfPchLdtLvYdDVEJicBvX/jC
         hxokbe2XwzOM4Ex0FMHOkowMpmmkgP2AYsgCSPQmOjIEsRDh/RPCJsy4nKcIK/aBUwcU
         T3PDNp8hSdUg760OirUvEo7QcmzjU+M2ZwGOKGed7+ZwEnwlMqg0404Gkqztj2QHaO8O
         v4bPkEUIt0dZL2vvPup4EBDgqxBmKmRQqXB69R3TsJCku4ZNWgsXbpXvKCm61lDljXbP
         jGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367695; x=1727972495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrfyyC+PRLC+WpPdeRspDOSitUa47cS/B9RDYMZnzwI=;
        b=Bg5UZmqnbxmBmiFSPwX2KXBCKTLdxxbT7OxiPJnAmEcrWVdQ1Xx880vS1wEipczApJ
         aWya9FTkZEcgc49VqlvSLUDXxYless1NNRl2yVWnZ2segAPRk2jDJTyZ8Tdg7SkSA3GV
         yZrC//5SEXZIbeT1LhgDmtx64yS8p/hEuXHyo+YX+JV6608TdscoEF83yOxleYKT4JpK
         nhGLiQWqc3DEQxKt6JVts/bfegT5dVuEIl+KYa1rXEkS9KYSWR0y3yi48GYY5Z7RwGQm
         eNfjtsn5Y72PyN22qYdzwz0E6vjydpBmNbE9BoCrHZnGmT140fta8IS89K/lhj5H69uu
         05aw==
X-Gm-Message-State: AOJu0YxBHsRccUSoHi4DJyN3nE/rfWgy9GMfXJ7+8Ep0OFV4cYVX0+yJ
	IqoVrQ1Lrr8vA2vsiNSO0oL7CP4DXFzXtgRh7X73OH5erk/lJAabm5FcIvQp1feAk/H/VKcAhSF
	f3nf8mIsnwIx/tqfI3YhgFhIDaPI=
X-Google-Smtp-Source: AGHT+IF8ypqxLld9PCkBR05LX3hOSKNQleDj9aAxwVWtQHLq2zkB8cMdj2fU+M3Nxi4GfrWvI5z/4oNv+GA/Jvx4zio=
X-Received: by 2002:a17:907:c09:b0:a86:7514:e646 with SMTP id
 a640c23a62f3a-a93c4a69a42mr4392566b.42.1727367694885; Thu, 26 Sep 2024
 09:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925002210.501266-1-chantr4@gmail.com> <yxpa6ifnn4hzlhvi3tyzint564s6dzei2lxasb7l6hnfuv2q5i@fhxjci3jojbi>
In-Reply-To: <yxpa6ifnn4hzlhvi3tyzint564s6dzei2lxasb7l6hnfuv2q5i@fhxjci3jojbi>
From: Manu Bretelle <chantr4@gmail.com>
Date: Thu, 26 Sep 2024 09:21:23 -0700
Message-ID: <CAArYzr+CNua4tkh2wnq9r9aOAJh4mW=PgerM5vUTGO826L9Osg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: vm: add support for VIRTIO_FS
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

> >
> > diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selftests/bpf/config.vm
> > index a9746ca78777..da543b24c144 100644
> > --- a/tools/testing/selftests/bpf/config.vm
> > +++ b/tools/testing/selftests/bpf/config.vm
> > @@ -1,12 +1,15 @@
> > -CONFIG_9P_FS=y
> >  CONFIG_9P_FS_POSIX_ACL=y
> >  CONFIG_9P_FS_SECURITY=y
> > +CONFIG_9P_FS=y
> >  CONFIG_CRYPTO_DEV_VIRTIO=y
> > -CONFIG_NET_9P=y
> > +CONFIG_FUSE_FS=y
> > +CONFIG_FUSE_PASSTHROUGH=y
>
> In fs/fuse/Kconfig I see CONFIG_FUSE_PASSTHROUGH defaults on:
>
>         config FUSE_PASSTHROUGH
>                 bool "FUSE passthrough operations support"
>                 default y
>                 depends on FUSE_FS
>
> So is it necessary to set here? I suppose if it matters that we're sure
> it's enabled, it's better to be explicit.
>
IIRC, this is what part of the diff that was generated after running:
  ./scripts/config -e FUSE_FS -e VIRTIO_FS
over my original .config, but I may be wrong.

I don't remember adding this explicitly.

