Return-Path: <bpf+bounces-4971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875B752BE2
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 22:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1C1281F31
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB179200BC;
	Thu, 13 Jul 2023 20:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BB1E536
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 20:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF91DC433C8;
	Thu, 13 Jul 2023 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689281876;
	bh=+R5y01qvCjh+BoWaqyDvokXbp1fi20idqBjQDMdK6B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUOLciB+nPHAKoMotWfi1ShU5AdDTcEs9B9+EsDtKvF5evkljj6hcXLqzcRC+v8V+
	 mALuKx7xq827bU6yhqrk7wHYSJHwNgFpuDrngCRZ8iuXvE/+5DwmXOIdoOyEMf0BEg
	 0/5GU1Fl4GCiKXht1PGEDv7As2XE4JdbnI2K/aUSmzHGWAXatbLO6CCbF7e3DTj1L7
	 B6D2W3RzaPSiXNhc+btQJBBP+hjFmIax5VSg0h+lTR0ZOK5k3A4dRxqcfX9Hk2z8yo
	 FbUJ8IUWqCJ99cGFIETBME0RiJJ47Yil3xYKhu3LqUg65pC/C+2Yv3htPV0mJzg5+c
	 PJ0tJugsZhaTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0922D40516; Thu, 13 Jul 2023 17:57:53 -0300 (-03)
Date: Thu, 13 Jul 2023 17:57:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Manu Bretelle <chantra@meta.com>,
	Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
	Mykola Lysenko <mykolal@meta.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
Message-ID: <ZLBlUXDxRqzNRup3@kernel.org>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
 <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com>
 <ZK7JMjN9LXTFEOvT@kernel.org>
 <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jul 12, 2023 at 11:20:27AM -0700, Alexei Starovoitov escreveu:
> On Wed, Jul 12, 2023 at 8:39 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Right, perhaps the libbpf CI could try building perf, preferably with
> > BUILD_BPF_SKEL=1, to enable these tools:
> 
> 
> That would be great.
> perf experts probably should do pull-req to bpf CI to enable that.
> See slides:
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> 
> "How to contribute?
> Depending on what part of CI you are changing, you can create a pull request to
> https://github.com/kernel-patches/vmtest/
> https://github.com/libbpf/ci
> "

Sure, I still recall Quentin's talk about CI, etc in Dublin, will come
up with something and submit.

- Arnaldo

