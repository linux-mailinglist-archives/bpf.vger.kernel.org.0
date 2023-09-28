Return-Path: <bpf+bounces-11049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234357B1F78
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EB218282AA3
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DA36B0F;
	Thu, 28 Sep 2023 14:33:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE43FB02;
	Thu, 28 Sep 2023 14:32:56 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16D136;
	Thu, 28 Sep 2023 07:32:49 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.250]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsLo-1quhcT2cAi-008oqz; Thu, 28 Sep 2023 16:23:57 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by leknes.fjasle.eu (Postfix) with ESMTPS id 3B84A3F714;
	Thu, 28 Sep 2023 16:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
	t=1695911032; bh=rrG6e3agpf2u+xdW5EebxCgAIgDQqDDDehdHU4UpuSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9VyJAHr+r6y2EtJaCNO6HBblZVQgzaUGhMwVZ6O8WP+KHQgN2FjXoRADIfysq8pF
	 kJGLQ7huV6RT+PiTX1v6vTmKUB4n/gTFbtEy7TNQRVZegIIveW812XKAd9oFPz49Zh
	 qFCYktXaWarLodorMHCNFp6c3VBgzUAjnYLjIA7I=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
	id 8CBC03B5; Thu, 28 Sep 2023 16:23:21 +0200 (CEST)
Date: Thu, 28 Sep 2023 16:23:21 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Ian Rogers <irogers@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ming Wang <wangming01@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>, Yuan Can <yuancan@huawei.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	James Clark <james.clark@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
Message-ID: <ZRWMWcNKvZMgiAMR@bergen.fjasle.eu>
References: <20230923053515.535607-1-irogers@google.com>
 <20230923053515.535607-2-irogers@google.com>
 <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
 <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:WNIhYuQMIKkE8jRY9K+NatBF6dWQ4oI0AVrEW1Ph+1/B/OQCMOe
 UYvFzVf/gYNyD6apt1zxPnOEgXzDOp9rgmnrzkCk/swgt7YBVUGMKuIlKd5Y7q2eeaVsy3G
 UFMUULZIEOZtgVKKG1vHszO/HQPrY0TZy33PsLUS/IGIcPSHB/wyyhhSJK00ACowyMnhW4R
 gzpdERsa8atFSBEFq+ebQ==
UI-OutboundReport: notjunk:1;M01:P0:0GD5QClVf4o=;6KChTRklYRQjU1OUiRLjF0oQaba
 Q5ClB5DGl1KrJvxqBBGCP3BjWUj3C+nNSvgeti9Kpl8jruRElU/2+ghj9Xf2idQYnbK+G22f2
 fSpZfGMmFqg1/MJ6ffRU9Vzv0jIZVT0nEhBGF57L5mVxrB68Ooy0PSiZV4bU9qnoESHZfB/d+
 bVND/uO9UCZh7BcJWQchjgBAiiMofJBBfzFhwoqqZWOXZR3eiqdtC2+hc7BAib6bbzDL3+apW
 TyXV4TrR5zd9mF1ngiGoE7kQ+m4oFuMgwgdTIAsWviwSmLqLXuPYtAycL9zHBntIOjAn34k7X
 aVyVy/nVU/v1qBzqUesWjukK+hy6/Rmq0qKSBAy5vjtVJQXgyGMBwQJCnIElefVUGHmQehtUp
 AvYjzXcCuiJrVwERme+K5/vhiOu3VJM5dRX+oY84S3v0P7BSKd29Rbnl9/hywfNCmueDMzlyN
 RAP79IkX158taGlCfN8patYPgscXYcqJ7t3Uz9jm3crYePoP20YzJoQiR4jS+bRYsZsOcp5Kn
 bi2BC8XOxiWc1TutIgAK+44LIqOVA2InMPacw4PLokJV2/HzYsUHsvWwbgs7FvuD/2r3QrP6q
 Gi990oi4vd++Szbxh0tnqqFIpk5iit3vYHkmI2lKiPXby33n1JUSP2XzE4GwfMsiETwNBfbl1
 7CeKaCFwo0ui6S0Bi9KKXBbuCLrmmshlj+18RDliU2QdGQPjTPuSx66d2ZdQNYGSalggI8J1X
 p5Tsdl+onQ3L15Cbop5W5ObVHy0ACRVuXbUefl6dBia1ECdv9B0lsKA0O5x0u/Xs61b69jrMS
 0kqmcwYa1XUy6QDxEYX/WozNPmFs7nwMw9Dz5gJw6pDIkyN4lEV2ebN88aZIKfrzfT+Qhv4wh
 7zpsFWH1B4NXLgQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sep 2023 09:06:11 -0700, Ian Rogers wrote:
> On Mon, Sep 25, 2023 at 8:49 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Sep 22, 2023 at 10:35 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Builds in tools still use the cmd_ prefix in .cmd files, so don't
> > > require the saved part. Name the groups in the line pattern match so
> >
> > Is that something that can be changed in the tools/ Makefiles?
> >
> > I'm fine with this change, just curious where the difference comes
> > from precisely.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I agree. The savedcmd_ change came from Masahiro in:
> https://lore.kernel.org/lkml/20221229091501.916296-1-masahiroy@kernel.org/
> I was reluctant to change the build logic in tools/ because of the
> potential to break things. Maybe Masahiro/Nicolas know of issues?

I haven't seen any issues related to the introduction of savedcmd_; and 
roughly searching through tools/ I cannot find a rule that matches the 
pattern Masahiro described in commit 92215e7a801d ("kbuild: rename 
cmd_$@ to savedcmd_$@ in *.cmd files", 2022-12-29).  For consistency, 
I'd like to see the build rules in tools/ re-use the ones from scripts/ 
but as of now I don't see any necessity to introduce savedcmd in 
tools/, yet.

Kind regards,
Nicolas

