Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2434885ED
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiAHUoq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 15:44:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbiAHUop (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Jan 2022 15:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641674685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntWXCZ0zQqxqP5Huo89Rt3JcytilS4abkDUzM44/CDw=;
        b=LRBJLK1LJ2q0NH2QJvk4OgOm8eV4bj9pzLNhY0nrI1dEPcn/lH7+DyEA3Ops02K6ExYDIN
        S3KqXe0D0kVttt9axdVxmQeHB+sqCnIEjmK9FHLhLDHwjcuPKLERz8Y9JFPEirDLi+Az5e
        RHdpI+uc/tnlOiOL171Gr5eq6mszuVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-f8MA7buxMNSNKmGdZJoPKw-1; Sat, 08 Jan 2022 15:44:44 -0500
X-MC-Unique: f8MA7buxMNSNKmGdZJoPKw-1
Received: by mail-wm1-f71.google.com with SMTP id c5-20020a1c3505000000b00345c92c27c6so6955637wma.2
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 12:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ntWXCZ0zQqxqP5Huo89Rt3JcytilS4abkDUzM44/CDw=;
        b=Aoh9EdYC6ova/CS0b+QFDwv1XLnZPjTgz1RZrcSQ4lMV7sfLTyMa/feeSK1Be6xtBe
         Q3dPkhaSaLDmUrwxTv30i3eFHmwCHnZjSneMhRaVeM49xo32lf66JCKYZdC4OFpQTMeE
         vjm7XTW9Ydcm2b3y23oiRb2iSuCa+E7eWqLmbW0qTedXaOYvPA5+kjdXtV2tQp4QCGiz
         tbUa5Ps+/y7cM4XenrCzRB2yznAiYW+3LbiiiLUNf3tg4WikoqiAURLQCwS0P0S428s/
         yMyhueLD6F7tXa2kJvLNTOvCDUm2vQ23pwCnit0DZ3/c0lmWTZ+XUrzdQ+AGW8oX3Vp9
         FkKg==
X-Gm-Message-State: AOAM533XU1DpbhghF2jBmUALi5sMRON8wSh3yg026JS7kICAZN2wCZ0w
        qe68GPo56XbzjncDhYM2bpIDSp9qvEap2QNiD5ih0EAxmKn35qWJwGynB4HvCpTZHMuD6sVVdYD
        EhU9dgd0fZkeR
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr66408588edc.106.1641673186598;
        Sat, 08 Jan 2022 12:19:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFddTMrlHD0e5Tu9X/R343LKoyfXwZWg4G6FoZBSbHBzKmZDMMz1lo46gl6AgIXwgY7cfzAg==
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr66408546edc.106.1641673185497;
        Sat, 08 Jan 2022 12:19:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c8sm1121981edu.60.2022.01.08.12.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:19:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 071A5181F2A; Sat,  8 Jan 2022 21:19:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Add "live packet" mode for XDP in
 bpf_prog_run()
In-Reply-To: <CAADnVQLWjbm03-3NHYyEx98tWRN68LSaOd3R9fjJoHY5cYoEJg@mail.gmail.com>
References: <20220107215438.321922-1-toke@redhat.com>
 <20220107215438.321922-2-toke@redhat.com>
 <CAADnVQ+uftgnRQa5nvG4FTJga_=_FMAGxuiPB3O=AFKfEdOg=A@mail.gmail.com>
 <87pmp28iwe.fsf@toke.dk>
 <CAADnVQLWjbm03-3NHYyEx98tWRN68LSaOd3R9fjJoHY5cYoEJg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 08 Jan 2022 21:19:41 +0100
Message-ID: <87mtk67zfm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jan 8, 2022 at 5:19 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Sure, can do. Doesn't look like BPF_PROG_RUN is documented in there at
>> all, so guess I can start such a document :)
>
> prog_run was simple enough.
> This live packet mode is a different level of complexity.
> Just look at the length of this thread.
> We keep finding implementation details that will be relevant
> to anyone trying to use this interface.
> They all will become part of uapi.

Sure, totally fine with documenting it. Just seems to me the most
obvious place to put this is in a new
Documentation/bpf/prog_test_run.rst file with a short introduction about
the general BPF_PROG_RUN mechanism, and then a subsection dedicated to
this facility.

Or would you rather I create something like
Documentation/bpf/xdp_live_packets.rst ?

>> > Another question comes to mind:
>> > What happens when a program modifies the packet?
>> > Does it mean that the 2nd frame will see the modified data?
>> > It will not, right?
>> > It's the page pool size of packets that will be inited the same way
>> > at the beginning. Which is NAPI_POLL_WEIGHT * 2 =3D=3D 128 packets.
>> > Why this number?
>>
>> Yes, you're right: the next run won't see the modified packet data. The
>> 128 pages is because we run the program loop in batches of 64 (like NAPI
>> does, the fact that TEST_XDP_BATCH and NAPI_POLL_WEIGHT are the same is
>> not a coincidence).
>>
>> We need 2x because we want enough pages so we can keep running without
>> allocating more, and the first batch can still be in flight on a
>> different CPU while we're processing batch 2.
>>
>> I experimented with different values, and 128 was the minimum size that
>> didn't have a significant negative impact on performance, and above that
>> saw diminishing returns.
>
> I guess it's ok-ish to get stuck with 128.
> It will be uapi that we cannot change though.
> Are you comfortable with that?

UAPI in what sense? I'm thinking of documenting it like:

"The packet data being supplied as data_in to BPF_PROG_RUN will be used
 for the initial run of the XDP program. However, when running the
 program multiple times (with repeat > 1), only the packet *bounds*
 (i.e., the data, data_end and data_meta pointers) will be reset on each
 invocation, the packet data itself won't be rewritten. The pages
 backing the packets are recycled, but the order depends on the path the
 packet takes through the kernel, making it hard to predict when a
 particular modified page makes it back to the XDP program. In practice,
 this means that if the XDP program modifies the packet payload before
 sending out the packet, it has to be prepared to deal with subsequent
 invocations seeing either the initial data or the already-modified
 packet, in arbitrary order."

I don't think this makes any promises about any particular size of the
page pool, so how does it constitute UAPI?

>> > Should it be configurable?
>> > Then the user can say: init N packets with this one pattern
>> > and the program will know that exactly N invocation will be
>> > with the same data, but N+1 it will see the 1st packet again
>> > that potentially was modified by the program.
>> > Is it accurate?
>>
>> I thought about making it configurable, but the trouble is that it's not
>> quite as straight-forward as the first N packets being "pristine": it
>> depends on what happens to the packet afterwards:
>>
>> On XDP_DROP, the page will be recycled immediately, whereas on
>> XDP_{TX,REDIRECT} it will go through the egress driver after sitting in
>> the bulk queue for a little while, so you can get reordering compared to
>> the original execution order.
>>
>> On XDP_PASS the kernel will release the page entirely from the pool when
>> building an skb, so you'll never see that particular page again (and
>> eventually page_pool will allocate a new batch that will be
>> re-initialised to the original value).
>
> That all makes sense. Thanks for explaining.
> Please document it and update the selftest.
> Looks like XDP_DROP is not tested.
> Single packet TX and REDIRECT is imo too weak to give
> confidence that the mechanism will not explode with millions of
> packets.

OK, will do.

>> If we do want to support a "pristine data" mode, I think the least
>> cumbersome way would be to add a flag that would make the kernel
>> re-initialise the packet data before every program invocation. The
>> reason I didn't do this was because I didn't have a use case for it. The
>> traffic generator use case only rewrites a tiny bit of the packet
>> header, and it's just as easy to just keep rewriting it without assuming
>> a particular previous value. And there's also the possibility of just
>> calling bpf_prog_run() multiple times from userspace with a lower number
>> of repetitions...
>>
>> I'm not opposed to adding such a flag if you think it would be useful,
>> though. WDYT?
>
> reinit doesn't feel necessary.
> How one would use this interface to send N different packets?
> The api provides an interface for only one.

By having the XDP program react appropriately. E.g., here is the XDP
program used by the trafficgen tool to cycle through UDP ports when
sending out the packets - it just reads the current value and updates
based on that, so it doesn't matter if it sees the initial page or one
it already modified:

const volatile __u16 port_start;
const volatile __u16 port_range;
volatile __u16 next_port =3D 0;

SEC("xdp")
int xdp_redirect_update_port(struct xdp_md *ctx)
{
	void *data_end =3D (void *)(long)ctx->data_end;
	void *data =3D (void *)(long)ctx->data;
	__u16 cur_port, cksum_diff;
	struct udphdr *hdr;

	hdr =3D data + (sizeof(struct ethhdr) + sizeof(struct ipv6hdr));
	if (hdr + 1 > data_end)
		return XDP_ABORTED;

	cur_port =3D bpf_ntohs(hdr->dest);
	cksum_diff =3D next_port - cur_port;
	if (cksum_diff) {
		hdr->check =3D bpf_htons(~(~bpf_ntohs(hdr->check) + cksum_diff));
		hdr->dest =3D bpf_htons(next_port);
	}
	if (next_port++ >=3D port_start + port_range - 1)
		next_port =3D port_start;

	return bpf_redirect(ifindex_out, 0);
}

You could do something similar with a whole packet header or payload; or
you could even populate a map with the full-size packets and copy that
in based on a counter.

> It will be copied 128 times, but the prog_run call with repeat=3D1
> will invoke bpf prog only once, right?
> So technically doing N prog_run commands with different data
> and repeat=3D1 will achieve the result, right?
> But it's not efficient, since 128 pages and 128 copies will be
> performed each time.
> May be there is a use case for configurable page_pool size?

Hmm, we could size the page_pool as min(repeat, 128) to avoid the extra
copies when they won't be used?

Another question seeing as the merge window is imminent: How do you feel
about merging this before the merge window? I can resubmit before it
opens with the updated selftest and documentation, and we can deal with
any tweaks during the -rcs; or would you rather postpone the whole
thing until the next cycle?

-Toke

