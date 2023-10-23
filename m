Return-Path: <bpf+bounces-13054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C27D41D1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 23:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14931281544
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A622F0A;
	Mon, 23 Oct 2023 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfKmrjf2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DF79C3
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:40:54 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E38BD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 14:40:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso571941266b.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698097250; x=1698702050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvQ+AhacAAJA4DC0YNwlMnuLpFF6Arq7BNkexW0iG1E=;
        b=FfKmrjf2nVgfG8YaecRmPAITrWQObPYU0sqiAacxmMFD7ioSUwYTGRoWs2CMuH+WeR
         Lw/jNuvGW71kGX4C/IdnrHwugsktzOwlQRwMksC5bIrhS81oMSBH1omuiGIZVJqXkrxg
         iDCbXEkEPCtLOS4f9oYtjtOrBNTca1GUQ+sdXoM4StcjYvoTbxK5ma+wiygQ0DJ3eWQS
         dieB+t7ES7b3we8kTNFuZUeL61a7BNcfDGOVdwronw/X96pWYEvNu4uazb49fXWzAr0r
         xh9MVg8K9kU8atdUIZg4eNHTjt9gX1kW07JZe/71bVenF0YhLRkD60K8TuvoeD3cKOtG
         3/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698097250; x=1698702050;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvQ+AhacAAJA4DC0YNwlMnuLpFF6Arq7BNkexW0iG1E=;
        b=Rc6N7/C5v2tQRPIKaKDP2VrRLqp1SBkxS46u0m1pY0s+/2kf9vI4KiAdFHApJmEPbq
         GbMPM6rCalEIjQxO6Cfpwvj2WFiQ6EBJGfs0D0AO4sKAPQsLtJGl5BOHf0SN3mrvKasB
         czib/VN4pFz+9Q6p+d2phAtqHJjIAmAsqkSvgzb4saRjmkIrJGTD/QOrVFuBEbXFvv+J
         x0aUF1rKocwmC+N1lqd5lxbBxNwsATmo07puvinUoibkIfrQAuZT9yH5003vi9uVKFvd
         WPPDGrBkonJWgFohlWOHHwLG3GMdXuoD/LiBu8I+Lo8c6iRzbuGuxuIZ9afIKMwNyhOo
         6aYg==
X-Gm-Message-State: AOJu0YxGY1xF4nb/xY1lm1BSComit5wi8Av4BB0dxPYzbjtiXslV8PW5
	5rsStcCB6Ag9mbTiwawNEBY3JhbJtwPDYaUb
X-Google-Smtp-Source: AGHT+IHG2Ua+hArOyb9aruNB2njZ39/AYJiM9LUrlgyfo/u2akDarjEwdteiSQJidK3ikjC+ZvBdAg==
X-Received: by 2002:a17:907:7b89:b0:9a5:d972:af43 with SMTP id ne9-20020a1709077b8900b009a5d972af43mr10301135ejc.65.1698097250312;
        Mon, 23 Oct 2023 14:40:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906119b00b009ae587ce133sm7222270eja.188.2023.10.23.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:40:49 -0700 (PDT)
Message-ID: <cb392020d5bb8257405fcfa22a40d6d464d48ffc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] exact states comparison for iterator
 convergence checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com,
 awerner32@gmail.com,  john.fastabend@gmail.com
Date: Tue, 24 Oct 2023 00:40:48 +0300
In-Reply-To: <3c354780e99e451fd8b8de26b12a8cb5c47148aa.camel@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
	 <3c354780e99e451fd8b8de26b12a8cb5c47148aa.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 20:17 +0300, Eduard Zingerman wrote:
> On Sun, 2023-10-22 at 04:08 +0300, Eduard Zingerman wrote:
> [...]
> > Changelog:
> > V1 -> V2 [2], applied changes suggested by Alexei offlist:
> > - __explored_state() function removed;
> > - same_callsites() function is now used in clean_live_states();
> > - patches #1,2 are added as preparatory code movement;
> > - in process_iter_next_call() a safeguard is added to verify that
> >   cur_st->parent exists and has expected insn index / call sites.
>=20
> I have V3 ready and passing CI.
>=20
> However I checked on Alexei's concerns regarding performance on
> explored states cache miss and verifier does not behave well with this
> patch-set. For example, the program at the end of the email causes
> verifier to "hang" (loop inside is_state_visited() to no end).
>=20
> There are several options to fix this:
> (a) limit total iteration depth, as in [1], the limit would have to be
>     at-least 1000 to make iters/task_vma pass;
> (b) limit maximal number of checkpoint states associated with
>     instruction and evict those with lowest dfs_depth;
> (c) choose bigger constants in `sl->miss_cnt > sl->hit_cnt * 3 + 3` for
>     checkpoint states.

I played a bit with constants in 'eviction on miss' formula using [1] (opti=
on c).
There are three relevant tests:
- iters/max_iter_depth: should report load failure within a reasonable time=
;
- iters/checkpoint_states_deletion: should pass;
- verif_scale_pyperf600_iter: should pass.

I think iters/checkpoint_states_deletion represents the worst case scenario=
,
because depending on number of variables N, it produces 2**N distinct state=
s.
The formula for eviction that does not loose relevant states is:

    sl->miss_cnt > sl->hit_cnt * 2**N + 2**N

(because states start to repeat after 2**N iterations).

W/o eviction for checkpoint states maximal number of variables
verifier could handle in this test is 9, with reported 958,883 insns proces=
sed.
Which corresponds to formula (sl->miss_cnt > sl->hit_cnt * 512 + 512).

Using these values I get the following execution times:

| test                       | time ./test_progs -a <test> |
|----------------------------+-----------------------------|
| verif_scale_pyperf600_iter |                        0.2s |
| checkpoint_states_deletion |                        5.8s |
| max_iter_depth             |                       23.9s |

Going one step lower to 8 variables (and 256 as a constant),
checkpoint_states_deletion takes 248,133 insns to complete
and timings table looks as follows:

| test                       | time ./test_progs -a <test> |
|----------------------------+-----------------------------|
| verif_scale_pyperf600_iter |                        0.2s |
| checkpoint_states_deletion |                        1.0s |
| max_iter_depth             |                       15.2s |

So, it is possible to get speedup for worst case scenario by leaving
some instruction budget on the table.

IMO using formula (sl->miss_cnt > sl->hit_cnt * 512 + 512) to evict
checkpoints kind-off sort-off makes sense but is very hacky.
(Or 256).

I think that better solution would be to go for option (b) from a
previous email:
- evict old checkpoints basing on dfs_depth;
- also use a secondary hash-table for checkpoints and hash not only
  insn_idx but also some fingerprint of register states, thus avoiding
  long state list walks.

But that would require some additional coding and I know that Alexei
wants to land this thing sooner than later.

[1] https://github.com/eddyz87/bpf/tree/iter-exact-eviction-formula-experim=
ents

