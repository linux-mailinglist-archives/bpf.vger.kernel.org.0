Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF02B336BE4
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 07:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCKGNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 01:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhCKGNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 01:13:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FDC061574
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 22:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=h8aFuwdEQbq+Mg1pCOr++y0lRKxSpzr2i/D/1Sn40JY=; b=XtvHf0LRzm+d21Qj90F2B024Vb
        PE7Jf6Rrh9LADsQYxEbOeizvh7+NAbJz1o4D9eUIpqq/KSfMYrlyledbXRaB0Boen42Qf5gXrHJc1
        DbGZZ6z+lXPY50grHol99/iRG1qLWhCFnuWZnZO8+XxC+Y230F4bHV+hPH3c4OcXiVpW1fC5VhEvC
        81VItyxnL/J9G+Dv+wedtVzhlOyF6j+wFRwa6MclD9ouVh3odlRmcRG1chVjf27rMpps+X9aqvYF3
        Hh+OW3K/Q6YT8lATO0UTv9M2CX5rwd2uORxVUbETswTQfH5yuM3AKl2PCgwNPM5Plm61ist9ovpAF
        CUKXFhcw==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
        by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
        id 1lKEZH-008Rmk-8v
        for bpf@vger.kernel.org; Thu, 11 Mar 2021 06:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=h8aFuwdEQbq+Mg1pCOr++y0lRKxSpzr2i/D/1Sn40JY=; b=SQ71kkj+hQqJeaEdQu9vCbegeT
        n1GqRDzngRCaYc9rpXClkElVhb8Zfx1hTZNIbZS/jy4AQg5o7wfBimD6oD0rDeO7OtFNKHYYleNKJ
        OcxN+42NjXwBjzNJZm97rUHBShy443c35g+O/TuqQBazSG9s83Q7/8ZsDiiwDFeYteNX2yoB+uBpc
        xQjihJ08mlZ2Bp75Ur27Vgc+FdopqAyXOxL4xRQzoQToRpjkSybCyFP4feDrIbXYqoCmaFd1VzRKo
        907hCWSrMnK+YF7HEN5Fq3BH5aJzsn5M7WU0UNLuqThkZ/TESIIJ3EcN9a9+e7M4evsOkXfl/QFX9
        v0rYPP+Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKEYz-000tUv-0m; Thu, 11 Mar 2021 06:12:49 +0000
Subject: Re: [PATCH] net: core: Few absolutely rudimentary typo fixes
 throughout the file filter.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210311055608.12956-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <786f4801-c41f-cddd-c855-b388ec026614@infradead.org>
Date:   Wed, 10 Mar 2021 22:12:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210311055608.12956-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/10/21 9:56 PM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Hi Bhaskar,

FYI:

a. we accept British or American spellings
b. we accept one or two spaces after a period ('.') at the end of a sentence
c. we accept Oxford (serial) comma or not

> ---
>  net/core/filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 255aeee72402..931ee5f39ae7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2927,7 +2927,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  	 *
>  	 * Then if B is non-zero AND there is no space allocate space and
>  	 * compact A, B regions into page. If there is space shift ring to
> -	 * the rigth free'ing the next element in ring to place B, leaving
> +	 * the right freeing the next element in ring to place B, leaving
>  	 * A untouched except to reduce length.
>  	 */
>  	if (start != offset) {
> @@ -3710,7 +3710,7 @@ static inline int __bpf_skb_change_tail(struct sk_buff *skb, u32 new_len,
>  	 * be the one responsible for writing buffers.
>  	 *
>  	 * It's really expected to be a slow path operation here for
> -	 * control message replies, so we're implicitly linearizing,
> +	 * control message replies, so we're implicitly linearising,
>  	 * uncloning and drop offloads from the skb by this.
>  	 */
>  	ret = __bpf_try_make_writable(skb, skb->len);
> @@ -3778,7 +3778,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
>  		 * allow to expand on mac header. This means that
>  		 * skb->protocol network header, etc, stay as is.
>  		 * Compared to bpf_skb_change_tail(), we're more
> -		 * flexible due to not needing to linearize or
> +		 * flexible due to not needing to linearise or
>  		 * reset GSO. Intention for this helper is to be
>  		 * used by an L3 skb that needs to push mac header
>  		 * for redirection into L2 device.
> --


-- 
~Randy

