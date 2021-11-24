Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAF45CBB7
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 19:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbhKXSEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 13:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241542AbhKXSEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 13:04:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AEDC60FD9;
        Wed, 24 Nov 2021 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637776886;
        bh=wanx4a0c3he/yW/G8jdrXADz/DLKAo8Cw5+FuVygMTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlH9G0pC7NDqB0pLh5iRB9ihMk9S9yKJw5NIcZMTnHModNufyUn5KccDDwaHcDfEj
         VBDJPTYCavX6YsBU+vtODzJhQXFCSRARm+dyFlVl2NpZl276WsNvS0cNue2Oz4ATn+
         Pe5GJyLZUQExNfS+cgKu/sEMxX1WSkMCQJMqN4To=
Date:   Wed, 24 Nov 2021 19:01:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: bpf mailing list archive
Message-ID: <YZ5988RpWezAi9Yq@kroah.com>
References: <CAK3+h2zzrwv=S=CmgVo2e4Hubw8nvzbFhvpgyTiUh87O6APZrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3+h2zzrwv=S=CmgVo2e4Hubw8nvzbFhvpgyTiUh87O6APZrg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 09:38:05AM -0800, Vincent Li wrote:
> Hi,
> 
> I find it hard read bpf mailing list archive from
> https://lore.kernel.org/bpf/, I don't have specific old email archive
> subject to read, just want to read some random old bpf email for
> learning, had to click older/next at the bottom of page, can't go back
> in specific month/year range, is it possible to archive the bpf
> mailing list in https://marc.info/, I find it useful :)

Clone the list from lore as instructed at the bottom of the page and
then you can run tools on it to get your own local archive for searching
and doing whatever you want to do with it.  Highly recommended, and much
easier than trying to deal with the horrid marc.info interface.

Also, if you don't know about them, tools like mairix and mu are both
wonderful email search tools for large mailing lists, you might want to
look into them after doing your clone of the mailing list archive.

good luck!

greg k-h
