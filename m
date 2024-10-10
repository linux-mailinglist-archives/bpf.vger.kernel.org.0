Return-Path: <bpf+bounces-41590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AC5998D2B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072571F226BE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C2F1CEAA4;
	Thu, 10 Oct 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl6B3a+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A5188CAD;
	Thu, 10 Oct 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577325; cv=none; b=uvZb5bDk7+fLH+XTRYJXcsjGPbqZ6xaMvn9cFC0hGbyzXtx8ne0pbbHo/SqU/QDlGCxx4VVIP7RYzi4cRGp3CDGfTKE6/MSQk79bRF3gS2NupMogLU8zdi1khrO/mo0acB1R/AbcLfnIPwS02jMl2oAjz4Rl93OcDXQS/Jc01ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577325; c=relaxed/simple;
	bh=d+hpXxVmb3aKK0eK1VnP6oDaMBBez0l9ePrIgRqAaT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVQRiX5HIUyt0fcBkTlblmsq0R8MHK6MA8KT+9jokF4F3YdwkWMepmUte1cZFpAfjGb0eKgovdeteZep5pw0Y/rhrTCq8S/kdXTJTD8UVcGa7v618eS5+XE8FfMw+UMsjbI2KMA/39p06RziHZz2PK7+IoIAA3vvf+yk3taFimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl6B3a+t; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac187eef2so12497311fa.3;
        Thu, 10 Oct 2024 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728577322; x=1729182122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqwuCLIl2tcdpTx23gArz5Y7uzenJ20sh5dnqev10Io=;
        b=Yl6B3a+tSELC+tktAG0v7tNKvgUzBXMxOfieVqoPiQ9fkqx7ZBagwVWN6tvdaCdH0w
         cUdgfFYhw4ebH+ujaJz90nJJSlzs6jo+0gkr5rSFlGxmhFQo6to+X5Lu/TWVwkcAuzeJ
         v9rxF0m3GXWFevRf18YU4oPh0gRnFPU7qek7vWqel7902qhXaa/P6A5eDdblvQM2KaUf
         295Ttqtb1cCOWfo5e+09jC5Yg4uNxafT7bauz7kBmBFI8ghiA/od1tPz2tx52z159lhf
         xCmUTtV8TbjEu+bDjFoAhfaitZ5fnP/0JlZnzKL1E0qpamxcR8dKWmbOHIkzQaNLjXKq
         edrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728577322; x=1729182122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqwuCLIl2tcdpTx23gArz5Y7uzenJ20sh5dnqev10Io=;
        b=Zp8lqecNE0jJls1vYsJC5taON/RB+amXnhp02rqHAxXVcyBGDmXr4Pk++Zwgz7hKwx
         SNXNvWQqe3638nCnV0osTF+ZPWelDYamayEo1Bl3OK5GWH8fkcMpmkDVTLE7moNK2fyO
         HWtTsO/mD92J2wdpGd2nwX9hF6u+dQtV4PEPYdW3EouW9HVSILkhQd5xxJLwyRi0Sua4
         pr5UfZd5Q1vvJveOq0k97dEgG76WuBJ3uGV/a4n+pzTZVs6P7CJof6Xez9TLaOiPJagx
         flsWaZBQ3cI3fC44hIGJA0cCinyoggr7YR6a1wSiGEaZkfUSarLi/LDkxuH/rmKbL5AI
         UpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+D0QKd9aydWoOSN0ioaOEilCDS2nzJBML+7JGPAqFRaFFsWJeSYm/EXUZJUlkVBu8rgg=@vger.kernel.org, AJvYcCUkij5fHZFUhAfvxWGKk50HLPJJzwIZ3304Or71JYmRlxUb5RjqtgCUhDgJsNdzMWVqbN/9UA9g@vger.kernel.org, AJvYcCWDPB1zCAKUaN/YTPPpp37v1H4sCcj+vPSlpi5FtfuPgUXVw+Qus3DMIc/i06WOnM392oQesf4pFWr8pg==@vger.kernel.org, AJvYcCWysSJVe0dmQl1k0fF53vOyhoUYQOwL+BPAp6uABNoA6+51AowiZy6EJE3pzhspvFPCNU7SMUsIvB1BDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3uJz16LHdc/X5rXG0IWw7TrP2kJBoQ0BhWNjeIsG92Bhz9Hk
	XtlpjQPxq9bCln5TfjP6KpHJYuEl/mzB6tt5kGrP0EH+4Al8491Vl684w/Ipnt5ODM9FpXoJ2Sd
	24DYO3fJepIYvTn6fYIqDFc47pko=
X-Google-Smtp-Source: AGHT+IF5+dS/6FsJ+SrmgXbsnuLEPcs2Vh3K1NCSefdOc5WV+GSJPIwUNmypdX7oXd5shkIR1QFarjlZq5AtiocXbVU=
X-Received: by 2002:a2e:b8d6:0:b0:2fa:bd30:1928 with SMTP id
 38308e7fff4ca-2fb187cd74emr41734561fa.32.1728577320569; Thu, 10 Oct 2024
 09:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728532691-20044-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1728532691-20044-1-git-send-email-alibuda@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 09:21:48 -0700
Message-ID: <CAADnVQLXyA__zdDSiTdhaw=dXyfgmkr--cH068JvNK=JAYvRDA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/smc: Introduce a hook to modify syn_smc at runtime
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, linux-rdma@vger.kernel.org, 
	Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:58=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
>
> +__bpf_hook_start();
> +
> +__weak noinline int select_syn_smc(const struct sock *sk, struct sockadd=
r *peer)
> +{
> +       return 1;
> +}
> +
> +__bpf_hook_end();
> +
>  int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callba=
ck *cb)
>  {
>         struct smc_nl_dmp_ctx *cb_ctx =3D smc_nl_dmp_ctx(cb);
> @@ -156,19 +165,43 @@ static struct sock *smc_tcp_syn_recv_sock(const str=
uct sock *sk,
>         return NULL;
>  }
>
> -static bool smc_hs_congested(const struct sock *sk)
> +static void smc_openreq_init(struct request_sock *req,
> +                            const struct tcp_options_received *rx_opt,
> +                            struct sk_buff *skb, const struct sock *sk)
>  {
> +       struct inet_request_sock *ireq =3D inet_rsk(req);
> +       struct sockaddr_storage rmt_sockaddr =3D {};
>         const struct smc_sock *smc;
>
>         smc =3D smc_clcsock_user_data(sk);
>
>         if (!smc)
> -               return true;
> +               return;
>
> -       if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> -               return true;
> +       if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, sm=
c_hs_wq))
> +               goto out_no_smc;
>
> -       return false;
> +       rmt_sockaddr.ss_family =3D sk->sk_family;
> +
> +       if (rmt_sockaddr.ss_family =3D=3D AF_INET) {
> +               struct sockaddr_in *rmt4_sockaddr =3D  (struct sockaddr_i=
n *)&rmt_sockaddr;
> +
> +               rmt4_sockaddr->sin_addr.s_addr =3D ireq->ir_rmt_addr;
> +               rmt4_sockaddr->sin_port =3D ireq->ir_rmt_port;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else {
> +               struct sockaddr_in6 *rmt6_sockaddr =3D  (struct sockaddr_=
in6 *)&rmt_sockaddr;
> +
> +               rmt6_sockaddr->sin6_addr =3D ireq->ir_v6_rmt_addr;
> +               rmt6_sockaddr->sin6_port =3D ireq->ir_rmt_port;
> +#endif /* CONFIG_IPV6 */
> +       }
> +
> +       ireq->smc_ok =3D select_syn_smc(sk, (struct sockaddr *)&rmt_socka=
ddr);
> +       return;
> +out_no_smc:
> +       ireq->smc_ok =3D 0;
> +       return;
>  }
>
>  struct smc_hashinfo smc_v4_hashinfo =3D {
> @@ -1671,7 +1704,7 @@ int smc_connect(struct socket *sock, struct sockadd=
r *addr,
>         }
>
>         smc_copy_sock_settings_to_clc(smc);
> -       tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
> +       tcp_sk(smc->clcsock->sk)->syn_smc =3D select_syn_smc(sk, addr);
>         if (smc->connect_nonblock) {
>                 rc =3D -EALREADY;
>                 goto out;
> @@ -2650,8 +2683,7 @@ int smc_listen(struct socket *sock, int backlog)
>
>         inet_csk(smc->clcsock->sk)->icsk_af_ops =3D &smc->af_ops;
>
> -       if (smc->limit_smc_hs)
> -               tcp_sk(smc->clcsock->sk)->smc_hs_congested =3D smc_hs_con=
gested;
> +       tcp_sk(smc->clcsock->sk)->smc_openreq_init =3D smc_openreq_init;
>
>         rc =3D kernel_listen(smc->clcsock, backlog);
>         if (rc) {
> @@ -3475,6 +3507,24 @@ static void __net_exit smc_net_stat_exit(struct ne=
t *net)
>         .exit =3D smc_net_stat_exit,
>  };
>
> +#if IS_ENABLED(CONFIG_BPF_SYSCALL)
> +BTF_SET8_START(bpf_smc_fmodret_ids)
> +BTF_ID_FLAGS(func, select_syn_smc)
> +BTF_SET8_END(bpf_smc_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_smc_fmodret_ids,
> +};
> +
> +static int bpf_smc_kfunc_init(void)
> +{
> +       return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
> +}

fmodret was an approach that hid-bpf took initially,
but eventually they removed it all and switched to struct-ops approach.
Please learn that lesson.
Use struct_ops from the beginning.

I did a presentation recently explaining the motivation behind
struct_ops and tips on how to extend the kernel.
TLDR: the step one is to design the extension _without_ bpf.
The interface should be usable for kernel modules.
And then when you have *_ops style api in place
the bpf progs will plug-in without extra work.

Slides:
https://github.com/4ast/docs/blob/main/BPF%20struct-ops.pdf

