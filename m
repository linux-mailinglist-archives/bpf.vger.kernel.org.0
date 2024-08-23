Return-Path: <bpf+bounces-37976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9795D59E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DB71F23F67
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140F1925B2;
	Fri, 23 Aug 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyIDTSfV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E31925A4
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439252; cv=none; b=f8jMrlU+kGIvbUs15hjbtnSR57JRYRf8CoRshjznjhdM/gLeNHNw1Ww//ukmKv0FBcPh9inZ+LsyrDzze+uVs22y4jGJ0ZVGWSKUiIMAZTV5e77x1dbpInlLyYhd5Dl3GyrlirP0t1ECtsvu7vr9c5K+dpzMtv9iVRSOj569ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439252; c=relaxed/simple;
	bh=Q4vJwaUK8X2ZZMRlnStM040Xb4vDEc/DlTU+8BrJyTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY8XywA6qp98eJr6+NDyw57zaoTQIyPcfA/siDnNcOfe4IqQsYXp9s/0+JGaiFHi5WTTmyoSjJ5JTh6WsFfvROdtP8tBSeGghEme1BDUnaaW1g3Rc7fIytduhPEQQsxF64rIQnnbuhKoyjcSMVjd03I4GcVf1g6ecPS7mx6Fo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyIDTSfV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso2959284e87.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724439249; x=1725044049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x3ntAitNepK+aZerXk+zKiD6yfO8PQEuPkCGO4jDLY=;
        b=VyIDTSfV6taE2svIB09H4b9Ifa7jz1hoOXITNkOMXg+kVq3+XDJvoEHjI0yEiHdhWo
         rvkokjCEElxOahPaaq5bYfnUbRC3PNkqLUiuEF7ytAuDZMsHGgqHRKYIpHihXt3Yxc4C
         5H4VzqPPgvDV2xdiyK1KghAc5cyrRb2vEpU6UF90R2bnj7QINRtNj/xziAXc+E+G4yQX
         Z+KYMNfwxqQhuoAWHaS/w+h9cNsa58R8X59F4ObMxP8z7p2jW75ASet9j49FqNEyzL2j
         Z75v+k/OX9uYdCDy1JBpGA37qQU9Mv7crURnQ7EvJEDsWG3kS4Cti3NvaDq9TYnwy1nP
         zKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439249; x=1725044049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0x3ntAitNepK+aZerXk+zKiD6yfO8PQEuPkCGO4jDLY=;
        b=Z6HWjj/HTyBDjrxVM8Clr+5fKM786X1OYXGlw/nA4m/43cJDfhkUROTbohlBjDxUGH
         Sv5+RvTc3DYjF4KDC+OZETREyPu/yruA69zTZy67AyfaFX0eGtErG8LV9CFMHAPUiWCZ
         1qGntnzfd3Y17+nWaf61S47wUJn0vjRQSuduVkIjVfuTBY9lGWG/iV/eKTzsZif41aEf
         7HNmh9cREhShVul4VnMp6/GTwzIUWm4gMe+EoXOAjrWckinRfvQYFQEXSvCRqrcCk+dC
         QrKCJ2hqm56CAZLhg9QBOQpV0vqhirGdiomb5mMfe0fCy/v0VxcB+naBHx03LzAkUDXA
         7k9A==
X-Forwarded-Encrypted: i=1; AJvYcCVoeBJVE5XQS4eGXuNGqEJRm+m4cAG7TmMyEgOpDYxQtH/xXYiIm6SKjdolo8h6yXVDlzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaXUqxmxeF+W4l+ieMdQovFVREw8izEwGIr1S8qVO3b7nX1fnT
	RuVqi278W1UIB1XWaNr1VgATh6w4ie3sCZOTIOs6RE4N38SKAKPggPKW9q/AH6n+rApu5imqNoM
	Ykgtz5bYPpB/BeVFeHjWoEuIhH0BbpQ50RTUT
X-Google-Smtp-Source: AGHT+IG1zw8hURfp0LR7lZDsyuPcmRr5h5qutscfgF+gusOIWKvBV+uK4kVgtgYRCXnQ4TyCtGp1Mgvzdd/hx1T/5PA=
X-Received: by 2002:a05:6512:308c:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-53438785436mr2520694e87.33.1724439248277; Fri, 23 Aug 2024
 11:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
 <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com> <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev>
In-Reply-To: <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 20:53:54 +0200
Message-ID: <CANn89iLKcOBBHXMSduV-DXYZfDCKAZyySggKFnQMpKH3p_Ureg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take
 effect when TCP over IPv4 via INET6 API
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 8:49=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/23/24 6:35 AM, Eric Dumazet wrote:
> > On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Feng zhou <zhoufeng.zf@bytedan=
ce.com> wrote:
> >>
> >> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> >>
> >> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> >> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> >> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> >> use ip_queue_xmit, inet_sk(sk)->tos.
> >>
> >> So bpf_get/setsockopt needs add the judgment of this case. Just check
> >> "inet_csk(sk)->icsk_af_ops =3D=3D &ipv6_mapped".
> >>
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-=
lkp@intel.com/
> >> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> >> ---
> >> Changelog:
> >> v1->v2: Addressed comments from kernel test robot
> >> - Fix compilation error
> >> Details in here:
> >> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
> >>
> >>   include/net/tcp.h   | 2 ++
> >>   net/core/filter.c   | 6 +++++-
> >>   net/ipv6/tcp_ipv6.c | 6 ++++++
> >>   3 files changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 2aac11e7e1cc..ea673f88c900 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const =
struct request_sock_ops *ops,
> >>                                              struct tcp_options_receiv=
ed *tcp_opt,
> >>                                              int mss, u32 tsoff);
> >>
> >> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
> >> +
> >>   #if IS_ENABLED(CONFIG_BPF)
> >>   struct bpf_tcp_req_attrs {
> >>          u32 rcv_tsval;
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index ecf2ddf633bf..02a825e35c4d 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int =
optname,
> >>                            char *optval, int *optlen,
> >>                            bool getopt)
> >>   {
> >> -       if (sk->sk_family !=3D AF_INET)
> >> +       if (sk->sk_family !=3D AF_INET
> >> +#if IS_BUILTIN(CONFIG_IPV6)
> >> +           && !is_tcp_sock_ipv6_mapped(sk)
> >> +#endif
> >> +           )
> >>                  return -EINVAL;
> >
> > This does not look right to me.
> >
> > I would remove the test completely.
> >
> > SOL_IP socket options are available on AF_INET6 sockets just fine.
>
> Good point on the SOL_IP options.
>
> The sk could be neither AF_INET nor AF_INET6. e.g. the bpf_get/setsockopt
> calling from the bpf_lsm's socket_post_create). so the AF_INET test is st=
ill needed.
>

OK, then I suggest using sk_is_inet() helper.

> Adding "&& sk->sk_family !=3D AF_INET6" should do. From ipv6_setsockopt, =
I think
> it also needs to consider the "sk->sk_type !=3D SOCK_RAW".
>
> Please add a test in the next re-spin.
>
> pw-bot: cr

