Return-Path: <bpf+bounces-40639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8CC98B2E5
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E28B2280F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189201B1D70;
	Tue,  1 Oct 2024 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2J90eag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F51B1D63
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755578; cv=none; b=nC9EouK7pZyVH7yyjELnsVvJBXs06Qq1Ct23IRkvn59hvl2WmHazLYl6QomzovL7jPgPCQs8/TNpDCHQ6o7MWLr6Uhg6QvOlpBsy5VeiH9PBt1ZPruEztpc/ZWlzzmBgCtwTAuA5YOuCgDZG7yBUHSDxQx/TDVxRaRBxpKUEw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755578; c=relaxed/simple;
	bh=a9etoQnpj9/Xb7+iogYzSqg0qlyUy2yo3HYhMmK0gdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1Gc1vhomxvsG8UbLfbXWfYeYWonXRi01pDlXwrv+LdjHsLJJpE2dWTuPYk1gTrPTdmOKm2N6s779gHSz5xZbUhrPkVfqfoLYB3unJCtaxgGyrxr190IvmRERF5bfXMjnRStnN1LjRqcrLc1QaYL+FLnbVST+RDYFDIKHREygc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2J90eag; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so45982505e9.3
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 21:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727755575; x=1728360375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9etoQnpj9/Xb7+iogYzSqg0qlyUy2yo3HYhMmK0gdM=;
        b=d2J90eagAvSddpjgwD57y8jffcnEP5VvDITJXDBomHqc+qvF2f08SyGmxrWF6doL4y
         V9suuSGSYxH/Nn1H6o0j6ptVyDpzXurUSw59pDlULMAbNLjj5Z8U4S3fNETIZZzA94ov
         BW1SqK+5TU2j0kHI8o4pvEv8+5g3b2WSDp4I+hRPaYBPM23/zZJ0EhrhVsYm0eeeueD8
         sajJJuqo3e6S/XIA7oC2g6invJWuF1RVeKjQBz39Bb8jDpUUPMrtlDQ0hIdzYsYPQwVz
         qqAG/Iywr26uF75TGIaJP1gPkE9FYpIRIT0f0tOfsX+qK12/aQpnUzFZC67OZzvD2l4U
         bQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727755575; x=1728360375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9etoQnpj9/Xb7+iogYzSqg0qlyUy2yo3HYhMmK0gdM=;
        b=kT6RV3Dy+eeO2rvfUzUwCBD/CDqw8tUdr+F7gWAv7XzwEB+ZOeIUDl604E85l6AFh9
         002CMiVws8MdSR/Zyj+bB5P0DMoJFIQ80Q7ziQOROlpIZ9mG8errKRI6OQeYc76m4dh0
         PeMVP0elQjxih967vqKpTi0oBVwEttj4GVoE3Mgi4r5Zyo9OMws1yfmf+QSxXTqOeiBT
         vuZlA9HGn1RiZbTFuhI5e0nykTlIBO9d7HU4rVb3VUmviibDAlYraPoRpSKikjgQozTH
         7UWuCt8nfhwRHHeNao7NwheDK0sw5q/HiXNzOwLYXKBofQWtVl7WJHJiuuMFfXKeM5ZG
         bzAQ==
X-Gm-Message-State: AOJu0Yy9Fp6op0AQDbAen8czLTf00mG1BRK1gCndYs1yeS+bH21XHfIU
	SVV9LML66BNuMqUoMJPYxNCBzp+MGJaVztsfqPS/IOBLd8zqkkzpOyk5UfGuPNlQjaE8/E8W1Al
	Lmu8a2W3RvkkmSNPl58oJ9Py9/Gw=
X-Google-Smtp-Source: AGHT+IGaqnOFUfxlT6OXPcwSV0S8VGjkcUDsUPPbl/0c40TFwYynkWsk2ybpHZpeEq3/uqrQbOrCDqVJuY/1qgH3wsk=
X-Received: by 2002:a05:600c:1ca2:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-42f58433782mr107606695e9.12.1727755574913; Mon, 30 Sep 2024
 21:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+KXx0WsH1en-DNXLf4mc4bC7apK_U9js0KbFSfp8Jdm8K8W9w@mail.gmail.com>
 <CAEf4BzZjmz7dqOe--MYAV8F=h-RAhfnhHmW66W56GZeCKjVOww@mail.gmail.com>
In-Reply-To: <CAEf4BzZjmz7dqOe--MYAV8F=h-RAhfnhHmW66W56GZeCKjVOww@mail.gmail.com>
From: Abhik Sen <abhikisraina@gmail.com>
Date: Tue, 1 Oct 2024 09:36:01 +0530
Message-ID: <CA+KXx0WOmany6RdE8uaYMiCHd6FPNfXC3RxUfd-zE4UBaiO5Rw@mail.gmail.com>
Subject: Re: QUERY: Regarding bpf link cleanup for invalid binary path
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.

Yes you did understand the concern I was having, more precisely if I
have a bpf_link from libbpf's bpf_program__attach_uprobe_opts(), on a
binary path say "proc/<PID_12>/root/lib64/libpam.so", and the
namespace containing <PID_12> is terminated, thereby killing the
process <PID_12>, what happens to the bpf_link?

If I understood you correctly then even in this scenario one should
explicitly call the bpf_link__destroy on that link?
Thanks.

On Sat, Sep 28, 2024 at 4:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Sep 22, 2024 at 10:18=E2=80=AFPM Abhik Sen <abhikisraina@gmail.co=
m> wrote:
> >
> > Hello Team!
> >
> > We were looking into the bpf-link and bpf-program-attach-uprobe-opts
>
> Is the API actually called "bpf-program-attach-uprobe-opts" or we are
> talking about libbpf's bpf_program__attach_uprobe_opts()? In the
> former case, which library and API are we talking about? In the latter
> case, why rewrite API names and cause unnecessary confusion?
>
> > implementation and wanted to know if a bpf-link on a binary path
> > resulted out of bpf-program-attach-uprobe-opts([a binary path]),
> > remains valid and leaks memory post the binary path getting invalid
> > (say due to the file getting deleted or path does not exist anymore).
>
> I'll try to guess what you are asking. If you attached uprobe to some
> binary that was present at the time of attachment successfully, and
> then binary was removed from the file system *while uprobe is still
> attached*, then that binary is still there in the kernel and uprobe is
> still, technically active (there could be processes that were loaded
> from that binary that are still running). It's not considered a leak,
> that's how Linux object refcounting works.
>
> >
> > Does calling bpf-link-destroy on that link give any additional safety
> > w.r.t the invalid binary path, or is it not needed to invoke and the
> > internal implementation of the bpf-link takes care of the essential
> > cleanup?
>
> bpf_link__destroy() (that's libbpf API name) will detach uprobe, and
> if that uprobe was the last thing to keep reference to that deleted
> file, it will be truly removed and destroyed at that point. So you
> might want to do that, but it has nothing to do with safety.
>
> >
> > Thanks,
> > Abhik
> >

