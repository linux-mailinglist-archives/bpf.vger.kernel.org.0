Return-Path: <bpf+bounces-46078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55A9E3F49
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AF116740A
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230A2941C;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sb07Ij3h"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36E156962
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328393; cv=none; b=mYPufyLcQ9QzgnbrKPe75RKSITeDlYF2CR9dGsGJv9hDFxIjhxzBfZZUZ9/EHcMtlItYCJHSLR1vXy/wYTEIkT5VBZysBOMlL2zuuLRg0u7H6JMOJPyZg5leqS8dBgmtnzSZSxcgZOH/HOeOtzp/fLACDSEAjDIGUOCddNnR8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328393; c=relaxed/simple;
	bh=6Mefh2bIasJ0HBEWDvmJA6IiRjdrnLHOwbatAIva3PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgmh3fkRECri/inUv+O1z7IoHvuxd+R9VqrlYdi+35idRlNiYvG9mTRKhJOWeFU9FaBcbF6DIiD/G3XI8UO5NJc2BIuPc5fsCXLrRUs39Ycmc5k7rfnAtVMilafQMwSIGpteDwNq9rSCX2RRqkXVvggGgXdAd59y2GQJdan5IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sb07Ij3h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bhj8LYO2k2u8HrLPuYVcO19yxTO8d3XXre2ihzyGvGI=; b=Sb07Ij3h2rhhrzTfaVqs0MlCqS
	Q6vgaAOL12+WaIXg343RiurOYq3KUPaZ9P1M8r5mhsUWJ2rXoYk292dG3WvfuAzNTGu07jm1xBMRx
	iF6SlI0NFjYnCiVg7u+ZlCM2MTyRJ4USaQR4HSJc0fuOgBfpCMCcvXBYWb/Axl06ZrWZoALZfWotH
	AS6IcwAuvwWvX88GiQAJuNLtwXePYPdb++sqd8xADv/xqx7VI6MUmvTyS7ieBsQpkl9hJ1k+51J0z
	L/S9z70wn9z7JTwlvxyxUij7HnrH88bOj5LbLhMLJrwkgur4Ccz8c1tQQh0eki6xQyKEYltRRiCy1
	XFrzag5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIrtS-0003aZ-1r;
	Wed, 04 Dec 2024 16:06:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIrtR-0005fL-0q;
	Wed, 04 Dec 2024 16:06:25 +0000
Date: Wed, 4 Dec 2024 16:06:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: John Garry <john.g.garry@oracle.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: arm allmodconfig build issue with bpf
Message-ID: <Z1B-AVPdkMiSyY-H@shell.armlinux.org.uk>
References: <9950a25d-1a79-42c9-ade7-dc51ef569ad2@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9950a25d-1a79-42c9-ade7-dc51ef569ad2@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 03:54:30PM +0000, John Garry wrote:
> Hi all,
> 
> For some time, the arm allmodconfig build has had this following build issue
> for me:
> 
> $ make net/bpf/test_run.o
>   CALL    scripts/checksyscalls.sh
>   CC      net/bpf/test_run.o
> net/bpf/test_run.c:522:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   522 | {
>       | ^
> net/bpf/test_run.c:568:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   568 | {
>       | ^
> net/bpf/test_run.c:577:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   577 | {
>       | ^
> net/bpf/test_run.c:584:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   584 | {
>       | ^
> net/bpf/test_run.c:590:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   590 | {
>       | ^
> net/bpf/test_run.c:619:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   619 | {
>       | ^
> net/bpf/test_run.c:624:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   624 | {
>       | ^
> net/bpf/test_run.c:630:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   630 | {
>       | ^
> net/bpf/test_run.c:634:1: error: ‘retain’ attribute ignored
> [-Werror=attributes]
>   634 | {
>       | ^
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:194: net/bpf/test_run.o] Error 1
> make[3]: *** [scripts/Makefile.build:440: net/bpf] Error 2
> make[2]: *** [scripts/Makefile.build:440: net] Error 2
> make[1]: *** [/home/ubuntu/mnt/linux2/Makefile:1989: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> ubuntu@jgarry-ubuntu-bm5-instance-20230215-1843:~/mnt/linux2$
> 
> The issue comes the definition of __bpf_kfunc from include/linux/btf.h

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99587

seems relevant. Jakub's reply in comment 3 suggests that:

#if __has_attribute(__retain__) && \
        (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
         defined(CONFIG_LTO_CLANG))
# define __retain                       __attribute__((__retain__))
#else
# define __retain
#endif

is wrong - __has_attribute(__retain__) doesn't mean that GCC supports
__retain__, it only means that it "knows" about it but may still
reject it.

The nice thing about this bug is... it's remained "NEW" for three
years already, so likely means that it remains unfixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

