Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EF6013F3
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJQQwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJQQwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 12:52:23 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86CF031;
        Mon, 17 Oct 2022 09:52:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n130so12753068oia.6;
        Mon, 17 Oct 2022 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1LwX5bRFQXNkq6PB+GJkYIHW1maFFhRT+npXlh3EBU=;
        b=Wli2+vCUPK20VH6qBK0/9u0+D86Cprn715QA3rGfohk6lLxfaKQ/gr2fBPGeUKivfV
         9scv3keMMR40vWDmdGPV9mBFqcrR3IHAjiKgk9g2HFz+2GzmZeYm2V80n+MJ78WVfpcT
         yeYzVTE/N/xMeay1FUkdDXp4VjEEugswL6+/mgtjc3koOgAHsXFOFPuqyxYHHSkwavDv
         C+M6uSoIBnLjtzFoB6Ioq0cJQ0heFLwsSXacVrlHTrT1UMeP6VkCilRtw5NikcgJK2rM
         52sgzEMrbJk98DoOJk/9P8dvOgrS6rFCixGcl08kKYuIS08WWQTsUWkkSY90XgZi+dpx
         Y0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1LwX5bRFQXNkq6PB+GJkYIHW1maFFhRT+npXlh3EBU=;
        b=XSSNn23qw/E0UN8ffxR5ZpQNZdHRIaPHIlYMLIJLCONrfLQIoossvJu098Kea8vvO2
         G5p0I6/uftBfotA8cjJf1RSS0ZeRM4B9pHLzgW8N+nchKJAXMWS9WnQQFOTveSrmpFz1
         LJPzUWMqtgLdQtCg0YO8ErZTb441Rw1H8ESpjpJiHgKoE5ECP7HdobC1fwvUMO3TAvjP
         o/EDCPb3qkytJQsjKDCbXVFoZ+ndFgO9eU7vwm+UTQaFqOF0G9bPxY3cZD5AJ+eFWmzN
         rQGK5eJtpMmx5zuNYmewxjPQORkDlSBPuPafKz6olaQw88m5DdqcbqJrPPXdMhnbL8Go
         CDJw==
X-Gm-Message-State: ACrzQf1nQvzPzYESHAA6ACxGrbAm0A5rvo5pjGpqaWYFcDUskChRdIP0
        78bH5vQJ4wLob1gR+FTOcHKKCv3ma4n03pcuBIM=
X-Google-Smtp-Source: AMsMyM7pkfs8YvaEJ3rXNBXJfzbthWWMDK+JMBHXzoIgFykCTCTTewwkS0A48fh2TzykUTENTQtzoKPd6PQhlDPFwow=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr5577155oiw.96.1666025541711; Mon, 17
 Oct 2022 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210714.16320-1-fmdefrancesco@gmail.com> <fb0b7389-7121-04f8-176d-1ababe0ad8f2@amd.com>
In-Reply-To: <fb0b7389-7121-04f8-176d-1ababe0ad8f2@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Oct 2022 12:52:10 -0400
Message-ID: <CADnq5_PP3VCXQ5rbC0-8Qsi5W7Ew87U_bRknz4=qxbrPxVQ+qA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Applied.  Thanks!

On Fri, Oct 14, 2022 at 3:03 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 13.10.22 um 23:07 schrieb Fabio M. De Francesco:
> > The use of kmap() is being deprecated in favor of kmap_local_page().
> >
> > There are two main problems with kmap(): (1) It comes with an overhead =
as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when t=
he
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, t=
he
> > kernel virtual addresses are restored and still valid.
> >
> > Therefore, replace kmap() with kmap_local_page() in radeon_ttm_gtt_read=
().
> >
> > Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index d33fec488713..bdb4c0e0736b 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -869,11 +869,11 @@ static ssize_t radeon_ttm_gtt_read(struct file *f=
, char __user *buf,
> >
> >               page =3D rdev->gart.pages[p];
> >               if (page) {
> > -                     ptr =3D kmap(page);
> > +                     ptr =3D kmap_local_page(page);
> >                       ptr +=3D off;
> >
> >                       r =3D copy_to_user(buf, ptr, cur_size);
> > -                     kunmap(rdev->gart.pages[p]);
> > +                     kunmap_local(ptr);
> >               } else
> >                       r =3D clear_user(buf, cur_size);
> >
>
