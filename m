Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC16D337E
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDATZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDATZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 15:25:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3C19A2
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 12:24:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so102448305edb.11
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680377097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+N/EpzsdTPxcyDpyJRX7yyKNkXJHGOOkcVPrBrJfZA=;
        b=Tp3844jrEGFhz9wct96kM6r51oVbbWQURJjUJdq9uN03EPjs3V1BSgANpfBjMCEwoi
         HxNxbxuFWydn1A3ag2KITHAC87SkXnzMT0L+04K1CpTIEszjLIhp/CeRsh45n72saqVk
         z6gRzMW3pcSX0+D0SR+IsBSc2McfUFFTZtycEOmOzKgocTRrewpX+D4avo6L2Yq3gaho
         13GDs04qhlqMKZynarLAJwPPh7ap7okMpzFY9haP/uTF5k/1VJQfkl4C8K/j9d/uNVuc
         TLQT5N28bmcMhP8GlGba6Xsj90Ki/OBxJPH0/YmLpfycp9GBkdqJ70Q1iV+GtsgIKZSX
         cIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+N/EpzsdTPxcyDpyJRX7yyKNkXJHGOOkcVPrBrJfZA=;
        b=ySGChtyqv1Xfr7mfGjbHfuw7MTNPy2KbAIL5MG8F8yucOaEZNMhyle/rxG1KI6OwmV
         O0nPDIDiVxel89ouIUKw60PMicav/1zYz2BNrJLjVPQQ0l5M2lEVRzuIWm7DI06vPgMv
         4UZSpf+RGo53qfdB8eS2Nw2bZrpnYsaST2umL2hYYSeyxIRfL0MpTLEZ33pdL4jv1hiN
         YyQWj6DZ+0i2mcCe3DAqeOlMx8J9JnU+ZUYe2NTj1kqRMopYw/QdfXvyjsrrBntQuo+/
         xMhzu/Rzq31oOf6nJzhwy2f0CqKR6PgjsXpMxJ72DUh7PhsKRF2NTTIWRtOCgf/iEsjB
         6mUg==
X-Gm-Message-State: AAQBX9fzG53xFWlhxHwgPK5EfHML9G5gsutit03SHP1LN7gg8V9974uh
        vbewG0ob6+Ad4Fxu4sYuAJ7Jdg==
X-Google-Smtp-Source: AKy350YvhQUGyxOo85MV64oETAJ6hMLWRh78Nu+D56l9l4lVlm1t8e8tDLS2zu6bgAmlrnBvgYjhaw==
X-Received: by 2002:a17:907:9627:b0:947:40e6:fde4 with SMTP id gb39-20020a170907962700b0094740e6fde4mr13137509ejc.2.1680377097113;
        Sat, 01 Apr 2023 12:24:57 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id gx20-20020a1709068a5400b00931faf03db0sm2392703ejc.27.2023.04.01.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 12:24:56 -0700 (PDT)
Date:   Sat, 1 Apr 2023 19:25:44 +0000
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: optimize hashmap lookups when key_size is
 divisible by 4
Message-ID: <ZCiFONQVTvRia3nY@zh-lab-node-5>
References: <20230401101050.358342-1-aspsk@isovalent.com>
 <20230401162003.kkkx7ynlu7a2msn6@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401162003.kkkx7ynlu7a2msn6@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 01, 2023 at 09:20:03AM -0700, Alexei Starovoitov wrote:
> On Sat, Apr 01, 2023 at 10:10:50AM +0000, Anton Protopopov wrote:
> > The BPF hashmap uses the jhash() hash function. There is an optimized version
> > of this hash function which may be used if hash size is a multiple of 4. Apply
> > this optimization to the hashmap in a similar way as it is done in the bloom
> > filter map.
> > 
> > On practice the optimization is only noticeable for smaller key sizes, which,
> > however, is sufficient for many applications. An example is listed in the
> > following table of measurements (a hashmap of 65536 elements was used):
> > 
> >     --------------------------------------------------------------------
> >     | key_size | fullness | lookups /sec | lookups (opt) /sec |   gain |
> >     --------------------------------------------------------------------
> >     |        4 |      25% |      42.990M |            46.000M |   7.0% |
> >     |        4 |      50% |      37.910M |            39.094M |   3.1% |
> >     |        4 |      75% |      34.486M |            36.124M |   4.7% |
> >     |        4 |     100% |      31.760M |            32.719M |   3.0% |
> >     --------------------------------------------------------------------
> >     |        8 |      25% |      43.855M |            49.626M |  13.2% |
> >     |        8 |      50% |      38.328M |            42.152M |  10.0% |
> >     |        8 |      75% |      34.483M |            38.088M |  10.5% |
> >     |        8 |     100% |      31.306M |            34.686M |  10.8% |
> >     --------------------------------------------------------------------
> >     |       12 |      25% |      38.398M |            43.770M |  14.0% |
> >     |       12 |      50% |      33.336M |            37.712M |  13.1% |
> >     |       12 |      75% |      29.917M |            34.440M |  15.1% |
> >     |       12 |     100% |      27.322M |            30.480M |  11.6% |
> >     --------------------------------------------------------------------
> >     |       16 |      25% |      41.491M |            41.921M |   1.0% |
> >     |       16 |      50% |      36.206M |            36.474M |   0.7% |
> >     |       16 |      75% |      32.529M |            33.027M |   1.5% |
> >     |       16 |     100% |      29.581M |            30.325M |   2.5% |
> >     --------------------------------------------------------------------
> >     |       20 |      25% |      34.240M |            36.787M |   7.4% |
> >     |       20 |      50% |      30.328M |            32.663M |   7.7% |
> >     |       20 |      75% |      27.536M |            29.354M |   6.6% |
> >     |       20 |     100% |      24.847M |            26.505M |   6.7% |
> >     --------------------------------------------------------------------
> >     |       24 |      25% |      36.329M |            40.608M |  11.8% |
> >     |       24 |      50% |      31.444M |            35.059M |  11.5% |
> >     |       24 |      75% |      28.426M |            31.452M |  10.6% |
> >     |       24 |     100% |      26.278M |            28.741M |   9.4% |
> >     --------------------------------------------------------------------
> >     |       28 |      25% |      31.540M |            31.944M |   1.3% |
> >     |       28 |      50% |      27.739M |            28.063M |   1.2% |
> >     |       28 |      75% |      24.993M |            25.814M |   3.3% |
> >     |       28 |     100% |      23.513M |            23.500M |  -0.1% |
> >     --------------------------------------------------------------------
> >     |       32 |      25% |      32.116M |            33.953M |   5.7% |
> >     |       32 |      50% |      28.879M |            29.859M |   3.4% |
> >     |       32 |      75% |      26.227M |            26.948M |   2.7% |
> >     |       32 |     100% |      23.829M |            24.613M |   3.3% |
> >     --------------------------------------------------------------------
> >     |       64 |      25% |      22.535M |            22.554M |   0.1% |
> >     |       64 |      50% |      20.471M |            20.675M |   1.0% |
> >     |       64 |      75% |      19.077M |            19.146M |   0.4% |
> >     |       64 |     100% |      17.710M |            18.131M |   2.4% |
> >     --------------------------------------------------------------------
> > 
> > The following script was used to gather the results (SMT & frequency off):
> > 
> >     cd tools/testing/selftests/bpf
> >     for key_size in 4 8 12 16 20 24 28 32 64; do
> >             for nr_entries in `seq 16384 16384 65536`; do
> >                     fullness=$(printf '%3s' $((nr_entries*100/65536)))
> >                     echo -n "key_size=$key_size: $fullness% full: "
> >                     sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=$key_size --nr_entries=$nr_entries --max_entries=65536 --nr_loops=2000000 --map_flags=0x40 | grep cpu
> >             done
> >             echo
> >     done
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  kernel/bpf/hashtab.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 96b645bba3a4..eb804815f7c3 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -103,6 +103,7 @@ struct bpf_htab {
> >  	u32 n_buckets;	/* number of hash buckets */
> >  	u32 elem_size;	/* size of each element in bytes */
> >  	u32 hashrnd;
> > +	u32 key_size_u32;
> >  	struct lock_class_key lockdep_key;
> >  	int __percpu *map_locked[HASHTAB_MAP_LOCK_COUNT];
> >  };
> > @@ -510,6 +511,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >  	else
> >  		htab->elem_size += round_up(htab->map.value_size, 8);
> >  
> > +	/* optimize hash computations if key_size is divisible by 4 */
> > +	if ((attr->key_size & (sizeof(u32) - 1)) == 0)
> > +		htab->key_size_u32 = attr->key_size / sizeof(u32);
> 
> Please use & 3 and / 4.
> sizeof(u32) is not going to change.

Yes, sure

> > +
> >  	err = -E2BIG;
> >  	/* prevent zero size kmalloc and check for u32 overflow */
> >  	if (htab->n_buckets == 0 ||
> > @@ -605,9 +610,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >  	return ERR_PTR(err);
> >  }
> >  
> > -static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
> > +static inline u32 htab_map_hash(const struct bpf_htab *htab, const void *key, u32 key_len)
> >  {
> > -	return jhash(key, key_len, hashrnd);
> > +	if (likely(htab->key_size_u32))
> > +		return jhash2(key, htab->key_size_u32, htab->hashrnd);
> > +	return jhash(key, key_len, htab->hashrnd);
> 
> Could you measure the speed when &3 and /4 is done in the hot path ?
> I would expect the performance to be the same or faster,
> since extra load is gone.

I don't see any visible difference (I've tested "&3 and /4" and "%4==0 and /4"
variants). Do you still prefer division in favor of using htab->key_size_u32?
