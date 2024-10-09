Return-Path: <bpf+bounces-41501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38717997927
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3831C225E6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90051E1330;
	Wed,  9 Oct 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfaCDW04"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28781547CF
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516928; cv=none; b=AhJttiYxg5XyeOfq0Xw1N6Msz6BtIMUKkZPFtqEjt2cXM0/iGSrV9+U7akU5KH8oWHU3qIlDu36U7PwMkuFFwbB4khZEQ7PD+x8AkeipDgfHmBQGhvdrdhER4tjl7WcTKCmhu6kp/nwzSqTJYfbqzsSmDxUK8okQbcgJHQx8CT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516928; c=relaxed/simple;
	bh=3JCe5/aXakAe33MsV3fVuP0YrL2vIO6+IpjbdP8gRm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is2818z8IRdVUsnjWdCA/utvKpHOH53/IN3YhyEUaYVnE2+gn/n43r2VYenO44ZXKA3bAzTAHewfsq2qzVz+X46+R+TZ3OIlwxMEjIP4gIjZiGZ7VzpSnlI7wC+OkXjeC8lns3zrMxBKgp2RZQsYh/xMwxp6VmPIMRfl51VGPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfaCDW04; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso163189f8f.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728516925; x=1729121725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5gM/ickk520BcezLGCw7uOXhqlWZ4F/SXrCXl3VNmo=;
        b=UfaCDW04Gt8Ui9+2hMAzq7Ajh+mar/t676+2qque4DFqo1helhT+Ci0zAjdq/RNViB
         v7sC1SH19kM4+rCDzE67yAdy6bztQjFk2uD9WX5Pj+qigHgFg+lKL+rp3zo8tRfKu17t
         f03o1fw1EOE2W70jltwp4EnN/n7PERojPlxwC/cTRBYVapvcmV8/SzloOX3wiAiqvOuk
         Q6jkBIi/lJAWUiWMhMojeQ+MNJzPziE3RRnummJXBwl0tyl0dLhl5hyrzgPvoHqwUKzb
         daaQrRVhWHK4N0tWsN1RZDxmrzZn56OsNoFAbBTy1n/eXRVC/aJ6awAiOEua8/dhnp8U
         Yoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728516925; x=1729121725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5gM/ickk520BcezLGCw7uOXhqlWZ4F/SXrCXl3VNmo=;
        b=TUB+s5P22/N4LfmZzS65N9a9Uc74JJdlK1rZTef9P9yxymRv6XYkcqgQUf1Yt8VY10
         wBZ0guAVCtM5y1pCHZJ5JXZRPUBX9MUyyBBkzCVBlQpgwJPQyuqwrFeFElJh1DV/Zqdo
         33Nu4Xf79M4kifJQMCLnTi11CzHef9WxHwk1buaPHNAIGnoGKLt/0fQxPl8wyezhV6X5
         zqTg16f7Kz8963uCdfEOq+xGE3LPJ9BHCackGx0wFygAxSi/w7T+jw3QTIftreTraGiJ
         x0Am/pyUIWYexUJgcwAM8krN3aeO2tp8h6r/pKxsij+2ySZGLKvOw1dM5oPdzIk55P5B
         /zHw==
X-Forwarded-Encrypted: i=1; AJvYcCUWDm/mm62T14SVVNtveE2JN17PceeeVhmTUsWDVBMREQbHw39UgcXHgVTCKVEZgvlH2HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGxO0Rq/vZjEDcnNwSJIDwdbpMXuIvooqdgC8PnWGeCGW9Cys
	VaTdXK0g8SjTThUUgnuP8HXrYvky9FGCmXhgosKQ1afCHAgWDc16Jh+hy7CvXKslrYImDU7zuOn
	auifG0uel3hri9kzRAJHm/sbkFFs=
X-Google-Smtp-Source: AGHT+IEw/S0AVf8GcJyTGTNhviWqWIL6Xxb/h5RbHAY3TAeYOlIgp8vYYQQ3VRIbXMys5By6eBpqC5gisyPQ+eivpqI=
X-Received: by 2002:a5d:4991:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-37d3aab7873mr2611925f8f.48.1728516924596; Wed, 09 Oct 2024
 16:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-2-houtao@huaweicloud.com> <CAEf4BzZOo37TZM_tcEq_FV4v3LWXYmrUGAtOr+7ctGLF-w26wg@mail.gmail.com>
 <20f2714b-39a7-1530-6a7e-af8b7c2e8ee5@huaweicloud.com>
In-Reply-To: <20f2714b-39a7-1530-6a7e-af8b7c2e8ee5@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 16:35:13 -0700
Message-ID: <CAADnVQ+iMhEXPAbGNpPpsKnZ5VLfjo_ar59Z0HL2TtwesaEU-g@mail.gmail.com>
Subject: Re: [PATCH bpf 1/7] bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 10/9/2024 2:33 AM, Andrii Nakryiko wrote:
> > On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> There is an out-of-bounds read in bpf_link_show_fdinfo() for the sockm=
ap
> >> link fd. Fix it by adding the missing BPF_LINK_TYPE invocation for
> >> sockmap link
> >>
> >> Also add comments for bpf_link_type to prevent missing updates in the
> >> future.
> >>
> >> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb =
progs")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  include/linux/bpf_types.h | 1 +
> >>  include/uapi/linux/bpf.h  | 3 +++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> >> index 9f2a6b83b49e..fa78f49d4a9a 100644
> >> --- a/include/linux/bpf_types.h
> >> +++ b/include/linux/bpf_types.h
> >> @@ -146,6 +146,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
> >>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> >>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> >>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> >> +BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> >>  #endif
> >>  #ifdef CONFIG_PERF_EVENTS
> >>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index e8241b320c6d..4a939c90dc2e 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1121,6 +1121,9 @@ enum bpf_attach_type {
> >>
> >>  #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
> >>
> >> +/* Add BPF_LINK_TYPE(type, name) in bpf_types.h to keep bpf_link_type=
_strs[]
> >> + * in sync with the definitions below.
> >> + */
> >
> > Let's also add some static assert making sure that bpf_link_type_strs
> > (and probably same for other types) size is equal to
> > __MAX_BPF_LINK_TYPE? Comment is good to remind us, but compilation
> > error is better.
>
> Good idea. Will check for other candidates for static assert. Will do in =
v2.

When updating include/uapi/linux/bpf.h
pls update tools/../bpf.h in the same patch as well.

pw-bot: cr

