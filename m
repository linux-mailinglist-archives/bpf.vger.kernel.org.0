Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FE2D18AB
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLGSkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 13:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLGSkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 13:40:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C1C061749;
        Mon,  7 Dec 2020 10:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1vZ+rI2iiIkY3a+Mw7R3JaM5l1xXBwwdB8QTDmpgIbI=; b=Sn5wnNn2SXWUTTqQWS31UZMqZ3
        TJuoqvmlY/Athf3xpxDn5aBX86hfgaIbPlCzrLdz3AxizeimhDjsxn0/bKOd+R4U2tDLU7xqwH3Cn
        bhRZUSjdOjz/v+vpJRSieqYQFLyjX270ePMDCtFMDMrF/Sa0c7Zm5miRiOWH+KXQJyfvHUPJrbhRH
        gQc6WppM8dfhQAQ7qwPxuPSyw+rnWzoPn8+O2KWDtuOV0qK8FOhuWUooo1Q1y9+nvEWD/KBTmA4c+
        0fKjbuaoIxnTB7t/0kfOyxCzNQ29fd6SC3GOpBe0q3Vi8yuEwo+dM/2Re7qbslb/bEKMmoqyABZ4d
        2nNdD5+Q==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmLQY-0001eA-Bb; Mon, 07 Dec 2020 18:40:02 +0000
Subject: Re: linux-next: Tree for Dec 7 (bpf: sock_from_file)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>, bpf <bpf@vger.kernel.org>
References: <20201207202520.3ced306c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8f2e76b-a35e-55c5-e937-eea81700c994@infradead.org>
Date:   Mon, 7 Dec 2020 10:39:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207202520.3ced306c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/20 1:25 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20201204:
> 


on i386:
# CONFIG_NET is not set

ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
