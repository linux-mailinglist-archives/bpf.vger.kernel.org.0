Return-Path: <bpf+bounces-10440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA587A74F1
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814411C20B21
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CDC8F8;
	Wed, 20 Sep 2023 07:54:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3A8C0A;
	Wed, 20 Sep 2023 07:54:23 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F87D6;
	Wed, 20 Sep 2023 00:54:21 -0700 (PDT)
Date: Wed, 20 Sep 2023 09:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695196459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgR6B6oH7fsw3ZFJDc2Wq39XL479VS3UgB7X/Iv0yZQ=;
	b=Lc0qcF6ilcHpuRsQEVRAejAt4RkNMHwkHsetAA57B+FTWwNJjCXuAiPIYTzpTLhV7BFoed
	K1ystsOqu1B49l2F7s66harVZ5GjlKir3C6JG9uC6HhB9rU81hkPgkWh0OZvPGX8SeooTG
	QOE+LqBzLKIHEOhAZzqHL7N37IfoWIErez/j/plBtkm5jBHR4f7Wkq91fHQMGXxjX2+uP9
	Tu5hMrbJlPIHVlSC/56qY8bbeMdSRUgYHDLHoF5O/h/UTCMHgrTInmjvuL5oOycXZ2dKX7
	+xRSi2foPzJu4f6sMhbBDKdxDeGqtMq+JkkE5mBA+RnH5X+8tiaBVjVSd1uQjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695196459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgR6B6oH7fsw3ZFJDc2Wq39XL479VS3UgB7X/Iv0yZQ=;
	b=J4Ja/EeE4O8uXE05RP2QLC8QD+VXXcy/P+d2wHrzHCFDJC1HahqKjBajgqKf3C533S6CDI
	yTYNjxwDhb2p0SDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net v2 0/3] Add missing xdp_do_flush() invocations.
Message-ID: <20230920075418.TdZ0jsM_@linutronix.de>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
 <cb2f7931-5ae5-8583-acff-4a186fed6632@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb2f7931-5ae5-8583-acff-4a186fed6632@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-20 09:04:27 [+0200], Jesper Dangaard Brouer wrote:
> Hi Sebastian,

Hi Jesper,

> On 18/09/2023 17.36, Sebastian Andrzej Siewior wrote:
> > Hi,
> >=20
> > I've been looking at the drivers/ XDP users and noticed that some
> > XDP_REDIRECT user don't invoke xdp_do_flush() at the end.
>=20
> I'm wondering if we could detect (and WARN) in the net core e.g.
> net_rx_action() that a driver is missing a flush?
>=20
> The idea could be to check the per CPU (struct) bpf_redirect_info.
> Or check (per CPU) dev_flush_list.
>=20
> If some is worried about performance implications, then we can hide this
> under CONFIG_DEBUG_NET.

I had a WARN_ON in mind since the list has to be empty after the
completion of a NAPI callback. Now that you are bringing it up let me
actually do something=E2=80=A6

> --Jesper

Sebastian

