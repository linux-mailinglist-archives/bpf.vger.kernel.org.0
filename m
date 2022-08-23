Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C5859EF5C
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiHWWnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiHWWnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:43:51 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFAE876A6
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:43:50 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQccY-0008aV-0x; Wed, 24 Aug 2022 00:43:42 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oQccX-000SmY-Kg; Wed, 24 Aug 2022 00:43:41 +0200
Subject: Re: [PATCH bpf-next,v2] selftests/bpf: add lwt ip encap tests to
 test_progs
To:     Eyal Birger <eyal.birger@gmail.com>, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org
Cc:     bpf@vger.kernel.org
References: <20220822130820.1252010-1-eyal.birger@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3d69a390-f503-e3b8-78ab-b74f5d32e84d@iogearbox.net>
Date:   Wed, 24 Aug 2022 00:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220822130820.1252010-1-eyal.birger@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26636/Tue Aug 23 09:52:45 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/22/22 3:08 PM, Eyal Birger wrote:
> Port test_lwt_ip_encap.sh tests onto test_progs.
> 
> In addition, this commit adds "egress_md" tests which test a similar
> flow as egress tests only they use gre devices in collect_md mode
> for encapsulation and set the tunnel key using bpf_set_tunnel_key().
> 
> This introduces minor changes to test_lwt_ip_encap.{sh,c} for consistency
> with the new tests:
> 
> - GRE key must exist as bpf_set_tunnel_key() explicitly sets the
>    TUNNEL_KEY flag
> 
> - Source address for GRE traffic is set to IP*_5 instead of IP*_1 since
>    GRE traffic is sent via veth5 so its address is selected when using
>    bpf_set_tunnel_key()
> 
> Note: currently these programs use the legacy section name convention
> as iproute2 lwt configuration does not support providing function names.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
[...]

Thanks for following up. Is there now anything that test_lwt_ip_encap.c
doesn't cover over test_lwt_ip_encap.sh? If not, I'd vote for removing
the latter given the port is then covered in CI via test_progs.

> diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> index 6c69c42b1d60..a79f7840ceb1 100755
> --- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> @@ -238,7 +238,8 @@ setup()
>   	ip -netns ${NS3} -6 route add ${IPv6_6}/128 dev veth8 via ${IPv6_7}
>   
>   	# configure IPv4 GRE device in NS3, and a route to it via the "bottom" route
> -	ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_1} local ${IPv4_GRE} ttl 255
> +	ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_5} \
> +		local ${IPv4_GRE} ttl 255 key 0
>   	ip -netns ${NS3} link set gre_dev up
>   	ip -netns ${NS3} addr add ${IPv4_GRE} dev gre_dev
>   	ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6} ${VRF}
> @@ -246,7 +247,8 @@ setup()
>   
>   
>   	# configure IPv6 GRE device in NS3, and a route to it via the "bottom" route
> -	ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_1} local ${IPv6_GRE} ttl 255
> +	ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_5} \
> +		local ${IPv6_GRE} ttl 255 key 0
>   	ip -netns ${NS3} link set gre6_dev up
>   	ip -netns ${NS3} -6 addr add ${IPv6_GRE} nodad dev gre6_dev
>   	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
> 

