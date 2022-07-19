Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F95793A4
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 08:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGSG6K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiGSG6J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 02:58:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AEA275D8
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 23:58:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so25350675ejb.1
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pgMrFU+qEImV5jvhZKnhdxLHcWLuqCE+OAyoxG4pme8=;
        b=YbZYcppP9dA+6qz+j3MJQDbvZEOZiAHmbp42CjpwSYXGU0EoCZK1EKmmjObzd4dSjM
         3oWn2wIO7QVDAh4ROsod6+UfAHnX/VoIOBSYqqHZTf5BuQAxPUFvugznLVe8G/Z6Qija
         0Xmz/nKzdYJrwiHV3zLQmEAH/FUXIIeJaUoldEWbpK4/E4FG57WSEBTW2/7OQA3ITao3
         iOyVh3Zn9Ei8YAKMbb2tE/+4NdLJNdUhjUXdWBbVnTsT9FbDPhMmRG04UQFVFDIdQAu7
         dUiMlwp873B5xUCNZQOMoEgYkaUqgK6OJI5TSOwB9X00HdEwNVxPTTAJ9BEbZJ5Qz9VB
         l1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pgMrFU+qEImV5jvhZKnhdxLHcWLuqCE+OAyoxG4pme8=;
        b=XPZ7Z/9dZpFIf5nVhHaPYkenK4YUPpMwrMaaffSx00Wjkxq9QNSSVmsiz/omWzo6MA
         Ys7sxDVodtzOsEf9q3RxTdytr9WRBWWeL0EHOr/aWh+Li3DBENMmz89qF9lZqeSu5aY5
         xRVZlseadHURrODHbdUvX4rKlirjaX+qD5I33PnStMJ3v9CJ66BYrnFw0FwsKXi9Zjue
         ghGpyNZPGwUSK9yI2zcLgGVjG/ri+eFJle+wGfzUzJd4KB/uDGQA218Aj3OQXQCnRbq0
         8JrTLnUc+15lxIm7O102ipZXCiIAmp9kaxwE18B5Azno4Mc3JACYU6XcPDxazQNxVFp7
         u3SQ==
X-Gm-Message-State: AJIora8XWCdHDSTvyMeDgPM69HxlfPu1dFkVB67CcnaQZyTRMjKCmQlE
        z9eq0383y14vP9S1Ar+dbR06vQ==
X-Google-Smtp-Source: AGRyM1sNzzERn6owpOTMShEzVYzNg/n5kCxLDXLcQTwEu1yNAn2Ba1efmwHv6gwPSuECam1564pBsw==
X-Received: by 2002:a17:907:a061:b0:72f:1dde:fac0 with SMTP id ia1-20020a170907a06100b0072f1ddefac0mr11956591ejc.310.1658213886393;
        Mon, 18 Jul 2022 23:58:06 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0072f441a04a6sm1348851eju.5.2022.07.18.23.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 23:58:05 -0700 (PDT)
Message-ID: <75d3ee98-a73c-16c5-2bb3-f61180115b29@blackwall.org>
Date:   Tue, 19 Jul 2022 09:58:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf v2 0/5] bpf: Allow any source IP in
 bpf_skb_set_tunnel_key
Content-Language: en-US
To:     Paul Chaignon <paul@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Yonghong Song <yhs@fb.com>
References: <cover.1658159533.git.paul@isovalent.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1658159533.git.paul@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 18/07/2022 18:53, Paul Chaignon wrote:
> Commit 26101f5ab6bd ("bpf: Add source ip in "struct bpf_tunnel_key"")
> added support for getting and setting the outer source IP of encapsulated
> packets via the bpf_skb_{get,set}_tunnel_key BPF helper. This change
> allows BPF programs to set any IP address as the source, including for
> example the IP address of a container running on the same host.
> 
> In that last case, however, the encapsulated packets are dropped when
> looking up the route because the source IP address isn't assigned to any
> interface on the host. To avoid this, we need to set the
> FLOWI_FLAG_ANYSRC flag.
> 
> Changes in v2:
>   - Removed changes to IPv6 code paths as they are unnecessary.
> 
> Paul Chaignon (5):
>   ip_tunnels: Add new flow flags field to ip_tunnel_key
>   vxlan: Use ip_tunnel_key flow flags in route lookups
>   geneve: Use ip_tunnel_key flow flags in route lookups
>   bpf: Set flow flag to allow any source IP in bpf_tunnel_key
>   selftests/bpf: Don't assign outer source IP to host
> 
>  drivers/net/geneve.c                                 |  1 +
>  drivers/net/vxlan/vxlan_core.c                       | 11 +++++++----
>  include/net/ip_tunnels.h                             |  1 +
>  net/core/filter.c                                    |  1 +
>  tools/testing/selftests/bpf/prog_tests/test_tunnel.c |  1 -
>  5 files changed, 10 insertions(+), 5 deletions(-)
> 

Looks good, for the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
