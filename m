Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487928020E
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgJAPDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 11:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgJAPDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 11:03:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31D420780;
        Thu,  1 Oct 2020 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601564588;
        bh=tndLqBxrIDxlHmkQX8x4jK0/dSkmgzoyYAdf86KUqHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Piwp4g2pZ2HzhNYHwySvAuiDutspgnA5MK0d9n8XVmnSrW6oDvuE1Vf82T5z0ncKp
         gyLPs8ZWvEM6Ou+YdIIvNr/PvU4opTqXrqNo1jUTKDgC2VL/YI6igleKTV5tpG1jqB
         a5ghUEnNML3a5EfSBUdNAXoOHCDKLXFyscoD7b9g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9124403AC; Thu,  1 Oct 2020 12:03:04 -0300 (-03)
Date:   Thu, 1 Oct 2020 12:03:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: BTF without CONFIG_DEBUG_INFO_BTF=y
Message-ID: <20201001150304.GA18693@kernel.org>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
 <87h7rejkwh.fsf@toke.dk>
 <20201001125029.GE3169811@kernel.org>
 <20201001132250.GF3169811@kernel.org>
 <87v9fuhxt9.fsf@toke.dk>
 <VI1PR83MB025405E9346E8EA4C0459428FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR83MB025405E9346E8EA4C0459428FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 01, 2020 at 01:45:25PM +0000, Kevin Sheldrake escreveu:
> > Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> SNIP
> > >     Reported-by: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> > >     Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> > Yeah, that's much better!

> > Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>

> Thank you to Arnaldo for identifying and fixing the seg fault.
 
> Am I right in thinking that pahole can't work on a standard
> out-of-the-box distro such as Ubuntu 16.04 (v4.15) or 18.04 (v5.3/5.4)
> as debugging information isn't available in the kernel, and equally
> isn't available anywhere else, without recompiling it?

You mean recompiling the kernel with debug info? 

You just have to install de debuginfo packages, that in Ubuntu is
different than in Fedora but in the end is just the same principle: you
have matching separate debug info files for each kernel released by the
distro, please take a look at:

https://wiki.ubuntu.com/Debug%20Symbol%20Packages

There is also a page for Systemtap where it states the steps
specifically for the kernel debug symbol packages:

https://wiki.ubuntu.com/Kernel/Systemtap

This part:

codename=$(lsb_release -c | awk  '{print $2}')
sudo tee /etc/apt/sources.list.d/ddebs.list << EOF
deb http://ddebs.ubuntu.com/ ${codename}      main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-security main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-updates  main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-proposed main restricted universe multiverse
EOF

sudo apt-get update
sudo apt-get install linux-image-$(uname -r)-dbgsym

Also make sure you have the dwarves package installed, if you haven't
built it from sources as Toke suggested, as below, but then,
ubuntu:18.04 has a way too old version of pahole/dwarves, 1.10, so build
it from sources to have the BTF support and many other goodies.

I just checked and ubuntu:19.10 has dwarves 1.15, that is not enough,
1.16 is what the kernel expects to generate BTF:

[acme@five perf]$ grep "pahole version" scripts/*.sh
scripts/link-vmlinux.sh:		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
[acme@five perf]$

- Arnaldo

[perfbuilder@five ~]$ podman run --rm -ti ubuntu:18.04
root@f9beca14daaf:/# bash
root@f9beca14daaf:/# apt-get update
Get:1 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]
Get:2 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
Get:3 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
Get:4 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [14.6 kB]
Get:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]                     
Get:6 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [1337 kB]
Get:7 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]  
Get:8 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB]
Get:9 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]          
Get:10 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [193 kB]
Get:11 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [1693 kB]     
Get:12 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]                 
Get:13 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [2110 kB]
Get:14 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [2099 kB]
Get:15 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [220 kB]
Get:16 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [44.6 kB]
Get:17 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [11.4 kB]
Get:18 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [11.3 kB]
Fetched 21.1 MB in 6s (3778 kB/s)                             
Reading package lists... Done
root@f9beca14daaf:/# apt-get install dwarves
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libdw1 libelf1
The following NEW packages will be installed:
  dwarves libdw1 libelf1
0 upgraded, 3 newly installed, 0 to remove and 15 not upgraded.
Need to get 393 kB of archives.
After this operation, 2086 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 libelf1 amd64 0.170-0.4ubuntu0.1 [44.8 kB]
Get:2 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 libdw1 amd64 0.170-0.4ubuntu0.1 [203 kB]
Get:3 http://archive.ubuntu.com/ubuntu bionic/universe amd64 dwarves amd64 1.10-2.1build1 [145 kB]
Fetched 393 kB in 2s (233 kB/s)  
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libelf1:amd64.
(Reading database ... 4046 files and directories currently installed.)
Preparing to unpack .../libelf1_0.170-0.4ubuntu0.1_amd64.deb ...
Unpacking libelf1:amd64 (0.170-0.4ubuntu0.1) ...
Selecting previously unselected package libdw1:amd64.
Preparing to unpack .../libdw1_0.170-0.4ubuntu0.1_amd64.deb ...
Unpacking libdw1:amd64 (0.170-0.4ubuntu0.1) ...
Selecting previously unselected package dwarves.
Preparing to unpack .../dwarves_1.10-2.1build1_amd64.deb ...
Unpacking dwarves (1.10-2.1build1) ...
Setting up libelf1:amd64 (0.170-0.4ubuntu0.1) ...
Setting up libdw1:amd64 (0.170-0.4ubuntu0.1) ...
Setting up dwarves (1.10-2.1build1) ...
Processing triggers for libc-bin (2.27-3ubuntu1.2) ...
root@f9beca14daaf:/#

- Arnaldo
