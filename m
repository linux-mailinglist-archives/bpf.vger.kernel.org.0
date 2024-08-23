Return-Path: <bpf+bounces-37951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D033A95CE0D
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750E61F21294
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A36187870;
	Fri, 23 Aug 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MICsk+Pj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A080168C20
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420159; cv=none; b=gcw0/edZJaSj0FuSFOwblujdCLcjyPfPqqxPEOvxecJmildnGmx79WzGnHuJq0YZNyKiXRFPcLV5/t586vxOB1KvoLV+TsoQ3/vnIdfckRziB1DvbMxYkzmoWIAW3os9y4rlEU5KPckFklcu0Lo150od7NOfVXSPPAxsOrv+cRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420159; c=relaxed/simple;
	bh=ujM6O5ZK/EqpLhk4Q4uv5TbD+rpWyu4euAlplf7EsFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9RAQH8LeJmmU4Db03e6sXv+VEP17HmFme2exSYnsnNJCBPqgG1aCVRdn+1rLLlu8JzHaQlxtnh3bFmEP8LTW3STc3zuhytGsBFnGMnwbQ/YbExeJ0QwJR+Tvb64OtPJQnnfRFCGfVLuLu7YJVp4yj3fjxlgxzuh/NIrngxWB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MICsk+Pj; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso110444439f.2
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724420156; x=1725024956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEKb45Lg8MPDi362O0d6ofXFvSIdqIRy115kUuxhPZk=;
        b=MICsk+PjgLz2jig6HfpG8NjNKTWbVEWXAz9xczcIUN/9/ypUJt8qn5RmryX5k5OsWg
         KHxRFXwWfnf8VUvJrSwTg/Si/Oo3jmdqgXX/OjTYWk9U27gh8YJ4y8oIcUJDvLtO1OJ1
         YLXEEeVTxb/y+FE/mZQO9/cPlXr9R7RJQjrKsnDQlS++UZcmCn98xZdBb1s4bFO4g3T7
         ffnTV0FkwBmag9zQBHzvRM8pu3Lr76TjC04vs9I1mYvdS++HvTorXunM8BYTeaeRvwoR
         6CroNyTZCJV3NE4NB1jK9GeNdoWeWsl/f/WzzVdOaMj/3YJIp8beI2ocOYTGOeEyIncG
         aNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420156; x=1725024956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEKb45Lg8MPDi362O0d6ofXFvSIdqIRy115kUuxhPZk=;
        b=TqEJGEzIlPhJWe0hBAcQkvrAPFYGbW+5aeHPHcwfgEaL59xxrf07he+gBPA47mLp8h
         bq+qnHEWD8ZKPFVaeiaLsFFm+FeKJ3KXGi1O/tvFeY8M1Y14GQH4ykxpwbimhC/m0NFk
         ETg+v1j5Q9c+PqZBCLSM4yFu/DMyfl0F0gw7M7XHM1BZtjQq9FH/3OGcqjHHEkR3kTwa
         6y5OwNQ4MYusCme+A5ETB4oiYp9//TWiBWcHMZoMQAg2/aUNVZJt8UtL3Os3ErDEmd40
         o7Z8DeQXSxWGkMI6y9WT2B2Yj1OYCxY/fWlJlITxCYJLcu5gRHT5F3OAmJixWMkaUdZ1
         T7SA==
X-Forwarded-Encrypted: i=1; AJvYcCW0A03inWmiXgIvZIj1gRoPe0pvSmg/IxXez1XRWMrLxW5a8qiYSVqLbv+QNvY2OBx+Ozc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MrzQvcEZkNqDGNcZFS8yijj5RjJAESL3FC0j3QRHWdpSX9Qq
	6RxwlYGixDHiEHtXdPPg4sABFlPypcFRJB6AdupakfrCWBuTHpL9etN0W1GGRPFINLzmleFiqrO
	GyUN/Ici8Mb0WY5SJCd7+2z3VOUqXXNY9dbVI
X-Google-Smtp-Source: AGHT+IF1feSpu1MHABPyVtTarNKgPPjFSAfT+Lum6ZjhP2a6e49DYc4QMytXHG34dALxUk29vig8528QbbKgOzAX8xE=
X-Received: by 2002:a05:6602:3996:b0:81f:9468:7c3c with SMTP id
 ca18e2360f4ac-8278735fc68mr349134739f.12.1724420156033; Fri, 23 Aug 2024
 06:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
In-Reply-To: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 15:35:43 +0200
Message-ID: <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take
 effect when TCP over IPv4 via INET6 API
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Feng zhou <zhoufeng.zf@bytedance.c=
om> wrote:
>
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.
>
> So bpf_get/setsockopt needs add the judgment of this case. Just check
> "inet_csk(sk)->icsk_af_ops =3D=3D &ipv6_mapped".
>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp=
@intel.com/
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
> Changelog:
> v1->v2: Addressed comments from kernel test robot
> - Fix compilation error
> Details in here:
> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
>
>  include/net/tcp.h   | 2 ++
>  net/core/filter.c   | 6 +++++-
>  net/ipv6/tcp_ipv6.c | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..ea673f88c900 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const str=
uct request_sock_ops *ops,
>                                             struct tcp_options_received *=
tcp_opt,
>                                             int mss, u32 tsoff);
>
> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
> +
>  #if IS_ENABLED(CONFIG_BPF)
>  struct bpf_tcp_req_attrs {
>         u32 rcv_tsval;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ecf2ddf633bf..02a825e35c4d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int opt=
name,
>                           char *optval, int *optlen,
>                           bool getopt)
>  {
> -       if (sk->sk_family !=3D AF_INET)
> +       if (sk->sk_family !=3D AF_INET
> +#if IS_BUILTIN(CONFIG_IPV6)
> +           && !is_tcp_sock_ipv6_mapped(sk)
> +#endif
> +           )
>                 return -EINVAL;

This does not look right to me.

I would remove the test completely.

SOL_IP socket options are available on AF_INET6 sockets just fine.

