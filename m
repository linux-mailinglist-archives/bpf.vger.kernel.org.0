Return-Path: <bpf+bounces-6660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104976C2EA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921E61C2110D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66625A4C;
	Wed,  2 Aug 2023 02:31:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9BA3D;
	Wed,  2 Aug 2023 02:31:42 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA57268E;
	Tue,  1 Aug 2023 19:31:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so98031131fa.1;
        Tue, 01 Aug 2023 19:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943496; x=1691548296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nPrNWJYp/hZC50AjIDfXvrmS+jJWo/qj9DfjouCvto=;
        b=DcqTGt0+bM/wOpGYyL0LfJWVO7zByOhtPBU9GjiRvOxtKEuKGNc+wCr+J6QYPz+WHj
         khpSCMMsznxEin0YTJhCyUgzAmmBrpTPudJLTkya5hsnYvHAJ28vYHO1Moogous/4Rz/
         dsKN8b8CBMkH57jAL1Yww11DJnqdnKmJLz68/waHaX7Gh6b/efYnmWz04+5halCVYQ1p
         Rgnu7U5LUM15Q18NY5iX0HXEK5pbpXdv2Q0PszYUSnuIMeIwif11hQItH7WHOp78xQ4P
         Qundke0KXsrc8ETRmx0635Rhjjr/cFBGZ1eJ4naK3c54e2RbVyTg6z57MrElPRWtKJTb
         RyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943496; x=1691548296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nPrNWJYp/hZC50AjIDfXvrmS+jJWo/qj9DfjouCvto=;
        b=RDj+4LpuX2d7XRnm7U6kSO6w7Zag9Ljmx73HQ+ZxI6xcl2zkrZiAgKR+7AHvKNFK5i
         W4gJWnxN+nVcuqgTIwbWFyhStZfJH/adZcvgY4l90YFb8V31zZDwTzTzQhr4Ku+IOgyS
         u1zfnaEjwa6MjeRTIpbTo2ywpjOE3xIl5FMX9kF//G5/PGZeYjYKeyBuIoclGGiHBHCE
         d5aR7ZqLp+BmDBVEjH9I66awIJD6Emb1lKWZTnT+/YJgUYdTfY8Gqp7Lh41pHEKLvEWq
         uiQ9ucR6Fi9LuB22rVoJo3SrYv6Gp+D2jIvvvbUoDYurnpRrI4s2yfWyA+B9XpuxwDB8
         3R4A==
X-Gm-Message-State: ABy/qLYvxZ35+qbomqQhavrGZGOooUEauCOZ1AZvkDAIO0r9Ymw7mpjU
	kshC8ep5gE9bMVufMy7F0lXEsOb7sZsIukJA+bP5ny0U9c0=
X-Google-Smtp-Source: APBJJlE6eC60APY4i5EuLEnNQUT4CaveFeMQJg7KQCgq1ZNKQgj/PBZKjwYZhfT/hJHtU9SYbpeGkZJ+ZX6lYy2shl0=
X-Received: by 2002:a2e:8256:0:b0:2b6:df5d:8e05 with SMTP id
 j22-20020a2e8256000000b002b6df5d8e05mr3764056ljh.33.1690943496288; Tue, 01
 Aug 2023 19:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802003246.2153774-1-kuba@kernel.org>
In-Reply-To: <20230802003246.2153774-1-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:31:25 -0700
Message-ID: <CAADnVQJdA25VBE+7Erw7-beL4+=fy1KtRA3ojN0o1yUztnyjjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] net: struct netdev_rx_queue and xdp.h reshuffling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 5:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> While poking at struct netdev_rx_queue I got annoyed by
> the huge rebuild times. I split it out from netdevice.h
> and then realized that it was the main reason we included
> xdp.h in there. So I removed that dependency as well.
>
> This gives us very pleasant build times for both xdp.h
> and struct netdev_rx_queue changes.
>
> I'm sending this for bpf-next because I think it'd be easiest
> if it goes in there, and then bpf-next gets flushed soon after?
> I can also make a branch on merge-base for net-next and bpf-next..

Sounds like a plan to me.
Especially considering that targeting bpf-next will exercise BPF CI...
and it's not happy at the moment:
../net/netfilter/nf_conntrack_bpf.c: In function =E2=80=98bpf_xdp_ct_alloc=
=E2=80=99:
../net/netfilter/nf_conntrack_bpf.c:258:44: error: dereferencing
pointer to incomplete type =E2=80=98struct xdp_buff=E2=80=99
258 | nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev),
bpf_tuple, tuple__sz,
|

