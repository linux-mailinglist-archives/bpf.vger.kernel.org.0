Return-Path: <bpf+bounces-20877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE3844D63
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 00:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79894283FE1
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8D3A8EF;
	Wed, 31 Jan 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD+WJNkH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251F3A8D2;
	Wed, 31 Jan 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745177; cv=none; b=p1XMdlQZy6GRDz0/s8EQksGfCOkjqNP6tc2Mjsit0zLL7F94T7UJ4JwW34hxw4KAXfjA8yLtIwARE5pemKN7ehVshECUpEdYCV0SY2PpRKAGMiyfbgf9YqT68Z9z02i+dDF05KPbmQcXKSQbjBSkJE7y++aea+I+NqedUjE+Fko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745177; c=relaxed/simple;
	bh=aq/tIq5REOIbug/MsfZrhDQM9zZce6YgRuZXTIMdeCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0iVzp4cQcETSodlknTRJZ7EkL8qnWBGHMtZgQd3RS1oMZ0ornE1cvTdhcvWCxqQo/0UTaaQPWgsE5ZX4KihUSg5UXtpd5S1Y/C+NgelD/kJ8ZHl6xBpO51hUy81mEiMyJ2U5fo8o+9HWtNqaSZqii3TIPxXutURuiPpYY8elnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD+WJNkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F5C433C7;
	Wed, 31 Jan 2024 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706745176;
	bh=aq/tIq5REOIbug/MsfZrhDQM9zZce6YgRuZXTIMdeCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HD+WJNkHRfk9ENiP8dDzfv6lD33dxf18Hu22SV0XeSlGhJsCappav4iW9yF42IXlu
	 ugZmBH+2geZiw+E0aLRPf4mFAq11DMv4NNCq2JeBy6KxC4LBnsrwJVQdU3GUgVR+fV
	 +9bgc/u8EUQa7U87G0eoO+TvErhxnWDdzn0Nc1maSdqIJgddFimfqgb/bzegflkKV9
	 jTwKes+DT7BzN5DOZ0H8vrOHgMzmho+AMt68BgZaSy6RL9ZShBilhnhEu0mMjYXjOL
	 i4sFnyV8o5Y4xgmtPpcO6xdTPx8tfSY5+tPEANwQgjogVQmuPFfz91MwwV251qQA6K
	 cHgtetzbvUlZQ==
Date: Wed, 31 Jan 2024 15:52:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <20240131155251.5d22477f@kernel.org>
In-Reply-To: <877cjpzfgv.fsf@toke.dk>
References: <cover.1706451150.git.lorenzo@kernel.org>
	<9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
	<bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
	<ZbejGhc8K4J4dLbL@lore-desk>
	<ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
	<Zbj_Cb9oHRseTa3u@lore-desk>
	<fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
	<ZbkdblTwF19lBYbf@lore-desk>
	<877cjpzfgv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 16:32:00 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > ack from my side if you have some use-cases in mind.
> > Some questions below:
> > - can we assume ethtool will be used to report stats just for 'global'
> >   page_pool (not per-cpu page_pool)?
> > - can we assume netlink/yaml will be used to report per-cpu page_pool s=
tats?
> >
> > I think in the current series we can fix the accounting part (in partic=
ular
> > avoiding memory wasting) and then we will figure out how to report perc=
pu
> > page_pool stats through netlink/yaml. Agree? =20
>=20
> Deferring the export API to a separate series after this is merged is
> fine with me.

+1

> In which case the *gathering* of statistics could also be
> deferred (it's not really useful if it can't be exported).

What do you mean by "gather" here? If we plan to expose them later on=20
I reckon there's no point having this patch which actively optimizes
them away, no? IOW we should just drop this patch from v7?

