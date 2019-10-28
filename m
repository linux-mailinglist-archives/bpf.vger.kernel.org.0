Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF1E6E54
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2019 09:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfJ1Ig3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 04:36:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731608AbfJ1Ig3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Oct 2019 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572251787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRuL2BkbB+a2GJ+8JaKpKSwC2v1Z0RtMywL1CPTxmnM=;
        b=Fq7QE4WmfktjcTd7HLQa/mKOo44XydN+p9LXxPvGxk6PtJoT7D4tSrKy3Lz9JCS38ppGTg
        YUeQwUGsnpyMNVjXp8ohxf7/SDmlSVfunYP+bPqeTNe72k4QEDnEAFqIzTscHA0Y/lGiDx
        DbE5uZW7CAUoH+fXny/viLfOmkmOp2I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-PLJ8I5zDMOuLo3Aag0eB6A-1; Mon, 28 Oct 2019 04:36:25 -0400
Received: by mail-lf1-f72.google.com with SMTP id s30so2133942lfo.9
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JRuL2BkbB+a2GJ+8JaKpKSwC2v1Z0RtMywL1CPTxmnM=;
        b=rMpBkjjZRUdT7Jn3BaWIt8an7QLamKaDb9gkeoPbo5J85m+XAPpZLVIlFwlFvdanT5
         6M3NVndwZaYj2NixCCovg7CWY5mAwyxJ7VDYaIdpSxDgGhDten3FbeiTs+u2wk81g+Hu
         YigExS4DuODcUQan0H5mRlXFSa2jJcTzOT2/9qhjnArnyaqToKXWZUZiWGMY79L0OaJA
         1cBTOhC/C4BDz0LuZ4dY2Blqis8y4coOXuQLuCgWeRKhe0WaTUmrFTv+U7M1bVhPBVpD
         k8vkjHCdh81oMCWqsctvwESJp6PLYgwHOy3r+EbEi8Gp+WTg1100LVRi/Oxn8u0QXUna
         tfpQ==
X-Gm-Message-State: APjAAAWQMFpHh19nxRE77DwCl8M2iBCRAcuscWfiz7VBAEq14gKo15PG
        hiD3mu6dGyxuLB7k+7nRwnd4E4AVTQM/46upIJTYQh6m54pYjYTHIv//zbRF4XXgdgEED+4venl
        Ra+MbIXER/+TY
X-Received: by 2002:ac2:5c1b:: with SMTP id r27mr10568394lfp.172.1572251783813;
        Mon, 28 Oct 2019 01:36:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybrSiG3iGTQBRgdSqi/nOXWRKJK0ZAvTlqP1CnZDT99j5pVGWuRBov3U5MLvB6wWlxd1tV/A==
X-Received: by 2002:ac2:5c1b:: with SMTP id r27mr10568368lfp.172.1572251783528;
        Mon, 28 Oct 2019 01:36:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y28sm4846689lfg.31.2019.10.28.01.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 01:36:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AB6DF1800E2; Mon, 28 Oct 2019 09:36:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@gmail.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Pravin B Shelar <pshelar@ovn.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        William Tu <u9012063@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC PATCH v2 bpf-next 00/15] xdp_flow: Flow offload to XDP
In-Reply-To: <47f1a7e2-0d3a-e324-20c5-ba3aed216ddf@gmail.com>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch> <87sgniladm.fsf@toke.dk> <a7f3d86b-c83c-7b0d-c426-684b8dfe4344@gmail.com> <87zhhmrz7w.fsf@toke.dk> <47f1a7e2-0d3a-e324-20c5-ba3aed216ddf@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 28 Oct 2019 09:36:12 +0100
Message-ID: <87o8y1s1vn.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: PLJ8I5zDMOuLo3Aag0eB6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 10/27/19 9:21 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Rather, what we should be doing is exposing the functionality through
>> helpers so XDP can hook into the data structures already present in the
>> kernel and make decisions based on what is contained there. We already
>> have that for routing; L2 bridging, and some kind of connection
>> tracking, are obvious contenders for similar additions.
>
> The way OVS is coded and expected to flow (ovs_vport_receive ->
> ovs_dp_process_packet -> ovs_execute_actions -> do_execute_actions) I do
> not see any way to refactor it to expose a hook to XDP. But, if the use
> case is not doing anything big with OVS (e.g., just ACLs and forwarding)
> that is easy to replicate in XDP - but then that means duplicate data
> and code.

Yeah, I didn't mean that part for OVS, that was a general comment for
reusing kernel functionality.

> Linux bridge on the other hand seems fairly straightforward to
> refactor. One helper is needed to convert ingress <port,mac,vlan> to
> an L2 device (and needs to consider stacked devices) and then a second
> one to access the fdb for that device.

Why not just a single lookup like what you did for routing? Not too
familiar with the routing code...

> Either way, bypassing the bridge has mixed results: latency improves
> but throughput takes a hit (no GRO).

Well, for some traffic mixes XDP should be able to keep up without GRO.
And longer term, we probably want to support GRO with XDP anyway
(I believe Jesper has plans for supporting bigger XDP frames)...

-Toke

