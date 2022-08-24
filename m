Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF059FD5F
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiHXOhh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiHXOhg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 10:37:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724171712;
        Wed, 24 Aug 2022 07:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D01B9CE23A9;
        Wed, 24 Aug 2022 14:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6F4C433C1;
        Wed, 24 Aug 2022 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661351851;
        bh=wODvs7Qwt6y9wU3rWEhCOth9/kK2ZaKWLEwlW6cqugs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTSy/wiW6IRU2nk20u5olWq+0W4JhgtjBHvItxDIgGVhiE88GADHn25WCMR4e/Ewa
         MRub8GZJswxXzicC5XPVQ1LhD9tsnxa3z1ZwcIsW+GCpMoF+s7rP5/cUDBrFbt1DK6
         35VtjcdK/+ECFKS7IFT0vEW/XwOw6l8jAxJGLBSs5nPp1nq8T3QlSfzBXY+GBUrb2/
         bGx2madNOt0f1yua05s5UehStMz1IDQKnlHgZbbtSiG7pzoQUreYkHT3uXNypblfHY
         OcpYvHn5IsnHWzMs/wBGzS1srW5tO3lYBIfeKXDx3XjFaPOQFEXAZXFOf9qtf0RVso
         sbCvLH6NESSKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 061AC404A1; Wed, 24 Aug 2022 11:37:28 -0300 (-03)
Date:   Wed, 24 Aug 2022 11:37:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luna Jernberg <droidbittin@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Message-ID: <YwY3qEa2gFsPg2jz@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
 <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:
> The Nvidia driver breaks

How? What are the messages?

Here is a test on an Archlinux container:

[perfbuilder@758097c04011 dwarves-1.24]$ pahole --version
v1.24
[perfbuilder@758097c04011 dwarves-1.24]$ cat /etc/os-release
NAME="Arch Linux"
PRETTY_NAME="Arch Linux"
ID=arch
BUILD_ID=rolling
VERSION_ID=TEMPLATE_VERSION_ID
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://archlinux.org/"
DOCUMENTATION_URL="https://wiki.archlinux.org/"
SUPPORT_URL="https://bbs.archlinux.org/"
BUG_REPORT_URL="https://bugs.archlinux.org/"
LOGO=archlinux-logo
[perfbuilder@758097c04011 dwarves-1.24]$ pahole list_head
struct list_head {
	struct list_head *         next;                 /*     0     8 */
	struct list_head *         prev;                 /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};
[perfbuilder@758097c04011 dwarves-1.24]$ pahole --sizes | sort -k2 -nr | head
rcu_state	300608	7
cmp_data	290904	1
dec_data	274520	1
cpu_entry_area	241664	0
kvm	190016	6
pglist_data	173440	6
ZSTD_DCtx_s	161480	6
saved_cmdlines_buffer	131104	1
debug_store_buffers	131072	0
hid_parser	110848	1
[perfbuilder@758097c04011 dwarves-1.24]$
 
> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Wed, Aug 24, 2022 at 03:23:29PM +0200, Luna Jernberg escreveu:
> >> This package breaks on Arch Linux at the moment and if you are using Arch
> >> its recommended that you downgrade to 1.23
> >
> > Breaks in what sense? Can you please provide details?
> >
> > - Arnaldo
> >
> >> On Tue, Aug 23, 2022 at 1:59 AM Arnaldo Carvalho de Melo
> >> <acme@kernel.org>
> >> wrote:
> >>
> >> > Hi,
> >> >
> >> >         The v1.24 release of pahole and its friends is out, with faster
> >> > BTF generation by parallelizing the encoding part in addition to the
> >> > previoulsy parallelized DWARF loading, support for 64-bit BTF
> >> > enumeration
> >> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
> >> > based on the language that generated the objects, etc.
> >> >
> >> > Main git repo:
> >> >
> >> >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> >> >
> >> > Mirror git repo:
> >> >
> >> >    https://github.com/acmel/dwarves.git
> >> >
> >> > tarball + gpg signature:
> >> >
> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.xz
> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.bz2
> >> >    https://fedorapeople.org/~acme/dwarves/dwarves-1.24.tar.sign
> >> >
> >> >         Thanks a lot to all the contributors and distro packagers,
> >> > you're
> >> > on the
> >> > CC list, I appreciate a lot the work you put into these tools,
> >> >
> >> > Best Regards,
> >> >
> >> > BTF encoder:
> >> >
> >> > - Add support to BTF_KIND_ENUM64 to represent enumeration entries with
> >> >   more than 32 bits.
> >> >
> >> > - Support multithreaded encoding, in addition to DWARF multithreaded
> >> >   loading, speeding up the process.
> >> >
> >> >   Selected just like DWARF multithreaded loading, using the 'pahole -j'
> >> >   option.
> >> >
> >> > - Encode 'char' type as signed.
> >> >
> >> > BTF Loader:
> >> >
> >> > - Add support to BTF_KIND_ENUM64.
> >> >
> >> > pahole:
> >> >
> >> > - Introduce --lang and --lang_exclude to specify the language the
> >> >   DWARF compile units were originated from to use or filter.
> >> >
> >> >   Use case is to exclude Rust compile units while aspects of the
> >> >   DWARF generated for it get sorted out in a way that the kernel
> >> >   BPF verifier don't refuse loading the BTF generated from them.
> >> >
> >> > - Introduce --compile to generate compilable code in a similar fashion
> >> > to:
> >> >
> >> >    bpftool btf dump file vmlinux format c > vmlinux.h
> >> >
> >> >   As with 'bpftool', this will notice type shadowing, i.e. multiple
> >> > types
> >> >   with the same name and will disambiguate by adding a suffix.
> >> >
> >> > - Don't segfault when processing bogus files.
> >> >
> >
> > --
> >
> > - Arnaldo
> >

-- 

- Arnaldo
