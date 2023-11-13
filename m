Return-Path: <bpf+bounces-15007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451B7EA140
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC280E7C
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA92233E;
	Mon, 13 Nov 2023 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp4faMSe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18221362;
	Mon, 13 Nov 2023 16:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5D8C433C7;
	Mon, 13 Nov 2023 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699892966;
	bh=rFA9qo+KavsfAkBCp0SvdYqsAEdix8gEFowhv7AczRM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rp4faMSeg+19SKsnboDdTo6OKFhdE28+p6fjruPfnrispp1WW32oTmd78gVDWLvlf
	 +z5E5beb2Ln0pcRLmsEjGnF9vQenMeubN14Uy5oUuTZ8anDOdGWADla3wSr8wb+la1
	 YZ4EGarxPX8plZaAZe6gR0m8eVR+o1bj/C+8S+1Wbk0fiTtxYy73wq9aAtYFoZVZ8N
	 lpL2JJn2IG6BbqwOcvXZC5gcWaxe6Ad5OVUSqfY0zOV3zh6E3wtYRJY7dfPlMSmVZd
	 tHFRkEGMrNcjrCxSb7T9u6BeW0pnljC7N4DaYl/eIhI+9lIWW++C4FH+4g+/2nROC1
	 CcSbY8UCJKJ3w==
Message-ID: <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org>
Date: Mon, 13 Nov 2023 17:29:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hawk@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org,
 willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, maciej.fijalkowski@intel.com, yoong.siang.song@intel.com,
 netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v5 02/13] xsk: Add TX timestamp and TX checksum
 offload support
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
References: <20231102225837.1141915-1-sdf@google.com>
 <20231102225837.1141915-3-sdf@google.com>
 <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org>
 <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/13/23 15:10, Stanislav Fomichev wrote:
> On Mon, Nov 13, 2023 at 5:16 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>> On 11/2/23 23:58, Stanislav Fomichev wrote:
>>> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
>>> index 2ecf79282c26..b0ee7ad19b51 100644
>>> --- a/include/uapi/linux/if_xdp.h
>>> +++ b/include/uapi/linux/if_xdp.h
>>> @@ -106,6 +106,41 @@ struct xdp_options {
>>>    #define XSK_UNALIGNED_BUF_ADDR_MASK \
>>>        ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
>>>
>>> +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
>>> + * field of struct xsk_tx_metadata.
>>> + */
>>> +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
>>> +
>>> +/* Request transmit checksum offload. Checksum start position and offset
>>> + * are communicated via csum_start and csum_offset fields of struct
>>> + * xsk_tx_metadata.
>>> + */
>>> +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 << 1)
>>> +
>>> +/* AF_XDP offloads request. 'request' union member is consumed by the driver
>>> + * when the packet is being transmitted. 'completion' union member is
>>> + * filled by the driver when the transmit completion arrives.
>>> + */
>>> +struct xsk_tx_metadata {
>>> +     union {
>>> +             struct {
>>> +                     __u32 flags;
>>> +
>>> +                     /* XDP_TXMD_FLAGS_CHECKSUM */
>>> +
>>> +                     /* Offset from desc->addr where checksumming should start. */
>>> +                     __u16 csum_start;
>>> +                     /* Offset from csum_start where checksum should be stored. */
>>> +                     __u16 csum_offset;
>>> +             } request;
>>> +
>>> +             struct {
>>> +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
>>> +                     __u64 tx_timestamp;
>>> +             } completion;
>>> +     };
>>> +};
>>
>> This looks wrong to me. It looks like member @flags is not avail at
>> completion time.  At completion time, I assume we also want to know if
>> someone requested to get the timestamp for this packet (else we could
>> read garbage).
> 
> I've moved the parts that are preserved across tx and tx completion
> into xsk_tx_metadata_compl.
> This is to address Magnus/Maciej feedback where userspace might race
> with the kernel.
> See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/
> 

Does this mean that every driver have to extend their TX-desc ring with
sizeof(struct xsk_tx_metadata_compl)?
Won't this affect the performance of this V5?

  $ pahole -C xsk_tx_metadata_compl 
./drivers/net/ethernet/stmicro/stmmac/stmmac.ko
  struct xsk_tx_metadata_compl {
	__u64 *              tx_timestamp;         /*     0     8 */

	/* size: 8, cachelines: 1, members: 1 */
	/* last cacheline: 8 bytes */
  };

Guess, I must be misunderstanding, as I was expecting to see the @flags
member being preserved across, as I get the race there.

Looking at stmmac driver, it does look like this xsk_tx_metadata_compl
is part of the TX-ring for completion (tx_skbuff_dma) and the
tx_timestamp data is getting stored here.  How is userspace AF_XDP
application getting access to the tx_timestamp data?
I though this was suppose to get stored in metadata data area (umem)?

Also looking at the code, the kernel would not have a "crash" race on
the flags member (if we preserve in struct), because the code checks the
driver HW-TS config-state + TX-descriptor for the availability of a
HW-TS in the descriptor.


>> Another thing (I've raised this before): It would be really practical to
>> store an u64 opaque value at TX and then read it at Completion time.
>> One use-case is a forwarding application storing HW RX-time and
>> comparing this to TX completion time to deduce the time spend processing
>> the packet.
> 
> This can be another member, right? But note that extending
> xsk_tx_metadata_compl might be a bit complicated because drivers have
> to carry this info somewhere. So we have to balance the amount of
> passed data between the tx and the completion.

I don't think my opaque value proposal is subject to same race problem.
I think this can be stores in metadata area and across tx and tx
completion, because any race on a flags change is the userspace
programmers problem, as it cannot cause any kernel crash (given kernel
have no need to read this).

--Jesper



