Return-Path: <bpf+bounces-40073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4C97C18A
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 23:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C431C223CB
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F851CA6AA;
	Wed, 18 Sep 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EN89g9ER"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE926FB6
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695943; cv=none; b=AuneGHYQbdoYA82rZ3WnyPK8pTHcdA0PIXplxmVFpolpGnt3KrEQPyhTpetUh1i9p68EyuSUFDg1J7PLMCFW+0rWqIga884M/vOvpeKwsd63Mw4t4vJMvyrDRIac42VWDlNzbZXSeWX91LWuWso9+qqm3N+hTYy0H5aQXzPV+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695943; c=relaxed/simple;
	bh=zM2JOps5QVzvLyA0fdK4VggwQUbaSRWc9qkAybxwyVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz8Ghbuxc7nw+2Tn+nU4//c/wmz2CD8oCmDcFtK7Lau4YtONpg/LLtpY88t/aHpbkp2z2XTLBa+doK3nZuRTbpUSsQ4lFm2JgDtL4R9VbO5n9xCtzq6DXF+pnlltaiaBoJGemWhymXw5303SsZnEUupTIaLNFZcVbvnfj6UA/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EN89g9ER; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726695939; x=1726955139;
	bh=P7DzQzR0tS1vM/xzeSpc03vW43lRag0uZEeepnxWlCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EN89g9ERDteit2zyaYPtqb6fb+gQ5ETPScJpl16hD64SWlBaccnNxsrgTAyVBIBQN
	 ehx1yufI/ICz0OX09YhP4ifejzLtzNJ6+3R1dfGQOqPTevYF6qiIs0A1DGpKVl7nFK
	 jtlBef7XnZFdLukywMV1eyejVIzxsaKKXrAXTzQ1OETNYPxRAxHj4gV8RarINxxE+C
	 7K3sAVTQZsuoViC3KI/nWIbykR2/Ni5lw6sdDsGx2AOBxH21LsgVjAPPXMFNUTw6jr
	 YZS6gF0FxX/nNhg1OIbStcVPFwLZTKd5wIfI+/CDwfMWdb96moMALUqFnWJWLVK/W2
	 +9QO0V2NfUVpg==
Date: Wed, 18 Sep 2024 21:45:37 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Subject: Re: [PATCH bpf-next] libbpf: change log level of BTF loading error message
Message-ID: <y-ZrFr0yswMlvu_ixGp8r3ehYj4kzgFUbASMA4FaZAUwNmIyhL8zVXIbAeo-BMrYvIX4KAKrwwMg7vEL0HwlBpYVcmWuVGvcB4tM6olbzlc=@pm.me>
In-Reply-To: <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
References: <20240918193319.1165526-1-ihor.solodrai@pm.me> <a63ec24f6a54173d29a7b88ef679b2aa942d606a.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 66c04ac15fd89500b38193ed65169a19d3387291
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 18th, 2024 at 2:03 PM, Eduard Zingerman <eddyz87@gm=
ail.com> wrote:

>=20
> fwiw, I took verifier_bswap.bpf.o and replaced .BTF section with empty
> one inside it:

[...]

> So, if the goal is to move all optional invalid BTF messages to info
> level there are probably a few more places to modify.

Eduard, thanks for checking. My understanding is that a user
complained about this particular message being too noisy.

I don't know how to quickly check all the places that might be
relevant to optional BTF, and going through all the warnings feels
like too much work.

  $ grep -r 'pr_warn' | wc -l
  630

Maybe Andrii or others have a comment on this.


