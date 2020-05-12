Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8A1D00D6
	for <lists+bpf@lfdr.de>; Tue, 12 May 2020 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgELVZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 17:25:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:37744 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgELVZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 May 2020 17:25:43 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYcPD-0006d6-Kf; Tue, 12 May 2020 23:25:39 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYcPD-0002aW-Cs; Tue, 12 May 2020 23:25:39 +0200
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
 <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
 <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
Date:   Tue, 12 May 2020 23:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25810/Tue May 12 14:14:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/20 11:29 AM, Lorenz Bauer wrote:
> On Thu, 7 May 2020 at 17:43, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 5/7/20 5:54 PM, Lorenz Bauer wrote:
>>> On Wed, 6 May 2020 at 22:55, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 5/6/20 6:24 PM, Lorenz Bauer wrote:
>>>>> On Wed, 6 May 2020 at 02:28, Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>> On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>>>>>>
>>>>>>> In our TC classifier cls_redirect [1], we use the following sequence
>>>>>>> of helper calls to
>>>>>>> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
>>>>>>>
>>>>>>>      skb_adjust_room(skb, -encap_len,
>>>>>>> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
>>>>>>>      bpf_redirect(skb->ifindex, BPF_F_INGRESS)
>>>>>>>
>>>>>>> It seems like some checksums of the inner headers are not validated in
>>>>>>> this case.
>>>>>>> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
>>>>>>> network stack and elicits a SYN ACK.
>>>>>>>
>>>>>>> Is this known but undocumented behaviour or a bug? In either case, is
>>>>>>> there a work
>>>>>>> around I'm not aware of?
>>>>>>
>>>>>> I thought inner and outer csums are covered by different flags and driver
>>>>>> suppose to set the right one depending on level of in-hw checking it did.
>>>>>
>>>>> I've figured out what the problem is. We receive the following packet from
>>>>> the driver:
>>>>>
>>>>>        | ETH | IP | UDP | GUE | IP | TCP |
>>>>>        skb->ip_summed == CHECKSUM_UNNECESSARY
>>>>>
>>>>> ip_summed is CHECKSUM_UNNECESSARY because our NICs do rx
>>>>> checksum offloading. On this packet we run skb_adjust_room_mac(-encap),
>>>>> and get the following:
>>>>>
>>>>>        | ETH | IP | TCP |
>>>>>        skb->ip_summed == CHECKSUM_UNNECESSARY
>>>>>
>>>>> Note that ip_summed is still CHECKSUM_UNNECESSARY. After
>>>>> bpf_redirect()ing into the ingress, we end up in tcp_v4_rcv. There
>>>>> skb_checksum_init is turned into a no-op due to
>>>>> CHECKSUM_UNNECESSARY.
>>>>>
>>>>> I think this boils down to bpf_skb_generic_pop not adjusting ip_summed
>>>>> accordingly. Unfortunately I don't understand how checksums work
>>>>> sufficiently. Daniel, it seems like you wrote the helper, could you
>>>>> take a look?
>>>>
>>>> Right, so in the skb_adjust_room() case we're not aware of protocol
>>>> specifics. We do handle the csum complete case via skb_postpull_rcsum(),
>>>> but not CHECKSUM_UNNECESSARY at the moment. I presume in your case the
>>>> skb->csum_level of the original skb prior to skb_adjust_room() call
>>>> might have been 0 (that is, covering UDP)? So if we'd add the possibility
>>>> to __skb_decr_checksum_unnecessary() via flag, then it would become
>>>> skb->ip_summed = CHECKSUM_NONE? And to be generic, we'd need to do the
>>>> same for the reverse case. Below is a quick hack (compile tested-only);
>>>> would this resolve your case ...
>>>
>>> Thanks for the patch, it indeed fixes our problem! I spent some more time
>>> trying to understand the checksum offload stuff, here is where I am:
>>>
>>> On NICs that don't support hardware offload ip_summed is CHECKSUM_NONE,
>>> everything works by default since the rest of the stack does checksumming in
>>> software.
>>>
>>> On NICs that support CHECKSUM_COMPLETE, skb_postpull_rcsum
>>> will adjust for the data that is being removed from the skb. The rest of the
>>> stack will use the correct value, all is well.
>>>
>>> However, we're out of luck on NICs that do CHECKSUM_UNNECESSARY:
>>> the API of skb_adjust_room doesn't tell us whether the user intends to
>>> remove headers or data, and how that will influence csum_level.
>>>   From my POV, skb_adjust_room currently does the wrong thing.
>>> I think we need to fix skb_adjust_room to do the right thing by default,
>>> rather than extending the API. We spent a lot of time on tracking this down,
>>> so hopefully we can spare others the pain.
>>>
>>> As Jakub alludes to, we don't know when and how often to call
>>> __skb_decr_checksum_unnecessary so we should just
>>> unconditionally downgrade a packet to CHECKSUM_NONE if we encounter
>>> CHECKSUM_UNNECESSARY in bpf_skb_generic_pop. It sounds simple
>>> enough to land as a fix via the bpf tree (which is important for our
>>> production kernel). As a follow up we could add the inverse of the flags you
>>> propose via bpf-next.
>>>
>>> What do you think?
>>
>> My concern with unconditionally downgrading a packet to CHECKSUM_NONE would
>> basically trash performance if we have to fallback to sw in fast-path, these
>> helpers are also used in our LB case for DSR, for example.
> 
> Our setup also uses DSR, so I wonder how you manage to avoid this
> checksum issue.
> Why is Cilium not affected by this bug as well? You never pop headers?

We have different modes in our LB on how to apply DSR: pure DSR and hybrid. In
pure DSR, DSR is used for TCP and UDP, and in hybrid we use DSR for TCP and SNAT
for UDP (under the assumption that the main workload is on TCP anyway). For the
proto under DSR we basically use ctx_adjust_room(ctx, 8, BPF_ADJ_ROOM_NET, 0)
for IPv4 and similar ctx_adjust_room() for IPv6 (just of different size). Meaning
we push/pop an IP option for these cases w/ svc IP/port (for TCP under DSR only
in the SYN, but not subsequent packets). Now in the example of CHECKSUM_UNNECESSARY
("skb->csum_level indicates the number of consecutive checksums found in the packet
minus one that have been verified as CHECKSUM_UNNECESSARY. For instance if a device
receives an IPv6->UDP->GRE->IPv4->TCP packet and a device is able to verify the
checksums for UDP (possibly zero), GRE (checksum flag is set) and TCP, skb->csum_level
would be set to two") the IP hdr does not account for it, which might also explain
why we haven't seen it on our side so far.

> FWIW, currently the only work around I know is to disable rx
> checksumming for ALL
> inbound traffic via ethtool -K bla rx off. Which in theory trashes
> performance for all
> RX traffic, not just the one going to the load balancer. I applied this in a
> couple of production data centers, and did not see an increase in
> softirq, which is
> where I assume this would show up. My guess is that this is because our
> RX << TX. Unconditionally setting CHECKSUM_NONE would be even less visible,
> since we could turn rx checksumming back on in the general case.
> Is there a way for you to quantify what the impact for Cilium would be?
> 
>> I agree that it
>> sucks to expose these implementation details though. So eventually we'd end
>> up with 3 csum flags: inc/dec/reset to none. bpf_skb_adjust_room() is already
>> a complex to use helper with all its flags where you end up looking into the
>> implementation detail to understand what it is really doing. I'm not sure if
>> we make anything worse, but I do see your concern. :/
> 
> Having those flags seems fine to me, you're right that it's already complicated.
> My concern is really with the current state of the helper however: I think that
> as it exists right now it's buggy wrt checksum offload, and we need a
> backportable fix.
> 
> Option 1: always downgrade UNNECESSARY to NONE
> - Easiest to back port
> - The helper is safe by default
> - Performance impact unclear
> - No escape hatch for Cilium
> 
> Option 2: add a flag to force CHECKSUM_NONE
> - New UAPI, can this be backported?
> - The helper isn't safe by default, needs documentation
> - Escape hatch for Cilium
> 
> Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
> - New UAPI, can this be backported?
> - The helper is safe by default
> - Escape hatch for Cilium (though you'd need to detect availability of the
>    flag somehow)

This seems most reasonable to me; I can try and cook a proposal for tomorrow as
potential fix. Even if we add a flag, this is still backportable to stable (as
long as the overall patch doesn't get too complex and the backport itself stays
compatible uapi-wise to latest kernels. We've done that before.). I happen to
have two ixgbe NICs on some of my test machines which seem to be setting the
CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.

> I guess there is also Option 0, add a flag but don't backport, which to
> me is admitting defeat. If we were to do that we'd at least
> want to document the problem. Thinking about how to do that already
> makes my head spin:
> 
> - If you have a NIC that does CHECKSUM_UNNECESSARY
> - And you pop network headers
> - You will run into this bug
> - To fix it you have to disable rx checksum offload
> 
> How do users figure out whether a NIC does UNNECESSARY vs. COMPLETE
> vs. NONE? I have the luxury of only caring about two different drivers, but
> what if I ship BPF (like Cilium does)? Ultimately vendors would either have
> buggy programs, or would tell people to unconditionally disable rx
> checksumming I believe.
> 
>  From my POV, I'd prefer option 1 or 3, since I strongly believe that the
> helper should be safe by default, and that the user can assert invariants
> via flags to get better performance.I could live with option 2 as well since
> I just have to care about a single kernel version.
> 
>> (We do have bpf_csum_update()
>> helper as well. I wonder whether we should split such control into a different
>> helper.)
> 
> I'm not sure what you mean, maybe you can elaborate a little?

Meaning, a different helper to control these settings, e.g. bpf_csum_adjust(skb,
{inc/dec/..}) which would then fall into option 2 category though.

Thanks,
Daniel
