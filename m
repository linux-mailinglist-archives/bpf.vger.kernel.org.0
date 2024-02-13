Return-Path: <bpf+bounces-21820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A064385270D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25C01C25850
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08622097;
	Tue, 13 Feb 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABxGmm4z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5B2230F;
	Tue, 13 Feb 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788623; cv=none; b=Y8rJNVBfLJO+KGWq2MFU8eNoJ0rBrBwafqEY1Nz84AOBSlZddpzNKqG3o/q9MQnhO5goj3twOAQTNHV7CNGJpVNCU8Vc3wewuSobJHw2kJfMn/7JD7HszOhjJMd3gJlYBgmLEySvuzhzVknad7O3sBYoaI4Shp/ra1vPiKVWZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788623; c=relaxed/simple;
	bh=t8TXcZ6NhQgxyBUbvrpf5ZlhAgGpNr73upNRAj1P3Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SITirq/S7x53fzuI0FKPKb6oAo/FPIyoWuVhseEeOgmuLhiMHFWFed2NGspgaMokUeNxM8scAQtxK5e5BUlBwtf0X4yfCZLHHJBidPdaJEvkxSg+/JHzJKJrk9f1bRcJE94wa+7ND1T8+pQIj4yWbrQYiaoDfLmlOko1K89aH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABxGmm4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EB1C43390;
	Tue, 13 Feb 2024 01:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788622;
	bh=t8TXcZ6NhQgxyBUbvrpf5ZlhAgGpNr73upNRAj1P3Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABxGmm4zwRbmkkt8nLZgz90d34z4u1wyOIvnabnHBQ7uLt9TgcPcHnzBPbtr1/pdY
	 xSmOkXCWyfYvthnRfWyFbbMrHyTCCMT9gExsSv1uaN5mmCLnDj6wzyjPg5a9xerfmA
	 1TkzE/4/vyT3zrX4MbyaqkOGnlOY/XnFgv9mLzyY2r+R85z4O6AbJGY9lY046mQY2F
	 QnfQyHVDMa1Hc2mbGMIVTA1HTK4U+rhfI7N/NPsfYrwXF746oFZF94Sb3ojALkEOw6
	 kItDaxa5/rMY8C8qL8J1+to1Uzq8zGOaInTvDIREREpisjsp2AL9ZYJmyj11fstlpW
	 vlb0/sMEZUQ4A==
Date: Mon, 12 Feb 2024 18:43:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, keescook@chromium.org, maskray@google.com,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
Message-ID: <20240213014340.GA3329682@dev-arch.thelio-3990X>
References: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
 <CAK7LNAT1+K87M2f_8enCydaKgDPLP9E1ex-as85eC2hB49bkBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAT1+K87M2f_8enCydaKgDPLP9E1ex-as85eC2hB49bkBA@mail.gmail.com>

On Tue, Feb 13, 2024 at 09:55:07AM +0900, Masahiro Yamada wrote:
> On Fri, Feb 9, 2024 at 5:21 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> > changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
> > dd, which works fine for little endian platforms:
> >
> >    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
> >   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
> 
> I am afraid this dump is confusing.
> 
> The byte stream "03 00" is ET_DYN, as specified in ELF:
> 
>   Name        Value
>   ------------------
>   ET_REL        1
>   ET_EXEC       2
>   ET_DYN        3
> 
> It disagrees with your commit message "from ET_EXEC to ET_REL"
> 
> The dump for the old ELF was "02 00", wasn't it?

No, I have not manually edited or changed these diffs from hexdumping
the .o files. The little endian one was from arm64 and the big endian
one was from s390. Perhaps this is some difference between the
toolchains? I don't recall which one I used in this case, pretty sure it
was GNU though. I can just remove "from ET_EXEC" from the commit message
if that would help make it less confusing.

> >   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
> >
> > However, for big endian platforms, it changes the wrong byte, resulting
> > in an invalid ELF file type, which ld.lld rejects:
> 
> Fangrui pointed out this is true for inutils >= 2.35

Not for this particular error, which occurs because e_type is not a
valid value. If it was true for binutils, we would have seen this issue
sooner.

> >
> >    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
> >   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> >   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> 
>  -  00 02
>  +  01 02

See above.

> >
> >   Type:                              <unknown>: 103
> >
> >   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
> >
> > Fix this by using a different seek value for dd when targeting big
> > endian, so that the correct byte gets changed and everything works
> > correctly for all linkers.
> >
> >    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
> >   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> 
> Ditto.

See above.

> >   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> >
> >   Type:                              REL (Relocatable file)
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> > Link: https://github.com/llvm/llvm-project/pull/75643
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  scripts/link-vmlinux.sh | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..8a9f48b3cb32 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -135,8 +135,15 @@ gen_btf()
> >         ${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
> >                 --strip-all ${1} ${2} 2>/dev/null
> >         # Change e_type to ET_REL so that it can be used to link final vmlinux.
> > -       # Unlike GNU ld, lld does not allow an ET_EXEC input.
> > -       printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
> > +       # Unlike GNU ld, lld does not allow an ET_EXEC input. Make sure the correct
> > +       # byte gets changed with big endian platforms, otherwise e_type may be an
> > +       # invalid value.
> > +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> > +               seek=17
> > +       else
> > +               seek=16
> > +       fi
> > +       printf '\1' | dd of=${2} conv=notrunc bs=1 seek=${seek} status=none
> >  }
> >
> >  # Create ${2} .S file with all symbols from the ${1} object file
> 
> Do you want to send v2 to update the commit description?
> 

I don't think a v2 is necessary for the commit description...

> The current code will work, but another approach might be to
> update both byte 16 and byte 17 because e_type is a 16-bit field.
> 
> It works without relying on the MSB of the previous e_type being zero.
> The comment does not need updating because the intention is obvious
> from the code.
> 
> if is_enabled CONFIG_CPU_BIG_ENDIAN; then
>         et_rel='\0\1'
> else
>         et_rel='\1\0'
> fi
> 
> printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none

but I do like this suggested change because I was thinking that updating
the single bit could be fragile at some point. I'll send a v2 with that
and a slightly updated commit message shortly. Because it is
substantially different from v1, I won't carry forward all the tags I
received but I hope people will take a look at v2 and provide them
again.

Thanks a lot for taking a look!
Nathan

