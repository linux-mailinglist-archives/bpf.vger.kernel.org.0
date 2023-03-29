Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B26CEF29
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjC2QUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC2QUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 12:20:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5727525A
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 09:20:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u10so15430470plz.7
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680106846;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTsi8isUe58x4hdddBoVgFHqkwd0RjZkl8FpcJwQ+gQ=;
        b=EjLDfBr2FlBOZHrZ5cd3b9fzmq/bx3JUTvLYH+YV2tmCJBOZIFHivE46mO0Q+RMTxA
         8HU5+pTxtGwB5s5Fm4IAl2YjSyBfuZwj5aUAGRBhwxdRbJbql1I9MDOdmjrGvEi++NJE
         21aNX6elPxM4llPc027ir6tT8ydgKM+xm0hfU93JRbPmMHjRugDb6l5+1L1Kv08XqXlb
         DEOoGEOIQU3hx/ypOlWAaGbsXfXKwvfUX5kBT/HUvFFMuLFJB3AQAxXMp6jPXgs/fhnQ
         QZ/3I4+KUTL6eF3N2zHpIZa3LkZQDXVoZpdSdfsxe3ZlK90Gv4eADcVAECU8M95mTgS6
         Bpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106846;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTsi8isUe58x4hdddBoVgFHqkwd0RjZkl8FpcJwQ+gQ=;
        b=jVVcAOtepcKhcsv9+dtxkY7ma/DIKOJkUlcJPMT0qFuEgdoF9cMv74rdeEc4m4FoW8
         kyhNGOxEZRK5PvOGlKh5XNyEeeWMdAWPPW3FyeH+zCT86kwWzgny11TjRNw8gyXzmwsX
         /+pS966Ikl50qajXSpJGdxZ9oQ1+WgmQEpni0qDDYaGCHGhkwg5ZABnfbzPcIMD7uYMI
         w/fI67t+9dcFbpmSGvO8sxKcbV3oH7zOSFAA3rHW996PJCjFNLhurlRrH6Hm0GbnKHu5
         Lo6MGZvDkRItSppcDAZXH3CR8QFq6HHTT01ZFEPqXBOh7Z5dN5bDkaolAHtsV8OJFasQ
         RzNg==
X-Gm-Message-State: AO0yUKWo8neFW8RIYqXjXwPgYJvR5WFR0SZ/ehFQlwkFCAoksOh0jdpu
        uvNiVL2krVlg+hGMdKOBopiF9Q==
X-Google-Smtp-Source: AK7set+EnW/HIUCYLrkphzRD4Gp1YhNV0TltFpQ9VAxuoRJZLdDoBYfejotkcAn0liviUqu/9eVAuA==
X-Received: by 2002:a05:6a20:e1e:b0:d9:6650:ef14 with SMTP id ej30-20020a056a200e1e00b000d96650ef14mr16344184pzb.31.1680106845999;
        Wed, 29 Mar 2023 09:20:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:51dd:363a:9403:aff? ([2601:647:4900:1fbb:51dd:363a:9403:aff])
        by smtp.gmail.com with ESMTPSA id i25-20020aa79099000000b0062d7c0dc4f2sm6719805pfa.79.2023.03.29.09.20.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:20:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Implement batching in UDP iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <d03ee937-5c78-1c7a-c487-4fae508627aa@linux.dev>
Date:   Wed, 29 Mar 2023 09:20:44 -0700
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB0B99F7-F31F-4A46-B13F-28BAE42B97C0@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-2-aditi.ghag@isovalent.com>
 <c77f069e-69a4-bc0a-dc92-c77cd0f7df08@linux.dev>
 <FF565E79-7C76-4525-8835-931146319F21@isovalent.com>
 <d03ee937-5c78-1c7a-c487-4fae508627aa@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 28, 2023, at 2:33 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/28/23 10:06 AM, Aditi Ghag wrote:
>>>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>>> +{
>>>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>>>> +	struct udp_iter_state *state =3D &iter->state;
>>>> +	struct net *net =3D seq_file_net(seq);
>>>> +	struct udp_seq_afinfo *afinfo =3D state->bpf_seq_afinfo;
>>>> +	struct udp_table *udptable;
>>>> +	struct sock *first_sk =3D NULL;
>>>> +	struct sock *sk;
>>>> +	unsigned int bucket_sks =3D 0;
>>>> +	bool resized =3D false;
>>>> +	int offset =3D 0;
>>>> +	int new_offset;
>>>> +
>>>> +	/* The current batch is done, so advance the bucket. */
>>>> +	if (iter->st_bucket_done) {
>>>> +		state->bucket++;
>>>> +		state->offset =3D 0;
>>>> +	}
>>>> +
>>>> +	udptable =3D udp_get_table_afinfo(afinfo, net);
>>>> +
>>>> +	if (state->bucket > udptable->mask) {
>>>> +		state->bucket =3D 0;
>>>> +		state->offset =3D 0;
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +again:
>>>> +	/* New batch for the next bucket.
>>>> +	 * Iterate over the hash table to find a bucket with sockets =
matching
>>>> +	 * the iterator attributes, and return the first matching socket =
from
>>>> +	 * the bucket. The remaining matched sockets from the bucket are =
batched
>>>> +	 * before releasing the bucket lock. This allows BPF programs =
that are
>>>> +	 * called in seq_show to acquire the bucket lock if needed.
>>>> +	 */
>>>> +	iter->cur_sk =3D 0;
>>>> +	iter->end_sk =3D 0;
>>>> +	iter->st_bucket_done =3D false;
>>>> +	first_sk =3D NULL;
>>>> +	bucket_sks =3D 0;
>>>> +	offset =3D state->offset;
>>>> +	new_offset =3D offset;
>>>> +
>>>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>>>> +		struct udp_hslot *hslot =3D =
&udptable->hash[state->bucket];
>>>=20
>>> Use udptable->hash"2" which is hashed by addr and port. It will help =
to get a smaller batch. It was the comment given in v2.
>> I thought I replied to your review comment, but looks like I didn't. =
My bad!
>> I already gave it a shot, and I'll need to understand better how =
udptable->hash2 is populated. When I swapped hash with hash2, there were =
no sockets to iterate. Am I missing something obvious?
>=20
> Take a look at udp_lib_lport_inuse2() on how it iterates.

Thanks! I've updated the code to use hash2 instead of hash.

>=20
>>>=20
>>>> +
>>>> +		if (hlist_empty(&hslot->head)) {
>>>> +			offset =3D 0;
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		spin_lock_bh(&hslot->lock);
>>>> +		/* Resume from the last saved position in a bucket =
before
>>>> +		 * iterator was stopped.
>>>> +		 */
>>>> +		while (offset-- > 0) {
>>>> +			sk_for_each(sk, &hslot->head)
>>>> +				continue;
>>>> +		}
>>>=20
>>> hmm... how does the above while loop and sk_for_each loop actually =
work?
>>>=20
>>>> +		sk_for_each(sk, &hslot->head) {
>>>=20
>>> Here starts from the beginning of the hslot->head again. doesn't =
look right also.
>>>=20
>>> Am I missing something here?
>>>=20
>>>> +			if (seq_sk_match(seq, sk)) {
>>>> +				if (!first_sk)
>>>> +					first_sk =3D sk;
>>>> +				if (iter->end_sk < iter->max_sk) {
>>>> +					sock_hold(sk);
>>>> +					iter->batch[iter->end_sk++] =3D =
sk;
>>>> +				}
>>>> +				bucket_sks++;
>>>> +			}
>>>> +			new_offset++;
>>>=20
>>> And this new_offset is outside of seq_sk_match, so it is not =
counting for the seq_file_net(seq) netns alone.
>> This logic to resume iterator is buggy, indeed! So I was trying to =
account for the cases where the current bucket could've been updated =
since we release the bucket lock.
>> This is what I intended to do -
>> +loop:
>>                 sk_for_each(sk, &hslot->head) {
>>                         if (seq_sk_match(seq, sk)) {
>> +                               /* Resume from the last saved =
position in the
>> +                                * bucket before iterator was =
stopped.
>> +                                */
>> +                               while (offset && offset-- > 0)
>> +                                       goto loop;
>=20
> still does not look right. merely a loop decrementing offset one at a =
time and then go back to the beginning of hslot->head?

Yes, I realized that the macro doesn't continue as I thought it would. =
I've fixed it.

>=20
> A quick (untested and uncompiled) thought :
>=20
> 				/* Skip the first 'offset' number of sk
> 				 * and not putting them in the =
iter->batch[].
> 				 */
> 				if (offset) {
> 					offset--;
> 					continue;
> 				}
>=20
>>                                 if (!first_sk)
>>                                         first_sk =3D sk;
>>                                 if (iter->end_sk < iter->max_sk) {
>> @@ -3245,8 +3244,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>                                         iter->batch[iter->end_sk++] =3D=
 sk;
>>                                 }
>>                                 bucket_sks++ > +                      =
        new_offset++;
>>                         }
>> This handles the case when sockets that weren't iterated in the =
previous round got deleted by the time iterator was resumed. But it's =
possible that previously iterated sockets got deleted before the =
iterator was later resumed, and the offset is now outdated. Ideally, =
iterator should be invalidated in this case, but there is no way to =
track this, is there? Any thoughts?
>=20
> I would not worry about this update in-between case. race will happen =
anyway when the bucket lock is released. This should be very unlikely =
when hash"2" is used.
>=20
>=20

That makes sense.=20

