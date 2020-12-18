Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252A52DE109
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgLRKcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 05:32:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgLRKcH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 05:32:07 -0500
Date:   Fri, 18 Dec 2020 11:31:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608287486;
        bh=H+2oMPdaBm6uzckKT4AzZKea+ItnBPnlVjfUoiHdDV4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=cktprwcAG1lS3+av13kaq3oJFr7mF5fewQ0IyEgvYx25kRovxCZy6U5sml/tbyIxB
         wjE09h1rOol4j1wQRfiHZ/3AoJwSvw+97o8mmL6Ivw/zpM0WG4VVzSYdWbzhxV6VQ0
         /150jhMOqxUl4bveOrRgB3eMwA22NxtMCmbboqOM=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Meng Zhuo <mengzhuo1203@gmail.com>
Cc:     linux-api@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Please remove all bit fields in bpf uapi
Message-ID: <X9yE+hJpT73PdKjG@kroah.com>
References: <CACt3ES2LCfNDq-nskrySJjWD5EO9WCAst_+kJT7UbhYOmD+45g@mail.gmail.com>
 <X9xu2q8QFCCf70r7@kroah.com>
 <CACt3ES3NTRZF4jbCjgHybGHofNypQ3EPnYvuJi-eZZXJtonQUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACt3ES3NTRZF4jbCjgHybGHofNypQ3EPnYvuJi-eZZXJtonQUg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 18, 2020 at 05:09:58PM +0800, Meng Zhuo wrote:
> Hi, Greg
> 
> Thank you for your reply
> It's fine to do compile bit fields "by hand".

Surely Go has something like "if (field & 0x01)", right?  That's all you
need for a bitfield.

Look at the most common syscall, open(2)?  It uses bitfields, why
can't Go handle that?

> However is it possible to setup a guideline that forrbid "bit fields"
> in uapi in the future?

Where would that guideline go and who would enforce it?  :)

thanks,

greg k-h
