Return-Path: <bpf+bounces-1100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEE70E114
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6277E1C20D46
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB1200BB;
	Tue, 23 May 2023 15:55:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7749200A4
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 15:55:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B8C2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684857312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GVEg0KFzvyjXwlM9T+s+gIpxPD4m4VGc45BooCS2xmU=;
	b=GeWL0fCwdIqkVdD6H4YXOa0JgEcNzG7ISonbDwtWMA74VPPTF7/iYU0kFW67wqlj93wypi
	YnBIDWop0MPCnW7bdE3SXyJNMwp9oga5PR5pFDAExnTOjI6sxO43rWCnj/Vey27dV+lcBb
	7NcrJ6iwt1m6Oeqx27LGsEPyjWmfP/Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-OA27aA2oOkC67uMJqKredQ-1; Tue, 23 May 2023 11:55:10 -0400
X-MC-Unique: OA27aA2oOkC67uMJqKredQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96faa650a3fso404518166b.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 08:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857309; x=1687449309;
        h=content-transfer-encoding:subject:to:content-language:cc:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVEg0KFzvyjXwlM9T+s+gIpxPD4m4VGc45BooCS2xmU=;
        b=H9TAl23YCtEiKrLWzwgPlCj+ntpqadeqwn31Juy4cSBhPxWNWqGx1LEUqQg+9/U2UD
         Zm+XdUWVjV8ZZECK8rQwVu2u7TR5jCWe8Tz7Ba7OMlOZQ1oLNVT/SqGiRcUmo2m3RPuI
         OZxothRfnfZitAIyN4xr+C+aZc7zH/JgQ6n7tiSYwzotAE0JVoAJGEtQUfY76Xh1Spv2
         +YiUDz87IBr0mxQbTbztNHPjtaCD/aKjDMJJuQF03fOTrSIMGZPAkI2BXpUzXikHILUH
         fJWAsRYe3v5pVlcFHuHQ8dbmkYL86XnOOolDOyXMCkbLKacLKXEf0gq/H+GYBrJLLmtq
         O8mQ==
X-Gm-Message-State: AC+VfDypIDQqdluOE9nmVt7Xt90P3s4wJ4XVHByJTmJ/ug6qYCL9+IWC
	NXmUoxfrLqXk9S8ixopoilDvdx4NtcdrWQ4zfwQYTrQmScVfSrnrK0460i+oyK5TxuPQDJXUFnI
	UPqJFcgm5eq4O
X-Received: by 2002:a17:907:1c8b:b0:965:9602:1f07 with SMTP id nb11-20020a1709071c8b00b0096596021f07mr18039331ejc.39.1684857309704;
        Tue, 23 May 2023 08:55:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GdvO+T38t21WDxA1zApx3AtfM7mN1U2Kgj7kp8BFfKb+ewGuA0moLwxJXLRzOO94SYM3MsQ==
X-Received: by 2002:a17:907:1c8b:b0:965:9602:1f07 with SMTP id nb11-20020a1709071c8b00b0096596021f07mr18039304ejc.39.1684857309436;
        Tue, 23 May 2023 08:55:09 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b00965d4b2bd4csm4632196ejq.141.2023.05.23.08.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:55:08 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
Date: Tue, 23 May 2023 17:55:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, atzin@redhat.com, mkabat@redhat.com, kheib@redhat.com,
 Jiri Benc <jbenc@redhat.com>, bpf <bpf@vger.kernel.org>,
 Felix Maurer <fmaurer@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maxim Mikityanskiy <maxtram95@gmail.com>
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>, Netdev <netdev@vger.kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>
Subject: mlx5 XDP redirect leaking memory on kernel 6.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


When the mlx5 driver runs an XDP program doing XDP_REDIRECT, then memory
is getting leaked. Other XDP actions, like XDP_DROP, XDP_PASS and XDP_TX
works correctly. I tested both redirecting back out same mlx5 device and
cpumap redirect (with XDP_PASS), which both cause leaking.

After removing the XDP prog, which also cause the page_pool to be
released by mlx5, then the leaks are visible via the page_pool periodic
inflight reports. I have this bpftrace[1] tool that I also use to detect
the problem faster (not waiting 60 sec for a report).

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/page_pool_track_shutdown01.bt

I've been debugging and reading through the code for a couple of days,
but I've not found the root-cause, yet. I would appreciate new ideas
where to look and fresh eyes on the issue.

To Lin, it looks like mlx5 uses PP_FLAG_PAGE_FRAG, and my current
suspicion is that mlx5 driver doesn't fully release the bias count (hint
see MLX5E_PAGECNT_BIAS_MAX).

--Jesper


Extra info about my device.  Providing these as mlx5 driver can have 
different allocation modes depending on HW and device priv-flags setup.

$ ethtool --show-priv-flags mlx5p1
Private flags for mlx5p1:
rx_cqe_moder       : on
tx_cqe_moder       : off
rx_cqe_compress    : off
rx_striding_rq     : on
rx_no_csum_complete: off
xdp_tx_mpwqe       : on
skb_tx_mpwqe       : on
tx_port_ts         : off

$ ethtool -i mlx5p1
driver: mlx5_core
version: 6.4.0-rc2-net-next-vm-lock-dbg+
firmware-version: 16.23.1020 (MT_0000000009)
expansion-rom-version:
bus-info: 0000:03:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

$ lspci -v | grep 03:00.0
03:00.0 Ethernet controller: Mellanox Technologies MT28800 Family 
[ConnectX-5 Ex]


