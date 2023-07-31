Return-Path: <bpf+bounces-6398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB4768BE8
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB162814AA
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3A2117;
	Mon, 31 Jul 2023 06:24:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194FEDB
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 06:24:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB1E40
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690784650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
	b=hlMZvrHUZ0ceVW2AbwDnradUhsukm3myNM4W8cJ2dqvBxYyfGKbCQa3yhAN3UJuvWex7x5
	ashdEW5y8YslYnKywRSjBvUlsCbaFfYvQb+f8raeoTbxxrNugE+Avof1EuqprOHgW9tr0K
	OStdBJfUYAGGut6Gj9BzzLFkwbP4s1s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-8UU7mysAMpaGbrgJ4zUeNg-1; Mon, 31 Jul 2023 02:24:08 -0400
X-MC-Unique: 8UU7mysAMpaGbrgJ4zUeNg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bb8f751372so45443475ad.0
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784647; x=1691389447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
        b=FuKkB5ATavdV/XJ25Eyd0szJPvjYkf7T+SE9/M4JPgD8LvZceHw2dfZpGEXc9PX9fD
         EE1XEdT+dSPr61M7qpDEcvSqju2/Vz5HGWVPyhlJqyG+u13bzfKcVzEXxfZsvjKh4Snt
         xD5PO0Qfo901oN/kyOafTBiys5rFATX1Nx20P/HmJ81UiDPcS1Yc1qzsZ5lczKrNKgUG
         iHeWdhSyJ9P/wkIzOfnDGYbql6lJemGKEueJEz+bf941Km1sA0VM8DasZ+fL94QmOnan
         SvjuVEmrcZ8hABO3o63+zz1tbLW2kum8wW/48yHb+qrN2//x+rtejd4iD8wGT1a0h2xh
         7pcw==
X-Gm-Message-State: ABy/qLYE1RpVZ0yNmv+6gT+/xiK9yTXxvYblPKBWQCxRRv5WUehnfAx2
	tO1wMXnrUtQ9hZUbWXIDmTBZ97coLYCcSH0STwuWlYjLwYHWoeRv363dlMaknCu3EWrPMjzQdpI
	MYHhsh2k/RpUm
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837675plk.4.1690784647316;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7mH2Qi6DFfl6DwSxvSKUPeZPkzsuIKf9buf/HUaThSCbGhjgk9r38CsiEE+rud7IO8Nb3ow==
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837667plk.4.1690784647016;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b5247cac3dsm7590352plz.110.2023.07.30.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:06 -0700 (PDT)
Message-ID: <66cd33fd-5d92-915e-e7ac-9eb564936eab@redhat.com>
Date: Mon, 31 Jul 2023 14:24:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
Content-Language: en-US
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/25 21:07, Gavin Li 写道:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
>
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
>
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


