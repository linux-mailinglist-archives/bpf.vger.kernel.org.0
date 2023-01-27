Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B867E7AD
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 15:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjA0OBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 09:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjA0OBL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 09:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5384B68
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674827915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdjTBVez/3ftvZX6/OLdL9ZR1SQ75cgVUwtb7qk4ZfM=;
        b=F/BUpcCE+J+21bQJzTZxDnc03ZNqLbgbddjTCYb9DxKWTG0tMiahTK+he+UUU9ONuCkqXG
        ZqHYgHGQfSozFgaNSIScby+j3AoVdE8VPsIoAaa2pNtZh8OsgpwfMsMlqwI+/3XOcSJKzc
        kUc1M+omm6hTkYKmhC408BAQeXUKDBQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-ocOmp0c6O66pQk5FRwWvig-1; Fri, 27 Jan 2023 08:58:34 -0500
X-MC-Unique: ocOmp0c6O66pQk5FRwWvig-1
Received: by mail-ej1-f72.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so3468873ejc.0
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 05:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdjTBVez/3ftvZX6/OLdL9ZR1SQ75cgVUwtb7qk4ZfM=;
        b=vobPuhQlK7AL9oeaV1Z6DtNkkrpW6IRMUKZeD63+7AioycDTem/fM0arjh98DnFg6k
         Iqr0QkSNISpd8vVUM3CheC3q5Gpr97cJtEtioid5GcAnBB+Lr0s1rK2S5oIqEhGDZdLu
         AfdlTywe3IRBiChAvvy/mwRumGoi2GvwMgXCjh0BMlaVvOqK9crnrOuDhQjaL48/9SVj
         1XlWMXRpqK6mBzIasP5flgtPngpUdShNswl6SHsIQWuL9PqEGdRRlt1t4JztSVmn5rYC
         vA4j/VaCmnPn//dtIavvDyyOi3DamK24CrIFmALGb+NvhTgvuqdI1ALSJPw/6yRsmXYt
         eOdA==
X-Gm-Message-State: AO0yUKX2KYz/7fYFdSbxh8Vq50oJ3uxkdbAs1BM2Kf9LsgMA0WF+R0nL
        1d5OBHHr1TOjMLX3j6VAlIMNnFgfRMPM+rEN4IkTUIO+EmfKFj9IZoYP5EygIjOmEI69jR5gkXb
        7bQtfGk17kXsv
X-Received: by 2002:a17:906:6c87:b0:87b:59d9:5a03 with SMTP id s7-20020a1709066c8700b0087b59d95a03mr2515387ejr.36.1674827911095;
        Fri, 27 Jan 2023 05:58:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+3UBn4OcKy5pYLNxZ0qgtJJk59jcWp2z39qXFHB5Q8CawryZtKG7DrALckbaIQUtmNvCCSKg==
X-Received: by 2002:a17:906:6c87:b0:87b:59d9:5a03 with SMTP id s7-20020a1709066c8700b0087b59d95a03mr2515303ejr.36.1674827909461;
        Fri, 27 Jan 2023 05:58:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906d20a00b008448d273670sm2255205ejz.49.2023.01.27.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:58:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2266C943260; Fri, 27 Jan 2023 14:58:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, dsahern@gmail.com,
        willemb@google.com, void@manifault.com, kuba@kernel.org,
        xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [PATCH bpf-next RFC V1] selftests/bpf:
 xdp_hw_metadata clear metadata when -EOPNOTSUPP
In-Reply-To: <167482734243.892262.18210955230092032606.stgit@firesoul>
References: <167482734243.892262.18210955230092032606.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Jan 2023 14:58:28 +0100
Message-ID: <87cz70krjv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> The AF_XDP userspace part of xdp_hw_metadata see non-zero as a signal of
> the availability of rx_timestamp and rx_hash in data_meta area. The
> kernel-side BPF-prog code doesn't initialize these members when kernel
> returns an error e.g. -EOPNOTSUPP.  This memory area is not guaranteed to
> be zeroed, and can contain garbage/previous values, which will be read
> and interpreted by AF_XDP userspace side.
>
> Tested this on different drivers. The experiences are that for most
> packets they will have zeroed this data_meta area, but occasionally it
> will contain garbage data.
>
> Example of failure tested on ixgbe:
>  poll: 1 (0)
>  xsk_ring_cons__peek: 1
>  0x18ec788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>  rx_hash: 3697961069
>  rx_timestamp:  9024981991734834796 (sec:9024981991.7348)
>  0x18ec788: complete idx=8 addr=8000
>
> Converting to date:
>  date -d @9024981991
>  2255-12-28T20:26:31 CET
>
> I choose a simple fix in this patch. When kfunc fails or isn't supported
> assign zero to the corresponding struct meta value.
>
> It's up to the individual BPF-programmer to do something smarter e.g.
> that fits their use-case, like getting a software timestamp and marking
> a flag that gives the type of timestamp.
>
> Another possibility is for the behavior of kfunc's
> bpf_xdp_metadata_rx_timestamp and bpf_xdp_metadata_rx_hash to require
> clearing return value pointer.

I definitely think we should leave it up to the BPF programmer to react
to failures; that's what the return code is there for, after all :)

-Toke

