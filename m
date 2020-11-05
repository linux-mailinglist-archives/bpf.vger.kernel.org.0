Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216662A872B
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgKET2a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:28:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50283 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgKET23 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 14:28:29 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 31C695C019E;
        Thu,  5 Nov 2020 14:28:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 14:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=ehC9x8cE+ZGBKrco
        BMypR8Z8YvOTab6tJ2SFOzXL27c=; b=buYHyesk/b1Nhdb3//UKsAarJZURlfHZ
        F/wV+7xwvlPad2CqI+XXEJnwDwSfBbfK2clyrsERL8ja10WrEXyyxd98z8s1Mxot
        Vu+59CRVUrfL7JW0TBVtsIXlrxz0uimzHQvG+V3SyJ637ixDFLGGTtFyDj+KipWz
        AliPeqzttPrA46IfN258rVjpBByFqIS3Ve6mk6Mqo7WKj0T6i/IqiEZt/vaSEiXO
        FV46HiL89z2Ctv8MmL0kKK0UxOodkkG/bOQ8Kx+6HnhJLj6s6OpEj37pjGQCwuBd
        F1sE/Sx518OcZf5sbjfPPyuEfrcJE0vuXJmdKN5tL9TzgqdLjpndgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ehC9x8cE+ZGBKrcoBMypR8Z8YvOTab6tJ2SFOzXL27c=; b=IwHq6wkE
        aW6yx9Kk0ROQy4/bAVB7oW7ygq4wCpa49jISgt1REXVjVtDAnAaHGLU+OHkHmQyA
        aaEsKYOAkeWYdHHghbztFpegJxbeRVv8OHVnUouiaWV2kVrOGYCKzWfgsVICO1uD
        NOZ0U3DeTuYmt0+R70PQ5ryPgIZqP3XNOqSRhtWbiLULcaHJzOsMgpaOeO0l3vJC
        oC1BEAubWbEMw2MVtnkjy9avgEcvv60tAXDA6F2Y7PAy7JN78Eaz0NcGWfj37H5I
        cA5tfRw/BPm8x6WFUzyT825hBv4/cE54bUZpwyeqdeGQii2kddAqOKWt6cIRkZLy
        P0AjlnqCUwATUQ==
X-ME-Sender: <xms:XFKkX9hdQMI0JlDIV47qm2GjcfbitBLRBFsHWNB6qFYYdZZWyIanqg>
    <xme:XFKkXyAhzqTWZ2hF_zg4sb5HIgfggB9MVSmKteqrNOrmKVmUQtT3-TYEdMnwXekoz
    UXCUWaW6i4bl24Gwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgfuhffvfffkjgesthhqredttddt
    jeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeejfefhudeffefhjedvvefhheduledtueejvedugedvjedv
    jeeljefggedtjeejveenucfkphepieelrddukedurddutdehrdeigeenucevlhhushhtvg
    hrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:XFKkX9EyZ56_iKftZqdQ8QKqFz37Bg5bcGCUKX4siOwcyNuVR4DKhw>
    <xmx:XFKkXyTVJ4WNETLx7KONsIwT5QR3sBudUBSA9ePVLy4Z8VaP21M2wg>
    <xmx:XFKkX6zc52yQnedW6cCdyOQQImlFz19Pyu0yFac0JYNFPmVgfIZ0EA>
    <xmx:XFKkX-_iwjte-7ikeuNZ7dOsTOZjcGA7Ya22JO17QPvpXYdDP7vt1A>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F22D3060060;
        Thu,  5 Nov 2020 14:28:27 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "bpf" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy
 bytes after NUL terminator
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <songliubraving@fb.com>
Date:   Thu, 05 Nov 2020 11:28:11 -0800
Message-Id: <C6VKTIUUWPD0.2INCG5OQMYVNJ@maharaja>
In-Reply-To: <CE6BCF1F-2112-40DC-87C8-91FA2D6C86FC@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 5, 2020 at 10:16 AM PST, Song Liu wrote:
>
>
> > On Nov 4, 2020, at 6:25 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
> >=20
> > do_strncpy_from_user() may copy some extra bytes after the NUL
>
> We have multiple use of "NUL" here, should be "NULL"?
>
> > terminator into the destination buffer. This usually does not matter fo=
r
> > normal string operations. However, when BPF programs key BPF maps with
> > strings, this matters a lot.
> >=20
> > A BPF program may read strings from user memory by calling the
> > bpf_probe_read_user_str() helper which eventually calls
> > do_strncpy_from_user(). The program can then key a map with the
> > resulting string. BPF map keys are fixed-width and string-agnostic,
> > meaning that map keys are treated as a set of bytes.
> >=20
> > The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> > terminator, it can result in seemingly identical strings occupying
> > multiple slots in a BPF map. This behavior is subtle and totally
> > unexpected by the user.
> >=20
> > This commit uses the proper word-at-a-time APIs to avoid overcopying.
> >=20
> > Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read=
_{user, kernel}_str helpers")
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> > lib/strncpy_from_user.c | 9 +++++++--
> > 1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> > index e6d5fcc2cdf3..d084189eb05c 100644
> > --- a/lib/strncpy_from_user.c
> > +++ b/lib/strncpy_from_user.c
> > @@ -35,17 +35,22 @@ static inline long do_strncpy_from_user(char *dst, =
const char __user *src,
> > 		goto byte_at_a_time;
> >=20
> > 	while (max >=3D sizeof(unsigned long)) {
> > -		unsigned long c, data;
> > +		unsigned long c, data, mask, *out;
> >=20
> > 		/* Fall back to byte-at-a-time if we get a page fault */
> > 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time)=
;
> >=20
> > -		*(unsigned long *)(dst+res) =3D c;
> > 		if (has_zero(c, &data, &constants)) {
> > 			data =3D prep_zero_mask(c, data, &constants);
> > 			data =3D create_zero_mask(data);
> > +			mask =3D zero_bytemask(data);
> > +			out =3D (unsigned long *)(dst+res);
> > +			*out =3D (*out & ~mask) | (c & mask);
> > 			return res + find_zero(data);
> > +		} else  {
>
> This else clause is not needed, as we return in the if clause.

Thanks, will change in v3.

[..]
