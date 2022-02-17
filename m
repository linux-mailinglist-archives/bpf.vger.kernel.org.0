Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E564BA09F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiBQNFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 08:05:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiBQNFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 08:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B7052A8D04
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645103127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpcZMkbbCh5BkbYlg/SvgeHM4i6/4F8GaJEcQ/x4VQg=;
        b=QJhKeNj53DIuPcDq148J6R0Ul1fYy0G2YMo6O88e6hZr0AChNACHJSvzxQI5rry1V+odjF
        HZCj/zT4gsJFUdZ2yBASqnXeVnY/Y0OsCrtdL5R9eW9JV66QbElOY0AA/NvgR0qJeSIs2g
        ebLBWCW9F3KYmXqWXJ8bBFh8Cn5LVH0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-dmr0Oh2RMsmvOL_LniK2Jg-1; Thu, 17 Feb 2022 08:05:26 -0500
X-MC-Unique: dmr0Oh2RMsmvOL_LniK2Jg-1
Received: by mail-ed1-f69.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so3478016edb.11
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 05:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HpcZMkbbCh5BkbYlg/SvgeHM4i6/4F8GaJEcQ/x4VQg=;
        b=dWK/dwqZXe8mGM9hQyBqkFzJXwOC066HG3xA1kDMlzISTNivDkQgqycvvyREhy0ZVz
         WAS4j8XPuyVaUmZcl6XSy2+0LFGypaGP5rBmcrI6uB/eSMAw5bjXhesVC2/BVLByJ2QH
         WAB6EzG8r3iezHSR2HtZGU42MK7Vl9e0ZAnKzrb8m+jWCzsf/6P7raTylA11m8zdnLoV
         yjj/6U9inePzjm2ifUX+nkYWIllrCZA6hTU4c/GW0sE9yu1SpzUaXIEnRSsjdAh1yfBQ
         l+tPm8n7qOWbqdMDE+IM69Lgdl6VGPdEHMgUFuQkpvZ+eb2ycPVqr3Sj4ptO6u6BrUs/
         5KJg==
X-Gm-Message-State: AOAM533zYmzzs6c1X0uWxBpVQGQL0XDJTQFmubleyDtCUnbe9kMEaIB4
        wMLq5fVNCgfdllpBleuSQbZkMppYNsagxfk2W8dB/iSw3oSxWoFbdvmqimrdmgHgYZczueTEDj7
        bFRiB6H4wjreC
X-Received: by 2002:a17:906:3e4b:b0:6cf:7f02:9332 with SMTP id t11-20020a1709063e4b00b006cf7f029332mr2227300eji.404.1645103124265;
        Thu, 17 Feb 2022 05:05:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXopXKD89QYgb1WeZKES3DFukCLCJ+EmNSOsHVbM5bzPDRA3viHVG1CUFOwjJ+d7W2tkDcHg==
X-Received: by 2002:a17:906:3e4b:b0:6cf:7f02:9332 with SMTP id t11-20020a1709063e4b00b006cf7f029332mr2227126eji.404.1645103121650;
        Thu, 17 Feb 2022 05:05:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l6sm1133351ejz.189.2022.02.17.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:05:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 451D612E801; Thu, 17 Feb 2022 14:05:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: fix memleak in libbpf_netlink_recv()
In-Reply-To: <20220217073958.276959-1-andrii@kernel.org>
References: <20220217073958.276959-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Feb 2022 14:05:20 +0100
Message-ID: <87czjl4p9r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Ensure that libbpf_netlink_recv() frees dynamically allocated buffer in
> all code paths.
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Fixes: 9c3de619e13e ("libbpf: Use dynamically allocated buffer when recei=
ving netlink messages")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Oops! I saw there were already 'goto done' labels in that block of code
so assumed it was all fine and didn't look closer. Thank you for the
fix!

-Toke


Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

