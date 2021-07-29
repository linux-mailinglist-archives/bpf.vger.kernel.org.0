Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8619C3D9FA9
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhG2Iho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhG2Ihn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 04:37:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0AC0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 01:37:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g15so5889539wrd.3
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=p4JKR78YCMT0GzyVFcGrMvlzwUNK0GrOMmgRXzeh3O0=;
        b=xXvt4CdFkg9xhPKQW2RhAebtYEw6tb9FEsWXEB39j21/7Ac1xyB6gAutrVd8Q6k6mo
         CcGkND+TtkTIXf64uwdmPqKvjncLrsbq1N/FTfj6CVSdgJEKxZ2Tefs2nDx6hS/vcrkC
         24EM73E/EzoNnZO4EMIA1OiXCbG+NmtXPlwBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=p4JKR78YCMT0GzyVFcGrMvlzwUNK0GrOMmgRXzeh3O0=;
        b=XdpM14OvT9FCBQAo+qamm9XIDVPJpZqzwuBQDQD7mWbsB0IqIHv4NNDpY7Dgvmbns4
         TKNivkUBd3U+BuG6shsrU7+eaFQN33f/V+4sq/2SextgqUVHrLbRCwNv+e6iIJSwGB18
         arsSR92fsjy3QVc85NoXx3tPXRSdFh4krsfJAy5KGXwAFAVFBFnYyOOc+jrTjUE8y6xs
         B8dpyLYXG6aJ4vRJLsYmEQWqS2ND2jQ4NeP3U1HbEuzlFSuJH/oiuheAE8E6fPB1EUTA
         0oc425aFt6SCvKcR43BdsTc3xzimvduKWXkPg2A+Kuq7/8GwgQCHeLK9zcfx8C3SKX58
         W1FQ==
X-Gm-Message-State: AOAM531ESEk/dIz2BXFL1MHvZliM0urlz/5iU/7wgeVPTMZogyHsdZb6
        q/D8BI+bGXKLP8CxJ2AQkozYig==
X-Google-Smtp-Source: ABdhPJwvfdPV+HEbqfc1QfuveLLbR+7bPKmajYzrC1UCQPb+dGWvjUdHZDdMDmZMYftDrgrPwNV0WQ==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr3634542wrw.112.1627547859211;
        Thu, 29 Jul 2021 01:37:39 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id t17sm2196225wmq.17.2021.07.29.01.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:37:38 -0700 (PDT)
References: <20210727001252.1287673-1-jiang.wang@bytedance.com>
 <20210727001252.1287673-2-jiang.wang@bytedance.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Jiang Wang <jiang.wang@bytedance.com>
Cc:     netdev@vger.kernel.org, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/5] af_unix: add read_sock for stream
 socket types
In-reply-to: <20210727001252.1287673-2-jiang.wang@bytedance.com>
Date:   Thu, 29 Jul 2021 10:37:37 +0200
Message-ID: <87a6m5zfam.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 02:12 AM CEST, Jiang Wang wrote:
> To support sockmap for af_unix stream type, implement
> read_sock, which is similar to the read_sock for unix
> dgram sockets.
>
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>.
> ---
>  net/unix/af_unix.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 89927678c..32eeb4a6a 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -672,6 +672,8 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
>  static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
>  static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			  sk_read_actor_t recv_actor);
> +static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
> +				 sk_read_actor_t recv_actor);
>  static int unix_dgram_connect(struct socket *, struct sockaddr *,
>  			      int, int);
>  static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
> @@ -725,6 +727,7 @@ static const struct proto_ops unix_stream_ops = {
>  	.shutdown =	unix_shutdown,
>  	.sendmsg =	unix_stream_sendmsg,
>  	.recvmsg =	unix_stream_recvmsg,
> +	.read_sock =	unix_stream_read_sock,
>  	.mmap =		sock_no_mmap,
>  	.sendpage =	unix_stream_sendpage,
>  	.splice_read =	unix_stream_splice_read,
> @@ -2311,6 +2314,15 @@ struct unix_stream_read_state {
>  	unsigned int splice_flags;
>  };
>
> +static int unix_stream_read_sock(struct sock *sk, read_descriptor_t *desc,
> +				 sk_read_actor_t recv_actor)
> +{
> +	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
> +		return -EINVAL;

tcp_read_sock returns -ENOTCONN if socket is not connected.

For the sake of being consistent, and in case we start propagating the
error up the call chain, I'd use the same error code.

> +
> +	return unix_read_sock(sk, desc, recv_actor);
> +}
> +
>  static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  				    bool freezable)
>  {
