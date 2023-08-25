Return-Path: <bpf+bounces-8678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E1788EF8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2511C20F88
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862F18B17;
	Fri, 25 Aug 2023 18:54:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADE1805A;
	Fri, 25 Aug 2023 18:54:08 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857371BD2;
	Fri, 25 Aug 2023 11:54:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-637aaaf27f1so1510586d6.0;
        Fri, 25 Aug 2023 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989646; x=1693594446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpiZq1iBEEF3XG5AT94vls9pl91CF5C4Jt4sCJYAp3Q=;
        b=PrvTCYcbZIPy8JACiPTvj8uTXgeulpd7fPlL/7rybVKMHFDpbj5sGSLnobftBTxrxc
         BquJOAUd/fFUdTs7C5CMb0LlRetgoh56XK5O4C9nFzD+SiH6J/FfB1/svyav+o6NWpIj
         OxhQWDpkAFVGAOE8jO80yxlBFW2qdzZgvTBF5Icgg0MFWRY5I1R9JpSLh7SBp/mjNEhh
         3m2StqX+52Ev3jNG80Mz7TmchE73bop7dd7mhAZYp0VEM9s98M0oj+ORHmbCu5i77DvQ
         zYjGyFKTVircmvYe1dvGmO2BijBbQEqBtEcLOS73OzT/2NB+XVGZDn2guNxga+3eRs6J
         XBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989646; x=1693594446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpiZq1iBEEF3XG5AT94vls9pl91CF5C4Jt4sCJYAp3Q=;
        b=VZMohUTY46/O4OzN7v8YV14atgKFKUlqfmdv4cHlt3wjapvadH6DLYkV1+g/lhX3RZ
         OUI53WtPk6kqMEbgrAytK4Xg+Pf7fJS06yGaZfvn4krichVODhqKFcFFsvylqqjiv4TL
         4BlnEO+OwOhS/21KUIV2MZbYN90JUOCm5w5gH6MUlagQX5qITbF1nT5z8qYpjV/bSo3L
         1nC1fEHCrLj+3PEC9gBNKnUCAFWTInyS8L3fkdfVNoDPqCg1nHaQmCZLmoXCyONLahMT
         w8fhNo7OTB9YrDKWMjCVYIo4D8pCX98WQ0daXYPG2Vn44NcUYxrnG2IRgWnQcpVfDAVY
         DMCg==
X-Gm-Message-State: AOJu0YzWd/Hkhx4vUKCTr6D7D+LWfi7+kyQ/V1q1HS3Xu0I2zTz6LpRI
	j1UuUmuXiZt/PH3eNqgzDocWk6fMXUpXhLYH6NM=
X-Google-Smtp-Source: AGHT+IGlbhI63wRLcFo+iK8WhcLKHolamzju8iWEpHtyTpgPDWc8G5Bbe0IN+X7a2hH492DW9doKZXIR3NDiaQDfhsc=
X-Received: by 2002:a05:6214:4111:b0:621:65de:f60c with SMTP id
 kc17-20020a056214411100b0062165def60cmr22001114qvb.3.1692989646564; Fri, 25
 Aug 2023 11:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823144713.2231808-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20230823144713.2231808-1-tirthendu.sarkar@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 25 Aug 2023 20:53:55 +0200
Message-ID: <CAJ8uoz26kQbpqikaWkO3TNwMC=4V=96tppGcm0fjpXgfRkKUww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	dan.carpenter@linaro.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 23 Aug 2023 at 17:05, Tirthendu Sarkar
<tirthendu.sarkar@intel.com> wrote:
>
> Currently, xsk_build_skb() is a function that builds skb in two possible
> ways and then is ended with common error handling.
>
> We can distinguish four possible error paths and handling in xsk_build_skb():
>  1. sock_alloc_send_skb fails: Retry (skb is NULL).
>  2. skb_store_bits fails : Free skb and retry.
>  3. MAX_SKB_FRAGS exceeded: Free skb, cleanup and drop packet.
>  4. alloc_page fails for frag: Retry page allocation w/o freeing skb
>
> 1] and 3] can happen in xsk_build_skb_zerocopy(), which is one of the two
> code paths responsible for building skb. Common error path in
> xsk_build_skb() assumes that in case errno != -EAGAIN, skb is a valid
> pointer, which is wrong as kernel test robot reports that in
> xsk_build_skb_zerocopy() other errno values are returned for skb being
> NULL.
>
> To fix this, set -EOVERFLOW as error when MAX_SKB_FRAGS are exceeded and
> packet needs to be dropped in both xsk_build_skb() and
> xsk_build_skb_zerocopy() and use this to distinguish against all other
> error cases. Also, add explicit kfree_skb() for 3] so that handling of 1],
> 2], and 3] becomes identical where allocation needs to be retried.

Thanks Tirtha for the fix.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> ---
> Changelog:
>         v2 -> v3:
>         - Added further details in commit message as asked by Maciej
>         v1 -> v2:
>         - Removed err as a parameter to xsk_build_skb_zerocopy()
>         [Stanislav Fomichev]
>         - use explicit error to distinguish packet drop vs retry
>
>  net/xdp/xsk.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index fcfc8472f73d..55f8b9b0e06d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -602,7 +602,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>
>         for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
>                 if (unlikely(i >= MAX_SKB_FRAGS))
> -                       return ERR_PTR(-EFAULT);
> +                       return ERR_PTR(-EOVERFLOW);
>
>                 page = pool->umem->pgs[addr >> PAGE_SHIFT];
>                 get_page(page);
> @@ -655,15 +655,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>                         skb_put(skb, len);
>
>                         err = skb_store_bits(skb, 0, buffer, len);
> -                       if (unlikely(err))
> +                       if (unlikely(err)) {
> +                               kfree_skb(skb);
>                                 goto free_err;
> +                       }
>                 } else {
>                         int nr_frags = skb_shinfo(skb)->nr_frags;
>                         struct page *page;
>                         u8 *vaddr;
>
>                         if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
> -                               err = -EFAULT;
> +                               err = -EOVERFLOW;
>                                 goto free_err;
>                         }
>
> @@ -690,12 +692,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>         return skb;
>
>  free_err:
> -       if (err == -EAGAIN) {
> -               xsk_cq_cancel_locked(xs, 1);
> -       } else {
> -               xsk_set_destructor_arg(skb);
> -               xsk_drop_skb(skb);
> +       if (err == -EOVERFLOW) {
> +               /* Drop the packet */
> +               xsk_set_destructor_arg(xs->skb);
> +               xsk_drop_skb(xs->skb);
>                 xskq_cons_release(xs->tx);
> +       } else {
> +               /* Let application retry */
> +               xsk_cq_cancel_locked(xs, 1);
>         }
>
>         return ERR_PTR(err);
> @@ -738,7 +742,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 skb = xsk_build_skb(xs, &desc);
>                 if (IS_ERR(skb)) {
>                         err = PTR_ERR(skb);
> -                       if (err == -EAGAIN)
> +                       if (err != -EOVERFLOW)
>                                 goto out;
>                         err = 0;
>                         continue;
> --
> 2.34.1
>
>

