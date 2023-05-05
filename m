Return-Path: <bpf+bounces-161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064A6F8C2E
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 00:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AD41C219EF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD59101DF;
	Fri,  5 May 2023 22:03:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288AC8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 22:03:16 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FAA6A48
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 15:02:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so22692497b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683324148; x=1685916148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BT6eRZ8cGv64ZHaYMBcmQbx432Ve6ko0TAcNeoNAcQ=;
        b=rFzXi+vArFSQtuLbnctsaALE5LBceVLJz5yqgQ9/35KAgz0ENGAxTl206mjDbFk7zK
         qA2tAYr5aqCfk8SChwXeHe53SoDP/RJ+0mGTNpLGIXPiDAZAcPXvswqic7HADbQau2ja
         lqQCMlOoqqZT2FpI2bUQkoNu/bAcE8irhW/VJn86W3cwtdSHF650foiW3O/tCrtqQCd8
         8714Q1boJ+bBzMlC/KB+36kml3c6aTQ1Jj5cElzeIDbHt2zVBY+KihUhk0MeqVWX9n2H
         Kssyl2DkR+EIaQiUZyblp986xU+loVWTuUFZ9/dSQYkMp06x55NxpzSA9v6WEa3Ma7Xd
         rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324148; x=1685916148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BT6eRZ8cGv64ZHaYMBcmQbx432Ve6ko0TAcNeoNAcQ=;
        b=BSMq3Z+90z1/BqrvBgD3iR08H8vM21cIo/usMn5ofNqrUqNMTlpRoEM20Qld910cwu
         ziaAw4ZBJljEUYO6ehsq07ceJCtVOOSZPDVFH1UBfmqIvHZ+iyDoL42qxAq/hvW1RUYU
         ueelA+cwqcktn/LoUCndU46CIWgkqFNpayYKTaMzmMwGVeLyfNKxoEW3253OQxByobnO
         wC/SrIAIQ+zxYRLIYnH41D+dlIPGyUF2OtDjkSDlvTmPlDFM3jRWv4MALnqTOblm5sAb
         nBW9mdEFHn7LlB0xiC1rvQC+8vm4KV2Xe+d0/QLBlHTAm2KqbrxMpAUXRJb+ZcHeAvK3
         qu7w==
X-Gm-Message-State: AC+VfDwXu8SNwzq4XzLRgjNgR+z1iZ/xhJ5KKZ0L5thbXnT01Xkhoi7B
	/JhP6fbIxEFjrVP+hntzuxyTQU5WtgGz2aGcu598hw==
X-Google-Smtp-Source: ACHHUZ6wzWsZNGTxZA5dMBJKD0TG1ynW0Toz3LT5GWD/qTgFR0dX6lVC5Ps5jQrtBN+hkvjBjtzVtAbV6NmcL9V24fQ=
X-Received: by 2002:a17:90a:c090:b0:24d:e296:659b with SMTP id
 o16-20020a17090ac09000b0024de296659bmr3504006pjs.22.1683324148122; Fri, 05
 May 2023 15:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505215836.491485-1-kuba@kernel.org>
In-Reply-To: <20230505215836.491485-1-kuba@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 5 May 2023 15:02:16 -0700
Message-ID: <CAKH8qBvmk6bEoasBKvD_AECvtjUJX2JUJiApmo8RMc1GHadG=g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: netdev: init the offload table earlier
To: Jakub Kicinski <kuba@kernel.org>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 2:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Some netdevices may get unregistered before late_initcall(),
> we have to move the hashtable init earlier.
>
> Fixes: f1fc43d03946 ("bpf: Move offload initialization into late_initcall=
")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217399
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

Make sense, thank you!

> ---
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: song@kernel.org
> CC: yhs@fb.com
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sdf@google.com
> CC: haoluo@google.com
> CC: jolsa@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  kernel/bpf/offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index d9c9f45e3529..8a26cd8814c1 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -859,4 +859,4 @@ static int __init bpf_offload_init(void)
>         return rhashtable_init(&offdevs, &offdevs_params);
>  }
>
> -late_initcall(bpf_offload_init);
> +core_initcall(bpf_offload_init);
> --
> 2.40.1
>

