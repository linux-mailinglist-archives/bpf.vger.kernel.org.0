Return-Path: <bpf+bounces-985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786270A36A
	for <lists+bpf@lfdr.de>; Sat, 20 May 2023 01:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8700281AE5
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97236FA1;
	Fri, 19 May 2023 23:37:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C884568D
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 23:37:57 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B146EA;
	Fri, 19 May 2023 16:37:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53202149ae2so2632002a12.3;
        Fri, 19 May 2023 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684539475; x=1687131475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTSgTvbcd9Uv0YqNm3TopjpN1/V/dzNRUy9h9I2dqAs=;
        b=pUqAr6S8oHzGpF07TWZ48KQ7idSEEq2fB4EOOi638V6mtxDW/DRejoGfETv1qEvU+U
         UfQbjDAQwMRWzTG7l1pNAYaEcYqaaxQwIJwFogMCXIh97ymfTH7zzmW+qXOGmxo2zNoQ
         F9Ue6k7NSXhJwdPZ0rf9RIfe1caEC7gpAREFtclNuaczXUre9Vy31IZa/yBaMJZiFaB2
         c8kdcjqzKuMX01aA3Qt7PTzmMyi+ry/wsVwyOZc2VZ1CBbxpyu9VBoQ5bplDUPEkM0n2
         pzsB4CbvgXkIzNDEsrrXztqw7kJ08CwtauFNIBCFU4I4N4l+oe4QeRVss8FOqfJEjIeF
         uBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684539475; x=1687131475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTSgTvbcd9Uv0YqNm3TopjpN1/V/dzNRUy9h9I2dqAs=;
        b=Z27WpMlLKqRCKQt91BttQrU5LQ2PVryOJYxVHk4OmzW8hWZHss292Bq5Aib//nFNNr
         Vn9x+qcn5xOpPemusuzt/wLVf+QxSUZlZTz93ZLLhDeShsUE3haR++vDHkZ9YRK9wJCT
         9fZhiOvAOpI0dcx7mp+MBQlD7iZn6/6ZLehiLJSHjdsEh4kY9BkdfLE7bnoLo2whZzvv
         fqbzgXwZv3rIa6NpeP847YFMFoNTmXFl4JLgMXTVwgbWKfoisu4OTBnQ+fIIUHUn/RBw
         u42bpN4ZiahdUjBWTcKTH8wDmligX0rSUkPCz5txwEOrsZBMpuNTYxooVp9Oy/8PQrBM
         wkeA==
X-Gm-Message-State: AC+VfDyhM8dF5JmoQ3MyTz1Zl98egE7Tl0VSZiuWf446ToFne8Vf2LpL
	dqeNAh3XBxZqieH2RY2P9z9KRspjZrNowE9qm16nyn4Qt2jDDw==
X-Google-Smtp-Source: ACHHUZ5sVSxoI8yS4ei1lKiZQs4g2JBMGZQBQQOVlSEZN/nH1tT7oqLfj+RPt0EB02J+LkUG/rAvUmkC+elRuHvPn64=
X-Received: by 2002:a17:903:26cb:b0:1ae:7421:82b5 with SMTP id
 jg11-20020a17090326cb00b001ae742182b5mr4243200plb.45.1684539474593; Fri, 19
 May 2023 16:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
 <073cf884-e191-e323-1445-b79c86759557@linux.dev>
In-Reply-To: <073cf884-e191-e323-1445-b79c86759557@linux.dev>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Sat, 20 May 2023 07:37:43 +0800
Message-ID: <CAABZP2yjONcZNVKT88JXq_QyVzuDnu12nD8APT0XJ45dOtSFrQ@mail.gmail.com>
Subject: Re: a small question about bpftool struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for responding so quickly ;-)

On Sat, May 20, 2023 at 3:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> > Dear developers:
> > I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> > but when I invoke:
> > bpftool struct_ops register bpf_cubic.bpf.o
> >
> > the command line fail with:
> > libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> > found in struct bpf_struct_ops_tcp_congestion_ops
>
> At the machine trying to register the bpf_cubic, please dump the vmlinux =
btf and
> search for bpf_struct_ops_tcp_congestion_ops and paste it here:
>
> For example:
> #> bpftool btf dump file /sys/kernel/btf/vmlinux
>
> ...
>
> [74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
>          'refcnt' type_id=3D145 bits_offset=3D0
>          'state' type_id=3D74569 bits_offset=3D32
>          'data' type_id=3D6241 bits_offset=3D512
OK
[214398] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
        'refcnt' type_id=3D298 bits_offset=3D0
        'state' type_id=3D214224 bits_offset=3D32
        'data' type_id=3D213704 bits_offset=3D512

Please tell me if I could provide any further information.

You are of great help

Thank you very much
Zhouyi
>

