Return-Path: <bpf+bounces-15176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE7B7EE2D6
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B6CB20D1E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF72328C1;
	Thu, 16 Nov 2023 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8xb9+UL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB68328B7;
	Thu, 16 Nov 2023 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCEDC433C8;
	Thu, 16 Nov 2023 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700145064;
	bh=EhGHuwDh91cqarIXUDT3tp44P964N6cVpra9ZSSgrHQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N8xb9+ULvNniRwmzMdpxBtU8u7OyH+mGbDxyCcbK0uJacZTjERDbNmjFrqCHyY3qv
	 97gcZFgeT9L/lulv7LSGjCUfM3+cPCdrSR1xyS/sagSzpgQZWwj46Q0GGG1SJZue+w
	 pfRTQHAWokyDjTEFlSTQxlCgokaEHDpUk6rOsQQ6MLEpfFXvxrgWe0shARZKYaqmiE
	 nwm0lbYi/xO8RI70dFP2fmt6KzJqFgpFQOgelf4eFQINQPGzEboEgm4fs79OY8aNnr
	 7b9+q+3noy3GFEUMkE4VIJFqXwTfwSMCvb4vJLuLQHzXde5Um8+dAUMvjpVubhZRiN
	 mrsyKtNVMUz7g==
Message-ID: <a0dc04da-eb36-4824-b774-fd16f3f65875@kernel.org>
Date: Thu, 16 Nov 2023 15:30:55 +0100
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
 <2ed17b27-f211-4f58-95b5-5a71914264f3@kernel.org>
 <ZVJWuB4qtWfC-W_h@google.com>
 <be6186c1-52ee-42aa-b53c-39781af3a1ec@kernel.org>
 <ZVTJpLoSCaLoBa67@google.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ZVTJpLoSCaLoBa67@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/15/23 14:37, Stanislav Fomichev wrote:
> On 11/15, Jesper Dangaard Brouer wrote:
>>
>>
>> On 11/13/23 18:02, Stanislav Fomichev wrote:
>>> On 11/13, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 11/13/23 15:10, Stanislav Fomichev wrote:
>>>>> On Mon, Nov 13, 2023 at 5:16 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/2/23 23:58, Stanislav Fomichev wrote:
>>>>>>> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
>>>>>>> index 2ecf79282c26..b0ee7ad19b51 100644
>>>>>>> --- a/include/uapi/linux/if_xdp.h
>>>>>>> +++ b/include/uapi/linux/if_xdp.h
>>>>>>> @@ -106,6 +106,41 @@ struct xdp_options {
>>>>>>>      #define XSK_UNALIGNED_BUF_ADDR_MASK \
>>>>>>>          ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
>>>>>>>
>>>>>>> +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
>>>>>>> + * field of struct xsk_tx_metadata.
>>>>>>> + */
>>>>>>> +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
>>>>>>> +
>>>>>>> +/* Request transmit checksum offload. Checksum start position and offset
>>>>>>> + * are communicated via csum_start and csum_offset fields of struct
>>>>>>> + * xsk_tx_metadata.
>>>>>>> + */
>>>>>>> +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 << 1)
>>>>>>> +
>>>>>>> +/* AF_XDP offloads request. 'request' union member is consumed by the driver
>>>>>>> + * when the packet is being transmitted. 'completion' union member is
>>>>>>> + * filled by the driver when the transmit completion arrives.
>>>>>>> + */
>>>>>>> +struct xsk_tx_metadata {
>>>>>>> +     union {
>>>>>>> +             struct {
>>>>>>> +                     __u32 flags;
>>>>>>> +
>>>>>>> +                     /* XDP_TXMD_FLAGS_CHECKSUM */
>>>>>>> +
>>>>>>> +                     /* Offset from desc->addr where checksumming should start. */
>>>>>>> +                     __u16 csum_start;
>>>>>>> +                     /* Offset from csum_start where checksum should be stored. */
>>>>>>> +                     __u16 csum_offset;
>>>>>>> +             } request;
>>>>>>> +
>>>>>>> +             struct {
>>>>>>> +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
>>>>>>> +                     __u64 tx_timestamp;
>>>>>>> +             } completion;
>>>>>>> +     };
>>>>>>> +};
>>>>>>
>>>>>> This looks wrong to me. It looks like member @flags is not avail at
>>>>>> completion time.  At completion time, I assume we also want to know if
>>>>>> someone requested to get the timestamp for this packet (else we could
>>>>>> read garbage).
>>>>>
>>>>> I've moved the parts that are preserved across tx and tx completion
>>>>> into xsk_tx_metadata_compl.
>>>>> This is to address Magnus/Maciej feedback where userspace might race
>>>>> with the kernel.
>>>>> See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/
>>>>>
>>>>
>>>> Does this mean that every driver have to extend their TX-desc ring with
>>>> sizeof(struct xsk_tx_metadata_compl)?
>>>> Won't this affect the performance of this V5?
>>>
>>> Yes, but it doesn't have to be a descriptor. Might be some internal
>>> driver completion queue (as in the case of mlx5). And definitely does
>>> affect performance :-( (see all the static branches to disable it)
>>>>    $ pahole -C xsk_tx_metadata_compl
>>>> ./drivers/net/ethernet/stmicro/stmmac/stmmac.ko
>>>>    struct xsk_tx_metadata_compl {
>>>> 	__u64 *              tx_timestamp;         /*     0     8 */
>>>>
>>>> 	/* size: 8, cachelines: 1, members: 1 */
>>>> 	/* last cacheline: 8 bytes */
>>>>    };
>>>>
>>>> Guess, I must be misunderstanding, as I was expecting to see the @flags
>>>> member being preserved across, as I get the race there.
>>>>
>>>> Looking at stmmac driver, it does look like this xsk_tx_metadata_compl
>>>> is part of the TX-ring for completion (tx_skbuff_dma) and the
>>>> tx_timestamp data is getting stored here.  How is userspace AF_XDP
>>>> application getting access to the tx_timestamp data?
>>>> I though this was suppose to get stored in metadata data area (umem)?
>>>>
>>>> Also looking at the code, the kernel would not have a "crash" race on
>>>> the flags member (if we preserve in struct), because the code checks the
>>>> driver HW-TS config-state + TX-descriptor for the availability of a
>>>> HW-TS in the descriptor.
>>>
>>> xsk_tx_metadata_compl stores a pointer to the completion timestamp
>>> in the umem, so everything still arrives via the metadata area.
>>>
>>> We want to make sure the flags are not changing across tx and tx completion.
>>> Instead of saving the flags, we just use that xsk_tx_metadata_compl to
>>> signal to the completion that "I know that I've requested the tx
>>> completion timestamp, please put it at this address in umem".
>>>
>>> I store the pointer instead of flags to avoid doing pointer math again
>>> at completion. But it's an implementation detail and somewhat abstracted
>>> from the drivers (besides the fact that it's probably has to fit in 8
>>> bytes).
>>
>> I see it now (what I missed). At TX time you are storing a pointer where
>> to (later) write the TS at completion time.  It just seems overkill to
>> store 8 byte (pointer) to signal (via NULL) if the HWTS was requested.
>> Space in the drivers TX-ring is performance critical, and I think driver
>> developers would prefer to find a bit to indicate HWTS requested.
>>
>> If HWTS was *NOT* requested, then the metadata area will not be updated
>> (right, correct?). Then memory area is basically garbage that survived.
>> How does the AF_XDP application know this packet contains a HWTS or not?
>>
>>  From an UAPI PoV wouldn't it be easier to use (and extend) via keeping
>> the @flags member (in struct xsk_tx_metadata), but (as you already do)
>> not let kernel checks depend on it (to avoid the races).
> 
> I was assuming the userspace can keep this signal out of band or use
> the same idea as suggested with padding struct xsk_tx_metadata to keep
> some data around. But I see your point, it might be convenient to
> keep the original flags around during completion on the uapi side.
> 
> I think I can just move flags from the request union member to the outer
> struct. So the struct xsk_tx_metadata would look like:
> 
> struct xsk_tx_metadata {
> 	__u32 flags; /* maybe can even make this u64? */
> 

Yes to u64 for two reasons (1) this becomes UAPI and
(2) better alignment for tx_timestamp.
But I'm open to keeping it u32.

> 	union {
> 		__u16 csum_start;
> 		__u16 csum_offset;
> 	} request;
> 
> 	union {
> 		__u64 tx_timestamp;
> 	} completion;
> 
> 	__u32 padding; /* to drop this padding */
> };
> 
> But I'd also keep the existing xsk_tx_metadata_compl to carry the
> pointer+signal around. As I mentioned previously, it's completely
> opaque to the driver and we can change the internals in the future.
> 

Sure, it is an implementation detail and my objections are mostly that I
don't find it as a pretty code approach that can be hard to follow.
Maybe driver developer will object and change this later if it cost too
much to increase the element size in their TX-ring queues.

> IOW, we won't override the flags from the kernel side and as long
> as the userspace consumer doesn't mess them up it should receive
> the original value at completion.
> 
> Would that work for you?

Yes, that will work for me, thanks!

--Jesper

