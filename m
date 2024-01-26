Return-Path: <bpf+bounces-20382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7B83D96F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 12:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D46B2A263
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481F1428E;
	Fri, 26 Jan 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3KoTJ6J"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7514013
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268040; cv=none; b=WpReOT5ehJZeAh7+gL4cT+VhgeoJD8s11v8oRadjSBbWeek6LEUAqq0xDdAdNpNRPO6sCNOCPtBadDFzyVG2sOaaID6cCL9b1Y4bOEmCWEOkqV/z+vn5vpehSwq969EtWQkxIMOtUfxAzJtmdjHqd5BNQGzOPkT9aY2ARxPdZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268040; c=relaxed/simple;
	bh=rUDCyjkqCSegFTrxzDZFLtSC0X1851BiYh6zk6ILQUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+WZVC7qTMudB3sXXIvY4DWkyAOzueOHNOOCqjI+/FOuHV8lT7KMTaXrYbBxdBdf+8w4/ZqE5JHOJf/EhYno5aZVQjLVBExZCYR3tPHQ5OAbR16X4mOShOzY3HNk6iFZjbR/ANIuJfQ/g0TjfP+i/neWy6bFFjTzLE0RbpB37Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3KoTJ6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706268038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adKrKcsVsy8nxrIIG/cxmKvYrilkzcpLV+j2FAcibZc=;
	b=I3KoTJ6J0l9oaJKG7d1aAeTwTuSqI3blcDg4KYFISmbHsscv2C0Vz7DtRTDH5sWK/GQMgx
	xVBYmK4eqr8EjM47Pgoy1mQmCNBIJzjSNWBamYXryEAVUe3HXNuJgXShBdRspEZPHMwKhg
	T6MsYCW1Xu6n+2DKz09EXTI7+0dLfs0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-wt0vvWCwPiS3qAUe9zlJ1A-1; Fri, 26 Jan 2024 06:20:36 -0500
X-MC-Unique: wt0vvWCwPiS3qAUe9zlJ1A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a350f83730eso6901766b.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 03:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706268035; x=1706872835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adKrKcsVsy8nxrIIG/cxmKvYrilkzcpLV+j2FAcibZc=;
        b=ef3F3d4pNyju7wnsa02/G+J6hHzuGvAhZK+fYyxzoquJm0oJ0vrUS3X1qkWmcUaA+G
         nilTHKy8jX2kVCHlvTCegl6Wz1DDOWOPWrT3rMpfkx2wkhfVg/f5alaZw0f52YbcXA7W
         O5d0Gb6UB94Lll9n6F4i7/89uwMmYszx5AGO13Lr2t2i1XT0bL2+MKvXXEeF1iDQUeY+
         fpE8BKA2jSdPuoO+fFelM7kGZck8DwGQpJD/wdK5uawk3fpxLt75z+/2/8DRL/WBCIT5
         Q6iGleAqWMjpsyeMrQEySq68oLPXk6FrDV9T3kffFFuOXf/qof/mSzaSg+12+ge74y3q
         a6cA==
X-Gm-Message-State: AOJu0YyEQib98oKZWG/ZNqCnEBZef4AFUf29uF6GL9ycocfZftzevwlW
	8SJqvt4OZKyFXfURXvcASZLWLsF2zwBmjoTwoveRObKeShFVGRZDJzzvXQu7MBKJ7HySWf/FZF1
	hoOKo5akPxKA3E3EA7XwQqkSH9Vf0EjAd72EfavKQxj0BD8J/JP+co9tN0cds9SEZsusnaPFax0
	O/i3vZKq7sUC9qz1tcaozQPCt4
X-Received: by 2002:a17:906:1b57:b0:a33:2ea8:6c45 with SMTP id p23-20020a1709061b5700b00a332ea86c45mr1153418ejg.19.1706268035436;
        Fri, 26 Jan 2024 03:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFXUuQde2ZQSJlUg0Q4EcQL0ZwIpzUDUFkwVkwVyFgYDxpfpgyPr4TsY9axdE6ilwDji2IFnSyFKy2lexowRo=
X-Received: by 2002:a17:906:1b57:b0:a33:2ea8:6c45 with SMTP id
 p23-20020a1709061b5700b00a332ea86c45mr1153407ejg.19.1706268035096; Fri, 26
 Jan 2024 03:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-b4-hid-bpf-fixes-v2-0-052520b1e5e6@kernel.org> <20240124-b4-hid-bpf-fixes-v2-2-052520b1e5e6@kernel.org>
In-Reply-To: <20240124-b4-hid-bpf-fixes-v2-2-052520b1e5e6@kernel.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 26 Jan 2024 12:20:23 +0100
Message-ID: <CAO-hwJ+xOF=GH115_KcWKjXLqeKU-BzXmNY0bvOzhZQb0WkEDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] HID: bpf: actually free hdev memory after
 attaching a HID-BPF program
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:27=E2=80=AFPM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
>
> Turns out that I got my reference counts wrong and each successful
> bus_find_device() actually calls get_device(), and we need to manually
> call put_device().
>
> Ensure each bus_find_device() gets a matching put_device() when releasing
> the bpf programs and fix all the error paths.
>
> Cc: stable@vger.kernel.org
> Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> new in v2
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c  | 29 +++++++++++++++++++++++------
>  drivers/hid/bpf/hid_bpf_jmp_table.c | 19 ++++++++++++++++---
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 5111d1fef0d3..7903c8638e81 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -292,7 +292,7 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd,=
 __u32 flags)
>         struct hid_device *hdev;
>         struct bpf_prog *prog;
>         struct device *dev;
> -       int fd;
> +       int err, fd;
>
>         if (!hid_bpf_ops)
>                 return -EINVAL;
> @@ -311,14 +311,24 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_f=
d, __u32 flags)
>          * on errors or when it'll be detached
>          */
>         prog =3D bpf_prog_get(prog_fd);
> -       if (IS_ERR(prog))
> -               return PTR_ERR(prog);
> +       if (IS_ERR(prog)) {
> +               err =3D PTR_ERR(prog);
> +               goto out_dev_put;
> +       }
>
>         fd =3D do_hid_bpf_attach_prog(hdev, prog_fd, prog, flags);
> -       if (fd < 0)
> -               bpf_prog_put(prog);
> +       if (fd < 0) {
> +               err =3D fd;
> +               goto out_prog_put;
> +       }
>
>         return fd;
> +
> + out_prog_put:
> +       bpf_prog_put(prog);
> + out_dev_put:
> +       put_device(dev);
> +       return err;
>  }
>
>  /**
> @@ -345,8 +355,10 @@ hid_bpf_allocate_context(unsigned int hid_id)
>         hdev =3D to_hid_device(dev);
>
>         ctx_kern =3D kzalloc(sizeof(*ctx_kern), GFP_KERNEL);
> -       if (!ctx_kern)
> +       if (!ctx_kern) {
> +               put_device(dev);
>                 return NULL;
> +       }
>
>         ctx_kern->ctx.hid =3D hdev;
>
> @@ -363,10 +375,15 @@ noinline void
>  hid_bpf_release_context(struct hid_bpf_ctx *ctx)
>  {
>         struct hid_bpf_ctx_kern *ctx_kern;
> +       struct hid_device *hid;
>
>         ctx_kern =3D container_of(ctx, struct hid_bpf_ctx_kern, ctx);
> +       hid =3D (struct hid_device *)ctx_kern->ctx.hid; /* ignore const *=
/
>
>         kfree(ctx_kern);
> +
> +       /* get_device() is called by bus_find_device() */
> +       put_device(&hid->dev);
>  }
>
>  /**
> diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bp=
f_jmp_table.c
> index 12f7cebddd73..85a24bc0ea25 100644
> --- a/drivers/hid/bpf/hid_bpf_jmp_table.c
> +++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
> @@ -196,6 +196,7 @@ static void __hid_bpf_do_release_prog(int map_fd, uns=
igned int idx)
>  static void hid_bpf_release_progs(struct work_struct *work)
>  {
>         int i, j, n, map_fd =3D -1;
> +       bool hdev_destroyed;
>
>         if (!jmp_table.map)
>                 return;
> @@ -220,6 +221,12 @@ static void hid_bpf_release_progs(struct work_struct=
 *work)
>                 if (entry->hdev) {
>                         hdev =3D entry->hdev;
>                         type =3D entry->type;
> +                       /*
> +                        * hdev is still valid, even if we are called aft=
er hid_destroy_device():
> +                        * when hid_bpf_attach() gets called, it takes a =
ref on the dev through
> +                        * bus_find_device()
> +                        */
> +                       hdev_destroyed =3D hdev->bpf.destroyed;
>
>                         hid_bpf_populate_hdev(hdev, type);
>
> @@ -232,12 +239,18 @@ static void hid_bpf_release_progs(struct work_struc=
t *work)
>                                 if (test_bit(next->idx, jmp_table.enabled=
))
>                                         continue;
>
> -                               if (next->hdev =3D=3D hdev && next->type =
=3D=3D type)
> +                               if (next->hdev =3D=3D hdev && next->type =
=3D=3D type) {
> +                                       /*
> +                                        * clear the hdev reference and d=
ecrement the device ref
> +                                        * that was taken during bus_find=
_device() while calling
> +                                        * hid_bpf_attach()
> +                                        */
>                                         next->hdev =3D NULL;
> +                                       put_device(&hdev->dev);

sigh... I can't make a correct patch these days... Missing a '}' here
to match the open bracket added above :(

I had some debug information put there to check if the device was
actually freed, and the closing bracket got lost while cleaning this
up.

Cheers,
Benjamin

>                         }
>
> -                       /* if type was rdesc fixup, reconnect device */
> -                       if (type =3D=3D HID_BPF_PROG_TYPE_RDESC_FIXUP)
> +                       /* if type was rdesc fixup and the device is not =
gone, reconnect device */
> +                       if (type =3D=3D HID_BPF_PROG_TYPE_RDESC_FIXUP && =
!hdev_destroyed)
>                                 hid_bpf_reconnect(hdev);
>                 }
>         }
>
> --
> 2.43.0
>


