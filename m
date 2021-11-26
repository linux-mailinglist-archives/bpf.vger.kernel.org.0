Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78D45F4A2
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbhKZSbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 13:31:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbhKZS3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 13:29:42 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 13:29:42 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E592A6232B;
        Fri, 26 Nov 2021 18:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C2C93056;
        Fri, 26 Nov 2021 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637950783;
        bh=veGoBC6JPRLudSZ3gv58uc0qXWiRFbb61XaRPyC85lI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hQAvWjKYvqimPburQ706BWvjSdNXZMwnBEKhS1D9taxUEbjrk+QQCQ/1jyHjaECed
         6D6GcfxYkTx88xh4kTi+fOa5rQSJdIuLQUCgze0tLZG7KypYXeHOVz9Wf1+D7Q+Uw5
         bnGyWAWnmsIQuWJL+vbqZ0jnyiAwuLlvwIfgV3rZuVuiwn5Uegz9Zj7Hdx3UhwMeRo
         /mmLlis3UX8TbgHi71PogbMn1DPVQVaFx7zOm9b0HfNg9LCpg8sz3MmN6CFrmUPc+l
         t/chawF58NidBvDLQuyFYogA1eNOxPN4D+0Qdut4MHxMokNpQZUhtZOBH4KayO1agy
         NMquMp0R667tg==
Date:   Fri, 26 Nov 2021 10:19:41 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] bpf: let bpf_warn_invalid_xdp_action()
 report more info
Message-ID: <20211126101941.029e1d7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
References: <cover.1637924200.git.pabeni@redhat.com>
        <277a9483b38f9016bc78ce66707753681684fbd7.1637924200.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Nov 2021 12:19:11 +0100 Paolo Abeni wrote:
> -void bpf_warn_invalid_xdp_action(u32 act)
> +void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
>  {
>  	const u32 act_max = XDP_REDIRECT;
>  
> -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
> +	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expect packet loss!\n",
>  		     act > act_max ? "Illegal" : "Driver unsupported",
> -		     act);
> +		     act, prog->aux->name, prog->aux->id, dev->name ? dev->name : "");
>  }

Since we have to touch all the drivers each time the prototype of this
function is changed - would it make sense to pass in rxq instead? It has
more info which may become useful at some point.
