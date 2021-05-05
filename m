Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35E4374B29
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhEEWXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 18:23:21 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:57192 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhEEWXU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 18:23:20 -0400
IronPort-SDR: SlZz+qtjNJar1cuRTb3RsH2YyzRNfwRCERsi+CelErtf0Bp4FqQ01OJSEXCDBT70XCy9wZcnGV
 CpVP5ZArBBhesEl4raRJKGxmRMY3Cwe0N4CzCcIA3hg35SZGJhvm6yWoylwlAFdZHUl2uwVWgy
 FdkYI3HWLg5BDOEOVa2ykGtmamv7ax/XaVQzVhkQNdS/n1xg04k44V7Z2CPO7gqlobb/25KzUr
 77KM7Y7esxA38v0VSAL7fFdtmE15L0TeNQTu8R2LnaHhWMa2lYGNUNnwCaqwdiFyrkXOGJ9uNO
 LC0=
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="61033681"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 05 May 2021 14:22:23 -0800
IronPort-SDR: yYRQC2BGZ2EAkI+dghDlrq62ctnEzUdDXVCbEBB5v6z8SaTasrZVI5bDosiuTWtKQ2NxHxdwWc
 3oaEz2Y7c647UoXHvp0Jj2i9+uTeeFU1nNVPEyxqSbzUptTVOede61SgQjqXAIbOkz6stZVKDn
 mIPzoD9dlTOxe3+0gwdVKx2TfSeRTKAuPj/prdhV8xBVRK9GeA3DHNoj16s0xugWhT0J5x8xoZ
 cXwQBuJ8n5lEUZvbfkJnbYidEW5iYccXWAiDJhogWxOLWMfHI0nrP95kZXqh7LHnNFKdajOksb
 CZc=
Date:   Wed, 5 May 2021 22:22:18 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     David Laight <David.Laight@ACULAB.COM>
CC:     'Florian Weimer' <fweimer@redhat.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GCC <gcc-patches@gcc.gnu.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        glibc <libc-alpha@sourceware.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: RE: [RFC v2] bpf.2: Use standard types and attributes
In-Reply-To: <a17b3a3c7eff46829666d2b07adda0be@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.22.394.2105052219590.508961@digraph.polyomino.org.uk>
References: <20210423230609.13519-1-alx.manpages@gmail.com> <20210504110519.16097-1-alx.manpages@gmail.com> <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com> <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com> <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com> <6740a229-842e-b368-86eb-defc786b3658@gmail.com> <87r1imgu5g.fsf@oldenburg.str.redhat.com> <a17b3a3c7eff46829666d2b07adda0be@AcuMS.aculab.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 5 May 2021, David Laight via Libc-alpha wrote:

> > __u64 can't be formatted with %llu on all architectures.  That's not
> > true for uint64_t, where you have to use %lu on some architectures to
> > avoid compiler warnings (and technically undefined behavior).  There are
> > preprocessor macros to get the expected format specifiers, but they are
> > clunky.  I don't know if the problem applies to uint32_t.  It does
> > happen with size_t and ptrdiff_t on 32-bit targets (both vary between
> > int and long).
> 
> uint32_t can be 'randomly' either int or long on typical 32bit architectures.
> The correct way to print it is with eg "xxx %5.4" PRI_u32 " yyy".

C2X adds printf length modifiers such as "w32", so you can use a 
friendlier %w32u, for example.  (Not yet implemented in glibc or in GCC's 
format checking.)

-- 
Joseph S. Myers
joseph@codesourcery.com
