Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6148764C778
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLNKz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiLNKzZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90168E64
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671015276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lATICyjc4Te5qDzlf7xVSBXOIwfGudOTKNOg//tLkfs=;
        b=TltD0qG16ZF3UJyFnevuw4nly3LGELpk414CSqlSFGTJRE3Z2NG7qBR2L7JE22L5bRHmYo
        xLLw+5djyBKStH3Bx69/ehpvwh6BwbNxwC/wC8gExiHD2up8qCff5R9OrZv2SViGi2gdO2
        3Si72kEBD7z+Oqj1IHwG7StlFHqzw+A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-RLtbxcklMUWgVvAEtd7xxw-1; Wed, 14 Dec 2022 05:54:35 -0500
X-MC-Unique: RLtbxcklMUWgVvAEtd7xxw-1
Received: by mail-ed1-f71.google.com with SMTP id q10-20020a056402518a00b00472a255eef7so532167edd.15
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lATICyjc4Te5qDzlf7xVSBXOIwfGudOTKNOg//tLkfs=;
        b=yIW3PQdpFmos2738ugvqUntXM2VmR1JYsyB/iRFx6Jo2nr/HsAAVznyJs5hIAaSgtB
         1GovnxO/9Qr254EJFLyyrFSj0ip2ndw5p6HQwTQllKAfXr+EzfzFe5cccxderk9J4MIR
         HaSf9Wgs0h35suBZ8zvHqJ80HiCxAPBBdnCXEWefQEOnA9NOwV/ROEd4EWPGXYtoGh6K
         Jg7O1LmIOVdP/K5JDSe84OX6bhlyQvwyw4Aujz5atNIYyRb54x3z5XyZRq/cttsG20WF
         QfR0si5Hz5T3JloVbhF0q2MVgp/hIgMANvUj1985UdZ+AhzqWG4qedZoVxg/j/b6movC
         vqmg==
X-Gm-Message-State: ANoB5pmz/iMV6x6eZIlEceMQe4/YYphOX8UGIqyMITcziUyimJdJOHOt
        +D0xMOvilVusPlLYdmBEicGIPteD603aU9WiM7KuqNHRN2tMHlF1B9pu9X4k21/omYjWYK13p6T
        08rLo+lLqqo8Q
X-Received: by 2002:a17:906:714e:b0:7c1:23f2:c052 with SMTP id z14-20020a170906714e00b007c123f2c052mr18515800ejj.45.1671015274514;
        Wed, 14 Dec 2022 02:54:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aktP68eWjNGtYhMxkwuKx1/hjsdVsA515iq6ye8JxvoV9dLdzUmgRMuzJKw7+BuWsbeOGhw==
X-Received: by 2002:a17:906:714e:b0:7c1:23f2:c052 with SMTP id z14-20020a170906714e00b007c123f2c052mr18515778ejj.45.1671015274127;
        Wed, 14 Dec 2022 02:54:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007c16fdc93ddsm3795670ejh.81.2022.12.14.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 02:54:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE15482F543; Wed, 14 Dec 2022 11:54:32 +0100 (CET)
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
Subject: Re: [xdp-hints] [PATCH bpf-next v4 05/15] bpf: XDP metadata RX kfuncs
In-Reply-To: <20221213023605.737383-6-sdf@google.com>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-6-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Dec 2022 11:54:32 +0100
Message-ID: <877cyugsrb.fsf@toke.dk>
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

[..]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index d434a994ee04..c3e501e3e39c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2097,6 +2097,13 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>  	if (fp->kprobe_override)
>  		return false;
>  
> +	/* When tail-calling from a non-dev-bound program to a dev-bound one,
> +	 * XDP metadata helpers should be disabled. Until it's implemented,
> +	 * prohibit adding dev-bound programs to tail-call maps.
> +	 */
> +	if (bpf_prog_is_dev_bound(fp->aux))
> +		return false;
> +

nit: the comment is slightly inaccurate as the program running in a
devmap/cpumap has nothing to do with tail calls. maybe replace it with:

"XDP programs inserted into maps are not guaranteed to run on a
particular netdev (and can run outside driver context entirely in the
case of devmap and cpumap). Until device checks are implemented,
prohibit adding dev-bound programs to program maps."

Also, there needs to be a check in bpf_prog_test_run_xdp() to reject
dev-bound programs there as well...

-Toke

