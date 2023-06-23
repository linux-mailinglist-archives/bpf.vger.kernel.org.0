Return-Path: <bpf+bounces-3303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81773BDF3
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3748B281D06
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33695100DB;
	Fri, 23 Jun 2023 17:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A3D2FF
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:41:19 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7611C
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:41:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51452556acdso607914a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687542078; x=1690134078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9PD3+q6iQpZf8LtCTS6oacA8NFAVMaG9Rqjb2xMy84=;
        b=t6wK7bdT6ibzU+XvWml6Uq+jT+AyEkVqZSmShuCNmuLr70DodC0FRo1sXPkjNUtuYl
         F2K8pHah0BpX9LbgS9ZJzn9FsZHG/Yt+ms0reH/WdnHDu5dnjt/YXDdFSksLBiRqPuUe
         LTPJAZwmbMC5miPnyJuVQMDTRxzZMaBeSqevvzoeDmmbaoU/903oTnX2FgKV1b61rac+
         /f0LlXN7ZVuG1U4h2Q7WuFoNdWDUcgnkJ4JWrB00jn2sr7pPBWEUZhNlXn2Tq85QHw14
         qcrMyNdNlkWz8UV0WvrHUA5KiOifWVclMRJuc+nYNHuj/Y9NgyysETwK7LqZck4j97jn
         4IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542078; x=1690134078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9PD3+q6iQpZf8LtCTS6oacA8NFAVMaG9Rqjb2xMy84=;
        b=kg0klQI1yQ6V3mzbZzncGerHt0pqsvj1/TJOnNZucfB8cWjzD5gGE6z7XvI0TBpqsU
         OFxinBVdPzINOapRSjP2YvnyFIuJXKwLkwoIuGFWLyit5QuyqDZGcRSZgMBKdTj4Ii2N
         8zk++H4dQLrgLHAx95SVtkB1+1mJv2Nijh81mSBQB/bQJ6RSsNIuyTAlUdGfomzaybXK
         cigrjOCOeZ/5O9PTEoN2AXAVE26RAO+inzB48XILkska1pHZWhejovtCStlYgl+Beht0
         WQT9ScOlDt/hn8Hb0RRpmxpCl8tC4+TB86N+FN/ooqxDW1evSNg9nXbevsqQ3owN9z2t
         xTQQ==
X-Gm-Message-State: AC+VfDwfHZVUX1dNURq9y0KonlNecstw1IOCBSaXVoKSYiQ4jJOWNPXe
	IhYt57p25RD6EMsmhk4NYyJQKhygcsWdEqzRM4lTaQ==
X-Google-Smtp-Source: ACHHUZ6j4/ztWxetQRdS1AKcTujIbxNQaqipobjuGH8eq5qLLFb4I3ejngpvqDj3iK0TDDaGQNHmBNLdiDDMJHInqrU=
X-Received: by 2002:a17:90a:7641:b0:25b:ca75:8f44 with SMTP id
 s1-20020a17090a764100b0025bca758f44mr14772699pjl.4.1687542077508; Fri, 23 Jun
 2023 10:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com> <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
 <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com>
In-Reply-To: <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 23 Jun 2023 10:41:06 -0700
Message-ID: <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> > On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netdev@brouer=
.com> wrote:
> >>
> >>
> >> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=C3=B8rn =
(Cc)
> >>
> >> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> >>> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> >>> and carry some TX metadata in the headroom. For copy mode, there
> >>> is no way currently to populate skb metadata.
> >>>
> >>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> >>> to treat as metadata. Metadata bytes come prior to tx_desc address
> >>> (same as in RX case).
> >>
> >>   From looking at the code, this introduces a socket option for this T=
X
> >> metadata length (tx_metadata_len).
> >> This implies the same fixed TX metadata size is used for all packets.
> >> Maybe describe this in patch desc.
> >
> > I was planning to do a proper documentation page once we settle on all
> > the details (similar to the one we have for rx).
> >
> >> What is the plan for dealing with cases that doesn't populate same/ful=
l
> >> TX metadata size ?
> >
> > Do we need to support that? I was assuming that the TX layout would be
> > fixed between the userspace and BPF.
>
> I hope you don't mean fixed layout, as the whole point is adding
> flexibility and extensibility.

I do mean a fixed layout between the userspace (af_xdp) and devtx program.
At least fixed max size of the metadata. The userspace and the bpf
prog can then use this fixed space to implement some flexibility
(btf_ids, versioned structs, bitmasks, tlv, etc).
If we were to make the metalen vary per packet, we'd have to signal
its size per packet. Probably not worth it?

> > If every packet would have a different metadata length, it seems like
> > a nightmare to parse?
> >
>
> No parsing is really needed.  We can simply use BTF IDs and type cast in
> BPF-prog. Both BPF-prog and userspace have access to the local BTF ids,
> see [1] and [2].
>
> It seems we are talking slightly past each-other(?).  Let me rephrase
> and reframe the question, what is your *plan* for dealing with different
> *types* of TX metadata.  The different struct *types* will of-cause have
> different sizes, but that is okay as long as they fit into the maximum
> size set by this new socket option XDP_TX_METADATA_LEN.
> Thus, in principle I'm fine with XSK having configured a fixed headroom
> for metadata, but we need a plan for handling more than one type and
> perhaps a xsk desc indicator/flag for knowing TX metadata isn't random
> data ("leftover" since last time this mem was used).

Yeah, I think the above correctly catches my expectation here. Some
headroom is reserved via XDP_TX_METADATA_LEN and the flexibility is
offloaded to the bpf program via btf_id/tlv/etc.

Regarding leftover metadata: can we assume the userspace will take
care of setting it up?

> With this kfunc approach, then things in-principle, becomes a contract
> between the "local" TX-hook BPF-prog and AF_XDP userspace.   These two
> components can as illustrated here [1]+[2] can coordinate based on local
> BPF-prog BTF IDs.  This approach works as-is today, but patchset
> selftests examples don't use this and instead have a very static
> approach (that people will copy-paste).
>
> An unsolved problem with TX-hook is that it can also get packets from
> XDP_REDIRECT and even normal SKBs gets processed (right?).  How does the
> BPF-prog know if metadata is valid and intended to be used for e.g.
> requesting the timestamp? (imagine metadata size happen to match)

My assumption was the bpf program can do ifindex/netns filtering. Plus
maybe check that the meta_len is the one that's expected.
Will that be enough to handle XDP_REDIRECT?


> --Jesper
>
> BPF-prog API bpf_core_type_id_local:
>   - [1]
> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interactio=
n/af_xdp_kern.c#L80
>
> Userspace API btf__find_by_name_kind:
>   - [2]
> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interactio=
n/lib_xsk_extend.c#L185
>

