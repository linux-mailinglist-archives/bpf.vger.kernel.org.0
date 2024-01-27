Return-Path: <bpf+bounces-20451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759183EAA3
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 04:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF702878C2
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E051170F;
	Sat, 27 Jan 2024 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XRmEeL3C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XRmEeL3C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h87+TiSp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECAD51B
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706326896; cv=none; b=Q3etihIdoUmUk9VBe9ppgcQL6p241Vc72+9nwuXyAHLWvPmG4DPTQ6H5wEMGt4lzPMuh/HGlA6cVfJlcUXoGKCkCoItz3dHYl9PVsnGnX0bH+3tpIZUBYtMrLLnQYd4lEmD5VnCTc/etHP5ap56xSqLauZK5BYBSj88Sr02cc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706326896; c=relaxed/simple;
	bh=p5EWnvDGlUaCczMX0khFMadlQ70B1XfCWVBh7DBgWEc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=ExdH7b+UDzQ52aYLEh8oyYaWScqfS5+FGEcdxzCH+zmMxXXthjwU9LDJlg5kpArtQQIdT+2verZmXJ626/9fEOIa6i5yGYP3vJtydvRkGM1NccgOq2M9JYDeQrvDZ2u5ANqBQ3Rm+xs3wZLx/cCkiXvBwLkOT8/QlKseOJ7Nq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XRmEeL3C; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XRmEeL3C; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h87+TiSp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E5660C18DB98
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 19:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706326887; bh=p5EWnvDGlUaCczMX0khFMadlQ70B1XfCWVBh7DBgWEc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XRmEeL3CVxUQNXtNd1IFgBXGE8iacsO0r9AJkC20uDEHhuRpxx3EdG0Y0sdjg1o9l
	 RmAvJ0pzDraQzDUanS95rFXQaQX42uh/f+Sz02fC2bPEXGj0mxsm+WMYitQGzxw5AJ
	 rIF9+LWhRohxlygHBkI9spyPEi6u+AVoJxYQ8ARQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jan 26 19:41:27 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BA726C18DB86;
	Fri, 26 Jan 2024 19:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706326887; bh=p5EWnvDGlUaCczMX0khFMadlQ70B1XfCWVBh7DBgWEc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XRmEeL3CVxUQNXtNd1IFgBXGE8iacsO0r9AJkC20uDEHhuRpxx3EdG0Y0sdjg1o9l
	 RmAvJ0pzDraQzDUanS95rFXQaQX42uh/f+Sz02fC2bPEXGj0mxsm+WMYitQGzxw5AJ
	 rIF9+LWhRohxlygHBkI9spyPEi6u+AVoJxYQ8ARQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0773AC18DB86
 for <bpf@ietfa.amsl.com>; Fri, 26 Jan 2024 19:41:26 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxY3CLPwmn1L for <bpf@ietfa.amsl.com>;
 Fri, 26 Jan 2024 19:41:21 -0800 (PST)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C737EC14CE39
 for <bpf@ietf.org>; Fri, 26 Jan 2024 19:41:21 -0800 (PST)
Message-ID: <79b0ad25-47a8-4e72-adaf-318d73481c86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1706326879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7yIJrWPa8fV+oXvtJyJ/tHuTm0P+aqiTg5OYucnfmo=;
 b=h87+TiSpwnOcHDHMfCXE9dIiwOossMezDaDQoqgH7VmoJbc9upRWZrJsQI8ignYkBewQRF
 CkX26L0jWfYiBQmY//ZvCa+syq367L/fJCqFQdJTHJD9WNMnnRrOX9Fk/s9/xq/agN6KC0
 by6V6hkFevo4DUEYDQGPAwkFBnxf6kQ=
Date: Fri, 26 Jan 2024 19:41:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
 <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
 <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
 <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
 <294f01da50a6$ce3d0670$6ab71350$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <294f01da50a6$ce3d0670$6ab71350$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JixGnHEotgo1Arql9FLXruIlqiY>
Subject: Re: [Bpf] 64-bit immediate instructions clarification
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


On 1/26/24 2:27 PM, dthaler1968@googlemail.com wrote:
> Yonghong Song <yonghong.song@linux.dev> wrote:
>> On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
>>> The spec defines:
>>>> As discussed below in `64-bit immediate instructions`_, a 64-bit
>>>> immediate instruction uses a 64-bit immediate value that is constructed as
>> follows.
>>>> The 64 bits following the basic instruction contain a pseudo
>>>> instruction using the same format but with opcode, dst_reg, src_reg,
>>>> and offset all set to zero, and imm containing the high 32 bits of the
>> immediate value.
>>> [...]
>>>> imm64 = (next_imm << 32) | imm
>>> The 64-bit immediate instructions section then says:
>>>> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide
>>>> instruction encoding defined in `Instruction encoding`_, and use the
>>>> 'src' field of the basic instruction to hold an opcode subtype.
>>> Some instructions then nicely state how to use the full 64 bit
>>> immediate value, such as
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64
>> integer      integer
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm))
>> + next_imm   map fd       data pointer
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm))
>> + next_imm  map index    data pointer
>>> Others don't:
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)
>> map fd       map
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)
>> variable id  data pointer
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)
>> integer      code pointer
>>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)
>> map index    map
>>> How is next_imm used in those four?  Must it be 0?  Or can it be anything and
>> it's ignored?
>>> Or is it used for something?
>> The other four must have next_imm to be 0. No use of next_imm in thee four
>> insns kindly implies this.
>> See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).
> Thanks for confirming.  The "Instruction encoding" section has misleading text
> in my opinion.
>
> It nicely says:
>> Note that most instructions do not use all of the fields. Unused fields shall be cleared to zero.
> But then goes on to say:
>> As discussed below in 64-bit immediate instructions (Section 4.4), a 64-bit immediate instruction
>> uses a 64-bit immediate value that is constructed as follows.
> [...]
>> imm64 = (next_imm << 32) | imm
> Under a normal English reading, that could imply that all 64-bit immediate instructions use imm64,
> which is not the case.  The whole imm64 discussion there only applies today to src=0 (though I
> suppose it could be used by future 64-bit immediate instructions).   Minimally I think
> "a 64-bit immediate instruction uses" should be "some 64-bit immediate instructions use"
> but at present there's only one.
>
> It would actually be simpler to remove the imm64 text and just have the
> definition of src 0x0 change from: "dst = imm64" to "dst = (next_imm << 32) | imm".
>
> What do you think?

it does sound better. Something like below?

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index af43227b6ee4..fceacca46299 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -166,7 +166,7 @@ Note that most instructions do not use all of the fields.
  Unused fields shall be cleared to zero.
  
  As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
-instruction uses a 64-bit immediate value that is constructed as follows.
+instruction uses two 32-bit immediate values that are constructed as follows.
  The 64 bits following the basic instruction contain a pseudo instruction
  using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
  and imm containing the high 32 bits of the immediate value.
@@ -181,13 +181,8 @@ This is depicted in the following figure::
                                     '--------------'
                                    pseudo instruction
  
-Thus the 64-bit immediate value is constructed as follows:
-
-  imm64 = (next_imm << 32) | imm
-
-where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.  The unused bytes in the pseudo
-instruction are reserved and shall be cleared to zero.
+Here, the imm value of the pseudo instruction is called 'next_imm'. The unused
+bytes in the pseudo instruction are reserved and shall be cleared to zero.
  
  Instruction classes
  -------------------
@@ -590,7 +585,7 @@ defined further below:
  =========================  ======  ===  =========================================  ===========  ==============
  opcode construction        opcode  src  pseudocode                                 imm type     dst type
  =========================  ======  ===  =========================================  ===========  ==============
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = (next_imm << 32) | imm               integer      integer
  BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
  BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
  BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer

>
> Dave
>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

