Return-Path: <bpf+bounces-39834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF69782D6
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E071C22847
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF87928DC1;
	Fri, 13 Sep 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDdo1olv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFD4D5BD
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238659; cv=none; b=H1VmclGnncIJhI/S/D/IYY/21pPHGTVkpenwRudsIfpNSVZtjJOuB/xNshirYEVNX+HUlB7x0+bS7jb0WUg4hcYdY8on444MoJhEoHlnQx/UT175sYbwqocuHs7rB7MYdRD793IZMeHNSv7aZlwOji/cqWhgmvtRRlT4/6hGrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238659; c=relaxed/simple;
	bh=yxbS5ZgLlXhg5bw9EbtSOOdwW659qsXhQuCcfA1VLMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVGPI2EKnGbJjPzNsxlTsKBi0hy7gWFjYNSUJznuwZW811TvZTW/MfyK8Ooa1I8gOXSFPSWkbvOHcet8Swrwe7QRfxgueyc7h7aHtLxyEnoqmhSbRxNmZgXOB55lPovEZicUoW44ZsAYpIWcnrlnwdDAtBIR2e/k/yOpnFym9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDdo1olv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so543691966b.0
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726238655; x=1726843455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWAX9MKC9+qpP4rTaNc34KRGg6ko5WHRfsEjNewEvO8=;
        b=SDdo1olvF6fZ/z4Fbe/hhbgwTwDkKim4mAsTl6NjAmZ4yaUZOk9YpKhWqG2afJkwMn
         ers833ZJHqQ7tElMK5GubKzdZNHB+Jp4fh2/Hmb+829lXRSxVYRhf9DBmb3ixGYF9PKi
         LcRN4OG6ESYyNqr8O/Pky7WzlD5C9JNyRMy9EPR5MbTLXF9bmQkJqaEehfgIkCR1ndS+
         BybLf6iOMyRWQBItbcvv7caichNNr87XWK9gppuAUMhev/e4YaLgDPXouxThS1rHrgod
         uxRz0wA++lq0INU6gYtsT9EbtOUjcRpBsKmNgqy53keK2m7PayXRg3LzI/XZGz1EXb1a
         4QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238655; x=1726843455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWAX9MKC9+qpP4rTaNc34KRGg6ko5WHRfsEjNewEvO8=;
        b=HCSWlYF04wMBkKBLOGErHOm++Puh4PRx1fD1hdyV8nkh2uY5Tl+yEerFwB/7xnTS0X
         96mqf1EGYuhaKnC9dLP3M0wRKUWLGPgxbOLVT/QGhO0ZfoLLmHAFsdeJT1SP74FgXNkA
         WwUN/b/QgzWZz/B+8JrDXjd+BA+lGm0SboR+8NZW8pqsK9/Do4KIdfKVQUAZ+skrKBp5
         xRv5wIULHXBExG7PSbA3Kjkx+YZdI4N+wo10Sy37naVLmFHiTWmtebtu/ItDNaOGh97J
         vPnbWv7zYlg6A49IgV7Q6o9igmv1l2H2upZaAg32fX3H2VnI1nLJIK/OL281tXIp13W9
         ucbw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jkN19v6ZVV0a7rjfHE4f+O6QNxg2+1Z7LgfboboBxcaSIG2ItUGHduP2Z/tU5TUecLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QxBNivaXF9WkH3v29Mozk0KUN5TlXn8taHGIzyyoQIpXLJpr
	EFe0FxOdsBKBBJ7X039UgKqM7YBRja8ttrhCK+niWm+Aa7z2YGNWfWY+YNMKjqDjaug9rTOh1uI
	FSLx6A0ouWaopG4F3vm7s3O/DsgMsl2A8U8uB
X-Google-Smtp-Source: AGHT+IGE+Jp/rSNl8CHAKVPj7rH64h80c1EZux4OwllcyyhQIQurPUP9+TGcdKNzyP6cFI3y2UMMZ38TUPBCji5KOKg=
X-Received: by 2002:a17:907:9809:b0:a8d:29b7:ece3 with SMTP id
 a640c23a62f3a-a902a8f0940mr691888166b.33.1726238654450; Fri, 13 Sep 2024
 07:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
 <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
 <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev> <CANn89iLKcOBBHXMSduV-DXYZfDCKAZyySggKFnQMpKH3p_Ureg@mail.gmail.com>
 <6c75215b-0bdc-4b5a-b267-6dce0faec496@bytedance.com>
In-Reply-To: <6c75215b-0bdc-4b5a-b267-6dce0faec496@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 16:44:03 +0200
Message-ID: <CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to
 tos not take effect when TCP over IPv4 via INET6 API
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:08=E2=80=AFAM Feng Zhou <zhoufeng.zf@bytedance.c=
om> wrote:
>
> =E5=9C=A8 2024/8/24 02:53, Eric Dumazet =E5=86=99=E9=81=93:
> > On Fri, Aug 23, 2024 at 8:49=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 8/23/24 6:35 AM, Eric Dumazet wrote:
> >>> On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Feng zhou <zhoufeng.zf@byted=
ance.com> wrote:
> >>>>
> >>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> >>>>
> >>>> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> >>>> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> >>>> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> >>>> use ip_queue_xmit, inet_sk(sk)->tos.
> >>>>
> >>>> So bpf_get/setsockopt needs add the judgment of this case. Just chec=
k
> >>>> "inet_csk(sk)->icsk_af_ops =3D=3D &ipv6_mapped".
> >>>>
> >>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj=
6-lkp@intel.com/
> >>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> >>>> ---
> >>>> Changelog:
> >>>> v1->v2: Addressed comments from kernel test robot
> >>>> - Fix compilation error
> >>>> Details in here:
> >>>> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
> >>>>
> >>>>    include/net/tcp.h   | 2 ++
> >>>>    net/core/filter.c   | 6 +++++-
> >>>>    net/ipv6/tcp_ipv6.c | 6 ++++++
> >>>>    3 files changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >>>> index 2aac11e7e1cc..ea673f88c900 100644
> >>>> --- a/include/net/tcp.h
> >>>> +++ b/include/net/tcp.h
> >>>> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(cons=
t struct request_sock_ops *ops,
> >>>>                                               struct tcp_options_rec=
eived *tcp_opt,
> >>>>                                               int mss, u32 tsoff);
> >>>>
> >>>> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
> >>>> +
> >>>>    #if IS_ENABLED(CONFIG_BPF)
> >>>>    struct bpf_tcp_req_attrs {
> >>>>           u32 rcv_tsval;
> >>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>> index ecf2ddf633bf..02a825e35c4d 100644
> >>>> --- a/net/core/filter.c
> >>>> +++ b/net/core/filter.c
> >>>> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, in=
t optname,
> >>>>                             char *optval, int *optlen,
> >>>>                             bool getopt)
> >>>>    {
> >>>> -       if (sk->sk_family !=3D AF_INET)
> >>>> +       if (sk->sk_family !=3D AF_INET
> >>>> +#if IS_BUILTIN(CONFIG_IPV6)
> >>>> +           && !is_tcp_sock_ipv6_mapped(sk)
> >>>> +#endif
> >>>> +           )
> >>>>                   return -EINVAL;
> >>>
> >>> This does not look right to me.
> >>>
> >>> I would remove the test completely.
> >>>
> >>> SOL_IP socket options are available on AF_INET6 sockets just fine.
> >>
> >> Good point on the SOL_IP options.
> >>
> >> The sk could be neither AF_INET nor AF_INET6. e.g. the bpf_get/setsock=
opt
> >> calling from the bpf_lsm's socket_post_create). so the AF_INET test is=
 still needed.
> >>
> >
> > OK, then I suggest using sk_is_inet() helper.
> >
> >> Adding "&& sk->sk_family !=3D AF_INET6" should do. From ipv6_setsockop=
t, I think
> >> it also needs to consider the "sk->sk_type !=3D SOCK_RAW".
> >>
> >> Please add a test in the next re-spin.
> >>
> >> pw-bot: cr
>
> Thanks for your suggestion, I will add it in the next version.

Gentle ping.

Have you sent the new version ?

