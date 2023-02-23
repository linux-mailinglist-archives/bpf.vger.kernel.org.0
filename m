Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695A6A0A5B
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 14:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBWNTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 08:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjBWNTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 08:19:13 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB64AFD6
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 05:19:10 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pVBV3-00077r-Mg; Thu, 23 Feb 2023 08:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
        From; bh=Fd7v4Q9SarRbklpd7FFW8IZ21xM2OD+pdu8JV5+3+qc=; b=ebRTcrGgg4zTqd3sQeBy
        COiEp7kPpxKe/GbbNnlXkXwGKPAkIsqkcJfb6qcJ6i3PGzDGelccttDZNFSI42xb5QWJhCghK+0UU
        2rnrfQE3Tr4K1rLh++84hOrSdko2ggnCTH81vE2yh1RFGKsMhQMu3WZafzA5DlWbxhoXlUBzJyCyB
        ymWIe/hRykrQb09HCQIh0WWUdyvmigNmJZptWr/YZjCgl1+93ld2i1BIfnKaLrGFbJvXp78E8t0a0
        xUeEdTe+AjZjtIRcXSMxk6LgAXJQ2dF8TjwDy2UcS4fvRpbh1gj87vS6gyiIQdRfDcULbfttDFuhX
        UQmwIeS5u/2kiA==;
Received: from [141.143.193.75] (helo=termi)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1pVBV2-00087m-B3; Thu, 23 Feb 2023 08:19:05 -0500
From:   "Jose E. Marchesi" <jemarch@gnu.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
In-Reply-To: <CAADnVQ+k5HrxJbpi17yeowsP9f92fSbnpSXfndMrZ8r=zhx1mg@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 22 Feb 2023 17:56:43 -0800")
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
        <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com>
        <87ttzdwagy.fsf@oracle.com>
        <CAADnVQ+k5HrxJbpi17yeowsP9f92fSbnpSXfndMrZ8r=zhx1mg@mail.gmail.com>
Date:   Thu, 23 Feb 2023 14:18:51 +0100
Message-ID: <87bklkseo4.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Wed, Feb 22, 2023 at 3:23 PM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Mon, Feb 20, 2023 at 2:37 PM Dave Thaler
>> > <dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
>> >>
>> >> From: Dave Thaler <dthaler@microsoft.com>
>> >>
>> >> Document the discussion from the email thread on the IETF bpf list,
>> >> where it was explained that the raw format varies by endianness
>> >> of the processor.
>> >>
>> >> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
>> >>
>> >> Acked-by: David Vernet <void@manifault.com>
>> >> ---
>> >>
>> >> V1 -> V2: rebased on top of latest master
>> >> ---
>> >>  Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
>> >>  1 file changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> >> index af515de5fc3..1d473f060fa 100644
>> >> --- a/Documentation/bpf/instruction-set.rst
>> >> +++ b/Documentation/bpf/instruction-set.rst
>> >> @@ -38,8 +38,9 @@ eBPF has two instruction encodings:
>> >>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>> >>    constant) value after the basic instruction for a total of 128 bits.
>> >>
>> >> -The basic instruction encoding is as follows, where MSB and LSB mean the most significant
>> >> -bits and least significant bits, respectively:
>> >> +The basic instruction encoding looks as follows for a little-endian processor,
>> >> +where MSB and LSB mean the most significant bits and least significant bits,
>> >> +respectively:
>> >>
>> >>  =============  =======  =======  =======  ============
>> >>  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> >> @@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
>> >>  **opcode**
>> >>    operation to perform
>> >>
>> >> +and as follows for a big-endian processor:
>> >> +
>> >> +=============  =======  ====================  ===============  ============
>> >> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
>> >> +=============  =======  ====================  ===============  ============
>> >> +immediate      offset   destination register  source register  opcode
>> >> +=============  =======  ====================  ===============  ============
>> >
>> > I've changed it to:
>> > imm            offset   dst_reg  src_reg  opcode
>> >
>> > to match the little endian table,
>> > but now one of the tables feels wrong.
>> > The encoding is always done by applying C standard to the struct:
>> > struct bpf_insn {
>> >         __u8    code;           /* opcode */
>> >         __u8    dst_reg:4;      /* dest register */
>> >         __u8    src_reg:4;      /* source register */
>> >         __s16   off;            /* signed offset */
>> >         __s32   imm;            /* signed immediate constant */
>> > };
>> > I'm not sure how to express this clearly in the table.
>>
>> Perhaps it would be simpler to document how the instruction bytes are
>> stored (be it in an ELF file or as bytes in a memory buffer to be loaded
>> into the kernel or some other BPF consumer) as opposed to how the
>> instructions look like once loaded (as a 64-bit word) by a little-endian
>> or big-endian kernel?
>>
>> Stored little-endian BPF instructions:
>>
>>   code src_reg dst_reg off imm
>>
>>   foo-le.o:     file format elf64-bpfle
>>
>>   0000000000000000 <.text>:
>>      0:   07 01 00 00 ef be ad de         r1 += 0xdeadbeef
>>
>> Stored big-endian BPF instructions:
>>
>>   code dst_reg src_reg off imm
>>
>>   foo-be.o:     file format elf64-bpfbe
>>
>>   0000000000000000 <.text>:
>>      0:   07 10 00 00 de ad be ef         r1 += 0xdeadbeef
>>
>> i.e. in the stored bytes the code always comes first, then the
>> registers, then the offset, then the immediate, regardless of
>> endianness.
>>
>> This may be easier to understand by implementors looking to generate
>> and/or consume bytes conforming BPF instructions.
>
> +1
> I like this format more as well.
> Maybe we can drop the table and use a diagram of a kind ?
>
> opcode src dst offset imm          assembly
> 07     0   1   00 00  ef be ad de  r1 += 0xdeadbeef // little
> 07     1   0   00 00  de ad be ef  r1 += 0xdeadbeef // big

Good idea.  What about something like this:

opcode         offset imm          assembly
       src dst
07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
       dst src
07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big

I changed the immediate because 0xdeadbeef is negative and it may be
confusing in the assembly part: strictly it would be r1 += -559038737.
