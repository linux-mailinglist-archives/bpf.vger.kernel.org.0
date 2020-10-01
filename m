Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6A27FF79
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgJAMuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 08:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731891AbgJAMuc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 08:50:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91801206A5;
        Thu,  1 Oct 2020 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601556631;
        bh=VmDTQnnsb1OeZLfqcAZkCqwIGfY1Ci1mLCa6AdNP3ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlwdFLULUR8D3ZqpzDGl0CuhQByrMNsVrWZZGGae5orXo2VIps83gzCl6qr/F9+y5
         9BCGUozpfcNgmarbPhSKjOv87pL9jA8hqsieblbTfBpE+g4m2Rx9ItPGXnKTS+J2n0
         LhMYc0Ke3iU0nKa4YaWOksvvwXwUb0OZnNLro1Ao=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBFFD410FA; Thu,  1 Oct 2020 09:50:29 -0300 (-03)
Date:   Thu, 1 Oct 2020 09:50:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: BTF without CONFIG_DEBUG_INFO_BTF=y
Message-ID: <20201001125029.GE3169811@kernel.org>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
 <87h7rejkwh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7rejkwh.fsf@toke.dk>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 01, 2020 at 12:33:18PM +0200, Toke Høiland-Jørgensen escreveu:
> Kevin Sheldrake <Kevin.Sheldrake@microsoft.com> writes:
> 
> > Hello
> >
> > I've seen mention a few times that BTF information can be made
> > available from a kernel that wasn't configured with
> > CONFIG_DEBUG_INFO_BTF. Please can someone tell me if this is true and,
> > if so, how I could go about accessing and using it in kernels 4.15 to
> > 5.8?
> >
> > I have built the dwarves package from the github latest and run pahole
> > with '-J' against my kernel image to no avail - it actually seg
> > faults:
> >
> > ~/dwarves/build $ sudo ./pahole /boot/vmlinuz-5.3.0-1022-azure
> > btf_elf__new: cannot get elf header.
> > ctf__new: cannot get elf header.
> > ~/dwarves/build $ sudo ./pahole -J /boot/vmlinuz-5.3.0-1022-azure
> > btf_elf__new: cannot get elf header.
> > ctf__new: cannot get elf header.
> > Segmentation fault
> > ~/dwarves/build $ sudo ./pahole --version
> > v1.17
> >
> > Judging by the output, I'm guessing that my kernel image isn't the
> > right kind of file. Can someone point me in the right direction?
> 
> vmlinuz is a compressed image. There's a script in the kernel source
> tree (scripts/extract-vmlinux), however the kernel image in /boot/
> probably also has debug information stripped from it, so that likely
> won't help you. You'll need to get hold of a kernel image with debug
> information still intact somehow...
> 
> (Either way, pahole shouldn't be segfaulting, so hopefully someone can
> take a look at that).

Reproduced:

[acme@five pahole]$ cp /boot/vmlinuz-5.9.0-rc6+ .
[acme@five pahole]$ pahole -J vmlinuz-5.9.0-rc6+
btf_elf__new: cannot get elf header.
ctf__new: cannot get elf header.
tag__check_id_drift: subroutine_type id drift, core_id: 1145, btf_type_id: 1143, type_id_off: 0
pahole: type 'vmlinuz-5.9.0-rc6+' not found
libbpf: Unsupported BTF_KIND:0
btf_elf__encode: btf__new failed!
free(): double free detected in tcache 2
Aborted (core dumped)
[acme@five pahole]$

Working on a fix. Thanks for the report!

- Arnaldo
