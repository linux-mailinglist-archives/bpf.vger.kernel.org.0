Return-Path: <bpf+bounces-11828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C317C03FB
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91EC281F35
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29B30FAC;
	Tue, 10 Oct 2023 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecU4MnY9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BB28F0;
	Tue, 10 Oct 2023 18:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC1FC433C7;
	Tue, 10 Oct 2023 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696964388;
	bh=QjP+9QKzrymfN2C8lY1Hip1CW9eHoE7JMBdIbHB9Czk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecU4MnY9/zXzPaOCdkPNhnTUuXhWI95KlqSPWzzLZmRpvFprf7Ugvz4/J9Arb1C3O
	 Wh9q2HmUyWdFPy/Qm7NX1EVtWTNTSHV2ExW0G94RU7cBoXEwsFHa2gvWw8rjWN5MAr
	 3X5DJHZo3tTaultpVLa2Gmy4WVDYcpQg4ZK0vQQM=
Date: Tue, 10 Oct 2023 20:59:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <2023101036-relock-slogan-3b3c@gregkh>
References: <20231009130122.946357448@linuxfoundation.org>
 <CA+G9fYvWCf4fYuQsVLu0NdN+=W73bW1hr1hiokajktNzPFyYtA@mail.gmail.com>
 <6447b32f-abb9-4459-aca5-3d510a66b685@kernel.org>
 <CANn89iJ_KMA=dQWPhU8WQBc0_CvUztUBodAf-cW-2F=HMX3HJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ_KMA=dQWPhU8WQBc0_CvUztUBodAf-cW-2F=HMX3HJg@mail.gmail.com>

On Tue, Oct 10, 2023 at 07:24:08PM +0200, Eric Dumazet wrote:
> On Tue, Oct 10, 2023 at 6:51 PM Matthieu Baerts <matttbe@kernel.org> wrote:
> >
> > Hi Naresh,
> >
> > On 09/10/2023 22:43, Naresh Kamboju wrote:
> > > On Mon, 9 Oct 2023 at 18:46, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> This is the start of the stable review cycle for the 6.1.57 release.
> > >> There are 162 patches in this series, all will be posted as a response
> > >> to this one.  If anyone has any issues with these being applied, please
> > >> let me know.
> > >>
> > >> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > >> Anything received after that time might be too late.
> > >>
> > >> The whole patch series can be found in one patch at:
> > >>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
> > >> or in the git tree and branch at:
> > >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > >> and the diffstat can be found below.
> > >>
> > >> thanks,
> > >>
> > >> greg k-h
> > >
> > >
> > > The following kernel warnings were noticed several times on arm x15 devices
> > > running stable-rc 6.1.57-rc1 while running  selftests: net: mptcp_connect.sh
> > > and netfilter: nft_fib.sh.
> > >
> > > The possible unsafe locking scenario detected.
> > >
> > > FYI,
> > > Stable-rc/ linux.6.1.y kernel running stable/ linux.6.5.y selftest in this case.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > kselftest: Running tests in net/mptcp
> >
> > Thank you for having reported the issue and having added MPTCP ML in Cc!
> >
> > Just to avoid confusions: the "WARNING" you shared when running
> > 'mptcp_connect.sh' selftest appeared before creating the first MPTCP
> > connection. It looks like there is no reference to MPTCP in the
> > calltraces. Also, because you have the same issue with nft_fib.sh, I
> > would say that this issue is not linked to MPTCP but rather to a recent
> > modification in the IPv6 stack.
> >
> > By chance, did you start a "git bisect" to identify the commit causing
> > this issue?
> >
> >
> 
> I think stable teams missed to backport
> 
> commit c486640aa710ddd06c13a7f7162126e1552e8842
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Mar 13 20:17:32 2023 +0000
> 
>     ipv6: remove one read_lock()/read_unlock() pair in rt6_check_neigh()
> 
>     rt6_check_neigh() uses read_lock() to protect n->nud_state reading.
> 
>     This seems overkill and causes false sharing.
> 
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Reviewed-by: David Ahern <dsahern@kernel.org>
>     Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Ah, didn't know we needed that, now queued up, thanks!

greg k-h

