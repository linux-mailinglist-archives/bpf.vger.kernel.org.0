Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B731985F2
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgC3VBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 17:01:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgC3VBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 17:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=QJRXaFSmdizU3gcgzmC6VNf0B5yWIVwMwU5JSX/wwi0=; b=QWDTyJmDxiBwGQLjBtaz2Z8R65
        ZLDoWOhS//KutrdTX90J+sTnZ0EuEhxHGMsLMApanXxjtpQTl9qwuvFagvRxFZhSaeEQfs7iVs+15
        qqnI0ttiMgc7P5AnthV9o6Ji6zWSCCOVujGHmzQIjezcGSXFuoP1+/e1srr2mcL9LQ0LIsRiWgFJU
        wlfMZzEnbPkvse+1m3xqJAownEfA6jmP8tbtFTrNpxd8HKqG6Pw1cehY4HX+NQmhD2KLwFFGL+WyT
        7ToylqXuXlTetTkgQRJBqjih3LwSbu4nNELGdZqFkH6iwAObGyDn53+GAF6ivs8m9kNQR/DDjTY+a
        9Zyg5gTg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ1XA-0006mx-Kd; Mon, 30 Mar 2020 21:01:24 +0000
Subject: Re: [PATCH bpf-next] bpf: lsm: Make BPF_LSM depend on BPF_EVENTS
To:     Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>
References: <20200330204059.13024-1-kpsingh@chromium.org>
 <a51da62a-03da-fae5-f6eb-9aacdd7861b2@iogearbox.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7157f7eb-f210-24d0-abfb-ae205e97e77e@infradead.org>
Date:   Mon, 30 Mar 2020 14:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a51da62a-03da-fae5-f6eb-9aacdd7861b2@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/20 2:00 PM, Daniel Borkmann wrote:
> On 3/30/20 10:40 PM, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> LSM and tracing programs share their helpers with bpf_tracing_func_proto
>> which is only defined (in bpf_trace.c) when BPF_EVENTS is enabled.
>>
>> Instead of adding __weak symbol, make BPF_LSM depend on
>> BPF_EVENTS so that both tracing and LSM programs can actually share
>> helpers.
>>
>> Signed-off-by: KP Singh <kpsingh@google.com>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Fixes: fc611f47f218 ("bpf: Introduce BPF_PROG_TYPE_LSM")
> 
> Applied, thanks!

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy

