Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57203892B8
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 17:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhESPfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 May 2021 11:35:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:57508 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhESPfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 May 2021 11:35:21 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ljOCu-000Fir-Gc; Wed, 19 May 2021 17:34:00 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ljOCu-000I7U-CQ; Wed, 19 May 2021 17:34:00 +0200
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for l3 use of
 bpf_redirect_peer
To:     Jussi Maki <joamaki@gmail.com>, bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210518142356.1852779-1-joamaki@gmail.com>
 <20210518142356.1852779-3-joamaki@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2dc37982-9889-c2e8-9fb4-17ba26c28da9@iogearbox.net>
Date:   Wed, 19 May 2021 17:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210518142356.1852779-3-joamaki@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26175/Wed May 19 13:10:37 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/18/21 4:23 PM, Jussi Maki wrote:
> Add a test case for using bpf_skb_change_head in combination with
> bpf_redirect_peer to redirect a packet from a L3 device to veth and back.
> 
> The test uses a BPF program that adds L2 headers to the packet coming
> from a L3 device and then calls bpf_redirect_peer to redirect the packet
> to a veth device. The test fails as skb->mac_len is not set properly and
> thus the ethernet headers are not properly skb_pull'd in cls_bpf_classify,
> causing tcp_v4_rcv to point the TCP header into middle of the IP header.
> 
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
[...]
>   
>   /**
> - * setns_by_name() - Set networks namespace by name
> + * open_netns() - Switch to specified network namespace by name.
> + *
> + * Returns token with which to restore the original namespace
> + * using close_netns().
>    */
> -static int setns_by_name(const char *name)
> +static struct nstoken *open_netns(const char *name)
>   {
>   	int nsfd;
>   	char nspath[PATH_MAX];
>   	int err;
> +	struct nstoken *token;
> +
> +	token = malloc(sizeof(struct nstoken));
> +	if (!ASSERT_OK_PTR(token, "malloc token"))
> +		return NULL;
> +
> +	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
> +	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
> +		goto fail;
>   
>   	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
>   	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> -	if (nsfd < 0)
> -		return nsfd;
> +	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
> +		goto fail;
>   
> -	err = setns(nsfd, CLONE_NEWNET);
> -	close(nsfd);
> +	err = setns_by_fd(nsfd);
> +	if (!ASSERT_OK(err, "setns_by_fd"))
> +		goto fail;
>   
> -	return err;
> +	return token;
> +fail:
> +	free(token);
> +	return NULL;
>   }

As discussed earlier, the selftest seems to be causing issues in the bpf CI [0] likely
due to the setns() interaction/cleanup. Pls investigate and resubmit once fixed. Thanks
a lot, Jussi!

Cheers,
Daniel

   [0] https://travis-ci.com/github/kernel-patches/bpf/builds/226213040
