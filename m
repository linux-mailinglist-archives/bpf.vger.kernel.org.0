Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2075C31112B
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhBERpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 12:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhBERnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 12:43:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E95164DDD;
        Fri,  5 Feb 2021 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612553090;
        bh=Wkmdeu84GqsJBxdIKescV+S5TnRP000aL5aQE0iDgkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0piSSUG09Rg5VbPykiphfcgLW5uZlIwNSsVKEHVTKoRYslMmzbPRdlB9LYGqVcXj
         n2gSnUf78Q5LL2ojCeQfBlBOZ8RpK350oV+z38Af3bFRwxYVp2q+P2wKPejewW83oS
         hzZDMsZ1cbHIqsRVN14A/dXCch7rhJs6EhO3f2s8mEvvF0M1CcFV3KgKT62m8eATie
         oG6Cg4HF9LGaWfS0S+VqS1E/04zrs2NV3j1Rh9nfNf1gB9M82PuF5pJb/l8RYVzogS
         hdO98xV267PbqMSj66hUDaFBmGRAm9Z8Qyn2Dlf0BS2BaNrryOrL2s1RGJ4karf5C4
         9kybbTER1Svqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE33940513; Fri,  5 Feb 2021 16:24:46 -0300 (-03)
Date:   Fri, 5 Feb 2021 16:24:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     sedat.dilek@gmail.com,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
Message-ID: <20210205192446.GH920417@kernel.org>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> > On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > Grepping through linux.git/tools I guess some BTF tools/libs need to
> > know what BTF_INT_UNSIGNED is?
 
> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> ignore this for now until kernel infrastructure is ready.

Yeah, I thought about doing that.

> Not sure whether this information will be useful or not
> for BTF. This needs to be discussed separately.

Maybe search for the rationale for its introduction in DWARF.

- ARnaldo
