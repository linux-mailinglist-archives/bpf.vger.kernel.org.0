Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40A24856A
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRMxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHRMxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 08:53:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91ADC061389
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 05:53:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so15143315edk.6
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZNHqIo/o5PTzslTmWoWeSNX4Sf55a+mcEE0Ya1Wrqu4=;
        b=px6BOetxPov2VXZZYWCIwmQJXRiJdu2zYyppgQ4NJ0GFSaVjXYbMaWUeRKZJzvjVVK
         bQM1szrg0N5zIbrxv4Aw/tfY0Bd9U18IDyG1Znu7edZasCe6ou407EkE8OnjKZM1Z2oE
         wDUJMG6BbOdP2OKwZ7roQlXrLaCTGu+IZFjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ZNHqIo/o5PTzslTmWoWeSNX4Sf55a+mcEE0Ya1Wrqu4=;
        b=myXI5hKchVHPsq0f3X+ypT2IBipfm8emjnH+BQb1pAisYu0M9XP0HsxglwlMHedq5w
         rAmJRzXUoncdaF21UD64v1pEHz2SbQGvO1KF6b1KXadMgXLFxvxpr312JAMnYzIQrPK6
         +WRX6iCsP43ts1oSjXwMNuxWZ4JWcQGM/d+lJXahDIz6cE/gQhDDw7EmYMR3imjKpfRR
         Fyw9yRxWgdvRsqqbnuHUbZd67TIeT/qeDVu7dYib3uz0cNCcdDTimS1fFo/i13CEKRU6
         V2rviZDmMB6e0dvoMwiRm8eCO1sN9lCtYPh4HlWifsKjCRebLNhIaAXHZKYqWvvZnrfk
         jS6g==
X-Gm-Message-State: AOAM531sicxHpn/5XSVvXBHpyKxNV5ySHzDG0lGadsiWEW04qCtqnMum
        tkqgia9Zpdj6ZC3qyzd8JZBHNg==
X-Google-Smtp-Source: ABdhPJyIhdEd4dxx01MULiiDY53D0MAL/G49AynyKxTBCBWiwvdErSQptzndvDSyYLQHJa0lENC/1A==
X-Received: by 2002:a05:6402:c81:: with SMTP id cm1mr19000313edb.256.1597755224405;
        Tue, 18 Aug 2020 05:53:44 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j1sm15478983edq.58.2020.08.18.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:53:43 -0700 (PDT)
References: <20200812163305.545447-1-leah.rumancik@gmail.com> <20200812163305.545447-2-leah.rumancik@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
In-reply-to: <20200812163305.545447-2-leah.rumancik@gmail.com>
Date:   Tue, 18 Aug 2020 14:53:42 +0200
Message-ID: <87mu2sru7d.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 06:33 PM CEST, Leah Rumancik wrote:
> Introducing a new program type BPF_PROG_TYPE_IO_FILTER and a new
> attach type BPF_BIO_SUBMIT.
>
> This program type is intended to help filter and monitor IO requests.
>
> Co-developed-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Kjetil =C3=98rbekk <orbekk@google.com>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---

[...]

> diff --git a/block/blk-bpf-io-filter.c b/block/blk-bpf-io-filter.c
> new file mode 100644
> index 000000000000..453d6b156bd2
> --- /dev/null
> +++ b/block/blk-bpf-io-filter.c

[...]

> +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *p=
rog)
> +{
> +	struct gendisk *disk;
> +	struct fd f;
> +	struct bpf_prog_array *old_array;
> +	struct bpf_prog_array *new_array;
> +	int ret;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	f =3D fdget(attr->target_fd);
            ^^^^^

Missing corresponding fdput?

As per Martin's suggestion, with bpf_link this will become the
link_create callback, but the comment still stands.

> +	if (!f.file)
> +		return -EBADF;
> +
> +	disk =3D I_BDEV(f.file->f_mapping->host)->bd_disk;
> +	if (disk =3D=3D NULL)
> +		return -ENXIO;
> +
> +	ret =3D mutex_lock_interruptible(&disk->io_filter_lock);
> +	if (ret)
> +		return ret;
> +
> +	old_array =3D io_filter_rcu_dereference_progs(disk);
> +	if (old_array && bpf_prog_array_length(old_array) >=3D BPF_MAX_PROGS) {
> +		ret =3D -E2BIG;
> +		goto unlock;
> +	}
> +
> +	ret =3D bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	rcu_assign_pointer(disk->progs, new_array);
> +	bpf_prog_array_free(old_array);
> +
> +unlock:
> +	mutex_unlock(&disk->io_filter_lock);
> +	return ret;
> +}

[...]
