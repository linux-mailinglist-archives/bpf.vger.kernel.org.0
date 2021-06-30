Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED733B7D04
	for <lists+bpf@lfdr.de>; Wed, 30 Jun 2021 07:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhF3Fhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Jun 2021 01:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3Fhh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Jun 2021 01:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A6661C65;
        Wed, 30 Jun 2021 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625031309;
        bh=VBctbRohZEP0Od52mE6m6uhQBMkSeCuEYjH5LmodY+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuByqsHZKmnU5z0p9CS/OZ2VxZTBlFj6nDRgsR0M/C/jASN/WsMuo1tUBNfa9E8wy
         9n6p7e8QiGl9O+PLSp3+P35ZAeGl7VtUAH+PdGoDhQHggV7hNgzPc/k1xq4HNrTWQm
         99jnBEBFO2atCnByL0MqZNnaH/TD/wIzayIaT4d0=
Date:   Wed, 30 Jun 2021 07:35:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, dsahern@gmail.com,
        David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
Message-ID: <YNwCiZpNoKaL6fa1@kroah.com>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
 <20210629185537.78008-2-rumen.telbizov@menlosecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629185537.78008-2-rumen.telbizov@menlosecurity.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 11:55:35AM -0700, Rumen Telbizov wrote:
> From: David Ahern <dsahern@kernel.org>
> 
> Add support for policy routing via marks to the bpf_fib_lookup
> helper. The bpf_fib_lookup struct is constrained to 64B for
> performance. Since the smac and dmac entries are used only for
> output, put them in an anonymous struct and then add a union
> around a second struct that contains the mark to use in the FIB
> lookup.
> 
> Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
> ---

Any reason that David didn't also sign off on this?

thanks,

greg k-h
