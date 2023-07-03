Return-Path: <bpf+bounces-3922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93C7464AC
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB651C20A7D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A911CBB;
	Mon,  3 Jul 2023 21:06:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE5100B3;
	Mon,  3 Jul 2023 21:06:57 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D7E70;
	Mon,  3 Jul 2023 14:06:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so905864a12.1;
        Mon, 03 Jul 2023 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688418408; x=1691010408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s37NzTHMUBaqLFmLcuPGyHFd30//csXthbXBR4ahCA=;
        b=jrrCeScL4kYlEtkq3xekVTO6oZ+0cPyT6bqmExqbVucAP4WHz/eAFck7ntHOrVZvnI
         RfHU2A12F0LjJvEqyGXtbYw+I4zqcFu7uSQ61gIsqMsx+9Xreqb6LVhR3XuYMTjJoKwJ
         caAoK9T3CtgD2thvP/4ttX6ZMq6D4VVGWNhLO8MhpAkdJ6/ZEnm0U3HjYOif+nRBHj2B
         n/vPWyAq/Irxzk2cP1JYYilGgD3hQBKdGo2EqEg7WNulkg57Q2iJzpWiMT9UptW2LP5T
         R+vyHC8qeSlyZPIbjjzjuBOVmeSIT2ujSI48UIPO9lYSHFHYU5/OZiO44SQt9ngCXKpk
         LQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688418408; x=1691010408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0s37NzTHMUBaqLFmLcuPGyHFd30//csXthbXBR4ahCA=;
        b=FZGRHQMyCd+SEur/UbD4m2gZijF1r5XAk6DzpB6M6N2ZQJJ36TAtBZQwyYKt1OA6aH
         B5fvqIBbFxHhvK85Dc0z3IvsTkHiS2+BZ6BKlSNC53IM08zQX6o6TFD0lgIz5T8QJudg
         PpUSFEASA9A+CMzCxWbKox/P1EMqZ8eVvkWw1NyPh6oWp0wcq/31vY6MXO263QKdfQey
         mVSuwl3MffeVQU2G/xVpxR4Rn6JgatcAzTZPjg8YAVk6W35GkfrK0Sv/6WUBpDFJDV2S
         DA30BfYanI0q5HFBWn1buQmVFy8roRZS11FOQdMI7R9oOnLdMskGmYCzB88CZgqF0E9F
         bsZg==
X-Gm-Message-State: AC+VfDxfonl/c/fgEUjXcENNwt56ocSrbg/UFnXTehW6qRMvJVh0zBMk
	P6OOzYNYsiqLp7GdAleg8i4=
X-Google-Smtp-Source: ACHHUZ47oCDS/VawOuS05S/BzNAIqU7kzR5VjubUQNTZC6eVHkTjWUNkjY1bpISisIJKBK3hmgQWpA==
X-Received: by 2002:a05:6a20:54a8:b0:126:2bb7:d660 with SMTP id i40-20020a056a2054a800b001262bb7d660mr22649845pzk.7.1688418407947;
        Mon, 03 Jul 2023 14:06:47 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id q28-20020a635c1c000000b00548d361c137sm14962708pgb.61.2023.07.03.14.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:06:47 -0700 (PDT)
Date: Mon, 03 Jul 2023 14:06:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, 
 bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 netdev@vger.kernel.org, 
 Aleksander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <64a3386623163_65205208fe@john.notmuch>
In-Reply-To: <20230703181226.19380-16-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-16-larysa.zaremba@intel.com>
Subject: RE: [PATCH bpf-next v2 15/20] net, xdp: allow metadata > 32
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Larysa Zaremba wrote:
> From: Aleksander Lobakin <aleksander.lobakin@intel.com>
> 
> When using XDP hints, metadata sometimes has to be much bigger
> than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
> and make __skb_metadata_differs() work with bigger lengths.
> 
> Now size of metadata is only limited by the fact it is stored as u8
> in skb_shared_info, so maximum possible value is 255. Other important
> conditions, such as having enough space for xdp_frame building, are already
> checked in bpf_xdp_adjust_meta().
> 
> The requirement of having its length aligned to 4 bytes is still
> valid.
> 
> Signed-off-by: Aleksander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  include/linux/skbuff.h | 13 ++++++++-----
>  include/net/xdp.h      |  7 ++++++-
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 91ed66952580..cd49cdd71019 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4209,10 +4209,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
>  {
>  	const void *a = skb_metadata_end(skb_a);
>  	const void *b = skb_metadata_end(skb_b);
> -	/* Using more efficient varaiant than plain call to memcmp(). */
> -#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64

Why are we removing the ifdef here? Its adding a runtime 'if' when its not
necessary. I would keep the ifdef and simply add the default case
in the switch.

