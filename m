Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3227ACDB
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgI1LeG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgI1LeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 07:34:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0CC061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 04:34:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b17so480753pji.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FdlCOfUomxaV3oXhqokLgKx58K1pq5fowMywNeXbEY=;
        b=WGpN7+1HeVQQX1sijwgedsxhacVmoYbTSd7W6c2n1z/jWksenoMpZeRwtXIaXoFygF
         P2n81Zcp5JyyGfrE0gvBCrZuz4uTUtLJCP/3VU0vYKbySuAK3TcCUDj412QDfnbJE1hj
         c/NxIqHrVpBRYmkNIqEaShJ76sJOz24YjMrBD6NfRFB8VhT8J1WpJWOi67Byk71j9Ccx
         FS1u6c/2XFvMw/Lvb3RHGgeoY0iBVEB9VXVJEdukwW8MBZZcGiD91H0Cl/fMG3wXwPPY
         ZaazT/EHGgzw7W4WiXx/UBB6/IYuEGsYOLfYKukbsITJLM36gfvnVY3DVOFz0WdT1vNx
         m/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FdlCOfUomxaV3oXhqokLgKx58K1pq5fowMywNeXbEY=;
        b=bz5wEsPnQ18kvCnqv1cvQBNPaomejeQ+jcUVHW5fABqwT/MmlPcrX1DGDZDFArhJKs
         Yk95UsIdc7Mlq2N/9L4Z/T3M7EUSFc8ayy4J7kgJBeOMhIWMRCb+PmqoIY5OaWkwqZgv
         UN986Gj6v88Y67E+8MkiXTvAJmuCbfWv3JVpCwKrK0V4xhAtR5jnY2I6MhPl4f4poOaB
         +uVbTcLcIvvh1YNq4oZAiKqjVyDJufYFIwpYL9TGxMgqeTLdxSmffWS5U2/IauKPNipv
         u2Km4BDbXO6f7IMPf+y7i0VxnDucItiFtwjcQnVN6F9fReZqXu1eAd85wi2NEN3C7jfJ
         Resg==
X-Gm-Message-State: AOAM530ictHmtaFRZy1/WKGN2tddXcWVQ4K68Vx5F9CX6BMWHo8rx0Do
        HDZjBGQgK8dKtyEw3KaOFFi7aORAXdrlPYF76DE=
X-Google-Smtp-Source: ABdhPJyx+wcgIilE/4xNrWvxgkNk8s8XoROstzaWtjgv2de2CmA3o4Wsy3qG1+LV9vzIHl95Vt1/DB8fZct4X+905nY=
X-Received: by 2002:a17:90a:e207:: with SMTP id a7mr969649pjz.117.1601292840955;
 Mon, 28 Sep 2020 04:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200928082344.17110-1-ciara.loftus@intel.com>
In-Reply-To: <20200928082344.17110-1-ciara.loftus@intel.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Mon, 28 Sep 2020 13:33:49 +0200
Message-ID: <CAJ8uoz0pP3Q0rvXBraRquNvv_Z4hiZTXPV3sCc2P6ieVQGKX7A@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix a documentation mistake in xsk_queue.h
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 28, 2020 at 10:49 AM Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> After 'peeking' the ring, the consumer, not the producer, reads the data.
> Fix this mistake in the comments.
>
> Fixes: 15d8c9162ced ("xsk: Add function naming comments and reorder functions")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  net/xdp/xsk_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index bf42cfd74b89..a0bb2f722b3f 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -96,7 +96,7 @@ struct xsk_queue {
>   * seen and read by the consumer.
>   *
>   * The consumer peeks into the ring to see if the producer has written
> - * any new entries. If so, the producer can then read these entries
> + * any new entries. If so, the consumer can then read these entries
>   * and when it is done reading them release them back to the producer
>   * so that the producer can use these slots to fill in new entries.
>   *
> --
> 2.17.1
>

Thank you Ciara.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
