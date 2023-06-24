Return-Path: <bpf+bounces-3330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF273C515
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 02:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E4A281E7A
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4436E;
	Sat, 24 Jun 2023 00:17:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAA360
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 00:17:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E02727
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:17:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51be8edc657so1255147a12.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687565842; x=1690157842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbtnexG+5RMa7vnyPrx4KA+EsBnhX9yUwesH/xQgk6w=;
        b=cst9H4SAln/ilZZWhDMp7vMImTvDZVOB73oAEAytkiYknLzB2L4uop/vg1r3G3IUbb
         XQkfgnA+QRLT6fmrrann3RvuCLNVrhfH4L6aBIebnqxn/YpDN4PKzGixMEYONo7MEwZI
         inQ4O0Z4U65xqvk9LbKYdmbCJLF1oycD6edYG9rX2sivgm3Tye+OjfTsIs81pzcdMGcv
         ZjXXLH4Ej5eES+411DqAZSLVFRKYz5U1Ar1AiQX1QY8Dn6P/CIeJes9E82L73mr2+Ir1
         PTP7fQYCur7UwB0PCIR9KnoDvmnDSFIr7PeZcP6gwR6FnGB0Ks6Gk+wrFvObWtC4tZs5
         hpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565842; x=1690157842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbtnexG+5RMa7vnyPrx4KA+EsBnhX9yUwesH/xQgk6w=;
        b=BBxCLzpKQS10bgpDWDqYMcwUGHUUYbvhkOUslgw1llvbPEc8Qqwudxua/LpoEE7t5n
         OluECqhBXnAu2LVvkv0kR3ldBwE4sK9lG6vw4pFdAXqHLMgYnh8sD6oyJupEbpcpkNPM
         EBpwauafK4Ozyk+BauH1UzB/KW5GnzaMcBimE0ff9CZlXiVxCEPQNpxkn2xHPJqrXwiv
         2sylPkE4GX7wJpVmvOkyYrj0aSN6trg0OKmM+uRQ8tUHoJRL5HMztTGNl1ne9/A1Ibsd
         VqA29I5ZMQwSAQwigjJ8k/1ZxlR62aLraHoXr6qnV+7OxH2YBxH7TQ0dyPYot/wrLNR2
         DYwQ==
X-Gm-Message-State: AC+VfDwBhg+3FOQAaFezgrTXNxaVQN1nP1LAsYsMc1RFB7CDAhWIednx
	2Fj6Uq6OBdMuWS2v45TGcrRbGfbCFz16CXuZcOA=
X-Google-Smtp-Source: ACHHUZ659CSu6kFHB7rtZ/+ADcnwhHEcr2UXFU814yCusWFLr4JuhsqkeBHJ6qhAHvjf50Di4AIBvVl4bjDJKbbO7bM=
X-Received: by 2002:aa7:c1d2:0:b0:51b:fc1b:3578 with SMTP id
 d18-20020aa7c1d2000000b0051bfc1b3578mr1489567edp.18.1687565841896; Fri, 23
 Jun 2023 17:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622095330.1023453-1-aspsk@isovalent.com> <d981e123-43a1-4d91-8b52-0097087656b2@iogearbox.net>
In-Reply-To: <d981e123-43a1-4d91-8b52-0097087656b2@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 17:17:10 -0700
Message-ID: <CAADnVQ+mdh=Wu0=wmkP+GowoJ1zt6MO1yKk=wuSCAQA=3gkRRg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH bpf-next 0/4] bpf: add percpu stats for bpf_map
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 2:53=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/22/23 11:53 AM, Anton Protopopov wrote:
> > This series adds a mechanism for maps to populate per-cpu counters of e=
lements
> > on insertions/deletions. The sum of these counters can be accessed by a=
 new
> > kfunc from a map iterator program.
> >
> > The following patches are present in the series:
> >
> >    * Patch 1 adds a generic per-cpu counter to struct bpf_map
> >    * Patch 2 utilizes this mechanism for hash-based maps
> >    * Patch 3 extends the preloaded map iterator to dump the sum
> >    * Patch 4 adds a self-test for the change
> >
> > The reason for adding this functionality in our case (Cilium) is to get
> > signals about how full some heavy-used maps are and what the actual dyn=
amic
> > profile of map capacity is. In the case of LRU maps this is impossible =
to get
> > this information anyhow else. See also [1].
> >
> > This is a v2 for the https://lore.kernel.org/bpf/20230531110511.64612-1=
-aspsk@isovalent.com/T/#t
> > It was rewritten according to previous comments.  I've turned this seri=
es into
> > an RFC for two reasons:
> >
> > 1) This patch only works on systems where this_cpu_{inc,dec} is atomic =
for s64.
> > For systems which might write s64 non-atomically this would be required=
 to use
> > some locking mechanism to prevent readers from reading trash via the
> > bpf_map_sum_elements_counter() kfunc (see patch 1)
> >
> > 2) In comparison with the v1, we're adding extra instructions per map o=
peration
> > (for preallocated maps, as well as for non-preallocated maps). The only
> > functionality we're interested at the moment is the number of elements =
present
> > in a map, not a per-cpu statistics. This could be better achieved by us=
ing
> > the v1 version, which only adds computations for preallocated maps.
> >
> > So, the question is: won't it be fine to do the changes in the followin=
g way:
> >
> >    * extend the preallocated hash maps to populate percpu batch counter=
s as in v1
> >    * add a kfunc as in v2 to get the current sum
> >
> > This works as
> >
> >    * nobody at the moment actually requires the per-cpu statistcs
> >    * this implementation can be transparently turned into per-cpu stati=
stics, if
> >      such a need occurs on practice (the only thing to change would be =
to
> >      re-implement the kfunc and, maybe, add more kfuncs to get per-cpu =
stats)
> >    * the "v1 way" is the least intrusive: it only affects preallocated =
maps, as
> >      other maps already provide the required functionality
> >
> >    [1] https://lpc.events/event/16/contributions/1368/
> >
> > v1 -> v2:
> > - make the counters generic part of struct bpf_map
> > - don't use map_info and /proc/self/fdinfo in favor of a kfunc
>
> Tbh, I did like v1 approach a bit better. We are trying to bend over back=
wards just
> so that we don't add things to uapi, but in the end we are also adding it=
 to the
> maps.debug, etc (yes, it has .debug in the name and all) ...

I think we should keep bending even more backwards to avoid uapi burden.
All new features should be non-uapi no matter how many people
say "I'll definitely use it".

> or as an extensible bpf_map_info stats extension in case there is some ag=
reement?

I'd rather not.
bpf_map_info returns what user space sent to the kernel earlier.
stats or anything that user space didn't explicitly give earlier
is quite different.
Same goes for bpf_prog_info.
We only added verified_insns there that doesn't fit the above definition
and it was a mistake. After almost 2 years it is still unused
and cannot be removed.
veristat is parsing non-uapi verifier log.
Tooling can live with non-uapi map stats just fine.

