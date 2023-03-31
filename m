Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F206D2B49
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjCaWZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaWZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 18:25:06 -0400
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [IPv6:2001:41d0:203:375::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828C1EA02
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 15:25:04 -0700 (PDT)
Message-ID: <500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680301502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQnWkm4rVrh356Vg3L3cEBPbcOsC8xXrVcQoztsmiaw=;
        b=EWv9zNJt5d2zJvlDXhnZCZNwuUQueE4RCmujMk6Iy2z1rBQ075srlyRGTCPwN/4M6O8IOR
        i1dyDMrkg+JXtnTQJ8QEPX89J7jYYPZYO2KMjf+GGoB6WAn8DzWjUmqu2QVIQJhm8Brpn9
        igDHkVLWvFmUFxfQjBnleDvO5nSIcI4=
Date:   Fri, 31 Mar 2023 15:24:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 5/7] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-6-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230330151758.531170-6-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 8:17 AM, Aditi Ghag wrote:
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
> + *
> + * The helper expects a non-NULL pointer to a socket. It invokes the
> + * protocol specific socket destroy handlers.
> + *
> + * The helper can only be called from BPF contexts that have acquired the socket
> + * locks.
> + *
> + * Parameters:
> + * @sock: Pointer to socket to be destroyed
> + *
> + * Return:
> + * On error, may return EPROTONOSUPPORT, EINVAL.
> + * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
> + * 0 otherwise
> + */
> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	struct sock *sk = (struct sock *)sock;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;
> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(sock_destroy_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_sock_destroy)
> +BTF_SET8_END(sock_destroy_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &sock_destroy_kfunc_set,
> +};
> +
> +static int init_subsystem(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sock_destroy_kfunc_set);

This still needs to be restricted to BPF_TRACE_ITER which has held the 
lock_sock. May be adding BTF_KFUNC_HOOK_TRACING_ITER. Then, 
register_btf_kfunc_id_set() and btf_kfunc_id_set_contains() need to consider the 
prog->expected_attach_type also?

