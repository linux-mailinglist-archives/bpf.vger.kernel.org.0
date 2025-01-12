Return-Path: <bpf+bounces-48658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F6A0ABA4
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 20:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3490218873E5
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F61C3BE0;
	Sun, 12 Jan 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lLayJPA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEB1BEF77;
	Sun, 12 Jan 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736708952; cv=none; b=Uf0lcpm8HTIn6/LRDJqMGcgpolLGRREKjFVUtArbTxErVcSTba5nbEEl8qdmF14x0U14auwn3mcE9ZKxVo7YV1WpYq5jmGv/TvczD4esrUigEncsP8nUTKed8XV31jLVuN0zh1gRZ1ZyszCR1aUHpxFZcyCoxM42dE1RBspEM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736708952; c=relaxed/simple;
	bh=uU+fWbBPYakP3S/IJj7SvmN49d/K9LmqXINmzlkX728=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWxtie7Fl6k+x0TPEuByG+2FDbvejjLqF5s4bpD6qiGZrLipxaqiGLVV3QZmQeku42ZaXtfN779FVLuJ13ivQmzHaasdVtRDnjyewPm8yvkhEOjb61FqKslx4oQ5gEmNwHBKHgfvic/tIQnqdMzVXDtjdl7HBTGZsN0RqIfo46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lLayJPA/ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 209C740E02C4;
	Sun, 12 Jan 2025 19:09:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ra0A8l4pz-bW; Sun, 12 Jan 2025 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736708938; bh=aLAfkjw74RRvWtCHgEL4sAt3h2Wr05yapxhTRn2aLsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLayJPA/rT4foGXRe+yvpsShqvoq+dPGmKurefnXwDIubIdBYwiiMqfLOuXZiVGgc
	 MF9WFxHHRygWF98WRYLe84/Q+hZa78mxEY2n+5NNT0ozk1XbnQP0xZTbKM25XQz4eW
	 +yqV5JvIbcszJ7/oE+Y4P2mhYF5WjSSw2EcbomAxk+ljrnjLEPf5GiAndVSB2FgyTH
	 +Te+dEinRxl6FpNLbjrOtlLNwfW6datkFkRfzCm8l1Z006ad2yauMO8gRvkPs9bB1G
	 63z9Dv5qq3jYZzuyCpMdv/nDg8UB8lQtTj+Nr8GySo8f/75Ekn2P5bFNiLbx+wB8n/
	 f14QaGx9WBCa/ac7O2I49pxsA3+DlPkTj0GLNIQ/rxjmvIQadhI5WI8YzpmDxHbr0p
	 OnpCPhEA2DxR2y05U+xswnyukBd/vcEbPAgYEGcKT4dSvCMc4/0nJzlGUeIJJ8PKv7
	 SCPVP23T7BxaRXiEOCyvmXdZdtnXrXlFmo9xfgY3LkNy41KBoebZfSy3hXf9eZfMnf
	 BIEDs9gA2+RRZd1euWwMQD0bQZR6U0AvSaiSfqZ7U/XsMJedES1t8NGD6RqCJ6s0a4
	 ZgnwvfTXZQUanL3UL3v6qqKF2nJ9bsCq8XP2crFGgo67EQSdd9+64USArbQi/zgCnM
	 Wa6XaNFBMbnkkVL6C4szOaCE=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B34C040E02BF;
	Sun, 12 Jan 2025 19:08:01 +0000 (UTC)
Date: Sun, 12 Jan 2025 20:07:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.or
Subject: Re: [REGRESSION] Re: [PATCH v7 8/8] x86/module: enable ROX caches
 for module text on 64 bit
Message-ID: <20250112190755.GCZ4QTC01KzoZkxel9@fat_crate.local>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-9-rppt@kernel.org>
 <Z4QM_RFfhNX_li_C@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4QM_RFfhNX_li_C@intel.com>
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 08:42:05PM +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Wed, Oct 23, 2024 at 07:27:11PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >=20
> > Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> > text allocations on 64 bit.
>=20
> Hi,
>=20
> This breaks resume from hibernation on my Alderlake laptop.
>=20
> Fortunately this still reverts cleanly.

Does that hunk in the mail here fix it?

https://lore.kernel.org/all/Z4DwPkcYyZ-tDKwY@kernel.org/

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

