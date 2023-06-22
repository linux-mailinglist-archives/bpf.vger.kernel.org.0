Return-Path: <bpf+bounces-3123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15202739A4E
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14821C21111
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84963AA89;
	Thu, 22 Jun 2023 08:41:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB435246
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:41:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D026B6
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687423291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLDRU0DgVHLKMtSN0SL4+wqrKqeuyjYLggk0v3Jz8BA=;
	b=QEyQK+/4hlb9f9hh+6bDzGpwjKAovTvfnvE6W0D5GUn0GAocgC4sUcmKIAhyG7gEqPsXPZ
	HO9tq3v3j3SAMx/oy89bgKO++UZ2mFkF0PUr5GBEIYEHXiNkYXGvylt6uUyYV0Q7cx+zIo
	fF9qrW6+oZ4Uabb0O6bkgUlTnEURiNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-5MWTu8RDMqWvqXYz82IuQw-1; Thu, 22 Jun 2023 04:41:30 -0400
X-MC-Unique: 5MWTu8RDMqWvqXYz82IuQw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so10259631f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423289; x=1690015289;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLDRU0DgVHLKMtSN0SL4+wqrKqeuyjYLggk0v3Jz8BA=;
        b=eFtG3VDxJcmmHl7UsR0LAd53x8yMzGZWRRCIZUeJnVo1hlU735La4IvZkzGTbx+jnT
         lcJ+MuSboFQLDR14vBB42lDz/SfpzpTBpw+ku3zYPGa+L+uundGupKwXdD1C4UcpHjwR
         CqPsOU0DFVjHXmITUapd/WO4gAHvGEAdKImR7eqJ0cfX1hwu4RQMHL1sdDPSb3NiqVVS
         mYS26mt/H2H7NaDzE21GAco/HmFJlc+4/C1h/0LlONuFOvBaRasfZyBkr3MIpTLqRf++
         jPUmzMz2hbhiuXKnH2qGYiPe+X42+bjKVrQQH4D7u5yySvMdGvELXH7//gX2vQgnqILQ
         0FZg==
X-Gm-Message-State: AC+VfDxX87FNugD4+JIAmleAdYlPzuVyyU7ccgeghjU+CtWAJuso34sU
	CwkMSEjqqdNLeOpwpNHBRdelshFkS+8XjwKh7F+BUysS4rIu+ItktkTkhMEceHTsRv7HBaEcB91
	/y/R7GcoyyeLT
X-Received: by 2002:a5d:4811:0:b0:30f:c47f:27ad with SMTP id l17-20020a5d4811000000b0030fc47f27admr17093897wrq.28.1687423288961;
        Thu, 22 Jun 2023 01:41:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zAnPnp2VylPjRjt2iTmJZd7rhZ/iD44REfL4MTjkjtHKZxA7ykn6cbnmMw6JeQU5KL+GeBA==
X-Received: by 2002:a5d:4811:0:b0:30f:c47f:27ad with SMTP id l17-20020a5d4811000000b0030fc47f27admr17093884wrq.28.1687423288664;
        Thu, 22 Jun 2023 01:41:28 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d558f000000b0030647d1f34bsm6662063wrv.1.2023.06.22.01.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:41:27 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
Date: Thu, 22 Jun 2023 10:41:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: Re: [RFC bpf-next v2 00/11] bpf: Netdev TX metadata
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230621170244.1283336-1-sdf@google.com>
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 21/06/2023 19.02, Stanislav Fomichev wrote:
> CC'ing people only on the cover letter. Hopefully can find the rest via
> lore.

Could you please Cc me on all the patches, please.
(also please use hawk@kernel.org instead of my RH addr)

Also consider Cc'ing xdp-hints@xdp-project.net as we have end-users and
NIC engineers that can bring value to this conversation.

--Jesper


