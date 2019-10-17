Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD4DB693
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfJQSwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 14:52:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46912 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406895AbfJQSwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 14:52:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so2700105lfc.13
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=IqtM8krpn7TjILfLYbiENT8FZcwBT8PlSc6kum+UQO0=;
        b=eA9HD7e1ygqnDaz+YX/WyzVNcmjLglhBWzH/372d51x3t94hf3BVZaaBkQoUQN5Acj
         kmlG10cAqttSiedF0SQGwHZlA9G39HLn2QRp8EuyU22YftBXVLvnjmFUjrk9A38MrA6m
         CEYaWLPiXn8PnVOoPIWJPmrikFonbyWBHzWfH6TqxelCfXFg8iFsOYlPCud5zJzr6tK2
         KXbzkwiMmIV07ahgogi/B8xPDxPtbTm2ZNtDXc4jGKY3O5sE+t5Veg+EZpx37Lt7+xDM
         YfFHXL+WXN5gnj/euxqWyzIgDSKKGDuOGXZt7pMQG81hMZK7NBTdhqaGwKxSMyLGh5HS
         jGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=IqtM8krpn7TjILfLYbiENT8FZcwBT8PlSc6kum+UQO0=;
        b=doXhSiqLiWaCaKZcojxnfhjIzlrh0C1UoUtykG5fXwUgoEPtudpSiUQ6aeihMCFdlu
         JfZ1a1edgMy8GPru/VctVHC90eWLIcnicZ/ooCqHD5lqvL7UWHpUzrtQIONNvzIi9yVr
         MBDFpLWWmuuf/X5ZqN80cxgsLiRA8QuqIoJ7GX8YhmSUNxLRkkYGlFGLUbizuUmTcWuB
         9CMx+djrYXR96qYxlmJQnkulyf7rlFJOi2EEX9WM842RoS7bwzMcrt5Ivzpw8X2Hk8Qe
         JKcZMgKDBrk8RXGOK/oG66My5GSca708n/4Tfxfq2a/XJ/QZsR4u9Pg0lRB6td+nuptf
         eEgA==
X-Gm-Message-State: APjAAAVLUNfnSHkqIkpy67bYjyTBuZyQSBLyj2aKieVoitRA+2Zm4Xs0
        9SAIXiVrUV2Jv1U8ieKIBEAovfBuTXY=
X-Google-Smtp-Source: APXvYqyV9CFn3+MP7Rhjxgp5GigvlBBWAHg3O1aigNFEpOW42ZSuEjBQhHnRJkc3BxJ6Nqo0XD6QPg==
X-Received: by 2002:ac2:47f1:: with SMTP id b17mr3107418lfp.31.1571338362496;
        Thu, 17 Oct 2019 11:52:42 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 77sm1285777ljj.84.2019.10.17.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:52:42 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:52:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost
 calculation for 32-bit builds
Message-ID: <20191017115236.17895561@cakuba.netronome.com>
In-Reply-To: <20191017105702.2807093-1-toke@redhat.com>
References: <20191017105702.2807093-1-toke@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 17 Oct 2019 12:57:02 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Tetsuo pointed out that without an explicit cast, the cost calculation for
> devmap_hash type maps could overflow on 32-bit builds. This adds the
> missing cast.
>=20
> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up device=
s by hashed index")
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  kernel/bpf/devmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index a0a1153da5ae..e34fac6022eb 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -128,7 +128,7 @@ static int dev_map_init_map(struct bpf_dtab *dtab, un=
ion bpf_attr *attr)
> =20
>  		if (!dtab->n_buckets) /* Overflow check */
>  			return -EINVAL;
> -		cost +=3D sizeof(struct hlist_head) * dtab->n_buckets;
> +		cost +=3D (u64) sizeof(struct hlist_head) * dtab->n_buckets;

array_size()?

>  	}
> =20
>  	/* if map size is larger than memlock limit, reject it */

