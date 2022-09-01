Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D55A9B14
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiIAPBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiIAPBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 11:01:04 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1199342AC6;
        Thu,  1 Sep 2022 08:01:00 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTlgg-00071t-Tm; Thu, 01 Sep 2022 17:00:58 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTlgg-000QVV-Nf; Thu, 01 Sep 2022 17:00:58 +0200
Subject: Re: [RFC bpf-next 1/2] bpf: tnums: warn against the usage of
 tnum_in(tnum_range(), ...)
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20220831031907.16133-1-shung-hsi.yu@suse.com>
 <20220831031907.16133-2-shung-hsi.yu@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0f6d7f97-8cd9-d513-368b-39706dd6b06a@iogearbox.net>
Date:   Thu, 1 Sep 2022 17:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220831031907.16133-2-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26645/Thu Sep  1 09:52:28 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/22 5:19 AM, Shung-Hsi Yu wrote:
> Commit a657182a5c51 ("bpf: Don't use tnum_range on array range checking
> for poke descriptors") has shown that using tnum_range() as argument to
> tnum_in() can lead to misleading code that looks like tight bound check
> when in fact the actual allowed range is much wider.
> 
> Document such behavior to warn against its usage in general, and suggest
> some scenario where result can be trusted.
> 
> Link: https://lore.kernel.org/bpf/984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net/
> Link: https://www.openwall.com/lists/oss-security/2022/08/26/1
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Any objections from your side if I merge this? Thanks for adding doc. :)

> ---
>   include/linux/tnum.h | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 498dbcedb451..0ec4cda9e174 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -21,7 +21,12 @@ struct tnum {
>   struct tnum tnum_const(u64 value);
>   /* A completely unknown value */
>   extern const struct tnum tnum_unknown;
> -/* A value that's unknown except that @min <= value <= @max */
> +/* An unknown value that is a superset of @min <= value <= @max.
> + *
> + * Could including values outside the range of [@min, @max].
> + * For example tnum_range(0, 2) is represented by {0, 1, 2, *3*}, rather than
> + * the intended set of {0, 1, 2}.
> + */
>   struct tnum tnum_range(u64 min, u64 max);
>   
>   /* Arithmetic and logical ops */
> @@ -73,7 +78,18 @@ static inline bool tnum_is_unknown(struct tnum a)
>    */
>   bool tnum_is_aligned(struct tnum a, u64 size);
>   
> -/* Returns true if @b represents a subset of @a. */
> +/* Returns true if @b represents a subset of @a.
> + *
> + * Note that using tnum_range() as @a requires extra cautions as tnum_in() may
> + * return true unexpectedly due to tnum limited ability to represent tight
> + * range, e.g.
> + *
> + *   tnum_in(tnum_range(0, 2), tnum_const(3)) == true
> + *
> + * As a rule of thumb, if @a is explicitly coded rather than coming from
> + * reg->var_off, it should be in form of tnum_const(), tnum_range(0, 2**n - 1),
> + * or tnum_range(2**n, 2**(n+1) - 1).
> + */
>   bool tnum_in(struct tnum a, struct tnum b);
>   
>   /* Formatting functions.  These have snprintf-like semantics: they will write
> 

