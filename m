Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6940D302FA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfE3TtA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 15:49:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33763 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3TtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 15:49:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hWR2n-0005UK-Dh; Thu, 30 May 2019 20:48:57 +0100
Message-ID: <1559245735.24330.6.camel@codethink.co.uk>
Subject: Re: [stable] bpf: add bpf_jit_limit knob to restrict unpriv
 allocations
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        stable <stable@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Date:   Thu, 30 May 2019 20:48:55 +0100
In-Reply-To: <20190530173100.GA23688@kroah.com>
References: <1558994144.2631.14.camel@codethink.co.uk>
         <1559236680.24330.5.camel@codethink.co.uk>
         <20190530173100.GA23688@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2019-05-30 at 10:31 -0700, Greg Kroah-Hartman wrote:
> On Thu, May 30, 2019 at 06:18:00PM +0100, Ben Hutchings wrote:
> > On Mon, 2019-05-27 at 22:55 +0100, Ben Hutchings wrote:
> > > Please consider backporting this commit to 4.19-stable:
> > > 
> > > commit ede95a63b5e84ddeea6b0c473b36ab8bfd8c6ce3
> > > Author: Daniel Borkmann <daniel@iogearbox.net>
> > > Date:   Tue Oct 23 01:11:04 2018 +0200
> > > 
> > >     bpf: add bpf_jit_limit knob to restrict unpriv allocations
> > > 
> > > No other stable branches are affected by the issue.
> > 
> > Actually that's wrong; the commit introducing this was backported to
> > 4.4, 4.9, and 4.14.  I haven't yet checked whether this fix applies
> > cleanly to them.
> 
> It doesn't apply cleanly to those trees :(

OK, then I'll try backporting it at some point.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
