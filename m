Return-Path: <bpf+bounces-6076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B027654F7
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E2E1C2164C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E06171C8;
	Thu, 27 Jul 2023 13:28:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063E1642E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:28:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2422726
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690464520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRXsOUJMOHDEoSqPt6aYSJsJvljvQhH7ysfJpGE7U3I=;
	b=dVtSPfZu4hCdyrmsloo672P6TgRiy5QF6qZWggZiH7SHyPtGesB+oekJTHCYqQr4e3YT4W
	zQq6Be1lUH8UAAXpCS5iRT+9ULOrsq9EWinozbpFB45RCUzfRvCH+Xes6pbcKbj1FZo8Xx
	8K+gD8tKxWhfDj90u2o1uDdaRL9m0J0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-vDIULUAuOKWPa7nCDXHMmw-1; Thu, 27 Jul 2023 09:28:38 -0400
X-MC-Unique: vDIULUAuOKWPa7nCDXHMmw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767c4cc8d84so21627985a.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464517; x=1691069317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRXsOUJMOHDEoSqPt6aYSJsJvljvQhH7ysfJpGE7U3I=;
        b=gUYhv2q/Bn6i8tLOTiEzOWjPDUyJNhkUYK9bwNNIp5cY40S/STWTbHhh+2dqBC0CY7
         aYqharCfP6/geLYlLeWdwNvCaY9+g4A8u34FFpH4e5SUmrTqd+kxTa1h700xA4rN66RA
         cLkgQSqbK/xwgawdm0UonJ7Sub2E0fiWWCoBlW/HRdK6cPJUd38olzy9ZoZTcJ17dWzG
         tWm/hESn0BSHSYEqRRpYLsSyhIuBnuIqi+qxNhvXr4HRC3/ALl3mIkNyKKw2jsNhZMCk
         PwFN1LneS/OYUN2+SeuW+heNlVF4wPDKfnWgHIho7s5ilvLpXFnPqQ/VlHJUCMAgsRXQ
         sF3g==
X-Gm-Message-State: ABy/qLabLe7rSWiwHTUdex+Wo20v3dogGpzObXmcgAkurSpYgjd7dsLy
	G1tklxCNPIaH8TDvxZcOuMbJzD4IZiUiPI2Xf7hBUNrOYIKF0TrwC9nKFdLA5y+jOkVw4XULU6A
	5knAgkKI73JeU
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5530691qkb.3.1690464517506;
        Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSS1sj3ooFLxDH7GaJepQJ5naZSQaFVoxc5DBSu1lp42qGgOiczSwad8h1rf/0DMO/8MK1BQ==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5530665qkb.3.1690464517246;
        Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a126400b00767dafbf282sm411683qkl.12.2023.07.27.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:28:36 -0700 (PDT)
Message-ID: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
From: Paolo Abeni <pabeni@redhat.com>
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
Date: Thu, 27 Jul 2023 15:28:32 +0200
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
	 <20230725130709.58207-3-gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> Add interrupt_coalesce config in send_queue and receive_queue to cache us=
er
> config.
>=20
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
>=20
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
>=20
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

FTR, this patch is significantly different from the version previously
acked/reviewed, I'm unsure if all the reviewers are ok with the new
one.

[...]

>  static int virtnet_set_coalesce(struct net_device *dev,
>  				struct ethtool_coalesce *ec,
>  				struct kernel_ethtool_coalesce *kernel_coal,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi =3D netdev_priv(dev);
> -	int ret, i, napi_weight;
> +	int ret, queue_number, napi_weight;
>  	bool update_napi =3D false;
> =20
>  	/* Can't change NAPI weight if the link is up */
>  	napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> -			update_napi =3D true;
> +	for (queue_number =3D 0; queue_number < vi->max_queue_pairs; queue_numb=
er++) {
> +		ret =3D virtnet_should_update_vq_weight(dev->flags, napi_weight,
> +						      vi->sq[queue_number].napi.weight,
> +						      &update_napi);
> +		if (ret)
> +			return ret;
> +
> +		if (update_napi) {
> +			/* All queues that belong to [queue_number, queue_count] will be
> +			 * updated for the sake of simplicity, which might not be necessary

It looks like the comment above still refers to the old code. Should
be:
	[queue_number, vi->max_queue_pairs]
		=09
Otherwise LGTM, thanks!

Paolo


