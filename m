Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2411569536A
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 22:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBMVxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 16:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBMVxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 16:53:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F113D47;
        Mon, 13 Feb 2023 13:53:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0F166130D;
        Mon, 13 Feb 2023 21:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9F6C433A8;
        Mon, 13 Feb 2023 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676325230;
        bh=e8dQo3F0EIPQ9ZETyfBUQ97sr1WZutIWag6P8qcCbCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2CymvjCgODR3hdwfvcE/OJk3Zd+CEMEv0lnAXYlMlpusd4fdH7fY8lSj7bnROMr3
         YpQkgxLSWUetu0QhOURxgd3Hvq0qxHADD22uhr/T7ThSWBc5Cu5Gzzd6lOZsb5mjw2
         dKcEtTLOr+u8Nad/eZ3WjHbGAq7zH13UC8P4F0IYEEdC86LslXKSNAJhfvEcCn3CRm
         VW+qF4j+HxAEMJhf9Tz7wFi9yQQsjQSGIowI0s+8VFYSwSEJWjP+FYcg2/Gf/HsfWT
         4QdpslFCS6sxb31rYbW7r4Bk3WMPbRJO+I+w/XT+9B3riLhpi7S02rtOyygY6Vc8p9
         b6vi66WFzrYOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC7EF40025; Mon, 13 Feb 2023 18:53:46 -0300 (-03)
Date:   Mon, 13 Feb 2023 18:53:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
Message-ID: <Y+qxas4DsaO8nUze@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
 <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org>
 <Y+oofL/aJmUjcxIR@kernel.org>
 <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
 <CAOgh=FzBjR7V+sQOy2OEV+YXxB0_YzapNTO+-Xf3uGnLfA0Vxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FzBjR7V+sQOy2OEV+YXxB0_YzapNTO+-Xf3uGnLfA0Vxw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 13, 2023 at 12:53:38PM +0000, Eric Curtin escreveu:
> On Mon, 13 Feb 2023 at 12:45, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Hi Arnaldo,
> >
> > On Mon, Feb 13, 2023 at 1:09 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > The namespace.o seems to be ok:
> >
> > I saw the other message too -- this looks great, thanks a ton.
> >
> > > The core one needs work:
> >
> > If `core.o` works, then I think it is likely other things will work :)
> 
> Hi Guys,
> 
> I'll leave this to the experts, but if we get this to the point where
> we are happy to enable again for Rust CUs, could we request another
> version bump? It just makes it easier to integrate with the kernel

Sure, as we improve the support for encoding BTF from DWARF generated
for Rust code, and the subset that is used in the kernel is handled, we
will just adjust scripts/pahole-flags.sh to skip Rust DWARF if the
version is >= the version where excluding DWARF generated from some
languages (Rust in this case) but < the version where we're confortable
with generating BTF for Rust DWARF.

- Arnaldo

> scripts when we want to enable again.
> 
> >
> > I can try to extract the cases for those into simpler `.o` files, if
> > you would find simpler test cases useful (perhaps for the test suite
> > etc.).
> >
> > Cheers,
> > Miguel
> >
> 

-- 

- Arnaldo
