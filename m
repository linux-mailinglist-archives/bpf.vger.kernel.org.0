Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312146A65A8
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 03:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCACkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 21:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCACkv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 21:40:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3737554
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:40:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11231475pjg.4
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkg/x6ZEBLOWTiWv25lv6mpg2ZmulC3EuoTBTinmv9E=;
        b=amPZeo+eBQz4u/sXb7RRXbpjYSvL7NJYppIW9KLwjPjNNLij9kMgRyur2C4jNMTOnX
         Rvtg/282+vNqyn/H5ax1NhcTuFFfNeIzNrqnBdwYp207vGnsdx+YWpNjfpCo1CEADffb
         TIezNtu6/0zCVvYwTTnFk+ie5li7GlHL2fJGxRsI1P3z+8hUN2iGD0IRK5QBCzv7hrY2
         ixq75ulhhw6nX0uMS0uxZC2XazXFPDCmPFgDp0fqo1IPocfY5nvq3HtiW8T+X0cyrfwF
         ZAJ5mCqm4vyH7QKuZ1jiVa9Lk9jweivyNrcASQQn9MU3PGgvYio6ob7/mHD5j0Q6sOvU
         uoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkg/x6ZEBLOWTiWv25lv6mpg2ZmulC3EuoTBTinmv9E=;
        b=4aNk+zP0Dthh+45jzgHFqjkvsHO6qR2SbzMRtcuVgczrtoK0ZhULkup+pfF30m//c1
         bsyAgtIaG80DIDJJrXvP3B2hRycAD2e76RhQ9g5v0kyZANEvQ8S92pM/o6V+fn0LFJpl
         R2ivr6qrcQXrV/Mj26juiQrDtNXgr9aEzfJQo34xcuU0bcrAGQF/kv95yyzwSEHe++Nc
         d4xGJB4I5KrrnYYPZxsmUEEohuq+iwNl1mke2EjCZprqhJ8PbmjozDpcFn21ReHYDiqM
         lSdRNiYSXeYxtYs7uuBhz0vmfuiD2LUj3+RBQrskpLz21wKFToPHsNjyI05Oaw9UzyMQ
         6LmQ==
X-Gm-Message-State: AO0yUKWSilkici8uwh0CeVEZR1phqhLL6kSHh0ra+OR4eyiaKS1BB7og
        czqIMjlSIhnpXSIVSSylfp8Tvg==
X-Google-Smtp-Source: AK7set+taubzTE4JDVSYqCo2NuRJ+VqjQFyAJSF283OHeuibFuged2cCxjmio8ja92pgh4MmayrJXQ==
X-Received: by 2002:a17:903:32c4:b0:19b:78:539e with SMTP id i4-20020a17090332c400b0019b0078539emr5406802plr.68.1677638449654;
        Tue, 28 Feb 2023 18:40:49 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:d435:3c0:a2bd:c7c? ([2601:647:4900:b6:d435:3c0:a2bd:c7c])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b0019cbb055a95sm7197117plb.94.2023.02.28.18.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:40:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Implement batching in UDP iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <22705f9d-9b94-a4ec-3202-270fef1ed657@linux.dev>
Date:   Tue, 28 Feb 2023 18:40:47 -0800
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67D9E31D-D45F-4C33-B354-2C9EC43ADD12@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-2-aditi.ghag@isovalent.com>
 <22705f9d-9b94-a4ec-3202-270fef1ed657@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> +
>> +		if (hlist_empty(&hslot->head))
>> +			continue;
>> +
>> +		spin_lock_bh(&hslot->lock);
>> +		sk_for_each(sk, &hslot->head) {
>> +			if (seq_sk_match(seq, sk)) {
>> +				if (first) {
>> +					first_sk =3D sk;
>> +					first =3D false;
>> +				}
>> +				if (iter->end_sk < iter->max_sk) {
>> +					sock_hold(sk);
>> +					iter->batch[iter->end_sk++] =3D =
sk;
>> +				}
>> +				bucket_sks++;
>> +			}
>> +		}
>> +		spin_unlock_bh(&hslot->lock);
>> +		if (first_sk)
>> +			break;
>> +	}
>> +
>> +	/* All done: no batch made. */
>> +	if (!first_sk)
>> +		return NULL;
>=20
> I think first_sk and bucket_sks need to be reset on the "again" case =
also?
>=20
> If bpf_iter_udp_seq_stop() is called before a batch has been fully =
processed by the bpf prog in ".show", how does the next =
bpf_iter_udp_seq_start() continue from where it left off? The =
bpf_tcp_iter remembers the bucket and the offset-in-this-bucket. I think =
bpf_udp_iter can do something similar.

Hmm, I suppose you are referring to the `tcp_seek_last_pos` logic? This =
was the [1] commit that added the optimization in v2.6, but only for =
TCP. Extending the same logic for UDP is out of the scope of this PR? =
Although reading the [1] commit description, the latency issue seems to =
be specific to the file based iterators, no? Of course, BPF iterators =
are quite new, and I'm not sure if we have the same "slowness" reported =
in that commit. Having said that, do we expect users to start from where =
they previously left off by stopping BPF iterators? Regardless, I'll do =
some testing to ensure that we at least don't crash.=20


[1] =
https://github.com/torvalds/linux/commit/a8b690f98baf9fb1902b8eeab801351ea=
603fa3a


