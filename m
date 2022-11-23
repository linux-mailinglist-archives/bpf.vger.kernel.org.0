Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D96361C5
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiKWO3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiKWO3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564E7C45E
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669213614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ci/dFCNljVcFf9q9RRytIXDpm4lKFdZkNw15CAnsDvQ=;
        b=YH6bmdOEsxNUPF7BO7FaUu83KPDFMv2JOKGuaD2U/VJ1+sD9VXa5HcYGz7pswIVUyNigI+
        SOHmlSSmcQeoLwwA5zRVofzxRV35v++a3drTtX7Yzll+59nFKO4bXJ+ecmWw4jLsbL+gck
        z8qlSUUJPZcsMjva1BorzY28JS07bhY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-JtZrz3E5NGejxdJD8sCIqg-1; Wed, 23 Nov 2022 09:26:53 -0500
X-MC-Unique: JtZrz3E5NGejxdJD8sCIqg-1
Received: by mail-ed1-f70.google.com with SMTP id t4-20020a056402524400b004620845ba7bso10451716edd.4
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci/dFCNljVcFf9q9RRytIXDpm4lKFdZkNw15CAnsDvQ=;
        b=pZBDGMmCo+c19rD04vDEMEDSI5E5iX8pXouaOcDg0adaoE343AiCpJGWBYW4dnB5Zu
         nenplurwckzX1zBiWl1EVtQdd4LZ3DpSxLU/8ichp6hzfAzJp87f+pVrdYJuiwSTyT7m
         kFWDCxxRmvxvW9+qF35DPp2L0UhbmzOjv0oRAkhKFG/JCa33u6QW31RnaqQnUJ8QTRAN
         igEJNoqT+k2KTyRkftIxCCXfDQ4/KpcGjt0j4yaBA8opsyMuT0+FCdRiGcXmtwqB8EQX
         S9Lt34vVcxqlHOgt9aZ+OiuKPlpQQoLAt3i4oE1bgGtvnL1y2AFIbH9czMcJX0dKbeyv
         LzFg==
X-Gm-Message-State: ANoB5pnv1gKfeA0Gz0X1F0O+fY9hbu8Z80qgCdK7PdZNN3Ad0z7zwyde
        4hJTSB8D4vaZduElgzfKNEUYBe4mpkfEM2Hs001czqk785oI8WFRtaUBOpy9TmX7+7FF+D80W/M
        Rb0qdOWfHNicg
X-Received: by 2002:a17:906:81c4:b0:78d:9858:e538 with SMTP id e4-20020a17090681c400b0078d9858e538mr24440808ejx.502.1669213611721;
        Wed, 23 Nov 2022 06:26:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KqxmrmIDbHgSTSQNejPu/z2+DPqzYorDZmwBIJ8vMgCMYGubMeimvSckzbonP+MTiW7z8xA==
X-Received: by 2002:a17:906:81c4:b0:78d:9858:e538 with SMTP id e4-20020a17090681c400b0078d9858e538mr24440776ejx.502.1669213611315;
        Wed, 23 Nov 2022 06:26:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kw1-20020a170907770100b0078246b1360fsm7283131ejc.131.2022.11.23.06.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:26:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 274AF7D5116; Wed, 23 Nov 2022 15:26:50 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] [PATCH bpf-next v2 8/8] selftests/bpf: Simple
 program to dump XDP RX metadata
In-Reply-To: <20221121182552.2152891-9-sdf@google.com>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-9-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Nov 2022 15:26:50 +0100
Message-ID: <877czlvj9x.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> +static int rxq_num(const char *ifname)
> +{
> +	struct ethtool_channels ch = {
> +		.cmd = ETHTOOL_GCHANNELS,
> +	};
> +
> +	struct ifreq ifr = {
> +		.ifr_data = (void *)&ch,
> +	};
> +	strcpy(ifr.ifr_name, ifname);
> +	int fd, ret;
> +
> +	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (fd < 0)
> +		error(-1, errno, "socket");
> +
> +	ret = ioctl(fd, SIOCETHTOOL, &ifr);
> +	if (ret < 0)
> +		error(-1, errno, "socket");
> +
> +	close(fd);
> +
> +	return ch.rx_count;
> +}

mlx5 uses 'combined' channels, so this returns 0. Changing it to just:

return ch.rx_count ?: ch.combined_count; 

works though :)

-Toke

